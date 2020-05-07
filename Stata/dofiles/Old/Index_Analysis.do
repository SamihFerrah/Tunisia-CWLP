*AJOUTER LES INDEX À L'ANALYSE

set matsize 10000

*ADD THE VARIABLE: RECEIVED A PWP PREVIOUSLY OR NOT.

*all indiv outcomes, in order of category. with repetition for rev_total and psych_a_menage

sum IAa*

sum ///
					IAafood_consump_win IAaexpenditure_win IAacoping_mechanisms IAahh_assets2 IAahouse_ownership		///
					IAalarge_assets IAasmall_assets IAahome_assets IAacomms_assets IAaproductive_assets IAahuman_capital2 ///
					IAawage_employment2 /*IAaother_employment*/ IAanon_agri_enterp /*IAaagri_prod_income*/ IAadebts_and_savings2 ///
					IAadebts IAasavings																						///
					IAaemploy_aspirations IAasocial_cohesion2 IAacomm_groups IAalocal_conflict IAarecent_migration		///
					IAalocal_security IAacivic_engag IAainitiatives IAainitiatives_meeting IAainitiatives_acting		///
					IAainformation_sources IAautopia IAaisolation IAapsycho_wellbeing2 IAapsycho_internal IAapsycho_external ///
					IAapearlin_index IAaoverall_intrahouse2 IAawomens_decision IAaviolence_ag_women 
					

local IndexAa ///
					IAafood_consump_win IAaexpenditure_win IAacoping_mechanisms IAahh_assets2 IAahouse_ownership		///
					IAalarge_assets IAasmall_assets IAahome_assets IAacomms_assets IAaproductive_assets IAahuman_capital2 ///
					IAawage_employment2 IAaother_employment /*IAanon_agri_enterp IAaagri_prod_income*/ IAadebts_and_savings2 ///
					IAadebts IAasavings																						///
					IAaemploy_aspirations IAasocial_cohesion2 IAacomm_groups IAalocal_conflict IAarecent_migration		///
					IAalocal_security IAacivic_engag IAainitiatives IAainitiatives_meeting IAainitiatives_acting		///
					IAainformation_sources IAautopia IAaisolation IAapsycho_wellbeing2 IAapsycho_internal IAapsycho_external ///
					IAapearlin_index IAaoverall_intrahouse2 IAawomens_decision IAaviolence_ag_women 

sum ///
					IBafood_consump_win IBaexpenditure_win IBacoping_mechanisms IBahh_assets2 IBahouse_ownership		///
					IBalarge_assets IBasmall_assets IBahome_assets IBacomms_assets IBaproductive_assets IBahuman_capital2 ///
					IBawage_employment2 IBaother_employment IBanon_agri_enterp /*IBaagri_prod_income*/ IBadebts_and_savings2 ///
					IBadebts IBasavings																						///
					IBaemploy_aspirations IBasocial_cohesion2 IBacomm_groups IBalocal_conflict IBarecent_migration		///
					IBalocal_security IBacivic_engag IBainitiatives IBainitiatives_meeting IBainitiatives_acting		///
					IBainformation_sources IBautopia IBaisolation IBapsycho_wellbeing2 IBapsycho_internal IBapsycho_external ///
					IBapearlin_index IBaoverall_intrahouse2 IBawomens_decision IBaviolence_ag_women 
local IndexBa ///
					IBafood_consump_win IBaexpenditure_win IBacoping_mechanisms IBahh_assets2 IBahouse_ownership		///
					IBalarge_assets IBasmall_assets IBahome_assets IBacomms_assets IBaproductive_assets IBahuman_capital2 ///
					IBawage_employment2 IBaother_employment /*IBanon_agri_enterp IBaagri_prod_income*/ IBadebts_and_savings2 ///
					IBadebts IBasavings																						///
					IBaemploy_aspirations IBasocial_cohesion2 IBacomm_groups IBalocal_conflict IBarecent_migration		///
					IBalocal_security IBacivic_engag IBainitiatives IBainitiatives_meeting IBainitiatives_acting		///
					IBainformation_sources IBautopia IBaisolation IBapsycho_wellbeing2 IBapsycho_internal IBapsycho_external ///
					IBapearlin_index IBaoverall_intrahouse2 IBawomens_decision IBaviolence_ag_women 

