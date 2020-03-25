*AJOUTER LES INDEX À L'ANALYSE

set matsize 10000
set more off

*******[SUMMARY TABLE  - INDEX ANALYSES]******
*******[TABLE 1 - FOOD CONSUMPTION ANALYSIS]******
*******[TABLE 2 - EXPENDITURE ANALYSIS]******
*******[TABLE 3 - COPING MECHANISMS]******
*******[TABLE 4 - HOUSEHOLD ASSETS]******
*******[TABLE 5 - HUMAN CAPITAL]******
*******[TABLE 6 - WAGE EMPLOYMENT]******
*******[TABLE 7 - DEBTS AND SAVINGS]******
*******[TABLE 8 - SOCIAL COHESION]******
*******[TABLE 9 - CIVIC ENGAGEMENT]******
*******[TABLE 10 - PSYCHOICAL WELLBEING]******
*******[TABLE 11 - INTRAHOUSEHOLD ALLOCATIONS]******
*******[TABLE 12 - VIOLENCE AGAINST WOMEN]******


*CREATE DATASETS FOR ANALYSIS FROM MULTIPLE IMPUTATION
use "$stata/enquete_All3", clear 


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
					/*IAapearlin_index*/ IAaoverall_intrahouse2 IAawomens_decision IAaviolence_ag_women
					

local IndexAa ///
					IAafood_consump_win IAaexpenditure_win IAacoping_mechanisms IAahh_assets2 IAahouse_ownership		///
					IAalarge_assets IAasmall_assets IAahome_assets IAacomms_assets IAaproductive_assets IAahuman_capital2 ///
					IAawage_employment2 IAaother_employment /*IAanon_agri_enterp IAaagri_prod_income*/ IAadebts_and_savings2 ///
					IAadebts IAasavings																						///
					IAaemploy_aspirations IAasocial_cohesion2 IAacomm_groups IAalocal_conflict IAarecent_migration		///
					IAalocal_security IAacivic_engag IAainitiatives IAainitiatives_meeting IAainitiatives_acting		///
					IAainformation_sources IAautopia IAaisolation IAapsycho_wellbeing2 IAapsycho_internal IAapsycho_external ///
					/*IAapearlin_index*/ IAaoverall_intrahouse2 IAawomens_decision IAaviolence_ag_women 
					

sum ///
					IBafood_consump_win IBaexpenditure_win IBacoping_mechanisms IBahh_assets2 IBahouse_ownership		///
					IBalarge_assets IBasmall_assets IBahome_assets IBacomms_assets IBaproductive_assets IBahuman_capital2 ///
					IBawage_employment2 IBaother_employment IBanon_agri_enterp /*IBaagri_prod_income*/ IBadebts_and_savings2 ///
					IBadebts IBasavings																						///
					IBaemploy_aspirations IBasocial_cohesion2 IBacomm_groups IBalocal_conflict IBarecent_migration		///
					IBalocal_security IBacivic_engag IBainitiatives IBainitiatives_meeting IBainitiatives_acting		///
					IBainformation_sources IBautopia IBaisolation IBapsycho_wellbeing2 IBapsycho_internal IBapsycho_external ///
					/*IBapearlin_index*/ IBaoverall_intrahouse2 IBawomens_decision IBaviolence_ag_women 
					
local IndexBa ///
					IBafood_consump_win IBaexpenditure_win IBacoping_mechanisms IBahh_assets2 IBahouse_ownership		///
					IBalarge_assets IBasmall_assets IBahome_assets IBacomms_assets IBaproductive_assets IBahuman_capital2 ///
					IBawage_employment2 IBaother_employment /*IBanon_agri_enterp IBaagri_prod_income*/ IBadebts_and_savings2 ///
					IBadebts IBasavings																						///
					IBaemploy_aspirations IBasocial_cohesion2 IBacomm_groups IBalocal_conflict IBarecent_migration		///
					IBalocal_security IBacivic_engag IBainitiatives IBainitiatives_meeting IBainitiatives_acting		///
					IBainformation_sources IBautopia IBaisolation IBapsycho_wellbeing2 IBapsycho_internal IBapsycho_external ///
					/*IBapearlin_index*/ IBaoverall_intrahouse2 IBawomens_decision IBaviolence_ag_women 

sum ///
					IBbfood_consump_win IBbexpenditure_win IBbcoping_mechanisms IBbhh_assets2 IBbhouse_ownership		///
					IBblarge_assets IBbsmall_assets IBbhome_assets IBbcomms_assets IBbproductive_assets IBbhuman_capital2 ///
					IBbwage_employment2 IBbother_employment /*IBbnon_agri_enterp IBbagri_prod_income*/ IBbdebts_and_savings2 ///
					IBbdebts IBbsavings																						///
					IBbemploy_aspirations IBbsocial_cohesion2 IBbcomm_groups IBblocal_conflict IBbrecent_migration		///
					IBblocal_security IBbcivic_engag IBbinitiatives IBbinitiatives_meeting IBbinitiatives_acting		///
					IBbinformation_sources IBbutopia IBbisolation IBbpsycho_wellbeing2 IBbpsycho_internal IBbpsycho_external ///
					/*IBbpearlin_index*/ IBboverall_intrahouse2 IBbwomens_decision IBbviolence_ag_women  

local IndexBb ///
					IBbfood_consump_win IBbexpenditure_win IBbcoping_mechanisms IBbhh_assets2 IBbhouse_ownership		///
					IBblarge_assets IBbsmall_assets IBbhome_assets IBbcomms_assets IBbproductive_assets IBbhuman_capital2 ///
					IBbwage_employment2 IBbother_employment /*IBbnon_agri_enterp IBbagri_prod_income*/ IBbdebts_and_savings2 ///
					IBbdebts IBbsavings																						///
					IBbemploy_aspirations IBbsocial_cohesion2  IBbcomm_groups IBblocal_conflict IBbrecent_migration		///
					IBblocal_security IBbcivic_engag IBbinitiatives IBbinitiatives_meeting IBbinitiatives_acting		///
					IBbinformation_sources IBbutopia IBbisolation IBbpsycho_wellbeing2 IBbpsycho_internal IBbpsycho_external ///
					/*IBbpearlin_index*/ IBboverall_intrahouse2 IBbwomens_decision IBbviolence_ag_women 
sum ///
					ICafood_consump_win ICaexpenditure_win ICacoping_mechanisms ICahh_assets2 ICahouse_ownership		///
					ICalarge_assets ICasmall_assets ICahome_assets ICacomms_assets ICaproductive_assets ICahuman_capital2 ///
					ICawage_employment2 ICaother_employment /*ICanon_agri_enterp IACagri_prod_income*/ ICadebts_and_savings2 ///
					ICadebts ICasavings																						///
					ICaemploy_aspirations ICasocial_cohesion2 ICacomm_groups ICalocal_conflict ICarecent_migration		///
					ICalocal_security ICacivic_engag ICainitiatives ICainitiatives_meeting ICainitiatives_acting		///
					ICainformation_sources ICautopia ICaisolation ICapsycho_wellbeing2 ICapsycho_internal ICapsycho_external ///
					/*ICapearlin_index*/ ICaoverall_intrahouse2 ICawomens_decision ICaviolence_ag_women 
local IndexCa ///
					ICafood_consump_win ICaexpenditure_win ICacoping_mechanisms ICahh_assets2 ICahouse_ownership		///
					ICalarge_assets ICasmall_assets ICahome_assets ICacomms_assets ICaproductive_assets ICahuman_capital2 ///
					ICawage_employment2 ICaother_employment /*ICanon_agri_enterp ICaagri_prod_income*/ ICadebts_and_savings2 ///
					ICadebts ICasavings																						///
					ICaemploy_aspirations ICasocial_cohesion2 ICacomm_groups ICalocal_conflict ICarecent_migration		///
					ICalocal_security ICacivic_engag ICainitiatives ICainitiatives_meeting ICainitiatives_acting		///
					ICainformation_sources ICautopia ICaisolation ICapsycho_wellbeing2 ICapsycho_internal ICapsycho_external ///
					/*ICapearlin_index*/ ICaoverall_intrahouse2 ICawomens_decision ICaviolence_ag_women 
sum ///
					ICbfood_consump_win ICbexpenditure_win ICbcoping_mechanisms ICbhh_assets2 ICbhouse_ownership		///
					ICblarge_assets ICbsmall_assets ICbhome_assets ICbcomms_assets ICbproductive_assets ICbhuman_capital2 ///
					ICbwage_employment2 ICbother_employment /*ICbnon_agri_enterp ICbagri_prod_income*/ ICbdebts_and_savings2 ///
					ICbdebts ICbsavings																						///
					ICbemploy_aspirations ICbsocial_cohesion2 ICbcomm_groups ICblocal_conflict ICbrecent_migration		///
					ICblocal_security ICbcivic_engag ICbinitiatives ICbinitiatives_meeting ICbinitiatives_acting		///
					ICbinformation_sources ICbutopia ICbisolation ICbpsycho_wellbeing2  ICbpsycho_internal ICbpsycho_external ///
					/*ICbpearlin_index*/ ICboverall_intrahouse2 ICbwomens_decision ICbviolence_ag_women 
local IndexCb ///
					ICbfood_consump_win ICbexpenditure_win ICbcoping_mechanisms ICbhh_assets2 ICbhouse_ownership		///
					ICblarge_assets ICbsmall_assets ICbhome_assets ICbcomms_assets ICbproductive_assets ICbhuman_capital2 ///
					ICbwage_employment2 ICbother_employment /*ICbnon_agri_enterp ICbagri_prod_income*/ ICbdebts_and_savings2 ///
					ICbdebts ICbsavings																						///
					ICbemploy_aspirations ICbsocial_cohesion2 ICbcomm_groups ICblocal_conflict ICbrecent_migration		///
					ICblocal_security ICbcivic_engag ICbinitiatives ICbinitiatives_meeting ICbinitiatives_acting		///
					ICbinformation_sources ICbutopia ICbisolation ICbpsycho_wellbeing2  ICbpsycho_internal ICbpsycho_external ///
					/*ICbpearlin_index*/ ICboverall_intrahouse2 ICbwomens_decision ICbviolence_ag_women 
					
					
local all3 `IndexAa' `IndexBa' `IndexBb' `IndexCa' `IndexCb'
							


*controls:ADJUSTED TO REFLECT THE ONES THAT ARE NOT BALANCED.

local ctrl_Aa hhsize drepondant_mat g1_3 g1_4 g1_5 g1_7
local ctrl_Ba extra 
local ctrl_Bb extra repondant_sex
local ctrl_Ca //none
local ctrl_Cb hhsize g1_4


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
*label variable IAapearlin_index 		"Pearlin Index"
label variable IAaoverall_intrahouse2 	"Intrahousehold Dynamics"
label variable IAawomens_decision 		"Female Decisionmaking"
label variable IAaviolence_ag_women 	"Violence against Women"
label variable IAapsycho_internal 		"Internal Wellbeing"
label variable IAapsycho_external		"External Wellbeing"


label variable hhsize 					"Number of household member"
label variable drepondant_mat 			"Marital Status 1)Unmarried 0)Married" 
label variable g1_3 					"Serious illness of head" 
label variable g1_4 					"Serious illness of other household members" 
label variable g1_5 					"Loss of employment"
label variable g1_7 					"Failure to harvest" 
label variable extra 					"Obs from second randomization"
label variable repondant_sex			"Respondent gender"

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
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(hhsize drepondant_mat g1_3 g1_4 g1_5 g1_7 _cons) 	///			 	 					
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
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(hhsize g1_4 _cons)	label 			///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)	collabels(none) mlabels(none) 	///
								title			("Spillover Effects")		varlabels(beneficiaire "Treatment Community") 		///
								note("OLS regressions on standardized indices with robust standard errors clustered at the imada level")													
						   			
		estimates clear
		restore

		filefilter "$report/Index_Analysis.xls" "$report/0Index_Analysis.xls", from("_") to(" ") replace


*******[TABLE 1 - FOOD CONSUMPTION ANALYSIS]******


local food_consump_win 		c3_a_1_win6 c3_a_2_win6 c3_a_3_win c3_a_4_win5 c3_a_5_win5 c3_a_6_win5 c3_a_7_win5 	///
							c3_a_8_win5 c3_a_9_win c3_a_10_win c3_a_11_win5 

label variable c3_a_1_win6 			"Bread_and_Grains"		
label variable c3_a_2_win6 			"Pasta_and_Rice"
label variable c3_a_3_win 			"Fish"
label variable c3_a_4_win5 			"Meat"
label variable c3_a_5_win5 			"Egg_and_Dairy"
label variable c3_a_6_win5 			"Vegetables"
label variable c3_a_7_win5 			"Fruit"
label variable c3_a_8_win5 			"Oils"
label variable c3_a_9_win 			"Drinks"
label variable c3_a_10_win 			"Spices"
label variable c3_a_11_win5 		"Coffee_Tea_and_Tobacco"
label variable IAafood_consump_win 	"Food_Consumption_Index"


