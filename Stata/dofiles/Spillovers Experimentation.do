********************************************************************************
********************************************************************************
*				 SPILLOVERS INVESTIGATION									   *
********************************************************************************
********************************************************************************


*******[SUMMARY TABLE  - INDEX ANALYSES]****** 			--> Table_Index.tex
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



OLS WITH AND WITHOUT CONTROLS.
model for continous
model for binaries(2): OLS + GLM
model for censored: OLS and TOBIT(dit si nul ou non nul).
*/


*ADD THE VARIABLE: RECEIVED A PWP PREVIOUSLY OR NOT.

*all indiv outcomes, in order of category. with repetition for rev_total and psych_a_menage


********************************************************************************
********************************************************************************
* 0. Run program, define parameters and local 
********************************************************************************
********************************************************************************

set matsize 10000
set more off
pause on
cd "$git_tunisia/outputs/Main/"

local IndexAa ///
					IAafood_consump_win IAaexpenditure_win IAacoping_mechanisms IAahh_assets2 IAahouse_ownership		///
					IAalarge_assets IAasmall_assets IAahome_assets IAacomms_assets IAaproductive_assets IAahuman_capital2 ///
					IAawage_employment2 IAaother_employment /*IAanon_agri_enterp IAaagri_prod_income*/ IAadebts_and_savings2 ///
					IAadebts IAasavings																						///
					IAaemploy_aspirations IAasocial_cohesion2 IAacomm_groups IAalocal_conflict IAarecent_migration		///
					IAalocal_security IAacivic_engag IAainitiatives IAainitiatives_meeting IAainitiatives_acting		///
					IAainformation_sources IAautopia IAaisolation IAapsycho_wellbeing2 IAapsycho_internal IAapsycho_external ///
					/*IAapearlin_index*/ IAaoverall_intrahouse2 IAawomens_decision IAaviolence_ag_women 
					
					
local IndexBa ///
					IBafood_consump_win IBaexpenditure_win IBacoping_mechanisms IBahh_assets2 IBahouse_ownership		///
					IBalarge_assets IBasmall_assets IBahome_assets IBacomms_assets IBaproductive_assets IBahuman_capital2 ///
					IBawage_employment2 IBaother_employment /*IBanon_agri_enterp IBaagri_prod_income*/ IBadebts_and_savings2 ///
					IBadebts IBasavings																						///
					IBaemploy_aspirations IBasocial_cohesion2 IBacomm_groups IBalocal_conflict IBarecent_migration		///
					IBalocal_security IBacivic_engag IBainitiatives IBainitiatives_meeting IBainitiatives_acting		///
					IBainformation_sources IBautopia IBaisolation IBapsycho_wellbeing2 IBapsycho_internal IBapsycho_external ///
					/*IBapearlin_index*/ IBaoverall_intrahouse2 IBawomens_decision IBaviolence_ag_women 

local IndexBb ///
					IBbfood_consump_win IBbexpenditure_win IBbcoping_mechanisms IBbhh_assets2 IBbhouse_ownership		///
					IBblarge_assets IBbsmall_assets IBbhome_assets IBbcomms_assets IBbproductive_assets IBbhuman_capital2 ///
					IBbwage_employment2 IBbother_employment /*IBbnon_agri_enterp IBbagri_prod_income*/ IBbdebts_and_savings2 ///
					IBbdebts IBbsavings																						///
					IBbemploy_aspirations IBbsocial_cohesion2  IBbcomm_groups IBblocal_conflict IBbrecent_migration		///
					IBblocal_security IBbcivic_engag IBbinitiatives IBbinitiatives_meeting IBbinitiatives_acting		///
					IBbinformation_sources IBbutopia IBbisolation IBbpsycho_wellbeing2 IBbpsycho_internal IBbpsycho_external ///
					/*IBbpearlin_index*/ IBboverall_intrahouse2 IBbwomens_decision IBbviolence_ag_women 

local IndexCa ///
					ICafood_consump_win ICaexpenditure_win ICacoping_mechanisms ICahh_assets2 ICahouse_ownership		///
					ICalarge_assets ICasmall_assets ICahome_assets ICacomms_assets ICaproductive_assets ICahuman_capital2 ///
					ICawage_employment2 ICaother_employment /*ICanon_agri_enterp ICaagri_prod_income*/ ICadebts_and_savings2 ///
					ICadebts ICasavings																						///
					ICaemploy_aspirations ICasocial_cohesion2 ICacomm_groups ICalocal_conflict ICarecent_migration		///
					ICalocal_security ICacivic_engag ICainitiatives ICainitiatives_meeting ICainitiatives_acting		///
					ICainformation_sources ICautopia ICaisolation ICapsycho_wellbeing2 ICapsycho_internal ICapsycho_external ///
					/*ICapearlin_index*/ ICaoverall_intrahouse2 ICawomens_decision ICaviolence_ag_women 

