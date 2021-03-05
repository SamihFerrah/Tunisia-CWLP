********************************************************************************
********************************************************************************
*						ATTRITION TEST CASH GRANTS TUNISIA IE
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


local covariates 		repondant_age repondant_mat repondant_educ				///
						hhsize adult_num jeunes_lireecrire emploi_2013_a		///
						formation origine_naissance origine_naissance_bis 	
						
local balance_coll		q0_1_c q0_2_c q0_3_c 											///
						negevent_1 negevent_2 negevent_3 negevent_4 					///
						negevent_5 negevent_6 negevent_7      							///
						negevent_8 negevent_9 posevent_1 posevent_2 posevent_3      	///
						posevent_4 posevent_5 posevent_6 posevent_7 posevent_8 prev_PWP ///
						pop_2004_admin pop_2014_admin pop_change_admin



********************************************************************************
********************************************************************************						
* 1) ATTRITION test at individual level 
********************************************************************************
********************************************************************************						
	
u "$vera/clean/clean_CashXFollow_PII.dta", clear

keep if Intervention == "Cash Grants - Women"

keep Nom Imada PSU psu Age trt_cash HHID

replace Nom = upper(Nom)
replace Nom = subinstr(Nom," ","",.)

encode Imada, gen(imada)

replace Imada = upper(Imada)
replace Imada = subinstr(Imada," ","",.)

* Merge with full assignment to flag attrited respondent

preserve 

	u "A:/Assignment/Full sample.dta", clear
	
	keep if Intervention == "Cash Grants - Women"
	
	g 		trt_cash = 0
	replace trt_cash = 1 if Status == "Treatment"
	
	keep Nom Imada HHID repondant_age repondant_sex Strata trt_cash
	
	g Age = repondant_age
	
	replace Nom = upper(Nom)
	replace Nom = subinstr(Nom," ","",.)

	encode Imada, gen(imada)

	replace Imada = upper(Imada)
	replace Imada = subinstr(Imada," ","",.)

	destring Strata, replace 
	
	cap drop _merge 
	
	tempfile baseline 
	sa      `baseline'

restore 

cap drop Strata _merge 

* Merge with info from baseline
merge m:1 HHID using `baseline', update

* Generate attrition indicator 

gen 	attrition = 0 
replace attrition = 1 if _merge ==2 

drop _merge



