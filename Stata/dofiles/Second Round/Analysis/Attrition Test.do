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


local covariates 		repondant_age_b repondant_educ_b									///
						hhsize_b adult_num_b jeunes_lireecrire_b emploi_2013_a_b			///
						formation_b origine_naissance_b origine_naissance_bis_b 			///
						association_dummy_b association_2_b  			///
						psy_menage_dum3_b psy_a_menage_dum3_b							///
						initiatives_1_b initiatives_2_b 								///
						epargne_pret_b epargne_b epargne_cb_win_b epargne_dette_b 	/// 
						q2_1_18_win_b q2_1_19_win_b q2_1_21_win_b q2_1_16_win_b 	/// 
						c3_a_1_win_b c3_a_2_win_b c3_a_3_win_b c3_a_4_win_b			///
						c3_a_5_win_b c3_a_6_win_b c3_a_7_win_b c3_a_8_win_b			///
						c3_a_9_win_b c3_a_10_win_b c3_a_11_win_b c4_win_b 			/// 
						days_work_main_win_b 						 		///
						inc_work_main_win_b profit_work_main_win_b 						///
						business_q0_main_b emploi_sec_b
						
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
	
u "$vera/clean/clean_analysis_CashXFollow.dta", clear

keep if Intervention == "Cash Grants - Women" 

destring Strata, replace

replace trt_cash_1 = trt_cash if trt_cash == 0 
replace trt_cash_0 = trt_cash if trt_cash == 0

replace trt_cash_1 = . if trt_cash_0 == 1
replace trt_cash_0 = . if trt_cash_1 == 1

*codebook `covariates'
	
	label var repondant_age_b			"Respondant age"
	label var repondant_educ_b			"Respondant education"
	label var hhsize_b					"HH size"
	label var h_18_65_b					"Male 18-65 years old"
	label var f_18_65_b					"Female 18-65 years old"
	label var jeunes_lireecrire_b		"Number of Illiterate adult in household"
	label var emploi_2013_a_b			"Respondent worked 3 month in 2013"
	label var formation_b				"Respondent attended a professional training"
	label var origine_naissance_b		"Respondent born in imada"
	label var origine_naissance_bis_b	"Respondent born in gouvernorat"
	label var trauma_abus_b				"Victim of violence (1987-2010)"
	label var emploi_sec_b 				"Respondent had an IGA last 4 weeks"
	label var business_q0_main_b		"Respondent own a business"
	label var profit_work_main_win_b	"Profit from main IGA last month"
	label var inc_work_main_win_b		"Income from main IGA last month"
	label var days_work_main_win_b		"Number of days work main IGA last month"
	label var c4_win_b					"Rent (in Dinars)"
	label var c3_a_11_win_b				"Tobacco, coffee and tea (in Dinars)"
	label var c3_a_10_win_b				"Seasoning (in Dinars)"
	label var c3_a_9_win_b				"Water, Soda (in Dinars)"
	label var c3_a_8_win_b				"Oil (in Dinars)"
	label var c3_a_7_win_b				"Fruits (in Dinars)"
	label var c3_a_6_win_b				"Vegetables (in Dinars)"
	label var c3_a_5_win_b				"Egss and Diary (in Dinars)"
	label var c3_a_4_win_b				"Meat (in Dinars)"
	label var c3_a_3_win_b				"Fish (in Dinars)"
	label var c3_a_2_win_b				"Pasta, Rice (in Dinars)"
	label var c3_a_1_win_b				"Bread, Flour (in Dinars)"
	label var q2_1_16_win_b				"Number of phone owned"
	label var q2_1_21_win_b				"Number of horses owned"
	label var q2_1_19_win_b				"Number of chicken owned"
	label var q2_1_18_win_b				"Number of sheep owned"
	label var epargne_dette_b			"Contract debt last year"
	label var epargne_cb_win_b			"Amount saved last year"
	label var epargne_b					"Saved money last year"
	label var epargne_pret_b			"Lend money last year"
	label var initiatives_2_b			"Respondent meet the Omda last 6 month"
	label var initiatives_1_b			"Respondent participated in a townhall last 6 month"
	label var psy_a_menage_dum3_b		"Felt accepted by other HH in community at baseline"
	label var psy_menage_dum3_b			"Respondent had good relation with other HH member at baseline"
	label var association_2_b			"Member of a woman association"
	label var association_dummy_b		"Member of any local association"
	

		
********************************************************************************
* 1) Descriptive attrition analysis
********************************************************************************


count if attrition == 1 & trt_cash_0 == 0 & trt_cash_1 == 0
local n1 	= `r(N)'
local perc1 = `n1'/1000

count if attrition == 1 & trt_cash_0 == 1
local n2 	= `r(N)'
local perc2 = `n2'/500

count if attrition == 1 & trt_cash_1 == 1
local n3 	= `r(N)'
local perc3 = `n3'/500


	* Export tables 
	
	file open Table using "Balance Test Cash/Table_Attrition_Number.tex", text write replace
		
	file write Table  									_n ///
	"Control 				& `n1' & `perc1'\%	 \\ "	_n ///
	"Treatment 				& `n2' & `perc2'\%	 \\ "	_n ///
	"Treatment x Partner	& `n3' & `perc3'\%	 \\ "	_n ///
	"\hline											"	_n 
	
	file close Table 
	
