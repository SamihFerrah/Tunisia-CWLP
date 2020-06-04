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

save "$stata/enquete_all", replace







