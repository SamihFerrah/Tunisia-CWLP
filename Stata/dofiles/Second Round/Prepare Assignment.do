********************************************************************************
*			PREPARE SAMPLE LIST OF CASH GRANT INTERVENTION
********************************************************************************
set seed 12345


local var_export 	HHID Gender Nom Age Imada Adresse CIN Father Status Intervention Partenaire Telephone1 Telephone2	///
	 TCLP PSU

* Import list of respondent prepared by Julie 

import excel using "$rando/Dataset/3_final/TCLP2018_rando_FULL.xls", clear first

g Gender = "Female"

* Export list of ID with corrected one for female respondent 
	
preserve 
	
	keep hhid repondant_age repondant_name locality
	
	rename hhid 	ID 
	rename locality LOCALITY
	
	sa "$home/14. Female Entrepreneurship Add on/Data/General/First Fix.dta", replace
	
restore
	
* Get most updated informations from Baseline 

preserve 

	u "$home/14. Female Entrepreneurship Add on/Data/Randomization/Datawork/02_Baseline/01.Dataset/03_Final/TCLP2018_BL_CashTransfert.dta", clear
	
	keep hhid cin tel_number tel_number2  partenaire_nom
	
	rename tel_number 		telephone1 
	rename tel_number2 		telephone2
	rename partenaire_nom 	Partenaire_Nom
	
	destring tel* hhid cin, replace 
	
	tempfile baseline 
	sa   	`baseline'

restore 

merge 1:1 hhid using `baseline', update

* Keep relevant variable

keep 	hhid imada tclprando tclprando_partner repondant_name locality adresse 	///
		telephone1 telephone2 psu gpslatitude gpslongitude 						///
		Partenaire_Nom repondant_age

* Rename variable

rename 	(hhid imada tclprando tclprando_partner repondant_name locality adresse	///
		telephone1 telephone2 psu repondant_age) 								///
		(HHID Imada Status Partenaire Nom Localite Adresse Telephone1 			///
		Telephone2 PSU Age)
		
* Order variables

order 	HHID Nom Age Localite Adresse Status Partenaire Telephone1 Telephone2	///
		Status Partenaire PSU Partenaire_Nom
		
* Sort by Imada and Nom

sort Imada Nom

* Fill gap

	* Recode Partenaire variable 
	
	replace Partenaire = "Non" if Partenaire == "Treatment"
	replace Partenaire = "Oui" if Partenaire == "Treatment with partner"
	replace Partenaire = "Non" if Partenaire == ""
	
	
	* Merge with clean TCLP round 1 to fill missing locality variables
	
	preserve 
		
		use "$home/14. Female Entrepreneurship Add on/Data/First round/enquete_All3.dta", clear
		
		
		recast str150 repondant_name

		g 		Gender = "Female" 	if repondant_sex == 0 
		replace Gender = "Male" 	if repondant_sex == 1
		
		g 		TCLP = "Non"
		replace TCLP = "Oui" if programs == 1
		
		* Add HHID fix 
		
		/* Not sure why (should ask previous RA), but 1993 individuals share an 
		ID ranging from 1 to 26. For those, we change it based on their position 
		on the list
		
		1) Import list of really bad fix of previous RA 
		2) Replace bad fix 
		3) Create new fix for sample of male respondent whom has not been fixed 
		4) Create master list to identify across all dataset 
		
		*/
		
		* Fix one missing age (for merging purpose)
		
		g missing_age = 1 if repondant_age ==.
		
		sum repondant_age
		
		replace repondant_age = `r(mean)' if repondant_age ==.
		
		drop ID 
		
		merge 1:1 repondant_name repondant_age LOCALITY using "$home/14. Female Entrepreneurship Add on/Data/General/First Fix.dta"
						
		sum ID
		
		local max_ID = `r(max)'
		
		replace ID = `max_ID' + _n if ID ==. 
		
		drop hh_id		
		
		* Fix missing GPS
		replace gpslatitude 	= q8latitude 	if gpslatitude == .
		replace gpslongitude 	= q8longitude 	if gpslongitude == .
	
		* Fix missing phone
		
		*Cell
		ren cell 		Telephone1
		ren telephone 	Telephone2
		ren FIRST_NAME_FATHER Father
		
		keep 	ID imada_str repondant_name adresse Telephone? psu gpslatitude 	///
				gpslongitude repondant_age missing_age between spillovers 		///
				within infrastructure full Strata repondant_sex beneficiaire	///
				programs parti desist control enquete imada CIN Father Gender TCLP
		
		g PSU = psu 
	
		drop psu
		
		g Imada = imada_str
		
		rename 	(ID repondant_name adresse) 							///
				(HHID Nom1 Adresse1)
		
		
		duplicates drop
		
		tostring _all, replace
		destring HHID Telephone?, replace
		
		tempfile locality
		sa		`locality'
		
	restore
	
	merge 1:1 HHID using `locality', update
	
	drop Localite
	
	replace Nom = Nom1 if Nom =="" 
	
	destring repondant_age, replace
	
	replace Age = repondant_age if Age ==.
		
	replace Adresse = Adresse1 if Adresse == "" 

	g 		sample_ = "Cash Grants" 		if _merge ==3 | _merge == 4 | _merge == 5
	replace sample_ = "Follow up - TCLP" 	if _merge == 2
	
	* Export list of fixed ID with PII to be able to merge it with other datasets
	
	preserve 
		
		keep HHID Nom Age Imada missing_age
		
		g repondant_age 	= Age 
		g repondant_name 	= Nom 
	
		sa "$home/14. Female Entrepreneurship Add on/Data/General/Final ID Fix.dta", replace 
		
	restore 

* Change format wide to long to duplicate respondents and their partners 

preserve 
	
	keep if sample_ == "Cash Grants" & Status == "Treatment"
	
	keep HHID Partenaire_Nom Telephone1 Telephone2 Adresse Imada CIN Gender sample_
	
	replace Gender = "Male"
	
	replace Partenaire_Nom = "A completer" if Partenaire_Nom == ""
	
	g ID_HH = _n 
	
	export excel ID_HH HHID using "$home/14. Female Entrepreneurship Add on/Data/General/ID Cash HH.xlsx", firstrow(var) replace 
	
	g Nom = Partenaire_Nom 
	
	replace Partenaire_Nom = ""
	
	replace sample_ = "Cash Grants - Partenaire"
		
	tempfile 	partenaire 
	sa		   `partenaire'

