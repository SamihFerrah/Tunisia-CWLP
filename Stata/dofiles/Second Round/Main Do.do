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
	
	
	
	global user_number  9


	* Dropbox/Box globals
	* ---------------------

	if $user_number == 7 {
		global home		"/Users/Samih/Dropbox/WB-Tunisia-CWLP-IE"
		global dropbox	"/Users/Samih/Dropbox/World Bank/Tunisia CWLP/2.TUNISIA/01.Data/02_DataWork_Sarah (FO Replicate)"
	}
	if $user_number == 8 {
		global home		"C:/Users/Samih/Dropbox/WB-Tunisia-CWLP-IE"
		global dropbox	"C:/Users/samih/Dropbox/World Bank/Tunisia CWLP/2.TUNISIA/01.Data/02_DataWork_Sarah (FO Replicate)"
		
		* Location of shared folder with BJKA
		global shared	"C:/Users/samih/Dropbox/World Bank/Tunisia IE - Shared folder"
	}
	
	if $user_number == 9 {
		global home		"C:/Users/wb553190/Dropbox/WB-Tunisia-CWLP-IE"
		global dropbox	"C:/Users/wb553190/Dropbox/World Bank/Tunisia CWLP/2.TUNISIA/01.Data/02_DataWork_Sarah (FO Replicate)"
		
		* Location of shared folder with BJKA
		global shared	"C:/Users/wb553190/Dropbox/World Bank/Tunisia IE - Shared folder"
	}
		
		* Location of baseline 
		
		*location of the Raw data, raw;
		global stata_base "$dropbox/stata"
		
		*location of the temporary data, temp;
		global rando "$home/14. Female Entrepreneurship Add on/Data/Randomization/Datawork/01_rando"
		
		*location of stata data 
		global stata   "$home/14. Female Entrepreneurship Add on/Data/Second round"

		*location of the Raw data, raw;
		global vera   "B:"
		
		if $user_number == 7{
			global git_tunisia "/Users/Samih/Desktop/Work/Git/Tunisia-CWLP/Stata"
		}
		if $user_number == 8{
			global git_tunisia "C:/Users/samih/Documents/Github/Tunisia-CWLP/Stata"
		}
		if $user_number == 9{
			global git_tunisia "C:/Users/wb553190/OneDrive - WBG/Documents/Github/Tunisia-CWLP/Stata"
		}


********************************************************************************
********************************************************************************
*				CLEANING INDIVIDUAL LEVEL DATASET 						
********************************************************************************
********************************************************************************

global importXclean_individual 	= 1

global preliminary_report		= 0 

********************************************************************************
********************************************************************************
*							ANALYSIS
********************************************************************************
********************************************************************************

global balance_test 			= 0

global attrition_test 			= 0

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


* Balance test

if $balance_test == 1{
	
	do "$git_tunisia/dofiles/Second Round/Analysis/Balance Test"

}

* Attrition test

if $attrition_test == 1{
	
	do "$git_tunisia/dofiles/Second Round/Analysis/Attrition Test"

}

