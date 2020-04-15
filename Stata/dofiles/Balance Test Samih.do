
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


local balance_indiv 	repondant_age repondant_sex repondant_mat repondant_educ		///
						hhsize adult_num jeunes_lireecrire emploi_2013_a				///
						formation origine_naissance origine_naissance_bis 	
						
local balance_coll		q0_1_c q0_2_c q0_3_c 											///
						negevent_1 negevent_2 negevent_3 negevent_4 					///
						negevent_5 negevent_6 negevent_7      							///
						negevent_8 negevent_9 posevent_1 posevent_2 posevent_3      	///
						posevent_4 posevent_5 posevent_6 posevent_7 posevent_8 prev_PWP



********************************************************************************
********************************************************************************						
* 1) Balance test at individual level 
********************************************************************************
********************************************************************************						
	

use "$stata/enquete_All3", clear 
desc `balance_coll'

	* Some re-labelling 
	
	/*
	* Drop label
	foreach covariates in `balance_indiv'{
		
		label var `covariates' drop
		
	}
	*/
	
	label var repondant_age			"Age"
	label var repondant_sex			"Male"
	label var repondant_mat			"Married"
	label var repondant_educ		"Education"
	label var hhsize				"HH size"
	label var h_18_65				"Male 18-65 years old"
	label var f_18_65				"Female 18-65 years old"
	label var jeunes_lireecrire		"Illiterate adult"
	label var emploi_2013_a			"Worked 3 month (2013)"
	label var formation				"Professional training"
	label var origine_naissance		"Born imada"
	label var origine_naissance_bis "Born gouvernorat"
	label var trauma_abus			"Victim violence (1987-2010)"
		

	* Balance test at the individual level 
	
	local count_out = 0 
	
	mat def pvalue = J(11,3,.)
	
	foreach covariates in `balance_indiv' {
		
		local count_out = `count_out' + 1 
		
		local l_`count_out' : variable label `covariates'
		
		* Between Specification 
		
		reg `covariates' beneficiaire 	if between == 1, vce(cluster imada)
		
			local c_1_`count_out' 	: di%12.3f _b[beneficiaire]
			local se_1_`count_out' 	: di%12.3f _se[beneficiaire]
			local n_1_`count_out' 	= e(N)
			local r2_1_`count_out' 	= e(R2)
				
			mat def pvalue[`count_out',1] = ttail(e(df_r),abs(_b[beneficiaire]/_se[beneficiaire]))*2	
				
		* Within Specification 
		
		reg `covariates' program 		if within == 1, robust
		
			local c_2_`count_out' 	: di%12.3f _b[program]
			local se_2_`count_out' 	: di%12.3f _se[program]
			local n_2_`count_out' 	= e(N)
			local r2_2_`count_out' 	= e(R2)
				
			mat def pvalue[`count_out',2] = ttail(e(df_r),abs(_b[program]/_se[program]))*2	
				
		* Spillovers Specification 
		
		reg `covariates' beneficiaire 	if spillover == 1	, vce(cluster imada)
		
			local c_3_`count_out' 	: di%12.3f _b[beneficiaire]
			local se_3_`count_out' 	: di%12.3f _se[beneficiaire]
			local n_3_`count_out' 	= e(N)
			local r2_3_`count_out' 	= e(R2)
				
			mat def pvalue[`count_out',3] = ttail(e(df_r),abs(_b[beneficiaire]/_se[beneficiaire]))*2	
		
	}
	
	* Store significance level based on p-value adjustment
	
	local count_outcomes = 1
	
	forvalue i = 1/11{
		
		* Between specification
		
		local pval1 = pvalue[`i',1]
		
		local pval_1_`i' : di%12.3f `pval1'												// Store q-value value
		
		local s_1_`i' ""
		local s_2_`i' ""
		local s_3_`i' ""
		
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
		
		local pval2 = pvalue[`i',1]
		
		local pval_2_`i' : di%12.3f `pval2'												// Store q-value value
		
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
		
		local pval3 = pvalue[`i',1]
		
		local pval_3_`i' : di%12.3f `pval3'												// Store q-value value
		
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
		
	
	* Export TeX Tables of balance test at individual level 
	
{

	file open Table using "Table_Balance_Individual.tex", text write replace
		
	file write Table  _n ///
	"\begin{tabular}{l*{9}{c}}\hline&\multicolumn{3}{c}{Between}&\multicolumn{3}{c}{Within}&\multicolumn{3}{c}{Spillovers} \\ \cmidrule(r){2-4}\cmidrule(l){5-7}\cmidrule(l){8-10} & {T-C} & {P-value} & {N} & {T-C} & {P-value} & {N}  & {T-C} & {P-value} & {N}  \\ \midrule"  _n ///
	" `l_1'			& 	`c_1_1'`s_1_1' 		& `pval_1_1' & `n_1_1'		& 	`c_2_1'`s_2_1' 		& `pval_2_1' & `n_2_1'		& `c_3_1'`s_3_1' & `pval_3_1' & `n_3_1' 				\\ " 	_n ///
	" 				&	 (`se_1_1') & &									&   	(`se_2_1') & &								&	(`se_3_1')	& &				\\ " 	_n ///
	" `l_2'			& 	`c_1_2'`s_1_2' 		& `pval_1_2' & `n_1_2' 		& 	`c_2_2'`s_2_2' & `pval_2_2' & `n_2_2'			& `c_3_2'`s_3_2' & `pval_3_2' & `n_3_2' 				\\ " 	_n ///
	" 				&	 (`se_1_2') & &									&   	(`se_2_2') & &								&	(`se_3_3') & &						\\ " 	_n ///
	" `l_3'			& 	`c_1_3'`s_1_3' 		& `pval_1_3' & `n_1_3' 		& 	`c_2_3'`s_2_3' & `pval_2_3' & `n_2_3'			& `c_3_3'`s_3_3' & `pval_3_3' & `n_3_3' 				\\ " 	_n ///
	" 				&	 (`se_1_3') & &									&   	(`se_2_3') & &								&	(`se_3_3') & &						\\ " 	_n ///
	" `l_4'			& 	`c_1_4'`s_1_4' 		& `pval_1_4' & `n_1_4'		& 	`c_2_4'`s_2_4' & `pval_2_4' & `n_2_4'			& `c_3_4'`s_3_4' & `pval_3_4' & `n_3_4' 				\\ " 	_n ///
	" 				&	 (`se_1_4') & &									&   	(`se_2_4') & &								&	(`se_3_4') & &						\\ " 	_n ///
	" `l_5'			& 	`c_1_5'`s_1_5' 		& `pval_1_5' & `n_1_5' 		& 	`c_2_5'`s_2_5' & `pval_2_5' & `n_2_5'			& `c_3_5'`s_3_5' & `pval_3_5' & `n_3_5' 				\\ " 	_n ///
	" 				&	 (`se_1_5') & &									&   	(`se_2_5') & &								&	(`se_3_5') & &						\\ " 	_n ///
	" `l_6'			& 	`c_1_6'`s_1_6' 		& `pval_1_6' & `n_1_6' 		& 	`c_2_6'`s_2_6' & `pval_2_6' & `n_2_6'			& `c_3_6'`s_3_6' & `pval_3_6' & `n_3_6' 				\\ " 	_n ///
	" 				&	 (`se_1_6') & &									&   	(`se_2_6') & &								&	(`se_3_6') & &						\\ " 	_n ///
	" `l_7'			& 	`c_1_7'`s_1_7' 		& `pval_1_7' & `n_1_7' 		& 	`c_2_7'`s_2_7' & `pval_2_7' & `n_2_7'			& `c_3_7'`s_3_7' & `pval_3_7' & `n_3_7' 				\\ " 	_n ///
	" 				&	 (`se_1_7') & &									&   	(`se_2_7') & &								&	(`se_3_7') & &						\\ " 	_n ///
	" `l_8'			& 	`c_1_7'`s_1_8' 		& `pval_1_8' & `n_1_8' 		& 	`c_2_8'`s_2_8' & `pval_2_8' & `n_2_8'			& `c_3_8'`s_3_8' & `pval_3_8' & `n_3_8' 				\\ " 	_n ///
	" 				&	 (`se_1_8') & &									&   	(`se_2_8') & &								&	(`se_3_8') & &						\\ " 	_n ///
	" `l_9'			& 	`c_1_9'`s_1_9' 		& `pval_1_9' & `n_1_9' 		& 	`c_2_9'`s_2_9' & `pval_2_9' & `n_2_9'			& `c_3_9'`s_3_9' & `pval_3_9' & `n_3_9' 				\\ " 	_n ///
	" 				&	 (`se_1_9') & &									&   	(`se_2_9') & &								&	(`se_3_9') & &						\\ " 	_n ///
	" `l_10'			& 	`c_1_10'`s_1_10' 		& `pval_1_10' & `n_1_10' 		& 	`c_2_10'`s_2_10' & `pval_2_10' & `n_2_10'			& `c_3_10'`s_3_10' & `pval_3_10' & `n_3_10' 				\\ " 	_n ///
	" 				&	 (`se_1_10') & &									&   	(`se_2_10') & &								&	(`se_3_10') & &						\\ " 	_n ///
	" `l_11'			& 	`c_1_11'`s_1_11' 		& `pval_1_11' & `n_1_11'		& 	`c_2_11'`s_2_11' & `pval_2_11' & `n_2_11'			& `c_3_11'`s_3_11' & `pval_3_11' & `n_3_11' 				\\ " 	_n ///
	" 				&	 (`se_1_11') & &									&   	(`se_2_11') & &								&	(`se_3_11') & &						\\ " 	_n ///
	"\hline \end{tabular}														 					   "	
	file close Table	
	
/*
	" `l_12'			& 	`c_1_12'`s_1_12' 		& `pval_1_12' & `n_1_12' 		& 	`c_2_12'`s_2_12' & `pval_2_12' & `n_2_12'			& `c_3_12'`s_3_12' & `pval_3_12' & `n_3_12' 				\\ " 	_n ///
	" 				&	 (`se_1_12') & &									&   	(`se_2_12') & &								&	(`se_3_12') & &						\\ " 	_n ///
		" `l_13'			& 	`c_1_13'`s_1_13' 		& `pval_1_13' & `n_1_13' 		& 	`c_2_13'`s_2_13' & `pval_2_13' & `n_2_13'			& `c_3_13'`s_3_13' & `pval_3_13' & `n_3_13' 				\\ " 	_n ///
	" 				&	 (`se_1_13') & &									&   	(`se_2_13') & &								&	(`se_3_13') & &						\\ " 	_n ///
	" `l_13'			& 	`c_1_6'`s_1_13' 		& `pval_1_13' & `n_1_13' 		& 	`c_2_13'`s_2_13' & `pval_2_13' & `n_2_13'			& `c_3_6'`s_3_6' & `pval_3_13' & `n_3_13' 				\\ " 	_n ///
	" 				&	 (`se_1_13') & &									&   	(`se_2_13') & &								&	(`se_3_13') & &						\\ " 	_n ///
*/
}

********************************************************************************
********************************************************************************						
* 2) Balance test at community level 
********************************************************************************
********************************************************************************						
	
	* Some re-labelling 
	/*
	* Drop label
	foreach covariates in `balance_coll'{
		
		label  var `covariates' drop
		
	}
	*/
	
	label var q0_1_c "River or lake"
	label var q0_2_c "Forest"
	label var q0_3_c "Mountain"
	label var q2_1_c "Main activity: Agriculture "
	label var q2_2_c "Main activity: Fishing"
	label var q2_3_c "Main activity: Farming"
	label var q2_4_c "Main activity: Industry"
	label var q2_5_c "Main activity: Trade"
	label var q2_6_c "Main activity: Other services"
	label var negevent_1 "Drought"	
	label var negevent_2 "Flood"
	label var negevent_3 "Fast increase in commodity prices"
	label var negevent_4 "Large loss of work"	
	label var negevent_5 "Crop parasites"
	label var negevent_6 "Livestock illness"
	label var negevent_7 "Human epidemic" 
	label var negevent_8 "Electricity cut off"
	label var negevent_9 "Other bad events"
	label var posevent_1 "Development project"
	label var posevent_2 "Electrification of the IMADA"
	label var posevent_3 "New school" 
	label var posevent_4 "New road"
	label var posevent_5 "New health centre"
	label var posevent_6 "New employment opportunities"
	label var posevent_7 "Improved transport services"
	label var posevent_8 "Other good events"
	
	* Balance test at the individual level 
	
	local count_out = 0 
	
	mat def pvalue = J(21,1,.)
	
	foreach covariates in `balance_coll'{
	
		local count_out = `count_out' + 1 
		
		local l_`count_out' : variable label `covariates'
		
		* Between Specification 
		
		reg `covariates' beneficiaire missing_`covariates' 	if between == 1, vce(cluster imada)
		
			local c_1_`count_out' 	: di%12.3f _b[beneficiaire]
			local se_1_`count_out' 	: di%12.3f _se[beneficiaire]
			local n_1_`count_out' 	= e(N)
			local r2_1_`count_out' 	= e(R2)
				
			mat def pvalue[`count_out',1] = ttail(e(df_r),abs(_b[beneficiaire]/_se[beneficiaire]))*2
	
	}
	
	* Store significance level based on p-value
	
	forvalue i = 1/21{
		
		* Between specification
		
		local pval1 = pvalue[`i',1]
		
		local pval_1_`i' : di%12.3f `pval1'												// Store q-value value
		
		local s_1_`i' ""

		if `pval_1_`i'' < 0.1{
			local s_1_`i' "*"
		}
		if `pval_1_`i'' < 0.05{
			local s_1_`i' "**"
		}
		if `pval_1_`i'' < 0.01{
			local s_1_`i' "***"
		}
	}

	* Export TeX Tables of balance test at individual level 
	
	file open Table using "Table_Balance_Community.tex", text write replace
		
	file write Table  _n ///
	"\begin{tabular}{l*{3}{c}}\hline&\multicolumn{1}{c}{T-C}&\multicolumn{1}{c}{P-value}&\multicolumn{1}{c}{N} \\ \hline"  _n ///
	" `l_1'			& 	`c_1_1'`s_1_1' 		& `pval_1_1' & `n_1_1'		\\ " 		_n ///	
	" 				&	 (`se_1_1') 		& 			 &				\\ "		_n ///								
	" `l_2'			& 	`c_1_2'`s_1_2' 		& `pval_1_2' & `n_1_2' 		\\ " 		_n ///			
	" 				&	 (`se_1_2') 		& 			 &				\\ "		_n ///								
	" `l_3'			& 	`c_1_3'`s_1_3' 		& `pval_1_3' & `n_1_3' 		\\ " 		_n ///			 		
	" 				&	 (`se_1_3') 		& 			 &				\\ "		_n ///								
	" `l_4'			& 	`c_1_4'`s_1_4' 		& `pval_1_4' & `n_1_4' 		\\ " 		_n ///					
	" 				&	 (`se_1_4') 		& 			 &				\\ "		_n ///								
	" `l_5'			& 	`c_1_5'`s_1_5' 		& `pval_1_5' & `n_1_5' 		\\ " 		_n ///			 		
	" 				&	 (`se_1_5') 		& 			 &				\\ "		_n ///								
	" `l_6'			& 	`c_1_6'`s_1_6' 		& `pval_1_6' & `n_1_6' 		\\ " 		_n ///			 		
	" 				&	 (`se_1_6') 		& 			 &				\\ "		_n ///								
	" `l_7'			& 	`c_1_7'`s_1_7' 		& `pval_1_7' & `n_1_7' 		\\ " 		_n ///			 		
	" 				&	 (`se_1_7') 		& 			 &				\\ "		_n ///								
	" `l_8'			& 	`c_1_7'`s_1_8' 		& `pval_1_8' & `n_1_8' 		\\ " 		_n ///			 		
	" 				&	 (`se_1_8') 		& 			 &				\\ "		_n ///								
	" `l_9'			& 	`c_1_9'`s_1_9' 		& `pval_1_9' & `n_1_9' 		\\ " 		_n ///			 		
	" 				&	 (`se_1_9') 		& 			 &				\\ "		_n ///
	" `l_10'		& 	`c_1_10'`s_1_10' 	& `pval_1_10' 	& `n_1_10' 		\\ " 		_n ///			 		
	" 				&	 (`se_1_10') 		& 			  	&				\\ "		_n ///
	" `l_11'		& 	`c_1_11'`s_1_11' 	& `pval_1_11' 	& `n_1_11' 		\\ " 		_n ///			 		
	" 				&	 (`se_1_11') 		& 			  	&				\\ "		_n ///	
	" `l_12'		& 	`c_1_12'`s_1_12' 	& `pval_1_12' 	& `n_1_12' 		\\ " 		_n ///			 		
	" 				&	 (`se_1_12') 		& 			  	&				\\ "		_n ///	
	" `l_13'		& 	`c_1_13'`s_1_13' 	& `pval_1_13' 	& `n_1_13' 		\\ " 		_n ///			 		
	" 				&	 (`se_1_13') 		& 			  	&				\\ "		_n ///	
	" `l_14'		& 	`c_1_14'`s_1_14' 	& `pval_1_14' 	& `n_1_14' 		\\ " 		_n ///			 		
	" 				&	 (`se_1_14') 		& 			  	&				\\ "		_n ///	
	" `l_15'		& 	`c_1_15'`s_1_15' 	& `pval_1_15' 	& `n_1_15' 		\\ " 		_n ///			 		
	" 				&	 (`se_1_15') 		& 			  	&				\\ "		_n ///	
	" `l_16'		& 	`c_1_16'`s_1_16' 	& `pval_1_16' 	& `n_1_16' 		\\ " 		_n ///			 		
	" 				&	 (`se_1_16') 		& 			  	&				\\ "		_n ///	
	" `l_17'		& 	`c_1_17'`s_1_17' 	& `pval_1_17' 	& `n_1_17' 		\\ " 		_n ///			 		
	" 				&	 (`se_1_17') 		& 			  	&				\\ "		_n ///	
	" `l_18'		& 	`c_1_18'`s_1_18' 	& `pval_1_18' 	& `n_1_18' 		\\ " 		_n ///			 		
	" 				&	 (`se_1_18') 		& 			  	&				\\ "		_n ///	
	" `l_19'		& 	`c_1_19'`s_1_19' 	& `pval_1_19' 	& `n_1_19' 		\\ " 		_n ///			 		
	" 				&	 (`se_1_19') 		& 			  	&				\\ "		_n ///	
	" `l_20'		& 	`c_1_20'`s_1_20' 	& `pval_1_20' 	& `n_1_20' 		\\ " 		_n ///			 		
	" 				&	 (`se_1_20') 		& 			  	&				\\ "		_n ///
	" `l_21'		& 	`c_1_21'`s_1_21' 	& `pval_1_21' 	& `n_1_21' 		\\ " 		_n ///			 		
	" 				&	 (`se_1_21') 		& 			  	&				\\ "		_n ///
	"\hline \end{tabular}												   "		_n 
	file close Table		

	/*
	
	" `l_21'		& 	`c_1_21'`s_1_21' 	& `pval_1_21' 	& `n_1_21' 		\\ " 		_n ///			 		
	" 				&	 (`se_1_21') 		& 			  	&				\\ "		_n ///
	" `l_22'		& 	`c_1_22'`s_1_22' 	& `pval_1_22' 	& `n_1_22' 		\\ " 		_n ///			 		
	" 				&	 (`se_1_22') 		& 			  	&				\\ "		_n ///
	" `l_23'		& 	`c_1_23'`s_1_23' 	& `pval_1_23' 	& `n_1_23' 		\\ " 		_n ///			 		
	" 				&	 (`se_1_23') 		& 			  	&				\\ "		_n ///
	" `l_24'		& 	`c_1_24'`s_1_24' 	& `pval_1_24' 	& `n_1_24' 		\\ " 		_n ///			 		
	" 				&	 (`se_1_24') 		& 			  	&				\\ "		_n ///
	" `l_25'		& 	`c_1_25'`s_1_25' 	& `pval_1_25' 	& `n_1_25' 		\\ " 		_n ///			 		
	" 				&	 (`se_1_25') 		& 			  	&				\\ "		_n ///
	" `l_26'		& 	`c_1_26'`s_1_26' 	& `pval_1_26' 	& `n_1_26' 		\\ " 		_n ///			 		
	" 				&	 (`se_1_26') 		& 			  	&				\\ "		_n ///
	
	*/
