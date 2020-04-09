********************************************************************************
********************************************************************************
*				DETAILLED REGRESSION TUNISIA CWLP 							   *
********************************************************************************
********************************************************************************
cd "$git_tunisia/outputs/"
pause on 
clear 

********************************************************************************
********************************************************************************
* 0) DEFINE LOCAL USED TO BUILD INDEX 
********************************************************************************
********************************************************************************

local lab_market_main 	 		emploi_main days_work_main_win hours_work_main_win inc_work_main_win									///
								profit_work_main_win business_q0_main business_q3_main_win business_q5_main_win

											
local eco_welfare 				c3_a_1_win c3_a_2_win c3_a_3_win c3_a_4_win c3_a_5_win c3_a_6_win c3_a_7_win 					///
								c3_a_8_win c3_a_9_win c3_a_10_win c3_a_11_win c4_win c5_win c6_win 								///
								c7_win c8_win c9_win c11_win c12_win c13_win c14_win c16_win c18_win 

local consumption_food 			c3_a_1_win c3_a_2_win c3_a_3_win c3_a_4_win c3_a_5_win c3_a_6_win c3_a_7_win 					///
								c3_a_8_win c3_a_9_win c3_a_10_win c3_a_11_win 


local consumption_other 		c4_win c5_win c6_win c7_win c8_win c9_win c11_win c12_win c13_win c14_win 					///
								c16_win c18_win 

							
local assets					q2_1_2_win q2_1_3_win q2_1_4_win q2_1_5_win q2_1_6_win q2_1_7_win q2_1_8_win 					///
								q2_1_9_win q2_1_10_win q2_1_11_win q2_1_12_win q2_1_13_win  							///
								q2_1_15_win q2_1_16_win q2_1_17_win q2_1_18_win q2_1_19_win 										///
								 q2_1_21_win q2_1_22_win 

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


local social				association_1 association_2 initiatives_9 association_9														///
							association_3 association_4 association_6 /*association_7 association_8*/  
							
							
local civic					initiatives_1 initiatives_2 initiatives_3 initiatives_4 initiatives_5 initiatives_6 						///
							initiatives_7 initiatives_8  initiatives_10 initiatives_11 													///
							initiatives_12 initiatives_13 initiatives_14 initiatives_15									

							

local well_being 			psy_anxiete psy_exploit psy_depress5 /*psy_accepte_dum1*/ psy_accepte_dum3 									///
							psy_menage_dum3 /*psy_a_menage_dum1*/ psy_a_menage_dum3	 													///
							psycho_depress4 psycho_depress3 psycho_depress2 psycho_depress1


local woman_violence		violence_1_2 violence_1_3 violence_1_4 violence_1_5 violence_1_6 											///
							violence_1_7 violence_1_8 violence_1_9 violence_1_10 violence_1_11 											///
							violence_1_16 violence_1_17 violence_1_18  	
							

local woman_bargain 		intrahh_1 intrahh_2 intrahh_7 intrahh_11 emploiw /*association_2*/


local woman_empowerment		intrahh_1 intrahh_2 intrahh_7 intrahh_11 emploiw 															///
							violence_1_2 violence_1_3 violence_1_4 violence_1_5 violence_1_6 											///
							violence_1_7 violence_1_8 violence_1_9 violence_1_10 violence_1_11 											///
							violence_1_16 violence_1_17 violence_1_18  	


local Index_ALL 			lab_market_main /*lab_market_sec*/ eco_welfare consumption_food consumption_other							///
							assets home_assets comms_assets productive_assets 															///
							credit_access pos_coping_mechanisms neg_coping_mechanisms													///
							shocks social civic well_being woman_bargain woman_violence woman_empowerment 			
							
* Control variables

local ctrl_Aa 		hhsize missing_hhsize drepondant_mat missing_drepondant_mat 									///
					negevent_4 missing_negevent_4									///	
					q0_1_c missing_q0_1_c q0_3_c missing_q0_3_c  q2_2_c missing_q2_2_c  q2_3_c 						///
					missing_q2_3_c	q2_4_c  missing_q2_4_c  posevent_8	missing_posevent_8
local ctrl_Ba 
	
local ctrl_Cb 		hhsize missing_hhsize drepondant_mat missing_drepondant_mat 									///
					negevent_4 missing_negevent_4									///	
					q0_1_c missing_q0_1_c q0_3_c missing_q0_3_c  q2_2_c missing_q2_2_c  q2_3_c 						///
					missing_q2_3_c	q2_4_c  missing_q2_4_c  posevent_8	missing_posevent_8
	
global bet_with_spill = 1

********************************************************************************
********************************************************************************
* 1) DETAILLED REGRESSION OF EACH INDIVIDUAL VARIABLE WITHIN OUTCOME GROUP (B vs W vs S)
********************************************************************************
********************************************************************************

