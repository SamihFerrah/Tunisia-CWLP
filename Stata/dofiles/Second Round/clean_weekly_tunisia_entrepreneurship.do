********************************************************************************
********************************************************************************
*				TUNISIA IE ENTREPENEURSHIP CLEANING 						   *
********************************************************************************
********************************************************************************
/* 
Add enumerators check for productivity 

*/

u "$home/14. Female Entrepreneurship Add on/Data/Second Round/tempdata/clean_import_CashXFollow.dta", clear


********************************************************************************
********************************************************************************
* 1) TARGET NUMBERS 
********************************************************************************
********************************************************************************

/*	Test for target number: since surveys are submitted in daily waves, keep track of the 
	numbers of surveys submitted and the target number of surveys needed for an area to be
	completed.
*/

use "$home/14. Female Entrepreneurship Add on/Survey material/Assignment/Full Sample.dta"

keep hhid Intervention Status

* Count number of respondent per sample 

	* Cash Grant Control 
	
	count if Intervention == "Cash Grants - Women" & Status == "Control"
	
	local control_women = `r(N)'
	
	* Cash Grant Treatment 
	
	count if Intervention == "Cash Grants - Women" & Status == "Treatment"
	
	local treatment_women = `r(N)'
	
	* Cash Grant Partenaire 
	
	count if Intervention == "Cash Grants - Partenaire"
	
	local partenaire = `r(N)'
	
	* Follow up
	
	count if Intervention == "Follow up - TCLP" & replacement == "Non Replacement"
	
	local follow_up = `r(N)'
	
	u "$home/14. Female Entrepreneurship Add on/Data/Second Round/tempdata/clean_CashXFollow_noPII.dta", clear

	* Cash Grant Control

	count if Intervention == "Cash Grants - Women" & Status == "Control"

	local control_women_did = `r(N)'

	* Cash Grant Treatment

	count if Intervention == "Cash Grants - Women" & Status == "Treatment"

	local treatment_women_did = `r(N)'

	* Cash Grant Partners

	count if Intervention == "Cash Grants - Partenaire"

	local partenaire_did = `r(N)'

	* Follow Up 

	count if Intervention == "Follow up - TCLP" & replacement == "Non Replacement"

	local follow_up_did = `r(N)'

	
	* Write completion results in Excel
	
	putexcel set "$shared/HFC/Tunisia_IE_HFC_Report.xlsx", sheet("Progress", modify)

	putexcel A2 = "Sample"
	
	putexcel A3 = "Cash Grant - Control"
	putexcel A4 = "Cash Grant - Treatment"
	putexcel A5 = "Cash Grant - Partenaire"
	putexcel A6 = "Follow Up"
	
	putexcel B2 = "Cible"
	
	putexcel B3 = "`control_women''"
	putexcel B4 = "`treatment_women'"
	putexcel B5 = "`partenaire'"
	putexcel B6 = "`follow_up'"
	
	putexcel C2 = "Done"
	
	putexcel C3 = "`control_women_did''"
	putexcel C4 = "`treatment_women_did'"
	putexcel C5 = "`partenaire_did'"
	putexcel C6 = "`follow_up_did'"
	
	
********************************************************************************
********************************************************************************
* 2) Enumerator productivity
********************************************************************************
********************************************************************************

u "$home/14. Female Entrepreneurship Add on/Data/Second Round/tempdata/clean_CashXFollow_noPII.dta", clear

* Create indicator to count number of survey per enumerators 

	g count_survey = 1 
	
	g count_survey_cash = 1  if Intervention == "Cash Grants - Women"
	g count_survey_part = 1  if Intervention == "Cash Grants - Partenaire"
	g count_survey_tclp = 1  if Intervention == "Follow up - TCLP"
	
* Compute duration of survey per enumerator 

	g duration =
	
	egen pc90 = pctile(duration), p(90) 
	
	g 		flag_p90 = 0 
	replace flag_p90 = 1 if duration > pc90 & duration !=.
	
	label var flag_p90 "Survey too long"
	
