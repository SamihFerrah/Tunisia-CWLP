
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
cd "$git_tunisia/outputs/Second Round/Endline report"
pause on 
clear 



						
global balance_0 	repondant_age_b secondary_b  origine_naissance_b married_b 				///
					emploi_main_b formation_b 

global balance_1	relation_head_b relation_spouse_b relation_daughter_b relation_other_b 			///			
					
global balance_2 	hhsize_b children_b adults_b elderly_b 

global balance_3 	conso_food_pc_b conso_nofood_pc_b conso_tot_pc_b dirtfloor_b thatched_still_b	///
					proprietaire_terre_b livestock_b

global balance_4 	distance_cheflieu_b distance_marche_b distance_transpublic_b distance_ecoleprim_b distance_eau_b 
				
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


* Special label var to add indent in Latex Table 
label var woman_b 					"Female"
label var repondant_age_b 			"Age"
label var secondary_b  				"Completed secondary school"
label var origine_naissance_b 		"Born in this imada"
label var married_b 				"Married"
label var emploi_main_b 			"Had an IGA in the last month"
label var initiatives_2_b 			""
label var formation_b				"Attend a professional training"
label var hhsize_b 					"Household size"
label var children_b 				"Number of children ($<$18)"
label var adults_b 					"Number of adults (18-65)"
label var elderly_b					"Number of elders ($>$65)"
label var conso_food_pc_b 			"Daily food consumption per capita (in Dinars)"
label var conso_nofood_pc_b 		"Daily non food consumption per capita (in Dinars)"
label var conso_tot_pc_b 			"Daily consumption per capita (in Dinars)"
label var dirtfloor_b 				"Has dirt floor"
label var thatched_still_b			"Has thatched or steel roof"
label var proprietaire_terre_b 		"Owns land"
label var livestock_b				"Has livestock"
label var relation_head_b 			"~~~~ Head"
label var relation_spouse_b			"~~~~ Spouse of the head"
label var relation_daughter_b		"~~~~ Daughter of the head"
label var relation_other_b			"~~~~ Other"
label var distance_cheflieu_b 		"~~~~ Headquarter"
label var distance_marche_b 		"~~~~ Food market"	
label var distance_transpublic_b 	"~~~~ Public transportation station"
label var distance_ecoleprim_b 		"~~~~ Primary school"
label var distance_eau_b 			"~~~~ Water sourc"

* Table balance full
* -------------------------

* Means, sd and ttests and normalized diff

file open Table using "balance.tex", text write replace

foreach balance in balance_0 balance_1 balance_2 balance_3 balance_4{

	if "`balance'" == "balance_0"{
		local title "\textbf{Respondent variables}"
	}
	if "`balance'" == "balance_1"{
		local title "Status in the household"
	}
	if "`balance'" == "balance_2"{
		local title "\addlinespace \textbf{Household demographics}"
	}
	if "`balance'" == "balance_3"{
		local title "\addlinespace \textbf{Household living conditions}"
	}
	if "`balance'" == "balance_4"{
		local title "Walking distance (in minutes, one way)"
	}
	
	
	file write Table																							_n ///
	"`title' 																							\\ "	_n
		
foreach var in $`balance' {
		
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

* Omnibus Test

	reg trt_cash_0	$balance_0 $balance_1 $balance_2 $balance_3
	test $balance_0 $balance_1 $balance_2 $balance_3
	local p0 : di%12.3f `r(p)'
	
	reg trt_cash_1	$balance_0 $balance_1 $balance_2 $balance_3
	test $balance_0 $balance_1 $balance_2 $balance_3
	local p1 : di%12.3f `r(p)'
	
	reg trt_cash_2	$balance_0 $balance_1 $balance_2 $balance_3
	test $balance_0 $balance_1 $balance_2 $balance_3
	local p2 : di%12.3f `r(p)'
	
	file write Table																								_n ///
	"\hline																										 "	_n ///
	"Omnibus F-test p-value & . & . & . & `p0' & `p1' & `p2' & . & . & . 									   \\" 	_n ///
	"Observations  & `n0' & `n1' & `n2' & `ntot0' & `ntot1' & `ntot2' & `ntot0' & `ntot1' & `ntot2' 		   \\"	_n ///
	"\addlinespace																								 "	_n ///
	"\hline																										 "  _n 
	
file close Table

* Table balance endline sample
* ----------------------------------------

drop if attrition == 1

file open Table using "balance2.tex", text write replace

foreach balance in balance_0 balance_1 balance_2 balance_3 balance_4{

	if "`balance'" == "balance_0"{
		local title "\textbf{Respondent variables}"
	}
	if "`balance'" == "balance_1"{
		local title "Status in the household"
	}
	if "`balance'" == "balance_2"{
		local title "\addlinespace \textbf{Household demographics}"
	}
	if "`balance'" == "balance_3"{
		local title "\addlinespace \textbf{Household living conditions}"
	}
	if "`balance'" == "balance_4"{
		local title "Walking distance (in minutes, one way)"
	}
	
	
	file write Table																							_n ///
	"`title' 																							\\ "	_n
		
foreach var in $`balance' {
		
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

* Omnibus Test

	reg trt_cash_0	$balance_0 $balance_1 $balance_2 $balance_3
	test $balance_0 $balance_1 $balance_2 $balance_3
	local p0 : di%12.3f `r(p)'
	
	reg trt_cash_1	$balance_0 $balance_1 $balance_2 $balance_3
	test $balance_0 $balance_1 $balance_2 $balance_3
	local p1 : di%12.3f `r(p)'
	
	reg trt_cash_2	$balance_0 $balance_1 $balance_2 $balance_3
	test $balance_0 $balance_1 $balance_2 $balance_3
	local p2 : di%12.3f `r(p)'
	
	file write Table																								_n ///
	"\hline																										 "	_n ///
	"Omnibus F-test p-value & . & . & . & `p0' & `p1' & `p2' & . & . & . 									   \\" 	_n ///
	"Observations  & `n0' & `n1' & `n2' & `ntot0' & `ntot1' & `ntot2' & `ntot0' & `ntot1' & `ntot2' 		   \\"	_n ///
	"\addlinespace																								 "	_n ///
	"\hline																										 "  _n 