if $bet_with_spill == 1{
* Use data 
use "$stata/enquete_All3", clear 

* Loop over every outcomes group 

	foreach index of local Index_ALL{
	
	local count_index 
	local count_out = 0 														// Use to name local with regression info stored
							
	local cov_num : word count ``index''											// Count number of element in local `index'

	
	mat def pvalue = J(`cov_num',3,.)											// Define matrix to store p-value in order to adjust for mht
	
	cap file close Table_`index'												
	
	file open Table_`index' using "Tables/Individual/Table_`index'.tex", text write replace
	
	file write  Table_`index'													_n ///
	"\begin{tabular}{l*{6}{c}}\hline&\multicolumn{2}{c}{Between}&\multicolumn{2}{c}{Within}&\multicolumn{2}{c}{Spillovers} \\ \cmidrule(r){2-3}\cmidrule(l){4-5}\cmidrule(l){6-7} & {T-C} & {N} & {T-C} & {N}  & {T-C}  & {N}  \\ \midrule"  
	
	
		* Loop over every individual variables within outcomes group 
		
		foreach individual_outcomes of local `index'{
		
		local count_out = `count_out' + 1
		
		local l_`count_out' : variable label `individual_outcomes'
		

		* Run regressions on individual outcomes 
			
			
			* Between 
			
			
			eststo between: regress `individual_outcomes'_b beneficiaire `ctrl_Aa' if between == 1, vce (cluster imada)
				
				local c_1_`count_out' 	: di%12.3f _b[beneficiaire]
				local se_1_`count_out' 	: di%12.3f _se[beneficiaire]
				local n_1_`count_out' 	= e(N)
				local r2_1_`count_out' 	: di%12.3f e(r2)
				
				mat def pvalue[`count_out',1] = ttail(e(df_r),abs(_b[beneficiaire]/_se[beneficiaire]))*2
			
			
			* Within 
			
			
			eststo within: regres `individual_outcomes'_w programs `ctrl_Ba' if within == 1, robust
			
				local c_2_`count_out' 	: di%12.3f  _b[programs]
				local se_2_`count_out' 	: di%12.3f _se[programs]
				local n_2_`count_out'  	= e(N)
				local r2_2_`count_out' 	: di%12.3f e(r2)
					
				mat def pvalue[`count_out',2] = ttail(e(df_r),abs(_b[programs]/_se[programs]))*2
		
		
			* Spillovers 
			
		
			eststo spill1: regres `individual_outcomes'_s beneficiaire `ctrl_Cb'  if spillovers == 1, vce (cluster imada)
			
				local c_3_`count_out' 	: di%12.3f _b[beneficiaire]
				local se_3_`count_out' 	: di%12.3f _se[beneficiaire]
				local n_3_`count_out' 	= e(N)
				local r2_3_`count_out' 	: di%12.3f e(r2)
					
				mat def pvalue[`count_out',3] = ttail(e(df_r),abs(_b[beneficiaire]/_se[beneficiaire]))*2
				
		}
		
		* Store P-value vector name in global 
		global pvalue "pvalue"
	
		* Adjust P-value
		
		FDR_CWLP_1																// Adjust p-value for between specification
		FDR_CWLP_2																// Adjust p-value for within specification
		FDR_CWLP_3																// Adjust p-value for spillovers specification
		
		
		* Compute stars 
		
		forvalue i = 1/`cov_num'{
			
			local s_1_`i' ""
			local s_2_`i' ""
			local s_3_`i' ""
			
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
		}
		


	* Export tables
	forvalue i = 1/`cov_num'{
	
		file write Table_`index'																													_n ///
		"`l_`i''	&	`c_1_`i''`s_1_`i''	&	`n_1_`i''	&	`c_2_`i''`s_2_`i''	&	`n_2_`i''	&	`c_3_`i''`s_3_`i''	&	`n_3_`i''	\\"		_n ///
		"			&	(`se_1_`i'')		&				&	(`se_2_`i'')		&				&	(`se_3_`i'')		&				\\"

	}

	file write Table_`index'															_n ///
	"\hline \end{tabular}"														
	
	file close Table_`index'
}
}

********************************************************************************
********************************************************************************
* 1) DETAILLED REGRESSION OF EACH INDIVIDUAL VARIABLE WITHIN OUTCOME GROUP FULL
********************************************************************************
********************************************************************************


* Use data 

use "$stata/enquete_All3", clear 

* Loop over every outcomes group 

	foreach index of local Index_ALL{
	
		local count_out = 0 														// Use to name local with regression info stored
								
		local cov_num : word count ``index''										// Count number of element in local `index'
		
		mat def pvalue = J(`cov_num',3,.)											// Define matrix to store p-value in order to adjust for mht
		
		cap file close Table_`index'_Full												
		
		file open Table_`index'_Full using "Tables/Individual/Table_`index'_Full.tex", text write replace
		
		file write  Table_`index'_Full																										_n ///
		"\begin{tabular}{l*{7}{c}}\hline&\multicolumn{1}{c}{PWP}&\multicolumn{1}{c}{P-value}&\multicolumn{1}{c}{Workers}&\multicolumn{1}{c}{P-value}&\multicolumn{1}{c}{Full}&\multicolumn{1}{c}{P-value}&\multicolumn{1}{c}{Obs} \\ \hline"	_n 
		
		
		* Loop over every individual variables within outcomes group 
		
		foreach individual_outcomes of local `index'{
			
			local count_out = `count_out' + 1
			
			local l_`count_out' : variable label `individual_outcomes'
			
			* Run regressions on individual outcomes 
			
			regres `individual_outcomes'_f beneficiaire programs `ctrl_Cb'  if full == 1, vce (cluster imada)
		
				local c1_`count_out'  : di%12.3f _b[beneficiaire]
				local se1_`count_out' : di%12.3f _se[beneficiaire]
					
				local c2_`count_out'  : di%12.3f _b[programs]
				local se2_`count_out' : di%12.3f _se[programs]
					
				local n_`count_out' = e(N)
				local r2_`count_out' : di%12.3f e(r2)
				
				mat def pvalue[`count_out',1] = ttail(e(df_r),abs(_b[beneficiaire]/_se[beneficiaire]))*2
					
				mat def pvalue[`count_out',2] = ttail(e(df_r),abs(_b[programs]/_se[programs]))*2
					
				count 
				local full_sample = `r(N)'
					
				count if beneficiaire 	== 1
				local communities 		= `r(N)'
					
				count if programs 	== 1
				local workers 		= `r(N)'
					
				local share_communities = `communities'/`full_sample'
				local share_worker 		= `workers'/`full_sample'
					
				local t1_`count_out' 	=  _b[beneficiaire]*`share_communities' +  _b[programs]*`share_worker'
				local t1_`count_out'	: di%12.3f `t1_`count_out'' 
				
				local set1_`count_out' = _se[beneficiaire]*`share_communities' + _se[programs]*`share_worker'
				local set1_`count_out'	: di%12.3f `set1_`count_out'' 
				
				test _b[beneficiaire]*`share_communities' +  _b[programs]*`share_worker' = 0 
				
				mat def pvalue[`count_out',3] = `r(p)'
				
		}
		
		* Store P-value vector name in global 
		global pvalue "pvalue"
	
		* Adjust P-value
		
		FDR_CWLP_1																// Adjust p-value for between specification
		FDR_CWLP_2																// Adjust p-value for within specification
		FDR_CWLP_3																// Adjust p-value for spillovers specification

		* Compute stars 
		
		
		forvalue i = 1/`cov_num'{
			
			local s_1_`i' ""
			local s_2_`i' ""
			local s_3_`i' ""
			
			local pval_1_`i' = Qval1[`i',1]
			
			local pval_1_`i' : di%12.3f `pval_1_`i''
			
			* Between specification
		
			if `pval_1_`i'' < 0.1{
				local s_1_`i' "*"
			}
			if `pval_1_`i'' < 0.05{
				local s_1_`i' "**"
			}
			if `pval_1_`i'' < 0.01{
				local s_1_`i' "***"
			}
			
			di in red "`pval_1_`i'' `s_1_`i''"
		
			* Within Specification 
		
			local pval_2_`i' = Qval2[`i',1]
			
			local pval_2_`i' : di%12.3f `pval_2_`i''
			
			if `pval_2_`i'' < 0.1{
				local s_2_`i' "*"
			}
			if `pval_2_`i'' < 0.05{
				local s_2_`i' "**"
			}
			if `pval_2_`i'' < 0.01{
				local s_2_`i' "***"
			}
			
			di in red "`s_2_`i''"
		
			* Full Specification 
		
			local pval_3_`i' = Qval3[`i',1]
			
			local pval_3_`i' : di%12.3f `pval_3_`i''
			
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
	

	* Export Table 

	forvalue i = 1/`cov_num'{

	file write Table_`index'_Full 											 																				_n ///
	" `l_`i''	& 	`c1_`i''`s_1_`i'' 	& `pval_1_`i'' 	&	`c2_`i''`s_2_`i'' 	& `pval_2_`i''	& 	`t1_`i''`s_3_`i''	&	`pval_3_`i'' &	`n_`i''	\\ " 	_n ///
	" 			&	(`se1_`i'') 		& 				&	(`se2_`i'')			&				&						&				 &			\\ " 	_n 
	}
	
	file write Table_`index'_Full 	_n ///
	"\hline \end{tabular}"
	
	file close Table_`index'_Full
	
}	
	
