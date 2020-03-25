********************************************************************************
*				REPLICATION INDEX TUNISIA CWLP 								   *
********************************************************************************
********************************************************************************

********************************************************************************
********************************************************************************
* 0) DEFINE LOCAL USED TO BUILD INDEX 
********************************************************************************
********************************************************************************


local lab_market_main			futur_services emp_futur_cb_win5 emploi tspent_main earned_main_win5 employedhh 				///
								earnedhh_win5 paidjobhh 
							
							
local lab_market_sec			earnedoth_win5 paidjoboth sec_empl tspent_sec_win5 earned_sec_win5
							
							
local eco_welfare 				c3_a_1_win5 c3_a_2_win5 c3_a_3_win5 c3_a_4_win5 c3_a_5_win5 c3_a_6_win5 c3_a_7_win5 				///
								c3_a_8_win5 c3_a_9_win5 c3_a_10_win5 c3_a_11_win5 c4_win5 c5_win5 c6_win5 							///
								c7_win5 c8_win5 c9_win5 c11_win5 c12_win5 c13_win5 c14_win5 c16_win5 c18_win5 


* Need to check what are the outcomes related to comm_assets (q2_1_12bis2 q2_1_13_winbis2 q2_1_14bis2 q2_1_15bis2 q2_1_16_winbis2)
* Need to check what's the difference with bis and bis2 variables 

local assets					q2_1_2_win5 q2_1_3_win5 q2_1_4_win5 q2_1_5_win5 q2_1_6_win5 q2_1_7_win5 q2_1_8_win5 					///
								q2_1_9_win5 q2_1_10_win5 q2_1_11_win5 q2_1_12_win5 q2_1_13_win5 q2_1_14_win5 							///
								q2_1_15_win5 q2_1_16_win5 q2_1_17_win5 q2_1_18_win q2_1_19_win5 										///
								q2_1_20_win5 q2_1_21_win5 q2_1_22_win5 q2_1_23_win5 mur_dummy toit_dummy proprietaire_dum1 					///
								titre proprietaire_terre superficie_m titre_terre 
						

local credit_access				epargne_dette epargne_dette_cb_win5 epargne epargne_cb epargne_pret											


local pos_coping_mechanisms		g2_3 g2_4 g2_5 g2_6  g2_8 g2_9 g2_10 g2_11 g2_12 

local neg_coping_mechanisms		g2_1 g2_2 g2_7 g2_13 g2_14 g2_15	


local shocks					g1_1 g1_2 g1_3 g1_4 g1_5 g1_6 g1_7 g1_8 g1_9


* comite_c comite_c_menage comite_cbis comite_c_menagebis association_dummy  migration_cm_q1 migration_q1

local social				association_1 association_2 initiatives_9 association_9											///
							association_3 association_4 association_6 association_7 association_8  
							
							
local civic					initiatives_1 initiatives_2 initiatives_3 initiatives_4 initiatives_5 initiatives_6 			///
							initiatives_7 initiatives_8  initiatives_10 initiatives_11 										///
							initiatives_12 initiatives_13 initiatives_14 initiatives_15									

							

local well_being 			psy_anxiete psy_exploit psy_depress5 /*psy_accepte_dum1*/ psy_accepte_dum3 						///
							psy_menage_dum3 /*psy_a_menage_dum1*/ psy_a_menage_dum3	 										///
							psycho_depress4 psycho_depress3 psycho_depress2 psycho_depress1


local woman_violence		violence_1_2 violence_1_3 violence_1_4 violence_1_5 violence_1_6 								///
							violence_1_7 violence_1_8 violence_1_9 violence_1_10 violence_1_11 								///
							violence_1_16 violence_1_17 violence_1_18  	
							

local woman_bargain 		intrahh_1 intrahh_2 intrahh_7 intrahh_11 emploiw association_2


