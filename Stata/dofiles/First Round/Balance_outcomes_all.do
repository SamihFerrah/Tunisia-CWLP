
  
************collapse at village-level, in prep for analysis********//not needed with new 100+ outcomes. All indiv.

use $stata/tunisia_chefs_benef2, clear

*keep variable labels
/*
foreach v of var q0_1 q2_1 q2_2 q2_3 q2_4 q2_5 q2_6 q2_9_dum1 q2_9_dum2 q2_9_dum3 q2_9_dum4 q0_6_dum1 q0_6_dum2 ///
q0_6_dum3 q0_6_dum4 { 
 local l`v' : variable label `v' 
} 
order imada, first

*take means over the 2-3 leader questionnaire per community
collapse (mean) q0_1 q2_1 q2_2 q2_3 q2_4 q2_5 q2_6 q2_9_dum1 q2_9_dum2 q2_9_dum3 q2_9_dum4 q0_6_dum1 q0_6_dum2 ///
q0_6_dum3 q0_6_dum4, by (imada)

*label mean variables
foreach v of var q0_1 q2_1 q2_2 q2_3 q2_4 q2_5 q2_6 q2_9_dum1 q2_9_dum2 q2_9_dum3 q2_9_dum4 q0_6_dum1 q0_6_dum2 ///
q0_6_dum3 q0_6_dum4 { 
 label var `v' "`l`v''" 
} 
*/

foreach v of var 	q0_1 q0_2 q0_3 q0_5 negevent_1 negevent_2 negevent_3 negevent_4 negevent_5 negevent_6 		///
					negevent_7 negevent_8 negevent_9 posevent_1 posevent_2 posevent_3 posevent_4 posevent_5		///
					posevent_6 posevent_7 posevent_8 negevent posevent q2_1 q2_1_prop q2_2 q2_3 q2_4 q2_5 q2_6 q2_9_dum1 	///
					q2_9_dum2 q2_9_dum3 q2_9_dum4 q0_6_dum1 q0_6_dum2 q0_6_dum3 q0_6_dum4 q3_12 q3_16 q3_119 	///
					dq3_12 dq3_16 dq3_119 q4_26_dum q4_27_dum q4_28_dum q4_34_dum q4_35_dum	{ 															//distance from infrastructure is v varied q3_22 q3_23 q3_26 q3_27
 
 local l`v' : variable label `v' 
} 
order imada, first				
	

*take means over the 2-3 leader questionnaire per community
collapse (mean) q0_1 q0_2 q0_3 q0_5 negevent_1 negevent_2 negevent_3 negevent_4 negevent_5 negevent_6 		///
				negevent_7 negevent_8 negevent_9 posevent_1 posevent_2 posevent_3 posevent_4 posevent_5		///
				posevent_6 posevent_7 posevent_8 negevent posevent q2_1 q2_1_prop q2_2 q2_3 q2_4 q2_5 q2_6 q2_9_dum1 	///
				q2_9_dum2 q2_9_dum3 q2_9_dum4 q0_6_dum1 q0_6_dum2 q0_6_dum3 q0_6_dum4 q3_12 q3_16 q3_119 	///
				dq3_12 dq3_16 dq3_119 q4_26_dum q4_27_dum q4_28_dum q4_34_dum q4_35_dum, by(imada)
				
				


