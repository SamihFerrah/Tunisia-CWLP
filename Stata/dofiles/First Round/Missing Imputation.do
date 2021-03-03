********************************************************************************
********************************************************************************
*						IMPUT MISSING VARIABLE TUNISIA
********************************************************************************
********************************************************************************


							
local all_outcomes 																// Fill this local with outcomes variables
local all_controls


********************************************************************************
********************************************************************************
* 1) Imput outcomes variables
********************************************************************************
********************************************************************************

foreach sample in followup cash{												// Loop over different dataset 

			
	if "`sample'" == "followup"{
		local trt_indicator		"beneficiaire"
		local cond			  `"& Intervention == "Follow up - TCLP""'					// Empty for now but might be useful later for the heterogeneity
	}

	if "`sample'" == "followup"{
		local trt_indicator "trt_cash"
		local cond			`"& Intervention == "Cash Grants - Women""'															// Empty for now but might be useful later for the heterogeneity
	}



/* No need for now but might be handy when having to do heterogeneous analysis 

foreach specification in  between   within   spillovers    full 	///
						  between_w within_w spillovers_w  full_w 	///
						  between_m within_m spillovers_m full_m  {
						  

	if "`specification'" == "between"{
	local cond 			= "between == 1"
	local trt_indicator = "beneficiaire"
	local var_suffix	= "b"	
	}
	
	if "`specification'" == "within"{
	local cond 			= "within == 1"
	local trt_indicator = "program"
	local var_suffix	= "w"	
	}
	
	if "`specification'" == "spillovers"{
	local cond 			= "spillovers == 1"
	local trt_indicator = "beneficiaire"
	local var_suffix	= "s"	
	}
	
	if "`specification'" == "full"{
	local cond 			= "full == 1"
	local trt_indicator = "trt_full"
	local var_suffix	= "f"	
	}
	
	if "`specification'" == "infrastructure"{
	local cond 			= "infrastructure == 1"
	local trt_indicator = "beneficiaire"
	local var_suffix	= "i"	
	}
	
	
	**********************************
	**********************************
	
	if "`specification'" == "between_w"{
	local cond 			= "between == 1 & repondant_sex == 0"
	local trt_indicator = "beneficiaire"
	local var_suffix	= "b_w"	
	}
	
	if "`specification'" == "within_w"{
	local cond 			= "within == 1 & repondant_sex == 0"
	local trt_indicator = "program"
	local var_suffix	= "w_w"	
	}
	
	if "`specification'" == "spillovers_w"{
	local cond 			= "spillovers == 1 & repondant_sex == 0"
	local trt_indicator = "beneficiaire"
	local var_suffix	= "s_w"
	}
	
	if "`specification'" == "full_w"{
	local cond 			= "full == 1 & repondant_sex == 0"
	local trt_indicator = "trt_full"
	local var_suffix	= "f_w"	
	}
	
	if "`specification'" == "infrastructure"{
	local cond 			= "infrastructure == 1 & repondant_sex == 0"
	local trt_indicator = "beneficiaire"
	local var_suffix	= "i_w"	
	}
	
	**********************************
	**********************************


	if "`specification'" == "between_m"{
	local cond 			= "between == 1 & repondant_sex == 1"
	local trt_indicator = "beneficiaire"
	local var_suffix	= "b_m"
	
* Redefine local with outcomes without female empowerment related one

local all_individual 	c3_a_1_win c3_a_2_win c3_a_3_win c3_a_4_win c3_a_5_win c3_a_6_win c3_a_7_win 					///
						c3_a_8_win c3_a_9_win c3_a_10_win c3_a_11_win c4_win c5_win c6_win 								///
						c7_win c8_win c9_win c11_win c12_win c13_win c14_win c15_win c16_win c18_win 					///
						q2_1_2_win q2_1_3_win q2_1_4_win q2_1_5_win q2_1_6_win q2_1_7_win q2_1_8_win 					///
						q2_1_9_win q2_1_10_win q2_1_11_win q2_1_12_win q2_1_13_win q2_1_14_win 							///
						q2_1_15_win q2_1_16_win q2_1_17_win q2_1_18_win q2_1_19_win 									///
						q2_1_20_win q2_1_21_win q2_1_22_win 															///
						epargne_dette epargne_dette_cb_win epargne epargne_cb_win epargne_pret							///				
						g2_4 g2_5 g2_6  g2_8 g2_9 g2_10 g2_11 g2_12 													///
						g2_1 g2_2 g2_7 g2_13 g2_14 g2_15																///
						g1_1 g1_2 g1_3 g1_4 g1_5 g1_6 g1_7 g1_8 g1_9													///
						association_1 association_2 association_9														///
						association_3 association_4 association_6 /*association_7 association_8*/  						///
						initiatives_1 initiatives_2 initiatives_3 initiatives_4 initiatives_5 initiatives_6 			///
						initiatives_7 initiatives_8  initiatives_10 initiatives_11 										///
						initiatives_12 initiatives_13 initiatives_14 initiatives_15 initiative_dummy					///		
						psy_anxiete psy_exploit psy_depress5 /*psy_accepte_dum1*/ psy_accepte_dum3 						///
						psy_menage_dum3 /*psy_a_menage_dum1*/ psy_a_menage_dum3	 										///
						psycho_depress4 psycho_depress3 psycho_depress2 psycho_depress1									///
						source_info_internal source_info2_internal 														///
						utopie_a_dum1  utopie_a_dum3 utopie_b_dum1  utopie_b_dum3										///
						isolement_1 isolement_2 isolement_3 isolement_4 isolation_dummy									///
						association_dummy comite_c comite_c_menage conflit_dispute_in conflit_dispute_out 				///
						migration_cm_q1 migration_q1 security_dummy														///
						association_7 association_8 securite_1 securite_2 securite_3 securite_4							///
						securite_5 securite_6
						
	}
	
	if "`specification'" == "within_m" {
	local cond 			= "within == 1 & repondant_sex == 1"
	local trt_indicator = "program"
	local var_suffix	= "w_m"
	}
	
	if "`specification'" == "spillovers_m" {
	local cond 			= "spillovers == 1 & repondant_sex == 1"
	local trt_indicator = "beneficiaire"
	local var_suffix	= "s_m"
	}
	
	if "`specification'" == "full_m" {
	local cond 			= "full == 1 & repondant_sex == 1"
	local trt_indicator = "trt_full"
	local var_suffix	= "f_m"
	}
	
	if "`specification'" == "infrastructure"{
	local cond 			= "infrastructure == 1 & repondant_sex == 1"
	local trt_indicator = "beneficiaire"
	local var_suffix	= "i_m"	
	}

*/
		
	foreach variables in `all_outcomes' {

			forvalue i = 0/1 {
		
				sum     `variables'_`var_suffix' if `trt_indicator' == `i' `cond'
				
				replace `variables'_`var_suffix' = `r(mean)' if   `variables'_`var_suffix' ==.  & `trt_indicator' == `i' `cond' | ///
																  `variables'_`var_suffix' ==.d & `trt_indicator' == `i' `cond' | ///
																  `variables'_`var_suffix' ==.a & `trt_indicator' == `i' `cond' | ///
																  `variables'_`var_suffix' ==.n & `trt_indicator' == `i' `cond'
			}
	}
	
}


********************************************************************************
********************************************************************************
* 2) Imput control variables 
********************************************************************************
********************************************************************************

foreach sample in followup cash{												// Loop over different dataset 

			
	if "`sample'" == "followup"{
		local trt_indicator		"beneficiaire"
		local cond			  `"& Intervention == "Follow up - TCLP""'					// Empty for now but might be useful later for the heterogeneity
	}

	if "`sample'" == "followup"{
		local trt_indicator "trt_cash"
		local cond			`"& Intervention == "Cash Grants - Women""'															// Empty for now but might be useful later for the heterogeneity
	}
		
	foreach variables in `all_controls' {

			forvalue i = 0/1 {
		
				g     	m_`variables' = 0 
				replace m_`variables' = 1 if `variables' ==.   `cond' | ///
											 `variables' ==.d  `cond' | ///
											 `variables' ==.a  `cond' | ///
											 `variables' ==.n  `cond'
				
				replace `variables' = 1 if   `variables' ==.   `cond' | ///
											 `variables' ==.d  `cond' | ///
											 `variables' ==.a  `cond' | ///
											 `variables' ==.n  `cond'
			}
	}
	
}

save "$vera/temp/clean_CashXFollow_PII_imputed.dta", replace
