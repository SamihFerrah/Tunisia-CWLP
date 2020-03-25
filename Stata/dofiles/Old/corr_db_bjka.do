

*load corrections BJKA made.
clear
import excel using $raw/Enquete_menage_30012017_CORRIGE_cb.xlsx, first
keep enqueteur superviseur enquete imada PSU hh_id hh_id_2 KEY corr
rename *, lower
gen ID = hh_id
save $stata/Enquete_menage_30012017_CORRIGE_cb, replace

*replace raw dataset from server, by corrections listed by BJKA
*keep if corr==1 | corr==2 //if only replaced for changes marqued by color. but found some not marked, so will replace all those of study 2 (nominative lists).
*keep if corr==1 |corr==2 | enquete==2

merge m:1 key using $stata/enquete_indiv0.dta 
drop _merge
drop if corr==2
isid key //ok

*from iedupreport provided by bjka
drop if key=="uuid:110a48e8-e23d-4d79-bb9b-122e7cab6627"
drop if key=="uuid:8d068dc8-3409-4f61-b0b0-4634d0de536a"
drop if key=="uuid:2fb78fbf-583c-4527-8c68-4a0a431d3b01"
drop if key=="uuid:9e9c701f-1744-4fac-bcbd-01c9a712d0ac"
drop if key=="uuid:21df05c3-fba1-4b6a-9744-9b32a6bae7f4"
drop if key=="uuid:d90f2cae-ddf0-47e3-abf2-714886bede35"
drop if key=="uuid:aa6e1c86-2cfc-453d-9919-34f8c72499eb"
drop if key=="uuid:921b27b8-00b7-436a-b85d-8fc9e8d7c870"
drop if key=="uuid:e6d76337-2b5a-48e3-b972-4e546eb9c9ef"
