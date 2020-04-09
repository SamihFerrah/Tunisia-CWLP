********************************************************************************
*				REPLICATION INDEX TUNISIA CWLP 								   *
********************************************************************************
********************************************************************************

********************************************************************************
********************************************************************************
* 0) DEFINE LOCAL USED TO BUILD INDEX 
********************************************************************************
********************************************************************************


local lab_market_main 	 		emploi_main days_work_main_win hours_work_main_win inc_work_main_win									///
								profit_work_main_win business_q0_main business_q3_main_win business_q5_main_win

														
local eco_welfare 				c3_a_1_win c3_a_2_win c3_a_3_win c3_a_4_win c3_a_5_win c3_a_6_win c3_a_7_win 					///
								c3_a_8_win c3_a_9_win c3_a_10_win c3_a_11_win c4_win c5_win c6_win 								///
								c7_win c8_win c9_win c11_win c12_win c13_win c14_win c16_win c18_win 

local consumption_food 			c3_a_1_win c3_a_2_win c3_a_3_win c3_a_4_win c3_a_5_win c3_a_6_win c3_a_7_win 						///
								c3_a_8_win c3_a_9_win c3_a_10_win c3_a_11_win 

local consumption_other 		c4_win c5_win c6_win c7_win c8_win c9_win c11_win c12_win c13_win c14_win 					///
								c15_win c16_win c18_win 

							
local assets					q2_1_2_win q2_1_3_win q2_1_4_win q2_1_5_win q2_1_6_win q2_1_7_win q2_1_8_win 					///
								q2_1_9_win q2_1_10_win q2_1_11_win q2_1_12_win q2_1_13_win q2_1_14_win 							///
								q2_1_15_win q2_1_16_win q2_1_17_win q2_1_18_win q2_1_19_win 										///
								q2_1_20_win q2_1_21_win q2_1_22_win 

local large_assets				q2_1_2_win q2_1_3_win q2_1_4_win q2_1_5_win q2_1_6_win q2_1_9_win q2_1_10_win					///
								q2_1_12_win q2_1_13_win q2_1_17_win q2_1_20_win q2_1_21_win q2_1_22q2_1_22_winbis 
						  
local small_assets				q2_1_7_win q2_1_8_win q2_1_11_win q2_1_14_win q2_1_15_win q2_1_16_win q2_1_18_win 				///
								q2_1_19_win  

local home_assets				q2_1_2_win q2_1_3_win q2_1_4_win q2_1_15_win q2_1_6_win q2_1_7_win q2_1_8_win  	
	
local comms_assets				q2_1_12_win q2_1_13_win q2_1_14_win q2_1_15_win q2_1_16_win  

local productive_assets			q2_1_9_win q2_1_10_win q2_1_11_win q2_1_17_win q2_1_18_win q2_1_19_win 							///
								q2_1_20_win q2_1_21_win 						
								
								
local credit_access				epargne_dette epargne_dette_cb_win epargne epargne_cb_win epargne_pret											


local pos_coping_mechanisms		g2_3 g2_4 g2_5 g2_6  g2_8 g2_9 g2_10 g2_11 g2_12 

local neg_coping_mechanisms		g2_1 g2_2 g2_7 g2_13 g2_14 g2_15	


local shocks					g1_1 g1_2 g1_3 g1_4 g1_5 g1_6 g1_7 g1_8 g1_9


local social				association_1 association_2 initiatives_9 association_9											///
							association_3 association_4 association_6 /*association_7 association_8*/  
							
							
local civic					initiatives_1 initiatives_2 initiatives_3 initiatives_4 initiatives_5 initiatives_6 			///
							initiatives_7 initiatives_8  initiatives_10 initiatives_11 										///
							initiatives_12 initiatives_13 initiatives_14 initiatives_15									

							

local well_being 			psy_anxiete psy_exploit psy_depress5 /*psy_accepte_dum1*/ psy_accepte_dum3 						///
							psy_menage_dum3 /*psy_a_menage_dum1*/ psy_a_menage_dum3	 										///
							psycho_depress4 psycho_depress3 psycho_depress2 psycho_depress1


local woman_violence		violence_1_2 violence_1_3 violence_1_4 violence_1_5 violence_1_6 								///
							violence_1_7 violence_1_8 violence_1_9 violence_1_10 violence_1_11 								///
							violence_1_16 violence_1_17 violence_1_18  	
							

local woman_bargain 		intrahh_1 intrahh_2 intrahh_7 intrahh_11 emploiw /*association_2*/