sum ///
					IBbfood_consump_win IBbexpenditure_win IBbcoping_mechanisms IBbhh_assets2 IBbhouse_ownership		///
					IBblarge_assets IBbsmall_assets IBbhome_assets IBbcomms_assets IBbproductive_assets IBbhuman_capital2 ///
					IBbwage_employment2 IBbother_employment /*IBbnon_agri_enterp IBbagri_prod_income*/ IBbdebts_and_savings2 ///
					IBbdebts IBbsavings																						///
					IBbemploy_aspirations IBbsocial_cohesion2 IBbcomm_groups IBblocal_conflict IBbrecent_migration		///
					IBblocal_security IBbcivic_engag IBbinitiatives IBbinitiatives_meeting IBbinitiatives_acting		///
					IBbinformation_sources IBbutopia IBbisolation IBbpsycho_wellbeing2 IBbpsycho_internal IBbpsycho_external ///
					IBbpearlin_index IBboverall_intrahouse2 IBbwomens_decision IBbviolence_ag_women 

local IndexBb ///
					IBbfood_consump_win IBbexpenditure_win IBbcoping_mechanisms IBbhh_assets2 IBbhouse_ownership		///
					IBblarge_assets IBbsmall_assets IBbhome_assets IBbcomms_assets IBbproductive_assets IBbhuman_capital2 ///
					IBbwage_employment2 IBbother_employment /*IBbnon_agri_enterp IBbagri_prod_income*/ IBbdebts_and_savings2 ///
					IBbdebts IBbsavings																						///
					IBbemploy_aspirations IBbsocial_cohesion2  IBbcomm_groups IBblocal_conflict IBbrecent_migration		///
					IBblocal_security IBbcivic_engag IBbinitiatives IBbinitiatives_meeting IBbinitiatives_acting		///
					IBbinformation_sources IBbutopia IBbisolation IBbpsycho_wellbeing2 IBbpsycho_internal IBbpsycho_external ///
					IBbpearlin_index IBboverall_intrahouse2 IBbwomens_decision IBbviolence_ag_women 
sum ///
					ICafood_consump_win ICaexpenditure_win ICacoping_mechanisms ICahh_assets2 ICahouse_ownership		///
					ICalarge_assets ICasmall_assets ICahome_assets ICacomms_assets ICaproductive_assets ICahuman_capital2 ///
					ICawage_employment2 ICaother_employment /*ICanon_agri_enterp IACagri_prod_income*/ ICadebts_and_savings2 ///
					ICadebts ICasavings																						///
					ICaemploy_aspirations ICasocial_cohesion2 ICacomm_groups ICalocal_conflict ICarecent_migration		///
					ICalocal_security ICacivic_engag ICainitiatives ICainitiatives_meeting ICainitiatives_acting		///
					ICainformation_sources ICautopia ICaisolation ICapsycho_wellbeing2 ICapsycho_internal ICapsycho_external ///
					ICapearlin_index ICaoverall_intrahouse2 ICawomens_decision ICaviolence_ag_women 
local IndexCa ///
					ICafood_consump_win ICaexpenditure_win ICacoping_mechanisms ICahh_assets2 ICahouse_ownership		///
					ICalarge_assets ICasmall_assets ICahome_assets ICacomms_assets ICaproductive_assets ICahuman_capital2 ///
					ICawage_employment2 ICaother_employment /*ICanon_agri_enterp ICaagri_prod_income*/ ICadebts_and_savings2 ///
					ICadebts ICasavings																						///
					ICaemploy_aspirations ICasocial_cohesion2 ICacomm_groups ICalocal_conflict ICarecent_migration		///
					ICalocal_security ICacivic_engag ICainitiatives ICainitiatives_meeting ICainitiatives_acting		///
					ICainformation_sources ICautopia ICaisolation ICapsycho_wellbeing2 ICapsycho_internal ICapsycho_external ///
					ICapearlin_index ICaoverall_intrahouse2 ICawomens_decision ICaviolence_ag_women 
sum ///
					ICbfood_consump_win ICbexpenditure_win ICbcoping_mechanisms ICbhh_assets2 ICbhouse_ownership		///
					ICblarge_assets ICbsmall_assets ICbhome_assets ICbcomms_assets ICbproductive_assets ICbhuman_capital2 ///
					ICbwage_employment2 ICbother_employment /*ICbnon_agri_enterp ICbagri_prod_income*/ ICbdebts_and_savings2 ///
					ICbdebts ICbsavings																						///
					ICbemploy_aspirations ICbsocial_cohesion2 ICbcomm_groups ICblocal_conflict ICbrecent_migration		///
					ICblocal_security ICbcivic_engag ICbinitiatives ICbinitiatives_meeting ICbinitiatives_acting		///
					ICbinformation_sources ICbutopia ICbisolation ICbpsycho_wellbeing2  ICbpsycho_internal ICbpsycho_external ///
					ICbpearlin_index ICboverall_intrahouse2 ICbwomens_decision ICbviolence_ag_women

