********************************************************************************
********************************************************************************
*						SAMPLE FOR QUALITATIVE RESEARCH							
********************************************************************************
********************************************************************************
set seed 12272020

* Use full sample dataset

u "$home/14. Female Entrepreneurship Add on/Survey material/Assignment/Full Sample.dta", clear

g Groupe 		= ""
g Replacement   = "Non"

	***************************************
	* Trt cash grant women and control TCLP
	***************************************
	
* Assign random number to cash grant treatment respondent and control TCLP

	g rand_trt_cash_0 = runiform() if Intervention == "Cash Grants - Women" & Status == "Treatment" & beneficiaire == 0 
	
	sort rand_trt_cash_0, stable 
	
	g 		qual_trt_cash_0 = 0
	replace qual_trt_cash_0 = 1 if Intervention == "Cash Grants - Women" & Status == "Treatment" & _n <=13

	
	replace Groupe = "Cash Grant Treatment & Control TCLP" 				 if qual_trt_cash_0 == 1 & _n <= 10 
	replace Groupe = "Cash Grant Treatment & Control TCLP - Replacement" if qual_trt_cash_0 == 1 & _n >  10 
	
	replace Replacement = "Oui" if qual_trt_cash_0 == 1 & _n >  10 
	
	*****************************************
	* Trt cash grant women and treatment TCLP
	*****************************************
	
* Assign random number to cash grant treatment respondent and treatment TCLP

	g rand_trt_cash_1 = runiform() if Intervention == "Cash Grants - Women" & Status == "Treatment" & beneficiaire == 1

	
	sort rand_trt_cash_1, stable 
	
	g 		qual_trt_cash_1 = 0
	replace qual_trt_cash_1 = 1 if Intervention == "Cash Grants - Women" & Status == "Treatment" & _n <=13
	
	replace Groupe = "Cash Grant Treatment & Treatment TCLP" 				if qual_trt_cash_1 == 1 & _n <= 10
	replace Groupe = "Cash Grant Treatment & Treatment TCLP - Replacement"  if qual_trt_cash_1 == 1 & _n >  10
	
	replace Replacement = "Oui" if qual_trt_cash_1 == 1 & _n >  10 
	
	****************************************
	* Ctr cash grant women and control TCLP
	****************************************
	
* Assign random number to cash grant control respondent and control TCLP 

	g rand_ctr_cash_0 = runiform() if Intervention == "Cash Grants - Women" & Status == "Control" & beneficiaire == 0 
	
	
	
	sort rand_ctr_cash_0, stable 
	
	g 		qual_crt_cash_0 = 0
	replace qual_crt_cash_0 = 1 if Intervention == "Cash Grants - Women" & Status == "Control" & _n <=7

	replace Groupe = "Cash Grant Control & Control TCLP" 					if qual_crt_cash_0 == 1 & _n <= 5
	replace Groupe = "Cash Grant Control & Control TCLP - Replacement"  	if qual_crt_cash_0 == 1 & _n >  5
	
	replace Replacement = "Oui" if qual_crt_cash_0 == 1 & _n >  5
	
	*****************************************
	* Ctr cash grant women and treatment TCLP
	*****************************************
	
* Assign random number to cash grant control respondent and treatment TCLP

	g rand_ctr_cash_1 = runiform() if Intervention == "Cash Grants - Women" & Status == "Control" & beneficiaire == 1
	
	sort rand_ctr_cash_1, stable 
	
	g 		qual_crt_cash_1 = 0
	replace qual_crt_cash_1 = 1 if Intervention == "Cash Grants - Women" & Status == "Control" & _n <=7
	
	
	replace Groupe = "Cash Grant Control & Treatment TCLP" 					if qual_crt_cash_1 == 1 & _n <=  5
	replace Groupe = "Cash Grant Control & Treatment TCLP - Replacement"  	if qual_crt_cash_1 == 1 & _n >   5
	
	replace Replacement = "Oui" if qual_trt_cash_1 == 1 & _n >   5
	
	**************************
	* Follow up control TCLP
	**************************
	