* Check code and Names of _merge == 1

gen 	Refusal = 0
replace Refusal = 1 	if Status == 4

gen 	Dead = 0 
replace Dead = 1 		if Status == 5

gen 	Abroad = 0 
replace Abroad = 1 		if Status == 6

gen 	Moved = 0 
replace Moved = 1 		if Status == 7 

g 		Unreachable = 0
replace Unreachable = 1 	if Status == 9

g 		Other = 0 
replace Other = 1 		if Status == 10

	
local counter = 0 

foreach reason in Refusal Dead Abroad Moved Unreachable Other{

	local counter = `counter' + 1 
	
	count if `reason' == 1 & trt_cash_0 == 0 
	local n1`counter' = `r(N)'
		
	sum `reason' 		if  trt_cash_0 == 0 
	local m1`counter' : di%12.3f `r(mean)'
		
	count if `reason' == 1 & trt_cash_0 == 1
	local n2`counter' = `r(N)'
		
	sum `reason' 		if  trt_cash_0 == 1 
	local m2`counter' : di%12.3f `r(mean)'
	
	count if `reason' == 1 & trt_cash_1 == 1 
	local n3`counter' = `r(N)'
		
	sum `reason' 		if  trt_cash_1 == 1 
	local m3`counter' : di%12.3f `r(mean)'
		
	reg `reason'	trt_cash_0
	reg `reason'	trt_cash_1
}

	* Export summary breakdown table
	
	file open Table using "Balance Test Cash/Table_Attrition_Breakdown.tex", text write replace
		
	file write Table  									_n ///
	"Refusal 	& `n11' & `m11' & `n21' & `m21'  & `n31' & `m31' \\" _n ///
	"Dead	 	& `n12' & `m12' & `n22' & `m22'  & `n32' & `m32' \\" _n ///
	"Abroad	 	& `n13' & `m13' & `n23' & `m23'  & `n33' & `m33' \\" _n ///
	"Moved	 	& `n14' & `m14' & `n24' & `m24'  & `n34' & `m34' \\" _n ///
	"Unreachable & `n15' & `m15' & `n25' & `m25'  & `n35' & `m35' \\" _n ///
	"Other		& `n16' & `m16' & `n26' & `m26'  & `n36' & `m36' \\" _n ///
	"\hline														   " _n 
	
	file close Table

	* Test of significance between 
	
	forvalue i = 0/1{
	
		iebaltab Refusal Dead Abroad Moved Unreachable Other, grpvar(trt_cash_`i') fixedeffect(Strata) normdiff pftest pttest total grplabel("0 Control @ 1 Treatment") rowvarlabels savetex("Balance Test Cash/Table_Attri_Diff_Breakdown_`i'.tex") replace
	
	}
	
preserve
	
	replace trt_cash = 2 if trt_cash_1 == 1
	
	iebaltab Refusal Dead Abroad Moved Unreachable Other, grpvar(trt_cash) fixedeffect(Strata) normdiff pftest pttest total grplabel("0 Control @ 1 Treatment 1 @ 2 Treatment 2") rowvarlabels savetex("Balance Test Cash/Table_Attri_Diff_Breakdown_main.tex") replace
	
restore 

/*		--> ONLY FOR FOLLOW UP
foreach reason in Refusal Dead Abroad Moved Inexistant{

	sum `reason' if trt_followup == 0 & Intervention == "Follow up - TCLP"
	sum `reason' if trt_followup == 1 & Intervention == "Follow up - TCLP"
	
	reg `reason' trt_followup, robust
	
}

*/

********************************************************************************
* 2) Statistical analysis
********************************************************************************

	forvalue i = 0/1{
	
	*******************************************
	* Column 1: Attrition test 
	*******************************************

	reg attrition trt_cash_`i' i.Strata, robust
	
	local c`i'_1 	: di%12.3f _b[trt_cash]
	local se`i'_1 	: di%12.3f _se[trt_cash]
	local n`i'1 	= e(N)
	local r2`i'_1 	= e(R2)
				
	* Compute p-value
	local pval_1 = ttail(e(df_r),abs(_b[trt_cash]/_se[trt_cash]))*2	
			
	* Format local 
	local pval_1 : di%12.3f `pval_1'
	local se`i'_1 = trim("`se`i'_1'")
	local se`i'_1 		 "(`se`i'_1')"
	local se`i'_1 = trim("`se`i'_1'")
			
	* Add stars
	if `pval_1' < 0.1{
		local s`i'_1 "*"
	}
	if `pval_1' < 0.05{
		local s`i'_1 "**"
	}
	if `pval_1' < 0.01{
		local s`i'_1 "***"
	}
	
	*****************************************************
	* Column 2: Attrition test controlling for covariates
	*****************************************************

	reg attrition trt_cash_`i' `covariates' i.Strata, robust
	
	local c`i'_2	: di%12.3f _b[trt_cash]
	local se`i'_2 	: di%12.3f _se[trt_cash]
	local n`i'2 	= e(N)
	local r2`i'_2 	= e(R2)
				
	* Compute p-value
	local pval_2 = ttail(e(df_r),abs(_b[trt_cash]/_se[trt_cash]))*2	
			
	* Format local 
	local pval_2 : di%12.3f `pval_2'
	local se`i'_2 = trim("`se`i'_2'")
	local se`i'_2 		 "(`se`i'_2')"
	local se`i'_2 = trim("`se`i'_2'")
			
	* Add stars
	if `pval_2' < 0.1{
		local s`i'_2 "*"
	}
	if `pval_2' < 0.05{
		local s`i'_2 "**"
	}
	if `pval_2' < 0.01{
		local s`i'_2 "***"
	}
	
	* Store covariates results and p value 
	
	local count_out = 0 
	
	foreach variables in `covariates' {
		
		local count_out = `count_out' + 1 
		
		local l_`count_out' : variable label `variables'
						
			local c`i'_2_`count_out' 	: di%12.3f _b[`variables']
			local se`i'_2_`count_out' 	: di%12.3f _se[`variables']
				
			* Compute p-value
			local pval_2_`count_out' = ttail(e(df_r),abs(_b[`variables']/_se[`variables']))*2	
			
			* Format local 
			local pval_2_`count_out' : di%12.3f `pval_2_`count_out''
			local se`i'_2_`count_out' = trim("`se`i'_2_`count_out''")
			local se`i'_2_`count_out' 		 "(`se`i'_2_`count_out'')"
			local se`i'_2_`count_out' = trim("`se`i'_2_`count_out''")
			
			* Add stars
			if `pval_2_`count_out'' < 0.1{
				local s`i'_2_`count_out' "*"
			}
			if `pval_2_`count_out'' < 0.05{
				local s`i'_2_`count_out' "**"
			}
			if `pval_2_`count_out'' < 0.01{
				local s`i'_2_`count_out' "***"
			}
	}	
	*********************************************************************
	* Column 3: Attrition test controlling for covariates and interacted
	*********************************************************************
	* Generate interaction terms between covariates and treatement 
	
	foreach variables in `covariates'{
		
		cap drop trtX`variables'												// Need to create those variables two times for each intervention
		
		g trtX`variables' = trt_cash_`i'*`variables'
		
	}
	
	reg attrition trt_cash_`i' `covariates' trtX* i.Strata, robust
	
	local c`i'_3	: di%12.3f _b[trt_cash]
	local se`i'_3 	: di%12.3f _se[trt_cash]
	local n`i'3 	= e(N)
	local r2`i'_3 	= e(R2)
				
	* Compute p-value
	local pval_3 = ttail(e(df_r),abs(_b[trt_cash]/_se[trt_cash]))*2	
			
	* Format local 
	local pval_3 : di%12.3f `pval_3'
	local se`i'_3 = trim("`se`i'_3'")
	local se`i'_3 		 "(`se`i'_3')"
	local se`i'_3 = trim("`se`i'_3'")
			
	* Add stars
	if `pval_3' < 0.1{
		local s`i'_3 "*"
	}
	if `pval_3' < 0.05{
		local s`i'_3 "**"
	}
	if `pval_3' < 0.01{
		local s`i'_3 "***"
	}
	
	* Store covariates results and p value 
	
	local count_out = 0 
	
		foreach variables in `covariates' {
			
			local count_out = `count_out' + 1 
			
			local l_`count_out' : variable label `variables'
							
				local c`i'_3_`count_out' 	: di%12.3f _b[`variables']
				local se`i'_3_`count_out' 	: di%12.3f _se[`variables']
					
				* Compute p-value
				local pval_3_`count_out' = ttail(e(df_r),abs(_b[`variables']/_se[`variables']))*2	
				
				* Format local 
				local pval_3_`count_out' : di%12.3f `pval_3_`count_out''
				local se`i'_3_`count_out' = trim("`se`i'_3_`count_out''")
				local se`i'_3_`count_out' 		"(`se`i'_3_`count_out'')"
				local se`i'_3_`count_out' = trim("`se`i'_3_`count_out''")
				
				* Add stars
				if `pval_3_`count_out'' < 0.1{
					local s`i'_3_`count_out' "*"
				}
				if `pval_3_`count_out'' < 0.05{
					local s`i'_3_`count_out' "**"
				}
				if `pval_3_`count_out'' < 0.01{
					local s`i'_3_`count_out' "***"
				}
		}
	
	* Store covariates interacted results and p value 
	
	local count_out = 0 
	
		foreach variables in `covariates' {
			
			local count_out = `count_out' + 1 
			
			local l_`count_out' : variable label `variables'
							
				local ci`i'_3_`count_out' 	: di%12.3f _b[trtX`variables']
				local sei`i'_3_`count_out' : di%12.3f _se[trtX`variables']
					
				* Compute p-value
				local pvali_3_`count_out' = ttail(e(df_r),abs(_b[trtX`variables']/_se[trtX`variables']))*2	
				
				* Format local 
				local pvali_3_`count_out' : di%12.3f `pvali_3_`count_out''
				local sei`i'_3_`count_out' = trim("`sei`i'_3_`count_out''")
				local sei`i'_3_`count_out' 		 "(`sei`i'_3_`count_out'')"
				local sei`i'_3_`count_out' = trim("`sei`i'_3_`count_out''")
				
				* Add stars
				if `pvali_3_`count_out'' < 0.1{
					local si`i'_3_`count_out' "*"
				}
				if `pvali_3_`count_out'' < 0.05{
					local si`i'_3_`count_out' "**"
				}
				if `pvali_3_`count_out'' < 0.01{
					local si`i'_3_`count_out' "***"
				}
		}
	}
	* Export TeX Tables of attrition test at individual level 
	
