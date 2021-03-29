********************************************************************************
********************************************************************************
*					CREATE ATTRITION INDICATOR AND REASON
********************************************************************************
********************************************************************************

*****************************************************
* Merge with full sample to get attrition indicator
*****************************************************


cap destring Age Telephone*, replace 

drop HHID 

rename hhid HHID 

preserve 

	u "A:/Assignment/Full Sample.dta", clear 
		
	g 		trt_cash = 0 if Intervention == "Cash Grants - Women"
	replace trt_cash = 1 if Intervention == "Cash Grants - Women" & Status == "Treatment"

	g 		trt_cash_0 = 0 if Intervention == "Cash Grants - Women"
	replace trt_cash_0 = 1 if Intervention == "Cash Grants - Women" & Status == "Treatment" & Partenaire == "Non"

	g 		trt_cash_1 = 0 if Intervention == "Cash Grants - Women"
	replace trt_cash_1 = 1 if Intervention == "Cash Grants - Women" & Status == "Treatment" & Partenaire == "Oui"

	label var trt_cash	 "Cash Grant Treatment (Partenaire == 0)"
	label var trt_cash_0 "Cash Grant Treatment (Partenaire == 0)"
	label var trt_cash_1 "Cash Grant Treatment (Partenaire == 1)"
	
	replace trt_cash_1 = . if trt_cash_0 == 1
	replace trt_cash_0 = . if trt_cash_1 == 1

	keep Intervention replacement Partenaire trt_followup HHID Strata trt_cash*

	tempfile full 
	sa 		`full'

restore


merge m:1 HHID using `full', gen(_merge2) update

drop if Intervention ==""														// Not sure why but 100 observations with missing 

g 		attrition = 0 
replace attrition = 1 if _merge2 == 2


**********************************************
* Get attrition reason from BJKA reports 
**********************************************

preserve 

	import excel using "$shared/Daily Report/Update BJKA.xlsx", clear first 
	
	drop if HHID == . 
	
	drop if _n > 4201
		
	cap confirm numeric variable Status

	if _rc !=0{
		
		replace Status = ""	   if Status == "Rendez vous cette semaine"
		replace Status = subinstr(Status," ","",.)
		
	}
	
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
					99 "Unreachable (moved)"		///
					999 "Never contacted"
					
	label value Status A
	
	keep Status HHID Nom Intervention H
	
	*rename H Treatment 

	merge 1:1 HHID using "A:/Assignment/Follow Up Sample.dta",keepusing(TCLP replacement)
	
	drop _merge
	
	keep Status HHID Nom Intervention TCLP
	
	tempfile completion
	sa 		`completion'
	
restore 

cap drop _merge Status

merge m:1 HHID using `completion', update 

drop if _merge == 2

* Check Status of _merge == 3

tab Status if _merge == 3

* Check Status of _merge == 2

tab Status if _merge == 2

* Check Status of replacement 

tab replacement if _merge == 3 

* Drop replacement not used 

drop if replacement == 0 & _merge == 2

* Check code and Names of _merge == 1

gen 	Refusal = 0
replace Refusal = 1 	if Status == 4

gen 	Dead = 0 
replace Dead = 1 		if Status == 5

gen 	Moved = 0 
replace Moved = 1 		if Status == 7 | Status == 6 | Status == 9 

g 		Other = 0 
replace Other = 1 		if Status == 10 | Status == .







