********************************************************************************
********************************************************************************
*				TUNISIA IE ENTREPENEURSHIP CLEANING 						   *
********************************************************************************
********************************************************************************
local date = c(current_date)


u "$vera/temp/temp_import_CashXFollow.dta", clear 

* Create special variable to merge 
 
g HHID = hhid 

merge m:1 HHID using "A:/Assignment/Full Sample.dta", keep(1 3) keepusing(Status Intervention trt_followup)

drop _merge 

********************************************************************************
********************************************************************************
* 2) CHECK THAT ALL SURVEY SUBMITTED ARE COMLETED 
********************************************************************************
********************************************************************************
/* 	Define indicator for survey completeness, often the last variables mandatory
	for all respondent not being missing
*/

* Generate indicator for completed survey 

g 		tot_complete = 0 
replace tot_complete = 1 if trauma_cauchemars 	!=. & 	Intervention == "Cash Grants - Women" | ///
														Intervention == "Follow up - TCLP"
														
replace tot_complete = 1 if x9_109 				!=. & 	Intervention == "Cash Grants - Partenaire"

cap format submissiondate  %tcDDmonCCYY
if _rc == 0{
    
	gen date = dofc(submissiondate) 
	
	format date %td

}
else{
    
	split submissiondate,parse(" ") g(date_tmp)
	
	g 		date_tmp12 = date_tmp1 if date_tmp2 == "déc."
	
	replace date_tmp12 = date_tmp1 if date_tmp2 =="févr."
	replace date_tmp12 = date_tmp1 if date_tmp2 =="janv."
	replace date_tmp1 = "Dec" if date_tmp2 =="déc."
	replace date_tmp1 = "Feb" if date_tmp2 =="févr."
	replace date_tmp1 = "Jan" if date_tmp2 =="janv."
	replace date_tmp2 = date_tmp12 +"," if date_tmp2 == "déc." 
	replace date_tmp2 = date_tmp12 +"," if date_tmp2 == "févr." 
	replace date_tmp2 = date_tmp12 +"," if date_tmp2 == "janv." 
	
	drop date_tmp12 
	
	replace submissiondate = date_tmp1+" "+date_tmp2 +date_tmp3 

	cap drop date_tmp* month_tmp day_tmp	
	
	rename submissiondate today_char
	
	gen today=date(today_char,"MDY",2017)
	
	format today %td
	
	label variable today "Date of interview"
}


********************************************************************************
********************************************************************************
* 3) APPLY CORRECTIONS FOR DUPLICATES OR ERROR IN CODE 
********************************************************************************
********************************************************************************
/* 	Run correction do-files in which we apply the different correction to keep this
	one clean from thousands line of correction
*/

do "$git_tunisia/dofiles/Second round/Corrections/duplicates_code_correction.do"
do "$git_tunisia/dofiles/Second round/Corrections/error_code_tunisia.do"



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
			cap noi replace `var' =.k if `var'== -999 | `var' == -99 | `var' == -9		//don't know
			cap noi replace `var' =.w if `var'== -998 | `var' == -98 | `var' == -8 		//refuse to say
			cap noi replace `var' =.z if `var'== -997 | `var' == -97 | `var' == -7 		//not relevant / other exception
		}
}

local partner_only x1_mgroles x1_mghome x1_mgkids x1_mgdecisions x1_mgrights1 x1_mgleader1 x1_mgleader2 	///
 x1_mgschlwork x1_mgill x1_mgopinion x1_mgpity x1_mgwork x1_mgedu x1_mgdomestic 		///
 x1_mgobey x1_mgspeak x1_mgcapacity x1_eduopp x1_boysfood x1_coupledu x1_leader3 		///
 x1_agreerole x1_mgrights2 x1_mgequality x1_mgfriends x1_mgfreetime_men 				///	
 x1_mg_freetime_women x1_mg_womenopi x1_mg_marry x1_participation x1_leader4			/// 
 x1_leader5 x1_leader6_1 x1_leader6_2 x1_leader6_3 x1_leader6_4 				///
 x1_leader6_5 x1_leader6_6 x1_leader6_7 x1_leader6_8 x1_leader6_9 x1_leader6_10 		///
 x1_leader7_1 x1_leader7_2 x1_leader7_3 x1_leader7_4 x1_leader7_5 			///
 x1_leader7_6 x1_leader7_7 x1_leader7_8 x1_leader7_9 x1_leader7_10 x1_leader9 			///
 x1_leader10 x1_participation2 x1_participation3 x2_hwviolenceintro x2_hwtolerate		///
 x2_goesout x2_refuseshave x2_burnsf x2_arguesshe x2_refusescook 			///
 x2_doesinfid x2_contraceptive x2_drinksalcohol x2_refusesclean x2_dowry			/// 
  x6_sxtalk x6_sxready x6_gay x6_friend x7_tough x7_insult 		///
 x8_pregn x8_contra x8_suggcontr x8_childresp x8_fatherchild x8_childdeci x8_contratype

 
foreach var of local partner_only {
	
	replace `var' = .a if Intervention != "Cash Grants - Partenaire"
	
}

********************************************************************************
********************************************************************************
* 1) CHECK THAT WE HAVE ALL THE DATA OF THE DAY 
********************************************************************************
********************************************************************************
/* 	Test that all data from the field is on the server: match survey data logs from the
	field with survey data logs on the server to confirm that all the data from the 
	field has been transferred to the server. 
*/

