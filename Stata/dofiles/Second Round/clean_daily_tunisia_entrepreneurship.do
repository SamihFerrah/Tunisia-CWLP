********************************************************************************
********************************************************************************
*				TUNISIA IE ENTREPENEURSHIP CLEANING 						   *
********************************************************************************
********************************************************************************
local date = c(current_date)


u "$vera/temp/temp_import_CashXFollow.dta", clear 

* Create special variable to merge 
 
g HHID = hhid 

merge m:1 HHID using "A:/Assignment/Full Sample.dta", keep(1 3) keepusing(Status Intervention trt_followup replacement Partenaire ID_HH2 Partenaire_Nom CIN) update

drop _merge 

g 		trt_cash = 0 if Intervention == "Cash Grants - Women"
replace trt_cash = 1 if Intervention == "Cash Grants - Women" & Status == "Treatment"

g 		trt_cash_0 = 0 if Intervention == "Cash Grants - Women"
replace trt_cash_0 = 1 if Intervention == "Cash Grants - Women" & Status == "Treatment" & Partenaire == "Non"

g 		trt_cash_1 = 0 if Intervention == "Cash Grants - Women"
replace trt_cash_1 = 1 if Intervention == "Cash Grants - Women" & Status == "Treatment" & Partenaire == "Oui"


label var trt_cash	 "Cash Grant Treatment (Partenaire == 0)"
label var trt_cash_0 "Cash Grant Treatment (Partenaire == 0)"
label var trt_cash_1 "Cash Grant Treatment (Partenaire == 1)"
	
rename imada imada_endline 

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
* 4) Get treatment status of partner (0 = no participation to financial training)
********************************************************************************
********************************************************************************

preserve 

	keep if Intervention == "Cash Grants - Women" & Status == "Treatment"
	
	keep if ID_HH2 !=. 
	
	keep trt_cash_0 trt_cash_1 ID_HH2
	
	duplicates drop 

	rename trt_cash_0 trt_cash_part_0
	rename trt_cash_1 trt_cash_part_1
	
	tempfile partner_trt
	sa 		`partner_trt'
	
restore 

merge m:1 ID_HH2 using `partner_trt'

replace trt_cash_part_1 = . if Intervention != "Cash Grants - Partenaire"

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
* 4) CHECK THAT WE HAVE ALL THE DATA OF THE DAY 
********************************************************************************
********************************************************************************
/* 	Test that all data from the field is on the server: match survey data logs from the
	field with survey data logs on the server to confirm that all the data from the 
	field has been transferred to the server. 
*/

preserve 

	* Import daily report 
	
	import excel using "$shared/Daily Report/Update BJKA.xlsx", clear first 
	
	drop if HHID == .
	
	cap replace Status = "999" if Status ==" "
	cap replace Status = ""	   if Status == "Rendez vous cette semaine"
	cap replace Status = 10 if Status == 100
	
	destring Status, replace

	label define A 	1 "Completed" 					///
					4 "Refusal"						///
					5 "Dead"						///
					6 "Abroad"						///
					7 "Other region"				///
					9 "Doesn't exist"				///
					10 "Other"						///
					12 "Replacement not used"		///
					13 "Transfered to other team"	///
					33 "Absent of dataset"			///
					99 "Unreachable (other region)" ///
					999 "Never contacted"
					
	label value Status A
	
	cap confirm numeric variable Status

	if _rc !=0{
		
		replace Status = subinstr(Status," ","",.)
		
	}
	
	destring Status, replace 
	
	* Keep last days of data collection 
	*keep if Status == 1	| Status == 33 											// Keep completed survey
	
	*replace Status = 1 
		
	rename Status 	Etat
	rename Date 	Date_complete
	
	keep HHID Etat Date_complete Nom Intervention Telephone1 Telephone2 Nom
	
	rename Intervention Inter
	
	* Create temperoray file 
	tempfile daily_completion
	sa   	`daily_completion'
	
restore

cap drop _merge 

* Merge data with completion report 
merge m:1 HHID using `daily_completion'