*label mean variables
foreach v of var q0_1 q0_2 q0_3 q0_5 negevent_1 negevent_2 negevent_3 negevent_4 negevent_5 negevent_6 		///
				negevent_7 negevent_8 negevent_9 posevent_1 posevent_2 posevent_3 posevent_4 posevent_5		///
				posevent_6 posevent_7 posevent_8 negevent posevent q2_1 q2_1_prop q2_2 q2_3 q2_4 q2_5 q2_6 q2_9_dum1 	///
				q2_9_dum2 q2_9_dum3 q2_9_dum4 q0_6_dum1 q0_6_dum2 q0_6_dum3 q0_6_dum4 q3_12 q3_16 q3_119 	///
				dq3_12 dq3_16 dq3_119 q4_26_dum q4_27_dum q4_28_dum q4_34_dum q4_35_dum	 {
				
 label var `v' "`l`v''" 
 }

			

save $stata/chefs_extracts_mean, replace
 
  
*MERGE INDIVIDUAL AND COMMUNITY-LEADER DATASETS//not needed with new 100+ outcomes. All indiv.

use $stata/enquete_indiv5, clear
merge m:1 imada using $stata/chefs_extracts_mean //34 not merging
list imada if _merge==1 //all imada 40 Fernana; ok
drop _merge
save $stata/enquete_All, replace


*call command for balance
do $do/command_balance

*use $stata/enquete_indiv5, clear

***********Necessary locals************

*locals for variables











*******************************************************************************************************
*********VARIABLES FOR BALANCE RERUN*******************************************************************
*******************************************************************************************************
	local balance_exante		q0_1 q0_2 q0_3 q2_1 q2_4 q2_5 dq3_12 dq3_16 dq3_119 q3_12 q3_16 q3_119		///
								repondant_age repondant_sex repondant_educ hhsize enfant_moins5 	///		//removed infra quality categorical and previous PWP q3_12 q3_16 q3_119 q0_5
								jeunes_lireecrire no_primary lycee_above drepondant_mat
								
	local balance_expost		negevent_1 negevent_2 negevent_3 negevent_4 negevent_5 negevent_6	///
								negevent_7 negevent_8 negevent_9 posevent_1 posevent_2 posevent_3	///
								posevent_4 posevent_5 posevent_6 posevent_7 posevent_8 negevent		///
								posevent g1_1 g1_2 g1_3 g1_4 g1_5 g1_6 g1_7 g1_9					
								
	local balance_exante_ch		q0_1 q0_2 q0_3 q2_1 q2_4 q2_5 dq3_12 dq3_16 dq3_119 q3_12 q3_16 q3_119		//distance from infrastructure is v varied q3_22  q3_23 q3_26	
	
	local balance_exante_ind	repondant_age repondant_sex repondant_educ hhsize enfant_moins5 	///		//removed infra quality categorical and previous PWP q3_12 q3_16 q3_119 q0_5
								jeunes_lireecrire no_primary lycee_above drepondant_mat
								
	local balance_expost_ch		negevent_1 negevent_2 negevent_3 negevent_4 negevent_5 negevent_6	///
								negevent_7 negevent_8 negevent_9 posevent_1 posevent_2 posevent_3	///
								posevent_4 posevent_5 posevent_6 posevent_7 posevent_8 negevent		///
								posevent 
								
	local balance_expost_ind	g1_1 g1_2 g1_3 g1_4 g1_5 g1_6 g1_7 g1_9
	
	local balance_chef_1ormore	q0_1_1ormore q0_2_1ormore q0_3_1ormore q2_1_1ormore q2_4_1ormore q2_5_1ormore	///
								dq3_12_1ormore dq3_16_1ormore dq3_119_1ormore q3_12_1ormore q3_16_1ormore 		///
								q3_119_1ormore negevent_1_1ormore negevent_2_1ormore negevent_3_1ormore			///
								negevent_4_1ormore negevent_5_1ormore negevent_6_1ormore negevent_7_1ormore 	///
								negevent_8_1ormore negevent_9_1ormore posevent_1_1ormore posevent_2_1ormore		///
								posevent_3_1ormore posevent_4_1ormore posevent_5_1ormore posevent_6_1ormore		///
								posevent_7_1ormore posevent_8_1ormore negevent_1ormore posevent_1ormore
								
	local balance_chef_maj		q0_1_maj q0_2_maj q0_3_maj q2_1_maj q2_4_maj q2_5_maj		///
								dq3_12_maj dq3_16_maj dq3_119_maj q3_12_maj q3_16_maj 		///
								q3_119_maj negevent_1_maj negevent_2_maj negevent_3_maj		///		
								negevent_4_maj negevent_5_maj negevent_6_maj negevent_7_maj ///
								negevent_8_maj negevent_9_maj posevent_1_maj posevent_2_maj	///
								posevent_3_maj posevent_4_maj posevent_5_maj posevent_6_maj ///
								posevent_7_maj posevent_8_maj negevent_maj posevent_maj 	
	
*******************************************************************************************************
*******************************************************************************************************
local controls q0_1 ///
superv_dum1 superv_dum2 superv_dum3 superv_dum4 superv_dum5 superv_dum6 relation_dum1 relation_dum2 relation_dum3 ///
repondant_age repondant_sex handicap

local food_consumption c3_a_3_win c3_a_3  c3_a_4_win c3_a_4 c3_a_6_win c3_a_6 c3_a_5_win c3_a_5 c3_a_8_win c3_a_8 ///
c3_a_9_win c3_a_9 c3_a_11_win c3_a_11 c3_a_1_win c3_a_1 c3_a_2_win c3_a_2 c3_a_7_win c3_a_7 c3_a_10_win c3_a_10

local expenditures exp_food c12_win c12 c13_win c13 c18_win c18 ///
c8_win c8 c5_win c5 c6_win c6 c7_win c7 c4_win c4 c11_win c11 c14_win c14 c9_win c9 c16_win c16

local shocks g1_1 g1_3 g1_5 g1_6 g1_7

local coping_mechanisms g2_1 g2_2 g2_3 g2_4 g2_5 g2_6 g2_7 g2_8 g2_9 g2_10 g2_11 g2_12 g2_13 g2_14 g2_15

local hh_assets q2_1_9 q2_1_10 q2_1_18_win q2_1_18 q2_1_19_win q2_1_19 q2_1_20 q2_1_21 q2_1_22 q2_1_23_win ///
q2_1_23 q2_1_2_win q2_1_2 q2_1_3 q2_1_4 q2_1_5 q2_1_6 q2_1_7 q2_1_8 q2_1_11 q2_1_12 q2_1_13_win q2_1_13 q2_1_14 q2_1_15 ///
q2_1_16_win q2_1_16 q2_1_17 mur_dum1 mur_dum2 mur_dum3 mur_dum4 mur_dum5 mur_dum6 mur_dum7 mur_dum8 toit_dum1 toit_dum2 ///
toit_dum3 toit_dum4 toit_dum5 toit_dum6 toit_dum7 proprietaire_dum1 proprietaire_dum2 proprietaire_dum3 titre proprietaire_terre ///
superficie superficie_m titre_terre f18

local human_capital lithh_dum1 lithh_dum2 lithh_dum3 lithh_dum4 lithh_dum5 lithh_dum6 lit_dum1 lit_dum2 lit_dum3 lit_dum4 lit_dum5 lit_dum6 formation formation_dum1 ///
formation_dum2 formation_dum3 formation_dum4 formation_dum5 formation_dum6 formation_dum7 formation_dum9 ///
formation_dum10 emploi_comp_inut

local wage_employment emploi tspent_main earned_main_win earned_main chomage_recherche

local other_employment sec_empl tspent_sec_win tspent_sec earned_sec

local non_agriculture_enterprise employs pers_employ hoursperm_employ paid_employ

*local agri_prod_income agri_income agri_invest //NO OBSERVATION

local oth_farm_activ type_emploi_3

local debts_and_savings epargne epargne_forme_3 epargne_cb_win epargne_cb

local employ_income_o_members empl_futurt_dum1 empl_futurt_dum2 empl_futurt_dum3 empl_futurt_dum4 empl_futur_dum1 ///
empl_futur_dum2 empl_futur_dum3 empl_futur_dum4 emp_futur_cb_win emp_futur_cb employedhh earnedhh paidjobhh earnedoth paidjoboth

local access_basic_services sante_lieux_dum1 sante_lieux_dum2 sante_lieux_dum3 sante_lieux_dum4 sante_lieux_dum5 ///
distance_dispensaire_win distance_dispensaire distance_ecoleprim_win distance_ecoleprim distance_ecolesec_win distance_ecolesec ///
distance_eau_win distance_eau sante_soins sante_hopital_win sante_hopital c12_win c12 sante_qualite_b_dum1 sante_qualite_b_dum2 ///
sante_qualite_b_dum3 sante_qualite_c_dum1 sante_qualite_c_dum2 sante_qualite_c_dum3 ecole_qualite_c_dum1 ecole_qualite_c_dum2 ///
ecole_qualite_c_dum3 ecole_qualite_d_dum1 ecole_qualite_d_dum2 ecole_qualite_d_dum3 distance_eau_win distance_eau distance_marche_win distance_marche ///
distance_transpublic_win distance_transpublic distance_ecoleprim_win distance_ecoleprim distance_ecolesec_win distance_ecolesec ///
distance_dispensaire_win distance_dispensaire distance_cheflieu_win distance_cheflieu

local social_cohesion association_1 association_2 association_3 association_4 association_6 association_7 association_8 ///
association_9 comite_c comite_c_menage conflit_dispute_in conflit_dispute_out migration_cm_q1 migration_q1 securite_1 securite_2 ///
securite_3 securite_4 securite_5 securite_6

local civic_engagement initiatives_1 initiatives_2 initiatives_3 initiatives_4 initiatives_5 initiatives_6 initiatives_7 initiatives_8 ///
initiatives_9 initiatives_10 initiatives_11 initiatives_12 initiatives_13 initiatives_14 initiatives_15 utopie_a_dum1 ///
utopie_a_dum2 utopie_a_dum3 utopie_b_dum1 utopie_b_dum2 utopie_b_dum3 source_info_1 source_info_2 source_info_3 source_info_4 ///
source_info_5 source_info_6 source_info_7 source_info_8 source_info2_1 source_info2_2 source_info2_3 source_info2_4 source_info2_5 ///
source_info2_6 source_info2_7 source_info2_8 isolement_1 isolement_2 isolement_3 isolement_4

local psychological_wellbeing psy_anxiete psy_exploit psy_depress5 psy_accepte_dum1 psy_accepte_dum2 psy_accepte_dum3 psy_depart_win ///
psy_depart psy_menage_dum1 psy_menage_dum2 psy_menage_dum3 psy_a_menage_dum1 psy_a_menage_dum2 psy_a_menage_dum3 pearlin_4 pearlin_5

local womens_decision_making intrahh_1 intrahh_2 intrahh_7 intrahh_11 emploiw

local violence_against_women violence_1_2 violence_1_3 violence_1_4 violence_1_5 violence_1_6 violence_1_7 violence_1_8 violence_1_9 ///
violence_1_10 violence_1_11 violence_1_16 violence_1_17 violence_1_18

local overall_intrahousehold `Womens_decision_making' `Violence_against_women'
/*
We have six "types" of individuals in our sample
1)      Workers on the ‘nominative lists’ (primary list of replacement lists) who were randomized into the program and ended up working
2)      Workers on the ‘nominative lists’ (primary list of replacement lists) who were randomized into the program and ended up not working (les desistes)
3)      Workers on the ‘nominative lists’ (primary list of replacement lists) who were randomized out of the program
4)      Representative random samples of individuals from treatment imadas
5)      Representative random samples of individuals from control imadas
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
a.      Re-run Aa and Ab separately for subsamples stratify by the key program-related | contextual variables we decide on.
b.      Re-run Ba and Bb separately for subsamples stratify by the key program-related | contextual variables we decide on.
*/


********************************************************* 
*************BALANCE EX ANTE***************************** 
*********************************************************

********Producing the tables**********
*A)      Between villages effects on the workers:
*a.      ITT: [(1) + (2)] vs (6)

