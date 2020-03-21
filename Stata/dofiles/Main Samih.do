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

	* Sarah Home		1
	* Sarah Work		2
	* Julie Home		3
	* Julie Work		4
	* Nausheen Home		5
	* Nausheen Work		6 
	* Samih 			7
	
	
	global user_number  7

	* Dropbox/Box globals
	* ---------------------
		
	if $user_number == 1 {
		global dropbox 	"C:\Users\Sarah\Dropbox\DIME\Handover\2.TUNISIA\01.Data\Replicate"
	}		
			
	if $user_number == 2 {
		global dropbox	"C:\Users\wb498055\Dropbox\DIME\Handover\2.TUNISIA\01.Data\Replicate"
	}
	
	if $user_number == 3 {
		global dropbox 	"C:\Users\Julie\Dropbox\Handover\2.TUNISIA\01.Data\Replicate"
	}		
			
	if $user_number == 4 {
		global dropbox	"C:\Users\wb527175\Dropbox\Handover\2.TUNISIA\01.Data\Replicate"
	}
/*	
	if $user_number == 5 {
		global dropbox 	"C:\Users\...\Dropbox\Handover\2.TUNISIA\01.Data\Replicate"
	}		
			
	if $user_number == 6 {
		global dropbox	"C:\Users\...\Dropbox\Handover\2.TUNISIA\01.Data\Replicate"
	}	
*/

	if $user_number == 7 {
		global dropbox	"/Users/Samih/Dropbox/World Bank/Tunisia CWLP/2.TUNISIA/01.Data/02_DataWork_Sarah (FO Replicate)"
	}
	
		*location of the temporary data, temp;
		global rando "$dropbox/randomization"
		
		*location of the temporary data, temp;
		global raw   "$dropbox/raw"

		*location of the Raw data, raw;
		global stata "$dropbox/stata"
			
		*location of the do files, do;
		global do   "$dropbox/do"
		
		*location of the do files, report;
		*global report "$dropbox/Resultats_Samih"
		
		if $user_number == 7{
			global git_tunisia "/Users/Samih/Desktop/Work/Git/Tunisia-CWLP/Stata"
		}

		
***INDIV

*Prepare dataset
do "$git_tunisia/dofiles/Prepare_indiv_db_Samih"

*Prepare outcomes
do "$git_tunisia/dofiles/Prepare_indiv_outcomes_Samih"

***COMMUNITY

*Préparer datasets
do "$git_tunisia/dofiles/Prepare_chefs_db_Samih"

*Préparer outcomes
do "$git_tunisia/dofiles/Prepare_chefs_outcomes_Samih"

* Final data 

do "$git_tunisia/dofiles/analysis_dataset_Samih"

***ALL

*Balance Analysis
*do "$do/Balance_outcomes_all"

*Creation of indexes
do "$git_tunisia/dofiles/Index_Samih"

*Histogram and Sumamry 

do "$git_tunisia/dofiles/Histogram and Summary.do"

*Analysis

do "$git_tunisia/dofiles/Analysis Samih"

*Heterogeneous Analysis
*do "$do/Analysis_heterog"

*Table with all Outcomes
*do $do/All_Outcomes