preserve 

	* Import daily report 
	
	import excel using "$shared/Daily Report/Update BJKA.xlsx", clear first 
	
	cap confirm numeric variable Status

	if _rc !=0{
		
		replace Status = subinstr(Status," ","",.)
		
	}
	
	destring Status, replace 
	
	* Keep last days of data collection 
	keep if Status == 1															// Keep completed survey
	
	rename HHID 	hhid
	rename Status 	Etat
	rename Date 	Date_complete
	
	keep if Etat == 1 
	
	* Create temperoray file 
	tempfile daily_completion
	sa   	`daily_completion'
	
restore

cap drop _merge 

* Merge data with completion report 
merge m:1 hhid using `daily_completion'

* Create indicator for missing survey
g 		missing_survey = 0 
replace missing_survey = 1 if _merge == 2 

label var missing_survey "Missing survey"

* Create indicator for survey outside of report
g 		outside_report = 0
replace outside_report = 1 if _merge == 1 & tot_complete == 1 

label var outside_report "Absent from report"

cap drop _merge 

* Export results for BJKA 

preserve 
	
	* Keep instances with issues 
	keep if missing_survey == 1 | outside_report == 1 | tot_complete == 0 
	
	* Code to string 
	g 		description = "Absent de la base mais signale comme complete" 		if missing_survey == 1
	replace description = "Dans la base mais pas dans le rapport "				if outside_report == 1 
	replace description = "Sondage incomplet" 									if tot_complete == 0 
	
	rename a1_date 		Date_Sondage
	rename description 	Description
	
	keep hhid Description Date_Sondage Date_complete
	
	order Date_Sondage Date_complete hhid Description
	
	sort Date_Sondage Description
	* Export to excel
	
	export excel using "$shared/Daily Report/Update BJKA.xlsx", sheet("Probleme Completion", replace) first(var)
	
restore 
	
replace tot_complete = 0 if missing_survey == 1 

********************************************************************************
********************************************************************************
* 4) ERROR IN CODE
********************************************************************************
********************************************************************************

/*	Test for error in code: Use the original assignement list to compare original code and 
							and code enter by the enumerator
*/

* Merge and check that code correspond to the original assignment
cap drop _merge 

merge m:1 HHID using "A:/Assignment/Full Sample.dta", gen(code_check) keep(1 3)

g 		error_code = 0 
replace error_code = 1 if code_check ==1
											// If code only in master then error in code

drop code_check 

count if error_code ==1 

if `r(N)' > 0 {

	preserve 
		
		keep if error_code == 1 
		 
		sort today today  
		 
		keep 	HHID a1_date a1_enumerator Nom 
		order 	HHID a1_date a1_enumerator Nom 
		
		rename 	(HHID a1_date a1_enumerator Nom ) ///
				(Faux_Code Date Enqueteur Nom)
				
		export excel using "$shared/Data Cleaning/Cleaning_Issue_Tunisia_Entrepreneurship.xlsx", sheet("Error Code", replace) first(var)
		
	restore
}

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

preserve
keep if dup > 0 

keep hhid a1_enumerator Nom a1_respondentname a1_respondentname_corr a1_date 
sort hhid 
order hhid a1_enumerator Nom a1_respondentname a1_respondentname_corr a1_date

	export excel using "$shared/Data Cleaning/Cleaning_Issue_Tunisia_Entrepreneurship.xlsx", sheet("Duplicates Code", replace) first(var)

	restore

* Duplicates in name ?


* Destring data 
destring _all, replace 

do "$git_tunisia/dofiles/Second round/Construct/label_variables.do"


********************************************************************************
********************************************************************************
* 6) DROP USELESS VARIABLES (Duration notes calculates)
********************************************************************************
********************************************************************************
/* 	Drop variables that only make sense for questionnaire review (duration, notes,
	calculates)
*/

* Add to local below useless variable 

local var_to_drop ""
					
foreach var of local var_to_drop{

	cap drop `var'
	
}
		 
* Save data with PII 

sa "$vera/clean/clean_CashXFollow_PII.dta", replace 

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

/*
foreach PII in name gps adress location phone{
	
	lookfor `PII'																// Search for possible variable to remove for deindetification purpose
	
	di in red "`r(varlist)'"
	
	* Drop variables 
	foreach var_to_drop in `r(varlist)'{
	
		cap noi drop `var_to_drop'
	
	}
}

*/

* Drop PII
drop username calc_name complete_name a1_respondentname confirm_name a1_respondentname_corr Nom Father devicephonenum Telephone1 Telephone2

********************************************************************************
********************************************************************************
* 8) SAVE DATA
********************************************************************************
********************************************************************************

sa "$home/14. Female Entrepreneurship Add on/Data/Second Round/cleandata/clean_CashXFollow_noPII.dta", replace

	
********************************************************************************
********************************************************************************
* 9) Export Missingness report
********************************************************************************
********************************************************************************

do "$git_tunisia/dofiles/Second Round/Analysis/Missingness Report.do"			// Import and do basic check before saving data
	
	
********************************************************************************
********************************************************************************
* 10) Export Data quality report
********************************************************************************
********************************************************************************

do "$git_tunisia/dofiles/Second Round/Analysis/Statistics.do"			// Import and do basic check before saving data
	
	
	