cap file close myfile
file open myfile using "$report/balance_exante.xls", write replace 

preserve 
keep if (parti==1 | desist==1 | enquete==3) 

 file write myfile "<!DOCTYPE html><html lang='en'><head>"
 file write myfile "<p align=center b> TABLE 1. Between villages effects on the workers:ITT </p><br>"
 file write myfile "<meta charset='utf-8' /></head><body><div><table border=1 align=center>" _n

 file write myfile "<tr><td>Variable</td><td>Description</td><td>N</td><td>Control<br>Mean</td><td>Treatment<br>Mean</td><td>Diff.<br>of Means</td><td>t-Stat</td><td>p-Value"
 *file write myfile "<tr><td>Variable</td><td>Description</td><td>N</td><td>Control<br>Mean</td><td>Treatment<br>Mean</td><td>Diff.<br>of Means</td><td>t-Stat</td><td>p-Value</td><td>D-Stat</td><td>p-Value</td>"
 foreach var of varlist `balance_exante' /*`food_consumption' `expenditures' `shocks' `coping_mechanisms' ///
 q2_1_9 q2_1_10 q2_1_18_win q2_1_18 q2_1_19_win q2_1_19 q2_1_20 q2_1_21 q2_1_22 q2_1_23_win ///
q2_1_23 q2_1_2_win q2_1_2 q2_1_3 q2_1_4 q2_1_5 q2_1_6 q2_1_7 q2_1_8 q2_1_11 q2_1_12 q2_1_13_win q2_1_13 q2_1_14 q2_1_15 ///
q2_1_16_win q2_1_16 q2_1_17 mur_dum1 mur_dum2 mur_dum3 mur_dum4 mur_dum5 mur_dum6 mur_dum7 /*mur_dum8*/ toit_dum1 toit_dum2 ///
toit_dum3 toit_dum4 toit_dum5 toit_dum6 toit_dum7 proprietaire_dum1 proprietaire_dum2 proprietaire_dum3 titre proprietaire_terre ///
superficie superficie_m titre_terre f18 /// 
 `human_capital' `wage_employment' ///
 `other_employment' employs pers_employ /*hoursperm_employ paid_employ*/ ` oth_farm_activ' `debts_and_savings' ///
 empl_futurt_dum1 empl_futurt_dum2 empl_futurt_dum3 empl_futurt_dum4 empl_futur_dum1 empl_futur_dum2 empl_futur_dum3 empl_futur_dum4 emp_futur_cb_win ///
 emp_futur_cb employedhh earnedhh /*paidjobhh*/ earnedoth paidjoboth `access_basic_services' `social_cohesion' `civic_engagement' `psychological_wellbeing' `womens_decision_making' ///
 `violence_against_women'*/ {
  local label : variable label `var'
  balance `var' "`label'" myfile beneficiaire 
 }
 file write myfile "</table>"
 file write myfile "<p align=small size=-2>Note: Means for groups."
 file write myfile "Standard error of the mean in {curly brackets}."
 file write myfile "Two-tailed test for difference in means."
 file write myfile "Significance level of the test is set to"
 file write myfile "10% (*), 5% (**), and 1% (***).</p><br>"
restore
 

*B)      Within village effects on the workers:
*a.      ITT: [(1) + (2)] vs (3)

gen program=(parti==1 | desist==1)

