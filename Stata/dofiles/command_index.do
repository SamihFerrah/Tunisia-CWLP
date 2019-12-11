
*calculate indexes for mean effect. from Kling Liebman Katz 2007


*INDEX CALCULATION
*Will want to calculate this after the balance calc, to present in same table...
cap program drop index
program define index
args condTC TCtype myfile /*, allgroups(namelist) overall_vars(varlist)*/


*CREATE USEFUL LOCALS FOR INDEX CALCULATION:
*locals for categories of variables


local food_consump_win 		c3_a_1_win6 c3_a_2_win6 c3_a_3_win c3_a_4_win5 c3_a_5_win5 c3_a_6_win5 c3_a_7_win5 	///
							c3_a_8_win5 c3_a_9_win c3_a_10_win c3_a_11_win5 

local expenditure_win 		exp_food_win c4_win c5_win5 c6_win5 c7_win5 c8_win5 c9_win c11_win c12_win c13_win c14_win ///
							c15_win c16_win c18_win 

local coping_mechanisms 	g2_1 g2_2 g2_3 g2_4 g2_5 g2_6 g2_7 g2_8 g2_9 g2_10 g2_11 g2_12 g2_13 g2_14 g2_15

local hh_assets2			q2_1_2_win q2_1_3 q2_1_4 q2_1_5 q2_1_6 q2_1_7 q2_1_8 q2_1_9 q2_1_10 q2_1_11 		///
							q2_1_12 q2_1_13_win q2_1_14 q2_1_15 q2_1_16_win q2_1_17 q2_1_18_win q2_1_19_win ///
							q2_1_20 q2_1_21 q2_1_22 q2_1_23_win mur_dummy toit_dummy proprietaire_dum1 		///
							titre proprietaire_terre superficie_m titre_terre f18_dummy
						
local house_ownership		proprietaire_dum1bis titrebis proprietaire_terrebis titre_terrebis
						
local large_assets			q2_1_2_winbis q2_1_3bis q2_1_4bis q2_1_5bis q2_1_6bis q2_1_9bis q2_1_10bis		///
							q2_1_12bis q2_1_13_winbis q2_1_17bis  q2_1_20bis q2_1_21bis q2_1_22bis 
						  
local small_assets			q2_1_7bis q2_1_8bis q2_1_11bis q2_1_14bis q2_1_15bis q2_1_16_winbis q2_1_18_winbis ///
							q2_1_19_winbis q2_1_23_winbis 

local home_assets			q2_1_2_winbis2 q2_1_3bis2 q2_1_4bis2 q2_1_5bis2 q2_1_6bis2 q2_1_7bis2 q2_1_8bis2  	
	
local comms_assets			q2_1_12bis2 q2_1_13_winbis2 q2_1_14bis2 q2_1_15bis2 q2_1_16_winbis2  

local productive_assets		q2_1_9bis2 q2_1_10bis2 q2_1_11bis2 q2_1_17bis2 q2_1_18_winbis2 q2_1_19_winbis2 ///
							q2_1_20bis2 q2_1_21bis2 //q2_1_22bis2

local human_capital2 		formation formation_dum1 formation_dum2 formation_dum3 formation_dum4 	///
							formation_dum5 formation_dum6 formation_dum7 formation_dum9 			///
							formation_dum10 emploi_comp_inut

local wage_employment2 		emploi tspent_main earned_main_win employedhh earnedhh_win ///
							paidjobhh earnedoth paidjoboth								

local other_employment 		sec_empl tspent_sec_win earned_sec

local non_agri_enterp 		employs pers_employ hoursperm_employ paid_employ

local debts_and_savings2 	epargne epargne_forme_3 epargne_cb epargne_dette epargne_dette_cb_win epargne_pret

local debts					epargne_dettebis epargne_dette_cb_winbis //epargne_pret

local savings				epargnebis epargne_forme_3bis epargne_cbbis

local employ_aspirations	futur_services emp_futur_cb_win //futur_agriculture

local social_cohesion2		association_dummy comite_c comite_c_menage conflit_dispute_in conflit_dispute_out ///
							/*migration_cm_q1 migration_q1*/ security_dummy							

local comm_groups			association_1 association_2 association_3 association_4 association_6 association_7 ///
							association_8 association_9 comite_cbis comite_c_menagebis

local local_conflict		conflit_dispute_inbis conflit_dispute_outbis

local recent_migration		migration_cm_q1bis migration_q1bis

local local_security		/*securite_1 securite_2 */ securite_3 /* securite_4 */ securite_5 securite_6

local civic_engag 			initiative_dummy utopie_a_dum1 utopie_b_dum1 source_info_internal source_info2_internal ///
							isolation_dummy
							
