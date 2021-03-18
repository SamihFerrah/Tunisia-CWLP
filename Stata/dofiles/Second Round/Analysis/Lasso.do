****************************************************************************
****************************************************************************
*							LASSO SELECTION 
****************************************************************************
****************************************************************************
clear 

/* 

First using asset, depression and anxiety index for training purpose. We try to select
two types of covariates to control for:
	- Individual outcomes used in TCLP endline report
	- Index used in TCLP endline report
	


Results:

	- Comparison CV, Adaptive and plugin method
	
		--> CV and adaptive method seems to work the best as they minimise the MSE 
		
	- Index perfomed poorly, although some have been selected (assets, woman bargain)
	
		--> z_assets_total: Asset index selected only (although pretty high MSE)
		--> z_assets_d: Assets, range of social netweork, positive coiping mechanism, woman bargain index selected  (CV and adtaptive method lead to same results) only assets for the plugin method
		--> z_assets19_d: Assets (CV and adaptive) and negative coping mechanism (only CV)
		--> Other outcomes: No selected
		
	- Individual outcomes used in TCLP endline
		

*/

* Define global 

global all 		c1_job_iga c1_job_iga_1 c1_job_iga_2 c1_job_iga_3 c1_job_covid business_profit 												///
				business_employee c3_haveskills c1_wageprimjob total_employement c2_borrow_all c2_borrow12 									///
				c2_borrow12n c2_repaiddebt c2_eliipsav c2_eliipsavn c2_depositac c2_depositacn c2_loan										///
				x9_1 x9_2 x9_3 x9_4 x9_5 x9_6 x9_7 x9_largepurchase x9_dailypurchase x9_wifepersonal 										///
				x9_borrow x9_lend x9_occupation x9_workplace x9_workhours x9_participation 													///
				c1_headjob c1_headjobiga_1 c1_headjobiga_2 c1_headjobiga_3 c1_headjobiga_4 c1_headincome30 									///
				c1_othermemberswork c1_othermembersworkn c1_incomeotheriga 																	///
				c1_hengag c1_hengag_agr c1_rentlabor c1_rentlabor_num c1_fertilizer c1_pesticides 											///
				productiona c1_cropprodna c1_cropvalna c1_cropconsna c1_cropdonna c1_cropsoldna c1_cropstoredna 							///
				b3_a_1 b3_a_2 b3_a_3 b3_a_4 b3_a_5 b3_a_6 b3_a_7 b3_a_8 b3_a_9 b3_a_10 b3_a_11 												///
				b3_fooddrink_num b3_medical_num b3_leisure_num b3_clothes_num b3_publictransport_num 										///
				b3_elec_gas_water_num b3_landline_phone_num b3_soap_num b3_otherservice_num 												///
				b3_medicalexpnum b3_chool_expnum conso_tot conso_tot_w conso_tot_pc conso_tot_pc_w 											///
				conso_food conso_food_pc conso_food_w conso_nofood conso_nofood_pc conso_nofood_w conso_food_pc_w conso_nofood_pc_w 		///
				b2_assetnum_sheep b2_assetnum19_sheep b2_assetnum_duck b2_assetnum19_duck b2_numasset_cows 									///
				b2_assetnum19_cows b2_assetnum_mule b2_assetnum19_mule b2_assetnum_room b2_assetnum19_room 									///
				b2_assetnum19_vent  b2_assetnum_mattresses b2_assetnum19_mattresses b2_assetnum_radio 										///
				b2_assetnum19_radio b2_assetnum_cellphone b2_assetnum19_cellphone b2_assetnum_smartphone 									///
				b2_assetnum19_smartphone b2_assetnum_refrigerator b2_assetnum19_refrigerator b2_assetnum_bicycles 							///
				b2_assetnum19_bicycles b2_assetnum_moto b2_assetnum19_moto b2_assetnum_chaise b2_assetnum19_chaise 							///
				b2_assetnum_tablette b2_assetnum19_tablette b2_assetnum_vent b2_assetnum_clim b2_assetnum19_clim 							///
				b2_assetnum_gr b2_assetnum19_gr b2_assetnum_nat b2_assetnum19_nat b2_assetnum_poch b2_assetnum19_poch 						///
				b2_assetnum_table b2_assetnum19_table b2_assetnum_salon b2_assetnum19_salon b2_assetnum_bibli 								///
				b2_assetnum19_bibli b2_assetnum_arm b2_assetnum19_arm b2_assetnum_ferer b2_assetnum19_ferer	 								///
				b2_assetnum_mach b2_assetnum19_mach b2_assetnum_dec b2_assetnum19_dec  														///
				d_b2_assetnum_sheep d_b2_assetnum19_sheep d_b2_assetnum_duck d_b2_assetnum19_duck d_b2_numasset_cows  d_b2_assetnum19_cows 	///
				d_b2_assetnum_mule d_b2_assetnum19_mule d_b2_assetnum_room d_b2_assetnum19_room d_b2_assetnum_mattresses 					///
				d_b2_assetnum19_mattresses d_b2_assetnum_radio d_b2_assetnum19_radio d_b2_assetnum_cellphone 								///
				d_b2_assetnum19_cellphone d_b2_assetnum_smartphone d_b2_assetnum19_smartphone d_b2_assetnum_refrigerator 					///
				d_b2_assetnum19_refrigerator d_b2_assetnum_bicycles d_b2_assetnum19_bicycles d_b2_assetnum_moto 							///
				d_b2_assetnum19_moto d_b2_assetnum_chaise d_b2_assetnum19_chaise d_b2_assetnum_tablette d_b2_assetnum19_tablette 			///
				d_b2_assetnum_vent d_b2_assetnum_clim d_b2_assetnum19_clim d_b2_assetnum_gr d_b2_assetnum19_gr d_b2_assetnum_nat 			///
				d_b2_assetnum19_nat d_b2_assetnum_poch d_b2_assetnum19_poch d_b2_assetnum_table d_b2_assetnum19_table 						///
				d_b2_assetnum_salon d_b2_assetnum19_salon d_b2_assetnum_bibli d_b2_assetnum19_bibli d_b2_assetnum_arm  						///
				d_b2_assetnum19_arm d_b2_assetnum_ferer d_b2_assetnum19_ferer d_b2_assetnum_mach d_b2_assetnum19_mach 						///
				d_b2_assetnum_dec d_b2_assetnum19_dec 																						///
				b4_sufferevent_1 b4_sufferevent_2 b4_sufferevent_3 b4_sufferevent_4 b4_sufferevent_5 b4_sufferevent_6						///
				b4_sufferevent_7 b4_sufferevent_8 b4_sufferevent_9 																			///
				b4_sufferevent_99 b4_facesufferevent_1 b4_facesufferevent_2 b4_facesufferevent_3 b4_facesufferevent_4 b4_facesufferevent_5	/// 
				b4_facesufferevent_6 																										///
				b4_facesufferevent_7 b4_facesufferevent_8 b4_facesufferevent_9 b4_facesufferevent_10 b4_facesufferevent_11 					///
				b4_facesufferevent_12 b4_facesufferevent_13 																				///
				b4_facesufferevent_14 b4_facesufferevent_15 b4_facesufferevent_0 b4_facesufferevent_99 										///
				c4_hhmig c4_hhmignum c4_hhmigreason_1 c4_hhmigreason_2 c4_hhmigreason_3 c4_hhmigreason_4 c4_hhmigreason_5 					///
				c4_hhmigreason_6 c4_hhmigreason_99 																							///
				c4_respondtravel c4_traveldays c4_travelreason_1 c4_travelreason_2 c4_travelreason_3 c4_travelreason_4 c4_travelreason_5 	///
				c4_travelreason_6 c4_travelreason_99 																						///
				c4_respfututra c4_respfututrareason_1 c4_respfututrareason_2 c4_respfututrareason_3 c4_respfututrareason_4 					///
				c4_respfututrareason_5 c4_respfututrareason_6 c4_respfututrareason_99 														///
				c4_hhfututra  c4_hhfututrareason_1 c4_hhfututrareason_2 c4_hhfututrareason_3 c4_hhfututrareason_4 c4_hhfututrareason_5 		///
				c4_hhfututrareason_6 c4_hhfututrareason_99  																				///
				d1_ladder_present d1_ladder_1ago d1_ladder3years d1_ladderwealth 															///
				d3_shortnessbreath d3_fearlosingcontrol  d3_worryest d3_feelingsfear d3_frighten 											///
				d3_feeldeceiving d3_solitaryactivities d3_uncomfortabl d3_unwilling 														///
				d3_lifethreatening d3_distressing d3_avoidthinking d3_remembering d3_lostinterest d3_feeldetached 							///
				d3_oftenirritable d3_makedecisions d3_sleepeatinghabit d3_depressed d3_wrongmatter 											///
				d3_alcoholdrugs d3_feltangry d3_troubllistening d3_wrongblame d3_recognition 												///
				d3_believethink d3_frustrated d3_enoughsleep d3_lotofthings d3_nightmares 													///	
				d3_solveproblems d3_dependsmainly d3_feel_helpless d3_influence_many d3_taking_control 										///
				d3_exploitedcheated d3_have_control d3_trust_worthy d3_achieveanything d3_beingaccepted
				