* Assign random number to follow up sample respondents and control TCLP

	g rand_follow_0 = runiform() if Intervention == "Follow up - TCLP" & beneficiaire == 0
	
	sort rand_follow_0, stable 
	
	g 		qual_follow_0 = 0
	replace qual_follow_0 = 1 if Intervention == "Follow up - TCLP" & beneficiaire == 0 & _n <=11
	
	replace Groupe = "Follow up TCLP Control" 				if qual_follow_0 == 1 & _n <=10
	replace Groupe = "Follow up TCLP Control - Replacement" if qual_follow_0 == 1 & _n > 10
	
	replace Replacement = "Oui" if qual_follow_0 == 1 & _n > 10
	
	**************************
	* Follow up treatment TCLP
	**************************
	
* Assign random number to follow up sample respondents and treatment TCLP

	g rand_follow_1 = runiform() if Intervention == "Follow up - TCLP" & beneficiaire == 1
	
	sort rand_follow_1, stable 
	
	g 		qual_follow_1 = 0
	replace qual_follow_1 = 1 if Intervention == "Follow up - TCLP" & beneficiaire == 1 & _n <=11
	
	replace Groupe = "Follow up TCLP Treatment" 			  if qual_follow_1 == 1 & _n <=10
	replace Groupe = "Follow up TCLP Treatment - Replacement" if qual_follow_1 == 1 & _n > 10
	
	replace Replacement = "Oui" if qual_follow_1 == 1 & _n > 10
	
	**************************
	* Trt cash grant partener 
	**************************
	
* Assign random number to male partner of treatment participant

	g rand_trt_male = runiform() if Intervention == "Cash Grants - Women" & Status == "Treatment"
	
	sort rand_trt_male, stable 
	
	g 		qual_trt_cash_p = 0
	replace qual_trt_cash_p = 1 if Intervention == "Cash Grants - Women" & Status == "Treatment" & qual_trt_cash_0 == 0 & qual_trt_cash_1 == 0 & _n <=7

	replace Groupe = "Cash Grant Partner Treatment" 				if qual_trt_cash_p == 1 & _n <= 5
	replace Groupe = "Cash Grant Partner Treatment - Replacement"   if qual_trt_cash_p == 1 & _n >  5
	
	replace Replacement = "Oui" if qual_trt_cash_p == 1 & _n >  5
	
	**************************
	* Ctr cash grant partener 
	**************************
	
* Assign random number to male partner of control participant

	g rand_ctr_male = runiform() if Intervention == "Cash Grants - Women" & Status == "Control" 
	
	sort rand_ctr_male, stable 
	
	g 		qual_crt_cash_p = 0
	replace qual_crt_cash_p = 1 if Intervention == "Cash Grants - Women" & Status == "Control" & qual_crt_cash_1 == 0 & qual_crt_cash_1 == 0 & _n <=7
	
	replace Groupe = "Cash Grant Partner Control" 					if qual_crt_cash_p == 1 & _n <= 5
	replace Groupe = "Cash Grant Partner Control - Replacement"   	if qual_crt_cash_p == 1 & _n >  5
	
	replace Replacement = "Oui" if qual_crt_cash_p == 1 & _n >  5
	
drop rand_* 

* Export selected sample 

keep if qual_trt_cash_0 		== 1 | /// 
		qual_trt_cash_1 		== 1 | /// 
		qual_crt_cash_0 		== 1 | ///
		qual_crt_cash_1 		== 1 | ///
		qual_follow_0	 		== 1 | ///
		qual_follow_1	 		== 1 | ///
		qual_trt_cash_p 		== 1 | /// 
		qual_crt_cash_p 		== 1
		
sort Groupe Replacement

order Groupe Replacement HHID Gender Nom Age Imada Adresse imada CIN Father Intervention Partenaire_Nom Telephone1 Telephone2

keep Groupe Replacement HHID Gender Nom Age Imada Adresse imada CIN Father  Partenaire_Nom Telephone1 Telephone2

export excel using "$home/14. Female Entrepreneurship Add on/Survey material/Assignment/Qualitative Research/Liste_Qualitative_Research.xlsx", first(var) replace