local Index_ALL 			lab_market_main lab_market_sec eco_welfare assets credit_access pos_coping_mechanisms neg_coping_mechanisms	///
							shocks social civic well_being woman_violence woman_bargain

							
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
	cap replace `var' =.k if `var' == -97
	cap replace `var' =.r if `var' == -98
	cap replace `var' =.z if `var' == -99
	}

}

*drop earned_main_winbis earned_main_win5bis
 
* Apply logarithmic transformation 

foreach var of varlist 		c3_a_1_win6 c3_a_2_win6 c3_a_3_win c3_a_4_win5 c3_a_5_win5 c3_a_6_win5 c3_a_7_win5  		///
							c3_a_8_win5 c3_a_9_win c3_a_10_win c3_a_11_win5 exp_food_win5 c4_win c5_win5 c6_win5 		/// 
							c7_win5 c8_win5 c9_win c11_win c12_win c13_win c14_win c15_win c16_win c18_win 				///
							tspent_main earned_main_win earnedhh_win earnedoth epargne_cb epargne_dette_cb_win		{
	gen l`var' = log(`var'+1)
	rename `var'   n`var'
	rename  l`var' `var'
}


*Account for repetition of variables in different categories; will delete at end of code

foreach var of varlist	c3_a_1_win6 c3_a_2_win6 c3_a_3_win c3_a_4_win5 c3_a_5_win5 c3_a_6_win5 c3_a_7_win5 	///
						c3_a_8_win5 c3_a_9_win c3_a_10_win c3_a_11_win5 exp_food_win5 c4_win c5_win5 c6_win5 ///
						c7_win5 c8_win5 c9_win c11_win c12_win c13_win c14_win c15_win c16_win c18_win 		///
						g2_1 g2_2 g2_3 g2_4 g2_5 g2_6 g2_7 g2_8 g2_9 g2_10 g2_11 g2_12 g2_13 g2_14 g2_15	///	
						q2_1_2_win q2_1_3 q2_1_4 q2_1_5 q2_1_6 q2_1_7 q2_1_8 q2_1_9 q2_1_10 q2_1_11 		///
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
					

					
/*	g1_1 g1_3 g1_5 g1_6 g1_7 lithh_dum1 lithh_dum2 lit_dum1 lit_dum2 emploi_comp_inut empl_futurt_dum4 sante_lieux_dum4 ///
sante_lieux_dum5 distance_dispensaire_win distance_ecoleprim_win distance_ecolesec_win distance_eau_win sante_qualite_b_dum1 ///
sante_qualite_c_dum1 ecole_qualite_c_dum1 ecole_qualite_d_dum1 distance_eau distance_marche_win distance_transpublic_win ///
distance_ecoleprim distance_ecolesec distance_dispensaire distance_cheflieu_win conflit_dispute_in conflit_dispute_out migration_cm_q1 ///
migration_q1 securite_1 securite_2 securite_3 securite_4 securite_5 securite_6 utopie_a_dum3 utopie_b_dum3 source_info_7 source_info_8 ///
source_info2_7 source_info2_8 psy_anxiete psy_exploit psy_depress5 psy_accepte_dum1 psy_menage_dum1 psy_a_menage_dum1 pearlin_2 pearlin_3 ///
intrahh_7 intrahh_11 violence_1_2 violence_1_3 violence_1_4 violence_1_5 violence_1_6 violence_1_7 violence_1_8 violence_1_9 violence_1_10 ///
violence_1_11 violence_1_16 violence_1_17 violence_1_18 violence_physical violence_emotional */

foreach signvar of local sign  {
gen 	`signvar'I = -	`signvar'
rename 	`signvar'I  	`signvar'_t
rename	`signvar' 		`signvar'I
rename	`signvar'_t	 	`signvar'
}

*save "$stata/enquete_All2", replace

********************************************************************************
********************************************************************************
* 1) STANDARDIZE EVERY INDIVIDUAL OUTCOMES AGAINST RELEVANT CONTROL GROUP
********************************************************************************
********************************************************************************

* Generate program indicator 

