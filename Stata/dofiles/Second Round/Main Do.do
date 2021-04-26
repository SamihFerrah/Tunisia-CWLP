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


	* Samih 			8
	* Samih2			9
	* Varada 			10
	* Replication 		11
	
	
	global user_number  8


	* Dropbox/Box globals
	* ---------------------

	if $user_number == 8 {
	
		* Dropbox folder 
		global home		"C:/Users/Samih/Dropbox/WB-Tunisia-CWLP-IE"
		global dropbox	"C:/Users/samih/Dropbox/World Bank/Tunisia CWLP/2.TUNISIA/01.Data/02_DataWork_Sarah (FO Replicate)"
		
		* Location of shared folder with BJKA
		global shared	"C:/Users/samih/Dropbox/World Bank/Tunisia IE - Shared folder"
		
		* Github folder 
		global git_tunisia "C:/Users/samih/Documents/Github/Tunisia-CWLP/Stata"

	}
	
	if $user_number == 9 {
	
		* Dropbox folder
		global home		"C:/Users/wb553190/Dropbox/WB-Tunisia-CWLP-IE"
		global dropbox	"C:/Users/wb553190/Dropbox/World Bank/Tunisia CWLP/2.TUNISIA/01.Data/02_DataWork_Sarah (FO Replicate)"
		
		* Location of shared folder with BJKA
		global shared	"C:/Users/wb553190/Dropbox/World Bank/Tunisia IE - Shared folder"
		
		* Github folder
		global git_tunisia "C:/Users/wb553190/OneDrive - WBG/Documents/Github/Tunisia-CWLP/Stata"
	}
		
		
	if $user_number == 10 {
	
		* Dropbox folder
		global home		"D:/Dropbox/WB-Tunisia-CWLP-IE" 
		global dropbox 	"D:/Dropbox/Tunisia CWLP/2.TUNISIA/01.Data/02_DataWork_Sarah (FO Replicate)"
		
		* Location of shared folder with BJKA
		global shared	"D:/Dropbox/Tunisia IE - Shared folder" 
		
		* Github folder
		global git_tunisia "D:/GitHub/Tunisia-CWLP/Stata" 
	}
	
	
	
	if $user_number == 11 {
	
		* Dropbox folder
		global home		"C:/Users/wb553190/Dropbox/World Bank/Code Peer Review 2021 (Tunisia IE)"					// Here goes the path to the dropbox folder with the non PII data  
		
		* Github folder
			
		global git_tunisia "C:/Users/wb553190/OneDrive - WBG/Documents/Github/Tunisia-CWLP/Stata" // Here goes the path to the github folder 
		
	}
		
		
		* Location of baseline 
		
		* Location of the Raw data, raw;
		global stata_base "$dropbox/stata"
		
		* Location of the temporary data, temp;
		global rando "$home/14. Female Entrepreneurship Add on/Data/Randomization/Datawork/01_rando"
		
		* Location of stata data 
		global stata   "$home/14. Female Entrepreneurship Add on/Data/Second round"

		* Location of the Raw data, raw;
		global vera   "B:"
		
		* For outputs 
		global stata_tex "$git_tunisia/outputs/Second Round/Report"

********************************************************************************
********************************************************************************
********************************************************************************
********************************************************************************
*				CLEANING INDIVIDUAL LEVEL DATASET 						
********************************************************************************
********************************************************************************

global importXclean_individual 	= 1

global construct 				= 1

global preliminary_report		= 0 

********************************************************************************
********************************************************************************
*							ANALYSIS
********************************************************************************
********************************************************************************


global balance_test 			= 0

global attrition_test 			= 0

global endline_report			= 0

********************************************************************************
********************************************************************************
********************************************************************************
********************************************************************************

do "$git_tunisia/dofiles/Ado/stata-tex.do"

*Clean and prepare dataset

if $importXclean_individual == 1	{
	do "$git_tunisia/dofiles/Second Round/import_DIME_Tunisia_Entrepreneurship_Encrypt.do"			// Import and do basic check before saving data
	do "$git_tunisia/dofiles/Second Round/clean_daily_tunisia_entrepreneurship.do"			// Import and do basic check before saving data
}


* Preliminary report : Missingness and Statstics

if $preliminary_report == 1 {

	do "$git_tunisia/dofiles/Second Round/Analysis/Missingness Report.do"
	do "$git_tunisia/dofiles/Second Round/Analysis/Statistics.do"
	
}



* Construct data 

if $construct == 1{

	
	do "$git_tunisia/dofiles/Second Round/Construct/Prepare Outcomes.do"		// Prepare outcomes for analysis
	
	do "$git_tunisia/dofiles/Second Round/Construct/Missing Imputation.do"		// Prepare outcomes and other relevant variables

	do "$git_tunisia/dofiles/Second Round/Construct/Index Construction.do"		// Impute missing outcomes variables 
	
	save "$vera/clean/clean_analysis_CashXFollow.dta", replace
	
	********************************************************************************
	********************************************************************************
	* DE-IDENTIFY DATA 
	********************************************************************************
	********************************************************************************

	* 1) Define variable to be drop (Add variable below to be dropped)

	local deidentification 	"username calc_name complete_name a1_respondentname confirm_name a1_respondentname_corr Nom Father devicephonenum Telephone1 Telephone2"


	* 2) Drop ID variable 

	foreach var of local deidentification {
		
		capture noisily drop `var' 													

	}

	if $user_number == 11{														// Save in db folder replication 
		sa "$home/clean_analysis_CashXFollow_noPII.dta", replace
	}
	else {
		sa "$home/14. Female Entrepreneurship Add on/Data/Second Round/cleandata/clean_analysis_CashXFollow_noPII.dta", replace
	}
}


* Balance test
if $balance_test == 1{

	
	do "$git_tunisia/dofiles/Second Round/Analysis/Balance Test"

}

* Attrition test
if $attrition_test == 1{
	
	do "$git_tunisia/dofiles/Second Round/Analysis/Attrition Test"

}

* Endline report

if $endline_report == 1{

	do "$git_tunisia/dofiles/Second Round/Analysis/Analysis Endline Report.do"
	
}



********************************************************************************
********************************************************************************
*							ANALYSIS
********************************************************************************
********************************************************************************