preserve
keep if (parti==1 | desist==1 | control==1)

 file write myfile "<!DOCTYPE html><html lang='en'><head>"
 file write myfile "<p align=center b> TABLE 2. Within village effects on the workers:ITT  </p><br>"
 file write myfile "<meta charset='utf-8' /></head><body><div><table border=1 align=center>" _n

 file write myfile "<tr><td>Variable</td><td>Description</td><td>N</td><td>Control<br>Mean</td><td>Treatment<br>Mean</td><td>Diff.<br>of Means</td><td>t-Stat</td><td>p-Value"
 *file write myfile "<tr><td>Variable</td><td>Description</td><td>N</td><td>Control<br>Mean</td><td>Treatment<br>Mean</td><td>Diff.<br>of Means</td><td>t-Stat</td><td>p-Value</td><td>D-Stat</td><td>p-Value</td>"
 foreach var of varlist extra `balance_exante_ind' /*`food_consumption' `expenditures' `shocks' `coping_mechanisms' ///
 q2_1_9 q2_1_10 q2_1_18_win q2_1_18 q2_1_19_win q2_1_19 q2_1_20 q2_1_21 q2_1_22 q2_1_23_win ///
 q2_1_23 q2_1_2_win q2_1_2 q2_1_3 q2_1_4 q2_1_5 q2_1_6 q2_1_7 q2_1_8 q2_1_11 q2_1_12 q2_1_13_win q2_1_13 q2_1_14 q2_1_15 ///
 q2_1_16_win q2_1_16 q2_1_17 mur_dum1 mur_dum2 mur_dum3 mur_dum4 mur_dum5 mur_dum6 mur_dum7 /*mur_dum8*/ toit_dum1 toit_dum2 ///
 /*toit_dum3*/ toit_dum4 toit_dum5 toit_dum6 toit_dum7 proprietaire_dum1 proprietaire_dum2 proprietaire_dum3 titre proprietaire_terre ///
 superficie superficie_m titre_terre f18 /// 
 `human_capital' `wage_employment' ///
 `other_employment' employs pers_employ /*hoursperm_employ paid_employ*/ ` oth_farm_activ' `debts_and_savings' ///
 empl_futurt_dum1 empl_futurt_dum2 empl_futurt_dum3 empl_futurt_dum4 empl_futur_dum1 empl_futur_dum2 empl_futur_dum3 empl_futur_dum4 emp_futur_cb_win ///
 emp_futur_cb employedhh earnedhh /*paidjobhh*/ earnedoth paidjoboth `access_basic_services' ///
 association_1 association_2 association_3 association_4 /*association_6*/ association_7 association_8 ///
 association_9 comite_c comite_c_menage conflit_dispute_in conflit_dispute_out migration_cm_q1 migration_q1 securite_1 securite_2 ///
 securite_3 securite_4 securite_5 securite_6 ///
 initiatives_1 initiatives_2 initiatives_3 initiatives_4 initiatives_5 initiatives_6 initiatives_7 initiatives_8 ///
 initiatives_9 initiatives_10 initiatives_11 initiatives_12 /*initiatives_13*/ initiatives_14 initiatives_15 utopie_a_dum1 ///
 utopie_a_dum2 utopie_a_dum3 utopie_b_dum1 utopie_b_dum2 utopie_b_dum3 source_info_1 source_info_2 source_info_3 source_info_4 ///
 source_info_5 source_info_6 source_info_7 source_info_8 source_info2_1 source_info2_2 source_info2_3 source_info2_4 source_info2_5 ///
 source_info2_6 source_info2_7 source_info2_8 isolement_1 isolement_2 isolement_3 isolement_4 ///
 `psychological_wellbeing' intrahh_1 /*intrahh_2*/ intrahh_7 intrahh_11 emploiw ///
 `violence_against_women'*/ {
  local label : variable label `var'
  balance `var' "`label'" myfile program 
 }
 file write myfile "</table>"
 file write myfile "<p align=small size=-2>Note: Means for groups."
 file write myfile "Standard error of the mean in {curly brackets}."
 file write myfile "Two-tailed test for difference in means."
 file write myfile "Significance level of the test is set to"
 file write myfile "10% (*), 5% (**), and 1% (***).</p><br>"
restore

