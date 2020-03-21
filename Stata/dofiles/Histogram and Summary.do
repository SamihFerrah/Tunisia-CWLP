********************************************************************************
*				PREPARE HISTOGRAM AND SUMMARY STATISITCS CWLP				*
********************************************************************************



	
********************************************************************************
********************************************************************************
* 0. PREPARE LOCAL 					
********************************************************************************
********************************************************************************
set graph off
cap file close tex_histo
pause on 
clear 
eststo clear 
cd "$git_tunisia/outputs/"
do  "$git_tunisia/dofiles/Ado/mmat2tex.do"

/*
local Index_ALL ///
					 food_consump_win  expenditure_win  coping_mechanisms  hh_assets2  house_ownership					///
					 large_assets  small_assets  home_assets  comms_assets  productive_assets  human_capital2 			///
					 wage_employment2  other_employment non_agri_enterp  agri_prod_income  debts_and_savings2 			///
					 debts  savings	 employ_aspirations  social_cohesion2  comm_groups  local_conflict  				///
					 recent_migration	ocal_security  civic_engag  initiatives  initiatives_meeting  					///
					 initiatives_acting	information_sources  utopia  isolation  psycho_wellbeing2  						///
					 psycho_internal  psycho_external pearlin_index*  overall_intrahouse2  								///
					 womens_decision  violence_ag_women 
*/
local Index_ALL ///
					 food_consump_win  expenditure_win  coping_mechanisms  hh_assets2   human_capital2 					///
					 wage_employment2  other_employment /*non_agri_enterp*/   debts  savings  								///
					 service_access	social_cohesion2 civic_engag psycho_wellbeing2 womens_decision violence_ag_women
					 
			
local allgroups2	food_consump_win expenditure_win coping_mechanisms hh_assets2 house_ownership		///
					large_assets small_assets home_assets comms_assets productive_assets human_capital2 ///
					wage_employment2 other_employment non_agri_enterp /*agri_prod_income*/ debts_and_savings2 ///
					employ_aspirations social_cohesion2 comm_groups local_conflict recent_migration		///
					local_security civic_engag initiatives initiatives_meeting initiatives_acting		///
					information_sources utopia isolation psycho_wellbeing2 psycho_internal psycho_external ///
					/*pearlin_index*/ overall_intrahouse2 womens_decision violence_ag_women debts savings	///
					five_years_chef local_sec_all intrahh_prt social_capital cooperation participation 	///
					utopie pol_isolation
					
* Controls : ADJUSTED TO REFLECT THE ONES THAT ARE NOT BALANCED.

local ctrl_Aa hhsize drepondant_mat g1_3 g1_4 g1_5 g1_7
local ctrl_Ba extra 
local ctrl_Bb extra repondant_sex
local ctrl_Ca //none
local ctrl_Cb hhsize g1_4

