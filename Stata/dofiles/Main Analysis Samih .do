********************************************************************************
********************************************************************************
*			MAIN TABLE TUNISISA CWLP ANALYSIS 								
********************************************************************************
********************************************************************************

********************************************************************************
********************************************************************************
* 0) Define local with variables to test 
********************************************************************************
********************************************************************************
cd "$git_tunisia/outputs/Main/"
cap file close Table
pause on 

local Index_ALL 	lab_market_main /*lab_market_sec*/ eco_welfare assets   										///
					credit_access pos_coping_mechanisms neg_coping_mechanisms										///
					shocks social civic well_being woman_empowerment 					

	
	local ctrl_Aa 	hhsize missing_hhsize drepondant_mat missing_drepondant_mat 									///
					adult_num missing_adult_num 																	///
					q0_1_c missing_q0_1_c posevent_8 missing_posevent_8
				  
	local ctrl_Ba 
	
	local ctrl_Cb 	hhsize missing_hhsize drepondant_mat missing_drepondant_mat 									///
					adult_num missing_adult_num 																	///
					q0_1_c missing_q0_1_c posevent_8 missing_posevent_8
					

********************************************************************************
********************************************************************************
* 1) Main table with three different specification
********************************************************************************
********************************************************************************	


use "$stata/enquete_All3", clear 

				
local count_out = 0 
mat def pvalue = J(11,3,.)