gen programs=(parti==1 | desist==1)

		
* Generate variable identifyin the sample used for every analysis 

g 		between = .
replace between = 1 if (parti==1 | desist==1 | enquete==3)

g 		within = .
replace within = 1 if (parti==1 | desist==1 | control==1) 

g 		spillovers = .
replace spillovers = 1 if (control==1 | enquete==3) 

g 		Infrastructure = .
replace Infrastructure = 1 if enquete==1

g 		full = . 
replace full = 1 if parti==1 | desist==1 | enquete==3 | control==1

g 		trt_full = 1 if full == 1
replace trt_full = 0 if beneficiaire == 0 & programs == 0  & full == 1

foreach specification in between within spillovers full{								// Loop over every specification (control group differ between those)

	
	* Define local specific to specification
	
	if "`specification'" == "between"{
	local prg_condition = "between"
	local trt_indicator = "beneficiaire"
	local spec_prefix 	= "IAaS"
	local woman_cond 	= ""
	}
	
	if "`specification'" == "within"{
	local prg_condition = "within"
	local trt_indicator = "program"
	local spec_prefix 	= "IBaS"
	local woman_cond 	= ""
	}
	
	if "`specification'" == "spillovers"{
	local prg_condition = "spillovers"
	local trt_indicator = "beneficiaire"
	local spec_prefix 	= "ICbS"
	local woman_cond 	= ""
	}
	
	if "`specification'" == "full"{
	local prg_condition = "full"
	local trt_indicator = "trt_full"
	local spec_prefix 	= "ICfS"
	local woman_cond 	= ""
	}

	* Loop over every outcomes group
	
	foreach group_outcomes of local Index_ALL{
		
		if "`group_outcomes'" == "woman_violence" |  "`group_outcomes'" == "woman_bargain"{
		local woman_cond = "& repondant_sex == 0"
		}
		
		* Create local used to store variable name to sum later 
		
		local sum_`group_outcomes' 		 ""
		local var_num_`group_outcomes' = 0
		
		* Loop over every individual outcomes
		
		foreach indiv_outcomes of local `group_outcomes'{
		
			* Create control mean of individual outcomes
			
			sum `indiv_outcomes' 					if `trt_indicator' == 0 & `prg_condition' ==1 `woman_cond'
			
			gen mean_`indiv_outcomes' = `r(mean)'	if `prg_condition' == 1 `woman_cond'
			
			* Create control standard deviaiton 
			
			sum `indiv_outcomes' 					if `trt_indicator' == 0 & `prg_condition' ==1 `woman_cond'
			
			gen sd_`indiv_outcomes' = `r(sd)' 		if `prg_condition' == 1 `woman_cond'
		
			* Normalize individual outcome 
			
			gen norm_`indiv_outcomes' = (`indiv_outcomes' - mean_`indiv_outcomes') / sd_`indiv_outcomes' if `prg_condition' ==1 `woman_cond'
			
			* Fill local with variable name used later to sum all standardize outcomes
			
			local sum_`group_outcomes' "`sum_`group_outcomes'' norm_`indiv_outcomes'"
			
			* Fill local with variable counter 
			
			local var_num_`group_outcomes' = `var_num_`group_outcomes'' + 1
	
		}
		
		* Sum all standardize variable of relevant outcome group
		
		egen `spec_prefix'`group_outcomes' = rowtotal(`sum_`group_outcomes'') if `prg_condition' ==1 `woman_cond', missing 
		
		* Divide by the number of variable in outcomes group_outcomes
		
		replace `spec_prefix'`group_outcomes' = (`spec_prefix'`group_outcomes'/`var_num_`group_outcomes'') if `prg_condition' == 1 `woman_cond'
		
		* Standardize index 
		
		sum `spec_prefix'`group_outcomes'
		
		replace `spec_prefix'`group_outcomes' = `spec_prefix'`group_outcomes' / `r(sd)' if `prg_condition' == 1 `woman_cond'
		
		* Clean variables created
		
		drop mean_*
		drop sd_*
		drop norm_*
	
	}
	
	* Label index 
	
	label variable `spec_prefix'lab_market_main			"Labor market (HH head)"
	label variable `spec_prefix'lab_market_sec			"Labor market (other HH members)"
	label variable `spec_prefix'eco_welfare				"Consumption expenditures"
	label variable `spec_prefix'assets					"Assets expenditures"
	label variable `spec_prefix'credit_access			"Financial inclusion"
	label variable `spec_prefix'pos_coping_mechanisms	"Positive coping mechanisms"
	label variable `spec_prefix'neg_coping_mechanisms	"Negative coping mechanisms"
	label variable `spec_prefix'social 					"Social participation"
	label variable `spec_prefix'civic					"Civic engagement"
	label variable `spec_prefix'well_being				"Psychological well being"
	label variable `spec_prefix'woman_bargain			"Women's empowerment and agency"
	label variable `spec_prefix'woman_violence			"Intimate partner violence"
	label variable `spec_prefix'shocks					"Economic shock"
	
	* Previous labelling
	 
	{
	*label variable `spec_prefix'food_consump_win 		"Food Consumption"
	*label variable `spec_prefix'expenditure_win 		"Other Expenditure"
	*label variable `spec_prefix'coping_mechanisms 		"Coping Mechanisms"
	*label variable `spec_prefix'hh_assets2 				"HH Assets"
	*label variable `spec_prefix'house_ownership		"House Ownership"
	*label variable `spec_prefix'large_assets 			"Large Assets"
	*label variable `spec_prefix'small_assets 			"Small Assets"
	*label variable `spec_prefix'home_assets 			"Home Assets"
	*label variable `spec_prefix'comms_assets 			"Communications Assets"
	*label variable `spec_prefix'productive_assets 		"Productive Assets"
	*label variable `spec_prefix'human_capital2 			"Human Capital"
	*label variable `spec_prefix'wage_employment2		"Wage Employment"
	*label variable `spec_prefix'other_employment		"Other Employment"
	*label variable `spec_prefix'non_agri_enterp 		"Non-Agricultural Enterprise"
	*label variable `spec_prefix'debts_and_savings2 	"Debts and Savings"
	*label variable `spec_prefix'debts				 	"Debts"
	*label variable `spec_prefix'savings 				"Savings"
	*label variable `spec_prefix'employ_aspirations 	"Employment Aspirations"
	*label variable `spec_prefix'service_access 			"Access to services"
	*label variable `spec_prefix'social_cohesion2 		"Social Cohesion"
	*label variable `spec_prefix'comm_groups 			"Community Groups"
	*label variable `spec_prefix'local_conflict 		"Local Conflict"
	*label variable `spec_prefix'recent_migration		"Recent Migration"
	*label variable `spec_prefix'local_security 		"Local Security"
	*label variable `spec_prefix'civic_engag 			"Civic Engagement"
	*label variable `spec_prefix'initiatives 			"Local Participation"
	*label variable `spec_prefix'initiatives_meeting 	"Local Meeting"
	*label variable `spec_prefix'initiatives_acting		"Local Acting"
	*label variable `spec_prefix'information_sources 	"Information Sources"
	*label variable `spec_prefix'utopia 				"Liberal Norms"
	*label variable `spec_prefix'isolation 				"Isolation"
	*label variable `spec_prefix'psycho_wellbeing2 		"Psychological Wellbeing"	
	*label variable `spec_prefix'pearlin_index 			"Pearlin Index"
	*label variable `spec_prefix'overall_intrahouse2 	"Intrahousehold Dynamics"
	*label variable `spec_prefix'womens_decision 		"Female Decisionmaking"
	*label variable `spec_prefix'violence_ag_women 		"Violence against Women"
	*label variable `spec_prefix'psycho_internal 		"Internal Wellbeing"
	*label variable `spec_prefix'psycho_external		"External Wellbeing"
	}
}

********************************************************************************
********************************************************************************
* 4) APPLY LAST CORRECTION AND SAVE DATA 
********************************************************************************
********************************************************************************