use "$stata/enquete_All3", clear 

	{																			// Define multiple local (index and individual measures)
	
	label variable hhsize 					"Number of household member"
	label variable drepondant_mat 			"Marital Status 1)Unmarried 0)Married" 
	label variable g1_3 					"Serious illness of head" 
	label variable g1_4 					"Serious illness of other household members" 
	label variable g1_5 					"Loss of employment"
	label variable g1_7 					"Failure to harvest" 
	label variable extra 					"Obs from second randomization"
	label variable repondant_sex			"Respondent gender"
	

	local food_consump_win 		c3_a_1_win6 c3_a_2_win6 c3_a_3_win c3_a_4_win5 c3_a_5_win5 c3_a_6_win5 c3_a_7_win5 	///
							c3_a_8_win5 c3_a_9_win c3_a_10_win c3_a_11_win5 

	local expenditure_win 		exp_food_win c4_win c5_win5 c6_win5 c7_win5 c8_win5 c9_win c11_win c12_win c13_win c14_win ///
								c15_win c16_win c18_win 

	local coping_mechanisms 	g2_1 g2_2 g2_3 g2_4 g2_5 g2_6 g2_7 g2_8 g2_9 g2_10 g2_11 g2_12 g2_13 g2_14 g2_15

	local hh_assets2			q2_1_2_win q2_1_3 q2_1_4 q2_1_5 q2_1_6 q2_1_7 q2_1_8 q2_1_9 q2_1_10 q2_1_11 		///
								q2_1_12 q2_1_13_win q2_1_14 q2_1_15 q2_1_16_win q2_1_17 q2_1_18_win q2_1_19_win ///
								q2_1_20 q2_1_21 q2_1_22 q2_1_23_win mur_dummy toit_dummy proprietaire_dum1 		///
								titre proprietaire_terre superficie_m titre_terre f18_dummy
							
	local house_ownership		proprietaire_dum1bis titrebis proprietaire_terrebis titre_terrebis
							
	local large_assets			q2_1_2_winbis q2_1_3bis q2_1_4bis q2_1_5bis q2_1_6bis q2_1_9bis q2_1_10bis		///
								q2_1_12bis q2_1_13_winbis q2_1_17bis  q2_1_20bis q2_1_21bis q2_1_22bis 
							  
	local small_assets			q2_1_7bis q2_1_8bis q2_1_11bis q2_1_14bis q2_1_15bis q2_1_16_winbis q2_1_18_winbis ///
								q2_1_19_winbis q2_1_23_winbis 

	local home_assets			q2_1_2_winbis2 q2_1_3bis2 q2_1_4bis2 q2_1_5bis2 q2_1_6bis2 q2_1_7bis2 q2_1_8bis2  	
		
	local comms_assets			q2_1_12bis2 q2_1_13_winbis2 q2_1_14bis2 q2_1_15bis2 q2_1_16_winbis2  

	local productive_assets		q2_1_9bis2 q2_1_10bis2 q2_1_11bis2 q2_1_17bis2 q2_1_18_winbis2 q2_1_19_winbis2 ///
								q2_1_20bis2 q2_1_21bis2 //q2_1_22bis2

	local human_capital2 		formation formation_dum1 formation_dum2 formation_dum3 formation_dum4 	///
								formation_dum5 formation_dum6 formation_dum7 formation_dum9 			///
								formation_dum10 emploi_comp_inut

	local wage_employment2 		emploi tspent_main earned_main_win employedhh earnedhh_win ///
								paidjobhh earnedoth paidjoboth								

	local other_employment 		sec_empl tspent_sec_win earned_sec

	local non_agri_enterp 		employs pers_employ hoursperm_employ paid_employ

	local debts_and_savings2 	epargne epargne_forme_3 epargne_cb epargne_dette epargne_dette_cb_win epargne_pret

	local debts					epargne_dettebis epargne_dette_cb_winbis //epargne_pret

	local savings				epargnebis epargne_forme_3bis epargne_cbbis

	local employ_aspirations	futur_services emp_futur_cb_win //futur_agriculture

	local social_cohesion2		association_dummy comite_c comite_c_menage conflit_dispute_in conflit_dispute_out ///
								/*migration_cm_q1 migration_q1*/ security_dummy							

	local comm_groups			association_1 association_2 association_3 association_4 association_6 association_7 ///
								association_8 association_9 comite_cbis comite_c_menagebis

	local local_conflict		conflit_dispute_inbis conflit_dispute_outbis

	local recent_migration		migration_cm_q1bis migration_q1bis

	local local_security		/*securite_1 securite_2 */ securite_3 /* securite_4 */ securite_5 securite_6

	local civic_engag 			initiative_dummy utopie_a_dum1 utopie_b_dum1 source_info_internal source_info2_internal ///
								isolation_dummy
								
	local initiatives			initiatives_1 initiatives_2 initiatives_3 initiatives_4 initiatives_5 initiatives_6 ///
								initiatives_7 initiatives_8 initiatives_9 initiatives_10 initiatives_11 			///
								initiatives_12 initiatives_13 initiatives_14 initiatives_15
								
	local initiatives_meeting	initiatives_1bis initiatives_2bis initiatives_3bis initiatives_4bis initiatives_5bis initiatives_6bis ///
								initiatives_7bis initiatives_8bis initiatives_9bis 
								
	local initiatives_acting	initiatives_10bis initiatives_11bis initiatives_12bis initiatives_13bis initiatives_14bis /*initiatives_15bis*/

	local information_sources	source_info_internalbis source_info2_internalbis 

	local utopia				utopie_a_dum1bis  utopie_a_dum3 utopie_b_dum1bis  utopie_b_dum3

	local isolation				isolement_1 isolement_2 isolement_3 isolement_4

	local psycho_wellbeing2		psy_anxiete psy_exploit psy_depress5 /*psy_accepte_dum1*/ psy_accepte_dum3 	///
								psy_menage_dum3 /*psy_a_menage_dum1*/ psy_a_menage_dum3	
							
	local psycho_internal   	psy_anxietebis psy_exploitbis psy_depress5bis

	local psycho_external		/*psy_accepte_dum1bis*/ psy_accepte_dum3bis psy_menage_dum3bis 				///
								/*psy_a_menage_dum1bis*/ psy_a_menage_dum3bis							

	local womens_decision 		intrahh_1 intrahh_2 intrahh_7 intrahh_11 emploiw
								
	local overall_intrahouse2	intrahh_1bis intrahh_2bis intrahh_7bis intrahh_11bis emploiwbis ///
								violence_physical violence_emotional

	local violence_ag_women 	violence_1_2 violence_1_3 violence_1_4 violence_1_5 violence_1_6 ///
								violence_1_7 violence_1_8 violence_1_9 violence_1_10 violence_1_11 ///
								violence_1_16 violence_1_17 violence_1_18
		
	}
		
