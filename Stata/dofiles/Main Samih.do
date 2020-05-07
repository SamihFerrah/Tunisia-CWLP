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


global import_individual		= 0
global construct_individual		= 0
global import_community			= 0 
global construct_community		= 0
global construct_analysis		= 0
global codebook_				= 0
global sum_stat					= 0
global balance 					= 0
global desc_index				= 0
global main_table				= 1
global indiv_reg				= 0
global heterogeneity			= 0

********************************************************************************
********************************************************************************
*				CLEANING INDIVIDUAL LEVEL DATASET 						
********************************************************************************
********************************************************************************


*Prepare dataset
if $import_individual == 1	{
	do "$git_tunisia/dofiles/Prepare_indiv_db_Samih"
}

*Prepare outcomes
if $construct_individual == 1	{
	do "$git_tunisia/dofiles/Prepare_indiv_outcomes_Samih"						// Prepare outcomes and other relevant variables
	do "$git_tunisia/dofiles/Missing Imputation.do"								// Imput missing outcomes variables 
}

********************************************************************************
********************************************************************************
*				CLEANING COMMUNITY LEVEL DATASET 						
********************************************************************************
********************************************************************************


* Prepare dataset
if $import_community == 1{
	do "$git_tunisia/dofiles/Prepare_chefs_db_Samih"
}

* Prepare community level outcomes 
if $construct_community == 1{
	do "$git_tunisia/dofiles/Prepare_chefs_outcomes_Samih"
}


* Construct analysis dataset 
if $construct_analysis == 1{
	do "$git_tunisia/dofiles/analysis_dataset_Samih"
	do "$git_tunisia/dofiles/Index_Samih"
}


********************************************************************************
********************************************************************************
*							ANALYSIS
********************************************************************************
********************************************************************************


* Run user written command 
do "$git_tunisia/dofiles/Ado/FDR_CWLP"


* Produce codebook of outcomes 
if $codebook_ == 1{
	do "$git_tunisia/dofiles/Codebook.do"
}

* Produce balance test 
if $balance == 1{
	do "$git_tunisia/dofiles/Balance Test Samih.do"
}
 
* Produce summary statistics of outcomes
if $sum_stat == 1{
	do "$git_tunisia/dofiles/Summary Statistics.do"
}

*Produce Histogram and Summary and Tex results document
if $desc_index == 1{
	do "$git_tunisia/dofiles/Histogram and Summary.do"
}

* Produce main tables of index 
if $main_table == 1{
	do "$git_tunisia/dofiles/Main Analysis Samih "
	do "$git_tunisia/dofiles/Main Analysis Samih (Extended)"
}

* Produce Individual outcomes regression tables 
if $indiv_reg ==1{
	do "$git_tunisia/dofiles/Individual Regression.do"
}

* Produce individual outcomes regression tables 
if $heterogeneity == 1{
	do "$git_tunisia/dofiles/Heterogeneity Samih.do"
}

* Prepare Tex Results File 
do "$git_tunisia/dofiles/Prepare Tex Results File"