* Create stat per enumerators and per day 

collapse (sum) count_survey* flag_p90 (mean) duration by(enumerator date)

sort enumerator date 

rename count_survey 		#Survey
rename count_survey_cash 	#Survey_Cash
rename count_survey_part 	#Survey_Partenaire
rename count_survey_tclp 	#Survey_TCLP

export excel "$shared/HFC/Tunisia_IE_HFC_Report.xlsx", sheet("Enqueteur", modify)


********************************************************************************
********************************************************************************
* 3) Survey Duration
********************************************************************************
********************************************************************************

u "$home/14. Female Entrepreneurship Add on/Data/Second Round/tempdata/clean_CashXFollow_noPII.dta", clear

local main_module 


foreach module of local main_module{
	
	* Compute duration of survey per enumerator 

		g duration_`module' =
		
		label var duration_`module' "Duration `module'"
	
}
		
* Create stat per enumerators and per day 

collapse (mean) duration_*


export excel "$shared/HFC/Tunisia_IE_HFC_Report.xlsx", sheet("Duration", modify)

********************************************************************************
********************************************************************************
* 4) Missingness, DK, RFS etc...
********************************************************************************
********************************************************************************


********************************************************************************
********************************************************************************
* 2) TEST ANSWERS CONSISTENCY 
********************************************************************************
********************************************************************************
/* 	Checking for variable consistency means to check that answer makes sense based on
	other questions. If the survey is well constructed (constraints and requirement) this
	should not be an issue, but it’s always better to check.
	Example : Does the 12 years old respondents have children and is so how many ?
*/