*b.      ATE: (1) vs (3)
preserve
keep if (parti==1 | control==1)

 file write myfile "<!DOCTYPE html><html lang='en'><head>"
 file write myfile "<p align=center b> TABLE 3. Within village effects on the workers:ATE  </p><br>"
 file write myfile "<meta charset='utf-8' /></head><body><div><table border=1 align=center>" _n

 file write myfile "<tr><td>Variable</td><td>Description</td><td>N</td><td>Control<br>Mean</td><td>Treatment<br>Mean</td><td>Diff.<br>of Means</td><td>t-Stat</td><td>p-Value"
 *file write myfile "<tr><td>Variable</td><td>Description</td><td>N</td><td>Control<br>Mean</td><td>Treatment<br>Mean</td><td>Diff.<br>of Means</td><td>t-Stat</td><td>p-Value</td><td>D-Stat</td><td>p-Value</td>"
 foreach var of varlist extra `balance_exante_ind' /*`food_consumption' `expenditures' `shocks' `coping_mechanisms' ///
 q2_1_9 q2_1_10 q2_1_18_win q2_1_18 q2_1_19_win q2_1_19 q2_1_20 q2_1_21 q2_1_22 q2_1_23_win ///
 q2_1_23 q2_1_2_win q2_1_2 q2_1_3 q2_1_4 q2_1_5 q2_1_6 q2_1_7 q2_1_8 q2_1_11 q2_1_12 q2_1_13_win q2_1_13 q2_1_14 q2_1_15 ///
 q2_1_16_win q2_1_16 q2_1_17 mur_dum1 mur_dum2 mur_dum3 mur_dum4 mur_dum5 mur_dum6 mur_dum7 /*mur_dum8*/ toit_dum1 toit_dum2 ///
 /*toit_dum3*/ toit_dum4 toit_dum5 toit_dum6 toit_dum7 proprietaire_dum1 proprietaire_dum2 proprietaire_dum3 titre proprietaire_terre ///
 superficie superficie_m titre_terre f18 /// 
 `human_capital' `wage_employment' ///
 `other_employment' employs pers_employ /*hoursperm_employ paid_employ*/ ` oth_farm_activ' `debts_and_savings' ///
 empl_futurt_dum1 empl_futurt_dum2 empl_futurt_dum3 empl_futurt_dum4 empl_futur_dum1 empl_futur_dum2 empl_futur_dum3 empl_futur_dum4 emp_futur_cb_win ///
 emp_futur_cb employedhh earnedhh /*paidjobhh*/ earnedoth paidjoboth `access_basic_services' ///
 association_1 association_2 association_3 association_4 /*association_6*/ association_7 association_8 ///
 association_9 comite_c comite_c_menage conflit_dispute_in conflit_dispute_out migration_cm_q1 migration_q1 securite_1 securite_2 ///
 securite_3 securite_4 securite_5 securite_6 ///
 initiatives_1 initiatives_2 initiatives_3 initiatives_4 initiatives_5 initiatives_6 initiatives_7 initiatives_8 ///
 initiatives_9 initiatives_10 initiatives_11 initiatives_12 /*initiatives_13*/ initiatives_14 initiatives_15 utopie_a_dum1 ///
 utopie_a_dum2 utopie_a_dum3 utopie_b_dum1 utopie_b_dum2 utopie_b_dum3 source_info_1 source_info_2 source_info_3 source_info_4 ///
 source_info_5 source_info_6 source_info_7 source_info_8 source_info2_1 source_info2_2 source_info2_3 source_info2_4 source_info2_5 ///
 source_info2_6 source_info2_7 source_info2_8 isolement_1 isolement_2 isolement_3 isolement_4 ///
 `psychological_wellbeing' intrahh_1 /*intrahh_2*/ intrahh_7 intrahh_11 emploiw ///
 `violence_against_women'*/ {
  local label : variable label `var'
  balance `var' "`label'" myfile parti 
 }
 file write myfile "</table>"
 file write myfile "<p align=small size=-2>Note: Means for groups."
 file write myfile "Standard error of the mean in {curly brackets}."
 file write myfile "Two-tailed test for difference in means."
 file write myfile "Significance level of the test is set to"
 file write myfile "10% (*), 5% (**), and 1% (***).</p><br>"
restore

*C)      Spillover effects (two types)
*a.      (4) vs (5)

preserve
keep if enquete==1

 file write myfile "<!DOCTYPE html><html lang='en'><head>"
 file write myfile "<p align=center b> TABLE 4. Spillover effects: (4) vs (5) </p><br>"
 file write myfile "<meta charset='utf-8' /></head><body><div><table border=1 align=center>" _n

 file write myfile "<tr><td>Variable</td><td>Description</td><td>N</td><td>Control<br>Mean</td><td>Treatment<br>Mean</td><td>Diff.<br>of Means</td><td>t-Stat</td><td>p-Value"
 *file write myfile "<tr><td>Variable</td><td>Description</td><td>N</td><td>Control<br>Mean</td><td>Treatment<br>Mean</td><td>Diff.<br>of Means</td><td>t-Stat</td><td>p-Value</td><td>D-Stat</td><td>p-Value</td>"
 foreach var of varlist `balance_exante' /*`food_consumption' `expenditures' `shocks' `coping_mechanisms' `hh_assets' `human_capital' `wage_employment' ///
 `other_employment' employs pers_employ /*hoursperm_employ paid_employ*/ ` oth_farm_activ' `debts_and_savings' ///
 empl_futurt_dum1 empl_futurt_dum2 empl_futurt_dum3 empl_futurt_dum4 empl_futur_dum1 empl_futur_dum2 empl_futur_dum3 empl_futur_dum4 emp_futur_cb_win ///
 emp_futur_cb employedhh earnedhh /*paidjobhh*/ earnedoth paidjoboth `access_basic_services' `social_cohesion' `civic_engagement' `psychological_wellbeing' ///
 `womens_decision_making' `violence_against_women'*/ {
  local label : variable label `var'
  balance `var' "`label'" myfile beneficiaire 
 }
 file write myfile "</table>"
 file write myfile "<p align=small size=-2>Note: Means for groups."
 file write myfile "Standard error of the mean in {curly brackets}."
 file write myfile "Two-tailed test for difference in means."
 file write myfile "Significance level of the test is set to"
 file write myfile "10% (*), 5% (**), and 1% (***).</p><br>"
restore

*b.      (3) vs (6)
preserve
keep if (control==1 | enquete==3)
 file write myfile "<!DOCTYPE html><html lang='en'><head>"
 file write myfile "<p align=center b> TABLE 5. Spillover effects: (3) vs (6) </p><br>"
 file write myfile "<meta charset='utf-8' /></head><body><div><table border=1 align=center>" _n

 file write myfile "<tr><td>Variable</td><td>Description</td><td>N</td><td>Control<br>Mean</td><td>Treatment<br>Mean</td><td>Diff.<br>of Means</td><td>t-Stat</td><td>p-Value"
 *file write myfile "<tr><td>Variable</td><td>Description</td><td>N</td><td>Control<br>Mean</td><td>Treatment<br>Mean</td><td>Diff.<br>of Means</td><td>t-Stat</td><td>p-Value</td><td>D-Stat</td><td>p-Value</td>"
 foreach var of varlist `balance_exante_ind' /*`food_consumption' `expenditures' `shocks' `coping_mechanisms' `hh_assets' `human_capital' `wage_employment' ///
 `other_employment' employs pers_employ /*hoursperm_employ paid_employ*/ ` oth_farm_activ' `debts_and_savings' ///
 empl_futurt_dum1 empl_futurt_dum2 empl_futurt_dum3 empl_futurt_dum4 empl_futur_dum1 empl_futur_dum2 empl_futur_dum3 empl_futur_dum4 emp_futur_cb_win ///
 emp_futur_cb employedhh earnedhh /*paidjobhh*/ earnedoth paidjoboth `access_basic_services' `social_cohesion' `civic_engagement' `psychological_wellbeing' ///
 `womens_decision_making' `violence_against_women'*/ {
  local label : variable label `var'
  balance `var' "`label'" myfile beneficiaire 
 }
 file write myfile "</table>"
 file write myfile "<p align=small size=-2>Note: Means for groups."
 file write myfile "Standard error of the mean in {curly brackets}."
 file write myfile "Two-tailed test for difference in means."
 file write myfile "Significance level of the test is set to"
 file write myfile "10% (*), 5% (**), and 1% (***).</p><br>"