*delete temporary variables
foreach var of varlist	c3_a_1_win6 c3_a_2_win6 c3_a_3_win c3_a_4_win5 c3_a_5_win5 c3_a_6_win5 c3_a_7_win5 	///
						c3_a_8_win5 c3_a_9_win c3_a_10_win c3_a_11_win5 exp_food_win5 c4_win c5_win5 c6_win5 ///
						c7_win5 c8_win5 c9_win c11_win c12_win c13_win c14_win c15_win c16_win c18_win 		///
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
label variable emp_futur_cb_win5	"Income aspiration"
label variable emploi				"Had an IGA during the last 4 weeks"
label variable tspent_main			"Days spent in main IGA"
label variable earned_main_win5		"Wage from main activity last month"
label variable employedhh			"HH head main IGA"
label variable earnedhh_win5		"HH head main income last month"
label variable paidjobhh			"HH head second IGA"
label variable earnedoth_win5		"Other HH member income last month"
label variable paidjoboth			"HH members IGA"
label variable sec_empl				"Other IGA"
label variable tspent_sec_win5		"Days spent in other IGA"
label variable earned_sec_win5		"Wage from other IGA activity last month"
label variable c3_a_1_win5 	"Bread, flour..."
label variable c3_a_2_win5 	"Pasta, rice..."
label variable c3_a_3_win5 	"Fish"
label variable c3_a_4_win5 	"Meat"
label variable c3_a_5_win5 	"Eggs and diary"
label variable c3_a_6_win5 	"Vegetables"
label variable c3_a_7_win5 	"Fruits"
label variable c3_a_8_win5 	"Oil"
label variable c3_a_9_win5 	"Water and soda"
label variable c3_a_10_win5 "Seasonning"
label variable c3_a_11_win5 "Tobacco, coffee and tea"
label variable c4_win5 		"Rent"
label variable c5_win5 		"Electricity, gaz, petrol..."
label variable c6_win5 		"Phone"
label variable c7_win5 		"Soap"
label variable c8_win5 		"Transport"
label variable c9_win5 		"Hairdresser"
label variable c11_win5 	"household small repairs"
label variable c12_win5 	"Medical expenses"
label variable c13_win5 	"Education expenses"
label variable c14_win5 	"Clothes"
label variable c15_win5 	"Assets"
label variable c16_win5 	"Taxes"
label variable c18_win5 	"Festivity"
label variable q2_1_2_win5 			"Stove"
label variable q2_1_3_win5 			"Fridge"
label variable q2_1_4_win5 			"Heating"
label variable q2_1_5_win5 			"Air conditionner"
label variable q2_1_6_win5 			"Washing machine"
label variable q2_1_7_win5 			"Bed"
label variable q2_1_8_win5 			"Shelf"
label variable q2_1_9_win5 			"Automobile"
label variable q2_1_10_win5 		"Moto"
label variable q2_1_11_win5 		"Bike"
label variable q2_1_12_win5 		"Television"
label variable q2_1_13_win5 		"Satellite"
label variable q2_1_14_win5 		"Camera"
label variable q2_1_16_win5 		"Phone"
label variable q2_1_17_win5 		"Computer"
label variable q2_1_18_win5 		"Sheep"
label variable q2_1_19_win5 		"Poultry"
label variable q2_1_20_win5 		"Hives"
label variable q2_1_21_win5 		"Cattle"
label variable q2_1_22_win5 		"Horses"
label variable q2_1_23_win5 		"Dog or cat"
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
label variable epargne_dette_cb_win5 	"Actual amount of debt"
label variable epargne  				"Did you save money during the last 12 months"
label variable epargne_cb 				"Amount saved during the last 12 months"
label variable epargne_pret				"Did you lend money during the last 12 months"								



save "$stata/enquete_All3", replace