********************************************************************************
********************************************************************************
* 5) IDENTIFY AND DOCUMENT OUTLIERS
********************************************************************************
********************************************************************************
/*	An outliers is an observations far away from the mean of the sample. For example,
	someone would report an age of 99 years old when the average is 20. There isn’t a rule
	to check for outliers, some will consider an outlier as an observations superior 
	to 2.2 times the absolut standard deviation, some 1.8. 
	As for the variable consistency, checkking for outliers depends on the construction 
	of the survey, and because of the constraints it makes sense to check only 
	for integer (no categorical variable) and unbounded one.
*/

	// Here needs to correct for previous outliers 
	
	do "$root/dofiles/outliers_correction.do"

	sa "$root/tempdata/temp_outliers_CashXFollow.dta.dta"
	
	****************************************************************************
	****************************************************************************
	* 0) Define unbounded data --> integer not dummie 
	****************************************************************************
	****************************************************************************

		// 1) Import form information
		
		import excel using "$home/Survey Instrument/DIME_Tunisia_entrepreneurship_10122020.xlsx", clear first											// lAst version of the form
		
		// 2) Keep unbounded variable i.e type == integer
		keep name type constraint
		keep if type =="integer"  // & constraint ==""

		// 3) Create local storing name of unbounded variable 
		local check_outliers "" 
		
		levelsof name, local(check)
		foreach x of local check{
		local check_outliers "`check_outliers' `x'"
		} 
		
		local check_outliers = strlower("`check_outliers'")
		// 4) Display list of variable stored in the local 

		display in red "`check_outliers'"
		
	****************************************************************************
	****************************************************************************
	* 1) Flag outliers (define as having an absolute difference of 2 sd from mean)
	****************************************************************************
	****************************************************************************
	
	foreach var of local `check_outliers'{
	
		g flag_outliers_max_`var' =. 
		g flag_outliers_min_`var' =.
	
		sum `var'
		
		replace flag_outliers_max_`var' = 1 if `var' > `r(mean)' + 	2*`r(sd)' & `var' !=. 
		replace flag_outliers_min_`var' = 1 if `var' < `r(mean)' + 	2*`r(sd)' & `var' !=. 
	
	}
	
	****************************************************************************
	****************************************************************************
	* 2) Export list of outliers
	****************************************************************************
	****************************************************************************
	
	foreach i of local a1_enum {												// Loop over each enumerators 
	
	local dailyhfc "$home/Data/Second round/outputs/Cleaning/Outliers.csv"		// Define local to export outliers report
	
	use "$root/tempdata/temp_outliers_CashXFollow.dta.dta", clear				// Use clean data

	* Generate comment variable
	gen comment = ""
	
	keep if enumerator == "`i'" 												//	Keep for each enumerator
	
	count
	
	if `r(N)' > 0 {
		
		local qq = `qq'+1 
		
		* 0. List enumerator name
		
		if `qq'==1 {
		
			listtab enumerator using "`dailyhfc'" if _n == 1 & today>= $hfc_panel_start , delimiter(",") replace headlines("" "Nom de l'enqueteur:") headchars(charname)
		
		}
		
		if `qq'>1 {
		
			listtab comment 	if _n ==1 	& today>= $hfc_panel_start , delimiter(",") replace appendto(`dailyhfc') headlines("" "") headchars(charname)
			listtab enumerator 	if _n == 1 	& today>= $hfc_panel_start , delimiter(",") replace appendto(`dailyhfc') headlines("" "Nom de l'enqueteur:") headchars(charname)
		}

		* 1. count number of surveys collected
		
		bys enumerator : gen count = _N
		listtab count if _n == 1 & today>= $hfc_panel_start , delimiter(",") replace appendto(`dailyhfc') headlines("" "Tous les sondages faits:") headchars(charname)
		
		* 3. Check for outliers

		cap drop flag_outlier
		
		gen flag_outlier	=	0
				
			foreach x in 1.8 { 													// This means that "outliers" are anything that is more than 1.8 SDs from the mean
			
				foreach var of local check_outliers {
				
					di "`var'"
					
					count if `var'!=.
					
					if `r(N)'>0 {
						
						local l_`var' : variable label `var'					// Store variable labels
						
					
						preserve
						
							use "$root/tempdata/temp_outliers_CashXFollow.dta.dta", clear					// Use clean data
							quietly: sum `var'																// Summarize variable
							local vmean = `r(mean)'															// Store mean
							local vsd = `r(sd)'																// Store standard error
							
						restore
						
						gen mean 	= `vmean'
						gen sd 		= `vsd'
						
						generate sds = (`var'-mean) / sd
						
						format mean sd sds %12.4f
						
						sort `idvar'
						
						foreach var2 of varlist `var' mean sd sds {
						
							char `var2'[charname] "`var2'"
						}
						
						count if today >= $hfc_panel_start & abs(sds) > `x' & !missing(sds)
						
						if `r(N)'>0 {
							listtab $enum_info $info `var' mean Contact1 Contact2 comment if abs(sds) > `x' & !missing(sds) & today>=$hfc_panel_start, delimiter(",") replace appendto(`dailyhfc') headlines("" "`var':, `l_`var''") headchars(charname)
						}
						
						replace flag_outlier = 1 if abs(sds) > `x' & !missing(sds)
						
						drop mean sd sds
						
						}														// Condition for # survey of each nums (second one)
					}															// Loop over each outliers 
				}																// Loop over outliers threshold
			}																	// Condition for # of survey of each enums
		}																		// Close enumerator loop
		
		drop flag_outlier
			
	
********************************************************************************
********************************************************************************
* 4) CATEGORIZE VARIABLE LISTED AS OTHERS 
********************************************************************************
********************************************************************************
/*	For every variable with “other” as a choices, check what are the choices and 
	if one answer is frequently given create a new value for the variable, replace 
	it if “other” correspond to it and label the value accordingly.	
*/


********************************************************************************
********************************************************************************
* 4) TARGET NUMBERS 
********************************************************************************
********************************************************************************
/*	Test for target number: since surveys are submitted in daily waves, keep track of the 
	numbers of surveys submitted and the target number of surveys needed for an area to be
	completed.
*/



********************************************************************************
********************************************************************************
* 5) EXPORT DAILY FIELD REPORT FOR FIELD TEAM TO CORRECT FOR ISSUE
********************************************************************************
********************************************************************************