restore


 file close myfile


 
 
 
 
 
 
 
********************************************************* 
*************BALANCE EX POST***************************** 
*********************************************************
 
********Producing the tables**********
*A)      Between villages effects on the workers:
*a.      ITT: [(1) + (2)] vs (6)

cap file close myfile
file open myfile using "$report/balance_expost.xls", write replace 

preserve 
keep if (parti==1 | desist==1 | enquete==3) 

 file write myfile "<!DOCTYPE html><html lang='en'><head>"
 file write myfile "<p align=center b> TABLE 1. Between villages effects on the workers:ITT </p><br>"
 file write myfile "<meta charset='utf-8' /></head><body><div><table border=1 align=center>" _n

 file write myfile "<tr><td>Variable</td><td>Description</td><td>N</td><td>Control<br>Mean</td><td>Treatment<br>Mean</td><td>Diff.<br>of Means</td><td>t-Stat</td><td>p-Value"
 *file write myfile "<tr><td>Variable</td><td>Description</td><td>N</td><td>Control<br>Mean</td><td>Treatment<br>Mean</td><td>Diff.<br>of Means</td><td>t-Stat</td><td>p-Value</td><td>D-Stat</td><td>p-Value</td>"
 foreach var of varlist `balance_expost' /*`food_consumption' `expenditures' `shocks' `coping_mechanisms' ///
 q2_1_9 q2_1_10 q2_1_18_win q2_1_18 q2_1_19_win q2_1_19 q2_1_20 q2_1_21 q2_1_22 q2_1_23_win ///
q2_1_23 q2_1_2_win q2_1_2 q2_1_3 q2_1_4 q2_1_5 q2_1_6 q2_1_7 q2_1_8 q2_1_11 q2_1_12 q2_1_13_win q2_1_13 q2_1_14 q2_1_15 ///
q2_1_16_win q2_1_16 q2_1_17 mur_dum1 mur_dum2 mur_dum3 mur_dum4 mur_dum5 mur_dum6 mur_dum7 /*mur_dum8*/ toit_dum1 toit_dum2 ///
toit_dum3 toit_dum4 toit_dum5 toit_dum6 toit_dum7 proprietaire_dum1 proprietaire_dum2 proprietaire_dum3 titre proprietaire_terre ///
superficie superficie_m titre_terre f18 /// 
 `human_capital' `wage_employment' ///
 `other_employment' employs pers_employ /*hoursperm_employ paid_employ*/ ` oth_farm_activ' `debts_and_savings' ///
 empl_futurt_dum1 empl_futurt_dum2 empl_futurt_dum3 empl_futurt_dum4 empl_futur_dum1 empl_futur_dum2 empl_futur_dum3 empl_futur_dum4 emp_futur_cb_win ///
 emp_futur_cb employedhh earnedhh /*paidjobhh*/ earnedoth paidjoboth `access_basic_services' `social_cohesion' `civic_engagement' `psychological_wellbeing' `womens_decision_making' ///
 `violence_against_women'*/ {
  local label : variable label `var'
  balance `var' "`label'" myfile beneficiaire 
 }
 file write myfile "</table>"
 file write myfile "<p align=small size=-2>Note: Means for groups."
 file write myfile "Standard error of the mean in {curly brackets}."
 file write myfile "Two-tailed test for difference in means."
 file write myfile "Significance level of the test is set to"
 file write myfile "10% (*), 5% (**), and 1% (***).</p><br>"
restore
 

*B)      Within village effects on the workers:
*a.      ITT: [(1) + (2)] vs (3)

*gen program=(parti==1 | desist==1)

preserve
keep if (parti==1 | desist==1 | control==1)

 file write myfile "<!DOCTYPE html><html lang='en'><head>"
 file write myfile "<p align=center b> TABLE 2. Within village effects on the workers:ITT  </p><br>"
 file write myfile "<meta charset='utf-8' /></head><body><div><table border=1 align=center>" _n

 file write myfile "<tr><td>Variable</td><td>Description</td><td>N</td><td>Control<br>Mean</td><td>Treatment<br>Mean</td><td>Diff.<br>of Means</td><td>t-Stat</td><td>p-Value"
 *file write myfile "<tr><td>Variable</td><td>Description</td><td>N</td><td>Control<br>Mean</td><td>Treatment<br>Mean</td><td>Diff.<br>of Means</td><td>t-Stat</td><td>p-Value</td><td>D-Stat</td><td>p-Value</td>"
 foreach var of varlist extra `balance_expost_ind' /*`food_consumption' `expenditures' `shocks' `coping_mechanisms' ///
 q2_1_9 q2_1_10 q2_1_18_win q2_1_18 q2_1_19_win q2_1_19 q2_1_20 q2_1_21 q2_1_22 q2_1_23_win ///
 q2_1_23 q2_1_2_win q2_1_2 q2_1_3 q2_1_4 q2_1_5 q2_1_6 q2_1_7 q2_1_8 q2_1_11 q2_1_12 q2_1_13_win q2_1_13 q2_1_14 q2_1_15 ///
 q2_1_16_win q2_1_16 q2_1_17 mur_dum1 mur_dum2 mur_dum3 mur_dum4 mur_dum5 mur_dum6 mur_dum7 /*mur_dum8*/ toit_dum1 toit_dum2 ///
 /*toit_dum3*/ toit_dum4 toit_dum5 toit_dum6 toit_dum7 proprietaire_dum1 proprietaire_dum2 proprietaire_dum3 titre proprietaire_terre ///
 superficie superficie_m titre_terre f18 /// 
 `human_capital' `wage_employment' ///
 `other_employment' employs pers_employ /*hoursperm_employ paid_employ*/ ` oth_farm_activ' `debts_and_savings' ///
 empl_futurt_dum1 empl_futurt_dum2 empl_futurt_dum3 empl_futurt_dum4 empl_futur_dum1 empl_futur_dum2 empl_futur_dum3 empl_futur_dum4 emp_futur_cb_win ///
 emp_futur_cb employedhh earnedhh /*paidjobhh*/ earnedoth paidjoboth `access_basic_services' ///
 association_1 association_2 association_3 association_4 /*association_6*/ association_7 association_8 ///
 association_9 comite_c comite_c_menage conflit_dispute_in conflit_dispute_out migration_cm_q1 migration_q1 securite_1 securite_2 ///
 securite_3 securite_4 securite_5 securite_6 ///
 initiatives_1 initiatives_2 initiatives_3 initiatives_4 initiatives_5 initiatives_6 initiatives_7 initiatives_8 ///
 initiatives_9 initiatives_10 initiatives_11 initiatives_12 /*initiatives_13*/ initiatives_14 initiatives_15 utopie_a_dum1 ///
 utopie_a_dum2 utopie_a_dum3 utopie_b_dum1 utopie_b_dum2 utopie_b_dum3 source_info_1 source_info_2 source_info_3 source_info_4 ///
 source_info_5 source_info_6 source_info_7 source_info_8 source_info2_1 source_info2_2 source_info2_3 source_info2_4 source_info2_5 ///
 source_info2_6 source_info2_7 source_info2_8 isolement_1 isolement_2 isolement_3 isolement_4 ///
 `psychological_wellbeing' intrahh_1 /*intrahh_2*/ intrahh_7 intrahh_11 emploiw ///
 `violence_against_women'*/ {
  local label : variable label `var'
  balance `var' "`label'" myfile program 
 }
 file write myfile "</table>"
 file write myfile "<p align=small size=-2>Note: Means for groups."
 file write myfile "Standard error of the mean in {curly brackets}."
 file write myfile "Two-tailed test for difference in means."
 file write myfile "Significance level of the test is set to"
 file write myfile "10% (*), 5% (**), and 1% (***).</p><br>"