local IndexCb ///
					ICbfood_consump_win ICbexpenditure_win ICbcoping_mechanisms ICbhh_assets2 ICbhouse_ownership		///
					ICblarge_assets ICbsmall_assets ICbhome_assets ICbcomms_assets ICbproductive_assets ICbhuman_capital2 ///
					ICbwage_employment2 ICbother_employment /*ICbnon_agri_enterp ICbagri_prod_income*/ ICbdebts_and_savings2 ///
					ICbdebts ICbsavings																						///
					ICbemploy_aspirations ICbsocial_cohesion2 ICbcomm_groups ICblocal_conflict ICbrecent_migration		///
					ICblocal_security ICbcivic_engag ICbinitiatives ICbinitiatives_meeting ICbinitiatives_acting		///
					ICbinformation_sources ICbutopia ICbisolation ICbpsycho_wellbeing2  ICbpsycho_internal ICbpsycho_external ///
					/*ICbpearlin_index*/ ICboverall_intrahouse2 ICbwomens_decision ICbviolence_ag_women 
					
local IndexCd ///
					ICdfood_consump_win ICdexpenditure_win ICdcoping_mechanisms ICdhh_assets2 ICdhouse_ownership		///
					ICdlarge_assets ICdsmall_assets ICdhome_assets ICdcomms_assets ICdproductive_assets ICdhuman_capital2 ///
					ICdwage_employment2 ICdother_employment /*ICdnon_agri_enterp ICdagri_prod_income*/ ICddebts_and_savings2 ///
					ICddebts ICdsavings																						///
					ICdemploy_aspirations ICdsocial_cohesion2 ICdcomm_groups ICdlocal_conflict ICdrecent_migration		///
					ICdlocal_security ICdcivic_engag ICdinitiatives ICdinitiatives_meeting ICdinitiatives_acting		///
					ICdinformation_sources ICdutopia ICdisolation ICdpsycho_wellbeing2  ICdpsycho_internal ICdpsycho_external ///
					/*ICdpearlin_index*/ ICdoverall_intrahouse2 ICdwomens_decision ICdviolence_ag_women 
					
local IndexDa ///
					IDafood_consump_win IDaexpenditure_win IDacoping_mechanisms IDahh_assets2 IDahouse_ownership		///
					IDalarge_assets IDasmall_assets IDahome_assets IDacomms_assets IDaproductive_assets IDahuman_capital2 ///
					IDawage_employment2 IDaother_employment /*IDanon_agri_enterp IDaagri_prod_income*/ IDadebts_and_savings2 ///
					IDadebts IDasavings																						///
					IDaemploy_aspirations IDasocial_cohesion2 IDacomm_groups IDalocal_conflict IDarecent_migration		///
					IDalocal_security IDacivic_engag IDainitiatives IDainitiatives_meeting IDainitiatives_acting		///
					IDainformation_sources IDautopia IDaisolation IDapsycho_wellbeing2  IDapsycho_internal IDapsycho_external ///
					/*IDapearlin_index*/ IDaoverall_intrahouse2 IDawomens_decision IDaviolence_ag_women 
					
					
					
local Index_ALL ///
					 food_consump_win  expenditure_win  coping_mechanisms  hh_assets2  house_ownership		///
					 large_assets  small_assets  home_assets  comms_assets  productive_assets  human_capital2 ///
					 wage_employment2  other_employment /* non_agri_enterp  agri_prod_income*/  debts_and_savings2 ///
					 debts  savings																						///
					 employ_aspirations  social_cohesion2  comm_groups  local_conflict  recent_migration		///
					 local_security  civic_engag  initiatives  initiatives_meeting  initiatives_acting		///
					 information_sources  utopia  isolation  psycho_wellbeing2  psycho_internal  psycho_external ///
					/* pearlin_index*/  overall_intrahouse2  womens_decision  violence_ag_women 
					
local all3 `IndexAa' `IndexBa' `IndexBb' `IndexCa' `IndexCb'
							


