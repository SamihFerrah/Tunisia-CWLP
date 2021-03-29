
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
do "$git_tunisia/dofiles/Ado/stata-tex.do"


local balance_indiv 	repondant_age_b repondant_educ_b									///
						hhsize_b adult_num_b jeunes_lireecrire_b 			///
						formation_b origine_naissance_b origine_naissance_bis_b 			///
						association_dummy_b association_2_b  								///
						psy_menage_dum3_b psy_a_menage_dum3_b								///
						initiatives_1_b initiatives_2_b 									///
						epargne_pret_b epargne_b epargne_cb_win_b epargne_dette_b 			/// 
						q2_1_18_win_b q2_1_19_win_b q2_1_21_win_b q2_1_16_win_b 			/// 
						c3_a_1_win_b c3_a_2_win_b c3_a_3_win_b c3_a_4_win_b					///
						c3_a_5_win_b c3_a_6_win_b c3_a_7_win_b c3_a_8_win_b					///
						c3_a_9_win_b c3_a_10_win_b c3_a_11_win_b c4_win_b 					/// 
						days_work_main_win_b 						 						///
						inc_work_main_win_b profit_work_main_win_b 							///
						business_q0_main_b emploi_sec_b

						
local balance_indiv_om 	repondant_age_b repondant_educ_b									///
						hhsize_b adult_num_b jeunes_lireecrire_b emploi_2013_a_b			///
						formation_b origine_naissance_b origine_naissance_bis_b 			///
						association_dummy_b association_2_b  								///
						psy_menage_dum3_b psy_a_menage_dum3_b								///
						initiatives_1_b initiatives_2_b 									///
						epargne_pret_b epargne_b epargne_cb_win_b epargne_dette_b 			/// 
						q2_1_18_win_b q2_1_19_win_b q2_1_21_win_b q2_1_16_win_b 			/// 
						c3_a_1_win_b c3_a_2_win_b c3_a_3_win_b c3_a_4_win_b					///
						c3_a_5_win_b c3_a_6_win_b c3_a_7_win_b c3_a_8_win_b					///
						c3_a_9_win_b c3_a_10_win_b c3_a_11_win_b c4_win_b 					/// 
						business_q0_main_b
						
global balance 	woman_b repondant_age_b secondary_b  origine_naissance_b married_b relation_head_b relation_spouse_b relation_daughter_b relation_other_b emploi_main_b initiatives_2_b formation_b ///
				hhsize_b children_b adults_b elderly_b conso_food_pc_b conso_nofood_pc_b conso_tot_pc_b dirtfloor_b thatched_still_b proprietaire_terre_b livestock_b /// 
				distance_cheflieu_b distance_marche_b distance_transpublic_b distance_ecoleprim_b distance_eau_b 
				
********************************************************************************
********************************************************************************						
* 1) Balance test at individual level 
********************************************************************************
********************************************************************************						

u "$vera/clean/clean_analysis_CashXFollow.dta", clear

drop if tot_complete == 0 | Intervention == "Follow up - TCLP" | Intervention == "" | Intervention == "Cash Grants - Partenaire"

sum 			woman_b repondant_age_b secondary_b  origine_naissance_b married_b relation_head_b relation_spouse_b relation_daughter_b relation_other_b emploi_main_b initiatives_2_b ///
				hhsize_b children_b adults_b elderly_b conso_food_pc_b conso_nofood_pc_b conso_tot_pc_b dirtfloor_b thatched_still_b proprietaire_terre_b livestock_b /// 
				distance_cheflieu_b distance_marche_b distance_transpublic_b distance_ecoleprim_b distance_eau_b // many missing values for variables: distance_ecolesec_b distance_dispensaire_b


* Table balance full
* -------------------------

