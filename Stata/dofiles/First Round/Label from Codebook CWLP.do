/*
FIRST NEED TO RUN DO-FILE CODEBOOK, THEN CREATE AN ADDTIONAL COLUMN RELABELLING

*/
pause on
import excel using "$git_tunisia/outputs/Main/Codebook_change_label", clear first 

drop if Variables ==""																// Drop empty lines 
replace Relabelling = Labels if Relabelling ==""									// Replace relablling empty cells (means no modif)

levelsof Variables, local (all_individual)										// Store all variables names 

levelsof Relabelling, local (labels)											// Store all labels

* Store variable labels

local i = 1 

foreach labs_ of local labels{

	local l_`i' = "`labs_'"
	
	local i = `i' + 1
	
}

* Label variables 

local i = 1

foreach indiv in `all_individual'{												// Loop over every individual outcomes and label var 
	
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
	
	
use "$stata/enquete_All3", clear 				// Use clean data

append using `label_spreadsheet'

foreach specification in between   within   spillovers    full 	  infrastructure	///
						 between_w within_w spillovers_w  full_w  infrastructure_w 	///
						 between_m within_m spillovers_m  full_m  infrastructure_m	{

	if "`specification'" == "between"{
	local cond 			= "between == 1"
	local var_suffix	= "b"	
	}
	
	if "`specification'" == "within"{
	local cond 			= "within == 1"
	local var_suffix	= "w"	
	}
	
	if "`specification'" == "spillovers"{
	local cond 			= "spillovers == 1"
	local var_suffix	= "s"	
	}
	
	if "`specification'" == "full"{
	local cond 			= "full == 1"
	local var_suffix	= "f"	
	}
	
	if "`specification'" == "infrastructure"{
	local cond 			= "infrastructure == 1"
	local var_suffix	= "i"	
	}
	
	
	
	**********************************
	**********************************
	
	if "`specification'" == "between_w"{
	local cond 			= "between == 1 & repondant_sex == 0"
	local var_suffix	= "b_w"	
	}
	
	if "`specification'" == "within_w"{
	local cond 			= "within == 1 & repondant_sex == 0"
	local var_suffix	= "w_w"	
	}
	
	if "`specification'" == "spillovers_w"{
	local cond 			= "spillovers == 1 & repondant_sex == 0"
	local var_suffix	= "s_w"
	}
	
	if "`specification'" == "full_w"{
	local cond 			= "full == 1 & repondant_sex == 0"
	local var_suffix	= "f_w"	
	}
	
	if "`specification'" == "infrastructure_w"{
	local cond 			= "infrastructure == 1 & repondant_sex == 0"
	local var_suffix	= "i_w"	
	}
	
	**********************************
	**********************************
	
	if "`specification'" == "between_m"{
	local cond 			= "between == 1 & repondant_sex == 1"
	local var_suffix	= "b_m"
	}
	
	if "`specification'" == "within_m"{
	local cond 			= "within == 1 & repondant_sex == 1"
	local var_suffix	= "w_m"
	}
	
	if "`specification'" == "spillovers_m"{
	local cond 			= "spillovers == 1 & repondant_sex == 1"
	local var_suffix	= "s_m"
	}
	
	if "`specification'" == "full_m"{
	local cond 			= "full == 1 & repondant_sex == 1"
	local var_suffix	= "f_m"
	}
	
	if "`specification'" == "infrastructure_m"{
	local cond 			= "infrastructure == 1 & repondant_sex == 1"
	local var_suffix	= "i_m"	
	}
	
	foreach indiv in `all_individual'{
					
		label var `indiv'_`var_suffix' "`l_`indiv''"
			
		
	}
}

sa "$stata/enquete_All3", replace 