local initiatives			initiatives_1 initiatives_2 initiatives_3 initiatives_4 initiatives_5 initiatives_6 ///
							initiatives_7 initiatives_8 initiatives_9 initiatives_10 initiatives_11 			///
							initiatives_12 initiatives_13 initiatives_14 initiatives_15
							
local initiatives_meeting	initiatives_1bis initiatives_2bis initiatives_3bis initiatives_4bis initiatives_5bis initiatives_6bis ///
							initiatives_7bis initiatives_8bis initiatives_9bis 
							
local initiatives_acting	initiatives_10bis initiatives_11bis initiatives_12bis initiatives_13bis initiatives_14bis /*initiatives_15bis*/

local information_sources	source_info_internalbis source_info2_internalbis 

local utopia				utopie_a_dum1bis  utopie_a_dum3 utopie_b_dum1bis  utopie_b_dum3

local isolation				isolement_1 isolement_2 isolement_3 isolement_4

local psycho_wellbeing2		psy_anxiete psy_exploit psy_depress5 /*psy_accepte_dum1*/ psy_accepte_dum3 	///
							psy_menage_dum3 /*psy_a_menage_dum1*/ psy_a_menage_dum3	
						
local psycho_internal   	psy_anxietebis psy_exploitbis psy_depress5bis

local psycho_external		/*psy_accepte_dum1bis*/ psy_accepte_dum3bis psy_menage_dum3bis 				///
							/*psy_a_menage_dum1bis*/ psy_a_menage_dum3bis							

local womens_decision 		intrahh_1 intrahh_2 intrahh_7 intrahh_11 emploiw
							
local overall_intrahouse2	intrahh_1bis intrahh_2bis intrahh_7bis intrahh_11bis emploiwbis ///
							violence_physical violence_emotional

local violence_ag_women 	violence_1_2 violence_1_3 violence_1_4 violence_1_5 violence_1_6 ///
							violence_1_7 violence_1_8 violence_1_9 violence_1_10 violence_1_11 ///
							violence_1_16 violence_1_17 violence_1_18
	
	
	
*********************************************************************************************************************************	

* ERIC'S PRT TALK JAN 2018
* VIOLENCE
*local_conflict									//land dispute?						
local five_years_chef		q4_26_dum q4_27_dum /*q4_34_dum*/
/*local six_months_chef		q1_1_1 q1_1_2 q1_1_3 q1_1_4 q1_1_5 q1_1_6 q1_1_7*/
*local_security
local local_sec_all			securite_1 securite_2 securite_3bis securite_4 securite_5bis securite_6bis
local intrahh_prt			intrahh_7bis2 intrahh_11bis2 violence_physicalbis violence_emotionalbis

* SOCIAL CAPITAL/COLLECTIVE ACTION
local social_capital		association_dummybis /*psy_accepte_dum3bis psy_menage_dum3bis*/ psy_a_menage_dum3bis2	///
							q4_28_dum //trust chief

local cooperation			initiative_dummybis comite_cbis2 /*comite_c_menagebis2*/ comite_c_autrevillages
local participation			initiatives_1bis2 initiatives_2bis2 /*initiatives_3bis2*/ initiatives_4bis2 initiatives_5bis2 
							/*initiatives_6bis2 initiatives_7bis2 initiatives_8bis2*/ 
local utopie				utopie_a_dum1bis2 utopie_b_dum1bis2 utopie_d_dum1 utopie_e_dum1 /*q4_35_dum*/
local pol_isolation			isolement_1bis isolement_2bis isolement_3bis /*isolement_4bis*/ source_info_internalbis2 	///
							source_info2_internbis2


*********************************************************************************************************************************



local allgroups2	food_consump_win expenditure_win coping_mechanisms hh_assets2 house_ownership		///
					large_assets small_assets home_assets comms_assets productive_assets human_capital2 ///
					wage_employment2 other_employment non_agri_enterp /*agri_prod_income*/ debts_and_savings2 ///
					employ_aspirations social_cohesion2 comm_groups local_conflict recent_migration		///
					local_security civic_engag initiatives initiatives_meeting initiatives_acting		///
					information_sources utopia isolation psycho_wellbeing2 psycho_internal psycho_external ///
					/*pearlin_index*/ overall_intrahouse2 womens_decision violence_ag_women debts savings	///
					five_years_chef local_sec_all intrahh_prt social_capital cooperation participation 	///
					utopie pol_isolation


