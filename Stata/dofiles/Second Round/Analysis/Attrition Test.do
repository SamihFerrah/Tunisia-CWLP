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
cd "$git_tunisia/outputs/Second Round/Endline report"
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

* Table Attrition 
* ----------------------

egen attrition2 = rowtotal(Dead Moved Refusal Other)
// gen Submitted = 1 if attrition == 1 & attrition2 == 0
// replace Submitted = 0 if Submitted == .
replace Other = 1 if attrition == 1 & attrition2 == 0 // submitted forms

label var Dead 		"~~~~ Death"
label var Moved 	"~~~~ Migrated"
label var Refusal 	"~~~~ Refusals"
label var Other 	"~~~~ Other"
label var attrition "Attrition"

global attri_0 attrition 
global attri_1 Moved Dead Refusal Other

file open Table using "attrition.tex", text write replace

foreach reason in attri_0 attri_1{

	if "`reason'" == "attri_0"{
		local title ""
	}
	if "`reason'" == "attri_1"{
		local title "Attrition reason"
	}
	
	file write Table																							_n ///
	"`title' 																							\\ "	_n
		
foreach var in $`reason' {
		
		local l_var : variable label `var'
		
		* Summary stat
		sum `var' if group == 0
		local me0 	: di%12.3f `r(mean)'
		local sd0 	: di%12.3f `r(sd)'
		local n0 	= `r(N)'
	
		sum `var' if group == 1
		local me1 	: di%12.3f `r(mean)'
		local sd1 	: di%12.3f `r(sd)'
		local n1 	= `r(N)'
		
		sum `var' if group == 2
		local me2 	: di%12.3f `r(mean)'
		local sd2 	: di%12.3f `r(sd)'
		local n2 	= `r(N)'
		
		
		* T-test
		ttest `var' , by(trt_cash_0)
		local p0	= `r(p)'
		local p0	: di%12.3f `p0'
		local n10	=`r(N_1)'
		local n20	=`r(N_2)'
		local ntot0	=`n1'+`n2'
		
		ttest `var' , by(trt_cash_1)
		local p1	: di%12.3f `r(p)'
		local n11	=`r(N_1)'
		local n21	=`r(N_2)'
		local ntot1	=`n1'+`n2'
		
		ttest `var' , by(trt_cash_2)
		local p2	: di%12.3f `r(p)'
		local n12 	=`r(N_1)'
		local n22 	=`r(N_2)'
		local ntot2	=`n1'+`n2'
		
		* Add parantheses around standard error
		
		forvalue i = 0/2{
			local sd`i' = trim("`sd`i''")
			local sd`i' = "(`sd`i'')"
			local sd`i' = trim("`sd`i''")
		
		}
		
		* Add stars indication 
		forvalue i = 0/2{
			
			local s`i' ""
			
			if `p`i'' < 0.10{
				
				local s`i' "*"
				
			}
			
			if `p`i'' < 0.05{
				
				local s`i' "**"
				
			}
			
			if `p`i'' < 0.01{
				
				local s`i' "***"
				
			}
		
		}
		
		
		* Normalize difference 
		stddiff `var' , by(trt_cash_0)
		matrix b = r(output)		
		local ndiff0 = b[1,5]	
		local ndiff0 : di%12.3f `ndiff0'
		
		stddiff `var' , by(trt_cash_1)
		matrix b = r(output)		
		local ndiff1 = b[1,5]
		local ndiff1 : di%12.3f `ndiff1'
		
		stddiff `var' , by(trt_cash_2)
		matrix b = r(output)		
		local ndiff2 = b[1,5]
		local ndiff2 : di%12.3f `ndiff2'
		
		file write Table																							_n ///
		"`l_var' & `me0' & `me1' & `me2' & `p0'`s0' & `p1'`s1' & `p2'`s2' & `ndiff0' & `ndiff1' & `ndiff2'	\\"		_n ///
		"		 & `sd0' & `sd1' & `sd2' &      	&     	   &          &          &          &        	\\"		_n
		
	}
}

	
file write Table																								_n ///
"\hline																										 "	_n ///
"Observations  & `n0' & `n1' & `n2' & `ntot0' & `ntot1' & `ntot2' & `ntot0' & `ntot1' & `ntot2' 		   \\"	_n ///
"\addlinespace																								 "	_n ///
"\hline																										 "  _n 
	
file close Table
	