restore

*b.      ATE: (1) vs (3)
preserve
keep if (parti==1 | control==1)

 file write myfile "<!DOCTYPE html><html lang='en'><head>"
 file write myfile "<p align=center b> TABLE 3. Within village effects on the workers:ATE  </p><br>"
 file write myfile "<meta charset='utf-8' /></head><body><div><table border=1 align=center>" _n

 file write myfile "<tr><td>Variable</td><td>Description</td><td>N</td><td>Control<br>Mean</td><td>Treatment<br>Mean</td><td>Diff.<br>of Means</td><td>t-Stat</td><td>p-Value"
 *file write myfile "<tr><td>Variable</td><td>Description</td><td>N</td><td>Control<br>Mean</td><td>Treatment<br>Mean</td><td>Diff.<br>of Means</td><td>t-Stat</td><td>p-Value</td><td>D-Stat</td><td>p-Value</td>"
 foreach var of varlist extra `balance_expost_ind' /*`food_consumption' `expenditures' `shocks' `coping_mechanisms' ///
 q2_1_9 q2_1_10 q2_1_18_win q2_1_18 q2_1_19_win q2_1_19 q2_1_20 q2_1_21 q2_1_22 q2_1_23_win ///
 q2_1_23 q2_1_2_win q2_1_2 q2_1_3 q2_1_4 q2_1_5 q2_1_6 q2_1_7 q2_1_8 q2_1_11 q2_1_12 q2_1_13_win q2_1_13 q2_1_14 q2_1_15 ///
 q2_1_16_win q2_1_16 q2_1_17 mur_dum1 mur_dum2 mur_dum3 mur_dum4 mur_dum5 mur_dum6 mur_dum7 /*mur_dum8*/ toit_dum1 toit_dum2 ///
 /*toit_dum3*/ toit_dum4 toit_dum5 toit_dum6 toit_dum7 proprietaire_dum1 proprietaire_dum2 proprietaire_dum3 titre proprietaire_terre ///
 superficie superficie_m titre_terre f18 /// 
 `human_capital' `wage_employment' ///
 `other_employment' employs pers_employ /*hoursperm_employ paid_employ*/ ` oth_farm_activ' `debts_and_savings' ///
 empl_futurt_dum1 empl_futurt_dum2 empl_futurt_dum3 empl_futurt_dum4 empl_futur_dum1 empl_futur_dum2 empl_futur_dum3 empl_futur_dum4 emp_futur_cb_win ///
 emp_futur_cb employedhh earnedhh /*paidjobhh*/ earnedoth paidjoboth `access_basic_services' ///
 association_1 association_2 association_3 association_4 /*association_6*/ association_7 association_8 ///
 association_9 comite_c comite_c_menage conflit_dispute_in conflit_dispute_out migration_cm_q1 migration_q1 securite_1 securite_2 ///
 securite_3 securite_4 securite_5 securite_6 ///
 initiatives_1 initiatives_2 initiatives_3 initiatives_4 initiatives_5 initiatives_6 initiatives_7 initiatives_8 ///
 initiatives_9 initiatives_10 initiatives_11 initiatives_12 /*initiatives_13*/ initiatives_14 initiatives_15 utopie_a_dum1 ///
 utopie_a_dum2 utopie_a_dum3 utopie_b_dum1 utopie_b_dum2 utopie_b_dum3 source_info_1 source_info_2 source_info_3 source_info_4 ///
 source_info_5 source_info_6 source_info_7 source_info_8 source_info2_1 source_info2_2 source_info2_3 source_info2_4 source_info2_5 ///
 source_info2_6 source_info2_7 source_info2_8 isolement_1 isolement_2 isolement_3 isolement_4 ///
 `psychological_wellbeing' intrahh_1 /*intrahh_2*/ intrahh_7 intrahh_11 emploiw ///
 `violence_against_women'*/ {
  local label : variable label `var'
  balance `var' "`label'" myfile parti 
 }
 file write myfile "</table>"
 file write myfile "<p align=small size=-2>Note: Means for groups."
 file write myfile "Standard error of the mean in {curly brackets}."
 file write myfile "Two-tailed test for difference in means."
 file write myfile "Significance level of the test is set to"
 file write myfile "10% (*), 5% (**), and 1% (***).</p><br>"
restore

*C)      Spillover effects (two types)
*a.      (4) vs (5)

