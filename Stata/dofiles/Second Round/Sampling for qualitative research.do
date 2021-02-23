********************************************************************************
********************************************************************************
*						SAMPLE FOR QUALITATIVE RESEARCH							
********************************************************************************
********************************************************************************
set seed 12272020
local date = c(current_date)
pause on 

u "A:/Assignment/Full sample.dta", clear

drop Partenaire

g Groupe 			= ""
g Replacement   	= "Non"
g Ordre_Replacement = .

cap drop _merge 

/*
* Fill in information with one completed during endline

replace Nom 			= a1_respondentname if a1_respondentname 	!= ""
replace Telephone1 		= a1_phonerespond	if a1_phonerespond 		!=.
replace Partenaire_Nom 	= Nom 				if Partenaire_Nom == "" &Nom != ""
*/

* Import HH ID (for cash grant and partner)

preserve 

	import excel using "$home/14. Female Entrepreneurship Add on/Data/General/ID Cash HH.xlsx", clear first
	
	tempfile ID_HHH
	sa 	    `ID_HHH'
	
restore 

merge 1:1 HHID using `ID_HHH', update

cap drop _merge 

* Keep subset of 20 imadas 

tempfile full 
sa 		`full'

	set seed 12272020
	
	keep imada

	duplicates drop 

	g rand_imada = runiform()

	sort rand_imada, stable 

	keep if _n < 21

	keep imada
	
	tempfile imada_list
	sa 		`imada_list'

	decode imada, g(Imada)
	
	tab Imada
	
	pause
	
	drop imada
	
	export excel using "A:/Assignment/Qualitative Research/Liste Imada.xlsx", replace firstrow(var)
	
u `full', clear 

merge m:1 imada using `imada_list', keep(3)

cap drop _merge 


	***************************************
	* Trt cash grant women and control TCLP
	***************************************
	
* Assign random number to cash grant treatment respondent and control TCLP

	set seed 12272020
	
	g rand_trt_cash_0 = runiform() if Intervention == "Cash Grants - Women" & Status == "Treatment" & beneficiaire == 0 
	
	sort rand_trt_cash_0, stable 
	
	g 		qual_trt_cash_0 = 0
	replace qual_trt_cash_0 = 1 if Intervention == "Cash Grants - Women" & Status == "Treatment" & _n <=18

	pause
	
	replace Groupe = "Cash Grant Treatment & Control TCLP" 				 if qual_trt_cash_0 == 1 & _n <= 10 
	replace Groupe = "Cash Grant Treatment & Control TCLP - Replacement" if qual_trt_cash_0 == 1 & _n >  10 
	
	replace Replacement = "Oui" if qual_trt_cash_0 == 1 & _n >  10 
	
	tab HHID if Intervention == "Cash Grants - Women" & Status == "Treatment" & _n <=18
	
	pause
	*****************************************
	* Trt cash grant women and treatment TCLP
	*****************************************
	
* Assign random number to cash grant treatment respondent and treatment TCLP

	set seed 12272020
	
	g rand_trt_cash_1 = runiform() if Intervention == "Cash Grants - Women" & Status == "Treatment" & beneficiaire == 1
	
	sort rand_trt_cash_1, stable 
	
	g 		qual_trt_cash_1 = 0
	replace qual_trt_cash_1 = 1 if Intervention == "Cash Grants - Women" & Status == "Treatment" & _n <=18
	
	replace Groupe = "Cash Grant Treatment & Treatment TCLP" 				if qual_trt_cash_1 == 1 & _n <= 10
	replace Groupe = "Cash Grant Treatment & Treatment TCLP - Replacement"  if qual_trt_cash_1 == 1 & _n >  10
	
	replace Replacement = "Oui" if qual_trt_cash_1 == 1 & _n >  10 

		
	****************************************
	* Ctr cash grant women and control TCLP
	****************************************
	
* Assign random number to cash grant control respondent and control TCLP 

	set seed 12272020
	
	g rand_ctr_cash_0 = runiform() if Intervention == "Cash Grants - Women" & Status == "Control" & beneficiaire == 0 
	
	sort rand_ctr_cash_0, stable 
	
	g 		qual_crt_cash_0 = 0
	replace qual_crt_cash_0 = 1 if Intervention == "Cash Grants - Women" & Status == "Control" & _n <=9

	replace Groupe = "Cash Grant Control & Control TCLP" 					if qual_crt_cash_0 == 1 & _n <= 5
	replace Groupe = "Cash Grant Control & Control TCLP - Replacement"  	if qual_crt_cash_0 == 1 & _n >  5
	
	replace Replacement = "Oui" if qual_crt_cash_0 == 1 & _n >  5
	
	*****************************************
	* Ctr cash grant women and treatment TCLP
	*****************************************
	
* Assign random number to cash grant control respondent and treatment TCLP

	set seed 12272020
	
	g rand_ctr_cash_1 = runiform() if Intervention == "Cash Grants - Women" & Status == "Control" & beneficiaire == 1
	
	sort rand_ctr_cash_1, stable 
	
	g 		qual_crt_cash_1 = 0
	replace qual_crt_cash_1 = 1 if Intervention == "Cash Grants - Women" & Status == "Control" & _n <=9
	
	
	replace Groupe = "Cash Grant Control & Treatment TCLP" 					if qual_crt_cash_1 == 1 & _n <=  5
	replace Groupe = "Cash Grant Control & Treatment TCLP - Replacement"  	if qual_crt_cash_1 == 1 & _n >   5
	
	replace Replacement = "Oui" if qual_crt_cash_1 == 1 & _n >   5
	
	******************************************************
	******************************************************
	
	**************************
	* Follow up control TCLP
	**************************
	