local woman_empowerment		intrahh_1 intrahh_2 intrahh_7 intrahh_11 emploiw 												///
							violence_1_2 violence_1_3 violence_1_4 violence_1_5 violence_1_6 								///
							violence_1_7 violence_1_8 violence_1_9 violence_1_10 violence_1_11 								///
							violence_1_16 violence_1_17 violence_1_18  	


local Index_ALL 			lab_market_main /*lab_market_sec*/ eco_welfare consumption_food consumption_other				///
							assets home_assets comms_assets productive_assets 												///
							credit_access pos_coping_mechanisms neg_coping_mechanisms										///
							shocks social civic well_being woman_bargain woman_violence woman_empowerment 					
							 

							
********************************************************************************
********************************************************************************
* 1) Prepare data (flip sign and stuff)
********************************************************************************
********************************************************************************


u "$stata/enquete_all", clear


* Apply special character for missing variables 

foreach var of varlist _all{
capture confirm numeric variable `var'
	if _rc == 0{
	cap replace `var' =.d if `var' == -98
	cap replace `var' =.a if `var' == -98
	cap replace `var' =.n if `var' == -99
	}

}


foreach var of varlist 		c3_a_1_win c3_a_2_win c3_a_3_win c3_a_4_win c3_a_5_win c3_a_6_win c3_a_7_win  		///
							c3_a_8_win c3_a_9_win c3_a_10_win c3_a_11_win  c4_win c5_win c6_win 		/// 
							c7_win c8_win c9_win c11_win c12_win c13_win c14_win c15_win c16_win c18_win {
	gen l`var' = log(`var'+1)

}


*Account for repetition of variables in different categories; will delete at end of code

foreach var of varlist	c3_a_1_win6 c3_a_2_win6 c3_a_3_win c3_a_4_win c3_a_5_win c3_a_6_win c3_a_7_win 	///
						c3_a_8_win c3_a_9_win c3_a_10_win c3_a_11_win  c4_win c5_win c6_win ///
						c7_win c8_win c9_win c11_win c12_win c13_win c14_win c15_win c16_win c18_win 		///
						g2_1 g2_2 g2_3 g2_4 g2_5 g2_6 g2_7 g2_8 g2_9 g2_10 g2_11 g2_12 g2_13 g2_14 g2_15	///	
						q2_1_2_win q2_1_3 q2_1_4 q2_1_5 q2_1_6 q2_1_7 q2_1_8 q2_1_9 q2_1_10 q2_1_11 		///
						q2_1_12 q2_1_13_win q2_1_14 q2_1_15 q2_1_16_win q2_1_17 q2_1_18_win q2_1_19_win 	///
						q2_1_20 q2_1_21 q2_1_22 q2_1_23_win mur_dummy toit_dummy proprietaire_dum1 titre	///
						proprietaire_terre superficie_m titre_terre f18_dummy formation formation_dum1 		///
						formation_dum2 formation_dum3 formation_dum4 formation_dum5 formation_dum6 			///
						formation_dum7 formation_dum9 formation_dum10 emploi_comp_inut emploi tspent_main 	///
						earned_main_win employedhh earnedhh_win paidjobhh earnedoth paidjoboth sec_empl 	///
						tspent_sec_win earned_sec employs pers_employ hoursperm_employ paid_employ epargne  ///		
						epargne_forme_3 epargne_cb futur_services emp_futur_cb_win							///
						association_dummy comite_c comite_c_menage conflit_dispute_in conflit_dispute_out 	///
						migration_cm_q1 migration_q1 security_dummy association_1 association_2 			///
						association_3 association_4 association_6 association_7 association_8 				///
						association_9 securite_1 securite_2 securite_3 securite_4 							///
						securite_5 securite_6 initiative_dummy utopie_a_dum1 utopie_b_dum1 					///
						source_info_internal source_info2_internal utopie_a_dum3 utopie_b_dum3				///
						isolation_dummy initiatives_1 initiatives_2 initiatives_3 initiatives_4 			///
						initiatives_5 initiatives_6 initiatives_7 initiatives_8 initiatives_9 				///
						initiatives_10 initiatives_11 initiatives_12 initiatives_13 initiatives_14 			///
						initiatives_15 isolement_1 isolement_2 isolement_3 									///
						isolement_4 psy_anxiete psy_exploit psy_depress5 psy_accepte_dum1 psy_accepte_dum3 	///
						psy_menage_dum3 psy_a_menage_dum1 psy_a_menage_dum3 pearlin_1 						///
						pearlin_2 pearlin_3 pearlin_4 pearlin_5 pearlin_6 pearlin_7 violence_physical		///
						violence_emotional intrahh_1 intrahh_2 intrahh_7 intrahh_11 emploiw violence_1_2 	///
						violence_1_3 violence_1_4 violence_1_5 violence_1_6 violence_1_7 violence_1_8 		///
						violence_1_9 violence_1_10 violence_1_11 violence_1_16 violence_1_17 violence_1_18	///
						epargne_dette epargne_dette_cb_win 			{
						
						gen `var'bis = `var'
		}

