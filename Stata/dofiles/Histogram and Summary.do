********************************************************************************
*				PREPARE HISTOGRAM AND SUMMARY STATISITCS CWLP				*
********************************************************************************



	
********************************************************************************
********************************************************************************
* 0. PREPARE LOCAL 					
********************************************************************************
********************************************************************************
set graph off
cap file close tex_histo
pause on 
clear 
eststo clear 
set scheme plotplainblind
cd "$git_tunisia/outputs/"
do  "$git_tunisia/dofiles/Ado/mmat2tex.do"

local Index_ALL 	lab_market_main /*lab_market_sec*/ eco_welfare consumption_food consumption_other				///
					assets home_assets comms_assets productive_assets 												///
					credit_access pos_coping_mechanisms neg_coping_mechanisms										///
					shocks social civic well_being woman_bargain woman_violence  									///
					isolation utopia information_sources initiatives_acting initiatives_meeting						///
					initiatives comm_groups												
 	
					
* Controls : ADJUSTED TO REFLECT THE ONES THAT ARE NOT BALANCED.

	local ctrl_Aa 	hhsize missing_hhsize drepondant_mat missing_drepondant_mat 									///
					negevent_4 missing_negevent_4									///	
					q0_1_c missing_q0_1_c q0_3_c missing_q0_3_c  q2_2_c missing_q2_2_c  q2_3_c 						///
					missing_q2_3_c	q2_4_c  missing_q2_4_c  posevent_8	missing_posevent_8
				  
	local ctrl_Ba 
	
	local ctrl_Cb 	hhsize missing_hhsize drepondant_mat missing_drepondant_mat 									///
					negevent_4 missing_negevent_4									///	
					q0_1_c missing_q0_1_c q0_3_c missing_q0_3_c  q2_2_c missing_q2_2_c  q2_3_c 						///
					missing_q2_3_c	q2_4_c  missing_q2_4_c  posevent_8	missing_posevent_8
					
global summary_stat = 1
global main 		= 0
global imada_fe		= 0
global hete_woman	= 0
global hete_men		= 0

********************************************************************************
********************************************************************************

use "$stata/enquete_All3", clear 
																				
																				
	label variable hhsize 					"Number of household member"
	label variable drepondant_mat 			"Marital Status 1)Unmarried 0)Married" 
	label variable g1_3 					"Serious illness of head" 
	label variable g1_4 					"Serious illness of other household members" 
	label variable g1_5 					"Loss of employment"
	label variable g1_7 					"Failure to harvest" 
	label variable extra 					"Obs from second randomization"
	label variable repondant_sex			"Respondent gender"
	
	
********************************************************************************
********************************************************************************
* 1) Summary Statistics
********************************************************************************
********************************************************************************

if $summary_stat == 1{

* Create matrix to store results while looping over index
foreach index in `Index_ALL'{
	mat def `index' 			= J(4,5,.)
}

