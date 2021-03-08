********************************************************************************
********************************************************************************
*						MERGE BASELINE AND ENDLINE TUNISIA IE
********************************************************************************
********************************************************************************

* Define variable to keep from baseline 

local balance_indiv 	repondant_age repondant_mat repondant_educ				///
						hhsize adult_num jeunes_lireecrire emploi_2013_a		///
						formation origine_naissance origine_naissance_bis 	
						
local balance_coll		q0_1_c q0_2_c q0_3_c 											///
						negevent_1 negevent_2 negevent_3 negevent_4 					///
						negevent_5 negevent_6 negevent_7      							///
						negevent_8 negevent_9 posevent_1 posevent_2 posevent_3      	///
						posevent_4 posevent_5 posevent_6 posevent_7 posevent_8 prev_PWP ///
						pop_2004_admin pop_2014_admin pop_change_admin

********************************************************************************
********************************************************************************
						
* Use clean data 
u "$vera/temp/clean_CashXFollow_PII_2.dta", clear

* Merge with rand info for completing Nom Imada Age values 

cap drop _merge
cap drop imada

replace Nom = upper(Nom)
replace Nom = subinstr(Nom," ","",.)


encode Imada, gen(imada)

replace Imada = upper(Imada)
replace Imada = subinstr(Imada," ","",.)

merge m:1 HHID using "A:/Assignment/Full Sample.dta", keepusing(Nom Imada Age) keep(1 3)

* Get information from TCLP endline (2016)

preserve 

	u "$stata_base/enquete_All3", clear

	g Age = repondant_age
	
	generate str116 Nom = repondant_name
	
	replace Nom = upper(Nom)
	replace Nom = subinstr(Nom," ","",.)
	
	replace Imada = upper(Imada)
	replace Imada = subinstr(Imada," ","",.)

	format Nom %116s
		
	keep `balance_coll' `balance_indiv' Nom Imada Age imada
	
	rename * *_b 
	
	rename (Nom_b Imada_b Age_b imada_b) (Nom Imada Age imada)
	
	tempfile baseline 
	sa      `baseline'

restore 

/* We need to do two merge iteration:
	- 1) Using imada numeric value
	- 2) Using imada string value (for _merge 1)
*/

cap drop _merge

* Merge with info from baseline
merge m:1 Nom imada Age using `baseline', update replace 

* Replace next merge variable to missing for second merge wave
replace Imada = "" if _merge == 3

g Identified = 1 if _merge > 2

drop if _merge == 2

rename _merge original_merge

merge m:1 Nom Imada Age using `baseline', update replace

replace Identified = 1 if _merge > 2

drop if _merge == 2