rename 					source_info2_internal source_info2_intern
		
foreach var of varlist	q2_1_2_win q2_1_3 q2_1_4 q2_1_5 q2_1_6 q2_1_7 q2_1_8 q2_1_12 q2_1_13_win q2_1_14 	///
						q2_1_15 q2_1_16_win q2_1_9 q2_1_10 q2_1_11 q2_1_17 q2_1_18_win q2_1_19_win q2_1_20  ///
						q2_1_21 q2_1_22	intrahh_7 intrahh_11 psy_a_menage_dum3 initiatives_1 initiatives_2  ///
						initiatives_3 initiatives_4 initiatives_5 initiatives_6 initiatives_7 initiatives_8 ///
						utopie_a_dum1 utopie_b_dum1	source_info_internal source_info2_intern comite_c		///
						comite_c_menage	/*source_info_internal*/ {
						
						gen `var'bis2 = `var'
						
		}

rename 					source_info2_intern source_info2_internal
		
		
* Flip variables so that a higher value indicate a better outcome 

local sign 			emploi_comp_inut conflit_dispute_in conflit_dispute_out migration_cm_q1 migration_q1 	///
					security_dummy securite_1 securite_2 securite_3 securite_3bis securite_4 securite_5  	///
					securite_5bis securite_6 securite_6bis	violence_physicalbis violence_emotionalbis  	///
					utopie_a_dum3 utopie_b_dum3 isolation_dummy psy_anxiete psy_exploit 					///
					psy_depress5 psycho_depress4 psycho_depress3 psycho_depress2 psycho_depress1			///
					psy_accepte_dum1 psy_a_menage_dum1 source_info_internal source_info2_internal			///
					source_info_internalbis source_info2_internalbis intrahh_7bis intrahh_11bis				///
					pearlin_2 pearlin_3 intrahh_7 intrahh_11 violence_1_2 violence_1_3 violence_1_4 		///
					violence_1_5 violence_1_6 violence_1_7 violence_1_8 violence_1_9 violence_1_10 			///
					violence_1_11 violence_1_16 violence_1_17 violence_1_18	violence_physical 				///
					violence_emotional  migration_cm_q1bis migration_q1bis pearlin_7 pearlin_7bis 			///
					psy_anxietebis psy_exploitbis psy_depress5bis distance_marche  distance_transpublic		///
					psy_accepte_dum1bis psy_a_menage_dum1bis epargne_dette epargne_dette_cb_win			 	///
					epargne_dettebis epargne_dette_cb_winbis g2_1 g2_2  distance_ecoleprim					///
					g2_13 g2_14 g2_15 intrahh_7bis2 intrahh_11bis2 distance_ecolesec distance_eau			///
					source_info_internalbis2 source_info2_internbis2 distance_dispensaire   				///
					

foreach signvar of local sign  {
gen 	`signvar'I = -	`signvar'
rename 	`signvar'I  	`signvar'_t
rename	`signvar' 		`signvar'I
rename	`signvar'_t	 	`signvar'
}

********************************************************************************
********************************************************************************
* 1) STANDARDIZE EVERY INDIVIDUAL OUTCOMES AGAINST RELEVANT CONTROL GROUP
********************************************************************************
********************************************************************************


