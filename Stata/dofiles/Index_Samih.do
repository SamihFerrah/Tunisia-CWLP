********************************************************************************
*				REPLICATION INDEX TUNISIA CWLP 								   *
********************************************************************************
********************************************************************************

********************************************************************************
********************************************************************************
* 0) DEFINE LOCAL USED TO BUILD INDEX 
********************************************************************************
********************************************************************************

{
local food_consump_win 		c3_a_1_win6 c3_a_2_win6 c3_a_3_win c3_a_4_win5 c3_a_5_win5 c3_a_6_win5 c3_a_7_win5 			///
							c3_a_8_win5 c3_a_9_win c3_a_10_win c3_a_11_win5 

local expenditure_win 		exp_food_win c4_win c5_win5 c6_win5 c7_win5 c8_win5 c9_win c11_win c12_win c13_win c14_win 	///
							c15_win c16_win c18_win 

local coping_mechanisms 	g2_1 g2_2 g2_3 g2_4 g2_5 g2_6 g2_7 g2_8 g2_9 g2_10 g2_11 g2_12 g2_13 g2_14 g2_15

local hh_assets2			q2_1_2_win q2_1_3 q2_1_4 q2_1_5 q2_1_6 q2_1_7 q2_1_8 q2_1_9 q2_1_10 q2_1_11 				///
							q2_1_12 q2_1_13_win q2_1_14 q2_1_15 q2_1_16_win q2_1_17 q2_1_18_win q2_1_19_win 			///
							q2_1_20 q2_1_21 q2_1_22 q2_1_23_win mur_dummy toit_dummy proprietaire_dum1 					///
							titre proprietaire_terre superficie_m titre_terre f18_dummy
						
local house_ownership		proprietaire_dum1bis titrebis proprietaire_terrebis titre_terrebis
						
local large_assets			q2_1_2_winbis q2_1_3bis q2_1_4bis q2_1_5bis q2_1_6bis q2_1_9bis q2_1_10bis					///
							q2_1_12bis q2_1_13_winbis q2_1_17bis  q2_1_20bis q2_1_21bis q2_1_22bis 
						  
local small_assets			q2_1_7bis q2_1_8bis q2_1_11bis q2_1_14bis q2_1_15bis q2_1_16_winbis q2_1_18_winbis 			///
							q2_1_19_winbis q2_1_23_winbis 

local home_assets			q2_1_2_winbis2 q2_1_3bis2 q2_1_4bis2 q2_1_5bis2 q2_1_6bis2 q2_1_7bis2 q2_1_8bis2  	
	
local comms_assets			q2_1_12bis2 q2_1_13_winbis2 q2_1_14bis2 q2_1_15bis2 q2_1_16_winbis2  

local productive_assets		q2_1_9bis2 q2_1_10bis2 q2_1_11bis2 q2_1_17bis2 q2_1_18_winbis2 q2_1_19_winbis2 				///
							q2_1_20bis2 q2_1_21bis2 //q2_1_22bis2

local human_capital2 		formation formation_dum1 formation_dum2 formation_dum3 formation_dum4 						///
							formation_dum5 formation_dum6 formation_dum7 formation_dum9 								///
							formation_dum10 emploi_comp_inut

local wage_employment2 		emploi tspent_main earned_main_win employedhh earnedhh_win 									///
							paidjobhh earnedoth paidjoboth								

local other_employment 		sec_empl tspent_sec_win earned_sec

*local non_agri_enterp 		employs pers_employ hoursperm_employ paid_employ

local debts_and_savings2 	epargne epargne_forme_3 epargne_cb epargne_dette epargne_dette_cb_win epargne_pret

local debts					epargne_dettebis epargne_dette_cb_winbis //epargne_pret

local savings				epargnebis epargne_forme_3bis epargne_cbbis

local employ_aspirations	futur_services emp_futur_cb_win //futur_agriculture

local social_cohesion2		association_dummy comite_c comite_c_menage conflit_dispute_in conflit_dispute_out 			///
							/*migration_cm_q1 migration_q1*/ security_dummy							

local comm_groups			association_1 association_2 association_3 association_4 association_6 association_7 		///
							association_8 association_9 comite_cbis comite_c_menagebis

local local_conflict		conflit_dispute_inbis conflit_dispute_outbis

local recent_migration		migration_cm_q1bis migration_q1bis

local local_security		/*securite_1 securite_2 */ securite_3 /* securite_4 */ securite_5 securite_6

local civic_engag 			initiative_dummy utopie_a_dum1 utopie_b_dum1 source_info_internal source_info2_internal 	///
							isolation_dummy
							
local initiatives			initiatives_1 initiatives_2 initiatives_3 initiatives_4 initiatives_5 initiatives_6 		///
							initiatives_7 initiatives_8 initiatives_9 initiatives_10 initiatives_11 					///
							initiatives_12 initiatives_13 initiatives_14 initiatives_15
							
local initiatives_meeting	initiatives_1bis initiatives_2bis initiatives_3bis initiatives_4bis initiatives_5bis initiatives_6bis ///
							initiatives_7bis initiatives_8bis initiatives_9bis 
							
local initiatives_acting	initiatives_10bis initiatives_11bis initiatives_12bis initiatives_13bis initiatives_14bis /*initiatives_15bis*/

local information_sources	source_info_internalbis source_info2_internalbis 

local utopia				utopie_a_dum1bis  utopie_a_dum3 utopie_b_dum1bis  utopie_b_dum3

local isolation				isolement_1 isolement_2 isolement_3 isolement_4

local psycho_wellbeing2		psy_anxiete psy_exploit psy_depress5 /*psy_accepte_dum1*/ psy_accepte_dum3 					///
							psy_menage_dum3 /*psy_a_menage_dum1*/ psy_a_menage_dum3	
						
local psycho_internal   	psy_anxietebis psy_exploitbis psy_depress5bis

local psycho_external		/*psy_accepte_dum1bis*/ psy_accepte_dum3bis psy_menage_dum3bis 								///
							/*psy_a_menage_dum1bis*/ psy_a_menage_dum3bis							

local womens_decision 		intrahh_1 intrahh_2 intrahh_7 intrahh_11 emploiw
							
local overall_intrahouse2	intrahh_1bis intrahh_2bis intrahh_7bis intrahh_11bis emploiwbis 							///
							violence_physical violence_emotional

local violence_ag_women 	violence_1_2 violence_1_3 violence_1_4 violence_1_5 violence_1_6 							///
							violence_1_7 violence_1_8 violence_1_9 violence_1_10 violence_1_11 							///
							violence_1_16 violence_1_17 violence_1_18
	
local service_access		distance_dispensaire  distance_ecoleprim distance_ecolesec distance_eau 					///
							sante_qualite_a sante_qualite_b sante_qualite_c sante_qualite_d 							///
							ecole_qualite_a ecole_qualite_b ecole_qualite_c ecole_qualite_d								///
							distance_marche  distance_transpublic
}	

