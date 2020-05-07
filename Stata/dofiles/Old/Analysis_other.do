
*AJOUTER LES INDEX À L'ANALYSE

set matsize 10000
set more off
*ADD THE VARIABLE: RECEIVED A PWP PREVIOUSLY OR NOT.

*all indiv outcomes, in order of category. with repetition for rev_total and psych_a_menage

*controls:ADJUSTED TO REFLECT THE ONES THAT ARE NOT BALANCED.


*CREATE DATASETS FOR ANALYSIS FROM MULTIPLE IMPUTATION
use $stata/enquete_All3, clear 

gen program=(parti==1 | desist==1)


***********************************************************************************************************************
***********************************************************************************************************************





* ERIC'S PRT TALK JAN 2018

* VIOLENCE
*local_conflict									//land dispute?						
local five_years_chef		q4_26_dum q4_27_dum /*q4_34_dum*/
/*local six_months_chef		q1_1_1 q1_1_2 q1_1_3 q1_1_4 q1_1_5 q1_1_6 q1_1_7*/
*local_security
*local local_sec_all			securite_1 /*securite_2*/ securite_3bis /*securite_4*/ securite_5bis securite_6bis
local intrahh_prt			intrahh_7bis2 intrahh_11bis2 violence_physicalbis violence_emotionalbis

* SOCIAL CAPITAL/COLLECTIVE ACTION
local social_capital		association_dummybis /*psy_accepte_dum3bis psy_menage_dum3bis*/ psy_a_menage_dum3bis2	///
							q4_28_dum //trust chief

local cooperation			initiative_dummybis comite_cbis2 comite_c_menagebis2 comite_c_autrevillage
local participation			initiatives_1bis2 initiatives_2bis2 initiatives_3bis2 initiatives_4bis2 initiatives_5bis2 ///
							initiatives_6bis2 initiatives_7bis2 initiatives_8bis2 utopie_a_dum1bis2 utopie_b_dum1bis2 ///
							utopie_c_dum1 utopie_e_dum1 q4_35_dum
local pol_isolation			isolement_1bis isolement_2bis isolement_3bis isolement_4bis source_info_internalbis2 	///
							source_info2_internbis2