foreach specification in between within spillovers full 			///
						 between_w within_w spillovers_w full_w 	///
						 between_m within_m spillovers_m full_m {						// Loop over every specification (control group differ between those)

	
	* Define local specific to specification
	
	if "`specification'" == "between"{
	local prg_condition = "between ==1"
	local trt_indicator = "beneficiaire"
	local spec_prefix 	= "IAaS"
	local Index_ALL 			lab_market_main /*lab_market_sec*/ eco_welfare consumption_food consumption_other				///
							assets home_assets comms_assets productive_assets 												///
							credit_access pos_coping_mechanisms neg_coping_mechanisms										///
							shocks social civic well_being woman_bargain woman_violence woman_empowerment 	
	}
	
	if "`specification'" == "within"{
	local prg_condition = "within ==1"
	local trt_indicator = "program"
	local spec_prefix 	= "IBaS"
	local Index_ALL 			lab_market_main /*lab_market_sec*/ eco_welfare consumption_food consumption_other				///
							assets home_assets comms_assets productive_assets 												///
							credit_access pos_coping_mechanisms neg_coping_mechanisms										///
							shocks social civic well_being woman_bargain woman_violence woman_empowerment 	
	}
	
	if "`specification'" == "spillovers"{
	local prg_condition = "spillovers ==1"
	local trt_indicator = "beneficiaire"
	local spec_prefix 	= "ICbS"
	local Index_ALL 			lab_market_main /*lab_market_sec*/ eco_welfare consumption_food consumption_other				///
							assets home_assets comms_assets productive_assets 												///
							credit_access pos_coping_mechanisms neg_coping_mechanisms										///
							shocks social civic well_being woman_bargain woman_violence woman_empowerment 	
	}
	
	if "`specification'" == "full"{
	local prg_condition = "full ==1"
	local trt_indicator = "trt_full"
	local spec_prefix 	= "ICfS"
	local Index_ALL 			lab_market_main /*lab_market_sec*/ eco_welfare consumption_food consumption_other				///
							assets home_assets comms_assets productive_assets 												///
							credit_access pos_coping_mechanisms neg_coping_mechanisms										///
							shocks social civic well_being woman_bargain woman_violence woman_empowerment 	
	}
	
	**********************************
	**********************************
	
	if "`specification'" == "between_w"{
	local prg_condition = "between ==1 & repondant_sex == 0"
	local trt_indicator = "beneficiaire"
	local spec_prefix 	= "IAaSw"
	local Index_ALL 			lab_market_main /*lab_market_sec*/ eco_welfare consumption_food consumption_other				///
							assets home_assets comms_assets productive_assets 												///
							credit_access pos_coping_mechanisms neg_coping_mechanisms										///
							shocks social civic well_being woman_bargain woman_violence woman_empowerment 	
	}
	
	if "`specification'" == "within_w"{
	local prg_condition = "within ==1 & repondant_sex == 0"
	local trt_indicator = "program"
	local spec_prefix 	= "IBaSw"
	local Index_ALL 			lab_market_main /*lab_market_sec*/ eco_welfare consumption_food consumption_other				///
							assets home_assets comms_assets productive_assets 												///
							credit_access pos_coping_mechanisms neg_coping_mechanisms										///
							shocks social civic well_being woman_bargain woman_violence woman_empowerment 	
	}
	
	if "`specification'" == "spillovers_w"{
	local prg_condition = "spillovers ==1 & repondant_sex == 0"
	local trt_indicator = "beneficiaire"
	local spec_prefix 	= "ICbSw"
	local Index_ALL 			lab_market_main /*lab_market_sec*/ eco_welfare consumption_food consumption_other				///
							assets home_assets comms_assets productive_assets 												///
							credit_access pos_coping_mechanisms neg_coping_mechanisms										///
							shocks social civic well_being woman_bargain woman_violence woman_empowerment 	
	}
	
	if "`specification'" == "full_w"{
	local prg_condition = "full ==1 & repondant_sex == 0"
	local trt_indicator = "trt_full"
	local spec_prefix 	= "ICfSw"
	local Index_ALL 			lab_market_main /*lab_market_sec*/ eco_welfare consumption_food consumption_other				///
							assets home_assets comms_assets productive_assets 												///
							credit_access pos_coping_mechanisms neg_coping_mechanisms										///
							shocks social civic well_being woman_bargain woman_violence woman_empowerment 	
	}
	
	**********************************
	**********************************
	
	if "`specification'" == "between_m"{
	local prg_condition = "between ==1 & repondant_sex == 1"
	local trt_indicator = "beneficiaire"
	local spec_prefix 	= "IAaSm"
	local Index_ALL 		lab_market_main /*lab_market_sec*/ eco_welfare consumption_food consumption_other				///
							assets home_assets comms_assets productive_assets 												///
							credit_access pos_coping_mechanisms neg_coping_mechanisms										///
							shocks social civic well_being 
	}
	
	if "`specification'" == "within_m"{
	local prg_condition = "within ==1 & repondant_sex == 1"
	local trt_indicator = "program"
	local spec_prefix 	= "IBaSm"
	local Index_ALL 		lab_market_main /*lab_market_sec*/ eco_welfare consumption_food consumption_other				///
							assets home_assets comms_assets productive_assets 												///
							credit_access pos_coping_mechanisms neg_coping_mechanisms										///
							shocks social civic well_being 
	}
	
	if "`specification'" == "spillovers_m"{
	local prg_condition = "spillovers  ==1 & repondant_sex == 1"
	local trt_indicator = "beneficiaire"
	local spec_prefix 	= "ICbSm"
	local Index_ALL 		lab_market_main /*lab_market_sec*/ eco_welfare consumption_food consumption_other				///
							assets home_assets comms_assets productive_assets 												///
							credit_access pos_coping_mechanisms neg_coping_mechanisms										///
							shocks social civic well_being 
	}
	
	if "`specification'" == "full_m"{
	local prg_condition = "full  ==1 & repondant_sex == 1"
	local trt_indicator = "trt_full"
	local spec_prefix 	= "ICfSm"
	local Index_ALL 		lab_market_main /*lab_market_sec*/ eco_welfare consumption_food consumption_other				///
							assets home_assets comms_assets productive_assets 												///
							credit_access pos_coping_mechanisms neg_coping_mechanisms										///
							shocks social civic well_being 
	}
	
	**********************************
	**********************************
	
	* Loop over every outcomes group
	
	foreach group_outcomes of local Index_ALL{
		
		
		local lab_main_cond	""
		local lab_sec_cond	""
		local woman_cond 	""
		
		/*
		if "`group_outcomes'" == "lab_market_main"{
			local lab_main_cond "& repondant_rel == 1"
		}
		
		if "`group_outcomes'" == "lab_market_sec"{
			local lab_sec_cond "& repondant_rel != 1"
		}
		*/
		
		if "`group_outcomes'" == "woman_empowerment" & ("`specification'" == "between" 		| ///
														"`specification'" == "within"		| ///
														"`specification'" == "spillovers"	| ///
														"`specification'" == "full") {
		
		local woman_cond "& repondant_sex == 0"												
		}
				
		* Create local used to store variable name to sum later 
		
		local sum_`group_outcomes' 		 ""
		local var_num_`group_outcomes' = 0
		
		* Loop over every individual outcomes
		
		foreach indiv_outcomes of local `group_outcomes'{
		
			* Create control mean of individual outcomes
			
			sum `indiv_outcomes' 					if `trt_indicator' == 0 & `prg_condition' `woman_cond' `lab_main_cond' `lab_sec_cond'
			
			
			gen mean_`indiv_outcomes' = `r(mean)'	if `prg_condition' `woman_cond' `lab_main_cond' `lab_sec_cond'
			
			* Create control standard deviaiton 
			
			sum `indiv_outcomes' 					if `trt_indicator' == 0 & `prg_condition' `woman_cond'
			
			gen sd_`indiv_outcomes' = `r(sd)' 		if `prg_condition' `woman_cond' `lab_main_cond' `lab_sec_cond'
		
			* Normalize individual outcome 
			
			gen norm_`indiv_outcomes' = (`indiv_outcomes' - mean_`indiv_outcomes') / sd_`indiv_outcomes' if `prg_condition' `woman_cond' `lab_main_cond' `lab_sec_cond'
			
			* Fill local with variable name used later to sum all standardize outcomes
			
			local sum_`group_outcomes' "`sum_`group_outcomes'' norm_`indiv_outcomes'"
			
			* Fill local with variable counter 
			
			local var_num_`group_outcomes' = `var_num_`group_outcomes'' + 1
	
		}
		
		* Sum all standardize variable of relevant outcome group
		
		egen `spec_prefix'`group_outcomes' = rowtotal(`sum_`group_outcomes'') if `prg_condition' `woman_cond' `lab_main_cond' `lab_sec_cond', missing 
		
		* Divide by the number of variable in outcomes group_outcomes
		
		replace `spec_prefix'`group_outcomes' = (`spec_prefix'`group_outcomes'/`var_num_`group_outcomes'') if `prg_condition' == 1 `woman_cond' `lab_main_cond' `lab_sec_cond'
		
		* Standardize index 
		
		sum `spec_prefix'`group_outcomes'
		
		replace `spec_prefix'`group_outcomes' = `spec_prefix'`group_outcomes' / `r(sd)' if `prg_condition' `woman_cond' `lab_main_cond' `lab_sec_cond'
		
		* Clean variables created
		
		drop mean_*
		drop sd_*
		drop norm_*
	
	}
	
	* Label index 

	cap label variable `spec_prefix'home_assets				"Home assets"
	cap label variable `spec_prefix'comms_assets			"Communication assets"
	cap label variable `spec_prefix'productive_assets		"Productive assets"
	cap label variable `spec_prefix'consumption_food		"Food consumtion"
	cap label variable `spec_prefix'consumption_other		"Other consumption"
	cap label variable `spec_prefix'lab_market_main			"Labor market"
	*cap label variable `spec_prefix'lab_market_sec			"Labor market (other HH members)"
	cap label variable `spec_prefix'eco_welfare				"Consumption expenditures"
	cap label variable `spec_prefix'assets					"Assets owning"
	cap label variable `spec_prefix'credit_access			"Financial inclusion"
	cap label variable `spec_prefix'pos_coping_mechanisms	"Positive coping mechanisms"
	cap label variable `spec_prefix'neg_coping_mechanisms	"Negative coping mechanisms"
	cap label variable `spec_prefix'social 					"Social participation"
	cap label variable `spec_prefix'civic					"Civic engagement"
	cap label variable `spec_prefix'well_being				"Psychological well being"
	cap label variable `spec_prefix'woman_empowerment		"Women's empowerment"
	cap label variable `spec_prefix'woman_bargain			"Women's empowerment and agency"
	cap label variable `spec_prefix'woman_violence			"Intimate partner violence"
	cap label variable `spec_prefix'shocks					"Economic shock"

}

********************************************************************************
********************************************************************************
* 4) APPLY LAST CORRECTION AND SAVE DATA 
********************************************************************************
********************************************************************************

*delete temporary variables
foreach var of varlist	c3_a_1_win6 c3_a_2_win6 c3_a_3_win c3_a_4_win c3_a_5_win c3_a_6_win c3_a_7_win 	///
						c3_a_8_win c3_a_9_win c3_a_10_win c3_a_11_win  c4_win c5_win c6_win ///
						c7_win c8_win c9_win c11_win c12_win c13_win c14_win c15_win c16_win c18_win 		///
						g2_1 g2_2 g2_3 g2_4 g2_5 g2_6 g2_7 g2_8 g2_9 g2_10 g2_11 g2_12 g2_13 g2_14 g2_15	///	
						q2_1_2_win q2_1_3 q2_1_4 q2_1_5 q2_1_6 q2_1_7 q2_1_8 q2_1_9 q2_1_10 q2_1_11 			///
						q2_1_12 q2_1_13_win q2_1_14 q2_1_15 q2_1_16_win q2_1_17 q2_1_18_win q2_1_19_win 	///
						q2_1_20 q2_1_21 q2_1_22 q2_1_23_win mur_dummy toit_dummy proprietaire_dum1 titre	///
						proprietaire_terre superficie_m titre_terre f18_dummy formation formation_dum1 		///
						formation_dum2 formation_dum3 formation_dum4 formation_dum5 formation_dum6 			///
						formation_dum7 formation_dum9 formation_dum10 emploi_comp_inut emploi tspent_main 	///
						earned_main_win employedhh earnedhh_win paidjobhh earnedoth paidjoboth sec_empl 	///
						tspent_sec_win earned_sec employs pers_employ hoursperm_employ paid_employ epargne  ///		//any issue with oursperm_employ paid_employ?
						epargne_forme_3 epargne_cb futur_services emp_futur_cb_win							///
						association_dummy comite_c comite_c_menage conflit_dispute_in conflit_dispute_out 	///
						migration_cm_q1 migration_q1 security_dummy association_1 association_2 			///
						association_3 association_4 association_6 association_7 association_8 				///
						association_9 securite_1 securite_2 securite_3 securite_4 							///
						securite_5 securite_6 initiative_dummy utopie_a_dum1 utopie_b_dum1 					///
						source_info_internal source_info2_internal utopie_a_dum3 utopie_b_dum3				///
						isolation_dummy initiatives_1 initiatives_2 initiatives_3 initiatives_4 			///
						initiatives_5 initiatives_6 initiatives_7 initiatives_8 initiatives_9 				///
						initiatives_10 initiatives_11 initiatives_12 initiatives_13 initiatives_14 			///
						initiatives_15 isolement_1 isolement_2 isolement_3 									///
						isolement_4 psy_anxiete psy_exploit psy_depress5 psy_accepte_dum1 psy_accepte_dum3 	///
						psy_menage_dum3 psy_a_menage_dum1 psy_a_menage_dum3 pearlin_1 						///
						pearlin_2 pearlin_3 pearlin_4 pearlin_5 pearlin_6 pearlin_7 violence_physical 		///
						violence_emotional intrahh_1 intrahh_2 intrahh_7 intrahh_11 emploiw violence_1_2 	///
						violence_1_3 violence_1_4 violence_1_5 violence_1_6 violence_1_7 violence_1_8 		///
						violence_1_9 violence_1_10 violence_1_11 violence_1_16 violence_1_17 violence_1_18		{
						
						drop `var'bis 
		}

	local sign 		emploi_comp_inut conflit_dispute_in conflit_dispute_out migration_cm_q1 migration_q1 	///
					security_dummy securite_1 securite_2 securite_3 securite_4 securite_5  	///
					securite_6 	  	///
					utopie_a_dum3 utopie_b_dum3 isolation_dummy psy_anxiete psy_exploit 					///
					psy_depress5 psycho_depress4 psycho_depress3 psycho_depress2 psycho_depress1			///
					psy_accepte_dum1 psy_a_menage_dum1 source_info_internal source_info2_internal			///
					pearlin_2 pearlin_3 intrahh_7 intrahh_11 violence_1_2 violence_1_3 violence_1_4 		///
					violence_1_5 violence_1_6 violence_1_7 violence_1_8 violence_1_9 violence_1_10 			///
					violence_1_11 violence_1_16 violence_1_17 violence_1_18	violence_physical 				///
					violence_emotional  pearlin_7 distance_marche  distance_transpublic						///
					epargne_dette epargne_dette_cb_win g2_1 g2_2  distance_ecoleprim						///
					g2_13 g2_14 g2_15 intrahh_7bis2  distance_ecolesec distance_eau	distance_dispensaire   			

	foreach signvar of local sign  {
	rename 	`signvar'	  	`signvar'_convert 
	rename	`signvar'I 		`signvar'
	}

	