********************************************************************************
********************************************************************************

* Generate program indicator 
/*
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

*/
* Create matrix to store results while looping over index
foreach index in `Index_ALL'{
	mat def `index' 			= J(3,5,.)
}

/*
preserve 

keep if within == 1

drop I* nominative hh_id hh_id_2 superviseur enqueteur date_v  q1 dup3 extra parti ///
	 control desist controles superv_* g1_9 *_convert 

* Lasso selection of possible instrument variable for WORKER in full spec (to catch spillovers)

	// 1) Create local with all possible related variables (excluding the one used to create index)
	
	foreach x in `allgroups2'{													// Drop var used to create index 
	
		foreach var of local `x'{
		
			cap drop `var'
		}
	
	} 
	
	local possible ""
	
	foreach x of varlist _all{

		capture confirm numeric variable `x'
		
		if _rc == 0 & "`x'" != "NbHabitants"{
		
			cap assert `x' !=.
			
			if _rc == 0{
		
				local possible "`possible' `x'"
			
			}
			
		}
	
	}
	
	local possible2 ""
	
	foreach var of local possible{
	
		reg programs `var', robust
		
		local pvalue = ttail(e(df_r),abs(_b[`var']/_se[`var']))*2
		
		if  `pvalue' < 0.1 & "`var'" != "programs"{
		
			local possible2 "`possible2' `var'"

		}
	
	}
	
	desc `possible2'

	
	// 2) Proceed to LASSO estimation
	dsregress programs NbHabitants, control((i.imada) `possible2')
	
		* Display results from lasso procedure
	di as text "****************************************************************"
	di as text "****************************************************************"
	di in red  "LASSO SELECTION: `e(controls_sel)'"
	di as text "****************************************************************"
	di as text "****************************************************************"
	di in red  "Potential LASSO SELECTION: `e(controls)'"
	di as text "****************************************************************"
	di as text "****************************************************************"
	 
	
	local lasso_sel "`e(controls_sel)'"
	
	// 3) Test validity of instrument selected

restore
*/



