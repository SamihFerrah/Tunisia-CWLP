********************************************************************************
********************************************************************************
* 0) Define list of outcomes 
********************************************************************************
********************************************************************************
clear 
set maxvar 120000
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


merge m:1 HHID using "$home/14. Female Entrepreneurship Add on/Survey material/Assignment/Full Sample.dta", gen(assignment)

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
	
	* Recode missing variables with special missing indicator
	
	foreach var of varlist _all { 													//loop over all variables

		capture confirm numeric variable `var' 										//check that a variable is numeric
		
		if !_rc{
			
			local num_var = "`num_var' `var'"										// Add `var' to local with all numeric variable
			
			cap qui replace `var' =.w if 	`var'== -98 | ///
											`var'== -8  							// Refuse 
												
			cap qui replace `var' =.k if 	`var'== -99 | ///
											`var'== -9 								// Don't know 
												
			cap qui replace `var' =.z if 	`var'== -97 | ///
											`var'== -7 							//not relevant / other exception
		}
	}


	* Keep numeric variable
	
	keep `num_var'

	local all_var ""															// A bit unnecessary as it would end up with the same var as the local num_var		

	foreach var of varlist  _all{

		g sd_`var' 		= `var'
		g i_`var'		= `var'
		g a_`var'		= `var'
		g m_`var'		= `var'
		g p_`var'		= `var'
		g c_`var'		= `var'
		
		local all_var "`all_var' `var'"
		
	}
	
	* Count number of variable in local 
	
	local count_obs: word count `all_var'


	* Generate summary stats for each var 
	
	collapse (mean) m_* (sd) sd_* (min) i_* (max) a_* (percent) p_* (count) c_*

	local category "m_ sd_ i_ a_ p_ c_"

	* Loop over type of summary stat and create tempfile for each 
	
	foreach collapsed of local category{

		preserve 
		
			keep `collapsed'*
			
			rename `collapsed'* * 
			
			tempfile  `collapsed'
			sa		 ``collapsed''

		restore 
	}


	* Loop over each summary stat to rename and prepare dataset for merging all 
	
	foreach collapsed of local category{

		* Condition for naming variables
		if "`collapsed'" == "m_"{
			local varname = "Mean"
		}
		if "`collapsed'" == "sd_"{
			local varname = "StDev"
		}
		if "`collapsed'" == "i_"{
			local varname = "Min"
		}
		if "`collapsed'" == "a_"{
			local varname = "Max"
		}
		if "`collapsed'" == "p_"{
			local varname = "NonMissing"
		}
		if "`collapsed'" == "c_"{
			local varname = "Missing"
		}
		
		* Use tempfile 
		u ``collapsed'', clear

		* Create variables
		g `varname' 		=.
		g Variables 		=""

		* Set observations as the number of numeric variables
		set obs `count_obs'

		local counter = 1
		
		* Fill obs with: Variable names and Statistics from tempfile
		foreach var of varlist _all{

			di in red "`var'"
			
			local stat =  `var'
			
			di in red "`stat'"
			
			replace `varname'  	= `stat' 		if _n == `counter'
			replace Variables 	= "`var'"	  	if _n == `counter'
					
			local counter = `counter' + 1
		}

		* Keep relevant variables (Variable name + Statistic)
		keep `varname' Variables

		* Tempfile
		tempfile  `varname'
		sa		 ``varname''

	}

	* Merge all tempfile with summary stat
	
	u `Mean', clear
	merge 1:1 Variables using `StDev', nogen
	merge 1:1 Variables using `Min', nogen
	merge 1:1 Variables using `Max', nogen
	merge 1:1 Variables using `NonMissing', nogen
	merge 1:1 Variables using `Missing', nogen

	sa "$home/14. Female Entrepreneurship Add on/Data/Second Round/tempdata/Statistiques_`i'.dta", replace

	********************************************************************************
	********************************************************************************
	********************************************************************************

	* Export to excel
	
	u "$home/14. Female Entrepreneurship Add on/Data/Second Round/tempdata/Statistiques_`i'.dta", clear

	merge 1:1 Variables using "$home/14. Female Entrepreneurship Add on/Data/Second Round/tempdata/form.dta"

	keep if _merge == 3

	* Transform number of non missing into number of missing 
	
	replace Missing = `tot_obs' - Missing
		
	drop _merge 

	order module Variables label Mean StDev Min Max Missing 

	sort module variable_order

	drop variable_order
	
	if `i' == 0{
	    
		keep if module == "x1_mengender_yesno" 	| ///
				module == "x1_mengender_agree" 	| ///
				module == "x1_mengender1" 	   	| ///
				module == "x1_mengender2" 	   	| ///
				module == "x2_husbanwives" 		| ///
				module == "x6_sexuality" 		| ///
				module == "x7_masculinity" 		| ///
				module == "x7_masculinity" 		| ///
				module == "x8_reprodhe" 		| ///
				module == "x9_autonomy" 		| ///
				module == "x9_autonomy2" 		| ///
				module == "x9_autonomy3" 		| ///
				module == "x3_gbviolences" 		| ///
				module == "x4_gbviolenceshh" 	| ///
				module == "x5_gbviolencesperp"
				
	}
	
	if `i' == 1{
	    
		drop if module == "x1_mengender_yesno" 	| ///
				module == "x1_mengender_agree" 	| ///
				module == "x1_mengender1" 	   	| ///
				module == "x1_mengender2" 	   	| ///
				module == "x2_husbanwives" 		| ///
				module == "x6_sexuality" 		| ///
				module == "x7_masculinity" 		| ///
				module == "x7_masculinity" 		| ///
				module == "x8_reprodhe" 		
				
	}
	
	
	export excel using "$stata/outputs/Cleaning/Statistics.xlsx", sheet("`shet'", replace) first(var)

}


	