// missing : agri_prod_income

local Index_ALL ///
					 food_consump_win  expenditure_win  coping_mechanisms  hh_assets2   human_capital2 					///
					 wage_employment2  other_employment /*non_agri_enterp*/   debts  savings  								///
					 service_access	social_cohesion2 civic_engag psycho_wellbeing2 womens_decision violence_ag_women
					 
					
********************************************************************************
********************************************************************************
* 1) Prepare data (flip sign and stuff)
********************************************************************************
********************************************************************************


use "$stata/enquete_All", clear
*drop earned_main_winbis earned_main_win5bis
 
* Apply logarithmic transformation 

foreach var of varlist 		c3_a_1_win6 c3_a_2_win6 c3_a_3_win c3_a_4_win5 c3_a_5_win5 c3_a_6_win5 c3_a_7_win5  ///
							c3_a_8_win5 c3_a_9_win c3_a_10_win c3_a_11_win5 exp_food_win c4_win c5_win5 c6_win5 /// 
							c7_win5 c8_win5 c9_win c11_win c12_win c13_win c14_win c15_win c16_win c18_win 		///
							tspent_main earned_main_win earnedhh_win earnedoth epargne_cb epargne_dette_cb_win		{
	gen l`var' = log(`var'+1)
	rename `var'   n`var'
	rename  l`var' `var'
}


*Account for repetition of variables in different categories; will delete at end of code

foreach var of varlist	c3_a_1_win6 c3_a_2_win6 c3_a_3_win c3_a_4_win5 c3_a_5_win5 c3_a_6_win5 c3_a_7_win5 	///
						c3_a_8_win5 c3_a_9_win c3_a_10_win c3_a_11_win5 exp_food_win c4_win c5_win5 c6_win5 ///
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

