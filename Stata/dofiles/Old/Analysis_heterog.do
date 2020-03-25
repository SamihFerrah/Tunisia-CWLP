*AJOUTER LES INDEX À L'ANALYSE

set matsize 10000
set more off
*ADD THE VARIABLE: RECEIVED A PWP PREVIOUSLY OR NOT.

*all indiv outcomes, in order of category. with repetition for rev_total and psych_a_menage

*controls:ADJUSTED TO REFLECT THE ONES THAT ARE NOT BALANCED.

*1)PWP
*Within
local ctrl_Ba_PWP extra 
local ctrl_Bb_PWP extra repondant_sex

*2)Gender
*Between
local ctrl_Aa_gender hhsize drepondant_mat g1_3 g1_4 g1_5 g1_7
*Within
local ctrl_Ba_gender extra 
local ctrl_Bb_gender extra repondant_sex

*3)Prev PWP
*Between
local ctrl_Aa_prev_PWP hhsize drepondant_mat g1_3 g1_4 g1_5 g1_7
*Within
local ctrl_Ba_prev_PWP extra 
local ctrl_Bb_prev_PWP extra repondant_sex


*CREATE DATASETS FOR ANALYSIS FROM MULTIPLE IMPUTATION
use $stata/enquete_All3, clear 

gen program=(parti==1 | desist==1)

****************************************
*ANALYSIS OF HETEROGENEITY
****************************************

*TO BE PERFORMED ONLY ON INDEXES, AS PER WRITTEN INSTRUCTIONS.
*THREE PARAMETERS AVAILABLE FOR ANALYSIS (AMONG REQUESTED) : TYPE OF PWP PROJECT, GENDER, HAS HAD OTHER PWP PREVIOUSLY IN IMADA OF RESIDENCE
/*
We have six "types" of individuals in our sample
1)      Workers on the ‘nominative lists’ (primary list of replacement lists) who were randomized into the program and ended up working
2)      Workers on the ‘nominative lists’ (primary list of replacement lists) who were randomized into the program and ended up not working (les desistes)
3)      Workers on the ‘nominative lists’ (primary list of replacement lists) who were randomized out of the program
4)      Representative random samples of individuals from treatment imadas
5)      Representative random samples of individuals from control imadas
6)      Eligible and randomly selected workers from control imadas (i.e., synthestic controls)
*/

local IndexAa ///
					IAafood_consump_win IAaexpenditure_win IAacoping_mechanisms IAahh_assets2 IAahuman_capital2 ///
					IAawage_employment2 IAadebts_and_savings2 IAasocial_cohesion2 IAacivic_engag 				///
					IAapsycho_wellbeing IAaoverall_intrahouse2 

local IndexBa ///
					IBafood_consump_win IBaexpenditure_win IBacoping_mechanisms IBahh_assets2 IBahuman_capital2 ///
					IBawage_employment2 IBadebts_and_savings2 IBasocial_cohesion2 IBacivic_engag 				///
					IBapsycho_wellbeing IBaoverall_intrahouse2 

local IndexBb ///
					IBbfood_consump_win IBbexpenditure_win IBbcoping_mechanisms IBbhh_assets2 IBbhuman_capital2 ///
					IBbwage_employment2 IBbdebts_and_savings2 IBbsocial_cohesion2 IBbcivic_engag 				///
					IBbpsycho_wellbeing IBboverall_intrahouse2  

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