* Loop over every specification 
foreach specification in Between Within Spillovers{

	local counter_graph = 0 
	
	if "`specification'" == "Between"{
	local cond_index 	"IAaS"
	local cond_trt		"beneficiaire"
	local cond_sample 	"between"
	local row_summary = 1
	}
	
	if "`specification'" == "Within"{
	local cond_index	"IBaS"
	local cond_trt		"programs"
	local cond_sample 	"within"
	local row_summary = 2
	
	}
	
	if "`specification'" == "Spillovers"{
	local cond_index 	"ICbS"
	local cond_trt 		"beneficiaire"
	local cond_sample 	"spillovers"
	local row_summary = 3
	}
	
	* Loop over every index 
	foreach index in `Index_ALL'{
		
		local counter_graph = `counter_graph' + 1 
		
		local title : variable label `cond_index'`index'
		
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

* Combine graph produce above 
forvalue i = 1/15{
	
	grc1leg "Graph/Between/Figure_`i'.gph" ///
			"Graph/Within/Figure_`i'.gph" ///
			"Graph/Spillovers/Figure_`i'.gph", title("`caption_`i''")
			
	graph export "Graph/Combined/Figure_`i'.pdf", replace 

}

* Clean graph folder 

forvalue i = 1/15{

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

foreach outcome in `Index_ALL' {

		mat def `outcome'_reg = J(6,4,.)
		
		* Between 
			
			eststo between: regress IAaS`outcome' beneficiaire `ctrl_Aa' if between == 1, vce (cluster imada)
				
				mat def `outcome'_reg[1,1] = _b[beneficiaire]
				mat def `outcome'_reg[2,1] = _se[beneficiaire]
				
				local N1 = e(N)
				local R1 = round(e(r2),0.001)
			
			
		* Within 
		
			eststo within: regres IBaS`outcome' programs `ctrl_Ba' if within == 1, robust
			
				mat def `outcome'_reg[3,2] = _b[programs]
				mat def `outcome'_reg[4,2] = _se[programs]
				
				local N2 = e(N)
				local R2 = round(e(r2),0.001)
			
		* Spillovers classic 
		
			eststo spill1: regres ICbS`outcome' beneficiaire `ctrl_Cb'  if spillovers == 1, vce (cluster imada)
			
				mat def `outcome'_reg[1,3] = _b[beneficiaire]
				mat def `outcome'_reg[2,3] = _se[beneficiaire]
				
				local N3 = e(N)
				local R3 = round(e(r2),0.001)
			
		* Spillover and intensity
			
			eststo spill2: regres ICbS`outcome' beneficiaire NbHabitants  `ctrl_Cb' if spillovers == 1, vce (cluster imada)
			
				mat def `outcome'_reg[1,4] = _b[beneficiaire]
				mat def `outcome'_reg[2,4] = _se[beneficiaire]
				mat def `outcome'_reg[5,4] = _b[NbHabitants]
				mat def `outcome'_reg[6,4] = _se[NbHabitants]
				
				local N4 = e(N)
				local R4 = round(e(r2),0.001)
		
	
	esttab between within spill1 spill2, se keep (beneficiaire programs NbHabitants) ///
											order(beneficiaire programs NbHabitants)
	
				
	mata `outcome'_reg = st_matrix("`outcome'_reg")
	
	mmat2tex `outcome'_reg using "Tables/Regression/Table_`counter_reg'.tex", replace ///
	preheader("\begin{tabular}{l*{6}{c}}\hline&\multicolumn{1}{c}{Between}&\multicolumn{1}{c}{Within}&\multicolumn{1}{c}{Spillovers}&\multicolumn{1}{c}{Intensity}\\ \hline") ///
						bottom("\hline \textit{Obs} & `N1' & `N2' & `N3' & `N4'  \\ \textit{R2} & `R1' & `R2' & `R3' & `R4' \\ \hline \end{tabular}") ///
						rownames(row1 row2 row3 row4 row5 row6)   ///
						substitute(row1 "CWLP" row2 "" row3 "Workers" row4 "" row5 "\# Habitants" row6 " ") ///
						fmt(%12.4f %12.4f %12.4f %12.4f) ///
						coeff(pos((1,1) (6,4)) par)
						
	local counter_reg = `counter_reg' +1
	
}



/* --> Avoid running this part as some contens have been manually added to the 
	   Tex file (estimation strategy)
*/

* Prepare Tex File 

	file open tex_histo using "Tunisia Result.tex", text write replace
	file write tex_histo "\documentclass[10pt,a4paper]{article}"				_n
	file close tex_histo
	
	file open tex_histo using "Tunisia Result.tex", text write append
	file write tex_histo "\usepackage[latin1]{inputenc}"						_n
	file close tex_histo
	
	file open tex_histo using "Tunisia Result.tex", text write append
	file write tex_histo "\usepackage{amsmath}"									_n
	file close tex_histo
	
	file open tex_histo using "Tunisia Result.tex", text write append
	file write tex_histo "\usepackage{amsfonts}"								_n
	file close tex_histo
	
	file open tex_histo using "Tunisia Result.tex", text write append
	file write tex_histo "\usepackage{amssymb}"									_n
	file close tex_histo
	
	file open tex_histo using "Tunisia Result.tex", text write append
	file write tex_histo "\usepackage{graphicx}"								_n
	file close tex_histo	
	
	file open tex_histo using "Tunisia Result.tex", text write append
	file write tex_histo "\usepackage{stata}"									_n
	file close tex_histo		
	
	file open tex_histo using "Tunisia Result.tex", text write append
	file write tex_histo "\usepackage{float}"									_n
	file close tex_histo	
	
	file open tex_histo using "Tunisia Result.tex", text write append
	file write tex_histo "\usepackage{caption}"									_n 
	file close tex_histo
	
	file open tex_histo using "Tunisia Result.tex", text write append
	file write tex_histo "\usepackage{setspace}"								_n
	file close tex_histo
	
	file open tex_histo using "Tunisia Result.tex", text write append
	file write tex_histo "\usepackage{pdflscape}"								_n
	file close tex_histo
	
	file open tex_histo using "Tunisia Result.tex", text write append
	file write tex_histo "\usepackage{hyperref}"								_n
	file close tex_histo
	
	file open tex_histo using "Tunisia Result.tex", text write append
	file write tex_histo "\hypersetup{"											_n
	file close tex_histo
	
	file open tex_histo using "Tunisia Result.tex", text write append
	file write tex_histo 	"colorlinks,"										_n
	file close tex_histo
	
	file open tex_histo using "Tunisia Result.tex", text write append
	file write tex_histo 	"citecolor=black,"									_n
	file close tex_histo
	
	file open tex_histo using "Tunisia Result.tex", text write append
	file write tex_histo 	"filecolor=black,"									_n
	file close tex_histo
	
	file open tex_histo using "Tunisia Result.tex", text write append
	file write tex_histo 	"linkcolor=black,"									_n
	file close tex_histo
	
	file open tex_histo using "Tunisia Result.tex", text write append
	file write tex_histo 	"urlcolor=black"									_n
	file close tex_histo
	
	file open tex_histo using "Tunisia Result.tex", text write append
	file write tex_histo "}"													_n
	file close tex_histo
	
	file open tex_histo using "Tunisia Result.tex", text write append
	file write tex_histo "\usepackage{longtable}"								_n
	file close tex_histo		
	
	file open tex_histo using "Tunisia Result.tex", text write append
	file write tex_histo "\begin{document}"										_n
	file close tex_histo
	
	file open tex_histo using "Tunisia Result.tex", text write append
	file write tex_histo "\author{Ferrah Samih}\title{Tunisia CWLP: Histogram}\maketitle"	_n
	file close tex_histo
	
	file open tex_histo using "Tunisia Result.tex", text write append
	file write tex_histo "\pagebreak"											_n
	file close tex_histo
	
	file open tex_histo using "Tunisia Result.tex", text write append
	file write tex_histo "\listoffigures"										_n
	file close tex_histo
	
	file open tex_histo using "Tunisia Result.tex", text write append
	file write tex_histo "\pagebreak"											_n
	file close tex_histo
	
	file open tex_histo using "Tunisia Result.tex", text write append
	file write tex_histo 														_n ///
	"\section{Empirical Methodology}"	_n ///
	"We estimate the following equation:"	_n ///
	"\begin{itemize}"	_n ///
	"\item Between Village: \begin{equation} Y_{iv} = \beta_{0} + \beta_{1}CWLP_{v} + \beta_{2}X_{v} + \epsilon_{v} \end{equation}"	_n ///
	"\item Within Village: \begin{equation} Y_{iv} = \beta_{0} + \beta_{1}WORKERS_{iv} + \beta_{2}X_{v} + \epsilon_{iv} \end{equation}"	_n ///
	"\item Spillovers: \begin{equation} Y_{iv} = \beta_{0} + \beta_{1}CWLP_{v} + \beta_{2}X_{iv} + \epsilon_{iv} \end{equation}" 	_n ///
	"\item Intensity: \begin{equation} Y_{iv} = \beta_{0} + \beta_{1}CWLP_{v} + \beta_{2}HABITANTS_{v} + \beta_{3}X_{iv} + \epsilon_{iv} \end{equation}"	_n ///
	"\item Intensity Interacted: \begin{equation} Y_{iv} = \beta_{0} + \beta_{1}CWLP_{v} + \beta_{2}HABITANTS_{v} + \beta_{3}CWLP_{v}*HABITANTS_{v} + \beta_{4}X_{iv} + \epsilon_{jv} \end{equation}"	_n ///
	"\item Full: \begin{equation} Y_{iv} = \beta_{0} + \beta_{1}CWLP_{v} + \beta_{2}WORKERS_{v} + \beta_{3}X_{v} + \epsilon_{v} \end{equation}" _n ///
	"\end{itemize}"		_n ///
	"Where $CWLP_{v}$ is a dummy indicating whether a community (\textit{v}) was recipient of a CWLP infrastructure project, $WORKERS_{iv}$ is a dummy indicating whether individual \textit{i} in village \textit{v} was offered an employment in a CWLP infrastructure project. Last specification compare eligible beneficiary not offered employment in treated communities to eligible beneficiaries in control communities. $HABITANTS_{v}$ is a continuous variable measuring the size of the village \textbf{(NOTE THAT THE NUMBER OF HABITANTS IN THE IMADA IS CORRELATED TO THE TREATMENT ASSIGNMENT (BOTH FOR CWLP AND WORKERS))}." 	_n ///
	"\pagebreak"	_n 
	file close tex_histo
	
	forvalue i = 1/15{
		
		file open tex_histo using "Tunisia Result.tex", text write append
		file write tex_histo "\section{`caption_`i''}"							_n
		file close tex_histo	
		
		file open tex_histo using "Tunisia Result.tex", text write append
		file write tex_histo "\begin{table}[H]\centering"						_n
		file close tex_histo
		
		file open tex_histo using "Tunisia Result.tex", text write append
		file write tex_histo "\input{Tables/Summary/Table_`i'.tex}"				_n
		file close tex_histo
		
		file open tex_histo using "Tunisia Result.tex", text write append
		file write tex_histo "\end{table}"										_n
		file close tex_histo
		
		file open tex_histo using "Tunisia Result.tex", text write append
		file write tex_histo "\begin{figure}[H]\centering"						_n
		file close tex_histo
			
		file open tex_histo using "Tunisia Result.tex", text write append
		file write tex_histo "\includegraphics[scale=0.75]{Graph/Combined/Figure_`i'.pdf}" _n
		file close tex_histo
			
		file open tex_histo using "Tunisia Result.tex", text write append
		file write tex_histo "\caption{`caption_`i''} \label{fig:Fig_`i'}"		_n
		file close tex_histo
			
		file open tex_histo using "Tunisia Result.tex", text write append
		file write tex_histo "\end{figure}"										_n
		file close tex_histo
		
		file open tex_histo using "Tunisia Result.tex", text write append
		file write tex_histo "\begin{table}[H]\centering"						_n
		file close tex_histo
		
		file open tex_histo using "Tunisia Result.tex", text write append
		file write tex_histo "\input{Tables/Regression/Table_`i'.tex}"			_n
		file close tex_histo
		
		file open tex_histo using "Tunisia Result.tex", text write append
		file write tex_histo "\end{table}"										_n
		file close tex_histo
		
		file open tex_histo using "Tunisia Result.tex", text write append
		file write tex_histo "\pagebreak" 										_n
		file close tex_histo
		
		}
		
	file open tex_histo using "Tunisia Result.tex", text write append
	file write tex_histo "\end{document}"										_n
	file close tex_histo	
		