local sign 			emploi_comp_inut conflit_dispute_in conflit_dispute_out migration_cm_q1 migration_q1 ///
					security_dummy securite_1 securite_2 securite_3 securite_3bis securite_4 securite_5  ///
					securite_5bis securite_6 securite_6bis	violence_physicalbis violence_emotionalbis  ///
					utopie_a_dum3 utopie_b_dum3 isolation_dummy psy_anxiete psy_exploit 				///
					psy_depress5 psy_accepte_dum1 psy_a_menage_dum1 source_info_internal source_info2_internal	///
					source_info_internalbis source_info2_internalbis intrahh_7bis intrahh_11bis			///
					pearlin_2 pearlin_3 intrahh_7 intrahh_11 violence_1_2 violence_1_3 violence_1_4 	///
					violence_1_5 violence_1_6 violence_1_7 violence_1_8 violence_1_9 violence_1_10 		///
					violence_1_11 violence_1_16 violence_1_17 violence_1_18	violence_physical 			///
					violence_emotional conflit_dispute_inbis conflit_dispute_outbis migration_cm_q1bis 	///
					migration_q1bis pearlin_7 pearlin_7bis psy_anxietebis psy_exploitbis psy_depress5bis ///
					psy_accepte_dum1bis psy_a_menage_dum1bis epargne_dette epargne_dette_cb_win			 ///
					epargne_dettebis epargne_dette_cb_winbis g2_1 g2_2 g2_3 g2_4 g2_5 g2_6 g2_7 g2_8 	///
					g2_9 g2_10 g2_11 g2_12 g2_13 g2_14 g2_15 intrahh_7bis2 intrahh_11bis2				///
					source_info_internalbis2 source_info2_internbis2 distance_dispensaire  distance_ecoleprim distance_ecolesec distance_eau ///
					distance_marche  distance_transpublic

					
					
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