preserve
keep if enquete==1

 file write myfile "<!DOCTYPE html><html lang='en'><head>"
 file write myfile "<p align=center b> TABLE 4. Spillover effects: (4) vs (5) </p><br>"
 file write myfile "<meta charset='utf-8' /></head><body><div><table border=1 align=center>" _n

 file write myfile "<tr><td>Variable</td><td>Description</td><td>N</td><td>Control<br>Mean</td><td>Treatment<br>Mean</td><td>Diff.<br>of Means</td><td>t-Stat</td><td>p-Value"
 *file write myfile "<tr><td>Variable</td><td>Description</td><td>N</td><td>Control<br>Mean</td><td>Treatment<br>Mean</td><td>Diff.<br>of Means</td><td>t-Stat</td><td>p-Value</td><td>D-Stat</td><td>p-Value</td>"
 foreach var of varlist `balance_expost_ind' /*`food_consumption' `expenditures' `shocks' `coping_mechanisms' `hh_assets' `human_capital' `wage_employment' ///
 `other_employment' employs pers_employ /*hoursperm_employ paid_employ*/ ` oth_farm_activ' `debts_and_savings' ///
 empl_futurt_dum1 empl_futurt_dum2 empl_futurt_dum3 empl_futurt_dum4 empl_futur_dum1 empl_futur_dum2 empl_futur_dum3 empl_futur_dum4 emp_futur_cb_win ///
 emp_futur_cb employedhh earnedhh /*paidjobhh*/ earnedoth paidjoboth `access_basic_services' `social_cohesion' `civic_engagement' `psychological_wellbeing' ///
 `womens_decision_making' `violence_against_women'*/ {
  local label : variable label `var'
  balance `var' "`label'" myfile beneficiaire 
 }
 file write myfile "</table>"
 file write myfile "<p align=small size=-2>Note: Means for groups."
 file write myfile "Standard error of the mean in {curly brackets}."
 file write myfile "Two-tailed test for difference in means."
 file write myfile "Significance level of the test is set to"
 file write myfile "10% (*), 5% (**), and 1% (***).</p><br>"
restore

*b.      (3) vs (6)
preserve
keep if (control==1 | enquete==3)
 file write myfile "<!DOCTYPE html><html lang='en'><head>"
 file write myfile "<p align=center b> TABLE 5. Spillover effects: (3) vs (6) </p><br>"
 file write myfile "<meta charset='utf-8' /></head><body><div><table border=1 align=center>" _n

 file write myfile "<tr><td>Variable</td><td>Description</td><td>N</td><td>Control<br>Mean</td><td>Treatment<br>Mean</td><td>Diff.<br>of Means</td><td>t-Stat</td><td>p-Value"
 *file write myfile "<tr><td>Variable</td><td>Description</td><td>N</td><td>Control<br>Mean</td><td>Treatment<br>Mean</td><td>Diff.<br>of Means</td><td>t-Stat</td><td>p-Value</td><td>D-Stat</td><td>p-Value</td>"
 foreach var of varlist `balance_expost_ind' /*`food_consumption' `expenditures' `shocks' `coping_mechanisms' `hh_assets' `human_capital' `wage_employment' ///
 `other_employment' employs pers_employ /*hoursperm_employ paid_employ*/ ` oth_farm_activ' `debts_and_savings' ///
 empl_futurt_dum1 empl_futurt_dum2 empl_futurt_dum3 empl_futurt_dum4 empl_futur_dum1 empl_futur_dum2 empl_futur_dum3 empl_futur_dum4 emp_futur_cb_win ///
 emp_futur_cb employedhh earnedhh /*paidjobhh*/ earnedoth paidjoboth `access_basic_services' `social_cohesion' `civic_engagement' `psychological_wellbeing' ///
 `womens_decision_making' `violence_against_women'*/ {
  local label : variable label `var'
  balance `var' "`label'" myfile beneficiaire 
 }
 file write myfile "</table>"
 file write myfile "<p align=small size=-2>Note: Means for groups."
 file write myfile "Standard error of the mean in {curly brackets}."
 file write myfile "Two-tailed test for difference in means."
 file write myfile "Significance level of the test is set to"
 file write myfile "10% (*), 5% (**), and 1% (***).</p><br>"
restore


 file close myfile



*OUTCOMES USED FROM SEPT 2016 TO APRIL 2017
/*
local product ///
emploi chomage chomage_recherche reserv_wage reserv_wage_win emploi_2015_a rev_total rev_total_win h_per_day d_per_m

local income ///
rev_total rev_total_win business_q0 f2_val_2 f2_val_2_win 

local consump ///
c12 c3_a_1 c3_b_1  c3_a_6 c3_b_6 ///
c3_a_11 c3_b_11 c4 pain  pain_win legumes legumes_win tabac tabac_win 

local h_capital ///
c13 c13_win formation formation_dum3 formation_dum5 ///
formation_dum7 

local assets ///
c6 c6_win c15 c15_win epargne epargne_pret 

local credit ///
epargne_dette  c20 migration_q5 migration_q5_win 

local service ///
sante_hopital sante_hopital_win sante_qualite_a_dum1 sante_qualite_a_dum2 sante_qualite_a_dum3 ///
sante_qualite_b_dum1 sante_qualite_b_dum2 sante_qualite_b_dum3 sante_qualite_c_dum1 sante_qualite_c_dum2 ///
sante_qualite_c_dum3 sante_qualite_d_dum1 sante_qualite_d_dum2 sante_qualite_d_dum3 ///
q3_score_quality q3_score_time q4_score

local cohesion ///
responsability_dum1 responsability_dum2 responsability_dum4 ///
responsability_dum5 responsability_dum7 utopie_accord_dum1 psy_partage_dum1 psy_partage_dum4 psy_solitude_dum2 ///
psy_solitude_dum3 psy_solitude_dum4 psy_exploit psy_a_menage_dum1 psy_a_menage_dum2 psy_a_menage_dum3

local crime ///
conflit_dispute_in conflit_dispute_out ///
q4_26 q4_27 q1_score

local mental ///
f17_dum1 f17_dum2 ///
emploi_comp_inut emploidiffsal_1 emploidiffsal_4 emploidiffsal_5 ///
emploidiffindep_1 emploidiffindep_4 ///
pearlin_1 psy_a_menage_dum1 psy_a_menage_dum2 psy_a_menage_dum3 psy_depress5 

local relation ///
te_3_dum2 te_3_dum3 te_3_dum4 psy_accepte_dum3 psy_menage_dum2 psy_menage_dum3 ///
violence_1_7 violence_1_9 violence_2_1 violence_2_2 violence_2_3 violence_2_7 violence_2_9

*/





























 
 
 
 