* Means, sd and ttests and normalized diff
foreach var in $balance {
forvalues x = 0/2 {
sum `var' if group == `x'
local sd = `r(sd)'
local n = `r(N)'
insert_into_file using "${stata_tex}/sample_table.csv", key(`var'_mean`x') value(" `r(mean)'") format(%6.3f)
insert_into_file using "${stata_tex}/sample_table.csv", key(`var'_sd`x') value(" `sd'") format(%6.3f)
insert_into_file using "${stata_tex}/sample_table.csv", key(`var'_n`x') value(" `n'") format(%-9.0g)
ttest `var' , by(trt_cash_`x')
local n1=`r(N_1)'
local n2=`r(N_2)'
local ntot=`n1'+`n2'
insert_into_file using "${stata_tex}/sample_table.csv", key(`var'_p`x') value(" `r(p)'") format(%6.3f)
insert_into_file using "${stata_tex}/sample_table.csv", key(`var'_ntot`x') value(" `ntot'") format(%-9.0g)
stddiff `var' , by(trt_cash_`x')
matrix b = r(output)
local ndiff = b[1,5]	
insert_into_file using "${stata_tex}/sample_table.csv", key(`var'_ndiff`x') value(" `ndiff'") format(%6.3f)
}
}
* Omnibus test
forvalues x = 0/2 {
reg trt_cash_`x'	$balance
test $balance
insert_into_file using "${stata_tex}/sample_table.csv", key(omnip`x') value(" `r(p)'") format(%6.3f)
}


* Table balance endline sample
* ----------------------------------------

drop if attrition == 1

* Means, sd and ttests and normalized diff
foreach var in $balance {
forvalues x = 0/2 {
sum `var' if group == `x'
local sd = `r(sd)'
local n = `r(N)'
insert_into_file using "${stata_tex}/sample_table.csv", key(`var'2_mean`x') value(" `r(mean)'") format(%6.3f)
insert_into_file using "${stata_tex}/sample_table.csv", key(`var'2_sd`x') value(" `sd'") format(%6.3f)
insert_into_file using "${stata_tex}/sample_table.csv", key(`var'2_n`x') value(" `n'") format(%-9.0g)
ttest `var' , by(trt_cash_`x')
local n1=`r(N_1)'
local n2=`r(N_2)'
local ntot=`n1'+`n2'
insert_into_file using "${stata_tex}/sample_table.csv", key(`var'2_p`x') value(" `r(p)'") format(%6.3f)
insert_into_file using "${stata_tex}/sample_table.csv", key(`var'2_ntot`x') value(" `ntot'") format(%-9.0g)
stddiff `var' , by(trt_cash_`x')
matrix b = r(output)
local ndiff = b[1,5]	
insert_into_file using "${stata_tex}/sample_table.csv", key(`var'2_ndiff`x') value(" `ndiff'") format(%6.3f)
}
}

* Omnibus test
forvalues x = 0/2 {
reg trt_cash_`x'	$balance
test $balance
insert_into_file using "${stata_tex}/sample_table.csv", key(omnip`x'2) value(" `r(p)'") format(%6.3f)
}


table_from_tpl, t("${stata_tex}/TPL_balance.tex") r("${stata_tex}/sample_table.csv") o("${stata_tex}/balance.tex")
table_from_tpl, t("${stata_tex}/TPL_balance2.tex") r("${stata_tex}/sample_table.csv") o("${stata_tex}/balance2.tex")


/*
replace trt_cash_0 = . if attrition == 1
replace trt_cash_1 = . if attrition == 1
	
local balance_indiv_m ""

foreach var in `balance_indiv'{

	g 		m_`var'	= 0
	replace m_`var' = 1 if `var' ==.
	
	replace `var' = 0 	if `var' == .
	
	local balance_indiv_m "`balance_indiv_m' m_`var'"


}


bys trt_cash_0: sum emploi_main_b days_work_main inc_work_main_win_b profit_work_main_win_b emploi_sec_b

bys trt_cash_1:sum emploi_main_b days_work_main inc_work_main_win_b profit_work_main_win_b emploi_sec_b



	* Some re-labelling 
	
	/*
	* Drop label
	foreach covariates in `balance_indiv'{
		
		label var `covariates' drop
		
	}
	*/
	
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
	

		
	
	*******************************************
	* Difference
	*******************************************
	
	forvalue i = 0/1{
		
		iebaltab `balance_indiv', grpvar(trt_cash_`i') fixedeffect(strata_cash) cov(`balance_indiv_m') normdiff pftest pttest total grplabel("0 Control @ 1 Treatment") rowvarlabels savetex("Balance Test Cash/Table_Balance_Individual_`i'.tex") replace
	
	}

	preserve 
	
	replace trt_cash = 2 if trt_cash_1 == 1
	
	iebaltab `balance_indiv', grpvar(trt_cash) fixedeffect(strata_cash) cov(`balance_indiv_m') normdiff pftest pttest total grplabel("0 Control @ 1 Treatment 1 @ 2 Treatment 2") rowvarlabels savetex("Balance Test Cash/Table_Balance_Individual_main.tex") replace
	
	restore 
	
	********************************************
	* Omnibus test
	********************************************
	
	forvalue i = 0/1{
		
		local count_out = 0
		
		* Regression
		reg trt_cash_`i' `balance_indiv' `balance_indiv_m', robust 
		
		local n`i' = e(N)
		
		foreach variables in `balance_indiv' {
			
			local count_out = `count_out' + 1 
			
			local l_`count_out' : variable label `variables'
							
				local c`i'_2_`count_out' 	: di%12.3f  _b[`variables']
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
		" `l_`i''					& `c0_2_`i''`s0_2_`i'' 	& `pval0_2_`i''	 		& `c1_2_`i''`s1_2_`i'' 	& `pval1_2_`i''				\\ " 	_n ///
		" 							&  `se0_2_`i''			& 				  	 	&  `se1_2_`i''			&  							\\ " 	_n ///
		
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
					
			reg `covariates' m_`covariates' trt_cash_`i' i.strata_cash, robust
			
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
	
	forvalue i = 1/`count_out'{
	
		file write Table																					_n ///
		" `l_`i''					&   `c_1_`i''`s_1_`i'' 	& `pval_1_`i'' & `n_1_`i''		\\ " 	_n ///
		" 							&    `se_1_`i''			&  										\\ " 	_n ///
		
	}
	
	file close Table	

}
	
	
	