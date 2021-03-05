********************************************************************************
********************************************************************************
*					CREATE ATTRITION INDICATOR AND REASON
********************************************************************************
********************************************************************************

preserve 

	import excel using "$shared/Daily Report/Update BJKA.xlsx", clear first 
	
	drop if HHID == . 
	
	drop if _n > 4200
	
	replace Status = "1" if Status =="Anciens codes 33"
	
	cap confirm numeric variable Status

	if _rc !=0{
		
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
					33 "Absent of dataset"
					
	label value Status A
	
	keep Status HHID Nom Intervention H
	
	rename H Treatment 
	
	g 		trt_cash = 0 if Intervention == "Cash Grants - Women"
	replace trt_cash = 1 if Intervention == "Cash Grants - Women" & Treatment == "Treatment"

	merge 1:1 HHID using "A:/Assignment/Follow Up Sample.dta",keepusing(TCLP replacement)
	
	g 		trt_followup = 0 if Intervention == "Follow up - TCLP"
	replace trt_followup = 1 if Intervention == "Follow up - TCLP" & TCLP == "Oui"
	
	drop _merge
	
	tempfile completion
	sa 		`completion'
	
restore 

cap drop _merge 

merge m:1 HHID using `completion', update 

g 		attrition = 0 
replace attrition = 1 if _merge == 2 & replacement == 0 

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

gen 	Abroad = 0 
replace Abroad = 1 		if Status == 6

gen 	Moved = 0 
replace Moved = 1 		if Status == 7 

g 		Inexistant = 0
replace Inexistant = 1 	if Status == 9

foreach reason in Refusal Dead Abroad Moved Inexistant{

	sum `reason' if trt_cash == 0 & Intervention == "Cash Grants - Women"
	sum `reason' if trt_cash == 1 & Intervention == "Cash Grants - Women"
	
	reg `reason' trt_cash, robust
	
}

foreach reason in Refusal Dead Abroad Moved Inexistant{

	sum `reason' if trt_followup == 0 & Intervention == "Follow up - TCLP"
	sum `reason' if trt_followup == 1 & Intervention == "Follow up - TCLP"
	
	reg `reason' trt_followup, robust
	
}





