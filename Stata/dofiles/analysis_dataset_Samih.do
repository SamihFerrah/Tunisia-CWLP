use "$stata/enquete_indiv5", clear 

*merge individual and village datatsets
merge m:1 imada using "$stata/chefs_extracts_mean" //34 not merging
list imada if _merge==1 //all imada 40 Fernana; ok
drop _merge

save "$stata/enquete_all", replace