*******[TABLE 1 - LOCAL VIOLENCE/CONFLICT (AND SOME EXTRA ECON OUTCOMES]******

/*local local_conflict		conflit_dispute_inbis conflit_dispute_outbis securite_1
local five_years_chef		q4_26_dum q4_27_dum q4_34_dum						// actually not dummies
local local_security		securite_3bis securite_5bis securite_6bis
local local_sec_all			securite_2 securite_3bis securite_4 securite_5bis securite_6bis
local intrahh_prt			intrahh_7bis2 intrahh_11bis2 violence_physicalbis violence_emotionalbis
*/

* For binary dependent variable command
local violence_crime_d		conflit_dispute_in conflit_dispute_out securite_1 /*securite_2*/ securite_3 ///
							/*securite_4*/ securite_5 securite_6 intrahh_7 intrahh_11 violence_physical ///
							violence_emotional local_conflict security_incident economic_violence		///
							change_crime_vio emploi informal_sector formal_sector business_q0 			
							
* Local Conflict Dummy
gen	    local_conflict = .
replace local_conflict = 0 if conflit_dispute_in == 0 & conflit_dispute_out == 0 & securite_1 == 0
foreach var of varlist		conflit_dispute_in conflit_dispute_out securite_1		{
	replace local_conflict = 1 if `var' == 1
}	
label variable local_conflict	"Local Conflict"

* Security Incidents
gen	    security_incident = .
replace security_incident = 0 if securite_3 == 0 & securite_5 == 0 & securite_6 == 0
foreach var of varlist		securite_3 securite_5 securite_6 			{
	replace security_incident = 1 if `var' == 1
}	
label variable security_incident	"Local Security Incident"

* Economic Violence
gen	    economic_violence = .
replace economic_violence = 0 if intrahh_7 == 0 & intrahh_11 == 0 
foreach var of varlist		intrahh_7 intrahh_11						{
	replace economic_violence = 1 if `var' == 1
}	
label variable economic_violence	"Economic Violence"

* Change Theft/Violence
gen	    change_crime_vio = .
replace change_crime_vio = 0 if q4_26_dum == 0 & q4_26_dum == 0 
foreach var of varlist		q4_26_dum q4_27_dum					{
	replace change_crime_vio = 1 if `var' == 1
	replace change_crime_vio = 1 if `var' == 0.5
}	
label variable change_crime_vio	"Change Local Crime Vio"

* For regress command	
local violence_crime_chef	q4_26_dum q4_27_dum days_worked hours_worked /*q4_34_dum*/						// actually not dummies

							
local violence_indAa		IAalocal_conflict	IAafive_years_chef IAalocal_security	IAalocal_sec_all 	IAaintrahh_prt
local violence_indBa		IBalocal_conflict	IBafive_years_chef IBalocal_security	IBalocal_sec_all 	IBaintrahh_prt
local violence_indBb		IBblocal_conflict	IBbfive_years_chef IBblocal_security	IBblocal_sec_all 	IBbintrahh_prt
local violence_indCa		ICalocal_conflict	ICafive_years_chef ICalocal_security	ICalocal_sec_all 	ICaintrahh_prt
local violence_indCb		ICblocal_conflict	ICbfive_years_chef ICblocal_security	ICblocal_sec_all	ICbintrahh_prt

label variable association_dummy 		"Association Member"
label variable comite_c 				"Coop in Imada"
label variable comite_c_menage 			"HH Coop Member"
label variable conflit_dispute_in		"HH Conflict within Imada"
label variable conflit_dispute_out		"HH Conflict with Outside"
label variable IAalocal_conflict		"Local Conflict Index"
label variable IAafive_years_chef		"Community Level Violence"
label variable IAalocal_security		"Local Security Index"
label variable IAalocal_sec_all			"Local Security Index All"
label variable IAaintrahh_prt			"Intrahh Index"
label variable IAasocial_cohesion2		"Social Cohesion Index"
label variable securite_1				"Land Conflict"
label variable securite_2				"Arms Discovery"
label variable securite_3			  	"Theft of Household Goods"
label variable securite_4				"Physical Aggression"
label variable securite_5				"Domestic Violence"
label variable securite_6				"Armed Robbery or Murder"
label variable intrahh_7				"Spouse Decides Money Use"
label variable intrahh_11				"Earnings Confiscated 6M"
label variable violence_physical		"Phyiscal Violence 12M"
label variable violence_emotional		"Emotional Violence 12M"
label variable q4_26_dum 				"Change Theft"						// positive result better
label variable q4_27_dum 				"Change Violence"					// positive result better
label variable q4_28_dum				"Change Trust"						// positive result better
label variable q4_34_dum				"Change Violent Protest" 			// positive result better	
label variable q4_35_dum				"Change Peceful Protest"			// positive result better
label variable repondant_educ			"Education"


*** ECONOMIC VARS *** 
label variable emploi					"Any Economic Activity"
label variable informal_sector 			"Informal Sector Employment"
label variable formal_sector 			"Formal Sector Employment"
label variable days_worked 				"Days of Month Worked"
label variable hours_worked 			"Hours of Day Worked"
label variable business_q0 				"Business Ownership"



***********************************************************************************************
*ANALYSIS FOR AART (HUMAN CAPITAL)*************************************************************
***********************************************************************************************
gen 		literate = repondant_educ
replace		literate = 2 if repondant_educ > 1
replace literate = 0 if literate == 1
replace literate = 1 if literate == 2

ttest local_conflict if (parti==1 | desist==1 | enquete==3) & beneficiaire == 0, by(literate)
ttest security_incident if (parti==1 | desist==1 | enquete==3)& beneficiaire == 0, by(literate) 

*Between (can't read/write)
	estimates clear
	preserve 
	keep if (parti==1 | desist==1 | enquete==3) & repondant_educ==1
	local RAa ""
	local ctlmean ""

	foreach outcome of local violence_crime_d			{
		glm `outcome'  beneficiaire `ctrl_Aa', family(binomial) link(probit) vce(cluster imada)
		eststo `outcome'	: margins, dydx(beneficiaire) atmeans post
	
	*Column heading variable label
		local varlbl : variable label `outcome'
		local varlbl = subinstr("`varlbl'", " " , "_" , .)
		di "`varlbl'"
		
		estimates store `varlbl'
		local RAa `RAa' `varlbl'

	*control mean	
		sum 	`outcome' if beneficiaire == 0
		estadd scalar Control_Mean= r(mean)		
		sum 	`outcome' if beneficiaire == 1
		estadd scalar Treatment_Mean= r(mean)		
	}
	
	foreach outcome_ind of varlist `violence_indAa' {
		regres `outcome_ind' beneficiaire `ctrl_Aa', vce (cluster imada)
	
	*Column heading variable label
		local varlbl_ind : variable label `outcome_ind'
		local varlbl_ind = subinstr("`varlbl_ind'", " " , "_" , .)
		di "`varlbl_ind'"
		
		estimates store `varlbl_ind'
		local RAa `RAa' `varlbl_ind'
		
		estadd scalar Control_Mean= _b[_cons]	
		sum 	`outcome_ind' if beneficiaire == 1
		estadd scalar Treatment_Mean= r(mean)		
	
	}

								estout `RAa'	using	"$report\Violence_PRT.xls", 		replace 				///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(hhsize drepondant_mat _cons)	label 	///			 	 					
								stats(Control_Mean Treatment_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)		eqlabels(none) 	collabels(none) ///
								title			("Between Villages: direct effects on all workers")	varlabels(beneficiaire "Treatment Community") 
		estimates clear
		restore		


* Between (can read/write)
	estimates clear
	preserve 
	keep if (parti==1 | desist==1 | enquete==3)  & repondant_educ > 1		
	local RAa ""
	local ctlmean ""

	foreach outcome of local violence_crime_d			{
		glm `outcome'  beneficiaire `ctrl_Aa', family(binomial) link(probit) vce(cluster imada)
		eststo `outcome'	: margins, dydx(beneficiaire) atmeans post
	
	*Column heading variable label
		local varlbl : variable label `outcome'
		local varlbl = subinstr("`varlbl'", " " , "_" , .)
		di "`varlbl'"
		
		estimates store `varlbl'
		local RAa `RAa' `varlbl'

	*control mean	
		sum 	`outcome' if beneficiaire == 0
		estadd scalar Control_Mean= r(mean)		
		sum 	`outcome' if beneficiaire == 1
		estadd scalar Treatment_Mean= r(mean)		
	}
	
	foreach outcome_ind of varlist `violence_indAa' {
		regres `outcome_ind' beneficiaire `ctrl_Aa', vce (cluster imada)
	
	*Column heading variable label
		local varlbl_ind : variable label `outcome_ind'
		local varlbl_ind = subinstr("`varlbl_ind'", " " , "_" , .)
		di "`varlbl_ind'"
		
		estimates store `varlbl_ind'
		local RAa `RAa' `varlbl_ind'
		
		estadd scalar Control_Mean= _b[_cons]	
		sum 	`outcome_ind' if beneficiaire == 1
		estadd scalar Treatment_Mean= r(mean)		
	
	}

								estout `RAa'	using	"$report\Violence_PRT.xls", 		append 				///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(hhsize drepondant_mat _cons)	label 	///			 	 					
								stats(Control_Mean Treatment_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)		eqlabels(none) 	collabels(none) ///
								title			("Between Villages: direct effects on all workers")	varlabels(beneficiaire "Treatment Community") 
		estimates clear
		restore		
		

* Between (some educ - not highschool)
	estimates clear
	preserve 
	keep if (parti==1 | desist==1 | enquete==3) & (repondant_educ == 2 | repondant_educ == 3 | repondant_educ == 4)
	local RAa ""
	local ctlmean ""

	foreach outcome of local violence_crime_d			{
		glm `outcome'  beneficiaire `ctrl_Aa', family(binomial) link(probit) vce(cluster imada)
		eststo `outcome'	: margins, dydx(beneficiaire) atmeans post
	
	*Column heading variable label
		local varlbl : variable label `outcome'
		local varlbl = subinstr("`varlbl'", " " , "_" , .)
		di "`varlbl'"
		
		estimates store `varlbl'
		local RAa `RAa' `varlbl'

	*control mean	
		sum 	`outcome' if beneficiaire == 0
		estadd scalar Control_Mean= r(mean)		
		sum 	`outcome' if beneficiaire == 1
		estadd scalar Treatment_Mean= r(mean)		
	}
	
	foreach outcome_ind of varlist `violence_indAa' {
		regres `outcome_ind' beneficiaire `ctrl_Aa', vce (cluster imada)
	
	*Column heading variable label
		local varlbl_ind : variable label `outcome_ind'
		local varlbl_ind = subinstr("`varlbl_ind'", " " , "_" , .)
		di "`varlbl_ind'"
		
		estimates store `varlbl_ind'
		local RAa `RAa' `varlbl_ind'
		
		estadd scalar Control_Mean= _b[_cons]	
		sum 	`outcome_ind' if beneficiaire == 1
		estadd scalar Treatment_Mean= r(mean)		
	
	}

								estout `RAa'	using	"$report\Violence_PRT.xls", 		append 				///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(hhsize drepondant_mat _cons)	label 	///			 	 					
								stats(Control_Mean Treatment_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)		eqlabels(none) 	collabels(none) ///
								title			("Between Villages: direct effects on all workers")	varlabels(beneficiaire "Treatment Community") 
		estimates clear
		restore		

* Between (highschool/uni)
	estimates clear
	preserve 
	keep if (parti==1 | desist==1 | enquete==3) & (repondant_educ == 5 | repondant_educ == 6)
	local RAa ""
	local ctlmean ""

	foreach outcome of local violence_crime_d			{
		glm `outcome'  beneficiaire `ctrl_Aa', family(binomial) link(probit) vce(cluster imada)
		eststo `outcome'	: margins, dydx(beneficiaire) atmeans post
	
	*Column heading variable label
		local varlbl : variable label `outcome'
		local varlbl = subinstr("`varlbl'", " " , "_" , .)
		di "`varlbl'"
		
		estimates store `varlbl'
		local RAa `RAa' `varlbl'

	*control mean	
		sum 	`outcome' if beneficiaire == 0
		estadd scalar Control_Mean= r(mean)		
		sum 	`outcome' if beneficiaire == 1
		estadd scalar Treatment_Mean= r(mean)		
	}
	
	foreach outcome_ind of varlist `violence_indAa' {
		regres `outcome_ind' beneficiaire `ctrl_Aa', vce (cluster imada)
	
	*Column heading variable label
		local varlbl_ind : variable label `outcome_ind'
		local varlbl_ind = subinstr("`varlbl_ind'", " " , "_" , .)
		di "`varlbl_ind'"
		
		estimates store `varlbl_ind'
		local RAa `RAa' `varlbl_ind'
		
		estadd scalar Control_Mean= _b[_cons]	
		sum 	`outcome_ind' if beneficiaire == 1
		estadd scalar Treatment_Mean= r(mean)		
	
	}

								estout `RAa'	using	"$report\Violence_PRT.xls", 		append 				///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(hhsize drepondant_mat _cons)	label 	///			 	 					
								stats(Control_Mean Treatment_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)		eqlabels(none) 	collabels(none) ///
								title			("Between Villages: direct effects on all workers")	varlabels(beneficiaire "Treatment Community") 
		estimates clear
		restore		

		filefilter "$report/Violence_PRTb.xls" "$report/A.Violence_PRTb.xls", from("_") to(" ") replace					







***********************************************************************************************
***********************************************************************************************

	
		
		
		
*ANALYSIS CHIEF VIOLENCE VARS		
/*		
local social_capital		association_dummybis /*psy_accepte_dum3bis psy_menage_dum3bis*/ psy_a_menage_dum3bis2	///
							q4_28_dum //trust chief

local cooperation			initiative_dummybis comite_cbis2 comite_c_menagebis2 comite_c_autrevillage
local participation			initiatives_1bis2 initiatives_2bis2 initiatives_3bis2 initiatives_4bis2 initiatives_5bis2 ///
							initiatives_6bis2 initiatives_7bis2 initiatives_8bis2 utopie_a_dum1bis2 utopie_b_dum1bis2 ///
							utopie_c_dum1 utopie_e_dum1 q4_35_dum
local pol_isolation			isolement_1bis isolement_2bis isolement_3bis isolement_4bis source_info_internalbis2 	///
							source_info2_internbis2
*/
							


/*



*******[TABLE 9 - CIVIC ENGAGEMENT]******
*/
local civic_indicesAa		IAasocial_capital IAacooperation IAaparticipation IAautopie IAapol_isolation	
local civic_indicesBa		IBasocial_capital IBacooperation IBaparticipation IBautopie IBapol_isolation	
local civic_indicesBb		IBbsocial_capital IBbcooperation IBbparticipation IBbutopie IBbpol_isolation
local civic_indicesCa		ICasocial_capital ICacooperation ICaparticipation ICautopie ICapol_isolation							
local civic_indicesCb		ICbsocial_capital ICbcooperation ICbparticipation ICbutopie ICbpol_isolation	

local civic_engagement		association_dummy psy_a_menage_dum3 /*q4_28_dum*/ initiative_dummy comite_c /*comite_c_menage*/ ///
							/*comite_c_autrevillages*/ initiatives_1 initiatives_2 initiatives_3 /*initiatives_6*/ initiatives_4 initiatives_5 ///
							/*initiatives_6*/ initiatives_7 initiatives_8 initiatives_10 /*initiatives_11*/ initiatives_12 /*initiatives_13*/ ///
							initiatives_14 /*initiatives_15*/ utopie_a_dum1 utopie_b_dum1 utopie_d_dum1 						///
							utopie_e_dum1 utopie_c_dum1/*q4_35_dum*/ isolement_1 isolement_2 isolement_3 /*isolement_4*/ 	///
							source_info_internal source_info2_internal utopie_c_dum1 local_leaders national_leaders 		///
							coll_action isolation /*comite_c comite_c_menage comite_c_autrevillages*/

						
							
* Meet Local Leaders
gen	    local_leaders = .
replace local_leaders = 0 if initiatives_1 == 0 & initiatives_2 == 0 & initiatives_3 == 0 & initiatives_6 == 0 
foreach var of varlist		initiatives_1 initiatives_2 initiatives_3 initiatives_6					{
	replace local_leaders = 1 if `var' == 1
}	
label variable local_leaders	"Contact Local Leaders"

* Meet National Leaders
gen	    national_leaders = .
replace national_leaders = 0 if initiatives_4 == 0 & initiatives_5 == 0 & initiatives_7 == 0 & initiatives_8 == 0 
foreach var of varlist		initiatives_4 initiatives_5	initiatives_7 initiatives_8				{
	replace national_leaders = 1 if `var' == 1
}	
label variable national_leaders	"Contact National Leaders"
/*
* Social/Political Participation
gen	    pol_participation = .
replace pol_participation = 0 if initiatives_1 == 0 & initiatives_2 == 0 & initiatives_3 == 0 & initiatives_4 == 0 & ///
								initiatives_5 == 0 & initiatives_6 == 0 & initiatives_7 == 0 & initiatives_8 == 0 
foreach var of varlist		initiatives_1 initiatives_2 initiatives_3 initiatives_4 initiatives_5 initiatives_6     ///
							initiatives_7 initiatives_8	{
	replace pol_participation = 1 if `var' == 1
}	
label variable national_leaders	"Socio Political Part"
*/
* Comm Collective Action
gen	    coll_action = .
replace coll_action = 0 if 		initiatives_10 == 0 & initiatives_11 == 0 & initiatives_12 == 0 & initiatives_13 == 0 & ///
								initiatives_14 == 0 & initiatives_15 == 0
foreach var of varlist			initiatives_10 initiatives_11 initiatives_12 initiatives_13 initiatives_14 initiatives_15  {
	replace coll_action = 1 if `var' == 1
}	
label variable coll_action	"Collective Action"

* Interaction with Outside
gen	    isolation = .
replace isolation = 0 if isolement_1 == 0 & isolement_2 == 0 & isolement_3 == 0
foreach var of varlist		isolement_1 isolement_2 isolement_3			{
	replace isolation = 1 if `var' == 1
}	
label variable isolation	"Interaction with Outside"
				
					
							
local civic_chef			q4_28_dum /*q4_35_dum*/

label variable utopie_c_dum1			"Resort to Violence"
label variable association_dummy 		"Association Member"
label variable psy_a_menage_dum3		"HH Accepted in Community"
label variable comite_c 				"Coop in Imada"
label variable comite_c_menage 			"HH Coop Member"
label variable comite_c_autrevillages	"Coop Works with Outside"
label variable initiative_dummy			"Local Initiative Dummy"
label variable IAasocial_capital		"Social Capital Index"
label variable IAacooperation			"Cooperation Index"
label variable IAaparticipation			"Participation Index"
label variable IAautopie				"Liberal Norms Index"
label variable IAapol_isolation			"Isolation Index"
label variable initiatives_1 			"Village Meeting"
label variable initiatives_2 			"Meet Omda"
label variable initiatives_3 			"Meet Imam"
label variable initiatives_4 			"Contact Police"
label variable initiatives_5 			"Meet Other State Rep"
label variable initiatives_6 			"Meet NGO Rep"
label variable initiatives_7 			"Meet National Assembly Rep"
label variable initiatives_8 			"Meet Influential Non State"
label variable initiatives_9 			"Meet Family or Friends"
label variable initiatives_10 			"Rebuild School or Clinic"
label variable initiatives_11 			"Clear or Widen Road"
label variable initiatives_12 			"Repair Well"
label variable initiatives_13 			"Organize Security Patrol"
label variable initiatives_14 			"Rebuild Mosque"
label variable initiatives_15			"Build Market"
label variable isolement_1 				"Visited other Imada"
label variable isolement_2 				"Traded other Imada"
label variable isolement_3 				"Visited other Delegation"
label variable isolement_4				"Foreign Travel"
label variable utopie_a_dum1  			"All Decisionmaking"
label variable utopie_b_dum1			"Hold National Accountable"
label variable utopie_d_dum1  			"Hold Local Accountable"
label variable utopie_e_dum1			"Government Right to Tax"
label variable source_info_internal 	"Informal National News"	
label variable source_info2_internal	"Informal Local News"

local ctrl_Aa hhsize drepondant_mat
local ctrl_Ba extra 
local ctrl_Bb extra repondant_sex
local ctrl_Ca //none
local ctrl_Cb hhsize

local ctrl_Aa_PWP hhsize drepondant_mat
local ctrl_Ba_PWP extra
local ctrl_Bb_PWP extra repondant_sex

local ctrl_Aa_gender hhsize drepondant_mat
local ctrl_Ba_gender extra
local ctrl_Bb_gender extra repondant_sex

local ctrl_Aa_prev_PWP hhsize drepondant_mat
local ctrl_Ba_prev_PWP extra
local ctrl_Bb_prev_PWP extra repondant_sex

***********************************************************************************************
*ANALYSIS FOR AART (HUMAN CAPITAL)*************************************************************
***********************************************************************************************
* Between (illiterate)
	estimates clear
	preserve 
	keep if (parti==1 | desist==1 | enquete==3) & repondant_educ == 1
	local RAa ""
	local ctlmean ""

	foreach outcome of local civic_engagement			{
		glm `outcome'  beneficiaire `ctrl_Aa', family(binomial) link(probit) vce(cluster imada)
		eststo `outcome'	: margins, dydx(beneficiaire) atmeans post
	
	*Column heading variable label
		local varlbl : variable label `outcome'
		local varlbl = subinstr("`varlbl'", " " , "_" , .)
		di "`varlbl'"
		
		estimates store `varlbl'
		local RAa `RAa' `varlbl'
		
	*control mean	
		sum 	`outcome' if beneficiaire == 0
		estadd scalar Control_Mean= r(mean)
		
		sum 	`outcome' if beneficiaire == 1
		estadd scalar Treatment_Mean= r(mean)		

		*estadd scalar Treatment_Effect = Treatment_Mean - Control_Mean
		
	}
	
	foreach outcome_ind of varlist `civic_indicesAa' {
		regres `outcome_ind' beneficiaire `ctrl_Aa', vce (cluster imada)
	
	*Column heading variable label
		local varlbl_ind : variable label `outcome_ind'
		local varlbl_ind = subinstr("`varlbl_ind'", " " , "_" , .)
		di "`varlbl_ind'"
		
		estimates store `varlbl_ind'
		local RAa `RAa' `varlbl_ind'
		
		estadd scalar Control_Mean= _b[_cons]	

		sum 	`outcome_ind' if beneficiaire == 1
		estadd scalar Treatment_Mean= r(mean)		


	}

								estout `RAa'	using	"$report\CivicEngagement_PRT.xls", 		replace 				///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(hhsize drepondant_mat _cons)	label 	///			 	 					
								stats(Control_Mean Treatment_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)		eqlabels(none) 	collabels(none) ///
								title			("Between Villages: direct effects on all workers")	varlabels(beneficiaire "Treatment Community") 
		estimates clear
		restore		

* Between (read and write)

	estimates clear
	preserve 
	keep if (parti==1 | desist==1 | enquete==3) 	& repondant_educ > 1
	local RAa ""
	local ctlmean ""

	foreach outcome of local civic_engagement			{
		glm `outcome'  beneficiaire `ctrl_Aa', family(binomial) link(probit) vce(cluster imada)
		eststo `outcome'	: margins, dydx(beneficiaire) atmeans post
	
	*Column heading variable label
		local varlbl : variable label `outcome'
		local varlbl = subinstr("`varlbl'", " " , "_" , .)
		di "`varlbl'"
		
		estimates store `varlbl'
		local RAa `RAa' `varlbl'
		
	*control mean	
		sum 	`outcome' if beneficiaire == 0
		estadd scalar Control_Mean= r(mean)
		
		sum 	`outcome' if beneficiaire == 1
		estadd scalar Treatment_Mean= r(mean)		

		*estadd scalar Treatment_Effect = Treatment_Mean - Control_Mean
		
	}
	
	foreach outcome_ind of varlist `civic_indicesAa' {
		regres `outcome_ind' beneficiaire `ctrl_Aa', vce (cluster imada)
	
	*Column heading variable label
		local varlbl_ind : variable label `outcome_ind'
		local varlbl_ind = subinstr("`varlbl_ind'", " " , "_" , .)
		di "`varlbl_ind'"
		
		estimates store `varlbl_ind'
		local RAa `RAa' `varlbl_ind'
		
		estadd scalar Control_Mean= _b[_cons]	

		sum 	`outcome_ind' if beneficiaire == 1
		estadd scalar Treatment_Mean= r(mean)		


	}

								estout `RAa'	using	"$report\CivicEngagement_PRT.xls", 		append 				///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(hhsize drepondant_mat _cons)	label 	///			 	 					
								stats(Control_Mean Treatment_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)		eqlabels(none) 	collabels(none) ///
								title			("Between Villages: direct effects on all workers")	varlabels(beneficiaire "Treatment Community") 
		estimates clear
		restore		
		

* Between (not highschool)
	estimates clear
	preserve 
	keep if (parti==1 | desist==1 | enquete==3) 	& (repondant_educ == 2 | repondant_educ == 3 | repondant_educ == 4)
	local RAa ""
	local ctlmean ""

	foreach outcome of local civic_engagement			{
		glm `outcome'  beneficiaire `ctrl_Aa', family(binomial) link(probit) vce(cluster imada)
		eststo `outcome'	: margins, dydx(beneficiaire) atmeans post
	
	*Column heading variable label
		local varlbl : variable label `outcome'
		local varlbl = subinstr("`varlbl'", " " , "_" , .)
		di "`varlbl'"
		
		estimates store `varlbl'
		local RAa `RAa' `varlbl'
		
	*control mean	
		sum 	`outcome' if beneficiaire == 0
		estadd scalar Control_Mean= r(mean)
		
		sum 	`outcome' if beneficiaire == 1
		estadd scalar Treatment_Mean= r(mean)		

		*estadd scalar Treatment_Effect = Treatment_Mean - Control_Mean
		
	}
	
	foreach outcome_ind of varlist `civic_indicesAa' {
		regres `outcome_ind' beneficiaire `ctrl_Aa', vce (cluster imada)
	
	*Column heading variable label
		local varlbl_ind : variable label `outcome_ind'
		local varlbl_ind = subinstr("`varlbl_ind'", " " , "_" , .)
		di "`varlbl_ind'"
		
		estimates store `varlbl_ind'
		local RAa `RAa' `varlbl_ind'
		
		estadd scalar Control_Mean= _b[_cons]	

		sum 	`outcome_ind' if beneficiaire == 1
		estadd scalar Treatment_Mean= r(mean)		


	}

								estout `RAa'	using	"$report\CivicEngagement_PRT.xls", 		append 				///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(hhsize drepondant_mat _cons)	label 	///			 	 					
								stats(Control_Mean Treatment_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)		eqlabels(none) 	collabels(none) ///
								title			("Between Villages: direct effects on all workers")	varlabels(beneficiaire "Treatment Community") 
		estimates clear
		restore		
		

* Between (highschool and over)

	estimates clear
	preserve 
	keep if (parti==1 | desist==1 | enquete==3) 	& (repondant_educ == 5 | repondant_educ == 6)
	local RAa ""
	local ctlmean ""

	foreach outcome of local civic_engagement			{
		glm `outcome'  beneficiaire `ctrl_Aa', family(binomial) link(probit) vce(cluster imada)
		eststo `outcome'	: margins, dydx(beneficiaire) atmeans post
	
	*Column heading variable label
		local varlbl : variable label `outcome'
		local varlbl = subinstr("`varlbl'", " " , "_" , .)
		di "`varlbl'"
		
		estimates store `varlbl'
		local RAa `RAa' `varlbl'
		
	*control mean	
		sum 	`outcome' if beneficiaire == 0
		estadd scalar Control_Mean= r(mean)
		
		sum 	`outcome' if beneficiaire == 1
		estadd scalar Treatment_Mean= r(mean)		

		*estadd scalar Treatment_Effect = Treatment_Mean - Control_Mean
		
	}
	
	foreach outcome_ind of varlist `civic_indicesAa' {
		regres `outcome_ind' beneficiaire `ctrl_Aa', vce (cluster imada)
	
	*Column heading variable label
		local varlbl_ind : variable label `outcome_ind'
		local varlbl_ind = subinstr("`varlbl_ind'", " " , "_" , .)
		di "`varlbl_ind'"
		
		estimates store `varlbl_ind'
		local RAa `RAa' `varlbl_ind'
		
		estadd scalar Control_Mean= _b[_cons]	

		sum 	`outcome_ind' if beneficiaire == 1
		estadd scalar Treatment_Mean= r(mean)		


	}

								estout `RAa'	using	"$report\CivicEngagement_PRT.xls", 		append 				///
								cells			(b(star fmt(2)) se(par([ ]) fmt(2)))		drop(hhsize drepondant_mat _cons)	label 	///			 	 					
								stats(Control_Mean Treatment_Mean N)  		starlevels(* 0.10 ** 0.05 *** 0.01)		eqlabels(none) 	collabels(none) ///
								title			("Between Villages: direct effects on all workers")	varlabels(beneficiaire "Treatment Community") 
		estimates clear
		restore		
		
		filefilter "$report/CivicEngagement_PRT.xls" "$report/B.CivicEngagement_PRT.xls", from("_") to(" ") replace					