*Between

	estimates clear
	preserve 
	keep if (parti==1 | desist==1 | enquete==3) 

	local RAa ""
	foreach outcome of local food_consump_win			{
		regres `outcome'  beneficiaire `ctrl_Aa', vce(cluster imada)
	
	*column heading variable label
		local varlbl : variable label `outcome'
		local varlbl = subinstr("`varlbl'", " " , "_" , .)		
		di "`varlbl'"
		
		estimates store `varlbl'
		local RAa `RAa' `varlbl'
	*control mean non-logged 
		sum 	n`outcome' if beneficiaire == 0
		estadd scalar Control_Mean= r(mean)	


	}
	
		regres IAafood_consump_win beneficiaire `ctrl_Aa', vce (cluster imada)
		estimates store Food_Consumption_Index
		local RAa `RAa' Food_Consumption_Index
		*control mean	
			estadd scalar Control_Mean= _b[_cons]	


								estout `RAa'	using	"$report\Food_Consumption.xls", 		replace 				///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(hhsize drepondant_mat g1_3 g1_4 g1_5 g1_7 _cons)	label 	///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)		eqlabels(none) 	collabels(none) ///
								title			("Between Villages: direct effects on all workers")	varlabels(beneficiaire "Treatment Community") 
		estimates clear
		restore

*Within (ITT)
		
		estimates clear
		preserve
		keep if (parti==1 | desist==1 | control==1) 
		local RBa  ""
		local RBa2 ""
		foreach outcome of local food_consump_win			{
			regres `outcome' program `ctrl_Ba', vce (cluster imada)
			estimates store `outcome'
			local RBa `RBa' `outcome'
	*control mean non-logged 
		sum 	n`outcome' if program == 0
		estadd scalar Control_Mean= r(mean)	

		}
		regres IBafood_consump_win program `ctrl_Ba', vce (cluster imada)
		estimates store IBafood_consump_win
		local RBa `RBa' IBafood_consump_win
		*control mean	
			estadd scalar Control_Mean= _b[_cons]	


								estout `RBa'	using	"$report\Food_Consumption.xls", 		append 			///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(extra _cons)	label 			///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)	collabels(none) mlabels(none) eqlabels(none)	///
								title			("Within Villages: direct effects on all workers") varlabels(program "Worker")
								

		estimates clear	
		restore

*Within (ATE)

		estimates clear
		preserve
		keep if (parti==1 | control==1)
		local RBb ""
		foreach outcome of local food_consump_win			{
			regres `outcome' parti `ctrl_Bb', vce (cluster imada)
			estimates store `outcome'
			local RBb `RBb' `outcome'
	*control mean non-logged 
		sum 	n`outcome' if parti == 0
		estadd scalar Control_Mean= r(mean)	
	

		}
		regres IBbfood_consump_win parti `ctrl_Bb', vce (cluster imada)
		estimates store IBbfood_consump_win
		local RBb `RBb' IBbfood_consump_win
		*control mean	
			estadd scalar Control_Mean= _b[_cons]	


								estout `RBb'	using	"$report\Food_Consumption.xls", 		append 			///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(extra repondant_sex _cons)	label 			///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)	collabels(none) mlabels(none) eqlabels(none)	///
								title			("Within Villages: direct effects on PWP completers") varlabels(parti "PWP completer")
		estimates clear	
		restore

*Infrastructure

		estimates clear
		preserve
		keep if enquete==1
		local RCa ""
		foreach outcome of local food_consump_win			{
			regres `outcome'  beneficiaire `ctrl_Ca', vce(cluster imada)
			estimates store `outcome'
			local RCa `RCa' `outcome'
	*control mean non-logged 
		sum 	n`outcome' if beneficiaire == 0
		estadd scalar Control_Mean= r(mean)	


		}
		regres ICafood_consump_win beneficiaire `ctrl_Ca', vce (cluster imada)
		estimates store ICafood_consump_win
		local RCa `RCa' ICafood_consump_win
		*control mean	
			estadd scalar Control_Mean= _b[_cons]	


								estout `RCa'	using	"$report\Food_Consumption.xls", 		append 			///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		label 	drop(_cons)		///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)	collabels(none) mlabels(none) eqlabels(none) 	///
								title			("Infrastructure Effects")		varlabels(beneficiaire "Treatment Community")
		estimates clear
		restore

*Spillovers

		estimates clear
		preserve
		keep if (control==1 | enquete==3)
		local RCb ""
		foreach outcome of local food_consump_win			{
			regres `outcome'  beneficiaire `ctrl_Cb', vce(cluster imada)
			estimates store `outcome'
			local RCb `RCb' `outcome'
		
	*control mean non-logged 
		sum 	n`outcome' if beneficiaire == 0
		estadd scalar Control_Mean= r(mean)	


		}
		regres ICbfood_consump_win beneficiaire `ctrl_Cb', vce (cluster imada)
		estimates store ICbfood_consump_win
		local RCb `RCb' ICbfood_consump_win
		*control mean	
			estadd scalar Control_Mean= _b[_cons]	


								estout `RCb'	using	"$report\Food_Consumption.xls", 		append 							///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(hhsize g1_4 _cons)	label 					///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)	collabels(none) mlabels(none) 	///
								eqlabels(none) 	title("Spillover Effects")		varlabels(beneficiaire "Treatment Community")	///
								note("OLS regressions on logarithm of expenditure on different food items and on the standardized index of food expenditure. Clustered SE at the imada level." ///
								/*"Control means represent averages from the level consumption variable, not the logarithm"*/)													

		estimates clear
		restore

		filefilter "$report/Food_Consumption.xls" "$report/1Food_Consumption.xls", from("_") to(" ") replace

		
*******[TABLE 2 - EXPENDITURE ANALYSIS]******

local expenditure_win 		exp_food_win c4_win c5_win5 c6_win5 c7_win5 c8_win5 c9_win c11_win c12_win c13_win c14_win 
							
							
label variable exp_food_win 			"Food"		
label variable c4_win 					"Rent"
label variable c5_win5 					"Energy"
label variable c6_win5 					"Communicaitons"
label variable c7_win5 					"Toiletries"
label variable c8_win5 					"Transport"
label variable c9_win 					"Other Services"
label variable c11_win 					"Home Improvements"
label variable c12_win 					"Medical"
label variable c13_win 					"Education"
label variable c14_win 					"Clothes"
label variable c15_win					"Durable goods and HH Equipment"
label variable c16_win					"Tax and Insurance"
label variable c18_win					"Celebrations and Rituals"
label variable IAaexpenditure_win 		"Expenditure Index"


*Between

	estimates clear
	preserve 
	keep if (parti==1 | desist==1 | enquete==3) 	
	local RAa ""
	foreach outcome of local expenditure_win			{
		regres `outcome'  beneficiaire `ctrl_Aa', vce(cluster imada)
	
	*Column heading label variable	
		local varlbl : variable label `outcome'	
		local varlbl = subinstr("`varlbl'", " " , "_" , .)
		di "`varlbl'"
		
		estimates store `varlbl'
		local RAa `RAa' `varlbl'
	*control mean non-logged 
		sum 	n`outcome' if beneficiaire == 0
		estadd scalar Control_Mean= r(mean)	
	}
	
		regres IAaexpenditure_win beneficiaire `ctrl_Aa', vce (cluster imada)
		estimates store Expenditure_Index
		local RAa `RAa' Expenditure_Index
		*control mean	
			estadd scalar Control_Mean= _b[_cons]


								estout `RAa'	using	"$report\Expenditure.xls", 		replace 								///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(hhsize drepondant_mat g1_3 g1_4 g1_5 g1_7 _cons)	label 	///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)		eqlabels(none) 	collabels(none) ///
								title			("Between Villages: direct effects on all workers")	varlabels(_cons "Control Mean" beneficiaire "Treatment Community") 
		estimates clear
		restore
		
*Within (ITT)
		
		estimates clear
		preserve
		keep if (parti==1 | desist==1 | control==1) 
		local RBa ""
		foreach outcome of local expenditure_win			{
			regres `outcome' program `ctrl_Ba', vce (cluster imada)
			estimates store `outcome'
			local RBa `RBa' `outcome'
	*control mean non-logged 
		sum 	n`outcome' if program == 0
		estadd scalar Control_Mean= r(mean)	


		}
		regres IBaexpenditure_win program `ctrl_Ba', vce (cluster imada)
		estimates store IBaexpenditure_win
		local RBa `RBa' IBaexpenditure_win
		*control mean	
			estadd scalar Control_Mean= _b[_cons]	


								estout `RBa'	using	"$report\Expenditure.xls", 		append 			///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(extra _cons)	label 			///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)	collabels(none) mlabels(none) eqlabels(none)	///
								title			("Within Villages: direct effects on all workers") varlabels(_cons "Control Mean" program "Worker")
*Within (ATE)

		estimates clear	
		restore

		estimates clear
		preserve
		keep if (parti==1 | control==1)
		local RBb ""
		foreach outcome of local expenditure_win			{
			regres `outcome' parti `ctrl_Bb', vce (cluster imada)
			estimates store `outcome'
			local RBb `RBb' `outcome'
	*control mean non-logged 
		sum 	n`outcome' if parti == 0
		estadd scalar Control_Mean= r(mean)	

		}
		regres IBbexpenditure_win parti `ctrl_Bb', vce (cluster imada)
		estimates store IBbexpenditure_win
		local RBb `RBb' IBbexpenditure_win
		*control mean	
			estadd scalar Control_Mean= _b[_cons]	


								estout `RBb'	using	"$report\Expenditure.xls", 		append 			///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(extra repondant_sex _cons)	label 			///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)	collabels(none) mlabels(none) eqlabels(none)	///
								title			("Within Villages: direct effects on PWP completers") varlabels(_cons "Control Mean" parti "PWP completer")
		estimates clear	
		restore

*Infrastructure

		estimates clear
		preserve
		keep if enquete==1
		local RCa ""
		foreach outcome of local expenditure_win			{
			regres `outcome'  beneficiaire `ctrl_Ca', vce(cluster imada)
			estimates store `outcome'
			local RCa `RCa' `outcome'
	*control mean non-logged 
		sum 	n`outcome' if beneficiaire == 0
		estadd scalar Control_Mean= r(mean)	

		}
		regres ICaexpenditure_win beneficiaire `ctrl_Ca', vce (cluster imada)
		estimates store ICaexpenditure_win
		local RCa `RCa' ICaexpenditure_win
		*control mean	
			estadd scalar Control_Mean= _b[_cons]	


								estout `RCa'	using	"$report\Expenditure.xls", 		append 			///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))			label 		drop(_cons)	///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)	collabels(none) mlabels(none) eqlabels(none) 	///
								title			("Infrastructure Effects")		varlabels(_cons "Control Mean" beneficiaire "Treatment Community")
		estimates clear
		restore

*Spillovers

		estimates clear
		preserve
		keep if (control==1 | enquete==3)
		local RCb ""
		foreach outcome of local expenditure_win			{
			regres `outcome'  beneficiaire `ctrl_Cb', vce(cluster imada)
			estimates store `outcome'
			local RCb `RCb' `outcome'
	*control mean non-logged 
		sum 	n`outcome' if beneficiaire == 0
		estadd scalar Control_Mean= r(mean)	

		}
		regres ICbexpenditure_win beneficiaire `ctrl_Cb', vce (cluster imada)
		estimates store ICbexpenditure_win
		local RCb `RCb' ICbexpenditure_win
		
		*control mean	
			estadd scalar Control_Mean= _b[_cons]	


								estout `RCb'	using	"$report\Expenditure.xls", 		append 			///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(hhsize g1_4 _cons)	label 			///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)	collabels(none) mlabels(none) eqlabels(none) 	///
								title			("Spillover Effects")		varlabels(_cons "Control Mean" beneficiaire "Treatment Community")	///
								note("OLS regressions on logarithm of expenditure on different items and on the standardized index of expenditure. Clustered SE at the imada level.") ///

		estimates clear
		restore



		filefilter "$report/Expenditure.xls" "$report/2Expenditure.xls", from("_") to(" ") replace

		
		
		
		
	

*******[TABLE 3 - COPING MECHANISMS]******

*some don't run and don't have any effects (0s) on those configurations for which they do run.
local coping_mechanisms 	g2_1 g2_2 g2_3 g2_4 g2_5 g2_6 /*g2_7*/ g2_8 /*g2_9 g2_10*/ g2_11 /*g2_12*/ g2_13 g2_14 g2_15

label variable g2_1 		"Decrease food consumption"
label variable g2_2			"Children out of school"
label variable g2_3			"Debts with friends"
label variable g2_4			"Debts with coops"
label variable g2_5			"Debts with neighbours"
label variable g2_6			"Help from fam outside imada"
label variable g2_7			"Send children to friends"
label variable g2_8			"Help from comm members"
label variable g2_9			"Help from own Omda"
label variable g2_10		"Help from other Omda"
label variable g2_11		"Help from NGO"
label variable g2_12		"Help from government"
label variable g2_13		"Sell hh possessions"
label variable g2_14		"Sell livestock"
label variable g2_15		"Draw upon savings"


*Between

	estimates clear
	preserve 
	keep if (parti==1 | desist==1 | enquete==3) 	
	local RAa ""

	foreach outcome of local coping_mechanisms				{
		glm 	`outcome'  beneficiaire `ctrl_Aa', family(binomial) link(probit) vce(cluster imada)
		eststo 	`outcome'	: margins, dydx(beneficiaire) atmeans post
	
	*column heading variable label
		local varlbl : variable label `outcome'
		local varlbl = subinstr("`varlbl'", " " , "_" , .)
		di "`varlbl'"
		estimates store `varlbl'
		local RAa `RAa' `varlbl'
		
	*control mean	
		sum 	`outcome' if beneficiaire == 0
		estadd scalar Control_Mean= r(mean)	

	}
	
		regres IAacoping_mechanisms beneficiaire `ctrl_Aa', vce (cluster imada)
		estimates store Coping_Mechanism_Index
		local RAa `RAa' Coping_Mechanism_Index
		*control mean	
			estadd scalar Control_Mean= _b[_cons]	

								estout `RAa'	using	"$report\Coping_Mechanisms.xls", 		replace 				///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(hhsize drepondant_mat g1_3 g1_4 g1_5 g1_7 _cons)	label 	///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)		eqlabels(none) 	collabels(none) ///
								title			("Between Villages: direct effects on all workers")	varlabels(beneficiaire "Treatment Community") 
		estimates clear
		restore				
		
		
*Within (ITT)			

		estimates clear
		preserve
		keep if (parti==1 | desist==1 | control==1) 
		local RBa ""
		foreach outcome of local coping_mechanisms			{
			glm `outcome'  program `ctrl_Ba', family(binomial) link(probit) vce(cluster imada)
			eststo `outcome'	: margins, dydx(program) atmeans post
			local RBa `RBa' `outcome'
		
		*control mean	
			sum 	`outcome' if program == 0
			estadd scalar Control_Mean= r(mean)	
		
		}
		*index
		regres IBacoping_mechanisms program `ctrl_Ba', vce (cluster imada)
		estimates store IBacoping_mechanisms
		local RBa `RBa' IBacoping_mechanisms
		*control mean	
			estadd scalar Control_Mean= _b[_cons]	


								estout `RBa'	using	"$report\Coping_Mechanisms.xls", 		append 			///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(extra _cons)	label 			///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)	collabels(none) mlabels(none) eqlabels(none)	///
								title			("Within Villages: direct effects on all workers") varlabels(program "Worker")

		
*Within (ATE) 
		
		estimates clear	
		restore

		estimates clear
		preserve
		keep if (parti==1 | control==1)
		local RBb ""
		foreach outcome of local coping_mechanisms			{
			glm `outcome'  parti `ctrl_Bb', family(binomial) link(probit) vce(cluster imada)
			eststo `outcome'	: margins, dydx(parti) atmeans post			
			local RBb `RBb' `outcome'

		*control mean	
			sum 	`outcome' if parti == 0
			estadd scalar Control_Mean= r(mean)	

		}
		regres IBbcoping_mechanisms parti `ctrl_Bb', vce (cluster imada)
		estimates store IBbcoping_mechanisms
		local RBb `RBb' IBbcoping_mechanisms
		*control mean	
			estadd scalar Control_Mean= _b[_cons]	


								estout `RBb'	using	"$report\Coping_Mechanisms.xls", 		append 			///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(extra repondant_sex _cons)	label 			///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)	collabels(none) mlabels(none) eqlabels(none)	///
								title			("Within Villages: direct effects on PWP completers") varlabels(parti "PWP completer")
		estimates clear	
		restore

*Infrastructure 

		estimates clear
		preserve
		keep if enquete==1
		local RCa ""
		foreach outcome of local coping_mechanisms			{
			glm `outcome'  beneficiaire `ctrl_Ca', family(binomial) link(probit) vce(cluster imada)
			eststo `outcome'	: margins, dydx(beneficiaire) atmeans post
			local RCa `RCa' `outcome'

		*control mean	
			sum 	`outcome' if beneficiaire == 0
			estadd scalar Control_Mean= r(mean)	

		}
		regres ICacoping_mechanisms beneficiaire `ctrl_Ca', vce (cluster imada)
		estimates store ICacoping_mechanisms
		local RCa `RCa' ICacoping_mechanisms
		*control mean	
			estadd scalar Control_Mean= _b[_cons]	


								estout `RCa'	using	"$report\Coping_Mechanisms.xls", 		append 			///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))	label 	drop(_cons)		///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)	collabels(none) mlabels(none) eqlabels(none) 	///
								title			("Infrastructure Effects")		varlabels(beneficiaire "Treatment Community")
		estimates clear
		restore

*Spillovers

		estimates clear
		preserve
		keep if (control==1 | enquete==3)
		local RCb ""
		foreach outcome of local coping_mechanisms			{
			glm `outcome'  beneficiaire `ctrl_Cb', family(binomial) link(probit) vce(cluster imada)
			eststo `outcome'	: margins, dydx(beneficiaire) atmeans post
			local RCb `RCb' `outcome'

		*control mean	
			sum 	`outcome' if beneficiaire == 0
			estadd scalar Control_Mean= r(mean)	

		}
		regres ICbcoping_mechanisms beneficiaire `ctrl_Cb', vce (cluster imada)
		estimates store ICbcoping_mechanisms
		local RCb `RCb' ICbcoping_mechanisms
		*control mean	
			estadd scalar Control_Mean= _b[_cons]	


								estout `RCb'	using	"$report\Coping_Mechanisms.xls", 		append 			///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(hhsize g1_4 _cons)	label 			///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)	collabels(none) mlabels(none) eqlabels(none) 	///
								title			("Spillover Effects")		varlabels(beneficiaire "Treatment Community")			///
								note("Probit regressions on use of individual mechanisms and OLS regression on the standardized index. Clustered SE at the imada level.") ///

		estimates clear
		restore

		
		filefilter "$report/Coping_Mechanisms.xls" "$report/3Coping_Mechanisms.xls", from("_") to(" ") replace
		
		
	
		
		
*******[TABLE 4 - HOUSEHOLD ASSETS]******

local assets_indicesAa		IAahh_assets2 IAahouse_ownership IAalarge_assets IAasmall_assets IAahome_assets IAacomms_assets ///
							IAaproductive_assets 
local assets_indicesBa		IBahh_assets2 IBahouse_ownership IBalarge_assets IBasmall_assets IBahome_assets IBacomms_assets ///
							IBaproductive_assets 
local assets_indicesBb		IBbhh_assets2 IBbhouse_ownership IBblarge_assets IBbsmall_assets IBbhome_assets IBbcomms_assets ///
							IBbproductive_assets 
local assets_indicesCa		ICahh_assets2 ICahouse_ownership ICalarge_assets ICasmall_assets ICahome_assets ICacomms_assets ///
							ICaproductive_assets 
local assets_indicesCb		ICbhh_assets2 ICbhouse_ownership ICblarge_assets ICbsmall_assets ICbhome_assets ICbcomms_assets ///
							ICbproductive_assets /*q2_1_2_win q2_1_3 q2_1_4 q2_1_5 q2_1_6 q2_1_7 q2_1_8 q2_1_9 q2_1_10 q2_1_11 		///
							q2_1_12 q2_1_13_win q2_1_14 q2_1_15 q2_1_16_win q2_1_17 q2_1_18_win q2_1_19_win 	///
							q2_1_20 q2_1_21 q2_1_22 q2_1_23_win proprietaire_dum1 titre proprietaire_terre titre_terre */

label variable IAahh_assets2		"HH Assets Index"
label variable IAahouse_ownership	"Home Ownership Index"
label variable IAalarge_assets		"Large Assets Index"
label variable IAasmall_assets		"Small Assets Index"
label variable IAahome_assets		"Home Assets Index"
label variable IAacomms_assets		"Comms Assets Index"
label variable IAaproductive_assets	"Productive Assets Index"
label variable q2_1_2_win 			"Oven"
label variable q2_1_3 				"Fridge"
label variable q2_1_4 				"Central Heating"
label variable q2_1_5 				"Air Conditioning"
label variable q2_1_6 				"Washing Machine"
label variable q2_1_7 				"Beds"
label variable q2_1_8 				"Wardrobes"
label variable q2_1_9 				"Car Van or Tractor"
label variable q2_1_10 				"Motorbike or Scooter"
label variable q2_1_11 				"Bicycle"
label variable q2_1_12 				"Television"
label variable q2_1_13_win 			"Satellite dish"
label variable q2_1_14 				"Camera"
label variable q2_1_15 				"Radio"
label variable q2_1_16_win 			"Telephone"
label variable q2_1_17 				"Computer"
label variable q2_1_18_win 			"Sheep or Goat"	
label variable q2_1_19_win 			"Duck Chicken or Turkey"
label variable q2_1_20 				"Beehive"
label variable q2_1_21 				"Cattle"
label variable q2_1_22 				"Donkey or Horse"
label variable q2_1_23_win			"Cat Dog or Bird"
label variable proprietaire_dum1 	"Home Owner"
label variable titre 				"Title for Property"
label variable proprietaire_terre 	"Land Owner"
label variable titre_terre 			"Title for Land"
label variable superficie_m			"Land Area (m)"
label variable f18_dummy			"More than 3 on poverty scale"



*Between
					
		estimates clear
		preserve 
		keep if (parti==1 | desist==1 | enquete==3) 

		local RAa ""
		foreach outcome of varlist `assets_indicesAa' {
			regres `outcome' beneficiaire `ctrl_Aa', vce (cluster imada)
		
		*Column heading variable labels
			local varlbl : variable label `outcome'
			local varlbl = subinstr("`varlbl'", " " , "_" , .)
			di "`varlbl'"
			estimates store `varlbl'
			local RAa `RAa' `varlbl'	

		*control mean	
			estadd scalar Control_Mean= _b[_cons]	
		}
		
								estout `RAa'	using	"$report\Assets.xls", 		replace 					///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(hhsize drepondant_mat g1_3 g1_4 g1_5 g1_7 _cons)	label 	///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)		collabels(none)						///
								title			("Between Villages: direct effects on all workers")	varlabels(beneficiaire "Treatment Community") 
		estimates clear
		restore

*Within (ITT)

		estimates clear
		preserve
		keep if (parti==1 | desist==1 | control==1) 
		local RBa ""
		foreach outcome of varlist `assets_indicesBa' {
			regres `outcome' program `ctrl_Ba', vce (cluster imada)
			estimates store RBa`outcome'
			local RBa `RBa' RBa`outcome'
		*control mean	
			estadd scalar Control_Mean= _b[_cons]	
		}
								estout `RBa'	using	"$report\Assets.xls", 		append 							///
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
		foreach outcome of varlist `assets_indicesBb' {
			regres `outcome' parti `ctrl_Bb', vce (cluster imada)
			estimates store RBb`outcome'
			local RBb `RBb' RBb`outcome'
		*control mean	
			estadd scalar Control_Mean= _b[_cons]	
		}
								estout `RBb'	using	"$report\Assets.xls", 		append 					///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))	drop(extra repondant_sex _cons) 	label	///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)	collabels(none) mlabels(none) 	///
								title			("Within Villages: direct effects on PWP completers") varlabels(parti "PWP completer")
		estimates clear	
		restore

*Infrastructure

		estimates clear
		preserve
		keep if enquete==1
		local RCa ""
		foreach outcome of varlist `assets_indicesCa' {
			regres `outcome' beneficiaire `ctrl_Ca', vce (cluster imada)
			estimates store RCa`outcome'
			local RCa `RCa' RCa`outcome'
		*control mean	
			estadd scalar Control_Mean= _b[_cons]	
		}

								estout `RCa'	using	"$report\Assets.xls", 		append 					///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))				label	drop( _cons)	 			///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)	collabels(none) mlabels(none) 	///
								title			("Infrastructure Effects")		varlabels(beneficiaire "Treatment Community")
		estimates clear
		restore

*Spillovers

		estimates clear
		preserve
		keep if (control==1 | enquete==3)
		local RCb ""
		foreach outcome of varlist `assets_indicesCb' {
			regres `outcome' beneficiaire `ctrl_Cb', vce (cluster imada)
			estimates store RCb`outcome'
			local RCb `RCb' RCb`outcome'
		*control mean	
			estadd scalar Control_Mean= _b[_cons]	
		}
								estout `RCb'	using	"$report\Assets.xls", 				append			///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(hhsize g1_4 _cons)	label	 		///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)	collabels(none) mlabels(none) 	///
								title			("Spillover Effects")		varlabels(beneficiaire "Treatment Community")		///
								note("OLS regressions on indices of asset ownership. Clustered SE at the imada level.")

		estimates clear
		restore
							
						
	
		filefilter "$report/Assets.xls" "$report/4Assets.xls", from("_") to(" ") replace
	
	



*******[TABLE 5 - HUMAN CAPITAL]******
local human_capital2 	formation /*formation_dum1*/ formation_dum2 formation_dum3 formation_dum4 	///
						formation_dum5 /*formation_dum6*/ formation_dum7 formation_dum9 			///
						formation_dum10 emploi_comp_inut
						
						
label variable formation			"Any"	
label variable formation_dum1		"Language"	
label variable formation_dum2		"ICT"	
label variable formation_dum3		"Handicraft"
label variable formation_dum4		"Domestic Repairs"
label variable formation_dum5		"Agricultural"
label variable formation_dum6		"SME"	
label variable formation_dum7		"Mechanic or Electric"
label variable formation_dum9		"Other Services"
label variable formation_dum10		"Other"
label variable emploi_comp_inut		"Skills Currently Unutilized"
					
						
*Between
						
	estimates clear
	preserve 
	keep if (parti==1 | desist==1 | enquete==3) 	
	local RAa ""
	local ctlmean ""

	foreach outcome of local human_capital2			{
		glm `outcome'  beneficiaire `ctrl_Aa', family(binomial) link(probit) vce(cluster imada)	
		eststo `outcome' : margins, dydx(beneficiaire) atmeans post
	
	*Column headings variable labels
		local varlbl : variable label `outcome'
		local varlbl = subinstr("`varlbl'", " " , "_" , .)
		di "`varlbl'"
		
		estimates store `varlbl'
		local RAa `RAa' `varlbl'
		
	*control mean	
		sum 	`outcome' if beneficiaire == 0
		estadd scalar Control_Mean= r(mean)	

	}
	
		regres IAahuman_capital2 beneficiaire `ctrl_Aa', vce (cluster imada)
		estimates store Human_Capital_Index
		local RAa `RAa' Human_Capital_Index
	*control mean	
		estadd scalar Control_Mean= _b[_cons]	

								estout `RAa'	using	"$report\human_capital2.xls", 		replace 				///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(hhsize drepondant_mat g1_3 g1_4 g1_5 g1_7 _cons)	label 	///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)		eqlabels(none) 	collabels(none) ///
								title			("Between Villages: direct effects on all workers")	varlabels(beneficiaire "Treatment Community") 
		estimates clear
		restore		

*Within (ITT)

		estimates clear
		preserve
		keep if (parti==1 | desist==1 | control==1) 
		local RBa ""
		foreach outcome of local human_capital2			{
			glm `outcome'  program `ctrl_Ba', family(binomial) link(probit) vce(cluster imada)
			eststo `outcome'	: margins, dydx(program) atmeans post
			local RBa `RBa' `outcome'
			
		
	*control mean	
			sum 	`outcome' if program == 0
			estadd scalar Control_Mean= r(mean)	

		}
		regres IBahuman_capital2 program `ctrl_Ba', vce (cluster imada)
		estimates store IBahuman_capital2
		local RBa `RBa' IBahuman_capital2
	*control mean	
		estadd scalar Control_Mean= _b[_cons]	

								estout `RBa'	using	"$report\human_capital2.xls", 		append 			///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(extra _cons)	label 			///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)	collabels(none) mlabels(none) eqlabels(none)	///
								title			("Within Villages: direct effects on all workers") varlabels(program "Worker")

		estimates clear	
		restore

*Within (ATE)		

		estimates clear
		preserve
		keep if (parti==1 | control==1)
		local RBb ""
		foreach outcome of local human_capital2			{
			glm `outcome'  parti `ctrl_Bb', family(binomial) link(probit) vce(cluster imada)
			eststo `outcome'	: margins, dydx(parti) atmeans post
			local RBb `RBb' `outcome'
			
	*control mean	
			sum 	`outcome' if parti == 0
			estadd scalar Control_Mean= r(mean)	

		}
		regres IBbhuman_capital2 parti `ctrl_Bb', vce (cluster imada)
		estimates store IBbhuman_capital2
		local RBb `RBb' IBbhuman_capital2
	*control mean	
		estadd scalar Control_Mean= _b[_cons]	
								estout `RBb'	using	"$report\human_capital2.xls", 		append 			///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(extra repondant_sex _cons)	label 			///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)	collabels(none) mlabels(none) eqlabels(none)	///
								title			("Within Villages: direct effects on PWP completers") varlabels(parti "PWP completer")
		estimates clear	
		restore

*Infrastructure

		estimates clear
		preserve
		keep if enquete==1
		local RCa ""
		foreach outcome of local human_capital2			{
			glm `outcome'  beneficiaire `ctrl_Ca', family(binomial) link(probit) vce(cluster imada)
			eststo `outcome'	: margins, dydx(beneficiaire) atmeans post
			local RCa `RCa' `outcome'
			
	*control mean	
			sum 	`outcome' if beneficiaire == 0
			estadd scalar Control_Mean= r(mean)	

		}
		regres ICahuman_capital2 beneficiaire `ctrl_Ca', vce (cluster imada)
		estimates store ICahuman_capital2
		local RCa `RCa' ICahuman_capital2
	*control mean	
		estadd scalar Control_Mean= _b[_cons]	

								estout `RCa'	using	"$report\human_capital2.xls", 		append 			///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))	label 	drop(_cons)		///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)	collabels(none) mlabels(none) eqlabels(none) 	///
								title			("Infrastructure Effects")		varlabels(beneficiaire "Treatment Community")
		estimates clear
		restore

*Spillovers

		estimates clear
		preserve
		keep if (control==1 | enquete==3)
		local RCb ""
		foreach outcome of local human_capital2			{
			glm `outcome'  beneficiaire `ctrl_Cb', family(binomial) link(probit) vce(cluster imada)
			eststo `outcome'	: margins, dydx(beneficiaire) atmeans post
			local RCb `RCb' `outcome'
		
	*control mean	
			sum 	`outcome' if beneficiaire == 0
			estadd scalar Control_Mean= r(mean)	


		}
		regres ICbhuman_capital2 beneficiaire `ctrl_Cb', vce (cluster imada)
		estimates store ICbhuman_capital2
		local RCb `RCb' ICbhuman_capital2
	*control mean	
		estadd scalar Control_Mean= _b[_cons]	

								estout `RCb'	using	"$report\human_capital2.xls", 		append 			///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(hhsize g1_4 _cons)	label 			///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)	collabels(none) mlabels(none) eqlabels(none) 	///
								title			("Spillover Effects")		varlabels(beneficiaire "Treatment Community")				///
								note("Probit regressions on types of training and OLS regression on the standardized index. Clustered SE at the imada level.") ///

		estimates clear
		restore

					
						
		filefilter "$report/human_capital2.xls" "$report/5Human_Capital.xls", from("_") to(" ") replace
					
			
	

*******[TABLE 6 - WAGE EMPLOYMENT]******

local wage_employment2 		emploi tspent_main earned_main_win employedhh earnedhh_win ///
							paidjobhh earnedoth paidjoboth 
local employment_cen	 	/*tspent_main*/ earned_main_win earnedhh_win earnedoth 	/*tspent_sec_win earned_sec */
local employment_dum		emploi	employedhh	/*paidjobhh	paidjoboth*/ sec_empl futur_services futur_agriculture empl_futur_dum5 
							/*type_emploi_1 type_emploi_2 type_emploi_3 type_emploi_4 type_emploi_5 type_emploi_6 type_emploi_7 /*type_emploi_8*/		///
							type_emploi_9 type_emploi_10 type_emploi_11 /*type_emploi_12*/ type_emploi_13*/
						

label variable emploi				"Paid Employment"
label variable tspent_main			"Hours Worked"
label variable earned_main_win		"Monthly Earnings Main Job"
label variable employedhh			"HH Head Employed"
label variable earnedhh_win			"HH Head Monthly Earnings"
label variable paidjobhh			"Other HH Member Employed"
label variable earnedoth			"Other Monthly Earnings"
label variable paidjoboth			"HH Head Other Employment"
label variable sec_empl 			"Second Job"
label variable futur_services 		"Aspire Services"	
label variable futur_agriculture 	"Aspire Agriculture"
label variable empl_futur_dum5 		"Aspire Construction"
label variable type_emploi_1		"Agriculture"
label variable type_emploi_2		"Livestock"
label variable type_emploi_3		"Fisherman"
label variable type_emploi_4		"Food Industry"
label variable type_emploi_5		"Construction"
label variable type_emploi_6		"Mechanics or Electrics"
label variable type_emploi_7		"Transport"
label variable type_emploi_9		"Hotel Cafe or Restaurant"
label variable type_emploi_10		"Trader"
label variable type_emploi_11		"Civil Servant"
label variable type_emploi_13		"Military"
label variable emp_futur_cb_win 	"Aspirational Salary"
label variable IAawage_employment2	"Wage Employment Index"	
					
						
*Between
						
	estimates clear
	preserve 
	keep if (parti==1 | desist==1 | enquete==3)
 	
	local RAa ""
	foreach outcome of local employment_cen				{
		regres `outcome'  beneficiaire `ctrl_Aa', vce(cluster imada)
	
	*Column heading variable label
		local varlbl : variable label `outcome'
		local varlbl = subinstr("`varlbl'", " " , "_" , .)
		di "`varlbl'"
		
		estimates store `varlbl'
		local RAa `RAa' `varlbl'
		
	*control mean	
			sum 	n`outcome' if beneficiaire == 0 & `outcome'~=0
			estadd scalar Control_Mean= r(mean)	
		
	}
	
	foreach outcome_dum of local employment_dum			{
		glm `outcome_dum'  beneficiaire `ctrl_Aa', family(binomial) link(probit) vce(cluster imada)
		eststo `outcome_dum'	: margins, dydx(beneficiaire) atmeans post
	
	*Column heading variable label
		local varlbl_dum : variable label `outcome_dum'
		local varlbl_dum = subinstr("`varlbl_dum'", " " , "_" , .)
		di "`varlbl_dum'"
		
		estimates store `varlbl_dum'
		local RAa `RAa' `varlbl_dum'
		
	*control mean	
		sum 	`outcome_dum' if beneficiaire == 0
		estadd scalar Control_Mean= r(mean)	

	}
	
	foreach var of varlist emp_futur_cb_win IAawage_employment2		{
		regres `var' beneficiaire `ctrl_Aa', vce (cluster imada)
	*Column heading variable label
		local varlbl : variable label `var'
		local varlbl = subinstr("`varlbl'", " " , "_" , .)
		di "`varlbl'"
		
		estimates store `varlbl'
		local RAa `RAa' `varlbl'
		
	estadd scalar Control_Mean= _b[_cons]	

	}

								estout `RAa'	using	"$report\Employment.xls", 		replace 				///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))			drop(hhsize drepondant_mat g1_3 g1_4 g1_5 g1_7 _cons)	label 	///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)		eqlabels(none) 	collabels(none) ///
								title			("Between Villages: direct effects on all workers")	varlabels(_cons Constant beneficiaire "Treatment Community") 
		estimates clear
		restore				
		
*Within (ITT)

		estimates clear
		preserve
		keep if (parti==1 | desist==1 | control==1) 
		
		local RBa ""
		foreach outcome of local employment_cen			{
			regres `outcome' program `ctrl_Ba', vce(cluster imada)
			estimates store `outcome'
			local RBa `RBa' `outcome'

	*control mean	
			sum 	n`outcome' if program == 0  & `outcome'~=0
			estadd scalar Control_Mean= r(mean)	

		}
		foreach outcome_dum of local employment_dum			{
			glm `outcome_dum'  program `ctrl_Ba', family(binomial) link(probit) vce(cluster imada)
			eststo `outcome_dum'	: margins, dydx(program) atmeans post
			estimates store `outcome_dum'
			local RBa `RBa' `outcome_dum'
			
	*control mean	
		sum 	`outcome_dum' if program == 0
		estadd scalar Control_Mean= r(mean)	

	}

	foreach var of varlist emp_futur_cb_win IBawage_employment2		{
		regres `var' program `ctrl_Ba', vce (cluster imada)
		estimates store `var'
		local RBa `RBa' `var'
	estadd scalar Control_Mean= _b[_cons]	

	}
								estout `RBa'	using	"$report\Employment.xls", 		append 			///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(extra _cons)	label 			///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)	collabels(none) mlabels(none) eqlabels(none)	///
								title			("Within Villages: direct effects on all workers") varlabels(_cons Constant program "Worker")

		estimates clear	
		restore
	
	
*Within (ATE)

		estimates clear
		preserve
		keep if (parti==1 | control==1)
		local RBb ""
		foreach outcome of local employment_cen			{
			regres `outcome' parti `ctrl_Bb', vce(cluster imada)
			estimates store `outcome'
			local RBb `RBb' `outcome'
			
	*control mean	
			sum 	n`outcome' if parti == 0 & `outcome'~=0
			estadd scalar Control_Mean= r(mean)	

		}
		foreach outcome_dum of local employment_dum			{
			glm `outcome_dum'  parti `ctrl_Bb', family(binomial) link(probit) vce(cluster imada)
			eststo `outcome_dum'	: margins, dydx(parti) atmeans post
			estimates store `outcome_dum'
			local RBb `RBb' `outcome_dum'
			
	*control mean	
		sum 	`outcome_dum' if parti == 0
		estadd scalar Control_Mean= r(mean)	

		}

	foreach var of varlist emp_futur_cb_win IBbwage_employment2		{
		regres `var' parti `ctrl_Bb', vce (cluster imada)
		estimates store `var'
		local RBb `RBb' `var'
	estadd scalar Control_Mean= _b[_cons]	

	}

								estout `RBb'	using	"$report\Employment.xls", 		append 			///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(extra repondant_sex _cons)	label 			///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)	collabels(none) mlabels(none) eqlabels(none)	///
								title			("Within Villages: direct effects on PWP completers") varlabels( _cons Constant parti "PWP completer")
		estimates clear	
		restore


*Infrastructure

		estimates clear
		preserve
		keep if enquete==1
		local RCa ""
		foreach outcome of local employment_cen			{
			regres `outcome'  beneficiaire `ctrl_Ca', vce(cluster imada)
			estimates store `outcome'
			local RCa `RCa' `outcome'

	*control mean	
			sum 	n`outcome' if beneficiaire == 0 & `outcome'~=0
			estadd scalar Control_Mean= r(mean)	

		}
		foreach outcome_dum of local employment_dum			{
			glm `outcome_dum'  beneficiaire `ctrl_Ca', family(binomial) link(probit) vce(cluster imada)
			eststo `outcome_dum'	: margins, dydx(beneficiaire) atmeans post
			estimates store `outcome_dum'
			local RCa `RCa' `outcome_dum'
			
	*control mean	
		sum 	`outcome_dum' if beneficiaire == 0
		estadd scalar Control_Mean= r(mean)	

		}

	foreach var of varlist emp_futur_cb_win ICawage_employment2		{		
	regres `var' beneficiaire `ctrl_Ca', vce (cluster imada)
		estimates store `var'
		local RCa `RCa' `var'
	estadd scalar Control_Mean= _b[_cons]	
	}

								estout `RCa'	using	"$report\Employment.xls", 		append 			///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		label 	drop( _cons)			///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)	collabels(none) mlabels(none) eqlabels(none) 	///
								title			("Infrastructure Effects")		varlabels(_cons Constant beneficiaire "Treatment Community")
		estimates clear
		restore

		
*Spillovers

		estimates clear
		preserve
		keep if (control==1 | enquete==3)
		local RCb ""
		foreach outcome of local employment_cen			{
			regres `outcome'  beneficiaire `ctrl_Cb', vce(cluster imada)
			estimates store `outcome'
			local RCb `RCb' `outcome'
	
	*control mean	
			sum 	n`outcome' if beneficiaire == 0 & `outcome'~=0
			estadd scalar Control_Mean= r(mean)	

		}
		foreach outcome_dum of local employment_dum			{
			glm `outcome_dum'  beneficiaire `ctrl_Cb', family(binomial) link(probit) vce(cluster imada)
			eststo `outcome_dum'	: margins, dydx(beneficiaire) atmeans post
			estimates store `outcome_dum'
			local RCb `RCb' `outcome_dum'
			
	*control mean	
		sum 	`outcome_dum' if beneficiaire == 0
		estadd scalar Control_Mean= r(mean)	

		}

	foreach var of varlist emp_futur_cb_win ICbwage_employment2		{		
		regres `var' beneficiaire `ctrl_Cb', vce (cluster imada)
		estimates store `var'
		local RCb `RCb' `var'
	estadd scalar Control_Mean= _b[_cons]	
	}

								estout `RCb'	using	"$report\Employment.xls", 		append 			///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(hhsize g1_4 _cons)	label 			///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)	collabels(none) mlabels(none) eqlabels(none) 	///
								title			("Spillover Effects")		varlabels(beneficiaire "Treatment Community" _cons Constant)		///
								note("Probit regressions on binary variables and OLS regressions on continuous variables and the standardized index. Clustered SE at the imada level.")
		estimates clear
		restore


						
		filefilter "$report/Employment.xls" "$report/6Employment.xls", from("_") to(" ") replace					
						
						
						
*******[TABLE 7 - DEBTS AND SAVINGS]******
local debts_and_savings2 	epargne epargne_forme_3 epargne_cb epargne_dette epargne_dette_cb_win epargne_pret
local debts					epargne_dette epargne_dette_cb_win 
local savings				epargne epargne_forme_3 epargne_cb

local saving_cen			epargne_cb epargne_dette_cb_win
local saving_dum			epargne epargne_dette epargne_pret //epargne_forme_3
local finance_indicesAa		IAadebts_and_savings2 IAadebts IAasavings
local finance_indicesBa		IBadebts_and_savings2 IBadebts IBasavings
local finance_indicesBb		IBbdebts_and_savings2 IBbdebts IBbsavings
local finance_indicesCa		ICadebts_and_savings2 ICadebts ICasavings
local finance_indicesCb		ICbdebts_and_savings2 ICbdebts ICbsavings			
						
label variable 				epargne 				"Saved Past Year"
label variable 				epargne_forme_3 		"Saved in Bank Account"
label variable 				epargne_cb				"Amount Saved"
label variable 				epargne_dette 			"In Debt Past Year"
label variable 				epargne_dette_cb_win 	"Amount in Debt"
label variable 				epargne_pret			"Lent Money Past Year"
label variable 				IAadebts_and_savings2 	"Debt and Saving Index"
label variable 				IAadebts 				"Debt Index"
label variable 				IAasavings				"Saving Index"
						
						
*Between						
						
	estimates clear
	preserve 
	keep if (parti==1 | desist==1 | enquete==3) 	
	local RAa ""
	foreach outcome of local saving_cen				{
		regres `outcome'  beneficiaire `ctrl_Aa', vce(cluster imada)
	
	*column heading label variable
		local varlbl : variable label `outcome'
		local varlbl = subinstr("`varlbl'", " " , "_" , .)
		di "`varlbl'"
	
		estimates store `varlbl'
		local RAa `RAa' `varlbl'	

	*control mean	
		sum 	`outcome' if beneficiaire == 0 & `outcome' ~= 0
		estadd scalar Control_Mean= r(mean)	

	}
	foreach outcome_dum of local saving_dum			{
		glm `outcome_dum'  beneficiaire `ctrl_Aa', family(binomial) link(probit) vce(cluster imada)
		eststo `outcome_dum'	: margins, dydx(beneficiaire) atmeans post
	
	*Column heading label variable
		local varlbl_dum : variable label `outcome_dum'
		local varlbl_dum = subinstr("`varlbl_dum'", " " , "_" , .)
		di "`varlbl_dum'"
		
		estimates store `varlbl_dum'
		local RAa `RAa' `varlbl_dum'

	*control mean	
		sum 	`outcome_dum' if beneficiaire == 0
		estadd scalar Control_Mean= r(mean)	

	}
	foreach outcome_ind of varlist `finance_indicesAa' {
		regres `outcome_ind' beneficiaire `ctrl_Aa', vce (cluster imada)
	
	*Column heading label variable
		local varlbl_ind : variable label `outcome_ind'
		local varlbl_ind = subinstr("`varlbl_ind'", " " , "_" , .)
		di "`varlbl_ind'"
		estimates store `varlbl_ind'
		local RAa `RAa' `varlbl_ind'
		
	estadd scalar Control_Mean= _b[_cons]	

	}

								estout `RAa'	using	"$report\Saving.xls", 		replace 				///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(hhsize drepondant_mat g1_3 g1_4 g1_5 g1_7 _cons)	label 	///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)		eqlabels(none) 	collabels(none) ///
								title			("Between Villages: direct effects on all workers")	varlabels(beneficiaire "Treatment Community") 
		estimates clear
		restore		
	
	
*Within (ITT)

		estimates clear
		preserve
		keep if (parti==1 | desist==1 | control==1) 
		local RBa ""

		foreach outcome of local saving_cen			{
			regres `outcome' program `ctrl_Ba', vce (cluster imada)
			estimates store `outcome'
			local RBa `RBa' `outcome'
			
*control mean	
		sum 	`outcome' if program == 0 & `outcome' ~= 0
		estadd scalar Control_Mean= r(mean)	
		}
		
		foreach outcome_dum of local saving_dum			{
			glm `outcome_dum'  program `ctrl_Ba', family(binomial) link(probit) vce(cluster imada)
			eststo `outcome_dum'	: margins, dydx(program) atmeans post
			estimates store `outcome_dum'
			local RBa `RBa' `outcome_dum'
			
			
	*control mean	
		sum 	`outcome_dum' if program == 0
		estadd scalar Control_Mean= r(mean)	
		

		}

		foreach outcome_ind of varlist `finance_indicesBa' {
			regres `outcome_ind' program `ctrl_Ba', vce (cluster imada)
			estimates store RBa`outcome_ind'
			local RBa `RBa' RBa`outcome_ind'
			
	estadd scalar Control_Mean= _b[_cons]	
		}

								estout `RBa'	using	"$report\Saving.xls", 		append 			///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(extra _cons)	label 			///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)	collabels(none) mlabels(none) eqlabels(none)	///
								title			("Within Villages: direct effects on all workers") varlabels(program "Worker")

		estimates clear	
		restore

*Within (ATE)

		estimates clear
		preserve
		keep if (parti==1 | control==1)
		local RBb ""

		foreach outcome of local saving_cen			{
			regres `outcome' parti `ctrl_Bb', vce (cluster imada)
			estimates store `outcome'
			local RBb `RBb' `outcome'

		*control mean	
		sum 	`outcome' if parti == 0 & `outcome' ~= 0
		estadd scalar Control_Mean= r(mean)	
		
		}
		foreach outcome_dum of local saving_dum			{
			glm `outcome_dum'  parti `ctrl_Bb', family(binomial) link(probit) vce(cluster imada)
			eststo `outcome_dum'	: margins, dydx(parti) atmeans post
			estimates store `outcome_dum'
			local RBb `RBb' `outcome_dum'
			
			
	*control mean	
		sum 	`outcome_dum' if parti == 0
		estadd scalar Control_Mean= r(mean)	
		
		}

		foreach outcome_ind of varlist `finance_indicesBb' {
			regres `outcome_ind' parti `ctrl_Bb', vce (cluster imada)
			estimates store RBb`outcome_ind'
			local RBb `RBb' RBb`outcome_ind'
	estadd scalar Control_Mean= _b[_cons]	
		}

								estout `RBb'	using	"$report\Saving.xls", 		append 			///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(extra repondant_sex _cons)	label 			///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)	collabels(none) mlabels(none) eqlabels(none)	///
								title			("Within Villages: direct effects on PWP completers") varlabels(parti "PWP completer")
		estimates clear	
		restore

*Infrastructure

		estimates clear
		preserve
		keep if enquete==1
		local RCa ""

		foreach outcome of local saving_cen			{
			regres `outcome'  beneficiaire `ctrl_Ca', vce(cluster imada)
			estimates store `outcome'
			local RCa `RCa' `outcome'

	*control mean	
		sum 	`outcome' if beneficiaire == 0 & `outcome' ~= 0
		estadd scalar Control_Mean= r(mean)	
		}
		foreach outcome_dum of local saving_dum			{
			glm `outcome_dum'  beneficiaire `ctrl_Ca', family(binomial) link(probit) vce(cluster imada)
			eststo `outcome_dum'	: margins, dydx(beneficiaire) atmeans post
			estimates store `outcome_dum'
			local RCa `RCa' `outcome_dum'
			
			
	*control mean	
		sum 	`outcome_dum' if beneficiaire == 0
		estadd scalar Control_Mean= r(mean)	
		}

		foreach outcome_ind of varlist `finance_indicesCa' {
			regres `outcome_ind' beneficiaire `ctrl_Ca', vce (cluster imada)
			estimates store RCa`outcome_ind'
			local RCa `RCa' RCa`outcome_ind'
	estadd scalar Control_Mean= _b[_cons]	

		}

								estout `RCa'	using	"$report\Saving.xls", 		append 			///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		label 	drop(_cons)		///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)	collabels(none) mlabels(none) eqlabels(none) 	///
								title			("Infrastructure Effects")		varlabels(beneficiaire "Treatment Community")
		estimates clear
		restore

*Spillovers

		estimates clear
		preserve
		keep if (control==1 | enquete==3)
		local RCb ""

		foreach outcome of local saving_cen			{
			regres `outcome'  beneficiaire `ctrl_Cb', vce(cluster imada)
			estimates store `outcome'
			local RCb `RCb' `outcome'

	*control mean	
		sum 	`outcome' if beneficiaire == 0 & `outcome' ~= 0
		estadd scalar Control_Mean= r(mean)	
		}
		foreach outcome_dum of local saving_dum			{
			glm `outcome_dum'  beneficiaire `ctrl_Cb', family(binomial) link(probit) vce(cluster imada)
			eststo `outcome_dum'	: margins, dydx(beneficiaire) atmeans post
			estimates store `outcome_dum'
			local RCb `RCb' `outcome_dum'
		
			
	*control mean	
		sum 	`outcome_dum' if beneficiaire == 0
		estadd scalar Control_Mean= r(mean)	
		
		}

		foreach outcome_ind of varlist `finance_indicesCb' {
			regres `outcome_ind' beneficiaire `ctrl_Cb', vce (cluster imada)
			estimates store RCb`outcome_ind'
			local RCb `RCb' RCb`outcome_ind'
		estadd scalar Control_Mean= _b[_cons]	

		}

								estout `RCb'	using	"$report\Saving.xls", 		append 			///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(hhsize g1_4 _cons)	label 			///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)	collabels(none) mlabels(none) eqlabels(none) 	///
								title			("Spillover Effects")		varlabels(beneficiaire "Treatment Community")			///
								note("Probit regressions on binary variables and OLS regressions on continuous variables and standardized indices. Clustered SE at the imada level.")

		estimates clear
		restore

		

		filefilter "$report/Saving.xls" "$report/7Saving.xls", from("_") to(" ") replace					





*******[TABLE 8 - SOCIAL COHESION]******
local social_cohesion2		association_dummy comite_c comite_c_menage conflit_dispute_in conflit_dispute_out ///
							/*migration_cm_q1 migration_q1 security_dummy securite_1 securite_2 securite_3  ///
							securite_4 securite_5 securite_6 association_1 association_2 association_3 		
							association_4 association_6 association_7 association_8 association_9*/
local cohesion_indAa		IAacomm_groups	 IAalocal_conflict	IAarecent_migration IAalocal_security	IAasocial_cohesion2	
local cohesion_indBa		IBacomm_groups	 IBalocal_conflict	IBarecent_migration IBalocal_security	IBasocial_cohesion2	
local cohesion_indBb		IBbcomm_groups	 IBblocal_conflict	IBbrecent_migration IBblocal_security	IBbsocial_cohesion2	
local cohesion_indCa		ICacomm_groups	 ICalocal_conflict	ICarecent_migration ICalocal_security	ICasocial_cohesion2	
local cohesion_indCb		ICbcomm_groups	 ICblocal_conflict	ICbrecent_migration ICblocal_security	ICbsocial_cohesion2	

label variable association_dummy 		"Association Member"
label variable comite_c 				"Coop in Imada"
label variable comite_c_menage 			"HH Coop Member"
label variable conflit_dispute_in 		"HH Conflict within Imada"
label variable conflit_dispute_out		"HH Conflict with Outside"
label variable security_dummy			"Security Incident Past Yr"
label variable IAacomm_groups	 		"Community Group Index"
label variable IAalocal_conflict		"Local Conflict Index"
label variable IAarecent_migration 		"Migration Index"
label variable IAalocal_security		"Security Index"
label variable IAasocial_cohesion2		"Social Cohesion Index"
label variable securite_1				"Land Conflict"
label variable securite_2				"Arms Discovery"
label variable securite_3				"Theft of Household Goods"
label variable securite_4				"Physical Aggression"
label variable securite_5				"Domestic Violence"
label variable securite_6				"Armed Robbery or Murder"
label variable association_1			"Farmers"
label variable association_2			"Women"
label variable association_3			"Religious"
label variable association_4			"Youth"
label variable association_6			"Credit and Savings"
label variable association_7			"Political"
label variable association_8			"Human Rights"
label variable association_9			"Other"
label variable migration_cm_q1			"Lived outside Jendouba 12M"
label variable migration_q1				"Num Family Migrated 12M"

*Between

	estimates clear
	preserve 
	keep if (parti==1 | desist==1 | enquete==3) 	
	local RAa ""
	local ctlmean ""

	foreach outcome of local social_cohesion2			{
		glm `outcome'  beneficiaire `ctrl_Aa', family(binomial) link(probit) vce(cluster imada)
		eststo `outcome'	: margins, dydx(beneficiaire) atmeans post
	
	*Column heading variable label
		local varlbl : variable label `outcome'
		local varlbl = subinstr("`varlbl'", " " , "_" , .)
		di "`varlbl'"
		
		estimates store `varlbl'
		local RAa `RAa' `varlbl'

	*control mean	
		sum 	`outcome' if beneficiaire == 0
		estadd scalar Control_Mean= r(mean)		
	}
	
	foreach outcome_ind of varlist `cohesion_indAa' {
		regres `outcome_ind' beneficiaire `ctrl_Aa', vce (cluster imada)
	
	*Column heading variable label
		local varlbl_ind : variable label `outcome_ind'
		local varlbl_ind = subinstr("`varlbl_ind'", " " , "_" , .)
		di "`varlbl_ind'"
		
		estimates store `varlbl_ind'
		local RAa `RAa' `varlbl_ind'
		
		estadd scalar Control_Mean= _b[_cons]	
	}

								estout `RAa'	using	"$report\Social_Cohesion.xls", 		replace 				///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(hhsize drepondant_mat g1_3 g1_4 g1_5 g1_7 _cons)	label 	///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)		eqlabels(none) 	collabels(none) ///
								title			("Between Villages: direct effects on all workers")	varlabels(beneficiaire "Treatment Community") 
		estimates clear
		restore		

*Within (ITT)

		estimates clear
		preserve
		keep if (parti==1 | desist==1 | control==1) 
		local RBa ""
		foreach outcome of local social_cohesion2			{
			glm `outcome'  program `ctrl_Ba', family(binomial) link(probit) vce(cluster imada)
			eststo `outcome'	: margins, dydx(program) atmeans post
			local RBa `RBa' `outcome'

	*control mean	
		sum 	`outcome' if program == 0
		estadd scalar Control_Mean= r(mean)	

		}
		foreach outcome_ind of varlist `cohesion_indBa' {
			regres `outcome_ind' program `ctrl_Ba', vce (cluster imada)
			estimates store RBa`outcome_ind'
			local RBa `RBa' RBa`outcome_ind'

			estadd scalar Control_Mean= _b[_cons]	

		}

								estout `RBa'	using	"$report\Social_Cohesion.xls", 		append 			///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(extra _cons)	label 			///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)	collabels(none) mlabels(none) eqlabels(none)	///
								title			("Within Villages: direct effects on all workers") varlabels(program "Worker")

		estimates clear	
		restore

*WIthin (ATE)

		estimates clear
		preserve
		keep if (parti==1 | control==1)
		local RBb ""
		foreach outcome of local social_cohesion2			{
			glm `outcome'  parti `ctrl_Bb', family(binomial) link(probit) vce(cluster imada)
			eststo `outcome'	: margins, dydx(parti) atmeans post
			local RBb `RBb' `outcome'
			
	*control mean	
		sum 	`outcome' if parti == 0
		estadd scalar Control_Mean= r(mean)	

		}
		foreach outcome_ind of varlist `cohesion_indBb' {
			regres `outcome_ind' parti `ctrl_Bb', vce (cluster imada)
			estimates store RBb`outcome_ind'
			local RBb `RBb' RBb`outcome_ind'
			estadd scalar Control_Mean= _b[_cons]	
		}

								estout `RBb'	using	"$report\Social_Cohesion.xls", 		append 			///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(extra repondant_sex _cons)	label 			///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)	collabels(none) mlabels(none) eqlabels(none)	///
								title			("Within Villages: direct effects on PWP completers") varlabels(parti "PWP completer")
		estimates clear	
		restore

*Infrastructure

		estimates clear
		preserve
		keep if enquete==1
		local RCa ""
		foreach outcome of local social_cohesion2			{
			glm `outcome'  beneficiaire `ctrl_Ca', family(binomial) link(probit) vce(cluster imada)
			eststo `outcome'	: margins, dydx(beneficiaire) atmeans post
			local RCa `RCa' `outcome'
			
	*control mean	
		sum 	`outcome' if beneficiaire == 0
		estadd scalar Control_Mean= r(mean)	

		}
		foreach outcome_ind of varlist `cohesion_indCa' {
			regres `outcome_ind' beneficiaire `ctrl_Ca', vce (cluster imada)
			estimates store RCa`outcome_ind'
			local RCa `RCa' RCa`outcome_ind'
			estadd scalar Control_Mean= _b[_cons]	
		}

								estout `RCa'	using	"$report\Social_Cohesion.xls", 		append 			///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))	label 	drop(_cons)		///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)	collabels(none) mlabels(none) eqlabels(none) 	///
								title			("Infrastructure Effects")		varlabels(beneficiaire "Treatment Community")
		estimates clear
		restore

*Spillovers

		estimates clear
		preserve
		keep if (control==1 | enquete==3)
		local RCb ""
		foreach outcome of local social_cohesion2			{
			glm `outcome'  beneficiaire `ctrl_Cb', family(binomial) link(probit) vce(cluster imada)
			eststo `outcome'	: margins, dydx(beneficiaire) atmeans post
			local RCb `RCb' `outcome'
			
	*control mean	
		sum 	`outcome' if beneficiaire == 0
		estadd scalar Control_Mean= r(mean)	

		}
			foreach outcome_ind of varlist `cohesion_indCb' {
			regres `outcome_ind' beneficiaire `ctrl_Cb', vce (cluster imada)
			estimates store RCb`outcome_ind'
			local RCb `RCb' RCb`outcome_ind'
			estadd scalar Control_Mean= _b[_cons]	
		}

								estout `RCb'	using	"$report\Social_Cohesion.xls", 		append 			///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(hhsize g1_4 _cons)	label 			///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)	collabels(none) mlabels(none) eqlabels(none) 	///
								title			("Spillover Effects")		varlabels(beneficiaire "Treatment Community")						///
								note("Probit regressions on binary variables and OLS regressions on standardized indices. Clustered SE at the imada level.")
								
		estimates clear
		restore




		filefilter "$report/Social_Cohesion.xls" "$report/8Social_Cohesion.xls", from("_") to(" ") replace					









*******[TABLE 9 - CIVIC ENGAGEMENT]******

local civic_indicesAa		IAacivic_engag IAainitiatives IAainitiatives_meeting IAainitiatives_acting IAainformation_sources IAautopia IAaisolation	

local civic_indicesBa		IBacivic_engag IBainitiatives IBainitiatives_meeting IBainitiatives_acting IBainformation_sources IBautopia IBaisolation 

local civic_indicesBb		IBbcivic_engag IBbinitiatives IBbinitiatives_meeting IBbinitiatives_acting IBbinformation_sources IBbutopia IBbisolation 

local civic_indicesCa		ICacivic_engag ICainitiatives ICainitiatives_meeting ICainitiatives_acting ICainformation_sources ICautopia ICaisolation 
							
local civic_indicesCb		ICbcivic_engag ICbinitiatives ICbinitiatives_meeting ICbinitiatives_acting ICbinformation_sources ICbutopia ICbisolation 
							
label variable IAacivic_engag			"Civic Engagement Index"
label variable IAainitiatives			"Local Participation Index"
label variable IAainitiatives_meeting	"Meeting Index"
label variable IAainitiatives_acting	"Acting Index"
label variable IAainformation_sources	"Information Sources Index"
label variable IAautopia				"Liberal Norms Index"
label variable IAaisolation				"Isolation Index"
label variable initiatives_1 			"Village Meeting"
label variable initiatives_2 			"Meet Omda"
label variable initiatives_3 			"Meet Imam"
label variable initiatives_4 			"Contact Police"
label variable initiatives_5 			"Meet Other State Rep"
label variable initiatives_6 			"Meet NGO Rep"
label variable initiatives_7 			"Meet National Assembly Rep"
label variable initiatives_8 			"Meet Influential Non State"
label variable initiatives_9 			"Meet Family or Friends"
label variable initiatives_10 			"Rebuild School or Clinic"
label variable initiatives_11 			"Clear or Widen Road"
label variable initiatives_12 			"Repair Well"
label variable initiatives_13 			"Organize Security Patrol"
label variable initiatives_14 			"Rebuild Mosque"
label variable initiatives_15			"Build Market"
label variable isolement_1 				"Visited other Imada"
label variable isolement_2 				"Traded other Imada"
label variable isolement_3 				"Visited other Delegation"
label variable isolement_4				"Foreign Travel"
label variable utopie_a_dum1  			"All Decisionmaking"
label variable utopie_b_dum1			"All Hold Accountable"
label variable utopie_a_dum3			"All Decisionmaking. Disagree"
label variable utopie_b_dum3			"All Hold Accountable. Disagree"

*Between
						
		estimates clear
		preserve 
		keep if (parti==1 | desist==1 | enquete==3) 

		local RAa ""
		foreach outcome of varlist `civic_indicesAa' {
			regres `outcome' beneficiaire `ctrl_Aa', vce (cluster imada)
		
		*Column heading label variable
			local varlbl : variable label `outcome'
			local varlbl = subinstr("`varlbl'", " " , "_" , .)
			di "`varlbl'"			
			estimates store `varlbl'
			local RAa `RAa' `varlbl'
		*control mean	
			estadd scalar Control_Mean= _b[_cons]	

		}
								estout `RAa'	using	"$report\Civic_Engagement.xls", 		replace 					///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(hhsize drepondant_mat g1_3 g1_4 g1_5 g1_7 _cons)	label 	///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)		collabels(none)						///
								title			("Between Villages: direct effects on all workers")	varlabels(beneficiaire "Treatment Community") 
																																
		estimates clear
		restore
		
		
		
		
		
		
		
		
		
		
		
		
		

*Within (ITT)

		estimates clear
		preserve
		keep if (parti==1 | desist==1 | control==1) 
		local RBa ""
		foreach outcome of varlist `civic_indicesBa' {
			regres `outcome' program `ctrl_Ba', vce (cluster imada)
			estimates store RBa`outcome'
			local RBa `RBa' RBa`outcome'
			
		*control mean	
			estadd scalar Control_Mean= _b[_cons]	

		}
								estout `RBa'	using	"$report\Civic_Engagement.xls", 		append 							///
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
		foreach outcome of varlist `civic_indicesBb' {
			regres `outcome' parti `ctrl_Bb', vce (cluster imada)
			estimates store RBb`outcome'
			local RBb `RBb' RBb`outcome'

		*control mean	
			estadd scalar Control_Mean= _b[_cons]	

		}
								estout `RBb'	using	"$report\Civic_Engagement.xls", 		append 					///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))	drop(extra repondant_sex _cons) 	label	///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)	collabels(none) mlabels(none) 	///
								title			("Within Villages: direct effects on PWP completers") varlabels(parti "PWP completer")
		estimates clear	
		restore

*Infrastructure

		estimates clear
		preserve
		keep if enquete==1
		local RCa ""
		foreach outcome of varlist `civic_indicesCa' {
			regres `outcome' beneficiaire `ctrl_Ca', vce (cluster imada)
			estimates store RCa`outcome'
			local RCa `RCa' RCa`outcome'
			
		*control mean	
			estadd scalar Control_Mean= _b[_cons]	

		}

								estout `RCa'	using	"$report\Civic_Engagement.xls", 		append 					///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(_cons)		label		 			///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)	collabels(none) mlabels(none) 	///
								title			("Infrastructure Effects")		varlabels(beneficiaire "Treatment Community")
		estimates clear
		restore

*Spillovers

		estimates clear
		preserve
		keep if (control==1 | enquete==3)
		local RCb ""
		foreach outcome of varlist `civic_indicesCb' {
			regres `outcome' beneficiaire `ctrl_Cb', vce (cluster imada)
			estimates store RCb`outcome'
			local RCb `RCb' RCb`outcome'
			
		*control mean	
			estadd scalar Control_Mean= _b[_cons]	

		}
								estout `RCb'	using	"$report\Civic_Engagement.xls", 				append			///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(hhsize g1_4 _cons)	label	 		///			 	 					
								stats(N)  		starlevels(* 0.10 ** 0.05 *** 0.01)	collabels(none) mlabels(none) 	///
								title			("Spillover Effects")		varlabels(beneficiaire "Treatment Community")	///
								note("OLS regressions on continuous variables and standardized indices. Clustered SE at the imada level.")
								
		estimates clear
		restore
							
						
	
		filefilter "$report/Civic_Engagement.xls" "$report/9Civic_Engagement.xls", from("_") to(" ") replace						
	

	





*******[TABLE 10 - PSYCHOICAL WELLBEING]******

local psycho_wellbeing2	psy_anxiete psy_exploit psy_depress5 /*psy_accepte_dum1*/ psy_accepte_dum3 	///
						psy_menage_dum3 /*psy_a_menage_dum1*/ psy_a_menage_dum3	
local psycho_internal   psy_anxiete psy_exploit psy_depress5
local psycho_external	/*psy_accepte_dum1*/ psy_accepte_dum3 psy_menage_dum3 				///
						/*psy_a_menage_dum1*/ psy_a_menage_dum3					
//local pearlin_index		pearlin_1 pearlin_2 pearlin_3 pearlin_4 pearlin_5 pearlin_6 pearlin_7


local psycho_indicesAa	IAapsycho_wellbeing2 IAapsycho_internal IAapsycho_external //IAapearlin_index
local psycho_indicesBa	IBapsycho_wellbeing2 IBapsycho_internal IBapsycho_external //IBapearlin_index
local psycho_indicesBb	IBbpsycho_wellbeing2 IBbpsycho_internal IBbpsycho_external //IBbpearlin_index
local psycho_indicesCa	ICapsycho_wellbeing2 ICapsycho_internal ICapsycho_external //ICapearlin_index
local psycho_indicesCb	ICbpsycho_wellbeing2 ICbpsycho_internal ICbpsycho_external //ICbpearlin_index

label variable psy_anxiete 			"Fear Losing Control"
label variable psy_exploit 			"Exploited by Others"
label variable psy_depress5			"Unimportant to Others"
label variable psy_accepte_dum3 	"Accepted by family"
label variable psy_menage_dum3 		"Close with Family"
label variable psy_a_menage_dum3	"HH Accepted in Community"
label variable IAapsycho_wellbeing2 "Psych Wellbeing Index"
label variable IAapsycho_internal 	"Internal Wellbeing Index"
label variable IAapsycho_external 	"External Wellbaing Index"
*label variable IAapearlin_index		"Pearlin Index"

*Between

	estimates clear
	preserve 
	keep if (parti==1 | desist==1 | enquete==3) 	
	local RAa ""
	local ctlmean ""

	foreach outcome of local psycho_wellbeing2			{
		glm `outcome'  beneficiaire `ctrl_Aa', family(binomial) link(probit) vce(cluster imada)
		eststo `outcome'	: margins, dydx(beneficiaire) atmeans post
	
	*Column heading variable label
			local varlbl : variable label `outcome'
			local varlbl = subinstr("`varlbl'", " " , "_" , .)
			di "`varlbl'"
			
			estimates store `varlbl'
			local RAa `RAa' `varlbl'

	*control mean	
		sum 	`outcome' if beneficiaire == 0
		estadd scalar Control_Mean= r(mean)				

	}
		foreach outcome_ind of varlist `psycho_indicesAa' {
			regres `outcome_ind' beneficiaire `ctrl_Aa', vce (cluster imada)
	
	*Column heading variable label
				local varlbl_ind : variable label `outcome_ind'
				local varlbl_ind = subinstr("`varlbl_ind'", " " , "_" , .)
				di "`varlbl_ind'"
				estimates store `varlbl_ind'
				local RAa `RAa' `varlbl_ind'
				
		*control mean	
			estadd scalar Control_Mean= _b[_cons]	
		}

								estout `RAa'	using	"$report\Psych_Wellbeing.xls", 		replace 				///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(hhsize drepondant_mat g1_3 g1_4 g1_5 g1_7 _cons)	label 	///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)		eqlabels(none) 	collabels(none) ///
								title			("Between Villages: direct effects on all workers")	varlabels(beneficiaire "Treatment Community") 
		estimates clear
		restore		

*Within (ITT)

		estimates clear
		preserve
		keep if (parti==1 | desist==1 | control==1) 
		local RBa ""
		foreach outcome of local psycho_wellbeing2			{
			glm `outcome'  program `ctrl_Ba', family(binomial) link(probit) vce(cluster imada)
			eststo `outcome'	: margins, dydx(program) atmeans post
			local RBa `RBa' `outcome'
			
	*control mean	
		sum 	`outcome' if program == 0
		estadd scalar Control_Mean= r(mean)	

		}
		
		foreach outcome_ind of varlist `psycho_indicesBa' {
			regres `outcome_ind' program `ctrl_Ba', vce (cluster imada)
			estimates store RBa`outcome_ind'
			local RBa `RBa' RBa`outcome_ind'
		*control mean	
			estadd scalar Control_Mean= _b[_cons]	

		}

								estout `RBa'	using	"$report\Psych_Wellbeing.xls", 		append 			///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(extra _cons)	label 			///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)	collabels(none) mlabels(none) eqlabels(none)	///
								title			("Within Villages: direct effects on all workers") varlabels(program "Worker")

		estimates clear	
		restore

*Within (ATE)

		estimates clear
		preserve
		keep if (parti==1 | control==1)
		local RBb ""
		foreach outcome of local psycho_wellbeing2			{
			glm `outcome'  parti `ctrl_Bb', family(binomial) link(probit) vce(cluster imada)
			eststo `outcome'	: margins, dydx(parti) atmeans post
			local RBb `RBb' `outcome'
			
	*control mean	
		sum 	`outcome' if parti == 0
		estadd scalar Control_Mean= r(mean)	

		}
		foreach outcome_ind of varlist `psycho_indicesBb' {
			regres `outcome_ind' parti `ctrl_Bb', vce (cluster imada)
			estimates store RBb`outcome_ind'
			local RBb `RBb' RBb`outcome_ind'
		*control mean	
			estadd scalar Control_Mean= _b[_cons]	
		}

								estout `RBb'	using	"$report\Psych_Wellbeing.xls", 		append 			///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(extra repondant_sex _cons)	label 			///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)	collabels(none) mlabels(none) eqlabels(none)	///
								title			("Within Villages: direct effects on PWP completers") varlabels(parti "PWP completer")
		estimates clear	
		restore

*Infrastructure

		estimates clear
		preserve
		keep if enquete==1
		local RCa ""
		foreach outcome of local psycho_wellbeing2			{
			glm `outcome'  beneficiaire `ctrl_Ca', family(binomial) link(probit) vce(cluster imada)
			eststo `outcome'	: margins, dydx(beneficiaire) atmeans post
			local RCa `RCa' `outcome'
			
	*control mean	
		sum 	`outcome' if beneficiaire == 0
		estadd scalar Control_Mean= r(mean)	

		}
		foreach outcome_ind of varlist `psycho_indicesCa' {
			regres `outcome_ind' beneficiaire `ctrl_Ca', vce (cluster imada)
			estimates store RCa`outcome_ind'
			local RCa `RCa' RCa`outcome_ind'
		*control mean	
			estadd scalar Control_Mean= _b[_cons]	

		}

								estout `RCa'	using	"$report\Psych_Wellbeing.xls", 		append 			///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))	label 		drop(_cons)	///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)	collabels(none) mlabels(none) eqlabels(none) 	///
								title			("Infrastructure Effects")		varlabels(beneficiaire "Treatment Community")
		estimates clear
		restore

*Spillovers

		estimates clear
		preserve
		keep if (control==1 | enquete==3)
		local RCb ""
		foreach outcome of local psycho_wellbeing2			{
			glm `outcome'  beneficiaire `ctrl_Cb', family(binomial) link(probit) vce(cluster imada)
			eststo `outcome'	: margins, dydx(beneficiaire) atmeans post
			local RCb `RCb' `outcome'
			
	*control mean	
		sum 	`outcome' if beneficiaire == 0
		estadd scalar Control_Mean= r(mean)	

		}
		foreach outcome_ind of varlist `psycho_indicesCb' {
			regres `outcome_ind' beneficiaire `ctrl_Cb', vce (cluster imada)
			estimates store RCb`outcome_ind'
			local RCb `RCb' RCb`outcome_ind'
		*control mean	
			estadd scalar Control_Mean= _b[_cons]	

		}

								estout `RCb'	using	"$report\Psych_Wellbeing.xls", 		append 			///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(hhsize g1_4 _cons)	label 			///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)	collabels(none) mlabels(none) eqlabels(none) 	///
								title			("Spillover Effects")		varlabels(beneficiaire "Treatment Community")						///
								note("Probit regressions on binary variables and OLS regressions on standardized indices. Clustered SE at the imada level.")
								
		estimates clear
		restore





		filefilter "$report/Psych_Wellbeing.xls" "$report/10Psych_Wellbeing.xls", from("_") to(" ") replace						





*******[TABLE 11 - INTRAHOUSEHOLD ALLOCATIONS]******

local overall_intrahouse2	intrahh_1 intrahh_2 intrahh_7 intrahh_11 emploiw ///
							violence_physical violence_emotional
local intrahhAa				IAaoverall_intrahouse2 IAawomens_decision IAaviolence_ag_women
local intrahhBa				IBaoverall_intrahouse2 IBawomens_decision IBaviolence_ag_women
local intrahhBb				IBboverall_intrahouse2 IBbwomens_decision IBbviolence_ag_women
local intrahhCa				ICaoverall_intrahouse2 ICawomens_decision ICaviolence_ag_women
local intrahhCb				ICboverall_intrahouse2 ICbwomens_decision ICbviolence_ag_women


label variable intrahh_1 				"Earned Past 6 Months"
label variable intrahh_2 				"Spend own Money"
label variable intrahh_7 				"Spouse Decides your Money"
label variable intrahh_11 				"Money Taken Past 6M"
label variable emploiw 					"Female Employed"
label variable violence_physical 		"Physical Violence"
label variable violence_emotional		"Emotional Violence"
label variable IAaoverall_intrahouse2 	"Intrahousehold Index"
label variable IAawomens_decision 		"Womens Decision Index"
label variable IAaviolence_ag_women		"Violence to Women Index"

*Between	
	
	estimates clear
	preserve 
	keep if (parti==1 | desist==1 | enquete==3) 	
	local RAa ""

	foreach outcome of local overall_intrahouse2			{
		glm `outcome'  beneficiaire /*`ctrl_Aa'*/ drepondant_mat, family(binomial) link(probit) vce(cluster imada)
		eststo `outcome'	: margins, dydx(beneficiaire) atmeans post
	
	*Column heading variable labels
			local varlbl : variable label `outcome'
			local varlbl = subinstr("`varlbl'", " " , "_" , .)
			di "`varlbl'"
			estimates store `varlbl'
			local RAa `RAa' `varlbl'
			
		*control mean	
			sum 	`outcome' if beneficiaire == 0
			estadd scalar Control_Mean= r(mean)	

	}
		foreach outcome_ind of varlist `intrahhAa' {
			regres `outcome_ind' beneficiaire `ctrl_Aa', vce (cluster imada)
		
		*Column heading variable labels
			local varlbl_ind : variable label `outcome_ind'
			local varlbl_ind = subinstr("`varlbl_ind'", " " , "_" , .)
			di "`varlbl_ind'"
			estimates store `varlbl_ind'
			local RAa `RAa' `varlbl_ind'
	
		*control mean	
			estadd scalar Control_Mean= _b[_cons]	
		}

								estout `RAa'	using	"$report\Intrahh.xls", 		replace 				///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(hhsize drepondant_mat g1_3 g1_4 g1_5 g1_7 _cons)	label 	///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)		eqlabels(none) 	collabels(none) ///
								title			("Between Villages: direct effects on all workers")	varlabels(beneficiaire "Treatment Community") 
		estimates clear
		restore		

*Within (ITT)

		estimates clear
		preserve
		keep if (parti==1 | desist==1 | control==1) 
		local RBa ""
		foreach outcome of local overall_intrahouse2			{
			glm `outcome'  program `ctrl_Ba', family(binomial) link(probit) vce(cluster imada)
			eststo `outcome'	: margins, dydx(program) atmeans post
			local RBa `RBa' `outcome'

		*control mean	
			sum 	`outcome' if program == 0
			estadd scalar Control_Mean= r(mean)	

		}
			foreach outcome_ind of varlist `intrahhBa' {
			regres `outcome_ind' program `ctrl_Ba', vce (cluster imada)
			estimates store RBa`outcome_ind'
			local RBa `RBa' RBa`outcome_ind'

		*control mean	
			estadd scalar Control_Mean= _b[_cons]	
		}

								estout `RBa'	using	"$report\Intrahh.xls", 		append 			///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(extra _cons)	label 			///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)	collabels(none) mlabels(none) eqlabels(none)	///
								title			("Within Villages: direct effects on all workers") varlabels(program "Worker")

		estimates clear	
		restore

*Within (ATE)

		estimates clear
		preserve
		keep if (parti==1 | control==1)
		local RBb ""
		foreach outcome of local overall_intrahouse2			{
			glm `outcome'  parti `ctrl_Bb', family(binomial) link(probit) vce(cluster imada)
			eststo `outcome'	: margins, dydx(parti) atmeans post
			local RBb `RBb' `outcome'
		
		*control mean	
			sum 	`outcome' if parti == 0
			estadd scalar Control_Mean= r(mean)	

		}
			foreach outcome_ind of varlist `intrahhBb' {
			regres `outcome_ind' parti `ctrl_Bb', vce (cluster imada)
			estimates store RBb`outcome_ind'
			local RBb `RBb' RBb`outcome_ind'
			
		*control mean	
			estadd scalar Control_Mean= _b[_cons]	
		}

								estout `RBb'	using	"$report\Intrahh.xls", 		append 			///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(extra repondant_sex _cons)	label 			///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)	collabels(none) mlabels(none) eqlabels(none)	///
								title			("Within Villages: direct effects on PWP completers") varlabels(parti "PWP completer")
		estimates clear	
		restore

*Infrastructure

		estimates clear
		preserve
		keep if enquete==1
		local RCa ""
		foreach outcome of local overall_intrahouse2			{
			glm `outcome'  beneficiaire `ctrl_Ca', family(binomial) link(probit) vce(cluster imada)
			eststo `outcome'	: margins, dydx(beneficiaire) atmeans post
			local RCa `RCa' `outcome'
			
		*control mean	
			sum 	`outcome' if beneficiaire == 0
			estadd scalar Control_Mean= r(mean)	

		}
			foreach outcome_ind of varlist `intrahhCa' {
			regres `outcome_ind' beneficiaire `ctrl_Ca', vce (cluster imada)
			estimates store RCa`outcome_ind'
			local RCa `RCa' RCa`outcome_ind'
			
		*control mean	
			estadd scalar Control_Mean= _b[_cons]	
		}

								estout `RCa'	using	"$report\Intrahh.xls", 		append 			///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))	label 		drop(_cons)	///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)	collabels(none) mlabels(none) eqlabels(none) 	///
								title			("Infrastructure Effects")		varlabels(beneficiaire "Treatment Community")
		estimates clear
		restore

*Spillovers

		estimates clear
		preserve
		keep if (control==1 | enquete==3)
		local RCb ""
		foreach outcome of local overall_intrahouse2			{
			glm `outcome'  beneficiaire `ctrl_Cb', family(binomial) link(probit) vce(cluster imada)
			eststo `outcome'	: margins, dydx(beneficiaire) atmeans post
			local RCb `RCb' `outcome'
			
		*control mean	
			sum 	`outcome' if beneficiaire == 0
			estadd scalar Control_Mean= r(mean)	

		}
			foreach outcome_ind of varlist `intrahhCb' {
			regres `outcome_ind' beneficiaire `ctrl_Cb', vce (cluster imada)
			estimates store RCb`outcome_ind'
			local RCb `RCb' RCb`outcome_ind'
			
		*control mean	
			estadd scalar Control_Mean= _b[_cons]	
		}

								estout `RCb'	using	"$report\Intrahh.xls", 		append 			///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(hhsize g1_4 _cons)	label 			///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)	collabels(none) mlabels(none) eqlabels(none) 	///
								title			("Spillover Effects")		varlabels(beneficiaire "Treatment Community")						///
								note("Probit regressions on binary variables and OLS regressions standardized indices. Clustered SE at the imada level.")
								
		estimates clear
		restore


		filefilter "$report/Intrahh.xls" "$report/11Intrahh.xls", from("_") to(" ") replace								
		
		
		

*******[TABLE 12 - VIOLENCE AGAINST WOMEN]******
local violence_ag_women 	violence_1_2 violence_1_3 violence_1_4 violence_1_5 violence_1_6 ///
							violence_1_7 violence_1_8 violence_1_9 /*violence_1_10*/ violence_1_11 ///
							violence_1_16 violence_1_17 violence_1_18								// 10 not used as not enough variation for Cb and no results elsewhere

label variable violence_1_2		"Humiliated or Belittled"
label variable violence_1_3		"Intimidated or Scared"
label variable violence_1_4		"Threatened You"
label variable violence_1_5		"Threatened Loved One"
label variable violence_1_6		"Hit or Thrown At"
label variable violence_1_7		"Pushed or Hair Pulled"
label variable violence_1_8		"Punched"
label variable violence_1_9		"Kicked"
label variable violence_1_10	"Smothered or Burned"
label variable violence_1_11	"Threatened with Weapon"
label variable violence_1_16	"Forbidden to Work"
label variable violence_1_17	"Money Taken"
label variable violence_1_18	"Thrown out of House"

*Between
	
	estimates clear
	preserve 
	keep if (parti==1 | desist==1 | enquete==3) 	
	local RAa ""
	local ctlmean ""

	foreach outcome of local violence_ag_women			{
		glm `outcome'  beneficiaire `ctrl_Aa', family(binomial) link(probit) vce(cluster imada)
		eststo `outcome'	: margins, dydx(beneficiaire) atmeans post
		
		*Column heading label variable
			local varlbl : variable label `outcome'
			local varlbl = subinstr("`varlbl'", " " , "_" , .)
			di "`varlbl'"
			
			estimates store `varlbl'
			local RAa `RAa' `varlbl'
			
		*control mean	
			sum 	`outcome' if beneficiaire == 0
			estadd scalar Control_Mean= r(mean)	
	}
			regres IAaviolence_ag_women beneficiaire `ctrl_Aa', vce (cluster imada)
			estimates store Violence_to_Women_Index
			local RAa `RAa' Violence_to_Women_Index
		*control mean	
			estadd scalar Control_Mean= _b[_cons]	

								estout `RAa'	using	"$report\violence_ag_women.xls", 		replace 				///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(hhsize drepondant_mat g1_3 g1_4 g1_5 g1_7 _cons)	label 	///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)		eqlabels(none) 	collabels(none) ///
								title			("Between Villages: direct effects on all workers")	varlabels(beneficiaire "Treatment Community") 
		estimates clear
		restore		

