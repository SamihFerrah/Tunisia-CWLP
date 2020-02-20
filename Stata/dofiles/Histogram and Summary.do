********************************************************************************
*				PREPARE HISTOGRAM AND SUMMARY STATISITCS CWLP				*
********************************************************************************



	
********************************************************************************
********************************************************************************
* 0. PREPARE LOCAL 					
********************************************************************************
********************************************************************************
set graph off
clear 
eststo clear 

local Index_ALL ///
					 food_consump_win  expenditure_win  coping_mechanisms  hh_assets2  house_ownership					///
					 large_assets  small_assets  home_assets  comms_assets  productive_assets  human_capital2 			///
					 wage_employment2  other_employment /* non_agri_enterp  agri_prod_income*/  debts_and_savings2 		///
					 debts  savings																						///
					 employ_aspirations  social_cohesion2  comm_groups  local_conflict  recent_migration				///
					 local_security  civic_engag  initiatives  initiatives_meeting  initiatives_acting					///
					 information_sources  utopia  isolation  psycho_wellbeing2  psycho_internal  psycho_external		///
					/* pearlin_index*/  overall_intrahouse2  womens_decision  violence_ag_women 
					
					
* Controls : ADJUSTED TO REFLECT THE ONES THAT ARE NOT BALANCED.

local ctrl_Aa hhsize drepondant_mat g1_3 g1_4 g1_5 g1_7
local ctrl_Ba extra 
local ctrl_Bb extra repondant_sex
local ctrl_Ca //none
local ctrl_Cb hhsize g1_4

use "$stata/enquete_All3", clear 

	label variable IAafood_consump_win 		"Food Consumption"
	label variable IAaexpenditure_win 		"Other Expenditure"
	label variable IAacoping_mechanisms 	"Coping Mechanisms"
	label variable IAahh_assets2 			"HH Assets"
	label variable IAahouse_ownership		"House Ownership"
	label variable IAalarge_assets 			"Large Assets"
	label variable IAasmall_assets 			"Small Assets"
	label variable IAahome_assets 			"Home Assets"
	label variable IAacomms_assets 			"Communications Assets"
	label variable IAaproductive_assets 	"Productive Assets"
	label variable IAahuman_capital2 		"Human Capital"
	label variable IAawage_employment2		"Wage Employment"
	label variable IAaother_employment		"Other Employment"
	*label variable IAanon_agri_enterp 		"Non-Agricultural Enterprise"
	label variable IAadebts_and_savings2 	"Debts and Savings"
	label variable IAadebts				 	"Debts"
	label variable IAasavings 				"Savings"
	label variable IAaemploy_aspirations 	"Employment Aspirations"
	label variable IAasocial_cohesion2 		"Social Cohesion"
	label variable IAacomm_groups 			"Community Groups"
	label variable IAalocal_conflict 		"Local Conflict"
	label variable IAarecent_migration		"Recent Migration"
	label variable IAalocal_security 		"Local Security"
	label variable IAacivic_engag 			"Civic Engagement"
	label variable IAainitiatives 			"Local Participation"
	label variable IAainitiatives_meeting 	"Local Meeting"
	label variable IAainitiatives_acting	"Local Acting"
	label variable IAainformation_sources 	"Information Sources"
	label variable IAautopia 				"Liberal Norms"
	label variable IAaisolation 			"Isolation"
	label variable IAapsycho_wellbeing2 	"Psychological Wellbeing"	
	*label variable IAapearlin_index 		"Pearlin Index"
	label variable IAaoverall_intrahouse2 	"Intrahousehold Dynamics"
	label variable IAawomens_decision 		"Female Decisionmaking"
	label variable IAaviolence_ag_women 	"Violence against Women"
	label variable IAapsycho_internal 		"Internal Wellbeing"
	label variable IAapsycho_external		"External Wellbeing"
	label variable hhsize 					"Number of household member"
	label variable drepondant_mat 			"Marital Status 1)Unmarried 0)Married" 
	label variable g1_3 					"Serious illness of head" 
	label variable g1_4 					"Serious illness of other household members" 
	label variable g1_5 					"Loss of employment"
	label variable g1_7 					"Failure to harvest" 
	label variable extra 					"Obs from second randomization"
	label variable repondant_sex			"Respondent gender"
	
