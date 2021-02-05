********************************************************************************
********************************************************************************
* 					ERROR IN CODE CORRECTION
********************************************************************************
********************************************************************************

* Add correction or drop survey with code error 

* Added 7th January: ID  été saisie manuellement la première journée

drop if hhid == 681 & today ==d(27dec2020)

* Added 22th January
/*
Le superviseur Barka a interverti l’ID du partenaire de Najwa (39837) par l’ID de partenaire de Manoubia (39838), et inversement
*/
/*
g 		code_correct =. 
replace code_correct = 39838 if key == ""
replace code_correct = 39837 if key == ""

g 		code_replace = 0
replace code_replace = 1 if key == "" | key == ""

replace code = code_correct if code_replace == 1

*/

*Added 2th february 

/* Error in code, correct code already included in the dataset */

drop if key == "uuid:484e8e00-bcc4-4764-9124-23ee4781aad0" & hhid == 3349