{

	file open Table using "Balance Test Cash/Table_Attrition_Individual.tex", text write replace
	
	file write Table  																																_n ///
	" Treatment						& 	`c0_1'`s0_1' & 	`c0_2'`s0_2'  & `c0_3'`s0_3' 	& 	`c1_1'`s1_1' & 	`c1_2'`s1_2'  & `c1_3'`s1_3'	\\ " 	_n ///
	" 								&	 `se0_1'     &	 `se0_2' 	  &	 `se0_3'		&	 `se1_1'     &	 `se1_2' 	  &	 `se1_3'		\\ " 	_n 
	
	forvalue i = 1/`count_out'{
	
		file write Table																																		_n ///
		" `l_`i''					& 	 & `c0_2_`i''`s0_2_`i'' 	& `c0_3_`i''`s0_3_`i'' 	 & 	 & `c1_2_`i''`s1_2_`i'' 	& `c1_3_`i''`s1_3_`i''		\\ " 	_n ///
		" 							&	 &  `se0_2_`i''				&  `se0_3_`i''		  	 &	 &  `se1_2_`i''				&  `se1_3_`i''				\\ " 	_n ///
		" `l_`i'' X Treatment		& 	 & `ci0_2_`i''`si0_2_`i'' 	& `ci0_3_`i''`si0_3_`i'' & 	 & `ci1_2_`i''`si1_2_`i'' 	& `ci1_3_`i''`si1_3_`i'' 	\\ " 	_n ///
		" 							&	 &  `sei0_2_`i''			&  `sei0_3_`i''			 &	 &  `se1_2_`i''				&  `sei1_3_`i''				\\ " 	_n 
		
	}
	
	file write Table																										_n ///
	"Observations					&	`n01'	&	`n02'	&	`n03'	&	`n11'	&	`n12'	&	`n13'			\\"		_n 
	
	file close Table	
	
}