* local condTC beneficiaire
* local TCtype Vil
 *di "`condTC'"
 *di "`TCtype'"
 *di "`allgroups'"
 
 *****by outcome groups
 foreach group of local allgroups2 {
 *di "`group'" 

 *****by variable in group:  

  foreach outcome of local `group' {
   
   *local outcome violence_2_7I
   *local condTC beneficiaire
   *local TCtype Vil
 
   *di "`outcome'" //product_idx
   sum `outcome' if `condTC'==0
      *sum `outcome' if `condTC'==1 //tempo
   local ctrlmean=r(mean)
   local ctrlsd=r(sd)

   gen `TCtype'`outcome'_ctr=(`outcome'-`ctrlmean')
   gen `TCtype'`outcome'_norm=`TCtype'`outcome'_ctr/`ctrlsd'
   /*qui*/ sum `TCtype'`outcome'_norm
   local mean_norm=r(mean)
   file write myfile "<tr><td>`TCtype'</td><td>`group'</td><td>`outcome'</td><td>`ctrlmean'</td><td>`ctrlsd'</td><td>`mean_norm'"
  }

 *create index per group of outcomes
  local group2 ""
  foreach var of local `group' {
  local group2 `group2' `TCtype'`var'_norm
  }
  *di "`group2'"
   
  egen `TCtype'T`group'=rowtotal(`group2'), m
  *browse `TCtype'T*
  local n_group: word count `group2'
  gen `TCtype'`group'=`TCtype'T`group'/`n_group'
  qui sum `TCtype'`group'
  local mean_gr=r(mean)
  file write myfile "</td><td>`mean_gr'" 
  
 }
/*
 *create overall index
 local overall_vars2 ""
 foreach var of local overall_vars {
 local overall_vars2 `overall_vars2' `TCtype'`var'_norm
 }
 *di "`overall_vars2'" 
 
 egen `TCtype'Toverall=rowtotal(`overall_vars2'), m
 local n_overall: word count `overall_vars'
 gen `TCtype'overall=`TCtype'Toverall/`n_overall'
 qui sum `TCtype'overall
 local mean_all=r(mean)
 di "`mean_all'"
 file write myfile "</td><td>`mean_all'"   
*/    
 local ctrlmean=.
 local ctrlsd=.
 local mean_norm=.
 local n_group=.
 local mean_gr=.
 local n_overall=.
 local mean_all=.
 
 file write myfile "</td></tr>" _n

end

/*

local product_idx ///
emploi chomageI chomage_recherche reserv_wage_winI emploi_2015_a revT_win ///
d_per_m h_per_day 

local income_idx ///
revT_win2 /// repetition
business_q0 f2_val_2_win 

local consump_idx ///
c12 c3_a_1 c3_b_1  c3_a_4 c3_b_4 c3_a_6 c3_b_6 c3_a_11 c3_b_11 c4 /*pain_win ///
legumes_win tabac_win*/ 

local h_capital_idx ///
c13_win formation formation_dum3 formation_dum5 formation_dum7 

local assets_idx ///
c6_win c15_win epargne epargne_pret 

local credit_idx ///
epargne_detteI c20I migration_q5_winI 

local service_idx ///
sante_hopital_win sante_qualite_a_dum1I sante_qualite_a_dum3 ///
sante_qualite_b_dum1I sante_qualite_b_dum3 sante_qualite_c_dum1I sante_qualite_c_dum3 ///
sante_qualite_d_dum1I sante_qualite_d_dum3 ///
q3_score_quality q3_score_timeI q4_score

local cohesion_idx ///
responsability_dum1 responsability_dum2 responsability_dum4 responsability_dum5I ///
responsability_dum7I  utopie_accord_dum1 psy_partage_dum1 psy_partage_dum4I ///
psy_solitude_dum2I psy_solitude_dum3 psy_solitude_dum4I psy_exploitI ///
psy_a_menage_dum1I psy_a_menage_dum2I psy_a_menage_dum3

local crime_idx ///
conflit_dispute_inI conflit_dispute_outI ///
q4_26 q4_27 q1_scoreI

local mental_idx ///
f17_dum1I emploi_comp_inutI emploidiffsal_1I emploidiffsal_4 emploidiffsal_5 ///
emploidiffindep_1I emploidiffindep_4 pearlin_1 ///
psy_a_menage_dum12I psy_a_menage_dum22I psy_a_menage_dum32 /// repetition
psy_depress5I 

local relation_idx ///
te_3_dum2I te_3_dum3 te_3_dum4 psy_accepte_dum3 psy_menage_dum2 psy_menage_dum3 ///
violence_1_7I violence_1_9I violence_2_1I violence_2_2I violence_2_3I violence_2_7I violence_2_9I 

local allgroups product_idx income_idx consump_idx h_capital_idx assets_idx credit_idx service_idx cohesion_idx ///
crime_idx mental_idx relation_idx
*/
