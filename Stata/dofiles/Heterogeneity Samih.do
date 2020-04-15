********************************************************************************
********************************************************************************
* 								HETEROGENEITY 								   *
********************************************************************************
********************************************************************************




local Index_ALL 	lab_market_main /*lab_market_sec*/ eco_welfare assets credit_access pos_coping_mechanisms neg_coping_mechanisms	///
					shocks social civic well_being /*woman_empowerment*/

							
					
* Controls : ADJUSTED TO REFLECT THE ONES THAT ARE NOT BALANCED.

	local ctrl_Aa 	hhsize missing_hhsize drepondant_mat missing_drepondant_mat 									///
					adult_num missing_adult_num 																	///
					q0_1_c missing_q0_1_c posevent_8 missing_posevent_8
				  
	local ctrl_Ba 
	
	local ctrl_Cb 	hhsize missing_hhsize drepondant_mat missing_drepondant_mat 									///
					adult_num missing_adult_num 																	///
					q0_1_c missing_q0_1_c posevent_8 missing_posevent_8
					

********************************************************************************
********************************************************************************

use "$stata/enquete_All3", clear 

********************************************************************************
********************************************************************************
* 2) Regression results without imada fixed effect
********************************************************************************
********************************************************************************

{

	* Create interaction between treatment and treatment intensity variable 
	
	g maleXbeneficiaire = repondant_sex*beneficiaire
	
	g maleXprograms = repondant_sex*programs 
	replace maleXprograms = 0 if programs ==.

	local counter_reg = 1
	
	mat def pvalue = J(11,5,.)
	
	local count_out = 0 

	foreach outcome in `Index_ALL' {

	preserve
	
		if "`outcome'" == "woman_violence" | "`outcome'" == "woman_bargain"{
			keep if repondant_sex == 0
		}
		
		local count_out = `count_out' + 1
				
		local l_`count_out' : variable label IAaS`outcome'
		
		local caption_`count_out' = "`l_`count_out''"
		
		* Between 
			
			eststo between: regress IAaS`outcome' beneficiaire maleXbeneficiaire repondant_sex `ctrl_Aa' if between == 1, vce (cluster imada)
				
				local c_1_`count_out' : di%12.3f _b[beneficiaire]
				local se_1_`count_out' : di%12.3f _se[beneficiaire]
				local n_1_`count_out' = e(N)
				local r2_1_`count_out' : di%12.3f e(r2)
				
				mat def pvalue[`count_out',1] = ttail(e(df_r),abs(_b[beneficiaire]/_se[beneficiaire]))*2	

		* Within 
		
			eststo within: regres IBaS`outcome' programs maleXprograms repondant_sex `ctrl_Ba' if within == 1, robust
			
				local c_2_`count_out' : di%12.3f  _b[programs]
				local se_2_`count_out' : di%12.3f _se[programs]
				local n_2_`count_out'  = e(N)
				local r2_2_`count_out' : di%12.3f e(r2)
				
				mat def pvalue[`count_out',2] = ttail(e(df_r),abs(_b[programs]/_se[programs]))*2	
				
		* Spillovers classic 
		
			eststo spill1: regres ICbS`outcome' beneficiaire maleXbeneficiaire repondant_sex `ctrl_Cb'  if spillovers == 1, vce (cluster imada)
			
				local c_3_`count_out' : di%12.3f _b[beneficiaire]
				local se_3_`count_out' : di%12.3f _se[beneficiaire]
				local n_3_`count_out' = e(N)
				local r2_3_`count_out' : di%12.3f e(r2)
				
				mat def pvalue[`count_out',3] = ttail(e(df_r),abs(_b[beneficiaire]/_se[beneficiaire]))*2
				
				
		* Full specification 
		
			eststo full: regres ICfS`outcome' beneficiaire programs maleXbeneficiaire maleXprograms repondant_sex `ctrl_Cb'  if full == 1, vce (cluster imada)
			
			
				local c1_4_`count_out'  : di%12.3f _b[beneficiaire]
				local se1_4_`count_out' : di%12.3f _se[beneficiaire]
				
				local c2_4_`count_out'  : di%12.3f _b[programs]
				local se2_4_`count_out' : di%12.3f _se[programs]
				
				local n_4_`count_out' = e(N)
				local r2_4_`count_out' : di%12.3f e(r2)
				
				mat def pvalue[`count_out',4] = ttail(e(df_r),abs(_b[beneficiaire]/_se[beneficiaire]))*2
				
				mat def pvalue[`count_out',5] = ttail(e(df_r),abs(_b[programs]/_se[programs]))*2
			
		/*
		* Spillover and intensity
			
			eststo spill2: regres ICbS`outcome' beneficiaire NbHabitants  `ctrl_Cb' if spillovers == 1, vce (cluster imada)
			
				mat def `outcome'_reg[1,4] = _b[beneficiaire]
				mat def `outcome'_reg[2,4] = _se[beneficiaire]
				mat def `outcome'_reg[5,4] = _b[NbHabitants]
				mat def `outcome'_reg[6,4] = _se[NbHabitants]
				
				local N4 = e(N)
				local R4 = round(e(r2),0.001)
		
		*/	
	esttab between within spill1 full , se keep (beneficiaire programs maleXbeneficiaire maleXprograms repondant_sex) ///
								           order(beneficiaire programs maleXbeneficiaire maleXprograms repondant_sex)
										 
	
	restore
}

	* Store P-value vector name in global 
	global pvalue "pvalue"
	
	* Compute p-value
	FDR_CWLP_1
	FDR_CWLP_2
	FDR_CWLP_3
	FDR_CWLP_4
	FDR_CWLP_5

	
	* Store significance level based on p-value adjustment 
	pause on
	
	local count_outcomes = 1
	
	forvalue i = 1/11{
	
		local qval1 = Qval1[`i',1]
		
		* Between specification
		
		if `qval1' < 0.1{
			local s_1_`i' "*"
		}
		if `qval1' < 0.05{
			local s_1_`i' "**"
		}
		if `qval1' < 0.01{
			local s_1_`i' "***"
		}
		
		di in red "`s_1_`i''"
		
		* Within Specification 
		
		local qval2 = Qval2[`i',1]
		
		if `qval2' < 0.1{
			local s_2_`i' "*"
		}
		if `qval2' < 0.05{
			local s_2_`i' "**"
		}
		if `qval2' < 0.01{
			local s_2_`i' "***"
		}
		
		di in red "`s_2_`i''"
		
		* Spillovers Specification 
		
		local qval3 = Qval3[`i',1]
		
		if `qval3' < 0.1{
			local s_3_`i' "*"
		}
		if `qval3' < 0.05{
			local s_3_`i' "**"
		}
		if `qval3' < 0.01{
			local s_3_`i' "***"
		}
		
		di in red "`s_3_`i''"
		
		* Full Specification (first coeff)
		
		local qval4 = Qval4[`i',1]
		
		if `qval4' < 0.1{
			local s1_4_`i' "*"
		}
		if `qval4' < 0.05{
			local s1_4_`i' "**"
		}
		if `qval4' < 0.01{
			local s1_4_`i' "***"
		}
		
		di in red "`s1_4_`i''"
		
		* Full Specification (second coeff)
		
		local qval5 = Qval5[`i',1]
		
		if `qval5' < 0.1{
			local s2_4_`i' "*"
		}
		if `qval5' < 0.05{
			local s2_4_`i' "**"
		}
		if `qval5' < 0.01{
			local s2_4_`i' "***"
		}
		
		di in red "`s1_4_`i''"
	}

	
	* Export table 
	
	forvalue i = 1/11{
	
	file open Table_`i' using "Tables/Regression/Table_`i'.tex", text write replace
	
	file write Table_`i'  _n ///
	"\begin{tabular}{l*{4}{c}}\hline&\multicolumn{1}{c}{Between}&\multicolumn{1}{c}{Within}&\multicolumn{1}{c}{Spillovers}&\multicolumn{1}{c}{Full}\\ \hline" 	_n ///
	" Community					& 	`c_1_`i''`s_1_`i'' 	& 					 	& `c_3_`i''`s_3_`i'' & 	`c1_4_`i''`s1_4_`i''				\\ " 	_n ///
	" 							&	 (`se_1_`i'')		&   					&	(`se_3_`i'')	 &	(`se1_4_`i'')						\\ " 	_n ///
	" Community X Gender		& 	`c_1_`i''`s_1_`i'' 	& 					 	& `c_3_`i''`s_3_`i'' & 	`c1_4_`i''`s1_4_`i''				\\ " 	_n ///
	" 							&	 (`se_1_`i'')		&   					&	(`se_3_`i'')	 &	(`se1_4_`i'')						\\ " 	_n ///
	" Beneficiary 				& 					 	& `c_2_`i''`s_2_`i'' 	&    				 & 	`c2_4_`i''`s2_4_`i''				\\ " 	_n ///
	" 							&	  					& (`se_2_`i'')  		&					 &	(`se2_4_`i'')						\\ " 	_n ///
	" Beneficiary X Gender 		& 					 	& `c_2_`i''`s_2_`i'' 	&    				 & 	`c2_4_`i''`s2_4_`i''				\\ " 	_n ///
	" 							&	  					& (`se_2_`i'')  		&					 &	(`se2_4_`i'')						\\ " 	_n ///
	" Gender 					& 	`g_1_`i''			& `c_2_`i''`s_2_`i'' 	&    				 & 	`c2_4_`i''`s2_4_`i''				\\ " 	_n ///
	" 							&	  					& (`se_2_`i'')  		&					 &	(`se2_4_`i'')						\\ " 	_n ///
	"\hline															   			   					   							   " 	_n ///
	" Obs			& 		`n_1_`i''		&	`n_2_`i''			&	`n_3_`i''		 &		`n_4_`i''						\\ " 	_n ///
	" R2			&		`r2_1_`i''		&	`r2_2_`i''			&	`r2_3_`i''		 &		`r2_4_`i''						\\ "	_n ///
	"\hline \end{tabular}														 					   							   "	

	file close Table_`i'

	}
	

}
