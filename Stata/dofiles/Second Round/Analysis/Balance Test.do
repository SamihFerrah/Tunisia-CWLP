
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


local balance_indiv 	repondant_age repondant_mat repondant_educ				///
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
* 1) Balance test at individual level 
********************************************************************************
********************************************************************************						
	

u "$vera/clean/clean_CashXFollow_PII.dta", clear

keep if Intervention == "Cash Grants - Women"

keep Nom Imada PSU psu Age trt_cash

replace Nom = upper(Nom)
replace Nom = subinstr(Nom," ","",.)

encode Imada, gen(imada)

replace Imada = upper(Imada)
replace Imada = subinstr(Imada," ","",.)

preserve 

	u "$stata_base/enquete_All3", clear

	g Age = repondant_age
	
	generate str116 Nom = repondant_name
	
	replace Nom = upper(Nom)
	replace Nom = subinstr(Nom," ","",.)
	
	replace Imada = upper(Imada)
	replace Imada = subinstr(Imada," ","",.)

	format Nom %116s
	
	tempfile baseline 
	sa      `baseline'

restore 

/* We need to do two merge iteration:
	- 1) Using imada numeric value
	- 2) Using imada string value (for _merge 1)
*/

* Merge with info from baseline
merge m:1 Nom imada Age using `baseline'

* Replace next merge variable to missing for second merge wave
replace Imada = "" if _merge == 3

drop if _merge == 2

rename _merge original_merge

merge m:1 Nom Imada Age using `baseline', update

drop if _merge == 2


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
				
		reg `covariates' trt_cash missing_`covariates' i.strata, vce(cluster imada)
		
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
	
{

	file open Table using "Balance Test Cash/Table_Balance_Individual.tex", text write replace
		
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
	" 				&	 `se_1_9' & &							   		\\ " 	_n ///
	" `l_10'		& 	`c_1_10'`s_1_10' 	& `pval_1_10' & `n_1_10' 	\\ " 	_n ///
	" 				&	 `se_1_10' & &									\\" 	_n 
	file close Table	
}