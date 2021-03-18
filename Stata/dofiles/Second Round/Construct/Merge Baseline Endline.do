********************************************************************************
********************************************************************************
*						MERGE BASELINE AND ENDLINE TUNISIA IE
********************************************************************************
********************************************************************************

* Define variable to keep from baseline 

local balance_indiv 	repondant_age repondant_educ							///
						hhsize adult_num jeunes_lireecrire emploi_2013_a		///
						formation origine_naissance origine_naissance_bis h_18_65 f_18_65	trauma_abus 	
						
local balance_coll		q0_1_c q0_2_c q0_3_c 											///
						negevent_1 negevent_2 negevent_3 negevent_4 					///
						negevent_5 negevent_6 negevent_7      							///
						negevent_8 negevent_9 posevent_1 posevent_2 posevent_3      	///
						posevent_4 posevent_5 posevent_6 posevent_7 posevent_8 prev_PWP ///
						pop_2004_admin pop_2014_admin pop_change_admin
						
local all_individual	emploi_main days_work_main_win hours_work_main_win inc_work_main_win							///
						profit_work_main_win business_q0_main business_q3_main_win business_q5_main_win					///
						emploi_sec days_work_sec hours_work_sec inc_work_sec 											///
						profit_work_sec business_q0_sec business_q3_sec business_q5_sec									///
						c3_a_1_win c3_a_2_win c3_a_3_win c3_a_4_win c3_a_5_win c3_a_6_win c3_a_7_win 					///
						c3_a_8_win c3_a_9_win c3_a_10_win c3_a_11_win c4_win c5_win c6_win 								///
						c7_win c8_win c9_win c11_win c12_win c13_win c14_win c15_win c16_win c18_win 					///
						q2_1_2_win q2_1_3_win q2_1_4_win q2_1_5_win q2_1_6_win q2_1_7_win q2_1_8_win 					///
						q2_1_9_win q2_1_10_win q2_1_11_win q2_1_12_win q2_1_13_win q2_1_14_win 							///
						q2_1_15_win q2_1_16_win q2_1_17_win q2_1_18_win q2_1_19_win 									///
						q2_1_20_win q2_1_21_win q2_1_22_win 															///
						epargne_dette epargne_dette_cb_win epargne epargne_cb_win epargne_pret							///				
						g2_3 g2_4 g2_5 g2_6  g2_8 g2_9 g2_10 g2_11 g2_12 													///
						g2_1 g2_2 g2_7 g2_13 g2_14 g2_15																///
						g1_1 g1_2 g1_3 g1_4 g1_5 g1_6 g1_7 g1_8 g1_9													///
						association_1 association_2 association_9														///
						association_3 association_4 association_6 /*association_7 association_8*/  						///
						initiatives_1 initiatives_2 initiatives_3 initiatives_4 initiatives_5 initiatives_6 			///
						initiatives_7 initiatives_8  initiatives_9 initiatives_10 initiatives_11 										///
						initiatives_12 initiatives_13 initiatives_14 initiatives_15 initiative_dummy					///		
						psy_anxiete psy_exploit psy_depress5 /*psy_accepte_dum1*/ psy_accepte_dum3 						///
						psy_menage_dum3 /*psy_a_menage_dum1*/ psy_a_menage_dum3	 										///
						psycho_depress4 psycho_depress3 psycho_depress2 psycho_depress1									///
						intrahh_1 intrahh_2 intrahh_7 intrahh_11 emploiw 												///
						violence_1_2 violence_1_3 violence_1_4 violence_1_5 violence_1_6 								///
						violence_1_7 violence_1_8 violence_1_9 violence_1_10 violence_1_11 								///
						violence_1_16 violence_1_17 violence_1_18  														///
						source_info_internal source_info2_internal  													///
						utopie_a_dum1  utopie_a_dum3 utopie_b_dum1  utopie_b_dum3										///
						isolement_1 isolement_2 isolement_3 isolement_4 isolation_dummy									///
						association_dummy comite_c comite_c_menage conflit_dispute_in conflit_dispute_out 				///
						migration_cm_q1 migration_q1 security_dummy														///
						association_7 association_8 securite_1 securite_2 securite_3 securite_4							///
						securite_5 securite_6
			
global all_outcomes ""

foreach var in `all_individual'{
	
	global all_outcomes "$all_outcomes `var'" 

}

********************************************************************************
********************************************************************************
						
* Use clean data 
u "$vera/temp/clean_CashXFollow_PII_2.dta", clear

* Merge with rand info for completing Nom Imada Age values 

cap drop _merge
cap drop imada
cap drop Nom 
cap drop Age 
cap drop Imada
cap drop imada_str

g Identified = 0 

merge m:1 HHID using "A:/Assignment/Full Sample.dta", keepusing(Nom Imada Age)

rename Imada imada_str

replace imada_str = upper(imada_str)
replace imada_str = subinstr(imada_str," ","",.)

replace Nom = upper(Nom)
replace Nom = subinstr(Nom," ","",.)

* Get information from TCLP endline (2016)

preserve 

	u "$stata_base/enquete_All3.dta", clear

	g Age = repondant_age
	
	generate str116 Nom = repondant_name
	
	replace Nom = upper(Nom)
	replace Nom = subinstr(Nom," ","",.)

	format Nom %116s
		
	keep `balance_coll' `balance_indiv' $all_outcomes B_f_* programs Nom Imada Age imada
	
	rename * *_b 
	
	rename (Nom_b Imada_b Age_b imada_b programs_b) (Nom Imada Age imada TCLP_trt)
	
	decode imada, g(imada_str)
	
	replace imada_str = upper(imada_str)
	replace imada_str = subinstr(imada_str," ","",.)
	
	*drop if Nom == "AWATEFAMRI"
	*drop if Nom == "FATHIAABIDI"
	
	tempfile baseline 
	sa      `baseline'

restore 

/* We need to do two merge iteration:
	- 1) Using imada numeric value
	- 2) Using imada string value (for _merge 1)
*/

cap drop _merge

* Merge with info from baseline
merge m:1 Nom Age imada_str using `baseline'

drop if _merge == 2

* Generate Strata variable 

egen strata_cash = group(TCLP_trt imada) if Intervention == "Cash Grants - Women"
