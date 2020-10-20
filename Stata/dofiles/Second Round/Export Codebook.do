********************************************************************************
********************************************************************************
*				CODEBOOK TUNISIA CWLP 										   *
********************************************************************************
********************************************************************************
cd "$home/Data/Second round/outputs/Codebook"


********************************************************************************
********************************************************************************
* 1) CODEBOOK 
********************************************************************************
********************************************************************************
use "$root/cleandata/.dta", clear 

cap g index_caregiver_female_full_m = .

label var index_caregiver_female_full_m "Caregiver view's on woman empowerment"

* Set excel file 
putexcel set "Codebook.xlsx", replace 

* Set column names 
putexcel A1 	= "Index"
putexcel B1 	= "Variables"
putexcel C1 	= "Labels"
putexcel D1		= "Range"
	
* Loop over every index 
local counter_index = 2

foreach index in `Index_ALL'{
	
	local l_`index' : variable label index_`index'_full_m
	
	putexcel A`counter_index' = "`l_`index''"
	
	local counter_outcome = `counter_index'
	
	* Loop over every individual outcomes of Index 
	foreach individual_outcome of local `index'{
	
		local l_`individual_outcome' : variable label `individual_outcome'_m
		
		putexcel B`counter_outcome' = "`individual_outcome'"
		putexcel C`counter_outcome' = "`l_`individual_outcome''"
		
		sum `individual_outcome'_m
		putexcel D`counter_outcome' = "[`r(min)' ; `r(max)']"
		
		
		local counter_outcome = `counter_outcome' + 1
	
	}
	
	local counter_index = `counter_outcome' + 1

}


