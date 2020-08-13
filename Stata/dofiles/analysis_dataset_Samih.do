use "$stata/enquete_indiv5_imputed", clear 
cap drop _merge 

preserve 
	u "$stata/chefs_extracts_mean", clear 
	rename * *_c
	rename imada_c imada
	tempfile chef_data
	sa		`chef_data'
restore


*merge individual and village datatsets

merge m:1 imada using `chef_data' 												//34 not merging
list imada if _merge==1 														//all imada 40 Fernana; ok
drop _merge


decode imada, g(imada_str)
replace imada_str = upper(imada_str)
replace imada_str = subinstr(imada_str, " ", "",.)

* Import and merge admin data 
preserve 

	import excel using "$raw/Copie de Tunisia-TLCP-IE-randomization-finalev1.xlsx", clear first
	keep if _n < 83
	drop if delegation =="ghardimaou" & imada =="dkhaylia"						// Duplicate observation
	
	rename * *_admin 
	
	replace TCPL_OUI_admin = subinstr(TCPL_OUI_admin," ","",.)
	
	g 		beneficiaire_admin = 0 
	replace beneficiaire_admin = 1 if TCPL_OUI_admin == "OUI"
	
	rename imada_admin 				imada_str
	
	replace imada_str = upper(imada_str)
	replace imada_str = subinstr(imada_str, " ", "",.)
	
	rename strate_admin 			strata
	rename projects_per_delegation_admin 	num_projects
	
	g pop_change_admin = pop_2014_admin - pop_2004_admin 
	
	encode delegation_admin, g(delegation_admin_2)
	drop delegation_admin
	rename delegation_admin_2 delegation_admin
	
	tempfile admin
	sa 		`admin'

restore

merge m:1 imada_str using `admin'

* Check treatment status between Samir's correction and actual treatment status 
count if beneficiaire_admin 			!= beneficiaire 	& _merge == 3 

* Check if treatment status between Eric's randomization list and actual treatment status 
count if treatment_status1tcpl_admin 	!= beneficiaire 	& _merge == 3

*br imada treatment_status1tcpl_admin beneficiaire if treatment_status1tcpl_admin != beneficiaire

tab treatment_status1tcpl_admin beneficiaire if treatment_status1tcpl_admin != beneficiaire

drop if _merge == 2 

drop _merge 

preserve 

	import excel using "$raw/randomization (1).xlsx", sheet("Admin") clear first
	keep if Imada != ""
	
	replace Imada = subinstr(Imada," ","",.)
	replace Imada = upper(Imada)
	
	g imada_str = Imada
	
	keep imada_str Imada
	
	duplicates drop 
	
	replace imada_str = "AINDRAHAMBANLIEUS" if  imada_str == "AINDRAHAMBANLIEUE"
	replace imada_str = "BELLARIGIA"		if 	imada_str == "BULLAREGIA"
	replace imada_str = "ELHAMEM"			if 	imada_str == "ELHAMMEM"
	replace imada_str = "ELMALGUA"			if 	imada_str == "ELMALGA"
	replace imada_str = "FARGSAN"			if 	imada_str == "FORGSSAN"
	replace imada_str = "MANGUOUCH"			if 	imada_str == "MANGOUCH"
	replace imada_str = "SLOUL"				if 	imada_str == "SLOULE"
	replace imada_str = "OUEDMLIZOUEST"		if 	imada_str == "WEDMLIZOUEST"
	
	
	g beneficiaire_admin_2 = 1
	
	tempfile admin2
	sa 		`admin2'
	
restore 

merge m:1 imada_str using `admin2'

* Drop imadas present in master list but not surveyed 
drop _merge 

save "$stata/enquete_all", replace







