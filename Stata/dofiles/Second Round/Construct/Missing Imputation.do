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

u "$vera/clean/clean_CashXFollow_PII.dta", clear

foreach sample in followup cash{												// Loop over different dataset 

	if "`sample'" == "followup"{
		local trt_indicator		"program"
		local cond			  `"& Intervention == "Follow up - TCLP""'			// Empty for now but might be useful later for the heterogeneity
	}

	if "`sample'" == "cash"{
		local trt_indicator "trt_cash"
		local cond			`"& Intervention == "Cash Grants - Women""'			// Empty for now but might be useful later for the heterogeneity
	}
		
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
