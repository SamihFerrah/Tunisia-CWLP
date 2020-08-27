********************************************************************************
********************************************************************************
*				CODEBOOK TUNISIA CWLP 										   *
********************************************************************************
********************************************************************************
cd "$git_tunisia/outputs/Main/"
pause on 
clear 
********************************************************************************
********************************************************************************
* 0) DEFINE LOCAL USED TO BUILD INDEX 
********************************************************************************
********************************************************************************


local lab_market_main 	 		emploi_main days_work_main_win hours_work_main_win inc_work_main_win							///
								profit_work_main_win business_q0_main business_q3_main_win business_q5_main_win

														
local eco_welfare 				c3_a_1_win c3_a_2_win c3_a_3_win c3_a_4_win c3_a_5_win c3_a_6_win c3_a_7_win 					///
								c3_a_8_win c3_a_9_win c3_a_10_win c3_a_11_win c4_win c5_win c6_win 								///
								c7_win c8_win c9_win c11_win c12_win c13_win c14_win c16_win c18_win 

local consumption_food 			c3_a_1_win c3_a_2_win c3_a_3_win c3_a_4_win c3_a_5_win c3_a_6_win c3_a_7_win 					///
								c3_a_8_win c3_a_9_win c3_a_10_win c3_a_11_win 

local consumption_other 		c4_win c5_win c6_win c7_win c8_win c9_win c11_win c12_win c13_win c14_win 						///
								c15_win c16_win c18_win 

							
local assets					q2_1_2_win q2_1_3_win q2_1_4_win q2_1_5_win q2_1_6_win q2_1_7_win q2_1_8_win 					///
								q2_1_9_win q2_1_10_win q2_1_11_win q2_1_12_win q2_1_13_win q2_1_14_win 							///
								q2_1_15_win q2_1_16_win q2_1_17_win q2_1_18_win q2_1_19_win 									///
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


local social				association_dummy comite_c comite_c_menage conflit_dispute_in 									///
							conflit_dispute_out   																			///
							security_dummy securite_1 securite_2 securite_3 securite_4										///
							securite_5 securite_6 association_2 association_3 association_4	
							
							
local civic					initiatives_1 initiatives_2 initiatives_3 initiatives_4 initiatives_5 initiatives_6 			///
							initiatives_7 initiatives_8  initiatives_10 initiatives_11 										///
							initiatives_12 initiatives_13 initiatives_14 initiatives_15										///
							isolement_1 isolement_2 isolement_3 isolement_4													///
							source_info2_internal source_info_internal utopie_a_dum1 utopie_b_dum1							

							
local well_being 			psy_anxiete psy_exploit psy_depress5 /*psy_accepte_dum1*/ psy_accepte_dum3 						///
							psy_menage_dum3 /*psy_a_menage_dum1*/ psy_a_menage_dum3	 										///
							psycho_depress4 psycho_depress3 psycho_depress2 psycho_depress1


local woman_violence		violence_1_2 violence_1_3 violence_1_4 violence_1_5 violence_1_6 								///
							violence_1_7 violence_1_8 violence_1_9 violence_1_10 violence_1_11 								///
							violence_1_16 violence_1_17 violence_1_18  	
							

local woman_bargain 		intrahh_7 intrahh_11 emploiw /*association_2*/


local woman_empowerment		intrahh_1 intrahh_2 intrahh_7 intrahh_11 emploiw 												///
							violence_1_2 violence_1_3 violence_1_4 violence_1_5 violence_1_6 								///
							violence_1_7 violence_1_8 violence_1_9 violence_1_10 violence_1_11 								///
							violence_1_16 violence_1_17 violence_1_18  	
			
local initiatives			initiatives_1 initiatives_2 initiatives_3 initiatives_4 initiatives_5 initiatives_6 ///
							initiatives_7 initiatives_8 initiatives_9 initiatives_10 initiatives_11 			///
							initiatives_12 initiatives_13 initiatives_14 initiatives_15
							
local initiatives_meeting	initiatives_1 initiatives_2 initiatives_3 initiatives_4 initiatives_5 initiatives_6 ///
							initiatives_7 initiatives_8 initiatives_9 
							
local initiatives_acting	initiatives_10 initiatives_11 initiatives_12 initiatives_13 initiatives_14 /*initiatives_15bis*/

local information_sources	source_info_internal source_info2_internal 

local utopia				utopie_a_dum1 utopie_b_dum1 

local isolation				isolement_1 isolement_2 isolement_3 isolement_4

local comm_groups			association_1 association_2 association_3 association_4 association_6 association_7 ///
							association_8 association_9 comite_c comite_c_menage
							

local Index_ALL 			lab_market_main /*lab_market_sec*/ eco_welfare consumption_food consumption_other				///
							assets home_assets comms_assets productive_assets 												///
							credit_access pos_coping_mechanisms neg_coping_mechanisms										///
							shocks social civic well_being woman_bargain woman_violence woman_empowerment 					///
							isolation utopia information_sources initiatives_acting initiatives_meeting						///
							initiatives comm_groups
							


********************************************************************************
********************************************************************************
* 1) CODEBOOK 
********************************************************************************
********************************************************************************
use "$stata/enquete_All3", clear 

* Set excel file 
putexcel set "Codebook.xlsx", replace 

* Set column names 
putexcel A1 = "Index"
putexcel B1 = "Variables"
putexcel C1 = "Labels"
putexcel D1 = "Range"
	
* Loop over every index 
local counter_index = 2

foreach index in `Index_ALL'{
	
	local l_`index' : variable label B_f_`index'
	
	putexcel A`counter_index' = "`l_`index''"
	
	local counter_outcome = `counter_index'
	
	* Loop over every individual outcomes of Index 
	foreach individual_outcome of local `index'{
	
		local l_`individual_outcome' : variable label `individual_outcome'_b
		
		putexcel B`counter_outcome'	= "`individual_outcome'"
		putexcel C`counter_outcome' = "`l_`individual_outcome''"
		
		sum `individual_outcome'
		putexcel D`counter_outcome' = "[`r(min)';`r(max)']"
		
		local counter_outcome = `counter_outcome' + 1
	
	}
	
	local counter_index = `counter_outcome' + 1

}