* Assign random number to follow up sample respondents and control TCLP

	set seed 12272020
	
	g rand_follow_0 = runiform() if Intervention == "Follow up - TCLP" & beneficiaire == 0
	
	sort rand_follow_0, stable 
	
	g 		qual_follow_0 = 0
	replace qual_follow_0 = 1 if Intervention == "Follow up - TCLP" & beneficiaire == 0 & _n <=13
	
	replace Groupe = "Follow up TCLP Control" 				if qual_follow_0 == 1 & _n <=10
	replace Groupe = "Follow up TCLP Control - Replacement" if qual_follow_0 == 1 & _n > 10
	
	replace Replacement = "Oui" if qual_follow_0 == 1 & _n > 10
	
	**************************
	* Follow up treatment TCLP
	**************************
	
* Assign random number to follow up sample respondents and treatment TCLP

	set seed 12272020
	
	g rand_follow_1 = runiform() if Intervention == "Follow up - TCLP" & beneficiaire == 1
	
	sort rand_follow_1, stable 
	
	g 		qual_follow_1 = 0
	replace qual_follow_1 = 1 if Intervention == "Follow up - TCLP" & beneficiaire == 1 & _n <=13
	
	replace Groupe = "Follow up TCLP Treatment" 			  if qual_follow_1 == 1 & _n <=10
	replace Groupe = "Follow up TCLP Treatment - Replacement" if qual_follow_1 == 1 & _n > 10
	
	replace Replacement = "Oui" if qual_follow_1 == 1 & _n > 10
	
	keep if Groupe != ""
	
	bys Groupe: replace Ordre_Replacement = _n if Replacement == "Oui"
	
	preserve 
		
		keep if ID_HH ! =.
		
		keep ID_HH Groupe Replacement Ordre_Replacement
		
		cap drop _merge 
		
		merge 1:m ID_HH using "A:/Assignment/Full sample.dta", gen(dd)
		
		keep if dd == 3
		
		replace Groupe = Groupe + " " + "Partenaire"
		
		tempfile partenaire
		sa      `partenaire'
		
	restore
	
append using `partenaire'
	
sort Groupe ID_HH

* Fill in information with one completed during endline

preserve

	keep HHID 
	
	tempfile HHID_select
	sa      `HHID_select'
	
restore


preserve 
	
	u "B:/clean/clean_CashXFollow_PII.dta", clear
	
	keep if tot_complete == 1 
	
	cap drop _merge 
	
	merge m:1 HHID using `HHID_select', keep(3)
	
replace Nom 			= a1_respondentname if a1_respondentname 	!= ""
replace Telephone1 		= a1_phonerespond	if a1_phonerespond 		!=.

	keep HHID Nom Telephone1 
		
	rename Nom Nom2
	
	duplicates drop 
		
	tempfile new_info
	sa 		`new_info'
	
restore 

merge 1:1 HHID using `new_info', update keep(1 3 4 5) gen(ddd)

replace Nom = Nom2 if Nom == ""
replace Nom = Nom2 if Nom == "A completer"


drop rand_* 

preserve

	keep if qual_follow_0 == 1 & Replacement == "Non" | qual_follow_1 == 1 & Replacement == "Non"
	
	sort Groupe

	order Groupe HHID Gender Nom Age Imada Adresse imada CIN Father Intervention Partenaire_Nom Telephone1 Telephone2

	keep Groupe HHID Gender Nom Age Imada Adresse imada CIN Father  Partenaire_Nom Telephone1 Telephone2

	export excel using "A:/Assignment/Qualitative Research/Liste_Qualitative_Research `date' c.xlsx", sheet ("Follow UP TCLP") first(var) replace
	
restore 

preserve

	keep if qual_follow_0 == 1 & Replacement == "Oui" | qual_follow_1 == 1 & Replacement == "Oui"
	
	sort Groupe Ordre_Replacement

	order Groupe Replacement Ordre_Replacement HHID Gender Nom Age Imada Adresse imada CIN Father Intervention Partenaire_Nom Telephone1 Telephone2

	keep Groupe Replacement  Ordre_Replacement HHID Gender Nom Age Imada Adresse imada CIN Father  Partenaire_Nom Telephone1 Telephone2

	export excel using "A:/Assignment/Qualitative Research/Liste_Qualitative_Research `date' c.xlsx", sheet ("Follow UP TCLP Replacement", modify) first(var) 
	
restore

preserve

	drop if qual_follow_0 == 1 | qual_follow_1 == 1
	
	drop if Replacement == "Oui"
	
	sort ID_HH Groupe 
	
	order Groupe ID_HH HHID Gender Nom Age Imada Adresse imada CIN Father Intervention Partenaire_Nom Telephone1 Telephone2

	keep Groupe ID_HH HHID Gender Nom Age Imada Adresse imada CIN Father Partenaire_Nom Telephone1 Telephone2


	export excel using "A:/Assignment/Qualitative Research/Liste_Qualitative_Research `date' c.xlsx", sheet ("Cash Grant", modify) first(var)
	
restore 

preserve

	drop if qual_follow_0 == 1 | qual_follow_1 == 1
	
	keep if Replacement == "Oui"

	sort Groupe Ordre_Replacement
	
	order Groupe ID_HH HHID Ordre_Replacement Gender Nom Age Imada Adresse imada CIN Father Intervention Partenaire_Nom Telephone1 Telephone2

	keep Groupe ID_HH HHID Ordre_Replacement Gender Nom Age Imada Adresse imada CIN Father Partenaire_Nom Telephone1 Telephone2

	export excel using "A:/Assignment/Qualitative Research/Liste_Qualitative_Research `date' c.xlsx", sheet ("Cash Grant - Replacement", modify) first(var)
	
restore 
	
	
	
	
	