foreach specification in between within spillovers{								// Loop over every specification (control group differ between those)

	
	* Define local specific to specification
	
	if "`specification'" == "between"{
	local prg_condition = "between"
	local trt_indicator = "beneficiaire"
	local spec_prefix 	= "IAaS"
	}
	
	if "`specification'" == "within"{
	local prg_condition = "within"
	local trt_indicator = "program"
	local spec_prefix 	= "IBaS"
	}
	
	if "`specification'" == "spillovers"{
	local prg_condition = "spillovers"
	local trt_indicator = "beneficiaire"
	local spec_prefix 	= "ICbS"
	}

	* Loop over every outcomes group
	
	foreach group_outcomes of local Index_ALL{
		
		* Create local used to store variable name to sum later 
		
		local sum_`group_outcomes' 		 ""
		local var_num_`group_outcomes' = 0
		
		* Loop over every individual outcomes
		
		foreach indiv_outcomes of local `group_outcomes'{
		
			* Create control mean of individual outcomes
			
			sum `indiv_outcomes' 					if `trt_indicator' == 0 & `prg_condition' ==1
			
			gen mean_`indiv_outcomes' = `r(mean)'	if `prg_condition' == 1
			
			* Create control standard deviaiton 
			
			sum `indiv_outcomes' 					if `trt_indicator' == 0 & `prg_condition' ==1
			
			gen sd_`indiv_outcomes' = `r(sd)' 		if `prg_condition' == 1
		
			* Normalize individual outcome 
			
			gen norm_`indiv_outcomes' = (`indiv_outcomes' - mean_`indiv_outcomes') / sd_`indiv_outcomes' if `prg_condition' ==1
			
			* Fill local with variable name used later to sum all standardize outcomes
			
			local sum_`group_outcomes' "`sum_`group_outcomes'' norm_`indiv_outcomes'"
			
			* Fill local with variable counter 
			
			local var_num_`group_outcomes' = `var_num_`group_outcomes'' + 1
	
		}
		
		* Sum all standardize variable of relevant outcome group
		
		egen `spec_prefix'`group_outcomes' = rowtotal(`sum_`group_outcomes'') if `prg_condition' ==1, missing 
		
		* Divide by the number of variable in outcomes group_outcomes
		
		replace `spec_prefix'`group_outcomes' = (`spec_prefix'`group_outcomes'/`var_num_`group_outcomes'') if `prg_condition' == 1
		
		* Clean variables created
		
		drop mean_*
		drop sd_*
		drop norm_*
	
	}
	
	* Label index 
	
					 
	label variable `spec_prefix'food_consump_win 		"Food Consumption"
	label variable `spec_prefix'expenditure_win 		"Other Expenditure"
	label variable `spec_prefix'coping_mechanisms 		"Coping Mechanisms"
	label variable `spec_prefix'hh_assets2 				"HH Assets"
	*label variable `spec_prefix'house_ownership		"House Ownership"
	*label variable `spec_prefix'large_assets 			"Large Assets"
	*label variable `spec_prefix'small_assets 			"Small Assets"
	*label variable `spec_prefix'home_assets 			"Home Assets"
	*label variable `spec_prefix'comms_assets 			"Communications Assets"
	*label variable `spec_prefix'productive_assets 		"Productive Assets"
	label variable `spec_prefix'human_capital2 			"Human Capital"
	label variable `spec_prefix'wage_employment2		"Wage Employment"
	label variable `spec_prefix'other_employment		"Other Employment"
	*label variable `spec_prefix'non_agri_enterp 		"Non-Agricultural Enterprise"
	*label variable `spec_prefix'debts_and_savings2 	"Debts and Savings"
	label variable `spec_prefix'debts				 	"Debts"
	label variable `spec_prefix'savings 				"Savings"
	*label variable `spec_prefix'employ_aspirations 	"Employment Aspirations"
	label variable `spec_prefix'service_access 			"Access to services"
	label variable `spec_prefix'social_cohesion2 		"Social Cohesion"
	*label variable `spec_prefix'comm_groups 			"Community Groups"
	*label variable `spec_prefix'local_conflict 		"Local Conflict"
	*label variable `spec_prefix'recent_migration		"Recent Migration"
	*label variable `spec_prefix'local_security 		"Local Security"
	label variable `spec_prefix'civic_engag 			"Civic Engagement"
	*label variable `spec_prefix'initiatives 			"Local Participation"
	*label variable `spec_prefix'initiatives_meeting 	"Local Meeting"
	*label variable `spec_prefix'initiatives_acting		"Local Acting"
	*label variable `spec_prefix'information_sources 	"Information Sources"
	*label variable `spec_prefix'utopia 				"Liberal Norms"
	*label variable `spec_prefix'isolation 				"Isolation"
	label variable `spec_prefix'psycho_wellbeing2 		"Psychological Wellbeing"	
	*label variable `spec_prefix'pearlin_index 			"Pearlin Index"
	*label variable `spec_prefix'overall_intrahouse2 	"Intrahousehold Dynamics"
	label variable `spec_prefix'womens_decision 		"Female Decisionmaking"
	label variable `spec_prefix'violence_ag_women 		"Violence against Women"
	*label variable `spec_prefix'psycho_internal 		"Internal Wellbeing"
	*label variable `spec_prefix'psycho_external		"External Wellbeing"
}

********************************************************************************
********************************************************************************
* 4) APPLY LAST CORRECTION AND SAVE DATA 
********************************************************************************
********************************************************************************

*delete temporary variables
foreach var of varlist	c3_a_1_win6 c3_a_2_win6 c3_a_3_win c3_a_4_win5 c3_a_5_win5 c3_a_6_win5 c3_a_7_win5 	///
						c3_a_8_win5 c3_a_9_win c3_a_10_win c3_a_11_win5 exp_food_win c4_win c5_win5 c6_win5 ///
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

	local sign 			emploi_comp_inut conflit_dispute_in conflit_dispute_out migration_cm_q1 migration_q1 ///
						security_dummy securite_1 securite_2 securite_3 securite_4 securite_5 securite_6 	///
						utopie_a_dum3 utopie_b_dum3 isolation_dummy psy_anxiete psy_exploit 				///
						psy_depress5 psy_accepte_dum1 psy_a_menage_dum1 source_info_internal source_info2_internal	///
						pearlin_2 pearlin_3 intrahh_7 intrahh_11 violence_1_2 violence_1_3 violence_1_4 	///
						violence_1_5 violence_1_6 violence_1_7 violence_1_8 violence_1_9 violence_1_10 		///
						violence_1_11 violence_1_16 violence_1_17 violence_1_18	violence_physical 			///
						violence_emotional pearlin_7 epargne_dette epargne_dette_cb_win g2_1 g2_2 g2_3 g2_4 ///
						g2_5 g2_6 g2_7 g2_8 g2_9 g2_10 g2_11 g2_12 g2_13 g2_14 g2_15


	foreach signvar of local sign  {
	rename 	`signvar'	  	`signvar'_convert 
	rename	`signvar'I 		`signvar'
	}

save "$stata/enquete_All3", replace

