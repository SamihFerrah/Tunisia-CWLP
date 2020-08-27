********************************************************************************
********************************************************************************
*				TUNISIA IE ENTREPENEURSHIP CLEANING 						   *
********************************************************************************
********************************************************************************
local date = c(current_date)


********************************************************************************
********************************************************************************
* 1) CHECK THAT WE HAVE ALL THE DATA OF THE DAY 
********************************************************************************
********************************************************************************
/* 	Test that all data from the field is on the server: match survey data logs from the
	field with survey data logs on the server to confirm that all the data from the 
	field has been transferred to the server. 
*/


********************************************************************************
********************************************************************************
* 2) APPLY CORRECTIONS FOR DUPLICATES OR ERROR IN CODE 
********************************************************************************
********************************************************************************
/* 	Run correction do-files in which we apply the different correction to keep this
	one clean from thousands line of correction
*/

do "$root/dofiles/duplicates_correction_tunisia.do"
do "$root/dofiles/error_code_tunisia.do"



********************************************************************************
********************************************************************************
* 3) CHECK THAT ALL SURVEY SUBMITTED ARE COMLETED 
********************************************************************************
********************************************************************************
/* 	Define indicator for survey completeness, often the last variables mandatory
	for all respondent not being missing
*/

* Generate indicator for completed survey 

g 		tot_complete = 0 
replace tot_complete if trauma_cauchemars !=.

* Generate indicator for date of interview

gen today = date(today_char,"MDY",2020)
format today %td
label variable today "Date of interview"


********************************************************************************
********************************************************************************
* 4) ERROR IN CODE
********************************************************************************
********************************************************************************

/*	Test for error in code: Use the original assignement list to compare original code and 
							and code enter by the enumerator
*/

preserve

	* Import list of code

	import excel using "$data_root/Original Assignment/XXXXXXX.xlsx", clear first
	
	* Keep relevant variables
	
	keep HHID name 
	
	* Create tempfile
	
	tempfile 	original 
	sa		   `original'
	
restore

* Merge and check that code correspond to the original assignment

merge 1:1 HHID using `original'

g 		error_code = 0 
replace error_code = 1 if _merge ==1											// If code only in master then error in code

preserve 
	
	keep if error_code == 1 
	 
	sort today today  
	 
	keep HHID today a1_enumid a1_cityn a1_respondentcoordinates a1_respondentname a1_respondentnam a1_respondentnames
	order HHID today a1_enumid a1_cityn a1_respondentcoordinates a1_respondentname a1_respondentnam a1_respondentnames
	
	rename 	(today a1_enumid a1_cityn a1_respondentcoordinates a1_respondentname a1_respondentnam a1_respondentnames)	///
			(Date Enqueteur Ville Coordonnees Nom Postnom Prenom)
			
	export excel using "$project_root/Cleaning/Cleaning_Issue_Tunisia_Entrepreneurship.xlsx", sheet("Error Code", modify) modify
	
restore
		
********************************************************************************
********************************************************************************
* 4) DUPLICATE TEST
********************************************************************************
********************************************************************************
/*	Test for duplicates: since SurveyCTO/ODK data provides a number of duplicates, 
	check for duplicates using ieduplicates.
*/

* Drop perfect duplicates 

duplicates drop 

* Duplicates in code among interviews

duplicates tag HHID if tot_complete == 1 & error_code == 0, g(dup)				// Check for duplicates among completed survey

* Check if real duplicates (instances submitted two times)

tempfile 	 full 
sa			`full'

	keep if dup == 1 															// Keep duplicates variables
	
	bys HHID: g order_dup = _n 													// Create duplicate order variable (doesn't really matter)

	preserve
	
		keep if order_dup == 2													// Keep second duplicates 
		
		local original_varname ""
		
		foreach var in varlist _all{											// Add suffix "_2" at the end of each variable name
		
			rename `var' *_2
			
			local original_varname "`original_varname' `var'"
			
		}
		
		rename HHID_2 HHID 
		
		tempfile 	 dup_2 				
		sa 			`dup_2'
		
	restore 
	
	merge 1:1 HHID using `dup_2'												// Merge each observation to its duplicate
	
	levelsof HHID, local dup_to_check 
	
	g diff_detected = 0
	
	foreach code of local dup_to_check{
		
		preserve 
		
		keep if HHID == `code'
		
		foreach var of local original_varname{
	
			assert `var' == `var'_2
			
				if _rc != 0{
				
					cap replace diff_detected = 1 if HHID == `code'
					
				}
				else{
				
					drop `var' `var'_2
					
				}
			
		}		
	}
	
	keep if diff_detected == 1 
	
	export excel using "$project_root/Cleaning/Cleaning_Issue_Tunisia_Entrepreneurship.xlsx", sheet("Duplicates Code", modify) modify
	
u `full', clear


* Duplicates in name ?

********************************************************************************
********************************************************************************
* 5) RECODE AND LABEL MISSING VARIABLES
********************************************************************************
********************************************************************************
/* 	Recode and label missing variables with special character based 
	on respondent answers (DK, RFS)
*/

	* Recode missing value with specical character 
	
foreach var of varlist _all { 													//loop over all variables
	capture confirm numeric variable `var' 										//check that a variable is numeric
		if !_rc{
			cap noi replace `var' =.w if `var'== -999 | `var' == -99 | `var' == -9		//don't want to say
			cap noi replace `var' =.k if `var'== -998 | `var' == -98 | `var' == -8 		//don't know
			cap noi replace `var' =.z if `var'== -997 | `var' == -97 | `var' == -7 		//not relevant / other exception
		}
}

********************************************************************************
********************************************************************************
* 6) DROP USELESS VARIABLES (Duration notes calculates)
********************************************************************************
********************************************************************************
/* 	Drop variables that only make sense for questionnaire review (duration, notes,
	calculates)
*/

* Add to local below useless variable 

local var_to_drop	calc_* time0 state_lab gender_lab a3 nb_5 note_014 randomdraw 		///
					lista survey_hh_date ra1 repeat_v1_count ra1_b randomdraw_b	 		///
					survey_hh_date_b randomdraw1 randomdraw_bc bc_selected 				///
					survey_date uniqueid deviceid subscriberid simid  					///
					caseid treatmentnew test_dup cal_b cal_b11 cal_b11_b cal_b_scores 	///
					e2_repeat_count
					
foreach var of local var_to_drop{

	cap drop `var'
	
}
		 

********************************************************************************
********************************************************************************
* 7) DE-IDENTIFY DATA 
********************************************************************************
********************************************************************************

* 1) Define variable to be drop (Add variable below to be dropped)

local deidentification 	


* 2) Drop ID variable 

foreach var of local deidentification {
	
	capture noisily drop `var' 													

}

* 3) Check for remaining PII variable 

foreach PII in name gps adress location sources phone{
	
	lookfor `PII'																// Search for possible variable to remove for deindetification purpose
	
	di in red "`r(varlist)'"
	
	* Drop variables 
	foreach var_to_drop in `r(varlist)'{
	
		cap noi drop `var_to_drop'
	
	}
}

********************************************************************************
********************************************************************************
* 8) TARGET NUMBERS 
********************************************************************************
********************************************************************************
/*	Test for target number: since surveys are submitted in daily waves, keep track of the 
	numbers of surveys submitted and the target number of surveys needed for an area to be
	completed.
*/

********************************************************************************
********************************************************************************
* 10) SAVE DATA
********************************************************************************
********************************************************************************


