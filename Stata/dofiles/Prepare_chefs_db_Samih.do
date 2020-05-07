set more off, perm

do "$do/import_chef"


*Identify treatment/control imadas.

sort imada
ren imada lieu_entrevue
preserve 
	import excel using "$raw/benef_imada.xlsx", first clear
	rename imada lieu_entrevue
	tempfile 	benef 
	sa		   `benef'
restore 

merge m:1 lieu_entrevue using `benef'
ren benef beneficiaire

/*tempo*/
list lieu_entrevue if _merge==2, nol  //one imada missing.
count //160
tab lieu_entrevue
/*tempo*/
keep if _merge==3
drop _merge

*create variable imada for clustering
gen imada=lieu_entrevue

*prepare for merging with individual dataset
foreach var of varlist deviceid-repondant_name key submissiondate {
ren `var' vil_`var'
}

preserve 
	import excel using "$raw/Previous_PWP.xlsx", first clear
	keep imada prev_PWP
	tempfile imada_code
	sa		`imada_code'
restore 

merge m:1 imada using `imada_code'
drop _merge 

label var prev_PWP "Previous PWP"

save "$stata/tunisia_chefs_benef", replace
