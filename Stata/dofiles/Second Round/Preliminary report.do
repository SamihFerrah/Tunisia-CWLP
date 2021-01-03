********************************************************************************
********************************************************************************
*				TUNISIA IE PRELIMINARY REPORT		 						   *
********************************************************************************
********************************************************************************

/*

This do file produce and export summary statistics for all outcomes variables 
in order to capture difference and variation between respondents

We will try to follow the structure of the forms and structure the report by the 
different module

*/

pause on 

* Initiate TexFile 

cap file close TexPrep
file open TexPrep using "$git_tunisia/Second round/Preliminary report/Preliminary report.tex", text write replace

file write tex_histo 		"\documentclass[10pt,a4paper]{article}"				_n	///
							"\usepackage[latin1]{inputenc}"						_n	///
							"\usepackage{amsmath}"								_n	///
							"\usepackage{amsfonts}"								_n	///
							"\usepackage{amssymb}"								_n	///
							"\usepackage{graphicx}"								_n	///
							"\usepackage{stata}"								_n	///
							"\usepackage{float}"								_n	///
							"\usepackage{caption}"								_n 	///
							"\usepackage{setspace}"								_n	///
							"\usepackage{pdflscape}"							_n	///
							"\usepackage{hyperref}"								_n	///
							"\hypersetup{"										_n	///
							"colorlinks,"										_n	///
							"citecolor=black,"									_n	///
							"filecolor=black,"									_n	///
							"linkcolor=black,"									_n	///
							"urlcolor=black"									_n	///
							"}"													_n	///
							"\usepackage{longtable}"							_n	///
							"\usepackage{booktabs}"								_n	///
							"\begin{document}"									_n	///
							"\author{DIME}\title{Preliminary Report}\maketitle"	_n	///
							"\pagebreak"										_n	///
							"\tableofcontents"									_n	///
							"\pagebreak"										_n

********************************************************************************
********************************************************************************
* 0) Define list of outcomes 
********************************************************************************
********************************************************************************

	// 1) Import form definition 
	import excel using "$home/14. Female Entrepreneurship Add on/Survey Instrument/DIME_Tunisia_entrepreneurship_11142020.xlsx", clear first
	
	// 2) Keep interesting type of question
	
	split type, parse(" ")
	
	keep if type1 == "begin"			& type2 == "group"		|| ///
			type1 == "select_one"								|| ///
			type1 == "select_multiple"							|| ///
			type1 == "integer"									
			
			
	// 3) Define form section using different modules 
	
	g 		group_name = ""
	replace group_name = name if type1 == "begin" & type2 == "group"
	replace group_name = group_name[_n-1] if group_name == ""
	
	drop if group_name == "a1_enumname"					||	///
			group_name == "a1_datetime"					||	///
			group_name == "a1_city "					||	///
			group_name == "a1_respondentcoordinates"	||	///
			group_name == "a1_respondents_1"			|| 	///
			group_name == "a2_consent"					||	///
			group_name == "consentok"					|| 	///
			group_name == "wife_questionnaire"			||	///
			group_name == "socioecono_demograph"		||	///
			group_name == ""
		
	replace type1 = "1" if type1 == "integer" | type1 == "decimal"
	replace type1 = "2" if type1 == "select_one"
	replace type1 = "3" if type1 == "select_multiple"
	
	keep type name labelenglish constraint relevance 
	
	g 		type2 = type 
	replace type2 ="." 	 if type != "begin group"
	
	g 		module = labelenglish 		  if type == "begin group"
	replace module = module[_n-1] 		  if type2 == "."
	
	
	// 4) Store in local variable names and modules for analysis 
	
	tempfile full 
	sa		`full'
	
	levelsof group_name, local(group)
	
	foreach module of local group {
		
		local m_l_`module' = name
		
		u `full', clear
		
		keep if group_name == "`module'"
		
		drop if type1 == "begin"
		
		levelsof type1, local(var_type)
		
		foreach x of local var_type{
			
			di in red "`module' `x'"
			
			preserve 
			
				keep if type1 == "`x'"
				
				levelsof name, local(`module'_`x') 	
				
				global `module'_`x' `"``module'_`x''"'
				
				 di in red `"$``module'_`x''"'
			 
			restore 
		}
	}
	
********************************************************************************
********************************************************************************
* 1) Create summary statistics for whole module  
********************************************************************************
********************************************************************************

* Use clean data 

u "$home/14. Female Entrepreneurship Add on/Data/Second Round/tempdata/clean_analysis_CashXFollow.dta", clear