* Correct BJKA entry error 
replace Etat = 1 if _merge == 3 

* Create indicator for missing survey
g 		missing_survey = 0 
replace missing_survey = 1 if _merge == 2 & (Etat == 1 | Etat == 33)

label var missing_survey "Missing survey"

* Create indicator for survey outside of report
g 		outside_report = 0
replace outside_report = 1 if _merge == 1 & tot_complete == 1 

label var outside_report "Absent from report"

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
	
	keep HHID Nom Description Date_Sondage Date_complete Etat Telephone1 Telephone2
	
	order Date_Sondage Date_complete HHID Nom Description
	
	sort Date_Sondage Description 
	* Export to excel
	
	export excel using "$shared/Daily Report/Update BJKA.xlsx", sheet("Probleme Completion", replace) first(var)
	
restore 
	
drop if _merge == 2 

cap drop _merge 
********************************************************************************
********************************************************************************
* 5) ERROR IN CODE
********************************************************************************
********************************************************************************

/*	Test for error in code: Use the original assignement list to compare original code and 
							and code enter by the enumerator
*/

* Merge and check that code correspond to the original assignment
cap drop _merge 

cap destring Age Telephone1 Telephone2, replace 

merge m:1 HHID using "A:/Assignment/Full Sample.dta", gen(code_check) keep(1 3) keepusing(HHID)

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
* 6) DUPLICATE TEST
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

keep if dup > 0 & dup !=.

count

if `r(N)' > 0{

keep HHID a1_enumerator Nom a1_respondentname a1_respondentname_corr a1_date imada_endline psu key
sort HHID 
order HHID a1_enumerator Nom a1_respondentname a1_respondentname_corr a1_date imada_endline psu key


	export excel using "$shared/Data Cleaning/Cleaning_Issue_Tunisia_Entrepreneurship.xlsx", sheet("Duplicates Code", replace) first(var)

}

restore


* Duplicates in name ?


* Destring data 
destring _all, replace 

do "$git_tunisia/dofiles/Second round/Construct/label_variables.do"


********************************************************************************
********************************************************************************
* 7) Add common ID_HH (= HOUSEHOLD ID) for partner and cash grants participant
********************************************************************************

* Import HH ID (for cash grant and partner)

preserve 

	import excel using "$home/14. Female Entrepreneurship Add on/Data/General/ID Cash HH.xlsx", clear first
	
	tempfile ID_HHH
	sa 	    `ID_HHH'
	
restore 

cap drop _merge 

merge m:1 HHID using `ID_HHH', update keep(1 3)

drop _merge

* Create dummie variable to flag respondent for which we survey both 
* female and male partner_only

duplicates tag ID_HH if ID_HH !=. & tot_complete == 1, g(participant_partner)

label var participant_partner "Duo: participant x partner"

********************************************************************************
********************************************************************************
* 8) DROP USELESS VARIABLES (Duration notes calculates)
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
		 
drop Status 

********************************************************************************
********************************************************************************
* 9) Prepare outcomes by recoding variables
********************************************************************************
********************************************************************************

do "$git_tunisia/dofiles/Second round/Construct/recodedirection.do"


********************************************************************************
********************************************************************************
* 11) Create Attrition indicator
********************************************************************************
********************************************************************************

do "$git_tunisia/dofiles/Second round/Construct/Attrition Indicator.do"



********************************************************************************
********************************************************************************
* 10) Save temporary data with PII
********************************************************************************
********************************************************************************

sa "$vera/temp/clean_CashXFollow_PII_2.dta", replace 


********************************************************************************
********************************************************************************
* 12) Merge Baseline and Endline
********************************************************************************
********************************************************************************


do "$git_tunisia/dofiles/Second round/Construct/Merge Baseline Endline.do"

********************************************************************************
********************************************************************************
* 13) SAVE clean data  with PII
********************************************************************************
********************************************************************************

destring Strata, replace 

* Save data with PII 

sa "$vera/temp/clean_CashXFollow_PII_3.dta", replace 