* Loop over every specification 
foreach specification in Between Within Spillovers Infrastructure{

	local counter_graph = 0 
	
	if "`specification'" == "Between"{
	local cond_index 	"B_f_"
	local cond_trt		"beneficiaire"
	local cond_sample 	"between"
	local row_summary = 1
	}
	
	if "`specification'" == "Within"{
	local cond_index	"W_f_"
	local cond_trt		"programs"
	local cond_sample 	"within"
	local row_summary = 2
	
	}
	
	if "`specification'" == "Spillovers"{
	local cond_index 	"S_f_"
	local cond_trt 		"beneficiaire"
	local cond_sample 	"spillovers"
	local row_summary = 3
	}
	
	if "`specification'" == "Infrastructure"{
	local cond_index 	"I_f_"
	local cond_trt 		"beneficiaire"
	local cond_sample 	"infrastructure"
	local row_summary = 4
	}
	
	* Loop over every index 
	foreach index in `Index_ALL'{
		
		local counter_graph = `counter_graph' + 1 
		
		local title : variable label `cond_index'`index'
		
		local caption_`counter_graph' "`title'"
		
		* Export Density Histogram (with kernel line)
		
		twoway 	(hist 		`cond_index'`index' if `cond_trt' == 0 & `cond_sample' == 1, bcolor(blue%20)) 	///
				(kdensity 	`cond_index'`index' if `cond_trt' == 0 & `cond_sample' == 1, lcolor(blue%80))	///
				(hist 		`cond_index'`index' if `cond_trt' == 1 & `cond_sample' == 1, bcolor(red%20) ) 	///
				(kdensity 	`cond_index'`index' if `cond_trt' == 1 & `cond_sample' == 1, lcolor(red%80) ), 	///
				 title("`specification'", size(2)) subtitle(" ") xtitle("") ytitle("Density") 								///
				 graphregion(color(white)) plotregion(color(white)) 										///
				 legend(order(1 3) label( 1 "Control") label( 3 "Treatment"))
				 
		
		graph save "Graph/`specification'/Figure_`counter_graph'.gph", replace
		
		* Export Summary Tables 
		
		sum `cond_index'`index'
		
			mat def `index'[`row_summary',1] = `r(N)'
			mat def `index'[`row_summary',2] = `r(mean)'
			mat def `index'[`row_summary',3] = `r(sd)'
			mat def `index'[`row_summary',4] = `r(min)'
			mat def `index'[`row_summary',5] = `r(max)'
	}
}


* Combine graph produce above 
forvalue i = 1/24{
	
	grc1leg "Graph/Between/Figure_`i'.gph" 		///
			"Graph/Within/Figure_`i'.gph" 		///
			"Graph/Spillovers/Figure_`i'.gph"	///
			"Graph/Infrastructure/Figure_`i'.gph", title("`caption_`i''")
			
	graph export "Graph/Combined/Figure_`i'.pdf", replace 

}

* Clean graph folder 

forvalue i = 1/24{

	rm "Graph/Between/Figure_`i'.gph"
	rm "Graph/Within/Figure_`i'.gph"
	rm "Graph/Spillovers/Figure_`i'.gph"
	rm "Graph/Infrastructure/Figure_`i'.gph"
}


* Export table with summary statistics and regression results 
local counter_table =  1
foreach index in `Index_ALL'{

	mata `index' = st_matrix("`index'")
	
	mmat2tex `index' using "Tables/Summary/Table_`counter_table'.tex", replace ///
	preheader("\begin{tabular}{l*{5}{c}}\hline&\multicolumn{1}{c}{N}&\multicolumn{1}{c}{Mean}&\multicolumn{1}{c}{St. Dev}&\multicolumn{1}{c}{Min}&\multicolumn{1}{c}{Max}\\ \hline") ///
						bottom("\hline \end{tabular}") ///
						rownames(row1 row2 row3)   ///
						substitute(row1 "Between Village" row2 "Within Village" row3 "Spillovers" row4 "Infrastructure") ///
						fmt(%12.0g %12.3f %12.3f %12.2f %12.2f)
						
local counter_table = `counter_table' + 1
}
}


********************************************************************************
********************************************************************************
* 2) Regression results without imada fixed effect
********************************************************************************
********************************************************************************

if $main == 1 {

	* Create interaction between treatment and treatment intensity variable 
	
	g habXtrt = NbHabitants*beneficiaire
	
	g beneXprog = beneficiaire*programs 
	
	local counter_reg = 1
	
	mat def pvalue = J(18,6,.)
	
	local count_out = 0 

	foreach outcome in `Index_ALL' {

		if "`outcome'" == "woman_violence" | "`outcome'" == "woman_bargain"{
			keep if repondant_sex == 0
		}
		
		local count_out = `count_out' + 1
				
		local l_`count_out' : variable label IAaS`outcome'
		
		local caption_`count_out' = "`l_`count_out''"
		
		* Between 
			
			eststo between: regress IAaS`outcome' beneficiaire `ctrl_Aa' if between == 1, vce (cluster imada)
				
				local c_1_`count_out' : di%12.3f _b[beneficiaire]
				local se_1_`count_out' : di%12.3f _se[beneficiaire]
				local n_1_`count_out' = e(N)
				local r2_1_`count_out' : di%12.3f e(r2)
				
				mat def pvalue[`count_out',1] = ttail(e(df_r),abs(_b[beneficiaire]/_se[beneficiaire]))*2	

		* Within 
		
			eststo within: regres IBaS`outcome' programs `ctrl_Ba' if within == 1, robust
			
				local c_2_`count_out' : di%12.3f  _b[programs]
				local se_2_`count_out' : di%12.3f _se[programs]
				local n_2_`count_out'  = e(N)
				local r2_2_`count_out' : di%12.3f e(r2)
				
				mat def pvalue[`count_out',2] = ttail(e(df_r),abs(_b[programs]/_se[programs]))*2	
				
		* Spillovers classic 
		
			eststo spill1: regres ICbS`outcome' beneficiaire `ctrl_Cb'  if spillovers == 1, vce (cluster imada)
			
				local c_3_`count_out' : di%12.3f _b[beneficiaire]
				local se_3_`count_out' : di%12.3f _se[beneficiaire]
				local n_3_`count_out' = e(N)
				local r2_3_`count_out' : di%12.3f e(r2)
				
				mat def pvalue[`count_out',3] = ttail(e(df_r),abs(_b[beneficiaire]/_se[beneficiaire]))*2
				
				
		* Full specification 
		
			eststo full: regres ICfS`outcome' beneficiaire programs `ctrl_Cb'  if full == 1, vce (cluster imada)
			
			
				local c1_4_`count_out'  : di%12.3f _b[beneficiaire]
				local se1_4_`count_out' : di%12.3f _se[beneficiaire]
				
				local c2_4_`count_out'  : di%12.3f _b[programs]
				local se2_4_`count_out' : di%12.3f _se[programs]
				
				local n_4_`count_out' = e(N)
				local r2_4_`count_out' : di%12.3f e(r2)
				
				mat def pvalue[`count_out',4] = ttail(e(df_r),abs(_b[beneficiaire]/_se[beneficiaire]))*2
				
				mat def pvalue[`count_out',5] = ttail(e(df_r),abs(_b[programs]/_se[programs]))*2
				
				count 
				local full_sample = `r(N)'
				
				count if beneficiaire 	== 1
				local communities 		= `r(N)'
				
				count if programs 	== 1
				local workers 		= `r(N)'
				
				local share_communities = `communities'/`full_sample'
				local share_worker 		= `workers'/`full_sample'
				
				local t_1_`count_out' 	=  _b[beneficiaire]*`share_communities' +  _b[programs]*`share_worker'
				local t_1_`count_out'	: di%12.3f `t_1_`count_out'' 
			
				local set_1_`count_out' = _se[beneficiaire]*`share_communities' + _se[programs]*`share_worker'
				local set_1_`count_out'	: di%12.3f `set_1_`count_out'' 
			
				test _b[beneficiaire]*`share_communities' +  _b[programs]*`share_worker' = 0 
				mat def pvalue[`count_out',6] = `r(p)'
			
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
	esttab between within spill1 full , se keep (beneficiaire programs NbHabitants) ///
								           order(beneficiaire programs NbHabitants)
										   
}

	* Store P-value vector name in global 
	global pvalue "pvalue"
	
	* Compute p-value
	FDR_CWLP_1
	FDR_CWLP_2
	FDR_CWLP_3
	FDR_CWLP_4
	FDR_CWLP_5
	FDR_CWLP_6
	

	
	* Store significance level based on p-value adjustment 
	
	local count_outcomes = 1
	
	forvalue i = 1/18{
		
		local s_1_`i' 	""
		local s_2_`i' 	""
		local s_3_`i'	""
		local s1_4_`i' 	""
		local s2_4_`i' 	""
		local st_1_`i' 	""
			
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
		
		di in red "`s2_4_`i''"
		
		* Full coeff (total)
		
		local qval6 = Qval6[`i',1]
		
		local pvalt_1_`i' : di%12.3f `qval6'
		
		if `qval6' < 0.1{
			local st_1_`i' "*"
		}
		if `qval6' < 0.05{
			local st_1_`i' "**"
		}
		if `qval6' < 0.01{
			local st_1_`i' "***"
		}
		
	}


	* Export table 
	
	forvalue i = 1/18{
	
	file open Table_`i' using "Tables/Regression/Table_`i'.tex", text write replace
	
	file write Table_`i'  _n ///
	"\begin{tabular}{l*{4}{c}}\hline&\multicolumn{1}{c}{Between}&\multicolumn{1}{c}{Within}&\multicolumn{1}{c}{Spillovers}&\multicolumn{1}{c}{Full}\\ \hline" 	_n ///
	" PWP			& 	`c_1_`i''`s_1_`i'' 	& 					 	& `c_3_`i''`s_3_`i'' & 	`c1_4_`i''`s1_4_`i''				\\ " 	_n ///
	" 				&	 (`se_1_`i'')		&   					&	(`se_3_`i'')	 &	(`se1_4_`i'')						\\ " 	_n ///
	" Workers 		& 					 	& `c_2_`i''`s_2_`i'' 	&    			& 	`c2_4_`i''`s2_4_`i''				\\ " 	_n ///
	" 				&	  					& (`se_2_`i'')  		&					 &	(`se2_4_`i'')						\\ " 	_n ///
	"\hline															   			   					   							   " 	_n ///
	" Full			&						&						&					 & 	`t_1_`i''`st_1_`i''					\\ "	_n ///
	" P-value		&						&						&					 &	`pvalt_1_`i'' 						\\ "	_n ///
	" Obs			& 		`n_1_`i''		&	`n_2_`i''			&	`n_3_`i''		 &		`n_4_`i''						\\ " 	_n ///
	" R2			&		`r2_1_`i''		&	`r2_2_`i''			&	`r2_3_`i''		 &		`r2_4_`i''						\\ "	_n ///
	"\hline \end{tabular}														 					   							   "	

	file close Table_`i'

	}
	

}

********************************************************************************
********************************************************************************
* 3) Regression results with imada fixed effect
********************************************************************************
********************************************************************************

if $imada_fe == 1 {

	* Create interaction between treatment and treatment intensity variable 
	
	local counter_reg = 1
	
	mat def pvalue = J(18,6,.)
	
	local count_out = 0 

	foreach outcome in `Index_ALL' {
	
	preserve 
	
		if "`outcome'" == "woman_violence" | "`outcome'" == "woman_bargain" | "`outcome'" == "woman_empowerment" {
			keep if repondant_sex == 0
		}
		
		local count_out = `count_out' + 1
				
		local l_`count_out' : variable label IAaS`outcome'
		
		local caption_`count_out' = "`l_`count_out''"
		
		* Between 
			
			eststo between: regress IAaS`outcome' beneficiaire `ctrl_Aa' i.imada if between == 1, vce (cluster imada)
				
				local c_1_`count_out' : di%12.3f _b[beneficiaire]
				local se_1_`count_out' : di%12.3f _se[beneficiaire]
				local n_1_`count_out' = e(N)
				local r2_1_`count_out' : di%12.3f e(r2)
				
				mat def pvalue[`count_out',1] = ttail(e(df_r),abs(_b[beneficiaire]/_se[beneficiaire]))*2	

		* Within 
		
			eststo within: regres IBaS`outcome' programs `ctrl_Ba' i.imada if within == 1, robust
			
				local c_2_`count_out' : di%12.3f  _b[programs]
				local se_2_`count_out' : di%12.3f _se[programs]
				local n_2_`count_out'  = e(N)
				local r2_2_`count_out' : di%12.3f e(r2)
				
				mat def pvalue[`count_out',2] = ttail(e(df_r),abs(_b[programs]/_se[programs]))*2	
				
		* Spillovers classic 
		
			eststo spill1: regres ICbS`outcome' beneficiaire `ctrl_Cb' i.imada if spillovers == 1, vce (cluster imada)
			
				local c_3_`count_out' : di%12.3f _b[beneficiaire]
				local se_3_`count_out' : di%12.3f _se[beneficiaire]
				local n_3_`count_out' = e(N)
				local r2_3_`count_out' : di%12.3f e(r2)
				
				mat def pvalue[`count_out',3] = ttail(e(df_r),abs(_b[beneficiaire]/_se[beneficiaire]))*2
				
				
		* Full specification 
		
			eststo full: regres ICfS`outcome' beneficiaire programs `ctrl_Cb' i.imada  if full == 1, vce (cluster imada)
			
			
				local c1_4_`count_out'  : di%12.3f _b[beneficiaire]
				local se1_4_`count_out' : di%12.3f _se[beneficiaire]
				
				local c2_4_`count_out'  : di%12.3f _b[programs]
				local se2_4_`count_out' : di%12.3f _se[programs]
				
				local n_4_`count_out' = e(N)
				local r2_4_`count_out' : di%12.3f e(r2)
				
				mat def pvalue[`count_out',4] = ttail(e(df_r),abs(_b[beneficiaire]/_se[beneficiaire]))*2
				
				mat def pvalue[`count_out',5] = ttail(e(df_r),abs(_b[programs]/_se[programs]))*2
				
				count 
				local full_sample = `r(N)'
				
				count if beneficiaire 	== 1
				local communities 		= `r(N)'
				
				count if programs 	== 1
				local workers 		= `r(N)'
				
				local share_communities = `communities'/`full_sample'
				local share_worker 		= `workers'/`full_sample'
				
				local t_1_`count_out' 	=  _b[beneficiaire]*`share_communities' +  _b[programs]*`share_worker'
				local t_1_`count_out'	: di%12.3f `t_1_`count_out'' 
			
				local set_1_`count_out' = _se[beneficiaire]*`share_communities' + _se[programs]*`share_worker'
				local set_1_`count_out'	: di%12.3f `set_1_`count_out'' 
			
				test _b[beneficiaire]*`share_communities' +  _b[programs]*`share_worker' = 0 
				mat def pvalue[`count_out',6] = `r(p)'
				

	esttab between within spill1 full , se keep (beneficiaire programs NbHabitants) ///
								           order(beneficiaire programs NbHabitants)
	

	
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
	FDR_CWLP_6

	
	* Store significance level based on p-value adjustment 
	
	local count_outcomes = 1
	
	forvalue i = 1/18{
	
		local s_1_`i' 	""
		local s_2_`i' 	""
		local s_3_`i'	""
		local s1_4_`i' 	""
		local s2_4_`i' 	""
		local st_1_`i' 	""
		
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
		
		* Full coeff (total)
		
		local qval6 = Qval6[`i',1]
		
		local pvalt_1_`i' : di%12.3f `qval6'
		
		if `qval6' < 0.1{
			local st_1_`i' "*"
		}
		if `qval6' < 0.05{
			local st_1_`i' "**"
		}
		if `qval6' < 0.01{
			local st_1_`i' "***"
		}
	}

	
	* Export table 
	
	forvalue i = 1/18{
	
	file open Table_`i' using "Tables/Regression/Table_`i'_b.tex", text write replace
	
	file write Table_`i'  _n ///
	"\begin{tabular}{l*{4}{c}}\hline&\multicolumn{1}{c}{Between}&\multicolumn{1}{c}{Within}&\multicolumn{1}{c}{Spillovers}&\multicolumn{1}{c}{Full}\\ \hline" 	_n ///
	" PWP		& 	`c_1_`i''`s_1_`i'' 	& 					 	& `c_3_`i''`s_3_`i'' & 	`c1_4_`i''`s1_4_`i''				\\ " 	_n ///
	" 				&	 (`se_1_`i'')		&   					&	(`se_3_`i'')	 &	(`se1_4_`i'')						\\ " 	_n ///
	" Workers 	& 					 	& `c_2_`i''`s_2_`i'' 	&    				 & 	`c2_4_`i''`s2_4_`i''				\\ " 	_n ///
	" 				&	  					& (`se_2_`i'')  		&					 &	(`se2_4_`i'')						\\ " 	_n ///
	"\hline															   			   					   							   " 	_n ///
	" Full			&						&						&					 & 	`t_1_`i''`st_1_`i''					\\ "	_n ///
	" P-value		&						&						&					 &	`pvalt_1_`i'' 						\\ "	_n ///
	" Obs			& 		`n_1_`i''		&	`n_2_`i''			&	`n_3_`i''		 &		`n_4_`i''						\\ " 	_n ///
	" R2			&		`r2_1_`i''		&	`r2_2_`i''			&	`r2_3_`i''		 &		`r2_4_`i''						\\ "	_n ///
	"\hline \end{tabular}														 					   							   "	

	file close Table_`i'

	}

}


********************************************************************************
********************************************************************************
* 4) Regression results subsample of woman
********************************************************************************
********************************************************************************

if $hete_woman == 1{
use "$stata/enquete_All3", clear 

* Controls : ADJUSTED TO REFLECT THE ONES THAT ARE NOT BALANCED.

	local ctrl_Aa 	hhsize missing_hhsize drepondant_mat missing_drepondant_mat 									///
					negevent_4 missing_negevent_4									///	
					q0_1_c missing_q0_1_c q0_3_c missing_q0_3_c  q2_2_c missing_q2_2_c  q2_3_c 						///
					missing_q2_3_c	q2_4_c  missing_q2_4_c  posevent_8	missing_posevent_8
				  
	local ctrl_Ba 
	
	local ctrl_Cb 	hhsize missing_hhsize drepondant_mat missing_drepondant_mat 									///
					negevent_4 missing_negevent_4									///	
					q0_1_c missing_q0_1_c q0_3_c missing_q0_3_c  q2_2_c missing_q2_2_c  q2_3_c 						///
					missing_q2_3_c	q2_4_c  missing_q2_4_c  posevent_8	missing_posevent_8
					
					

local Index_ALL 			lab_market_main /*lab_market_sec*/ eco_welfare consumption_food consumption_other					///
							assets home_assets comms_assets productive_assets 												///
							credit_access pos_coping_mechanisms neg_coping_mechanisms										///
							shocks social civic well_being woman_bargain woman_violence woman_empowerment 					
							
keep if repondant_sex == 0

{

	* Create interaction between treatment and treatment intensity variable 
	
	g habXtrt = NbHabitants*beneficiaire
	
	g beneXprog = beneficiaire*programs 
	
	local counter_reg = 1
	
	mat def pvalue = J(18,6,.)
	
	local count_out = 0 

	local count_pval = 0
	
	foreach outcome in `Index_ALL' {

		local count_out  = `count_out'  + 1
		local count_pval = `count_pval' + 1
		
		local l_`count_out' : variable label IAaS`outcome'
		
		local caption_`count_out' = "`l_`count_out''"
		
		* Between 
			
			eststo between: regress IAaSw`outcome' beneficiaire `ctrl_Aa' if between == 1, vce (cluster imada)
				
				local c_1_`count_out' : di%12.3f _b[beneficiaire]
				local se_1_`count_out' : di%12.3f _se[beneficiaire]
				local n_1_`count_out' = e(N)
				local r2_1_`count_out' : di%12.3f e(r2)
				
				mat def pvalue[`count_pval',1] = ttail(e(df_r),abs(_b[beneficiaire]/_se[beneficiaire]))*2	

		* Within 
		
			eststo within: regres IBaSw`outcome' programs `ctrl_Ba' if within == 1, robust
			
				local c_2_`count_out' : di%12.3f  _b[programs]
				local se_2_`count_out' : di%12.3f _se[programs]
				local n_2_`count_out'  = e(N)
				local r2_2_`count_out' : di%12.3f e(r2)
				
				mat def pvalue[`count_pval',2] = ttail(e(df_r),abs(_b[programs]/_se[programs]))*2	
				
		* Spillovers classic 
		
			eststo spill1: regres ICbSw`outcome' beneficiaire `ctrl_Cb'  if spillovers == 1, vce (cluster imada)
			
				local c_3_`count_out' : di%12.3f _b[beneficiaire]
				local se_3_`count_out' : di%12.3f _se[beneficiaire]
				local n_3_`count_out' = e(N)
				local r2_3_`count_out' : di%12.3f e(r2)
				
				mat def pvalue[`count_pval',3] = ttail(e(df_r),abs(_b[beneficiaire]/_se[beneficiaire]))*2
				
				
		* Full specification 
		
			eststo full: regres ICfSw`outcome' beneficiaire programs `ctrl_Cb'  if full == 1, vce (cluster imada)
			
			
				local c1_4_`count_out'  : di%12.3f _b[beneficiaire]
				local se1_4_`count_out' : di%12.3f _se[beneficiaire]
				
				local c2_4_`count_out'  : di%12.3f _b[programs]
				local se2_4_`count_out' : di%12.3f _se[programs]
				
				local n_4_`count_out' = e(N)
				local r2_4_`count_out' : di%12.3f e(r2)
				
				mat def pvalue[`count_pval',4] = ttail(e(df_r),abs(_b[beneficiaire]/_se[beneficiaire]))*2
				
				mat def pvalue[`count_pval',5] = ttail(e(df_r),abs(_b[programs]/_se[programs]))*2
				
				count 
				local full_sample = `r(N)'
				
				count if beneficiaire 	== 1
				local communities 		= `r(N)'
				
				count if programs 	== 1
				local workers 		= `r(N)'
				
				local share_communities = `communities'/`full_sample'
				local share_worker 		= `workers'/`full_sample'
				
				local t_1_`count_out' 	=  _b[beneficiaire]*`share_communities' +  _b[programs]*`share_worker'
				local t_1_`count_out'	: di%12.3f `t_1_`count_out'' 
			
				local set_1_`count_out' = _se[beneficiaire]*`share_communities' + _se[programs]*`share_worker'
				local set_1_`count_out'	: di%12.3f `set_1_`count_out'' 
			
				test _b[beneficiaire]*`share_communities' +  _b[programs]*`share_worker' = 0 
				mat def pvalue[`count_out',6] = `r(p)'
				
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
	esttab between within spill1 full , se keep (beneficiaire programs NbHabitants) ///
								           order(beneficiaire programs NbHabitants)
										   
}

	* Store P-value vector name in global 
	global pvalue "pvalue"
	
	* Compute p-value
	FDR_CWLP_1
	FDR_CWLP_2
	FDR_CWLP_3
	FDR_CWLP_4
	FDR_CWLP_5
	FDR_CWLP_6

	
	* Store significance level based on p-value adjustment 
	
	local count_outcomes = 1
	
	forvalue i = 1/18{
		
		local s_1_`i' 	""
		local s_2_`i' 	""
		local s_3_`i'	""
		local s1_4_`i' 	""
		local s2_4_`i' 	""
		local st_1_`i' 	""
		
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
		
		* Full coeff (total)
		
		local qval6 = Qval6[`i',1]
		
		local pvalt_1_`i' : di%12.3f `qval6'
		
		if `qval6' < 0.1{
			local st_1_`i' "*"
		}
		if `qval6' < 0.05{
			local st_1_`i' "**"
		}
		if `qval6' < 0.01{
			local st_1_`i' "***"
		}
	}

	
	* Export table 
	
	forvalue i = 1/18{
	
	file open Table_`i' using "Tables/Regression/Table_`i'_w.tex", text write replace
	
	file write Table_`i'  _n ///
	"\begin{tabular}{l*{4}{c}}\hline&\multicolumn{1}{c}{Between}&\multicolumn{1}{c}{Within}&\multicolumn{1}{c}{Spillovers}&\multicolumn{1}{c}{Full}\\ \hline" 	_n ///
	" PWP		& 	`c_1_`i''`s_1_`i'' 	& 					 	& `c_3_`i''`s_3_`i'' & 	`c1_4_`i''`s1_4_`i''				\\ " 	_n ///
	" 				&	 (`se_1_`i'')		&   					&	(`se_3_`i'')	 &	(`se1_4_`i'')						\\ " 	_n ///
	" Workers 	& 					 	& `c_2_`i''`s_2_`i'' 	&    				 & 	`c2_4_`i''`s2_4_`i''				\\ " 	_n ///
	" 				&	  					& (`se_2_`i'')  		&					 &	(`se2_4_`i'')						\\ " 	_n ///
	"\hline															   			   					   							   " 	_n ///
	" Full			&						&						&					 & 	`t_1_`i''`st_1_`i''					\\ "	_n ///
	" P-value		&						&						&					 &	`pvalt_1_`i'' 						\\ "	_n ///
	" Obs			& 		`n_1_`i''		&	`n_2_`i''			&	`n_3_`i''		 &		`n_4_`i''						\\ " 	_n ///
	" R2			&		`r2_1_`i''		&	`r2_2_`i''			&	`r2_3_`i''		 &		`r2_4_`i''						\\ "	_n ///
	"\hline \end{tabular}														 					   							   "	

	file close Table_`i'

	}
	

}
}


********************************************************************************
********************************************************************************
* 5) Regression results subsample of male
********************************************************************************
********************************************************************************

if $hete_men == 1{
* Controls : ADJUSTED TO REFLECT THE ONES THAT ARE NOT BALANCED.

	local ctrl_Aa 	hhsize missing_hhsize drepondant_mat missing_drepondant_mat 									///
					negevent_4 missing_negevent_4									///	
					q0_1_c missing_q0_1_c q0_3_c missing_q0_3_c  q2_2_c missing_q2_2_c  q2_3_c 						///
					missing_q2_3_c	q2_4_c  missing_q2_4_c  posevent_8	missing_posevent_8
				  
	local ctrl_Ba 
	
	local ctrl_Cb 	hhsize missing_hhsize drepondant_mat missing_drepondant_mat 									///
					negevent_4 missing_negevent_4									///	
					q0_1_c missing_q0_1_c q0_3_c missing_q0_3_c  q2_2_c missing_q2_2_c  q2_3_c 						///
					missing_q2_3_c	q2_4_c  missing_q2_4_c  posevent_8	missing_posevent_8
					
use "$stata/enquete_All3", clear 


local Index_ALL 			lab_market_main /*lab_market_sec*/ eco_welfare consumption_food consumption_other					///
							assets home_assets comms_assets productive_assets 												///
							credit_access pos_coping_mechanisms neg_coping_mechanisms										///
							shocks social civic well_being /*woman_bargain woman_violence woman_empowerment*/					
							
keep if repondant_sex == 1

{

	* Create interaction between treatment and treatment intensity variable 
	
	g habXtrt = NbHabitants*beneficiaire
	
	g beneXprog = beneficiaire*programs 
	
	local counter_reg = 1
	
	mat def pvalue = J(18,6,.)
	
	local count_out = 0 

	foreach outcome in `Index_ALL' {

		local count_out = `count_out' + 1
				
		local l_`count_out' : variable label IAaS`outcome'
		
		local caption_`count_out' = "`l_`count_out''"
		
		* Between 
			
			eststo between: regress IAaSm`outcome' beneficiaire `ctrl_Aa' if between == 1, vce (cluster imada)
				
				local c_1_`count_out' : di%12.3f _b[beneficiaire]
				local se_1_`count_out' : di%12.3f _se[beneficiaire]
				local n_1_`count_out' = e(N)
				local r2_1_`count_out' : di%12.3f e(r2)
				
				mat def pvalue[`count_out',1] = ttail(e(df_r),abs(_b[beneficiaire]/_se[beneficiaire]))*2	

		* Within 
		
			eststo within: regres IBaSm`outcome' programs `ctrl_Ba' if within == 1, robust
			
				local c_2_`count_out' : di%12.3f  _b[programs]
				local se_2_`count_out' : di%12.3f _se[programs]
				local n_2_`count_out'  = e(N)
				local r2_2_`count_out' : di%12.3f e(r2)
				
				mat def pvalue[`count_out',2] = ttail(e(df_r),abs(_b[programs]/_se[programs]))*2	
				
		* Spillovers classic 
		
			eststo spill1: regres ICbSm`outcome' beneficiaire `ctrl_Cb'  if spillovers == 1, vce (cluster imada)
			
				local c_3_`count_out' : di%12.3f _b[beneficiaire]
				local se_3_`count_out' : di%12.3f _se[beneficiaire]
				local n_3_`count_out' = e(N)
				local r2_3_`count_out' : di%12.3f e(r2)
				
				mat def pvalue[`count_out',3] = ttail(e(df_r),abs(_b[beneficiaire]/_se[beneficiaire]))*2
				
				
		* Full specification 
		
			eststo full: regres ICfSm`outcome' beneficiaire programs `ctrl_Cb'  if full == 1, vce (cluster imada)
			
			
				local c1_4_`count_out'  : di%12.3f _b[beneficiaire]
				local se1_4_`count_out' : di%12.3f _se[beneficiaire]
				
				local c2_4_`count_out'  : di%12.3f _b[programs]
				local se2_4_`count_out' : di%12.3f _se[programs]
				
				local n_4_`count_out' = e(N)
				local r2_4_`count_out' : di%12.3f e(r2)
				
				mat def pvalue[`count_out',4] = ttail(e(df_r),abs(_b[beneficiaire]/_se[beneficiaire]))*2
				
				mat def pvalue[`count_out',5] = ttail(e(df_r),abs(_b[programs]/_se[programs]))*2
				
				count 
				local full_sample = `r(N)'
				
				count if beneficiaire 	== 1
				local communities 		= `r(N)'
				
				count if programs 	== 1
				local workers 		= `r(N)'
				
				local share_communities = `communities'/`full_sample'
				local share_worker 		= `workers'/`full_sample'
				
				local t_1_`count_out' 	=  _b[beneficiaire]*`share_communities' +  _b[programs]*`share_worker'
				local t_1_`count_out'	: di%12.3f `t_1_`count_out'' 
			
				local set_1_`count_out' = _se[beneficiaire]*`share_communities' + _se[programs]*`share_worker'
				local set_1_`count_out'	: di%12.3f `set_1_`count_out'' 
			
				test _b[beneficiaire]*`share_communities' +  _b[programs]*`share_worker' = 0 
				mat def pvalue[`count_out',6] = `r(p)'
			
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
	esttab between within spill1 full , se keep (beneficiaire programs NbHabitants) ///
								           order(beneficiaire programs NbHabitants)
										   
}

	* Store P-value vector name in global 
	global pvalue "pvalue"
	
	* Compute p-value
	FDR_CWLP_1
	FDR_CWLP_2
	FDR_CWLP_3
	FDR_CWLP_4
	FDR_CWLP_5
	FDR_CWLP_6

	
	* Store significance level based on p-value adjustment 
	
	local count_outcomes = 1
	
	forvalue i = 1/18{
		
		local s_1_`i' 	""
		local s_2_`i' 	""
		local s_3_`i'	""
		local s1_4_`i' 	""
		local s2_4_`i' 	""
		local st_1_`i' 	""
		
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
		
		* Full coeff (total)
		
		local qval6 = Qval6[`i',1]

		if `qval6' < 0.1{
			local st_1_`i' "*"
		}
		if `qval6' < 0.05{
			local st_1_`i' "**"
		}
		if `qval6' < 0.01{
			local st_1_`i' "***"
		}
	}

	
	* Export table 
	
	forvalue i = 1/18{
	
	file open Table_`i' using "Tables/Regression/Table_`i'_m.tex", text write replace
	
	file write Table_`i'  _n ///
	"\begin{tabular}{l*{4}{c}}\hline&\multicolumn{1}{c}{Between}&\multicolumn{1}{c}{Within}&\multicolumn{1}{c}{Spillovers}&\multicolumn{1}{c}{Full}\\ \hline" 	_n ///
	" PWP		& 	`c_1_`i''`s_1_`i'' 	& 					 	& `c_3_`i''`s_3_`i'' & 	`c1_4_`i''`s1_4_`i''				\\ " 	_n ///
	" 				&	 (`se_1_`i'')		&   					&	(`se_3_`i'')	 &	(`se1_4_`i'')						\\ " 	_n ///
	" Workers 	& 					 	& `c_2_`i''`s_2_`i'' 	&    				 & 	`c2_4_`i''`s2_4_`i''				\\ " 	_n ///
	" 				&	  					& (`se_2_`i'')  		&					 &	(`se2_4_`i'')						\\ " 	_n ///
	"\hline															   			   					   							   " 	_n ///
	" Full			&						&						&					 & 	`t_1_`i''`st_1_`i''					\\ "	_n ///
	" P-value		&						&						&					 &	`pvalt_1_`i'' 						\\ "	_n ///
	" Obs			& 		`n_1_`i''		&	`n_2_`i''			&	`n_3_`i''		 &		`n_4_`i''						\\ " 	_n ///
	" R2			&		`r2_1_`i''		&	`r2_2_`i''			&	`r2_3_`i''		 &		`r2_4_`i''						\\ "	_n ///
	"\hline \end{tabular}														 					   							   "	

	file close Table_`i'

	}
	

}
}



		