global all_individual	emploi_main days_work_main_win hours_work_main_win inc_work_main_win							///
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
						g2_3 g2_4 g2_5 g2_6  g2_8 g2_9 g2_10 g2_11 g2_12 												///
						g2_1 g2_2 g2_7 g2_13 g2_14 g2_15																///
						g1_1 g1_2 g1_3 g1_4 g1_5 g1_6 g1_7 g1_8 g1_9													///
						association_1 association_2 association_9														///
						association_3 association_4 association_6 /*association_7 association_8*/  						///
						initiatives_1 initiatives_2 initiatives_3 initiatives_4 initiatives_5 initiatives_6 			///
						initiatives_7 initiatives_8  initiatives_9 initiatives_10 initiatives_11 						///
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

global baseline_ind		B_f_lab_market_main /*lab_market_sec*/ B_f_eco_welfare 											///
						B_f_assets B_f_credit_access B_f_pos_coping_mechanisms B_f_neg_coping_mechanisms				///
						B_f_shocks B_f_social B_f_civic B_f_well_being B_f_woman_bargain B_f_woman_violence 	

*******************************************************************************
*******************************************************************************

u "$vera/clean/clean_analysis_CashXFollow.dta", clear


* Keep intervention 

keep if Intervention == "Cash Grants - Women" & tot_complete == 1 & attrition == 0 



