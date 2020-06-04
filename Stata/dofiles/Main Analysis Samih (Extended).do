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

local Index_ALL 	lab_market_main /*lab_market_sec*/ eco_welfare consumption_food consumption_other				///
					assets home_assets comms_assets productive_assets 												///
					credit_access pos_coping_mechanisms neg_coping_mechanisms										///
					shocks social civic well_being woman_bargain woman_violence  									///
					isolation utopia information_sources initiatives_acting initiatives_meeting						///
					initiatives comm_groups						

	
	local ctrl_Aa 	hhsize missing_hhsize repondant_mat missing_repondant_mat 									///
					adult_num missing_adult_num 																	///
					q0_1_c missing_q0_1_c posevent_8 missing_posevent_8
				  
	local ctrl_Ba 
	
	local ctrl_Cb 	hhsize missing_hhsize repondant_mat missing_repondant_mat 									///
					adult_num missing_adult_num 																	///
					q0_1_c missing_q0_1_c posevent_8 missing_posevent_8
					

********************************************************************************
********************************************************************************
* 1) Main table with three different specification
********************************************************************************
********************************************************************************	

********************************************************************************
********************************************************************************
* 1) Main table with three different specification (without imada fixed effect)
********************************************************************************
********************************************************************************	
				
local count_out = 0 
mat def pvalue = J(25,4,.)