label variable IBafood_consump_win 		"Food Consumption"
label variable IBaexpenditure_win 		"Other Expenditure"
label variable IBacoping_mechanisms 	"Coping Mechanisms"
label variable IBahh_assets2 			"HH Assets"
label variable IBahouse_ownership		"House Ownership"
label variable IBalarge_assets 			"Large Assets"
label variable IBasmall_assets 			"Small Assets"
label variable IBahome_assets 			"Home Assets"
label variable IBacomms_assets 			"Communications Assets"
label variable IBaproductive_assets 	"Productive Assets"
label variable IBahuman_capital2 		"Human Capital"
label variable IBawage_employment2		"Wage Employment"
label variable IBaother_employment		"Other Employment"
*label variable IBanon_agri_enterp 		"Non-Agricultural Enterprise"
label variable IBadebts_and_savings2 	"Debts and Savings"
label variable IBadebts				 	"Debts"
label variable IBasavings 				"Savings"
label variable IBaemploy_aspirations 	"Employment Aspirations"
label variable IBasocial_cohesion2 		"Social Cohesion"
label variable IBacomm_groups 			"Community Groups"
label variable IBalocal_conflict 		"Local Conflict"
label variable IBarecent_migration		"Recent Migration"
label variable IBalocal_security 		"Local Security"
label variable IBacivic_engag 			"Civic Engagement"
label variable IBainitiatives 			"Local Participation"
label variable IBainitiatives_meeting 	"Local Meeting"
label variable IBainitiatives_acting	"Local Acting"
label variable IBainformation_sources 	"Information Sources"
label variable IBautopia 				"Liberal Norms"
label variable IBaisolation 			"Isolation"
label variable IBapsycho_wellbeing2 	"Psychological Wellbeing"	
*label variable IBapearlin_index 		"Pearlin Index"
label variable IBaoverall_intrahouse2 	"Intrahousehold Dynamics"
label variable IBawomens_decision 		"Female Decisionmaking"
label variable IBaviolence_ag_women 	"Violence against Women"
label variable IBapsycho_internal 		"Internal Wellbeing"
label variable IBapsycho_external		"External Wellbeing"

*gen program=(parti==1 | desist==1)
*1ST: TYPE OF PWP PROJECT
*************************

*B)      Within village effects on the workers:
*a.      ITT: [(1) + (2)] vs (3)

estimates clear

preserve
keep if (parti==1 | desist==1 | control==1) 