foreach module of local group {

	foreach x of local var_type{
	
		file open T_`module'_`x' using "$git_tunisia/Second round/Preliminary report/Tables/T_`module'_`x'.tex", text write replace
		
		file write T_`module'_`x' "\begin{tabular}{l*{5}{c}}\hline&\multicolumn{1}{c}{Variables}&\multicolumn{1}{c}{Mean}&\multicolumn{1}{c}{Std. Deviation}&\multicolumn{1}{c}{Min}&\multicolumn{1}{c}{Max}"  
		
		* Export summary statistics for integer
		
		if "`x'" == "1"{
			
			foreach var of local `module'_`x'{
			
				local l_`var' : variable label `var'
				
				sum `var'
				
				local mean 	: di%12.3f `r(mean)'
				local sd 	: di%12.3f `r(sd)'
				
				file write T_`module'_`x' " `l_`var'' & `mean' & `sd' & `min' & `max' \\"	_n
				
			}
			
			
		}
		
		* Export summary statitistics for dummies variable
		
		if "`x'" == "2"{
			
			foreach var of local `module'_`x'{
			
				local l_`var' : variable label `var'
				
				sum `var'
				
				local mean 	: di%12.3f `r(mean)'
				local sd 	: di%12.3f `r(sd)'
				
				file write T_`module'_`x' " `l_`var'' & `mean' & `sd' & `min' & `max' \\"	_n
				
			}
		
		}
		
		* Export summary statistics for select multiple
		
		if "`x'" == "3"{
		// Nothing as it doesn't makes sense to summarize categorical answers
		}
	
	
	}																			// Close type loop
}																				// Close module loop
		

********************************************************************************
********************************************************************************
* 2) Create  historgram for all module 
********************************************************************************
********************************************************************************

* Use clean data 

u "$home/14. Female Entrepreneurship Add on/Data/Second Round/tempdata/clean_analysis_CashXFollow.dta", clear

foreach module of local group {

	foreach x of local var_type{
	
		file open T_`module'_`x' using "$git_tunisia/Second round/Preliminary report/Tables/T_`module'_`x'.tex", text write replace
		
		file write T_`module'_`x' "\begin{tabular}{l*{5}{c}}\hline&\multicolumn{1}{c}{Variables}&\multicolumn{1}{c}{Mean}&\multicolumn{1}{c}{Std. Deviation}&\multicolumn{1}{c}{Min}&\multicolumn{1}{c}{Max}"  
		
		* Export histogran for integer
		
		if "`x'" == "1"{
			
			foreach var of local `module'_`x'{
			
				local l_`var' : variable label `var'
				
				hist `var', bcolor(blue%30) ), 														///
							title("`l_`var''", size(2)) subtitle(" ") xtitle("") ytitle("Density") 	///
							graphregion(color(white)) plotregion(color(white)) 										
							
				graph export using "$git_tunisia/Second round/Preliminary report/Figures/F_`module'_`x'.pdf", replace 
			
			}
		}
		
		* Export bar graph for dummies
		
		if "`x'" == "2"{
			
			foreach var of local `module'_`x'{
			
				local l_`var' : variable label `var'
				
				graph bar `var', ytitle("% of respondent") legend title("`l_`var''")
				
				graph export using "$git_tunisia/Second round/Preliminary report/Figures/F_`module'_`x'.pdf", replace 
				
			}
		}
		
		* Export bar graph for select multiple
		
		if "`x'" == "3"{
		
			foreach var of local `module'_`x'{
			
				local l_`var' : variable label `var'
				
				graph bar `var', ytitle("% of respondent") legend title("`l_`var''")
				
				graph export using "$git_tunisia/Second round/Preliminary report/Figures/F_`module'_`x'.pdf", replace 
				
			}
		}
	
	
	}																			// Close type loop
}																				// Close module loop
		

********************************************************************************
********************************************************************************
* 3) Add section, tables and figures to tex document
********************************************************************************
********************************************************************************

foreach module of local group {

	"\section{`m_l_`module''}"													_n ///

	foreach x of local var_type{
	
	file write TexPrep																							_n ///
	"\begin{table}[H]\centering"																				_n ///
	 "\input{$git_tunisia/Second round/Preliminary report/Tables/T_`module'_`x'.tex}"							_n ///
	"\end{table}"																								_n ///
	"\begin{figure}[H]\centering"																				_n ///
	"\includegraphics[scale=0.75]{$git_tunisia/Second round/Preliminary report/Figures/F_`module'_`x'.tex}" 	_n ///
	"\caption{`caption_`i''} \label{fig:Fig_`i'}"																_n ///
	"\end{figure}"																								_n
	
	}
	
}

file close TexPrep
		







	