local IndexCb ///
					ICbfood_consump_win ICbexpenditure_win ICbcoping_mechanisms ICbhh_assets2 ICbhouse_ownership		///
					ICblarge_assets ICbsmall_assets ICbhome_assets ICbcomms_assets ICbproductive_assets ICbhuman_capital2 ///
					ICbwage_employment2 ICbother_employment /*ICbnon_agri_enterp ICbagri_prod_income*/ ICbdebts_and_savings2 ///
					ICbdebts ICbsavings																						///
					ICbemploy_aspirations ICbsocial_cohesion2 ICbcomm_groups ICblocal_conflict ICbrecent_migration		///
					ICblocal_security ICbcivic_engag ICbinitiatives ICbinitiatives_meeting ICbinitiatives_acting		///
					ICbinformation_sources ICbutopia ICbisolation ICbpsycho_wellbeing2  ICbpsycho_internal ICbpsycho_external ///
					ICbpearlin_index ICboverall_intrahouse2 ICbwomens_decision ICbviolence_ag_women

local all3 `IndexAa' `IndexBa' `IndexBb' `IndexCa' `IndexCb'
							


*controls:ADJUSTED TO REFLECT THE ONES THAT ARE NOT BALANCED.

local ctrl_Aa hhsize drepondant_mat
local ctrl_Ba extra 
local ctrl_Bb extra repondant_sex
local ctrl_Ca //none
local ctrl_Cb hhsize

local ctrl_Aa_PWP hhsize drepondant_mat
local ctrl_Ba_PWP extra
local ctrl_Bb_PWP extra repondant_sex

local ctrl_Aa_gender hhsize drepondant_mat
local ctrl_Ba_gender extra
local ctrl_Bb_gender extra repondant_sex

local ctrl_Aa_prev_PWP hhsize drepondant_mat
local ctrl_Ba_prev_PWP extra
local ctrl_Bb_prev_PWP extra repondant_sex

*CREATE DATASETS FOR ANALYSIS FROM MULTIPLE IMPUTATION
use $stata/enquete_All3, clear 


*************************************
*ANALYSIS
*************************************
/*
We have six "types" of individuals in our sample
1)      Workers on the ‘nominative lists’ (primary list of replacement lists) who were randomized into the program and ended up working
2)      Workers on the ‘nominative lists’ (primary list of replacement lists) who were randomized into the program and ended up not working (les desistes)
3)      Workers on the ‘nominative lists’ (primary list of replacement lists) who were randomized out of the program
4)      Representative random samples of individuals from treatment imadas
5)       Representative random samples of individuals from control imadas
6)      Eligible and randomly selected workers from control imadas (i.e., synthestic controls)

A)      Between villages effects on the workers:
a.      ITT: [(1) + (2)] vs (6)

B)      Within village effects on the workers:
a.      ITT: [(1) + (2)] vs (3)
b.      ATE: (1) vs (3)

C)      Spillover effects (two types)
a.      (4) vs (5)
b.      (3) vs (6)

D)     Heterogeneous effects
a.      Re-run Aa and Ab separately for subsamples stratify by the key program-related or contextual variables we decide on.
b.      Re-run Ba and Bb separately for subsamples stratify by the key program-related or contextual variables we decide on.
*/

/*
OLS WITH AND WITHOUT CONTROLS.
model for continous
model for binaries(2): OLS + GLM
model for censored: OLS and TOBIT(dit si nul ou non nul).
*/



*******[SUMMARY TABLE  - INDEX ANALYSES]******


label variable IAafood_consump_win 		"Food Consumption"
label variable IAaexpenditure_win 		"Other Expenditure"
label variable IAacoping_mechanisms 	"Coping Mechanisms"
label variable IAahh_assets2 			"HH Assets"
label variable IAahouse_ownership		"House Ownership"
label variable IAalarge_assets 			"Large Assets"
label variable IAasmall_assets 			"Small Assets"
label variable IAahome_assets 			"Home Assets"
label variable IAacomms_assets 			"Communications Assets"
label variable IAaproductive_assets 	"Productive Assets"
label variable IAahuman_capital2 		"Human Capital"
label variable IAawage_employment2		"Wage Employment"
label variable IAaother_employment		"Other Employment"
*label variable IAanon_agri_enterp 		"Non-Agricultural Enterprise"
label variable IAadebts_and_savings2 	"Debts and Savings"
label variable IAadebts				 	"Debts"
label variable IAasavings 				"Savings"
label variable IAaemploy_aspirations 	"Employment Aspirations"
label variable IAasocial_cohesion2 		"Social Cohesion"
label variable IAacomm_groups 			"Community Groups"
label variable IAalocal_conflict 		"Local Conflict"
label variable IAarecent_migration		"Recent Migration"
label variable IAalocal_security 		"Local Security"
label variable IAacivic_engag 			"Civic Engagement"
label variable IAainitiatives 			"Local Participation"
label variable IAainitiatives_meeting 	"Local Meeting"
label variable IAainitiatives_acting	"Local Acting"
label variable IAainformation_sources 	"Information Sources"
label variable IAautopia 				"Liberal Norms"
label variable IAaisolation 			"Isolation"
label variable IAapsycho_wellbeing2 	"Psychological Wellbeing"	
label variable IAapearlin_index 		"Pearlin Index"
label variable IAaoverall_intrahouse2 	"Intrahousehold Dynamics"
label variable IAawomens_decision 		"Female Decisionmaking"
label variable IAaviolence_ag_women 	"Violence against Women"
label variable IAapsycho_internal 		"Internal Wellbeing"
label variable IAapsycho_external		"External Wellbeing"

