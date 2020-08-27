


************************
*LOAD ROUGH DATASET
************************

import delimited "$raw/enquete_individu_jendouba_arabic_WIDE.csv", clear
*import delimited $raw/enquete_individu_jendouba_arabic.csv
gen ID = hh_id
sort ID
save "$stata/enquete_indiv0.dta", replace

*do corrections do dataset indicated by bjka, from their checks
do "$git_tunisia/dofiles/corr_db_bjka_Samih"

*do redistribution of observations to right ID, for individuals in duplicata in nominative lists // after search for in which group indiv. should be classified (participant, control or dorp-out)
do "$git_tunisia/dofiles/redistr_dup_lists_Samih"

*create unique id
do "$git_tunisia/dofiles/uid_Samih"

*var imada in dataset is where interview was conducted
ren imada lieu_entrevue

*label variables
do "$git_tunisia/dofiles/label_individuals_Samih"


save "$stata/enquete_indiv.dta", replace

*************************
*CRÉER LA MASTER LIST of nominative lists
*************************

*Count participants from 1st and 2nd randomizations
import excel "$raw/Participant_BJKA_cb.xls", first clear
count //1179
drop if ID == .
append using "$rando/parti_details_ID2", gen(extra)
count //1185 ; +6 ok
gen parti=1 // dummy for participant
sort ID NGO
isid ID
save "$stata/participant_BJKA", replace

*create objective of participants per imada
bysort NGO : egen Obj_parti = total(Principal) //Objective to reach, from Field Manual (not TOR). See Arthur.

*correct participant list for duplicates between lists
duplicates report CIN //0; previously had several duplicates: resolved

list NGO if inlist(ID,30841,30007,30839,30219,30250,30969,30214,30146,31156,30472,30181,30618,31137,30819,30429,30235,30023,30255,30593,31021,30324,30659,30269,31176,30413,31096,30476)

drop if ID==30841 //corrects for inter-lists duplicates
drop if ID==30007
drop if ID==30839
drop if ID==30219
drop if ID==30250
drop if ID==30969
drop if ID==30214
drop if ID==30146
*drop if ID==31156
drop if ID==30472
drop if ID==30181
drop if ID==30618
drop if ID==31137
drop if ID==30819
drop if ID==30429
drop if ID==30235
drop if ID==30023
drop if ID==30255
drop if ID==30593
drop if ID==31021
drop if ID==30324
drop if ID==30659
drop if ID==30269
drop if ID==31176
drop if ID==30413
drop if ID==31096
drop if ID==30476
count //1158

save "$stata/participant_BJKA_nodup", replace

*count controls for 1st and 2nd randomizations
import excel "$raw/Control_BJKA_cb.xls", first clear
count //760
append using "$rando/control_details_ID2", gen(extra)
count //871 
gen control=1 //dummy for control
sort ID NGO
drop if ID==.
isid ID
save "$stata/control_BJKA", replace

*create objective of controls/per imada
bysort NGO : egen Obj_control = total(Principal)

*correct control list for duplicates in control list, and for duplicates between lists
duplicates report CIN //6 x 2 ok: addressed below
duplicates tag CIN, gen(tag2)
tab tag2
list ID if tag2==1 //checked in list.
*list ID if (ID==10257 | ID==10258 | ID==10272 | ID==10276 | ID==10623 | ID==10626 | ID==10628 | /// 
*ID==10632 | ID==10634 | ID==10638 | ID==10639 | ID==10640) //checked in list: 1 corr made in load section
*drop if tag2==1 //drop duplicata

list NGO if inlist(ID,10258,10623,10638,10276,10634,10639,10271,10280,10205,10744,10105,10319,10630,10285,10281,10426,10637,10413,10324,10022,10635)

drop if ID==10258 //corrects for intra-lists duplicates
drop if ID==10623
drop if ID==10638
drop if ID==10276
drop if ID==10634
drop if ID==10639


drop if ID==10271 //corrects for inter-lists duplicates
drop if ID==10280
drop if ID==10205
drop if ID==10744
drop if ID==10105
drop if ID==10319
drop if ID==10630
drop if ID==10285
drop if ID==10281
drop if ID==10426
drop if ID==10637
drop if ID==10413
drop if ID==10324
drop if ID==10022
drop if ID==10635
count //845

save "$stata/control_BJKA_nodup", replace


*count drop-outs from 1st and 2nd randomization
import excel "$raw/Desist_BJKA_cb.xls", first clear 
count //452
append using "$rando/desist_details_ID2", gen(extra)
count //501; +49 ok
gen desist=1
sort ID NGO
isid ID
save "$stata/desist_BJKA", replace

*create objective of drop-outs per imada
bysort NGO : egen Obj_desist = total(Principal) 

*corrects drop-out list for duplicates within list, and for duplicates between lists
count //501
duplicates report CIN //3 x 2; addressed below 
duplicates tag CIN, gen(tag3)
list ID if tag3==1 // checked in list
*list ID if (ID==20003 | ID==20052 | ID==20056 | ID==20120 | ID==20226 | ID==20228) //checked in list: ok
*drop if tag3==1 //drop duplicata

list NGO if inlist(ID,20056,20226,20120)

drop if ID==20056 //corrects for intra-lists duplicates
drop if ID==20226
drop if ID==20120
count //498

save "$stata/desist_BJKA_nodup", replace

*append lists
use "$stata/participant_BJKA_nodup", clear
count //1158
append using "$stata/control_BJKA_nodup"
count //2003
append using "$stata/desist_BJKA_nodup"
count //2501
sort NGO
save "$stata/master_list0", replace

