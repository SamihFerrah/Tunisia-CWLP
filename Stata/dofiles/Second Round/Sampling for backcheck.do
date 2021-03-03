********************************************************************************
********************************************************************************
*						SAMPLE FOR BACKCHECK RESEARCH							
********************************************************************************
********************************************************************************
set seed 12272020
local date = c(current_date)

* Use full sample dataset

u "A:/Assignment/Full Sample.dta", clear

drop if replacement == 1

g Groupe = ""

	***************************************
	* Trt cash grant women and control TCLP
	***************************************
	
* Assign random number to cash grant treatment respondent and control TCLP

	g rand_trt_cash = runiform() if Intervention == "Cash Grants - Women" 
	
	sort rand_trt_cash, stable 
	
	xtile decile_1 = rand_trt_cash, nq(10)
	
	g 		qual_trt_cash = 0
	replace qual_trt_cash = 1 if Intervention == "Cash Grants - Women" & decile_1 ==1

	replace Groupe = "Cash Grant - Women" if qual_trt_cash == 1

	
	**************************
	* Follow up control TCLP
	**************************
	
* Assign random number to follow up sample respondents and control TCLP

	g rand_follow = runiform() if Intervention == "Follow up - TCLP" & replacement == 0
	
	sort rand_follow, stable 
	
	xtile decile_2 = rand_follow, nq(10)
	
	g 		qual_follow = 0
	replace qual_follow = 1 if Intervention == "Follow up - TCLP" & decile_2 ==1
	
	replace Groupe = "Follow up TCLP Control" if qual_follow == 1 
	
	
	**************************
	* Trt cash grant partner 
	**************************
	
* Assign random number to male partner of treatment participant

	g rand_trt_male = runiform() if Intervention == "Cash Grants - Partenaire"
	
	sort rand_trt_male, stable 
	
	xtile decile_3 = rand_trt_male, nq(10)
	
	g 		qual_trt_cash_p = 0
	replace qual_trt_cash_p = 1 if Intervention == "Cash Grants - Partenaire" & decile_3 == 1

	replace Groupe = "Cash Grant - Partner" if qual_trt_cash_p == 1

drop rand_* 

* Export selected sample 

keep if qual_trt_cash 		== 1 | /// 
		qual_follow	 		== 1 | ///
		qual_trt_cash_p 	== 1
		
sort Groupe

order Groupe HHID Gender Nom Age Imada Adresse imada CIN Father Intervention Partenaire_Nom Telephone1 Telephone2


replace Gender 	= "Male"		 if Groupe == "Cash Grant - Partner"	
replace Nom 	= Partenaire_Nom if Groupe == "Cash Grant - Partner" & Nom == "" & Nom == "A completer"
replace CIN 	= "" 			 if Groupe == "Cash Grant - Partner"
replace Father 	= ""			 if Groupe == "Cash Grant - Partner" 

keep Groupe HHID Gender Nom Age Imada Adresse imada Telephone1 Telephone2

g hhid = HHID 

sa 					"A:/Assignment/Backcheck/Liste Backcheck.dta", replace 

**********************************
* EXPORT CSV TO BE PRELOADED
**********************************

* Use cleandata 

u "B:/clean/clean_CashXFollow_PII.dta", clear

keep if tot_complete == 1 

keep hhid a1_enumerator today a1_respondentage a1_respondentname a1_phonerespond Partenaire_Nom

rename a1_phonerespond New_Phone

* Merge with clean data to flag respondent already surveyed

merge m:1 hhid using "A:/Assignment/Backcheck/Liste Backcheck.dta", keep (2 3)

g 		Surveyed = "Oui" if _merge == 3
replace Surveyed = "Non" if _merge == 2

replace Nom 		= Partenaire_Nom   	if Groupe == "Cash Grant - Partner" & Nom == ""
replace Nom 		= a1_respondentname if Nom == "" 

drop HHID 

keep Groupe hhid Gender Nom Age Imada Adresse Telephone1 Telephone2 today a1_enumerator Surveyed New_Phone

export delimited using "A:/Assignment/Backcheck/backcheck_data.csv", replace 

drop today a1_enumerator

sort Groupe

keep Groupe hhid Surveyed Gender Nom Imada Adresse New_Phone Telephone1 Telephone2

order Groupe hhid Surveyed Gender Nom Imada Adresse New_Phone Telephone1 Telephone2

sort Groupe Surveyed

export excel using "A:/Assignment/Backcheck/Liste Backcheck `date'.xlsx", first(var) replace

