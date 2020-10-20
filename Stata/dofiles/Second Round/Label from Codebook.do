/*
FIRST NEED TO RUN DO-FILE CODEBOOK, THEN CREATE AN ADDTIONAL COLUMN RELABELLING

*/
pause on
import excel using "$home/Data/Second round/outputs/Codebook/Codebook_change_label", clear first 

drop if Labels ==""																// Drop empty lines 
replace Relabelling = Labels if Relabelling ==""								// Replace relablling empty cells (means no modif)

levelsof Variables, local (all_individual)										// Store all variables names 

levelsof Relabelling, local (labels)											// Store all labels

*levelsof index_name, local(title)


* Create title row variables used as row header in individual regression 

/*
foreach intermediary in `title'{

	g title_`intermediary' = .
		
	levelsof title_row if index_name == "`intermediary'", local (l_title)
		
	label var title_`intermediary' `l_title'
	
}
*/

* Store variable labels

local i = 1 

foreach labs_ of local labels{

	local l_`i' = "`labs_'"
	
	local i = `i' + 1
	
}

* Label variables 

local i = 1

foreach indiv in `all_individual'{													// Loop over every individual outcomes and label var 
	
	preserve 
	
		keep if Variables == "`indiv'"
		
	*g `indiv'_m_label = .
		
		local l_`indiv' = Relabelling
		
	*label var `indiv' "`l_`i''"
	local i = `i' + 1
	
	restore
}


g source_label = 1																// Indicator used to drop those variables after appending 

tempfile label_spreadsheet
sa 		`label_spreadsheet'


	
use "$root/cleandata/clean_analysis_CashXFollow.dta", clear 					// Use clean data
		
	drop Variables Labels Range
	
	append using `label_spreadsheet'

	foreach indiv in `all_individual'{
				
		label var `indiv'_m "`l_`indiv''"
		
	}

sa "$root/cleandata/clean_analysis_CashXFollow.dta", replace 