codebook `covariates'

	
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
		
	*******************************************
	* Column 1: Attrition test 
	*******************************************

	reg attrition trt_cash i.Strata, robust
	sdsd
	local c_1 	: di%12.3f _b[trt_cash]
	local se_1 	: di%12.3f _se[trt_cash]
	local n1 	= e(N)
	local r2_1 	= e(R2)
				
	* Compute p-value
	local pval_1 = ttail(e(df_r),abs(_b[trt_cash]/_se[trt_cash]))*2	
			
	* Format local 
	local pval_1 : di%12.3f `pval_1'
	local se_1 = trim("`se_1'")
	local se_1 		 "(`se_1')"
	local se_1 = trim("`se_1'")
			
	* Add stars
	if `pval_1' < 0.1{
		local s_1 "*"
	}
	if `pval_1' < 0.05{
		local s_1 "**"
	}
	if `pval_1' < 0.01{
		local s_1 "***"
	}
	
	*****************************************************
	* Column 2: Attrition test controlling for covariates
	*****************************************************

	reg attrition trt_cash `covariates' i.Strata, robust
	
	local c_2	: di%12.3f _b[trt_cash]
	local se_2 	: di%12.3f _se[trt_cash]
	local n2 	= e(N)
	local r2_2 	= e(R2)
				
	* Compute p-value
	local pval_2 = ttail(e(df_r),abs(_b[trt_cash]/_se[trt_cash]))*2	
			
	* Format local 
	local pval_2 : di%12.3f `pval_2'
	local se_2 = trim("`se_2'")
	local se_2 		 "(`se_2')"
	local se_2 = trim("`se_2'")
			
	* Add stars
	if `pval_2' < 0.1{
		local s_2 "*"
	}
	if `pval_2' < 0.05{
		local s_2 "**"
	}
	if `pval_2' < 0.01{
		local s_2 "***"
	}
	
	* Store covariates results and p value 
	
	local count_out = 0 
	
	foreach variables in `covariates' {
		
		local count_out = `count_out' + 1 
		
		local l_`count_out' : variable label `variables'
						
			local c_2_`count_out' 	: di%12.3f _b[`variables']
			local se_2_`count_out' 	: di%12.3f _se[`variables']
				
			* Compute p-value
			local pval_2_`count_out' = ttail(e(df_r),abs(_b[`variables']/_se[`variables']))*2	
			
			* Format local 
			local pval_2_`count_out' : di%12.3f `pval_2_`count_out''
			local se_2_`count_out' = trim("`se_2_`count_out''")
			local se_2_`count_out' 		 "(`se_2_`count_out'')"
			local se_2_`count_out' = trim("`se_2_`count_out''")
			
			* Add stars
			if `pval_2_`count_out'' < 0.1{
				local s_2_`count_out' "*"
			}
			if `pval_2_`count_out'' < 0.05{
				local s_2_`count_out' "**"
			}
			if `pval_2_`count_out'' < 0.01{
				local s_2_`count_out' "***"
			}
	}	
	*********************************************************************
	* Column 3: Attrition test controlling for covariates and interacted
	*********************************************************************
	* Generate interaction terms between covariates and treatement 
	
	foreach variables in `covariates'{
	
		g trtX`variables' = trt_cash*`variables'
		
	}
	
	reg attrition trt_cash `covariates' trtX* i.strata, robust
	
	local c_3	: di%12.3f _b[trt_cash]
	local se_3 	: di%12.3f _se[trt_cash]
	local n3 	= e(N)
	local r2_3 	= e(R2)
				
	* Compute p-value
	local pval_3 = ttail(e(df_r),abs(_b[trt_cash]/_se[trt_cash]))*2	
			
	* Format local 
	local pval_3 : di%12.3f `pval_3'
	local se_3 = trim("`se_3'")
	local se_3 		 "(`se_3')"
	local se_3 = trim("`se_3'")
			
	* Add stars
	if `pval_3' < 0.1{
		local s_3 "*"
	}
	if `pval_3' < 0.05{
		local s_3 "**"
	}
	if `pval_3' < 0.01{
		local s_3 "***"
	}
	
	* Store covariates results and p value 
	
	local count_out = 0 
	
	foreach variables in `covariates' {
		
		local count_out = `count_out' + 1 
		
		local l_`count_out' : variable label `variables'
						
			local c_3_`count_out' 	: di%12.3f _b[`variables']
			local se_3_`count_out' 	: di%12.3f _se[`variables']
				
			* Compute p-value
			local pval_3_`count_out' = ttail(e(df_r),abs(_b[`variables']/_se[`variables']))*2	
			
			* Format local 
			local pval_3_`count_out' : di%12.3f `pval_3_`count_out''
			local se_3_`count_out' = trim("`se_3_`count_out''")
			local se_3_`count_out' 		 "(`se_3_`count_out'')"
			local se_3_`count_out' = trim("`se_3_`count_out''")
			
			* Add stars
			if `pval_3_`count_out'' < 0.1{
				local s_3_`count_out' "*"
			}
			if `pval_3_`count_out'' < 0.05{
				local s_3_`count_out' "**"
			}
			if `pval_3_`count_out'' < 0.01{
				local s_3_`count_out' "***"
			}
	}
	
	* Store covariates interacted results and p value 
	
	local count_out = 0 
	
	foreach variables in `covariates' {
		
		local count_out = `count_out' + 1 
		
		local l_`count_out' : variable label `variables'
						
			local ci_3_`count_out' 	: di%12.3f _b[trtX`variables']
			local sei_3_`count_out' : di%12.3f _se[trtX`variables']
				
			* Compute p-value
			local pvali_3_`count_out' = ttail(e(df_r),abs(_b[trtX`variables']/_se[trtX`variables']))*2	
			
			* Format local 
			local pvali_3_`count_out' : di%12.3f `pvali_3_`count_out''
			local sei_3_`count_out' = trim("`sei_3_`count_out''")
			local sei_3_`count_out' 		 "(`sei_3_`count_out'')"
			local sei_3_`count_out' = trim("`sei_3_`count_out''")
			
			* Add stars
			if `pvali_3_`count_out'' < 0.1{
				local si_3_`count_out' "*"
			}
			if `pvali_3_`count_out'' < 0.05{
				local si_3_`count_out' "**"
			}
			if `pvali_3_`count_out'' < 0.01{
				local si_3_`count_out' "***"
			}
	}

	* Export TeX Tables of attrition test at individual level 
	
{

	file open Table using "Balance Test Cash/Table_Attrition_Individual.tex", text write replace
		
	file write Table  																					_n ///
	" Treatment						& 	`c_1'`s_1' & 	`c_2'`s_2'  		& 	`c_3'`s_3' 		\\ " 	_n ///
	" 								&	 `se_1'    &	 `se_2' 			&	 `se_3'			\\ " 	_n 
	
	forvalue i = 1/`count_out'{
	
		file write Table																					_n ///
		" `l_`i''					& 	 		   & `c_2_`i''`s_2_`i'' 	& `c_3_`i''`s_3_`i'' 	\\ " 	_n ///
		" 							&	 		   &  `se_2_`i''			&  `se_3_`i''			\\ " 	_n ///
		" `l_`i'' X Treatment		& 	 		   & `ci_2_`i''`si_2_`i'' 	& `ci_3_`i''`si_3_`i'' 	\\ " 	_n ///
		" 							&	 		   &  `sei_2_`i''			&  `sei_3_`i''			\\ " 	_n 
		
	}
	
	file write Table																						_n ///
	"Observations					&	`n1'		&	`n2'				&	`n3'				\\"		_n 
	
	file close Table	
	
}

* 	"F-test							&				& 	`ftest1'			&	`ftest2'			\\"		_n ///
