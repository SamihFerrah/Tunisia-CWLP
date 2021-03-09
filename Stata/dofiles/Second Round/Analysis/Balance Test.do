
********************************************************************************
********************************************************************************

********************************************************************************
********************************************************************************

********************************************************************************
********************************************************************************
* 0) Define local with variables to test 
********************************************************************************
********************************************************************************
cap file close Table
cd "$git_tunisia/outputs/Main/"
pause on 
clear 


local balance_indiv 	repondant_age_b repondant_educ_b			///
						hhsize_b adult_num_b jeunes_lireecrire_b emploi_2013_a_b	///
						formation_b origine_naissance_b origine_naissance_bis_b 	
					

********************************************************************************
********************************************************************************						
* 1) Balance test at individual level 
********************************************************************************
********************************************************************************						
	

u "$vera/clean/clean_CashXFollow_PII.dta", clear

keep if Intervention == "Cash Grants - Women"

* Replace treatment indicator to missing if respondent is attrited

replace trt_cash_0 = . if attrition == 1
replace trt_cash_1 = . if attrition == 1

	* Some re-labelling 
	
	/*
	* Drop label
	foreach covariates in `balance_indiv'{
		
		label var `covariates' drop
		
	}
	*/
	
	label var repondant_age_b			"Age"
	label var repondant_educ_b			"Education"
	label var hhsize_b					"HH size"
	label var h_18_65_b					"Male 18-65 years old"
	label var f_18_65_b					"Female 18-65 years old"
	label var jeunes_lireecrire_b		"Illiterate adult"
	label var emploi_2013_a_b			"Worked 3 month (2013)"
	label var formation_b				"Professional training"
	label var origine_naissance_b		"Born imada"
	label var origine_naissance_bis_b	"Born gouvernorat"
	label var trauma_abus_b				"Victim violence (1987-2010)"
		
		
	*******************************************
	* Difference
	*******************************************
	
	forvalue i = 0/1{
	
		iebaltab `balance_indiv', grpvar(trt_cash_`i') fixedeffect(Strata) normdiff pftest pttest total grplabel("0 Control @ 1 Treatment") rowvarlabels savetex("Balance Test Cash/Table_Balance_Individual_`i'.tex") replace
	
	}

	********************************************
	* Omnibus test
	********************************************
	
	forvalue i = 0/1{
		
		local count_out = 0
		
		* Regression
		reg trt_cash_`i' `balance_indiv' i.Strata, robust 
		
		local n`i' = e(N)
		
		foreach variables in `balance_indiv' {
			
			local count_out = `count_out' + 1 
			
			local l_`count_out' : variable label `variables'
							
				local c`i'_2_`count_out' 	: di%12.3f _b[`variables']
				local se`i'_2_`count_out' 	: di%12.3f _se[`variables']
					
				* Compute p-value
				local pval`i'_2_`count_out' = ttail(e(df_r),abs(_b[`variables']/_se[`variables']))*2	
				
				* Format local 
				local pval`i'_2_`count_out' : di%12.3f `pval`i'_2_`count_out''
				local se`i'_2_`count_out' = trim("`se`i'_2_`count_out''")
				local se`i'_2_`count_out' 		 "(`se`i'_2_`count_out'')"
				local se`i'_2_`count_out' = trim("`se`i'_2_`count_out''")
				
				* Add stars
				if `pval`i'_2_`count_out'' < 0.1{
					local s`i'_2_`count_out' "*"
				}
				if `pval`i'_2_`count_out'' < 0.05{
					local s`i'_2_`count_out' "**"
				}
				if `pval`i'_2_`count_out'' < 0.01{
					local s`i'_2_`count_out' "***"
				}
		}
		
	* Test
	test `balance_indiv'
	
	local p`i' : di%12.3f `r(p)'
	local f`i' : di%12.3f `r(F)'
	
	}
	
	* Export table
	
	file open Table using "Balance Test Cash/Table_Balance_Omni.tex", text write replace

	forvalue i = 1/`count_out'{
	
		file write Table																																				_n ///
		" `l_`i''					& `c0_2_`i''`s0_2_`i'' 	& `pval0_2_`count_out''	 & `c1_2_`i''`s1_2_`i'' & `pval1_2_`count_out''		\\ " 	_n ///
		" 							&  `se0_2_`i''			& 				  	 	 &  `se1_2_`i''			&  							\\ " 	_n ///
		
	}
	
	file write Table																															_n ///
		"\hline																															  "		_n ///
		"Observation				& `n0'					&						&	`n1'				&							\\"		_n ///
		"F-stat						& `f0'					&						&	`f1'				&							\\"		_n ///
		"P-value					& `p0'					&						&	`p1'				&							\\"		_n
	
	file close Table
	
	********************************************
	* Balance test on individual covariates
	********************************************
	
	local count_out = 0 
	
	mat def pvalue = J(11,3,.)
	
	forvalue i = 0/1{
		
		local count_out = 0 
		
		foreach covariates in `balance_indiv' {
			
			local count_out = `count_out' + 1 
			
			local l_`count_out' : variable label `covariates'
					
			reg `covariates' trt_cash_`i' i.Strata, robust
			
				local c_1_`count_out' 	: di%12.3f _b[trt_cash]
				local se_1_`count_out' 	: di%12.3f _se[trt_cash]
				local n_1_`count_out' 	= e(N)
				local r2_1_`count_out' 	= e(R2)
					
				* Compute p-value
				local pval_1_`count_out' = ttail(e(df_r),abs(_b[trt_cash]/_se[trt_cash]))*2	
				
				* Format local 
				local pval_1_`count_out' : di%12.3f `pval_1_`count_out''
				local se_1_`count_out' = trim("`se_1_`count_out''")
				local se_1_`count_out' 		 "(`se_1_`count_out'')"
				local se_1_`count_out' = trim("`se_1_`count_out''")
				
				* Add stars
				if `pval_1_`count_out'' < 0.1{
					local s_1_`count_out' "*"
				}
				if `pval_1_`count_out'' < 0.05{
					local s_1_`count_out' "**"
				}
				if `pval_1_`count_out'' < 0.01{
					local s_1_`count_out' "***"
				}
		}
	
	
	* Export TeX Tables of balance test at individual level 


	file open Table using "Balance Test Cash/Table_Balance_Individual_Cov_`i'.tex", text write replace
		
	file write Table  															_n ///
	" `l_1'			& 	`c_1_1'`s_1_1' 		& `pval_1_1' & `n_1_1' 		\\ " 	_n ///
	" 				&	 `se_1_1' & &							   		\\ " 	_n ///
	" `l_2'			& 	`c_1_2'`s_1_2' 		& `pval_1_2' & `n_1_2' 		\\ " 	_n ///
	" 				&	 `se_1_2' & &							   		\\ " 	_n ///
	" `l_3'			& 	`c_1_3'`s_1_3' 		& `pval_1_3' & `n_1_3' 		\\ " 	_n ///
	" 				&	 `se_1_3' & &							   		\\ " 	_n ///
	" `l_4'			& 	`c_1_4'`s_1_4' 		& `pval_1_4' & `n_1_4' 		\\ " 	_n ///
	" 				&	 `se_1_4' & &							   		\\ " 	_n ///
	" `l_5'			& 	`c_1_5'`s_1_5' 		& `pval_1_5' & `n_1_5' 		\\ " 	_n ///
	" 				&	 `se_1_5' & &							   		\\ " 	_n ///
	" `l_6'			& 	`c_1_6'`s_1_6' 		& `pval_1_6' & `n_1_6' 		\\ " 	_n ///
	" 				&	 `se_1_6' & &							   		\\ " 	_n ///
	" `l_7'			& 	`c_1_7'`s_1_7' 		& `pval_1_7' & `n_1_7' 		\\ " 	_n ///
	" 				&	 `se_1_7' & &							   		\\ " 	_n ///
	" `l_8'			& 	`c_1_7'`s_1_8' 		& `pval_1_8' & `n_1_8' 		\\ " 	_n ///
	" 				&	 `se_1_8' & &							   		\\ " 	_n ///
	" `l_9'			& 	`c_1_9'`s_1_9' 		& `pval_1_9' & `n_1_9' 		\\ " 	_n ///
	" 				&	 `se_1_9' & &							   		\\ " 	_n 
	
	file close Table	

}
	
	
	