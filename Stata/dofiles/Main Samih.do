/*DATA RETREIVED FORM THE SERVER ON SEPT 29 AND OCT 4*/	
	
	clear
	clear matrix
	clear mata
	set maxvar 10000
	set matsize 10000
	set more off, perm
	
	capture log close

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
		global dropbox	"/Users/Samih/Dropbox/World Bank/Tunisia CWLP/2.TUNISIA/01.Data/Replicate"
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
		global report "$dropbox/Resultats_Samih"
		
		if $user_number == 7{
			global git_tunisia "/Users/Samih/Desktop/Work/Git/Tunisia-CWLP/Stata"
		}

		
***INDIV

*Prepare dataset
do "$do/Prepare_indiv_db"

*Prepare outcomes
do "$do/Prepare_indiv_outcomes"

***COMMUNITY

*Préparer datasets
do "$do/Prepare_chefs_db"

*Préparer outcomes
do "$do/Prepare_chefs_outcomes"

***ALL

*Balance Analysis
do "$do/Balance_outcomes_all"

*Creation of indexes
do "$do/Index"

*Analysis
do "$do/Analysis"

*Heterogeneous Analysis
do "$do/Analysis_heterog"

*Table with all Outcomes
*do $do/All_Outcomes