foreach outcome in `Index_ALL' {

use "$stata/enquete_All3", clear 

		if "`outcome'" == "woman_violence" | "`outcome'" == "woman_bargain"{
			keep if repondant_sex == 0
		}
		
		local count_out = `count_out' + 1
				
		
		local l_`outcome' : variable label B_f_`outcome'
		
		* Between 
			
			eststo between: regress B_f_`outcome' beneficiaire `ctrl_Aa' if between == 1, vce (cluster imada)
				
				local c_1_`outcome' : di%12.3f _b[beneficiaire]
				local se_1_`outcome' : di%12.3f _se[beneficiaire]
				local n_1_`outcome' = e(N)
				local r2_1_`outcome' = e(R2)
				local p_1_`outcome' : di%12.3f ttail(e(df_r),abs(_b[beneficiaire]/_se[beneficiaire]))*2
				
				mat def pvalue[`count_out',1] = ttail(e(df_r),abs(_b[beneficiaire]/_se[beneficiaire]))*2	

		* Within 
		
			eststo within: regres W_f_`outcome' programs `ctrl_Ba' if within == 1, robust
			
				local c_2_`outcome' : di%12.3f  _b[programs]
				local se_2_`outcome' : di%12.3f _se[programs]
				local n_2_`outcome'  = e(N)
				local r2_2_`outcome' = e(R2)
				local p_2_`outcome' : di%12.3f ttail(e(df_r),abs(_b[programs]/_se[programs]))*2
				
				mat def pvalue[`count_out',2] = ttail(e(df_r),abs(_b[programs]/_se[programs]))*2	
				
		* Spillovers indiviual level 
		
			eststo spill1: regres S_f_`outcome' beneficiaire `ctrl_Cb'  if spillovers == 1, vce (cluster imada)
			
				local c_3_`outcome' : di%12.3f _b[beneficiaire]
				local se_3_`outcome' : di%12.3f _se[beneficiaire]
				local n_3_`outcome' = e(N)
				local r2_3_`outcome' = e(R2)
				local p_3_`outcome' : di%12.3f ttail(e(df_r),abs(_b[beneficiaire]/_se[beneficiaire]))*2
				
				mat def pvalue[`count_out',3] = ttail(e(df_r),abs(_b[beneficiaire]/_se[beneficiaire]))*2
				
				
		* Spillovers imada level  
		
			eststo spill1: regres I_f_`outcome' beneficiaire `ctrl_Cb'  if infrastructure == 1, robust
			
				local c_4_`outcome' : di%12.3f _b[beneficiaire]
				local se_4_`outcome' : di%12.3f _se[beneficiaire]
				local n_4_`outcome' = e(N)
				local r2_4_`outcome' = e(R2)
				
				local p_4_`outcome' : di%12.3f ttail(e(df_r),abs(_b[beneficiaire]/_se[beneficiaire]))*2
				
				mat def pvalue[`count_out',4] = ttail(e(df_r),abs(_b[beneficiaire]/_se[beneficiaire]))*2
				
}
		
	* Store P-value vector name in global 
	global pvalue "pvalue"
	
	* Compute p-value
	
	FDR_CWLP_1
	FDR_CWLP_2
	FDR_CWLP_3
	FDR_CWLP_4


	* Store q-vaue for primary outcomes
	local count_outcomes = 1
	
	foreach outcome of local primary{
	
		local qval1 = Qval1[`count_outcomes',1]
		local p_1_`outcome' : di%12.3f `qval1'
		
		local qval2 = Qval2[`count_outcomes',1]
		local p_2_`outcome' : di%12.3f `qval2'
		
		local qval3 = Qval3[`count_outcomes',1]
		local p_3_`outcome' : di%12.3f `qval3'
		
		local qval4 = Qval4[`count_outcomes',1]
		local p_4_`outcome' : di%12.3f `qval4'
		
	local count_outcomes = `count_outcomes' + 1
	
	} 
	
	* Store significance level based on p-value (or adjusted p-value)
	
	foreach outcome of local Index_ALL{
		
		local s_1_`outcome' ""
		local s_2_`outcome' ""
		local s_3_`outcome' ""
		local s_4_`outcome' ""
		
		* Between specification
		
			if `p_1_`outcome'' < 0.1{
				local s_1_`outcome' "*"
			}
			if `p_1_`outcome'' < 0.05{
				local s_1_`outcome' "**"
			}
			if `p_1_`outcome'' < 0.01{
				local s_1_`outcome' "***"
			}
		
		* Within Specification 
		
			if `p_2_`outcome'' < 0.1{
				local s_2_`outcome' "*"
			}
			if `p_2_`outcome'' < 0.05{
				local s_2_`outcome' "**"
			}
			if `p_2_`outcome'' < 0.01{
				local s_2_`outcome' "***"
			}
		
		* Spillovers Specification (individual)
		
			if `p_3_`outcome'' < 0.1{
				local s_3_`outcome' "*"
			}
			if `p_3_`outcome'' < 0.05{
				local s_3_`outcome' "**"
			}
			if `p_3_`outcome'' < 0.01{
				local s_3_`outcome' "***"
			}
		
		* Spillovers Specification (community)
		
			if `p_4_`outcome'' < 0.1{
				local s_4_`outcome' "*"
			}
			if `p_4_`outcome'' < 0.05{
				local s_4_`outcome' "**"
			}
			if `p_4_`outcome'' < 0.01{
				local s_4_`outcome' "***"
			}
	
		
	}
		
file open Table using "Table_Index_Extended_nofe.tex", text write replace
	
file write Table  _n ///
"\begin{tabular}{l*{12}{c}}\hline&\multicolumn{3}{c}{Between}&\multicolumn{3}{c}{Within}&\multicolumn{3}{c}{Spillovers}&\multicolumn{3}{c}{Infrastructure} \\ \cmidrule(r){2-4}\cmidrule(l){5-7}\cmidrule(l){8-10}\cmidrule(l){9-13} & {T-C} & {P-value} & {N} & {T-C} & {P-value} & {N}  & {T-C} & {P-value} & {N} & {T-C} & {P-value} & {N} \\ \midrule"  _n

foreach outcome of local Index_ALL{
file write Table 	_n ///
" `l_`outcome'' & `c_1_`outcome''`s_1_`outcome'' & `p_1_`outcome'' & `n_1_`outcome''	& `c_2_`outcome''`s_2_`outcome'' & `p_2_`outcome'' & `n_2_`outcome''	& `c_3_`outcome''`s_3_`outcome'' & `p_3_`outcome'' & `n_3_`outcome'' & `c_4_`outcome''`s_4_`outcome'' & `p_4_`outcome'' & `n_4_`outcome'' \\ " 	_n
}

file write Table 	_n ///
"\hline \end{tabular}" _n		
											 					 	
file close Table		

********************************************************************************
* 2) Main table with three different specification (with imada fixed effect)
********************************************************************************
********************************************************************************	
				
local count_out = 0 
mat def pvalue = J(25,4,.)


foreach outcome in `Index_ALL' {

use "$stata/enquete_All3", clear 

		if "`outcome'" == "woman_violence" | "`outcome'" == "woman_bargain"{
			keep if repondant_sex == 0
		}
		
		local count_out = `count_out' + 1
				
		
		local l_`outcome' : variable label B_f_`outcome'
		
		* Between 
			
			eststo between: regress B_f_`outcome' beneficiaire `ctrl_Aa' i.imada if between == 1, vce (cluster imada)
				
				local c_1_`outcome' : di%12.3f _b[beneficiaire]
				local se_1_`outcome' : di%12.3f _se[beneficiaire]
				local n_1_`outcome' = e(N)
				local r2_1_`outcome' = e(R2)
				local p_1_`outcome' : di%12.3f ttail(e(df_r),abs(_b[beneficiaire]/_se[beneficiaire]))*2
				
				mat def pvalue[`count_out',1] = ttail(e(df_r),abs(_b[beneficiaire]/_se[beneficiaire]))*2	

		* Within 
		
			eststo within: regres W_f_`outcome' programs `ctrl_Ba' i.imada if within == 1, robust
			
				local c_2_`outcome' : di%12.3f  _b[programs]
				local se_2_`outcome' : di%12.3f _se[programs]
				local n_2_`outcome'  = e(N)
				local r2_2_`outcome' = e(R2)
				local p_2_`outcome' : di%12.3f ttail(e(df_r),abs(_b[programs]/_se[programs]))*2
				
				mat def pvalue[`count_out',2] = ttail(e(df_r),abs(_b[programs]/_se[programs]))*2	
				
		* Spillovers indiviual level 
		
			eststo spill1: regres S_f_`outcome' beneficiaire `ctrl_Cb' i.imada if spillovers == 1, vce (cluster imada)
			
				local c_3_`outcome' : di%12.3f _b[beneficiaire]
				local se_3_`outcome' : di%12.3f _se[beneficiaire]
				local n_3_`outcome' = e(N)
				local r2_3_`outcome' = e(R2)
				local p_3_`outcome' : di%12.3f ttail(e(df_r),abs(_b[beneficiaire]/_se[beneficiaire]))*2
				
				mat def pvalue[`count_out',3] = ttail(e(df_r),abs(_b[beneficiaire]/_se[beneficiaire]))*2
				
				
		* Spillovers imada level  
		
			eststo spill1: regres I_f_`outcome' beneficiaire `ctrl_Cb' i.imada if infrastructure == 1, robust
			
				local c_4_`outcome' : di%12.3f _b[beneficiaire]
				local se_4_`outcome' : di%12.3f _se[beneficiaire]
				local n_4_`outcome' = e(N)
				local r2_4_`outcome' = e(R2)
				
				local p_4_`outcome' : di%12.3f ttail(e(df_r),abs(_b[beneficiaire]/_se[beneficiaire]))*2
				
				mat def pvalue[`count_out',4] = ttail(e(df_r),abs(_b[beneficiaire]/_se[beneficiaire]))*2
				
}
		
	* Store P-value vector name in global 
	global pvalue "pvalue"
	
	* Compute p-value
	
	FDR_CWLP_1
	FDR_CWLP_2
	FDR_CWLP_3
	FDR_CWLP_4


	* Store q-vaue for primary outcomes
	local count_outcomes = 1
	
	foreach outcome of local primary{
	
		local qval1 = Qval1[`count_outcomes',1]
		local p_1_`outcome' : di%12.3f `qval1'
		
		local qval2 = Qval2[`count_outcomes',1]
		local p_2_`outcome' : di%12.3f `qval2'
		
		local qval3 = Qval3[`count_outcomes',1]
		local p_3_`outcome' : di%12.3f `qval3'
		
		local qval4 = Qval4[`count_outcomes',1]
		local p_4_`outcome' : di%12.3f `qval4'
		
	local count_outcomes = `count_outcomes' + 1
	
	} 
	
	* Store significance level based on p-value (or adjusted p-value)
	
	foreach outcome of local Index_ALL{
		
		local s_1_`outcome' ""
		local s_2_`outcome' ""
		local s_3_`outcome' ""
		local s_4_`outcome' ""
		
		* Between specification
		
			if `p_1_`outcome'' < 0.1{
				local s_1_`outcome' "*"
			}
			if `p_1_`outcome'' < 0.05{
				local s_1_`outcome' "**"
			}
			if `p_1_`outcome'' < 0.01{
				local s_1_`outcome' "***"
			}
		
		* Within Specification 
		
			if `p_2_`outcome'' < 0.1{
				local s_2_`outcome' "*"
			}
			if `p_2_`outcome'' < 0.05{
				local s_2_`outcome' "**"
			}
			if `p_2_`outcome'' < 0.01{
				local s_2_`outcome' "***"
			}
		
		* Spillovers Specification (individual)
		
			if `p_3_`outcome'' < 0.1{
				local s_3_`outcome' "*"
			}
			if `p_3_`outcome'' < 0.05{
				local s_3_`outcome' "**"
			}
			if `p_3_`outcome'' < 0.01{
				local s_3_`outcome' "***"
			}
		
		* Spillovers Specification (community)
		
			if `p_4_`outcome'' < 0.1{
				local s_4_`outcome' "*"
			}
			if `p_4_`outcome'' < 0.05{
				local s_4_`outcome' "**"
			}
			if `p_4_`outcome'' < 0.01{
				local s_4_`outcome' "***"
			}
	
		
	}
		
file open Table using "Table_Index_Extended_fe.tex", text write replace
	
file write Table  _n ///
"\begin{tabular}{l*{12}{c}}\hline&\multicolumn{3}{c}{Between}&\multicolumn{3}{c}{Within}&\multicolumn{3}{c}{Spillovers}&\multicolumn{3}{c}{Infrastructure} \\ \cmidrule(r){2-4}\cmidrule(l){5-7}\cmidrule(l){8-10}\cmidrule(l){9-13} & {T-C} & {P-value} & {N} & {T-C} & {P-value} & {N}  & {T-C} & {P-value} & {N} & {T-C} & {P-value} & {N} \\ \midrule"  _n

foreach outcome of local Index_ALL{
file write Table 	_n ///
" `l_`outcome'' & `c_1_`outcome''`s_1_`outcome'' & `p_1_`outcome'' & `n_1_`outcome''	& `c_2_`outcome''`s_2_`outcome'' & `p_2_`outcome'' & `n_2_`outcome''	& `c_3_`outcome''`s_3_`outcome'' & `p_3_`outcome'' & `n_3_`outcome'' & `c_4_`outcome''`s_4_`outcome'' & `p_4_`outcome'' & `n_4_`outcome'' \\ " 	_n
}

file write Table 	_n ///
"\hline \end{tabular}" _n		
											 					 	
file close Table	


********************************************************************************
********************************************************************************
* 3) Main table with full specification (without fixed effect)
********************************************************************************
********************************************************************************					

local  count_pvalue = 1

mat def pvalue = J(25,3,.)

foreach outcome in `Index_ALL' {

use "$stata/enquete_All3", clear 

		if "`outcome'" == "woman_violence" | "`outcome'" == "woman_bargain"{
			keep if repondant_sex == 0
		}
		
		local l_`count_pvalue' : variable label B_f_`outcome'
		
		* Full 
			
			regress F_f_`outcome' beneficiaire programs `ctrl_Cb' if full == 1, vce (cluster imada)
				
				local c_1_`outcome' 	: di%12.3f _b[beneficiaire]
				local se_1_`outcome' 	: di%12.3f _se[beneficiaire]
				
				local c_2_`outcome' 	: di%12.3f _b[programs]
				local se_2_`outcome' : di%12.3f _se[programs]
				
				local n_1_`outcome'  = e(N)
				local r2_1_`outcome' = e(R2)
				
				local p_1_`outcome' : di%12.3f ttail(e(df_r),abs(_b[beneficiaire]/_se[beneficiaire]))*2	
				local p_2_`outcome' : di%12.3f ttail(e(df_r),abs(_b[programs]/_se[programs]))*2	
				
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
				
			local c_3_`outcome' 	=  _b[beneficiaire]*`share_communities' +  _b[programs]*`share_worker'
			local c_3_`outcome'	: di%12.3f `c_3_`outcome'' 
			
			local se_3_`outcome' = _se[beneficiaire]*`share_communities' + _se[programs]*`share_worker'
			local se_3_`outcome'	: di%12.3f `set_1_`count_out3'' 
			
			test _b[beneficiaire]*`share_communities' +  _b[programs]*`share_worker' = 0 
			
			local p_3_`outcome' : di%12.3f `r(p)'
			
			mat def pvalue[`count_pvalue',3] = `r(p)'
			
		local count_pvalue  = `count_pvalue' + 1
		
}
		
	* Store P-value vector name in global 
	global pvalue "pvalue"
	
	* Compute p-value
	
	FDR_CWLP_1
	FDR_CWLP_2
	FDR_CWLP_3
	
	* Store adjusted p-value for primary outcomes 
	
	local count_outcomes = 1
	
	foreach outcome of local primary{
	
		local qval1 = Qval1[`count_outcomes',1]
		local p_1_`outcome' : di%12.3f `qvalcount_outcomes'
			
		local qval2 = Qval2[`count_outcomes',1]
		local p_2_`outcome' : di%12.3f `qvalcount_outcomes'
			
		local qval3 = Qval3[`count_outcomes',1]
		local p_3_`outcome' : di%12.3f `qvalcount_outcomes'
			
		local count_outcomes = `count_outcomes' + 1
		
	}
	
	* Store significance level based on p-value adjustment
	
		
	foreach outcome of local Index_ALL{

		* First coeff
			
			if `p_1_`outcome'' < 0.1{
				local ss_1_`outcome' "*"
			}
			if `p_1_`outcome'' < 0.05{
				local ss_1_`outcome' "**"
			}
			if `p_1_`outcome'' < 0.01{
				local ss_1_`outcome' "***"
			}
			
		* Second coeff
			
			if `p_2_`outcome'' < 0.1{
				local ss_2_`outcome' "*"
			}
			if `p_2_`outcome'' < 0.05{
				local ss_2_`outcome' "**"
			}
			if `p_2_`outcome'' < 0.01{
				local ss_2_`outcome' "***"
			}
		
		* Full coeff
		
			if `p_3_`outcome'' < 0.1{
				local ss_3_`outcome' "*"
			}
			if `p_3_`outcome'' < 0.05{
				local ss_3_`outcome' "**"
			}
			if `p_3_`outcome'' < 0.01{
				local ss_3_`outcome' "***"
			}

	}


			
file open Table using "Table_Index_Full_Extended_nofe.tex", text write replace
	
file write Table  _n ///
"\begin{tabular}{l*{4}{c}}\hline&\multicolumn{1}{c}{PWP}&\multicolumn{1}{c}{Workers}&\multicolumn{1}{c}{Full}&\multicolumn{1}{c}{N} \\ \hline"  _n 

 
foreach outcome of local Index_ALL{	
file write Table  _n ///
" `l_`outcome'' &	`c_1_`outcome''`ss_1_`outcome'' &  `c_2_`outcome''`ss_2_`outcome'' &	`c_3_`outcome''`ss_3_`outcome'' & `n_1_`outcome''			\\  " 	_n ///
" 		  &	   (`se_1_`outcome'') 			&	 (`se_2_`outcome'')			   & 							         &							\\ 	" 	_n 
	
}

file write Table  																 _n ///
"\hline \end{tabular}														   " _n	
file close Table

********************************************************************************
********************************************************************************
* 3) Main table with full specification (without fixed effect)
********************************************************************************
********************************************************************************	
local  count_pvalue = 1

mat def pvalue = J(25,3,.)

foreach outcome in `Index_ALL' {

use "$stata/enquete_All3", clear 

		if "`outcome'" == "woman_violence" | "`outcome'" == "woman_bargain"{
			keep if repondant_sex == 0
		}
		
		local l_`count_pvalue' : variable label B_f_`outcome'
		
		* Full 
			
			regress F_f_`outcome' beneficiaire programs `ctrl_Cb' i.imada if full == 1, vce (cluster imada)
				
				local c_1_`outcome' 	: di%12.3f _b[beneficiaire]
				local se_1_`outcome' 	: di%12.3f _se[beneficiaire]
				
				local c_2_`outcome' 	: di%12.3f _b[programs]
				local se_2_`outcome' : di%12.3f _se[programs]
				
				local n_1_`outcome'  = e(N)
				local r2_1_`outcome' = e(R2)
				
				local p_1_`outcome' : di%12.3f ttail(e(df_r),abs(_b[beneficiaire]/_se[beneficiaire]))*2	
				local p_2_`outcome' : di%12.3f ttail(e(df_r),abs(_b[programs]/_se[programs]))*2	
				
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
				
			local c_3_`outcome' 	=  _b[beneficiaire]*`share_communities' +  _b[programs]*`share_worker'
			local c_3_`outcome'	: di%12.3f `c_3_`outcome'' 
			
			local se_3_`outcome' = _se[beneficiaire]*`share_communities' + _se[programs]*`share_worker'
			local se_3_`outcome'	: di%12.3f `set_1_`count_out3'' 
			
			test _b[beneficiaire]*`share_communities' +  _b[programs]*`share_worker' = 0 
			
			local p_3_`outcome' : di%12.3f `r(p)'
			
			mat def pvalue[`count_pvalue',3] = `r(p)'
			
		local count_pvalue  = `count_pvalue' + 1
		
}
		
	* Store P-value vector name in global 
	global pvalue "pvalue"
	
	* Compute p-value
	
	FDR_CWLP_1
	FDR_CWLP_2
	FDR_CWLP_3
	
	* Store adjusted p-value for primary outcomes 
	
	local count_outcomes = 1
	
	foreach outcome of local primary{
	
		local qval1 = Qval1[`count_outcomes',1]
		local p_1_`outcome' : di%12.3f `qvalcount_outcomes'
			
		local qval2 = Qval2[`count_outcomes',1]
		local p_2_`outcome' : di%12.3f `qvalcount_outcomes'
			
		local qval3 = Qval3[`count_outcomes',1]
		local p_3_`outcome' : di%12.3f `qvalcount_outcomes'
			
		local count_outcomes = `count_outcomes' + 1
		
	}
		
		
	* Store significance level based on p-value adjustment
	
		
	foreach outcome of local Index_ALL{

		* First coeff
			
			if `p_1_`outcome'' < 0.1{
				local ss_1_`outcome' "*"
			}
			if `p_1_`outcome'' < 0.05{
				local ss_1_`outcome' "**"
			}
			if `p_1_`outcome'' < 0.01{
				local ss_1_`outcome' "***"
			}
			
		* Second coeff
			
			if `p_2_`outcome'' < 0.1{
				local ss_2_`outcome' "*"
			}
			if `p_2_`outcome'' < 0.05{
				local ss_2_`outcome' "**"
			}
			if `p_2_`outcome'' < 0.01{
				local ss_2_`outcome' "***"
			}
		
		* Full coeff
		
			if `p_3_`outcome'' < 0.1{
				local ss_3_`outcome' "*"
			}
			if `p_3_`outcome'' < 0.05{
				local ss_3_`outcome' "**"
			}
			if `p_3_`outcome'' < 0.01{
				local ss_3_`outcome' "***"
			}

	}


			
file open Table using "Table_Index_Full_Extended_fe.tex", text write replace
	
file write Table  _n ///
"\begin{tabular}{l*{4}{c}}\hline&\multicolumn{1}{c}{PWP}&\multicolumn{1}{c}{Workers}&\multicolumn{1}{c}{Full}&\multicolumn{1}{c}{N} \\ \hline"  _n 

 
foreach outcome of local Index_ALL{
	
	file write Table  _n ///
	" `l_`outcome'' &	`c_1_`outcome''`ss_1_`outcome'' &  `c_2_`outcome''`ss_2_`outcome'' &	`c_3_`outcome''`ss_3_`outcome'' & `n_1_`outcome''			\\  " 	_n ///
	" 		  &	   (`se_1_`outcome'') 			&	 (`se_2_`outcome'')			   & 							         &							\\ 	" 	_n 
	
}

file write Table  																 _n ///
"\hline \end{tabular}														   " _n	
file close Table