cd "$git_tunisia/outputs/"

do  "$git_tunisia/dofiles/Ado/mmat2tex.do"
		
********************************************************************************
********************************************************************************

* Generate program indicator 

gen programs=(parti==1 | desist==1)

		
* Generate variable identifyin the sample used for every analysis 

g 		between = .
replace between = 1 if (parti==1 | desist==1 | enquete==3)

g 		within = .
replace within = 1 if (parti==1 | desist==1 | control==1) 

g 		spillovers = .
replace spillovers = 1 if (control==1 | enquete==3) 

g 		Infrastructure = .
replace Infrastructure = 1 if enquete==1


* Create matrix to store results while looping over index
foreach index in `Index_ALL'{
	mat def `index' 			= J(3,5,.)
}
	
* Loop over every specification 
foreach specification in Between Within Spillovers{

	local counter_graph = 0 
	
	if "`specification'" == "Between"{
	local cond_index 	"IAa"
	local cond_trt		"beneficiaire"
	local cond_sample 	"between"
	local row_summary = 1
	}
	
	if "`specification'" == "Within"{
	local cond_index	"IBa"
	local cond_trt		"programs"
	local cond_sample 	"within"
	local row_summary = 2
	
	}
	
	if "`specification'" == "Spillovers"{
	local cond_index 	"ICb"
	local cond_trt 		"beneficiaire"
	local cond_sample 	"spillovers"
	local row_summary = 3
	}
	
	* Loop over every index 
	foreach index in `Index_ALL'{
		
		local counter_graph = `counter_graph' + 1 
		
		local title : variable label IAa`index'
		
		local caption_`counter_graph' "`title'"
		
		* Export Density Histogram (with kernel line)
		
		twoway 	(hist 		`cond_index'`index' if `cond_trt' == 0 & `cond_sample' == 1, bcolor(blue%20)) 	///
				(kdensity 	`cond_index'`index' if `cond_trt' == 0 & `cond_sample' == 1, lcolor(blue%80))	///
				(hist 		`cond_index'`index' if `cond_trt' == 1 & `cond_sample' == 1, bcolor(red%20) ) 	///
				(kdensity 	`cond_index'`index' if `cond_trt' == 1 & `cond_sample' == 1, lcolor(red%80) ), 	///
				 title("`specification'", size(2)) subtitle(" ") xtitle("") ytitle("Density") 								///
				 graphregion(color(white)) plotregion(color(white)) 										///
				 legend(order(1 3) label( 1 "Control") label( 3 "Treatment"))
				 
		
		graph save "Graph/`specification'/Figure_`counter_graph'.gph", replace
		
		* Export Summary Tables 
		
		sum `cond_index'`index'
		
			mat def `index'[`row_summary',1] = `r(N)'
			mat def `index'[`row_summary',2] = `r(mean)'
			mat def `index'[`row_summary',3] = `r(sd)'
			mat def `index'[`row_summary',4] = `r(min)'
			mat def `index'[`row_summary',5] = `r(max)'
	}
}
/*
* Combine graph produce above 
forvalue i = 1/35{
	
	grc1leg "Graph/Between/Figure_`i'.gph" ///
			"Graph/Within/Figure_`i'.gph" ///
			"Graph/Spillovers/Figure_`i'.gph", title("`caption_`i''")
			
	graph export "Graph/Combined/Figure_`i'.pdf", replace 

}
*/
* Clean graph folder 

forvalue i = 1/35{

	rm "Graph/Between/Figure_`i'.gph"
	rm "Graph/Within/Figure_`i'.gph"
	rm "Graph/Spillovers/Figure_`i'.gph"
}


* Export table with summary statistics and regression results 
local counter_table =  1
foreach index in `Index_ALL'{

	mata `index' = st_matrix("`index'")
	
	mmat2tex `index' using "Tables/Summary/Table_`counter_table'.tex", replace ///
	preheader("\begin{tabular}{l*{5}{c}}\hline&\multicolumn{1}{c}{N}&\multicolumn{1}{c}{Mean}&\multicolumn{1}{c}{St. Dev}&\multicolumn{1}{c}{Min}&\multicolumn{1}{c}{Max}\\ \hline") ///
						bottom("\hline \end{tabular}") ///
						rownames(row1 row2 row3)   ///
						substitute(row1 "Between Village" row2 "Within Village" row3 "Spillovers") ///
						fmt(%12.0g %12.3f %12.3f %12.2f %12.2f)
						
local counter_table = `counter_table' + 1
}


* Export regression results 

	* Create interaction between treatment and treatment intensity variable 
	
	g habXtrt = NbHabitants*beneficiaire
	
	g beneXprog = beneficiaire*programs 
	
	local counter_reg = 1

	local Index_ALL ///
					 food_consump_win  expenditure_win  coping_mechanisms  hh_assets2  house_ownership					///
					 large_assets  small_assets  home_assets  comms_assets  productive_assets  human_capital2 			///
					 wage_employment2  other_employment /* non_agri_enterp  agri_prod_income*/  debts_and_savings2 		///
					 debts  savings																						///
					 employ_aspirations  social_cohesion2  comm_groups  local_conflict  recent_migration				///
					 local_security  civic_engag  initiatives  initiatives_meeting  initiatives_acting					///
					 information_sources  utopia  isolation  psycho_wellbeing2  psycho_internal  psycho_external		///
					/* pearlin_index*/  overall_intrahouse2  womens_decision  violence_ag_women 
					
foreach outcome in `Index_ALL' {

		mat def `outcome'_reg = J(8,6,.)
		
		* Between 
			
			eststo between: regress IAa`outcome' beneficiaire `ctrl_Aa' if between == 1, vce (cluster imada)
				
				mat def `outcome'_reg[1,1] = _b[beneficiaire]
				mat def `outcome'_reg[2,1] = _se[beneficiaire]
				
				local N1 = e(N)
				local R1 = round(e(r2),0.001)
			
			
		* Within 
		
			eststo within: regres IBa`outcome' programs `ctrl_Ba' if within == 1, robust
			
				mat def `outcome'_reg[3,2] = _b[programs]
				mat def `outcome'_reg[4,2] = _se[programs]
				
				local N2 = e(N)
				local R2 = round(e(r2),0.001)
			
		* Spillovers classic 
		
			eststo spill1: regres ICb`outcome' beneficiaire `ctrl_Cb'  if spillovers == 1, vce (cluster imada)
			
				mat def `outcome'_reg[1,3] = _b[beneficiaire]
				mat def `outcome'_reg[2,3] = _se[beneficiaire]
				
				local N3 = e(N)
				local R3 = round(e(r2),0.001)
			
		* Spillover and intensity
			
			eststo spill2: regres ICb`outcome' beneficiaire NbHabitants  `ctrl_Cb' if spillovers == 1, vce (cluster imada)
			
				mat def `outcome'_reg[1,4] = _b[beneficiaire]
				mat def `outcome'_reg[2,4] = _se[beneficiaire]
				mat def `outcome'_reg[5,4] = _b[NbHabitants]
				mat def `outcome'_reg[6,4] = _se[NbHabitants]
				
				local N4 = e(N)
				local R4 = round(e(r2),0.001)
				
		* Interacted 
		
			eststo spill3: regres ICb`outcome' beneficiaire habXtrt NbHabitants `ctrl_Cb' if spillovers == 1, vce (cluster imada)
				
				mat def `outcome'_reg[1,5] = _b[beneficiaire]
				mat def `outcome'_reg[2,5] = _se[beneficiaire]
				mat def `outcome'_reg[5,5] = _b[NbHabitants]
				mat def `outcome'_reg[6,5] = _se[NbHabitants]
				mat def `outcome'_reg[7,5] = _b[habXtrt]
				mat def `outcome'_reg[8,5] = _se[habXtrt]
				
				local N5 = e(N)
				local R5 = round(e(r2),0.01)
				
		* Full specification 
		
			eststo full: regress IDa`outcome' beneficiaire programs, vce (cluster imada)
				
				mat def `outcome'_reg[1,6] = _b[beneficiaire]
				mat def `outcome'_reg[2,6] = _se[beneficiaire]
				mat def `outcome'_reg[3,6] = _b[programs]
				mat def `outcome'_reg[4,6] = _se[programs]
				
				local N6 = e(N)
				local R6 = round(e(r2),0.001)

	mata `outcome'_reg = st_matrix("`outcome'_reg")
	
	mmat2tex `outcome'_reg using "Tables/Regression/Table_`counter_reg'.tex", replace ///
	preheader("\begin{tabular}{l*{6}{c}}\hline&\multicolumn{1}{c}{Between}&\multicolumn{1}{c}{Within}&\multicolumn{1}{c}{Spillovers}&\multicolumn{1}{c}{Intensity}&\multicolumn{1}{c}{Intensity Interacted}&\multicolumn{1}{c}{Full}\\ \hline") ///
						bottom("\hline \textit{Obs} & `N1' & `N2' & `N3' & `N4' & `N5' & `N6' \\ \textit{R2} & `R1' & `R2' & `R3' & `R4' & `R5' & `R6' \\ \hline \end{tabular}") ///
						rownames(row1 row2 row3 row4 row5 row6 row7 row8)   ///
						substitute(row1 "CWLP" row2 "" row3 "Workers" row4 "" row5 "\# Habitants" row6 "" row7 "Habitants X CWLP" row8 "") ///
						fmt(%12.4f %12.4f %12.4f %12.4f %12.4f %12.4f) ///
						coeff(pos((1,1) (8,6)) par)
						
	local counter_reg = `counter_reg' +1
}



/* --> Avoid running this part as some contens have been manually added to the 
	   Tex file (estimation strategy)


* Prepare Tex File 

	file open tex_histo using "Histogram.tex", text write replace 

	file write tex_histo "\documentclass[10pt,a4paper]{article}"				_n
	file close tex_histo
	file open tex_histo using "Histogram.tex", text write append
	
	file write tex_histo "\usepackage[latin1]{inputenc}"						_n
	file close tex_histo
	file open tex_histo using "Histogram.tex", text write append
	
	file write tex_histo "\usepackage{amsmath}"									_n
	file close tex_histo
	file open tex_histo using "Histogram.tex", text write append
	
	file write tex_histo "\usepackage{amsfonts}"								_n
	file close tex_histo
	file open tex_histo using "Histogram.tex", text write append
	
	file write tex_histo "\usepackage{amssymb}"									_n
	file close tex_histo
	file open tex_histo using "Histogram.tex", text write append
	
	file write tex_histo "\usepackage{graphicx}"								_n
	file close tex_histo	
	file open tex_histo using "Histogram.tex", text write append
	
	file write tex_histo "\usepackage{stata}"									_n
	file close tex_histo		
	file open tex_histo using "Histogram.tex", text write append
	
	file write tex_histo "\usepackage{float}"									_n
	file close tex_histo		
	file open tex_histo using "Histogram.tex", text write append
	
	file write tex_histo "\usepackage{caption}"									_n 
	file close tex_histo
	file open tex_histo using "Histogram.tex", text write append
	
	file write tex_histo "\usepackage{setspace}"								_n
	file close tex_histo
	file open tex_histo using "Histogram.tex", text write append
	
	file write tex_histo "\usepackage{pdflscape}"								_n
	file close tex_histo
	file open tex_histo using "Histogram.tex", text write append
	
	file write tex_histo "\usepackage{hyperref}"								_n
	file close tex_histo
	file open tex_histo using "Histogram.tex", text write append
	
	file write tex_histo "\hypersetup{"											_n
	file close tex_histo
	file open tex_histo using "Histogram.tex", text write append
	
	file write tex_histo 	"colorlinks,"										_n
	file close tex_histo
	file open tex_histo using "Histogram.tex", text write append
	
	file write tex_histo 	"citecolor=black,"									_n
	file close tex_histo
	file open tex_histo using "Histogram.tex", text write append
	
	file write tex_histo 	"filecolor=black,"									_n
	file close tex_histo
	file open tex_histo using "Histogram.tex", text write append
	
	file write tex_histo 	"linkcolor=black,"									_n
	file close tex_histo
	file open tex_histo using "Histogram.tex", text write append
	
	file write tex_histo 	"urlcolor=black"									_n
	file close tex_histo
	file open tex_histo using "Histogram.tex", text write append
	
	file write tex_histo "}"													_n
	file close tex_histo
	file open tex_histo using "Histogram.tex", text write append
	
	file write tex_histo "\usepackage{longtable}"								_n
	file close tex_histo		
	file open tex_histo using "Histogram.tex", text write append
	
	file write tex_histo "\begin{document}"										_n
	file close tex_histo
	file open tex_histo using "Histogram.tex", text write append
	
	file write tex_histo "\author{Ferrah Samih}\title{Tunisia CWLP: Histogram}\maketitle"	_n
	file close tex_histo
	file open tex_histo using "Histogram.tex", text write append
	
	file write tex_histo "\pagebreak"											_n
	file close tex_histo
	file open tex_histo using "Histogram.tex", text write append
	
	file write tex_histo "\listoffigures"										_n
	file close tex_histo
	file open tex_histo using "Histogram.tex", text write append
	
	file write tex_histo "\pagebreak"											_n
	file close tex_histo

	forvalue i = 1/35{
		
		file open tex_histo using "Histogram.tex", text write append
		file write tex_histo "\section{`caption_`i''}"							_n
		file close tex_histo	
		
		file open tex_histo using "Histogram.tex", text write append
		file write tex_histo "\begin{table}[H]\centering"						_n
		file close tex_histo
		
		file open tex_histo using "Histogram.tex", text write append
		file write tex_histo "\input{Tables/Summary/Table_`i'.tex}"				_n
		file close tex_histo
		
		file open tex_histo using "Histogram.tex", text write append
		file write tex_histo "\end{table}"										_n
		file close tex_histo
		
		file open tex_histo using "Histogram.tex", text write append
		file write tex_histo "\begin{figure}[H]\centering"						_n
		file close tex_histo
			
		file open tex_histo using "Histogram.tex", text write append
		file write tex_histo "\includegraphics[scale=0.75]{Graph/Combined/Figure_`i'.pdf}" _n
		file close tex_histo
			
		file open tex_histo using "Histogram.tex", text write append
		file write tex_histo "\caption{`caption_`i''} \label{fig:Fig_`i'}"		_n
		file close tex_histo
			
		file open tex_histo using "Histogram.tex", text write append
		file write tex_histo "\end{figure}"										_n
		file close tex_histo
		
		file open tex_histo using "Histogram.tex", text write append
		file write tex_histo "\begin{table}[H]\centering"						_n
		file close tex_histo
		
		file open tex_histo using "Histogram.tex", text write append
		file write tex_histo "\input{Tables/Regression/Table_`i'.tex}"			_n
		file close tex_histo
		
		file open tex_histo using "Histogram.tex", text write append
		file write tex_histo "\end{table}"										_n
		file close tex_histo
		
		}
		
	file open tex_histo using "Histogram.tex", text write append
	file write tex_histo "\end{document}"										_n
	file close tex_histo	
		
*/		




