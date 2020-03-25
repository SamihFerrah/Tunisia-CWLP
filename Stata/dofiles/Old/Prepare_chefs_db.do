set more off, perm

do $do/import_chef


*Identify treatment/control imadas.

sort imada
ren imada lieu_entrevue
merge m:1 lieu_entrevue using $stata/benef_imada
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


save $stata/tunisia_chefs_benef, replace
