********************************************************************************
********************************************************************************
*						SAMPLE FOR QUALITATIVE RESEARCH							
********************************************************************************
********************************************************************************
set seed 12272020

* Use full sample dataset

	* Assign random number to cash grant treatment respondent

	g rand_trt_cash = runiform() if Intervention == "Cash Grant - Women" & Status == "Treatment"

	* Assign random number to cash grant control respondent

	g rand_ctr_cash = runiform() if Intervention == "Cash Grant - Women" & Status == "Control"

	* Assign random number to follow up sample respondents

	g rand_follow = runiform() if Intervention == "Follow up - TCLP"

	* Assign random number to male partner of treatment participant

	g rand_trt_male = runiform() if Intervention == "Cash Grant - Partenaire" & Status == "Treatment"

	* Assign random number to male partner of control participant

	g rand_ctr_male = runiform() if Intervention == "Cash Grant - Partenaire" & Status == "Treatment"
	
	
	
	**************************
	* Trt cash grant women 
	**************************
	
	sort rand_trt_cash, stable 
	
	g 		qual_trt_cash = 0
	replace qual_trt_cash = 1 if if Intervention == "Cash Grant - Women" & Status == "Treatment" & _n <=20
	
	**************************
	* Ctr cash grant women 
	**************************
	
	sort rand_ctr_cash, stable 
	
	g 		qual_crt_cash = 0
	replace qual_crt_cash = 1 if if Intervention == "Cash Grant - Women" & Status == "Control" & _n <=10
	
	**************************
	* Follow up
	**************************
	
	sort rand_follow, stable 
	
	g 		qual_follow = 0
	replace qual_follow = 1 if if Intervention == "Follow Up - TCLP" & _n <=10
	
	**************************
	* Trt cash grant partener 
	**************************
	
	sort rand_trt_male, stable 
	
	g 		qual_trt_cash_p = 0
	replace qual_trt_cash_p = 1 if if Intervention == "Cash Grant - Partner" & Status == "Treatment" & _n <=20
	
	**************************
	* Ctr cash grant partener 
	**************************
	
	sort rand_ctr_male, stable 
	
	g 		qual_crt_cash_p = 0
	replace qual_crt_cash_p = 1 if if Intervention == "Cash Grant - Partner" & Status == "Control" & _n <=10
	
	
drop rand_* 

* Export selected sample 


keep if qual_trt_cash 	== 1 | /// 
		qual_crt_cash 	== 1 | ///
		qual_follow 	== 1 | ///
		qual_trt_cash_p == 1 | /// 
		qual_crt_cash_p == 1
		
		
preserve 
	
	keep if qual_trt_cash == 1 
	
	export excel using "$home/14. Female Entrepreneurship Add on/Survey material/Assignment/Qualitative Research/Liste_Qualitative_Research.xlsx", sheet("Cash Grant Women - Treatment", modify)
	
restore

preserve 
	
	keep if qual_crt_cash == 1 
	
	export excel using "$home/14. Female Entrepreneurship Add on/Survey material/Assignment/Qualitative Research/Liste_Qualitative_Research.xlsx", sheet("Cash Grant Women - Control", modify)
	
restore  

preserve 
	
	keep if qual_follow == 1 
	
	export excel using "$home/14. Female Entrepreneurship Add on/Survey material/AssignmentQualitative Research/Liste_Qualitative_Research.xlsx", sheet("Follow UP", modify)
	
restore	

preserve 
	
	keep if qual_trt_cash_p == 1 
	
	export excel using "$home/14. Female Entrepreneurship Add on/Survey material/Assignment/Qualitative Research/Liste_Qualitative_Research.xlsx", sheet("Cash Grant Partner - Treatment", modify)
	
restore

preserve 
	
	keep if qual_crt_cash_p == 1 
	
	export excel using "$home/14. Female Entrepreneurship Add on/Survey material/Assignment/Qualitative Research/Liste_Qualitative_Research.xlsx", sheet("Cash Grant Partner - Control", modify)	