restore 

append using `partenaire'

* Assign HH code common to woman and male fo same HH 

g HH = HHID 

*Reassign code to cash grant partners 

sum HHID

local max_id = `r(max)'

replace HHID = `max_id' + _n if sample_ == "Cash Grants - Partenaire"

* Export respondent list of Treatment cash grant intervention 

preserve 

	keep if sample_ == "Cash Grants" | sample_ == "Cash Grants - Partenaire"
	
	drop if Status == "Replacement"
	
	destring between within infrastructure spillovers programs, replace	
	
	sort Imada HH Nom  
	
	rename sample_ Intervention
	
	replace Intervention = "Cash Grants - Women" if Intervention == "Cash Grants"
	
	sa 	"A:/Assignment/Cash Grant Sample.dta", replace 
	
	keep if Intervention == "Cash Grants - Partenaire" | ///
			Intervention == "Cash Grants - Women" & Status == "Treatment"
	order 	HHID Gender Nom Age Imada Adresse CIN Father Status Intervention Partenaire Partenaire_Nom Telephone1 	///
			Telephone2 TCLP PSU Intervention
	

	export excel `var_export' Partenaire_Nom using 	"A:/Assignment/Cash Grant Sample.xlsx", sheet("Treatment & Partner") firstrow(var) replace

restore 
	
	
* Export respondent list of Treatment cash grant intervention 

