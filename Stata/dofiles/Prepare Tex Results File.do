/* --> Avoid running this part as some contens have been manually added to the 
	   Tex file (estimation strategy) */

cap file close tex_histo


use "$stata/enquete_All3", clear 

local Index_ALL 			lab_market_main /*lab_market_sec*/ eco_welfare consumption_food consumption_other				///
							assets home_assets comms_assets productive_assets 												///
							credit_access pos_coping_mechanisms neg_coping_mechanisms										///
							shocks social civic well_being woman_bargain woman_violence woman_empowerment 	
							
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
	file write tex_histo "\usepackage{booktabs}"								_n
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
	file write tex_histo "\tableofcontents"										_n
	file close tex_histo
	
	file open tex_histo using "Tunisia Result.tex", text write append
	file write tex_histo "\pagebreak"											_n
	file close tex_histo
	
	file open tex_histo using "Tunisia Result.tex", text write append
	file write tex_histo 														_n ///
	"\section{Empirical Methodology}"											_n ///
	"We estimate the following equation:"										_n ///
	"\begin{itemize}"															_n ///
	"\item Between Village: \begin{equation} Y_{iv} = \beta_{0} + \beta_{1}CWLP_{v} + \beta_{2}X_{v} + \epsilon_{v} \end{equation}"				_n ///
	"\item Within Village: \begin{equation} Y_{iv} = \beta_{0} + \beta_{1}WORKERS_{iv} + \beta_{2}X_{v} + \epsilon_{iv} \end{equation}"			_n ///
	"\item Spillovers: \begin{equation} Y_{iv} = \beta_{0} + \beta_{1}CWLP_{v} + \beta_{2}X_{iv} + \epsilon_{iv} \end{equation}" 				_n ///
	"\item Full: \begin{equation} Y_{iv} = \beta_{0} + \beta_{1}CWLP_{v} + \beta_{2}WORKERS_{v} + \beta_{3}X_{v} + \epsilon_{v} \end{equation}" _n ///
	"\end{itemize}"																_n ///
	"Where $ CWLP_{v} $ is a dummy indicating whether a community (\textit{v}) was recipient of a CWLP infrastructure project, $ WORKERS_{iv} $ is a dummy indicating whether individual \textit{i} in village \textit{v} was offered an employment in a CWLP infrastructure project. Last specification compare eligible Workers not offered employment in treated communities to eligible beneficiaries in control communities." 		_n ///
	"\pagebreak"																_n ///
	"\section{Balance Test}"													_n ///
	"\begin{table}[H]\centering\caption{Individual balance test}" 				_n ///
	"\resizebox{\textwidth}{!}{\input{Main/Table_Balance_Individual.tex}}"		_n ///
	"\end{table}" 																_n ///
	"\begin{table}[H]\centering\caption{Community balance test}" 				_n ///
	"\scalebox{0.80}{\input{Main/Table_Balance_Community.tex}}"		_n ///
	"\end{table}" 																_n ///
	"\pagebreak"																_n ///
	"\section{Main Table}"														_n ///
	"\begin{table}[H]\centering\caption{Main results}" 							_n ///
	"\resizebox{\textwidth}{!}{\input{Main/Table_Index.tex}}"					_n ///
	"\end{table}" 																_n ///
	"\begin{table}[H]\centering\caption{Main results}" 							_n ///
	"\scalebox{0.80}{\input{Main/Table_Index_Full.tex}}"				_n ///
	"\end{table}" 																_n ///
	"\pagebreak"																_n ///
	"\begin{table}[H]\centering\caption{Extended main results}" 				_n ///
	"\resizebox{\textwidth}{!}{\input{Main/Table_Index_Extended.tex}}"			_n ///
	"\end{table}" 																_n ///
	"\begin{table}[H]\centering\caption{Extended main results}" 				_n ///
	"\scalebox{0.60}{\input{Main/Table_Index_Full_Extended.tex}}"		_n ///
	"\end{table}" 																_n ///
	"\pagebreak"																_n
	
	file close tex_histo
	
	local i = 0 
	
	file open tex_histo using "Tunisia Result.tex", text write append
	
	foreach index of local Index_ALL{
			
	local l_`index' : variable label IAaS`index'
		
		local i = `i' + 1
		
		file write tex_histo "\section{`l_`index''}"							_n
	
		file write tex_histo "\begin{table}[H]\centering"						_n
		
		file write tex_histo "\input{Tables/Summary/Table_`i'.tex}"				_n
		
		file write tex_histo "\end{table}"										_n
		
		file write tex_histo "\begin{figure}[H]\centering"						_n
			
		file write tex_histo "\includegraphics[scale=0.75]{Graph/Combined/Figure_`i'.pdf}" _n
			
		file write tex_histo "\caption{`caption_`i''} \label{fig:Fig_`i'}"		_n
			
		file write tex_histo "\end{figure}"										_n
		
		file write tex_histo "\begin{table}[H]\centering\caption{Model without Imada fixed effect}"						_n
		
		file write tex_histo "\input{Tables/Regression/Table_`i'.tex}"			_n
		
		file write tex_histo "\end{table}"										_n
		
		file write tex_histo "\begin{table}[H]\centering\caption{Model with Imada fixed effect}"						_n
		
		file write tex_histo "\input{Tables/Regression/Table_`i'_b.tex}"		_n
		
		file write tex_histo "\end{table}"										_n
		
		file write tex_histo "\begin{table}[H]\centering\caption{Subsample of woman respondent}"						_n
		
		file write tex_histo "\input{Tables/Regression/Table_`i'_w.tex}"		_n
		
		file write tex_histo "\end{table}"										_n
		
		file write tex_histo "\begin{table}[H]\centering\caption{Subsample of male respondent}"						_n
		
		file write tex_histo "\input{Tables/Regression/Table_`i'_m.tex}"		_n
		
		file write tex_histo "\end{table}"										_n
		
		file write tex_histo																_n ///
	"\begin{table}[H]\centering\caption{Individual outcomes used in group: `l_`index'' }"	_n ///
	"\resizebox{\textwidth}{!}{\input{Tables/Individual/Table_`index'.tex}}"				_n ///
	"\end{table}"																			_n ///
	"\begin{table}[H]\centering\caption{Individual outcomes used in group: `l_`index'' (full specification)}"	_n ///
	"\resizebox{\textwidth}{!}{\input{Tables/Individual/Table_`index'_Full.tex}}"			_n ///
	"\end{table}"																			_n ///
	"\pagebreak"																			_n
	
	}
	
	file write tex_histo "\end{document}"										_n
	file close tex_histo	