local Indiv ""
foreach outcome of local IndexBa {
regres `outcome' program##typepwp_dum1 program##typepwp_dum2 `ctrl_Ba_PWP', vce (cluster imada)
		local varlbl : variable label `outcome'	
		local varlbl = subinstr("`varlbl'", " " , "_" , .)
		di "`varlbl'"
		estimates store `varlbl'
		local Indiv `Indiv' `varlbl'

}
								estout 			`Indiv' using "$report/AnalysisHeterog_PWP.xls", 		 replace					///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))												///
								drop			(extra _cons 0.program#0.typepwp_dum1 0.program#1.typepwp_dum1 						///
												1.program#0.typepwp_dum1 0.typepwp_dum2 0.typepwp_dum1 0.program				///
												0.program#0.typepwp_dum2 0.program#1.typepwp_dum2 1.program#0.typepwp_dum2		///
												1.typepwp_dum1 1.typepwp_dum2)													///
								stats(N)  		starlevels(* 0.10 ** 0.05 *** 0.01)		collabels(none)							///
								title			("Within Villages: direct effects on all workers")								///
								varlabels		(1.program "Worker" 1.program#1.typepwp_dum1 "Worker*School" 					///
												1.program#1.typepwp_dum2 "Worker*Road") 

estimates clear	

restore


*b.      ATE: (1) vs (3)

estimates clear
preserve
keep if (parti==1 | control==1)

local Indiv ""
foreach outcome of local IndexBb {
regres `outcome' parti##typepwp_dum1 parti##typepwp_dum2 `ctrl_Bb_PWP', vce (cluster imada)
estimates store Indiv`outcome'
local Indiv `Indiv' Indiv`outcome'
}
								estout 			`Indiv' using "$report/AnalysisHeterog_PWP.xls", 		 append					///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))												///
								drop			(extra repondant_sex _cons 0.parti#0.typepwp_dum1 0.parti#1.typepwp_dum1 						///
												1.parti#0.typepwp_dum1 0.typepwp_dum2 0.typepwp_dum1 0.parti				///
												0.parti#0.typepwp_dum2 0.parti#1.typepwp_dum2 1.parti#0.typepwp_dum2		///
												1.typepwp_dum1 1.typepwp_dum2)												///
								stats(N)  		starlevels(* 0.10 ** 0.05 *** 0.01)		collabels(none)	mlabels(none)		///
								title			("Within Villages: direct effects on all workers")							///
								varlabels		(1.parti "PWP Completer" 1.parti#1.typepwp_dum1 "PWP Completer*School" 		///
												1.parti#1.typepwp_dum2 "PWP Completer*Road") 								///
								note("OLS regressions on standardized indices with robust standard errors clustered at the imada level")													
												

estimates clear	

restore
		filefilter "$report/AnalysisHeterog_PWP.xls" "$report/Heterog_PWP.xls", from("_") to(" ") replace


*2ND: GENDER
*************************

*A)      Between villages effects on the workers:
*a.      ITT: [(1) + (2)] vs (6)

estimates clear
preserve 
keep if (parti==1 | desist==1 | enquete==3) 

local Indiv ""
foreach outcome of local IndexAa {
	regres `outcome' beneficiaire##repondant_sex `ctrl_Aa_gender', vce (cluster imada)
		local varlbl : variable label `outcome'	
		local varlbl = subinstr("`varlbl'", " " , "_" , .)
		di "`varlbl'"
		estimates store `varlbl'
		local Indiv `Indiv' `varlbl'
}
								estout `Indiv'	using	"$report\AnalysisHeterog_gender.xls", 		replace 					///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))													///
								drop			(hhsize drepondant_mat g1_3 g1_4 g1_5 g1_7 _cons 0.beneficiaire#0.repondant_sex 0.beneficiaire#1.repondant_sex 			///
												1.beneficiaire#0.repondant_sex 0.repondant_sex 0.beneficiaire)					///
								stats(N)  		starlevels(* 0.10 ** 0.05 *** 0.01)		collabels(none)							///
								title			("Between Villages: direct effects on all workers")								///
								varlabels		(1.beneficiaire "Treatment Community" 1.repondant_sex "Male" 					///
												1.beneficiaire#1.repondant_sex "Treatment Community*Male") 

estimates clear	
restore



*B)      Within village effects on the workers:
*a.      ITT: [(1) + (2)] vs (3)

 


preserve
keep if (parti==1 | desist==1 | control==1) 

local Indiv ""
foreach outcome of local IndexBa {
regres `outcome' program##repondant_sex `ctrl_Ba_gender', vce (cluster imada) //No controls in ctrl_Ba_gender
estimates store `outcome'
local Indiv `Indiv' `outcome'
}
								estout `Indiv'	using	"$report\AnalysisHeterog_gender.xls", 		append	 					///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))													///
								drop			(extra _cons 0.program#0.repondant_sex 0.program#1.repondant_sex 						///
												1.program#0.repondant_sex 0.repondant_sex 0.program)							///
								stats(N)  		starlevels(* 0.10 ** 0.05 *** 0.01)		collabels(none)	mlabels(none)			///
								title			("Within Villages: direct effects on all workers")								///
								varlabels		(_cons "Ctrl Mean" 1.program "Worker" 1.repondant_sex "Male" 					///
												1.program#1.repondant_sex "Worker*Male") 

estimates clear	


restore


*b.      ATE: (1) vs (3) 

estimates clear
preserve
keep if (parti==1 | control==1)

local Indiv ""
foreach outcome of local IndexBb {
regres `outcome' parti##repondant_sex `ctrl_Bb_gender', vce (cluster imada)
estimates store `outcome'
local Indiv `Indiv' `outcome'
}
								estout `Indiv'	using	"$report\AnalysisHeterog_gender.xls", 		append	 					///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))													///
								drop			(extra repondant_sex _cons 0.parti#0.repondant_sex 0.parti#1.repondant_sex 							///
												1.parti#0.repondant_sex 0.repondant_sex 0.parti)								///
								stats(N)  		starlevels(* 0.10 ** 0.05 *** 0.01)		collabels(none)		mlabels(none)		///
								title			("Within Villages: direct effects on PWP completers")							///
								varlabels		(_cons "Ctrl Mean" 1.parti "PWP Completer" 1.repondant_sex "Male" 				///
												1.parti#1.repondant_sex "PWP Completer*Male") 									///
								note("OLS regressions on standardized indices with robust standard errors clustered at the imada level")													

estimates clear	

restore

		filefilter "$report/AnalysisHeterog_gender.xls" "$report/Heterog_gender.xls", from("_") to(" ") replace


*3RD: HAS HAD OTHER PWP PREVIOUSLY IN IMADA OF RESIDENCE
*************************

*A)      Between villages effects on the workers:
*a.      ITT: [(1) + (2)] vs (6)

estimates clear
preserve 
keep if (parti==1 | desist==1 | enquete==3) 

local Indiv ""
foreach outcome of local IndexAa {
regres `outcome' beneficiaire##prev_PWP `ctrl_Aa_prev_PWP', vce (cluster imada)
		local varlbl : variable label `outcome'	
		local varlbl = subinstr("`varlbl'", " " , "_" , .)
		di "`varlbl'"
		estimates store `varlbl'
		local Indiv `Indiv' `varlbl'
}
								estout 			`Indiv' using "$report/AnalysisHeterog_prevPWP.xls",  replace						///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))													///
								drop			(hhsize drepondant_mat g1_3 g1_4 g1_5 g1_7 _cons 0.beneficiaire#0.prev_PWP 0.beneficiaire#1.prev_PWP			 			///
												1.beneficiaire#0.prev_PWP 0.prev_PWP 0.beneficiaire)							///
								stats(N)  		starlevels(* 0.10 ** 0.05 *** 0.01)		collabels(none)							///
								title			("Between Villages: direct effects on all workers")								///
								varlabels		(1.beneficiaire "Treatment Community" 1.prev_PWP "Previous PWP" 						///
												1.beneficiaire#1.prev_PWP "Treatment Community*Previous PWP") 

estimates clear	

restore


*B)      Within village effects on the workers: 
*a.      ITT: [(1) + (2)] vs (3)

estimates clear
*gen program=(parti==1 | desist==1)

preserve
keep if (parti==1 | desist==1 | control==1) 

local Indiv ""
foreach outcome of local IndexBa {
regres `outcome' program##prev_PWP `ctrl_Ba_prev_PWP', vce (cluster imada) //No controls in ctrl_Ba_gender
estimates store Indiv`outcome'
local Indiv `Indiv' Indiv`outcome'
}
								estout 			`Indiv' using "$report/AnalysisHeterog_prevPWP.xls",  append						///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))													///
								drop			(extra _cons 0.program#0.prev_PWP 0.program#1.prev_PWP 						///
												1.program#0.prev_PWP 0.prev_PWP 0.program)							///
								stats(N)  		starlevels(* 0.10 ** 0.05 *** 0.01)		collabels(none)	mlabels(none)			///
								title			("Within Villages: direct effects on all workers")								///
								varlabels		(_cons "Ctrl Mean" 1.program "Worker" 1.prev_PWP "Previous PWP" 					///
												1.program#1.prev_PWP "Worker*Previous PWP") 

estimates clear	
	
restore


*b.      ATE: (1) vs (3)

estimates clear
preserve
keep if (parti==1 | control==1)

local Indiv ""
foreach outcome of local IndexBb {
regres `outcome' parti##prev_PWP `ctrl_Bb_prev_PWP', vce (cluster imada)
estimates store Indiv`outcome'
local Indiv `Indiv' Indiv`outcome'
}
								estout 			`Indiv' using "$report/AnalysisHeterog_prevPWP.xls",  append					///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))											///
								drop			(extra repondant_sex _cons 0.parti#0.prev_PWP 0.parti#1.prev_PWP 									///
												1.parti#0.prev_PWP 0.prev_PWP 0.parti)											///
								stats(N)  		starlevels(* 0.10 ** 0.05 *** 0.01)		collabels(none)		mlabels(none)		///
								title			("Within Villages: direct effects on PWP completers")							///
								varlabels		(_cons "Ctrl Mean" 1.parti "PWP Completer" 1.prev_PWP "Previous PWP" 			///
												1.parti#1.prev_PWP "PWP Completer*Previous PWP") 								///
								note("OLS regressions on standardized indices with robust standard errors clustered at the imada level")													
estimates clear	

restore


		filefilter "$report/AnalysisHeterog_prevPWP.xls" "$report/Heterog_prevPWP.xls", from("_") to(" ") replace

save "$report/analyzed_dataset.dta", replace
		
*end of do file

*/





