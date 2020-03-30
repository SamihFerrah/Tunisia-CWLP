********************************************************************************
********************************************************************************
*						IMPUT MISSING VARIABLE TUNISIA
********************************************************************************
********************************************************************************

u "$stata/enquete_indiv5", clear 

* Imput missing variable 

/* --> Previous one 
local lab_market_main			futur_services emp_futur_cb_win5 emploi /*tspent_main earned_main_win5 */
							
							
local lab_market_sec			/*earnedoth_win5 paidjoboth sec_empl tspent_sec_win5 earned_sec_win5*/
*/							
							
local eco_welfare 				c3_a_1_win5 c3_a_2_win5 c3_a_3_win5 c3_a_4_win5 c3_a_5_win5 c3_a_6_win5 c3_a_7_win5 				///
								c3_a_8_win5 c3_a_9_win5 c3_a_10_win5 c3_a_11_win5 c4_win5 c5_win5 c6_win5 							///
								c7_win5 c8_win5 c9_win5 c11_win5 c12_win5 c13_win5 c14_win5 c16_win5 c18_win5 


local assets					q2_1_2_win5 q2_1_3_win5 q2_1_4_win5 q2_1_5_win5 q2_1_6_win5 q2_1_7_win5 q2_1_8_win5 					///
								q2_1_9_win5 q2_1_10_win5 q2_1_11_win5 q2_1_12_win5 q2_1_13_win5 q2_1_14_win5 							///
								q2_1_15_win5 q2_1_16_win5 q2_1_17_win5 q2_1_18_win q2_1_19_win5 										///
								q2_1_20_win5 q2_1_21_win5 q2_1_22_win5 /*q2_1_23_win5 mur_dummy toit_dummy proprietaire_dum1 					///
								titre proprietaire_terre superficie_m titre_terre*/ 
						

local credit_access				epargne_dette epargne_dette_cb_win5 epargne epargne_cb epargne_pret											


local pos_coping_mechanisms		g2_3 g2_4 g2_5 g2_6  g2_8 g2_9 g2_10 g2_11 g2_12 

local neg_coping_mechanisms		g2_1 g2_2 g2_7 g2_13 g2_14 g2_15	


local shocks					g1_1 g1_2 g1_3 g1_4 g1_5 g1_6 g1_7 g1_8 g1_9


* comite_c comite_c_menage comite_cbis comite_c_menagebis association_dummy  migration_cm_q1 migration_q1

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
							

local woman_bargain 		intrahh_1 intrahh_2 intrahh_7 intrahh_11 emploiw 


local Index_ALL 			/*lab_market_main*/ eco_welfare assets credit_access pos_coping_mechanisms neg_coping_mechanisms	///
							shocks social civic well_being woman_violence woman_bargain
							
							

foreach spec in between within spillovers full{								// Loop over every specification (control group differ between those)

	* Define local specific to specification
	
	if "`spec'" == "between"{
	local prg_condition = "between"
	local trt_indicator = "beneficiaire"
	local spec_prefix 	= "b"
	}
	
	if "`spec'" == "within"{
	local prg_condition = "within"
	local trt_indicator = "program"
	local spec_prefix 	= "w"
	}
	
	if "`spec'" == "spillovers"{
	local prg_condition = "spillovers"
	local trt_indicator = "beneficiaire"
	local spec_prefix 	= "s"
	}
	
	if "`spec'" == "full"{
	local prg_condition = "full"
	local trt_indicator = "trt_full"
	local spec_prefix 	= "f"
	}
	
	foreach index in `Index_ALL'{
		
		foreach variables of local `index'{

			forvalue i = 0/1{
		
				sum      `variables'_`spec_prefix' if `trt_indicator' == `i' & `prg_condition' == 1
				
				replace `variables'_`spec_prefix' = `r(mean)' if  `variables'_`spec_prefix' ==.  & `trt_indicator' == `i' & `prg_condition' ==1 | ///
																  `variables'_`spec_prefix' ==.d & `trt_indicator' == `i' & `prg_condition' ==1 | ///
																  `variables'_`spec_prefix' ==.a & `trt_indicator' == `i' & `prg_condition' ==1 | ///
																  `variables'_`spec_prefix' ==.n & `trt_indicator' == `i' & `prg_condition' ==1	
			}
		}
	}
}

save "$stata/enquete_indiv5_imputed", replace