* Controls : ADJUSTED TO REFLECT THE ONES THAT ARE NOT BALANCED.

local ctrl_Aa hhsize drepondant_mat g1_3 g1_4 g1_5 g1_7
local ctrl_Ba extra 
local ctrl_Bb extra repondant_sex
local ctrl_Ca //none
local ctrl_Cb hhsize g1_4

	
	use "$stata/enquete_All3", clear 

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
	
	

* Generate program indicator 

gen programs=(parti==1 | desist==1)

		
* Generate variable identifyin the sample used for every analysis 

g 		Between = .
replace Between = 1 if (parti==1 | desist==1 | enquete==3)

g 		Within = .
replace Within = 1 if (parti==1 | desist==1 | control==1) 

g 		Spillovers = .
replace Spillovers = 1 if (control==1 | enquete==3) 

g 		Infrastructure = .
replace Infrastructure = 1 if enquete==1


* Compute treatment intensity as the share of treated respondent in the community 

	// 1) Count number of treated respondent within communities 
	
	g num_treated = .
	
	levelsof lieu_entrevue, local(imada)
	
	foreach village in `imada'{
	
	preserve
		keep lieu_entrevue programs
		
		collapse (sum) programs, by(lieu_entrevue)
		
		rename programs tot_treated
		
		tempfile `village'
		sa 		``village''
	restore 
	
	}

	foreach village in `imada'{
	merge m:1 lieu_entrevue using ``village'', nogen
	}
	
	// 2) Generate treatment intensity
	
	g 		intensity =.
	replace intensity = tot_treated/NbHabitants 
	
		* Imput intensity to 0 for control communities
		
		replace intensity = 0 if beneficiaire == 0
		
		
	// 3) Create interaction between treatment and treatment intensity variable 
	
	g habXtrt = NbHabitants*beneficiaire
	
	g beneXprog = beneficiaire*programs 
	
	// 4) Find predictors of programs assignment in PWP community 
	
	local possible_instru ""
	
		* Loop over every possible integer variable 
		
		foreach var of varlist _all {
		
			capture confirm numeric variable `var'
			
			if _rc ==0{

				cap reg programs `var', robust 										// Regress treatment indicator on variable 
				
				if _rc == 0{
				
					local pvalue ttail(e(df_r),abs(_b[`var']/_se[`var']))*2			// Compute p-value 
					
					if `pvalue'<0.1{
					
						local possible_instru "`possible_instru' `var'"
					}
				}
				
				
			}
		}
	
	di in red "`possible_instru'"
	
	desc `possible_instru'
	
	// 5) Run regressions 
	
	foreach outcome in `Index_ALL' {
		
		* Between 
			
			eststo between: regress IAa`outcome' beneficiaire `ctrl_Aa' if Between == 1, vce (cluster imada)
			
			
		* Within 
		
			eststo within: regres IBa`outcome' programs `ctrl_Ba' if Within == 1, robust
			
			
		* Spillovers classic 
		
			eststo spill1: regres ICb`outcome' beneficiaire `ctrl_Cb'  if Spillovers == 1, vce (cluster imada)
			
			
		* Spillover and intensity
			
			eststo spill2: regres ICb`outcome' beneficiaire NbHabitants  `ctrl_Cb' if Spillovers == 1, vce (cluster imada)
	
			
		* Interacted 
		
			eststo spill3: regres ICb`outcome' beneficiaire habXtrt NbHabitants `ctrl_Cb' if Spillovers == 1, vce (cluster imada)
			
		* Full specification 
		
			eststo full: regress IDa`outcome' beneficiaire programs, vce (cluster imada)
			
			
		* Full Interacted 
		
			eststo full2: regress IDa`outcome' beneficiaire programs beneXprog, vce (cluster imada)
			
			
		* IV 
		
			eststo IV : ivregress 2sls IDa`outcome' beneficiaire (programs = extra), vce (cluster imada)
		
		
		* Tabulate results
		
		esttab between within spill1 spill2 spill3 full full2 IV, mtitle("Between" "Within" "Spillover" "Intensity" "Intensity Interacted" 	///
																		  "Full Spec" "Full Interacted" "Instrumented")						///
												  se order(beneficiaire programs beneXprog habXtrt NbHabitants _cons) 						///
												      keep(beneficiaire programs beneXprog habXtrt NbHabitants _cons)						///
												  stat(N Control_Mean)									
		
		pause 
		
		eststo clear 
		
	}
	