preserve 

	keep if sample_ == "Cash Grants" | sample_ == "Cash Grants - Partenaire"
	
	drop if Status == "Replacement"
	
	destring between within infrastructure spillovers programs, replace	
	
	sort Imada HH Nom  
	
	rename sample_ Intervention
	
	replace Intervention = "Cash Grants - Women" if Intervention == "Cash Grants"
	
	keep if Intervention == "Cash Grants - Women" & Status == "Control"
	
	order 	HHID Gender Nom Age Imada Adresse CIN Father Status Intervention Partenaire Partenaire_Nom Telephone1 	///
			Telephone2 TCLP PSU Intervention
	
	export excel `var_export' Partenaire_Nom using 	"A:/Assignment/Cash Grant Sample.xlsx", sheet("Control", replace) firstrow(var) 
	
restore 
	
	* Draw random sample of CWLP participant for follow up 
	
	keep if sample_ == "Follow up - TCLP"
	
	cap drop select3_groups select2_elig
	
	destring between within infrastructure spillovers programs, replace
	
	gen eligible = .
	
	* Workers eligible to be drawn
	replace eligible = 1 if programs == 1 
	
	* Control workers
	replace eligible = 2 if programs == 0 & beneficiaire == 1
	
	* Synthetic control
	replace eligible = 3 if enquete == 3
	
	lab def select3_groups ///
		1 "Workers" ///
		2 "Control" ///
		3 "Synthetic control", modify

	lab val eligible select3_groups
	
	preserve
	
		keep if eligible ==3 
		
		g trt_followup = 1
		replace Status = "Follow Up"
		count
		
		tempfile synthetic 
		sa 		`synthetic'
		
	restore 
	
	drop if eligible == 3														// Select all synthtetic control so dropped from randomization and appened later
	
	keep if eligible !=.													// Drop community sample from sample to be randomized
	count
	
	randtreat, 	generate(trt_followup) replace strata(imada eligible) 			///
				misfits(wglobal) mult(2) unequal(359/1201 842/1201)			///
				setseed(12345)
				
	
	lab 	def trt_followup 0 "Non selected" 1 "Follow Up", modify
	lab 	val trt_followup trt_followup
	lab 	var trt_followup "Follow up status"

	replace Status = "Follow Up" if trt_followup == 1 
	
	append using `synthetic'
	
* Export list of follow up respondent 

preserve 

	keep if trt_followup == 1

	randtreat, 	generate(replacement) replace strata(imada eligible) 			///
				misfits(wglobal) mult(2) unequal(1000/1200 200/1200)				///
				setseed(12345)
				
	lab 	def replacement 0 "Non Replacement" 1 "Replacement", modify
	lab 	val replacement replacement
	lab 	var replacement "Replacement"
	
	rename sample_ Intervention 
	
	sa 		"A:/Assignment/Follow up Sample.dta", replace
		
	keep if replacement == 0
	
	sort Imada HHID Nom
	
	order 	HHID Gender Nom Age Imada Adresse CIN Father Intervention Partenaire Telephone1 Telephone2	///
			PSU 	
	
	export excel `var_export' using "A:/Assignment/Follow Up Sample.xlsx", firstrow(var) replace 
	
restore 

* Export ordered list of replacement

preserve 
	
	u "A:/Assignment/Follow up Sample.dta", clear
	
	keep if replacement == 1 
	
	sort Imada
	
	bys Imada: g order_ = runiform(0,1)
	
	sort order_ 
	
	bys imada eligible: g Ordre = _n
	
	sort Imada

	order Imada Ordre HHID Gender Nom Age Imada Adresse CIN Father Intervention Partenaire Telephone1 Telephone2	///
			PSU 
	
	export excel Imada Ordre HHID Gender Nom Age Imada Adresse CIN Father Intervention Partenaire Telephone1 Telephone2	///
			PSU using "A:/Assignment/Replacement.xlsx", firstrow(var) replace 
			
restore

* Export main list 

clear 

u 				"A:/Assignment/Follow up Sample.dta", clear
append using  	"A:/Assignment/Cash Grant Sample.dta"

bys Strata : tab Status 

sort Imada HH Nom 

order 	HHID Gender Nom Age Imada Adresse CIN Father Intervention Partenaire Partenaire_Nom Telephone1 Telephone2	///
		TCLP PSU 	

export excel `var_export' Partenaire_Nom using "A:/Assignment/Full Sample.xlsx", firstrow(var) replace

sa 				   				"A:/Assignment/Full Sample.dta", replace 
	
	
* Export GPS csv to map respondent and help enumeratos find them 

preserve 

		keep gps* HHID Status
		export delimited "$home/14. Female Entrepreneurship Add on/Survey material/Maps/Full_Sample_GPS.csv", replace 
		
restore

* Export preload for questionnaire 

g 		treatment2 = .
replace treatment2 = 0 if Intervention == "Cash Grants - Partenaire"
replace treatment2 = 1 if Intervention == "Cash Grants - Women"
replace treatment2 = 2 if Intervention == "Follow up - TCLP" 

replace Nom = "" if Nom == "A completer"

g complete_name 	= 1 if Nom == ""
g complete_age 		= 1 if Age == .
g complete_phone 	= 1 if Telephone1 ==. | Telephone2 ==.
g complete_CIN 		= 1 if CIN ==""

g complete_info 	= 1 if 	complete_name 	== 1 | ///
							complete_age 	== 1 | ///
							complete_phone 	== 1 

g 		trt_cash = .
replace trt_cash = 0 if Status == "Control"
replace trt_cash = 1 if Status == "Treatment"

rename HHID HHID_key

destring CIN, replace 

outsheet HHID_key Age Gender Nom CIN PSU treatment2 complete_* trt_cash using "A:/Assignment/preload_tunisia_cashgrants.csv", comma replace 