*Between
					
		estimates clear
		preserve 
		keep if (parti==1 | desist==1 | enquete==3) 

		local RAa ""
		foreach outcome of varlist `IndexAa' {
		regress `outcome' beneficiaire `ctrl_Aa', vce (cluster imada)
		local varlbl : variable label `outcome'	
		local varlbl = subinstr("`varlbl'", " " , "_" , .)
		di "`varlbl'"
		estimates store `varlbl'
		local RAa `RAa' `varlbl'
		
		estadd scalar Control_Mean= _b[_cons]	

		}
								estout `RAa'	using	"$report\Index_Analysis.xls", 		replace 							///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(hhsize drepondant_mat _cons) 	///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)		collabels(none)		label	///
								title			("Between Villages: direct effects on all workers")								///
								varlabels		(beneficiaire "Treatment Community") 

																																	//can we put title under variable name?
																																	//label columns with index name
																																	//negative number SEs in Excel rather than parentheses??
		estimates clear
		restore


		estimates clear
		
*Within (ITT)

		gen program=(parti==1 | desist==1)
	
		preserve
		keep if (parti==1 | desist==1 | control==1) 
		local RBa ""
		foreach outcome of varlist `IndexBa' {
		regres `outcome' program `ctrl_Ba', vce (cluster imada)
		estimates store RBa`outcome'
		local RBa `RBa' RBa`outcome'
		
		estadd scalar Control_Mean= _b[_cons]	
		}
								estout `RBa'	using	"$report\Index_Analysis.xls", 		append 								///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(extra _cons)	label 			///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)	collabels(none) mlabels(none) 	///
								title			("Within Villages: direct effects on all workers") varlabels(program "Worker")
		estimates clear	
		restore

*Within (ATE)
		estimates clear
		preserve
		keep if (parti==1 | control==1)
		local RBb ""
		foreach outcome of varlist `IndexBb' {
		regres `outcome' parti `ctrl_Bb', vce (cluster imada)
		estimates store RBb`outcome'
		local RBb `RBb' RBb`outcome'

		estadd scalar Control_Mean= _b[_cons]	
		}
								estout `RBb'	using	"$report\Index_Analysis.xls", 		append 									///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))	drop(extra repondant_sex _cons) 	label	///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)	collabels(none) mlabels(none) 		///
								title			("Within Villages: direct effects on PWP completers") 								///
								varlabels		(parti "PWP completer")
		estimates clear	
		restore

*Infrastructure

		estimates clear
		preserve
		keep if enquete==1
		local RCa ""
		foreach outcome of varlist `IndexCa' {
		regres `outcome' beneficiaire `ctrl_Ca', vce (cluster imada)
		estimates store RCa`outcome'
		local RCa `RCa' RCa`outcome'
		
		estadd scalar Control_Mean= _b[_cons]	
		}

								estout `RCa'	using	"$report\Index_Analysis.xls", 		append 								///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))	drop(_cons)			label				///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)	collabels(none) mlabels(none) 	///
								title			("Infrastructure Effects")		varlabels(beneficiaire "Treatment Community")
		estimates clear
		restore

*Spillovers

		estimates clear
		preserve
		keep if (control==1 | enquete==3)
		local RCb ""
		foreach outcome of varlist `IndexCb' {
		regres `outcome' beneficiaire `ctrl_Cb', vce (cluster imada)
		estimates store RCb`outcome'
		local RCb `RCb' RCb`outcome'
		
		estadd scalar Control_Mean= _b[_cons]	
		}
								estout `RCb'	using	"$report\Index_Analysis.xls", 				append						///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(hhsize _cons)	label 			///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)	collabels(none) mlabels(none) 	///
								title			("Spillover Effects")		varlabels(beneficiaire "Treatment Community") 		///
								note("OLS regressions on standardized indices with robust standard errors clustered at the imada level")													
						   			
		estimates clear
		restore

		filefilter "$report/Index_Analysis.xls" "$report/0Index_Analysis.xls", from("_") to(" ") replace


*/
************************************************************************************************************
*THEN CHANGE THE VARIABLES MADE POSITIVE FOR INDICES AROUND AGAIN
*And make logs for the analysis
************************************************************************************************************
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