foreach outcome in `Index_ALL' {

		if "`outcome'" == "woman_violence" | "`outcome'" == "woman_bargain"{
			keep if repondant_sex == 0
		}
		
		local count_out = `count_out' + 1
				
		
		local l_`count_out' : variable label IAaS`outcome'
		
		* Between 
			
			eststo between: regress IAaS`outcome' beneficiaire `ctrl_Aa' if between == 1, vce (cluster imada)
				
				local c_1_`count_out' : di%12.3f _b[beneficiaire]
				local se_1_`count_out' : di%12.3f _se[beneficiaire]
				local n_1_`count_out' = e(N)
				local r2_1_`count_out' = e(R2)
				
				mat def pvalue[`count_out',1] = ttail(e(df_r),abs(_b[beneficiaire]/_se[beneficiaire]))*2	

		* Within 
		
			eststo within: regres IBaS`outcome' programs `ctrl_Ba' if within == 1, robust
			
				local c_2_`count_out' : di%12.3f  _b[programs]
				local se_2_`count_out' : di%12.3f _se[programs]
				local n_2_`count_out'  = e(N)
				local r2_2_`count_out' = e(R2)
				
				mat def pvalue[`count_out',2] = ttail(e(df_r),abs(_b[programs]/_se[programs]))*2	
				
		* Spillovers classic 
		
			eststo spill1: regres ICbS`outcome' beneficiaire `ctrl_Cb'  if spillovers == 1, vce (cluster imada)
			
				local c_3_`count_out' : di%12.3f _b[beneficiaire]
				local se_3_`count_out' : di%12.3f _se[beneficiaire]
				local n_3_`count_out' = e(N)
				local r2_3_`count_out' = e(R2)
				
				mat def pvalue[`count_out',3] = ttail(e(df_r),abs(_b[beneficiaire]/_se[beneficiaire]))*2
				
}
		
	* Store P-value vector name in global 
	global pvalue "pvalue"
	
	* Compute p-value
	
	FDR_CWLP_1
	FDR_CWLP_2
	FDR_CWLP_3

	
	* Store significance level based on p-value adjustment
	
	local count_outcomes = 1
	
	forvalue i = 1/11{
		
		local s_1_`i' ""
		local s_2_`i' ""
		local s_3_`i' ""
		
		* Between specification
		
		local qval1 = Qval1[`i',1]
		
		local pval_1_`i' : di%12.3f `qval1'												// Store q-value value
		
		if `pval_1_`i'' < 0.1{
			local s_1_`i' "*"
		}
		if `pval_1_`i'' < 0.05{
			local s_1_`i' "**"
		}
		if `pval_1_`i'' < 0.01{
			local s_1_`i' "***"
		}
		
		* Within Specification 
		
		local qval2 = Qval2[`i',1]
		
		local pval_2_`i' : di%12.3f `qval2'												// Store q-value value
		
		if `pval_2_`i'' < 0.1{
			local s_1_`i' "*"
		}
		if `pval_2_`i'' < 0.05{
			local s_1_`i' "**"
		}
		if `pval_2_`i'' < 0.01{
			local s_1_`i' "***"
		}
		
		* Spillovers Specification 
		
		local qval3 = Qval3[`i',1]
		
		local pval_3_`i' : di%12.3f `qval3'												// Store q-value value
		
		if `pval_3_`i'' < 0.1{
			local s_3_`i' "*"
		}
		if `pval_3_`i'' < 0.05{
			local s_3_`i' "**"
		}
		if `pval_3_`i'' < 0.01{
			local s_3_`i' "***"
		}
	
		
	}
		
file open Table using "Table_Index.tex", text write replace
	
file write Table  _n ///
"\begin{tabular}{l*{9}{c}}\hline&\multicolumn{3}{c}{Between}&\multicolumn{3}{c}{Within}&\multicolumn{3}{c}{Spillovers} \\ \cmidrule(r){2-4}\cmidrule(l){5-7}\cmidrule(l){8-10} & {T-C} & {P-value} & {N} & {T-C} & {P-value} & {N}  & {T-C} & {P-value} & {N}  \\ \midrule"  _n ///
" `l_1'			& 	`c_1_1'`s_1_1' 		& `pval_1_1' & `n_1_1'		& 	`c_2_1'`s_2_1' 		& `pval_2_1' & `n_2_1'		& `c_3_1'`s_3_1' & `pval_3_1' & `n_3_1' 		\\ " 	_n ///
" 				&	 (`se_1_1') & &									&   	(`se_2_1') & &								&	(`se_3_1')	& &	\\ " 	_n ///
" `l_2'			& 	`c_1_2'`s_1_2' 		& `pval_1_2' & `n_1_2' 		& 	`c_2_2'`s_2_2' & `pval_2_2' & `n_2_2'			& `c_3_2'`s_3_2' & `pval_3_2' & `n_3_2' 		\\ " 	_n ///
" 				&	 (`se_1_2') & &									&   	(`se_2_2') & &								&	(`se_3_2') & &	\\ " 	_n ///
" `l_3'			& 	`c_1_3'`s_1_3' 		& `pval_1_3' & `n_1_3' 		& 	`c_2_3'`s_2_3' & `pval_2_3' & `n_2_3'			& `c_3_3'`s_3_3' & `pval_3_3' & `n_3_3' 		\\ " 	_n ///
" 				&	 (`se_1_3') & &									&   	(`se_2_3') & &								& (`se_3_3') 			   		\\ " 	_n ///
" `l_4'			& 	`c_1_4'`s_1_4' 		& `pval_1_4' & `n_1_4'		& 	`c_2_4'`s_2_4' & `pval_2_4' & `n_2_4'			& `c_3_4'`s_3_4' & `pval_3_4' & `n_3_4' 		\\ " 	_n ///
" 				&	 (`se_1_4') & &									&   	(`se_2_4') & &								&	(`se_3_4') & &	 \\ " 	_n ///
" `l_5'			& 	`c_1_5'`s_1_5' 		& `pval_1_5' & `n_1_5' 		& 	`c_2_5'`s_2_5' & `pval_2_5' & `n_2_5'			& `c_3_5'`s_3_5' & `pval_3_5' & `n_3_5' 		\\ " 	_n ///
" 				&	 (`se_1_5') & &									&   	(`se_2_5') & &								&	(`se_3_5') & &	\\ " 	_n ///
" `l_6'			& 	`c_1_6'`s_1_6' 		& `pval_1_6' & `n_1_6' 		& 	`c_2_6'`s_2_6' & `pval_2_6' & `n_2_6'			& `c_3_6'`s_3_6' & `pval_3_6' & `n_3_6' 		\\ " 	_n ///
" 				&	 (`se_1_6') & &									&   	(`se_2_6') & &								&	(`se_3_6') & &	\\ " 	_n ///
" `l_7'			& 	`c_1_7'`s_1_7' 		& `pval_1_7' & `n_1_7' 		& 	`c_2_7'`s_2_7' & `pval_2_7' & `n_2_7'			& `c_3_7'`s_3_7' & `pval_3_7' & `n_3_7' 		\\ " 	_n ///
" 				&	 (`se_1_7') & &									&   	(`se_2_7') & &								&	(`se_3_7') & &	 \\ " 	_n ///
" `l_8'			& 	`c_1_8'`s_1_8' 		& `pval_1_8' & `n_1_8' 		& 	`c_2_8'`s_2_8' & `pval_2_8' & `n_2_8'			& `c_3_8'`s_3_8' & `pval_3_8' & `n_3_8' 		\\ " 	_n ///
" 				&	 (`se_1_8') & &									&   	(`se_2_8') & &								&	(`se_3_8') & &	 \\ " 	_n ///
" `l_9'			& 	`c_1_9'`s_1_9' 		& `pval_1_9' & `n_1_9' 		& 	`c_2_9'`s_2_9' & `pval_2_9' & `n_2_9'			& `c_3_9'`s_3_9' & `pval_3_9' & `n_3_9' 		\\ " 	_n ///
" 				&	 (`se_1_9') & &									&   	(`se_2_9') & &								&	(`se_3_9') & &	\\ " 	_n ///
" `l_10'		& 	`c_1_10'`s_1_10' 	& `pval_1_10' & `n_1_10' 	& 	`c_2_10'`s_2_10' & `pval_2_10' & `n_2_10'		& `c_3_10'`s_3_10' & `pval_3_10' & `n_3_10'  	  \\ " 	_n ///
" 				&	 (`se_1_10') & &								&   	(`se_2_10') & &								&	(`se_3_10') & &	\\ " 	_n ///
" `l_11'		& 	`c_1_11'`s_1_11' 	& `pval_1_11' & `n_1_11' 	& 	`c_2_11'`s_2_11' & `pval_2_11' & `n_2_11'		& `c_3_11'`s_3_11' & `pval_3_11' & `n_3_11' 	  \\ " 	_n ///
" 				&	 (`se_1_11') & &								&   	(`se_2_11') & &								&	(`se_3_11') & &	\\ " 	_n ///
"\hline \end{tabular}														 					   "	
file close Table		


********************************************************************************
********************************************************************************
* 2) Main table with full specification
********************************************************************************
********************************************************************************	

use "$stata/enquete_All3", clear 

				
local count_out 	= 1 
local count_out2 	= 2 
local count_out3	= 1

local  count_pvalue = 1

mat def pvalue = J(11,3,.)

foreach outcome in `Index_ALL' {

	preserve

		if "`outcome'" == "woman_violence" | "`outcome'" == "woman_bargain"{
			keep if repondant_sex == 0
		}
		
		local l_`count_pvalue' : variable label IAaS`outcome'
		
		* Full 
			
			regress ICfS`outcome' beneficiaire programs `ctrl_Cb' if full == 1, vce (cluster imada)
				
				local c_1_`count_out' 	: di%12.3f _b[beneficiaire]
				local se_1_`count_out' 	: di%12.3f _se[beneficiaire]
				
				local c_1_`count_out2' 	: di%12.3f _b[programs]
				local se_1_`count_out2' : di%12.3f _se[programs]
				
				local n_1_`count_out'  = e(N)
				local r2_1_`count_out' = e(R2)
				
				mat def pvalue[`count_pvalue',1] = ttail(e(df_r),abs(_b[beneficiaire]/_se[beneficiaire]))*2	
				
				mat def pvalue[`count_pvalue',2] = ttail(e(df_r),abs(_b[programs]/_se[programs]))*2	
				
				count 
				local full_sample = `r(N)'
				
				count if beneficiaire 	== 1
				local communities 		= `r(N)'
				
				count if programs 	== 1
				local workers 		= `r(N)'
				
				local share_communities = `communities'/`full_sample'
				local share_worker 		= `workers'/`full_sample'
				
			local t_1_`count_out3' 	=  _b[beneficiaire]*`share_communities' +  _b[programs]*`share_worker'
			local t_1_`count_out3'	: di%12.3f `t_1_`count_out3'' 
			
			local set_1_`count_out3' = _se[beneficiaire]*`share_communities' + _se[programs]*`share_worker'
			local set_1_`count_out3'	: di%12.3f `set_1_`count_out3'' 
			
			test _b[beneficiaire]*`share_communities' +  _b[programs]*`share_worker' = 0 
			mat def pvalue[`count_pvalue',3] = `r(p)'
			
			*mat def pvalue[`count_pvalue',3] = ttail(e(df_r),abs(`t_1_`count_out3''/`set_1_`count_out3''))*2	
				
		
		local count_out 	= `count_out' 	 + 2
		local count_out2 	= `count_out2' 	 + 2
		local count_out3	= `count_out3'	 + 1
		
		local count_pvalue  = `count_pvalue' + 1
		
	restore	
}
		
	* Store P-value vector name in global 
	global pvalue "pvalue"
	
	* Compute p-value
	
	FDR_CWLP_1
	FDR_CWLP_2
	FDR_CWLP_3
	
	* Store significance level based on p-value adjustment
	
	local count_outcomes = 1
	
	local star_count 	= 1
	local star_count2 	= 2
	local star_count3 	= 1
		
	forvalue i = 1/11{
		
		local ss_1_`star_count' 	""
		local ss_1_`star_count2' 	""
		local st_1_`star_count3'	""
		
		* First coeff
		
			local qval1 = Qval1[`i',1]
			
			local pval_1_`star_count' : di%12.3f `qval1'						// Store q-value value
			
			if `pval_1_`star_count'' < 0.1{
				local ss_1_`star_count' "*"
			}
			if `pval_1_`star_count'' < 0.05{
				local ss_1_`star_count' "**"
			}
			if `pval_1_`star_count'' < 0.01{
				local ss_1_`star_count' "***"
			}
			
		* Second coeff
		
			local qval2 = Qval2[`i',1]
			
			local pval_1_`star_count2' : di%12.3f `qval2'						// Store q-value value
			
			if `pval_1_`star_count2'' < 0.1{
				local ss_1_`star_count2' "*"
			}
			if `pval_1_`star_count2'' < 0.05{
				local ss_1_`star_count2' "**"
			}
			if `pval_1_`star_count2'' < 0.01{
				local ss_1_`star_count2' "***"
			}
		
		di in red "`s_1_`star_count''"
		di in red "`s_1_`star_count2''"
		
		* Full coeff
		
		local qval3 = Qval3[`i',1]
		
		local t_pval_1_`star_count3' : di%12.3f `qval3'							// Store q-value value
		
		if `t_pval_1_`star_count3'' < 0.1{
			local st_1_`star_count3' "*"
		}
		if `t_pval_1_`star_count3'' < 0.05{
			local st_1_`star_count3' "**"
		}
		if `t_pval_1_`star_count3'' < 0.01{
			local st_1_`star_count3' "***"
		}

	local star_count 	= `star_count'  + 2
	local star_count2 	= `star_count2' + 2
	local star_count3 	= `star_count3' + 1

	}

			
file open Table using "Table_Index_Full.tex", text write replace
	
file write Table  _n ///
"\begin{tabular}{l*{4}{c}}\hline&\multicolumn{4}{c}{Full specification} \\ \cmidrule(r){2-5} & {} & {T-C} & {P-value} & {N}  \\ \midrule"  _n ///
" `l_1'			&	PWP	& 	`c_1_1'`ss_1_1' 		& `pval_1_1' 	& `n_1_1'				\\  " 	_n ///
" 				&	 			&	(`se_1_1') 				& &										\\ " 	_n ///
" 				& 	Workers 	&	`c_1_2'`ss_1_2' 		& `pval_1_2' 	& 		 				\\ " 	_n ///
" 				&	 			&	(`se_1_2') 				& &										\\ " 	_n ///
"\cmidrule{2-3}" _n ///
"				&	Total		& 	`t_1_1'`st_1_1'			&`pvalt_1_1'	& 						\\ "	_n ///
"\cmidrule{2-3}" _n ///
" `l_2'			&	PWP	& 	`c_1_3'`ss_1_3' 		& `pval_1_3' 	& `n_1_3' 				\\ " 	_n ///
" 				&	 			&	(`se_1_3') 				& &										\\ " 	_n ///
" 				& 	Workers 	& 	`c_1_4'`ss_1_4' 		& `pval_1_4' 	& 						\\ " 	_n ///
" 				&	 			&	(`se_1_4') 				& &										\\ " 	_n ///
"\cmidrule{2-3}" _n ///
"				&	Total		& 	`t_1_2'`st_1_2'			& `pvalt_1_2'	& 						\\ "	_n ///
"\cmidrule{2-3}" _n ///
" `l_3'			&	PWP	&	`c_1_5'`ss_1_5' 		& `pval_1_5' 	& `n_1_5' 				\\ " 	_n ///
" 				&	 			&	(`se_1_5') 				& &										\\ " 	_n ///
" 				& 	Workers 	& 	`c_1_6'`ss_1_6' 		& `pval_1_6' 	& 						\\ " 	_n ///
" 				&	 			&	(`se_1_6') 				& &										\\ " 	_n ///
"\cmidrule{2-3}" _n ///
"				&	Total		& 	`t_1_3'`st_1_3'			& `pvalt_1_3'	& 						\\ "	_n ///
"\cmidrule{2-3}" _n ///
" `l_4'			&	PWP	& 	`c_1_7'`ss_1_7' 		& `pval_1_7' 	& `n_1_7' 				\\ " 	_n ///
" 				&	 			&	(`se_1_7') 				& &										\\ " 	_n ///
" 				& 	Workers 	& 	`c_1_8'`ss_1_8' 		& `pval_1_8' 	& 						\\ " 	_n ///
" 				&	 			&	(`se_1_8') 				& &										\\ " 	_n ///
"\cmidrule{2-3}" _n ///
"				&	Total		& 	`t_1_4'`st_1_4'			& `pvalt_1_4'	& 						\\ "	_n ///
"\cmidrule{2-3}" _n ///
" `l_5'			&	PWP	& 	`c_1_9'`ss_1_9' 		& `pval_1_9' 	& `n_1_9' 				\\ " 	_n ///
" 				&	 			&	(`se_1_9') 				& &										\\ " 	_n ///
" 				& 	Workers 	& 	`c_1_10'`ss_1_10' 		& `pval_1_10' 	& 						\\ " 	_n ///
" 				&	 			&	(`se_1_10') 			& &										\\ " 	_n ///
"\cmidrule{2-3}" _n ///
"				&	Total		& 	`t_1_5'`st_1_5'			&`pvalt_1_5'	& 						\\ "	_n ///
"\cmidrule{2-3}" _n ///
" `l_6'			&	PWP	& 	`c_1_11'`ss_1_11' 		&`pval_1_11' 	& `n_1_11' 	 			\\ " 	_n ///
" 				&	 			&	(`se_1_11') 			& &										\\ " 	_n ///
" 				& 	Workers 	& 	`c_1_12'`ss_1_12' 		& `pval_1_12' 	&  	 					\\ " 	_n ///
" 				&	 			&	(`se_1_12') 			& &										\\ " 	_n ///
"\cmidrule{2-3}" _n ///
"				&	Total		& 	`t_1_6'`st_1_6'			&`pvalt_1_6'	& 						\\ "	_n ///
"\cmidrule{2-3}" _n ///
" `l_7'			&	PWP	& 	`c_1_13'`ss_1_13' 		& `pval_1_13' 	& `n_1_13' 	 			\\ " 	_n ///
" 				&	 			&	(`se_1_13') 			& &										\\ " 	_n ///
" 				& 	Workers 	& 	`c_1_14'`ss_1_14' 		& `pval_1_14' 	& 		 	 			\\ " 	_n ///
" 				&	 			&	(`se_1_14') 			& &										\\ " 	_n ///
"\cmidrule{2-3}" _n ///
"				&	Total		& 	`t_1_7'`st_1_7'			& `pvalt_1_7'	& 						\\ "	_n ///
"\cmidrule{2-3}" _n ///
" `l_8'			& 	PWP	&	`c_1_15'`ss_1_15' 		& `pval_1_15' 	& `n_1_15' 	 			\\ " 	_n ///
" 				&	 			&	(`se_1_15') 			& &										\\ " 	_n ///
" 				& 	Workers 	& 	`c_1_16'`ss_1_16' 		& `pval_1_16' 	& 		 	 			\\ " 	_n ///
" 				&	 			&	(`se_1_16') 			& &										\\ " 	_n ///
"\cmidrule{2-3}" _n ///
"				&	Total		& 	`t_1_8'`st_1_8'			&`pvalt_1_8'	& 						\\ "	_n ///
"\cmidrule{2-3}" _n ///
" `l_9'			&	PWP	& 	`c_1_17'`ss_1_17' 		& `pval_1_17' 	& `n_1_17' 	 			\\ " 	_n ///
" 				&	 			&	(`se_1_17') 			& &										\\ " 	_n ///
" 				& 	Workers 	& 	`c_1_18'`ss_1_18' 		& `pval_1_18' 	& 		 	 			\\ " 	_n ///
" 				&	 			&	(`se_1_18') 			& &										\\ " 	_n ///
"\cmidrule{2-3}" _n ///
"				&	Total		& 	`t_1_9'`st_1_9'			&`pvalt_1_9'	& 						\\ "	_n ///
"\cmidrule{2-3}" _n ///
" `l_10'		&	PWP	&	`c_1_19'`ss_1_19' 		&`pval_1_19' 	& `n_1_19' 	 			\\ " 	_n ///
" 				&	 			&	(`se_1_19') 			& &										\\ " 	_n ///
" 				& 	Workers 	& 	`c_1_20'`ss_1_20' 		& `pval_1_20' 	& 		 	 			\\ " 	_n ///
" 				&	 			&	(`se_1_20') 			& &										\\ " 	_n ///
"\cmidrule{2-3}" _n ///
"				&	Total		& 	`t_1_10'`st_1_10'		& `pvalt_1_10'	& 						\\ "	_n ///
"\cmidrule{2-3}" _n ///
" `l_11'		& 	PWP	&	`c_1_21'`ss_1_21' 		& `pval_1_21' 	& `n_1_21' 	 			\\ " 	_n ///
" 				&	 			&	(`se_1_21') 			& &										\\ " 	_n ///
" 				&  	Workers 	&	`c_1_22'`ss_1_22' 		& `pval_1_22' 	& 			 			\\ " 	_n ///
" 				&	 			&	(`se_1_22') 			& &										\\ " 	_n ///
"\cmidrule{2-3}" _n ///
"				&	Total		& 	`t_1_11'`st_1_11'		& `pvalt_1_11'	& 						\\ "	_n ///
"\cmidrule{2-3}" _n ///
"\hline \end{tabular}														   "	
file close Table