*Within (ITT)

		estimates clear
		preserve
		keep if (parti==1 | desist==1 | control==1) 
		local RBa ""
		foreach outcome of local violence_ag_women			{
			glm `outcome'  program `ctrl_Ba', family(binomial) link(probit) vce(cluster imada)
			eststo `outcome'	: margins, dydx(program) atmeans post
			local RBa `RBa' `outcome'
			
		*control mean	
			sum 	`outcome' if program == 0
			estadd scalar Control_Mean= r(mean)	

		}
			regres IBaviolence_ag_women program `ctrl_Ba', vce (cluster imada)
			estimates store RBaviolence_ag_women
			local RBa `RBa' RBaviolence_ag_women
		*control mean	
			estadd scalar Control_Mean= _b[_cons]	

								estout `RBa'	using	"$report\violence_ag_women.xls", 		append 			///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(extra  _cons)	label 			///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)	collabels(none) mlabels(none) eqlabels(none)	///
								title			("Within Villages: direct effects on all workers") varlabels(program "Worker")

		estimates clear	
		restore

*Within (ATE)

		estimates clear
		preserve
		keep if (parti==1 | control==1)
		local RBb ""
		foreach outcome of local violence_ag_women			{
			glm `outcome'  parti `ctrl_Bb', family(binomial) link(probit) vce(cluster imada)
			eststo `outcome'	: margins, dydx(parti) atmeans post
			local RBb `RBb' `outcome'

		*control mean	
			sum 	`outcome' if parti == 0
			estadd scalar Control_Mean= r(mean)	

		}
			regres IBbviolence_ag_women parti `ctrl_Bb', vce (cluster imada)
			estimates store RBbviolence_ag_women
			local RBb `RBb' RBbviolence_ag_women
		*control mean	
			estadd scalar Control_Mean= _b[_cons]	
			
								estout `RBb'	using	"$report\violence_ag_women.xls", 		append 			///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(extra repondant_sex  _cons)	label 			///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)	collabels(none) mlabels(none) eqlabels(none)	///
								title			("Within Villages: direct effects on PWP completers") varlabels(parti "PWP completer")
		estimates clear	
		restore

*Infrastructure

		estimates clear
		preserve
		keep if enquete==1
		local RCa ""
		foreach outcome of local violence_ag_women			{
			glm `outcome'  beneficiaire `ctrl_Ca', family(binomial) link(probit) vce(cluster imada)
			eststo `outcome'	: margins, dydx(beneficiaire) atmeans post
			local RCa `RCa' `outcome'

		*control mean	
			sum 	`outcome' if beneficiaire == 0
			estadd scalar Control_Mean= r(mean)	

		}
			regres ICaviolence_ag_women beneficiaire `ctrl_Ca', vce (cluster imada)
			estimates store RCaviolence_ag_women
			local RCa `RCa' RCaviolence_ag_women
		*control mean	
			estadd scalar Control_Mean= _b[_cons]	

								estout `RCa'	using	"$report\violence_ag_women.xls", 		append 			///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))	label 	drop( _cons)		///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)	collabels(none) mlabels(none) eqlabels(none) 	///
								title			("Infrastructure Effects")		varlabels(beneficiaire "Treatment Community")
		estimates clear
		restore

*Spillovers
		
		estimates clear
		preserve
		keep if (control==1 | enquete==3)
		local RCb ""
		foreach outcome of local violence_ag_women			{
			glm `outcome'  beneficiaire `ctrl_Cb', family(binomial) link(probit) vce(cluster imada)
			eststo `outcome'	: margins, dydx(beneficiaire) atmeans post
			local RCb `RCb' `outcome'
			
		*control mean	
			sum 	`outcome' if beneficiaire == 0
			estadd scalar Control_Mean= r(mean)	

		}
			regres ICbviolence_ag_women beneficiaire `ctrl_Cb', vce (cluster imada)
			estimates store RCbviolence_ag_women
			local RCb `RCb' RCbviolence_ag_women
		*control mean	
			estadd scalar Control_Mean= _b[_cons]	

								estout `RCb'	using	"$report\violence_ag_women.xls", 		append 			///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(hhsize g1_4 _cons)	label 			///			 	 					
								stats(Control_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)	collabels(none) mlabels(none) eqlabels(none) 	///
								title			("Spillover Effects")		varlabels(beneficiaire "Treatment Community")						///
								note("Probit regressions on binary variables and OLS regression on the standardized index. Clustered SE at the imada level.")

		estimates clear
		restore


		filefilter "$report/violence_ag_women.xls" "$report/12violence_ag_women.xls", from("_") to(" ") replace								
		








	
		