/*verification for duplicates in nominative lists*/
*append lists
/*use $stata/participant_BJKA, clear
append using $stata/control_BJKA
append using $stata/desist_BJKA
duplicates tag CIN, gen(dupcin)
tab dupcin
sort CIN LAST_NAME FIRST_NAME
browse ID CIN LAST_NAME FIRST_NAME SEX BIRTH_DATE if dupcin!=0*/

*merge imada codes to masterlist of nominatives
import excel "$raw/imada_NGO.xlsx", first clear
sort NGO
keep if NGO!=""
labmask imada, values(survey_imada)
save "$stata/imada_NGO", replace

use "$stata/master_list0", clear 
merge m:1 NGO using "$stata/imada_NGO", keepusing (imada survey_imada) //all matched
drop _merge
ren imada imada_origine //imada as reported in the registration list (to distinguish from site of interview)
do "$git_tunisia/dofiles/label_masterlist_Samih"
save "$stata/master_list", replace

*double-check duplicates between nominative lists.
isid ID //yes
duplicates report CIN //none
sort CIN ID

save "$stata/master_list2", replace

******************************
*MERGE DB AVEC MASTERLIST
******************************
use "$stata/enquete_indiv.dta", clear
merge m:1 ID using "$stata/master_list2", keep (1 3) //1929 matched; 578 not matched from using

*vérif si des enquete==2 n'ont pas mergé
list ID if enquete==2 & _merge==1 //10639 ok: is a triplicata of the nominative list, and a replacement. Will drop.
list ID key if enquete==2 & _merge==1
drop if ID==10639
drop _merge
order ID imada_origine NGO delegation repondant_name

count //3927
order enquete imada_origine delegation repondant_name psu ID hh_id* submissiondate superviseur enqueteur LAST_NAME FIRST_NAME gpsl* 
tab enquete, nol m // 1: 1203, 2: 1929, 3: 795

save "$stata/enquete_indiv2", replace


*******************************
*MODIFIER DATASET
*******************************

*complete dummies with the zeroes
replace parti=0 if parti==. 
replace control=0 if control==.
replace desist=0 if desist==.

*create categorical for type of nominative list
gen nominative=0
replace nominative=1 if parti==1
replace nominative=2 if control==1
replace nominative=3 if desist==1
label variable nominative "Inscrit dans quelle liste nominative"
label define nominative 1 "Participants" 2 "Controles" 3 "Désistements"
label values nominative nominative
order ID imada_origine NGO delegation repondant_name nominative, first

*Identify beneficiary imadas: nominative lists (as registered in masterlist)
gen beneficiaire=(NGO!="")
label variable beneficiaire "Parmi 40 imadas beneficiaires"
label define beneficiaire 1 "Oui" 0 "Non"
label values beneficiaire beneficiaire
tab beneficiaire
tab beneficiaire if enquete==2 //all 1: good
save "$stata/enquete_indiv3", replace

*Identify beneficiary imadas: for sample 1 and 3 (site of interview)
import excel using "$raw/benef_imada.xlsx", first clear
ren imada lieu_entrevue //imada where the the interview was conducted
keep lieu_entrevue nom_imada benef
drop if lieu_entrevue==.
save "$stata/benef_imada", replace

use "$stata/enquete_indiv3", clear
sort lieu_entrevue
merge m:1 lieu_entrevue using "$stata/benef_imada", keepusing(benef)
drop _merge
replace beneficiaire=benef if enquete!=2
tab beneficiaire if enquete==1 //598 no, 605 yes
tab beneficiaire if enquete==2 //all yes: good
tab beneficiaire if enquete==3 //all no: good

*create dummy that will be useful for analysis
gen controles=(nominative==2 | enquete==3)

*create imada variable for clustering. 
gen imada=lieu_entrevue if enquete==1 | enquete==3
replace imada=imada_origine  if enquete==2	
tab imada
label values imada lieu_entrevue
save "$stata/enquete_indiv3_1", replace


*add variable on type of project for second round PWP
import excel using "$raw/Type_project.xlsx", first clear
keep imada TypePWP 
drop if    imada==.																		
sort imada
save "$stata/type_project", replace

use "$stata/enquete_indiv3_1", clear
sort imada
merge m:1 imada using "$stata/type_project"
drop _merge
tab TypePWP beneficiaire, m //none beneficiaries have TypePWP==., all non-ben have TypePWP==.
tab TypePWP, gen(typepwp_dum)
sum typepwp_dum*
label variable typepwp_dum1 "École" 
label variable typepwp_dum2 "Route" 
label variable typepwp_dum3 "Autre" 

save "$stata/enquete_indiv3_2", replace


*create variable on population and on strata
import excel using "$raw/Population_imada.xlsx", first clear
drop nom_imada
save "$stata/population_imada", replace

use "$stata/enquete_indiv3_2", clear 
merge m:1 imada using "$stata/population_imada"
drop _merge
tab NbHabitants, m //non missing
tab Strata, gen(strata_dum)
sum strata_dum*
label variable strata_dum1 "Population faible" 
label variable strata_dum2 "Population moyenne"
label variable strata_dum3 "Population plus forte"

save "$stata/enquete_indiv3_3", replace


*create variable on a previous PWP in the community
import excel using "$raw/Previous_PWP.xlsx", first clear
keep imada prev_PWP
save "$stata/previous_pwp", replace

use "$stata/enquete_indiv3_3", clear
merge m:1 imada using "$stata/previous_pwp"
drop _merge
label variable prev_PWP "Had a previous PWP in community"


save "$stata/enquete_indiv4", replace
