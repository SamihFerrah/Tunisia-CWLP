/*DATA RETREIVED FORM THE SERVER ON SEPT 29 AND OCT 4*/	
	
	clear
	clear matrix
	clear mata
	set maxvar 10000
	set matsize 10000
	set more off, perm
	
	capture log close
	
	*cap ssc install labutil
	
/*CB's*/


	* Samih 			7
	* Samih2			8
	
	
	global user_number  8

	* Dropbox/Box globals
	* ---------------------

	if $user_number == 7 {
		global home		"/Users/Samih/Dropbox/WB-Tunisia-CWLP-IE"
		global dropbox	"/Users/Samih/Dropbox/World Bank/Tunisia CWLP/2.TUNISIA/01.Data/02_DataWork_Sarah (FO Replicate)"
	}
	if $user_number == 8 {
		global home		"C:/Users/Samih/Dropbox/WB-Tunisia-CWLP-IE"
		global dropbox	"C:/Users/samih/Dropbox/World Bank/Tunisia CWLP/2.TUNISIA/01.Data/02_DataWork_Sarah (FO Replicate)"
	}
	
		*location of the temporary data, temp;
		global rando "$home/14. Female Entrepreneurship Add on/Data/Randomization/Datawork/01_rando"
		
		*location of the temporary data, temp;
		global raw   "$dropbox/raw"

		*location of the Raw data, raw;
		global stata "$dropbox/stata"
			

		if $user_number == 7{
			global git_tunisia "/Users/Samih/Desktop/Work/Git/Tunisia-CWLP/Stata"
		}
		if $user_number == 8{
			global git_tunisia "C:/Users/samih/Documents/Github/Tunisia-CWLP/Stata"
		}


********************************************************************************
********************************************************************************
*				CLEANING INDIVIDUAL LEVEL DATASET 						
********************************************************************************
********************************************************************************


*Prepare dataset
if $import_individual == 1	{
	do "$git_tunisia/dofiles/"
}

*Prepare outcomes
if $construct_individual == 1	{
	do "$git_tunisia/dofiles/"													// Prepare outcomes and other relevant variables
	do "$git_tunisia/dofiles/"													// Imput missing outcomes variables 
}



********************************************************************************
********************************************************************************
*							ANALYSIS
********************************************************************************
********************************************************************************
