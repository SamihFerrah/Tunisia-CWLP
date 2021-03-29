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
						securite_5 securite_6 c3_a_1 c3_a_2 c3_a_3 c3_a_4 c3_a_5 c3_a_6 c3_a_7 							///
						c3_a_8 c3_a_9 c3_a_10 c3_a_11 c4 c5 c6 c7 c8 c9 c11 c12 c13 c14 c15 c16 c18 					///
						q2_1_2 q2_1_3 q2_1_4 q2_1_5 q2_1_6 q2_1_7 q2_1_8 q2_1_9 q2_1_10									///
						q2_1_11 q2_1_12 q2_1_13 q2_1_14 q2_1_15 q2_1_16 q2_1_17 q2_1_18 q2_1_19 						///
						q2_1_20 q2_1_21 q2_1_22 epargne_dette_cb epargne epargne_cb enfant_moins5 enfant_1317 			///
						enfant_primaire toit mur sol proprietaire_terre distance_eau distance_marche					/// 
						distance_transpublic distance_ecoleprim distance_ecolesec distance_dispensaire 					///
						distance_cheflieu repondant_sex repondant_mat repondant_rel
						
			
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

gen 	moved_imada = 0 
replace moved_imada = 1 if imada != imada_endline

label var moved_imada "Moved Imada"

* Cleaning baseline
* --------------------

	* Prepare conso
	foreach var in 	c3_a_1_b c3_a_2_b c3_a_3_b c3_a_4_b c3_a_5_b c3_a_6_b c3_a_7_b c3_a_8_b c3_a_9_b c3_a_10_b c3_a_11_b  {
			replace `var'=`var'/7
			}
	foreach var in 	c4_b c5_b c6_b c7_b c8_b c9_b  {
			replace `var' = `var'/30
			}
	foreach var in 	c11_b c12_b c13_b c14_b c15_b c16_b c18_b {
			replace `var' = `var'/365
			}		
	egen conso_food_b = rowtotal(c3_a_1_b c3_a_2_b c3_a_3_b c3_a_4_b c3_a_5_b c3_a_6_b c3_a_7_b c3_a_8_b c3_a_9_b c3_a_10_b c3_a_11_b)
	gen conso_food_pc_b = conso_food_b/hhsize_b
	egen conso_nofood_b = rowtotal(c4_b c5_b c6_b c7_b c8_b c9_b c11_b c12_b c13_b c14_b c15_b c16_b c18_b)
	gen conso_nofood_pc_b = conso_nofood_b/hhsize_b
	egen conso_tot_b = rowtotal(conso_food_b conso_nofood_b)
	egen conso_tot_pc_b = rowtotal(conso_food_pc_b conso_nofood_pc_b)
	

	** Winsorization
	foreach var in		distance_eau_b distance_marche_b distance_transpublic_b distance_ecoleprim_b distance_ecolesec_b distance_dispensaire_b distance_cheflieu_b ///
						conso_food_b conso_food_pc_b conso_nofood_b conso_nofood_pc_b conso_tot_b conso_tot_pc_b {	
						tab `var'
						count if `var' > 0
						local n = (`r(N)'*10)/100 // 10% of positive values
						di `n'
						local n_rounded = round(`n',1) // round
						di `n_rounded'
						winsor `var' , gen(w_`var') h(`n_rounded')
						tab w_`var'
						drop `var'
						rename w_`var' `var'
						}
						
	** Positive values
	foreach var in		distance_eau_b distance_marche_b distance_transpublic_b distance_ecoleprim_b distance_ecolesec_b distance_dispensaire_b {
						replace `var' = `var'*(-1)
						}
	
	** Prepare respondent var
	gen relation_head_b = 1 if repondant_rel_b == 1
	gen relation_spouse_b = 1 if repondant_rel_b == 2
	gen relation_daughter_b = 1 if repondant_rel_b == 3
	gen relation_other_b = 1 if repondant_rel_b != 1 & repondant_rel_b != 2 & repondant_rel_b != 3
	foreach var in relation_head_b relation_spouse_b relation_daughter_b relation_other_b {
	replace `var' = 0 if `var' == .
	}
	gen woman_b = 1 if repondant_sex == 0
	replace woman_b = 0 if woman_b == .
	gen secondary_b = 1 if repondant_educ_b == 4 | repondant_educ_b == 5 | repondant_educ_b == 6
	replace secondary_b = 0 if secondary_b == .
	gen married_b = 1 if repondant_mat_b == 1
	replace married_b = 0 if married_b == .

	** Prepare demo var 
	egen children_b = rowtotal(enfant_moins5 enfant_1317 enfant_primaire)
	egen adults_b = rowtotal(h_18_65_b f_18_65_b)
	gen elderly_b = hhsize_b-(adults_b+children_b)
	
	** Household var
	gen dirtfloor_b = 1 if sol == 1
	replace dirtfloor_b = 0 if dirtfloor_b == .
	gen thatched_still_b = 1 if toit == 1 | toit == 2 | toit == 3 | toit == 4
	replace thatched_still_b = 0 if thatched_still_b == .
	egen livestock_b = rowtotal(q2_1_18_win_b q2_1_19_win_b q2_1_20_win_b q2_1_21_win_b q2_1_22_win_b)
	replace livestock_b = 1 if livestock_b > 0

	