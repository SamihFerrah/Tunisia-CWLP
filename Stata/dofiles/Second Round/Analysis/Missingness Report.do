********************************************************************************
********************************************************************************
* 0) Define list of outcomes 
********************************************************************************
********************************************************************************
clear 
set maxvar 32767
pause on 

	// 1) Import form definition 
	import excel using "$home/14. Female Entrepreneurship Add on/Survey Instrument/DIME_Tunisia_entrepreneurship_12232020_Encrypted Version.xlsx", sheet("survey") clear first
	
	* Gen variable order 
	
	g variable_order =_n 
	
	// 2) Keep interesting type of question
	
	split type, parse(" ")
	
	keep if type == "integer" 					| ///
			type == "begin group"				| ///
			type == "decimal"					| ///
			type1 == "select_one"

			
	// 3) Define form section using different modules 

	g 		group_name = ""
	replace group_name = name if type == "begin group"
	replace group_name = group_name[_n-1] if group_name == ""
	
	* Here insert module not needed in outputs 
	drop if group_name == "a1_enumname"					|	///
			group_name == "a1_datetime"					|	///
			group_name == "a1_city "					|	///
			group_name == "a1_respondentcoordinates"	|	///
			group_name == "a1_respondents_1"			| 	///
			group_name == "a2_consent"					|	///
			group_name == "consentok"					| 	///
			group_name == "wife_questionnaire"			|	///
			group_name == "socioecono_demograph"		|	///
			group_name == ""

	keep type name labelenglish constraint relevance variable_order
	
	g 		type2 = type 
	replace type2 ="." 	 if type != "begin group"
	
	g 		module = labelenglish 		  if type == "begin group"
	replace module = module[_n-1] 		  if type2 == "."
	
	keep name labelenglish module variable_order
	
	rename labelenglish label
	rename name Variables 
	
	sa "$home/14. Female Entrepreneurship Add on/Data/Second Round/tempdata/form.dta", replace

	
********************************************************************************
********************************************************************************
*				USE DATA AND CREATE SUMMARY STAT
********************************************************************************
********************************************************************************

forvalue i = 0/1{

u "$home/14. Female Entrepreneurship Add on/Data/Second Round/cleandata/clean_CashXFollow_noPII.dta", clear 

cap drop confirm_resp
cap drop confirm_age
cap drop a1_respondentage_corr
cap drop a1_truerespondant
cap drop a1_notrespondant
cap drop conf_cash_control
cap drop conf_cash_treatment
cap drop conf_cash_partner
cap drop conf_followup

* Merge with assignment list to identify respondents status (and type of survey)


merge m:1 HHID using "A:/Assignment/Full Sample.dta", gen(assignment) keepusing(HHID Intervention)

cap drop_merge 

keep if assignment == 3

* Create indicator for type of survey 

g 		male_survey = 0
replace male_survey = 1 if Intervention == "Cash Grants - Partenaire"

g 		cash_survey = 0 
replace cash_survey = 1 if Intervention == "Cash Grants - Women"

g 		tclp_survey = 0 
replace tclp_survey = 1 if Intervention == "Follow up - TCLP"



	* Keep appropriate sample 
	drop if male_survey == `i'
	
	count 
	
	local tot_obs = `r(N)'
	
	* Naming condition based on sample
	if `i' == 0{
		local shet "Partner"
	}
	if `i' == 1{
		local shet "Cash X Follow"
	}
	
	
	* Create local to be filled with numeric variable na,e
	local num_var = ""
	
	foreach var of varlist _all { 													//loop over all variables

		capture confirm numeric variable `var' 										//check that a variable is numeric
		
		if !_rc{
			
			local num_var = "`num_var' `var'"
		}
	}
	* Keep numeric variable
	
	keep `num_var'

	foreach var of varlist  _all{
	
		count 
		local tot_obs = `r(N)'
		
		local l_`var' : variable label `var'
		
		* Count number of DK 
		count if `var' ==.k
		local d_`var' = `r(N)'/`tot_obs'
		
		* Count number of RF 
		count if `var' ==.w
		local r_`var' = `r(N)'/`tot_obs'
		
		* Count number of ot 
		count if `var' ==.z
		local o_`var' = `r(N)'/`tot_obs'
		
		* Count number of Not applicable 
		count if `var' ==.a
		local a_`var' = `r(N)'/`tot_obs'
		
		* Count number of missing
		count if `var' ==.
		local t_`var' = `r(N)'/`tot_obs'
	
	}
	
	local count_obs: word count `num_var'
	
	clear 
	
	set obs `count_obs'
	
	local counter = 1
	
	g Variables = ""
	g Label 	= ""
	g DK  		=.
	g RFS 		=.
	g Other 	=.
	g Not_applicable 	= .
	g Missing 			= .
	
	foreach var of local num_var{
		
		replace Variables 		= "`var'" 		if _n == `counter'
		replace Label 			= "`l_`var''" 	if _n == `counter'
		replace DK			 	= `d_`var''		if _n == `counter'
		replace RFS			 	= `r_`var''		if _n == `counter'
		replace Other			= `o_`var''		if _n == `counter'
		replace Not_applicable	= `a_`var''		if _n == `counter'
		replace Missing 		= `t_`var''		if _n == `counter'
		
		local counter = `counter' + 1 
	}

	
	merge 1:1 Variables using "$home/14. Female Entrepreneurship Add on/Data/Second Round/tempdata/form.dta"

	keep if _merge == 3

	* Transform number of non missing into number of missing 
			
	drop _merge 

	order module Variables Label DK RFS Other Not_applicable Missing

	
	sort module variable_order
	
	keep module Variables Label DK RFS Other Not_applicable Missing
	
	export excel using "$stata/outputs/Cleaning/Data Quality.xlsx", sheet("Missingness - `shet'", replace) first(var)

}


	