label variable futur_services		"Aspire to work in service"
label variable emp_futur_cb_win	"Income aspiration"
label variable emploi				"Had an IGA during the last 4 weeks"
label variable tspent_main			"Days spent in main IGA"
label variable earned_main_win		"Wage from main activity last month"
label variable employedhh			"HH head main IGA"
label variable earnedhh_win		"HH head main income last month"
label variable paidjobhh			"HH head second IGA"
label variable earnedoth_win		"Other HH member income last month"
label variable paidjoboth			"HH members IGA"
label variable sec_empl				"Other IGA"
label variable tspent_sec_win		"Days spent in other IGA"
label variable earned_sec_win		"Wage from other IGA activity last month"
label variable c3_a_1_win 	"Bread, flour..."
label variable c3_a_2_win 	"Pasta, rice..."
label variable c3_a_3_win 	"Fish"
label variable c3_a_4_win 	"Meat"
label variable c3_a_5_win 	"Eggs and diary"
label variable c3_a_6_win 	"Vegetables"
label variable c3_a_7_win 	"Fruits"
label variable c3_a_8_win 	"Oil"
label variable c3_a_9_win 	"Water and soda"
label variable c3_a_10_win "Seasonning"
label variable c3_a_11_win "Tobacco, coffee and tea"
label variable c4_win 		"Rent"
label variable c5_win 		"Electricity, gaz, petrol..."
label variable c6_win 		"Phone"
label variable c7_win 		"Soap"
label variable c8_win 		"Transport"
label variable c9_win 		"Hairdresser"
label variable c11_win 	"household small repairs"
label variable c12_win 	"Medical expenses"
label variable c13_win 	"Education expenses"
label variable c14_win 	"Clothes"
label variable c15_win 	"Assets"
label variable c16_win 	"Taxes"
label variable c18_win 	"Festivity"
label variable q2_1_2_win 			"Stove"
label variable q2_1_3_win 			"Fridge"
label variable q2_1_4_win 			"Heating"
label variable q2_1_5_win 			"Air conditionner"
label variable q2_1_6_win 			"Washing machine"
label variable q2_1_7_win 			"Bed"
label variable q2_1_8_win 			"Shelf"
label variable q2_1_9_win 			"Automobile"
label variable q2_1_10_win 		"Moto"
label variable q2_1_11_win 		"Bike"
label variable q2_1_12_win 		"Television"
label variable q2_1_13_win 		"Satellite"
label variable q2_1_14_win 		"Camera"
label variable q2_1_15_win			"Radio"
label variable q2_1_16_win 		"Phone"
label variable q2_1_17_win 		"Computer"
label variable q2_1_18_win 		"Sheep"
label variable q2_1_19_win 		"Poultry"
label variable q2_1_20_win 		"Hives"
label variable q2_1_21_win 		"Cattle"
label variable q2_1_22_win 		"Horses"
label variable q2_1_23_win 		"Dog or cat"
label variable mur_dummy 			"Cement or brick wall"
label variable toit_dummy 			"Cement or tiles roof"
label variable proprietaire_dum1 	"Proprietary: house"
label variable titre 				"Tilting property"	
label variable proprietaire_terre 	"Proprietary: land"
label variable superficie_m 		"Size land"
label variable titre_terre 			"Titling land"
label variable g2_1 	"Reduce food consumption"
label variable g2_2 	"Withdraw children from school"
label variable g2_3 	"Debt with friends"
label variable g2_4 	"Debt with coop"
label variable g2_5 	"Debt with neighbors"
label variable g2_6 	"Help from family outside of village"
label variable g2_7 	"Send children away"
label variable g2_8 	"Help from community member"
label variable g2_9		"Help from Omda"
label variable g2_10 	"Help from other Omda"
label variable g2_11 	"Help from NGO"
label variable g2_12 	"Help from Gov."
label variable g2_13 	"Selling assets"
label variable g2_14 	"Selling cattles"
label variable g2_15 	"Use savings"
label variable g1_1 	"Death of HH head (or main income earner)"
label variable g1_2 	"Death of other HH members"
label variable g1_3 	"Serious disease HH head (or main income earner)"
label variable g1_4 	"Serious disease of other HH members"
label variable g1_5 	"Loss of employment or fail business in HH"
label variable g1_6 	"Loss of means because of incident (fire, war..)"
label variable g1_7 	"Bad harvest"
label variable g1_8 	"Land Seizure"
label variable g1_9		"Other"
label variable association_1	"Farmer association"
label variable association_2	"Women association"								
label variable association_3	"Religious association"
label variable association_4	"Youth association"
label variable association_5	"Veteran association"
label variable association_6	"Saving association"
label variable association_7	"Political association"
label variable association_8	"Human right association"
label variable association_9	"Other association"
label variable initiatives_1 	"Participate in townhall"
label variable initiatives_2 	"Meet the Omda"
label variable initiatives_3 	"Meet the Imam"
label variable initiatives_4 	"Contact police or court"
label variable initiatives_5 	"Meet other state representative"
label variable initiatives_6 	"Meet NGO"
label variable initiatives_7 	"Meet village representative at House"
label variable initiatives_8 	"Meet influencial but not official people"
label variable initiatives_9 	"Friends or Family"								
label variable initiatives_10 	"Maintain school or clinic"
label variable initiatives_11 	"Maintain road"
label variable initiatives_12 	"Maintain wells"
label variable initiatives_13 	"Security in village"
label variable initiatives_14 	"Maintain mosquee"
label variable initiatives_15 	"Maintain market"
label variable psy_anxiete			"No fear of losing control"
label variable psy_exploit			"No feeling of being exploited"
label variable psy_depress5			"No useless for others"
label variable psy_accepte_dum3		"Accepted by family"
label variable psy_menage_dum3		"Good relation between HH member"
label variable psy_a_menage_dum3	"Accepted by other HH"
label variable psycho_depress4		"No loss of appetite"
label variable psycho_depress3		"Not feeling irritable"
label variable psycho_depress2		"No loss of interest for activity"
label variable psycho_depress1		"Feeling joy"
label variable violence_1_2 		"Humiliated"
label variable violence_1_3 		"Intimidated"
label variable violence_1_4 		"Threatened"
label variable violence_1_5 		"Threatened relatives"
label variable violence_1_6 		"Slapped"
label variable violence_1_7 		"Pushed"
label variable violence_1_8 		"Punched (hand)"
label variable violence_1_9 		"Punched (feet)"
label variable violence_1_10 		"Burned or strangled"
label variable violence_1_11 		"Threatened with a knife"
label variable violence_1_16 		"Prevented from going to work"
label variable violence_1_17 		"Stole your money"
label variable violence_1_18 		"Laid off"
label variable intrahh_1	"Earn income"
label variable intrahh_2	"Decide by self how own's income is used"
label variable intrahh_7	"Husband doesn't decide by itself how its income is used"
label variable intrahh_11	"Income not being confiscated"
label variable emploiw		"Women IGA"
label variable epargne_dette 			"Contract debt last 12 month"
label variable epargne_dette_cb_win 	"Actual amount of debt"
label variable epargne  				"Did you save money during the last 12 months"
label variable epargne_cb_win 			"Amount saved during the last 12 months"
label variable epargne_pret				"Did you lend money during the last 12 months"								


local Control_ALL   hhsize drepondant_mat h_18_65 f_18_65 trauma_abus q0_1_c q0_3_c q2_2_c q2_3_c q2_4_c 	///
					negevent_1 negevent_2 negevent_3 negevent_4 											///
					negevent_5 negevent_6 negevent_7      													///
					negevent_8 negevent_9 posevent_1 posevent_2 posevent_3      							///
					posevent_4 posevent_5 posevent_6 posevent_7 posevent_8

	* Imput missing control variable by 0 and add indicator for missing 
	
	foreach variables of local Control_ALL{
	
	g missing_`variables' = 0 
							
	replace missing_`variables' = 1 if 	`variables' ==.  | ///
										`variables' ==.a | ///
										`variables' ==.n | ///
										`variables' ==.d 
	
	replace `variables'   = 0 if  	`variables' ==.  | ///
									`variables' ==.a | ///
									`variables' ==.n | ///
									`variables' ==.d 
	}

	
	
save "$stata/enquete_All3", replace