* Store baseline variable in local 

global all_baseline ""

foreach var in emploi_main days_work_main_win hours_work_main_win inc_work_main_win							///
						profit_work_main_win business_q0_main business_q3_main_win business_q5_main_win					///
						emploi_sec days_work_sec hours_work_sec inc_work_sec {

	*global all_baseline "$all_baseline `var'_b m_`var'"
	global all_baseline "$all_baseline `var'_b"
	
	*g 		m_`var' = 0 
*	replace m_`var' = 1 if `var'_b ==. 
	*replace `var'_b = 0 if `var'_b ==.

}


codebook $all_baseline

fdf
* Foreach outcomes variables 

********************************************************************************
********************************************************************************
* 1. Lasso procedure to choose baseline measure to control for.
********************************************************************************
********************************************************************************

* Correlation between baseline and endline outcomes 

foreach baseline in $baseline_ind{

	foreach endline in z_anxiety_index z_depression_index z_assets_total z_assets19_total z_assets_d z_assets19_d{

		reg `endline' `baseline', robust 
		
	}

}


* Lasso selection 

splitsample, generate(samplelasso) split (.72 .25) rseed(12345)

	
global sel			""

foreach var in z_anxiety_index z_depression_index z_assets_total z_assets19_total z_assets_d z_assets19_d{

	di as text "****************************************************************"
	di as text "****************************************************************"
	di in red  "OUTCOME: `var'"
	di as text "****************************************************************"
	di as text "****************************************************************"
			
	global sel_`var' 	""
	
	* Lasso procedure
	*cap noi dsregress z_anxiety_index z_depression_index z_assets_total z_assets19_total z_assets_d z_assets19_d, controls(i.(strata_cash) $baseline_ind) missingok vce(robust) selection(cv)
		
	lasso linear `var' $all_baseline if samplelasso == 1, nolog rseed(12345) selection(cv)
	
	estimates store cv 
		
	lassoknots 
		
	lasso linear `var' $all_baseline if samplelasso == 1, nolog rseed(12345) selection(adaptive)
	
	estimates store adapt 
		
	lassoknots 
		
	lasso linear `var' $all_baseline if samplelasso == 1, nolog rseed(12345) selection(plugin)
	
	estimates store plugin 
		
	lassoknots 
		
	lassogof cv adapt plugin if sample==2
	
	lassogof cv adapt plugin if sample==2, postselection
	
	pause
	*elasticnet linear `var' `all_baseline', rseed(1234) alpha(0)
	
	
	* Display results from lasso procedure
	di as text "****************************************************************"
	di as text "****************************************************************"
	di in red  "OUTCOME: `var'"
	di as text "****************************************************************"
	di as text "****************************************************************"
	di in red  "LASSO SELECTION: `e(controls_sel)'"
	di as text "****************************************************************"
	di as text "****************************************************************"
	di in red  "Potential LASSO SELECTION: `e(controls)'"
	di as text "****************************************************************"
	di as text "****************************************************************"
	
	*Store variables to control for
	global sel_`var' 	"$sel_`var' `e(controls_sel)'"
	global sel 			"$sel `e(controls_sel)'"
	
}
sdsdsd

* Trim global with all control saved to remove strata variables 

global sel

