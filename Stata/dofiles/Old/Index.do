
use "$stata/enquete_All", clear
*drop earned_main_winbis earned_main_win5bis
 
*INDEX CALCULATION

foreach var of varlist 		c3_a_1_win6 c3_a_2_win6 c3_a_3_win c3_a_4_win5 c3_a_5_win5 c3_a_6_win5 c3_a_7_win5  ///
							c3_a_8_win5 c3_a_9_win c3_a_10_win c3_a_11_win5 exp_food_win c4_win c5_win5 c6_win5 /// 
							c7_win5 c8_win5 c9_win c11_win c12_win c13_win c14_win c15_win c16_win c18_win 		///
							tspent_main earned_main_win earnedhh_win earnedoth epargne_cb epargne_dette_cb_win		{
	gen l`var' = log(`var'+1)
	rename `var'   n`var'
	rename  l`var' `var'
}


*Account for repetition of variables in different categories; will delete at end of code
foreach var of varlist	c3_a_1_win6 c3_a_2_win6 c3_a_3_win c3_a_4_win5 c3_a_5_win5 c3_a_6_win5 c3_a_7_win5 	///
						c3_a_8_win5 c3_a_9_win c3_a_10_win c3_a_11_win5 exp_food_win c4_win c5_win5 c6_win5 ///
						c7_win5 c8_win5 c9_win c11_win c12_win c13_win c14_win c15_win c16_win c18_win 		///
						g2_1 g2_2 g2_3 g2_4 g2_5 g2_6 g2_7 g2_8 g2_9 g2_10 g2_11 g2_12 g2_13 g2_14 g2_15	///	
						q2_1_2_win q2_1_3 q2_1_4 q2_1_5 q2_1_6 q2_1_7 q2_1_8 q2_1_9 q2_1_10 q2_1_11 		///
						q2_1_12 q2_1_13_win q2_1_14 q2_1_15 q2_1_16_win q2_1_17 q2_1_18_win q2_1_19_win 	///
						q2_1_20 q2_1_21 q2_1_22 q2_1_23_win mur_dummy toit_dummy proprietaire_dum1 titre	///
						proprietaire_terre superficie_m titre_terre f18_dummy formation formation_dum1 		///
						formation_dum2 formation_dum3 formation_dum4 formation_dum5 formation_dum6 			///
						formation_dum7 formation_dum9 formation_dum10 emploi_comp_inut emploi tspent_main 	///
						earned_main_win employedhh earnedhh_win paidjobhh earnedoth paidjoboth sec_empl 	///
						tspent_sec_win earned_sec employs pers_employ hoursperm_employ paid_employ epargne  ///		//any issue with oursperm_employ paid_employ?
						epargne_forme_3 epargne_cb futur_services emp_futur_cb_win							///
						association_dummy comite_c comite_c_menage conflit_dispute_in conflit_dispute_out 	///
						migration_cm_q1 migration_q1 security_dummy association_1 association_2 			///
						association_3 association_4 association_6 association_7 association_8 				///
						association_9 securite_1 securite_2 securite_3 securite_4 							///
						securite_5 securite_6 initiative_dummy utopie_a_dum1 utopie_b_dum1 					///
						source_info_internal source_info2_internal utopie_a_dum3 utopie_b_dum3				///
						isolation_dummy initiatives_1 initiatives_2 initiatives_3 initiatives_4 			///
						initiatives_5 initiatives_6 initiatives_7 initiatives_8 initiatives_9 				///
						initiatives_10 initiatives_11 initiatives_12 initiatives_13 initiatives_14 			///
						initiatives_15 isolement_1 isolement_2 isolement_3 									///
						isolement_4 psy_anxiete psy_exploit psy_depress5 psy_accepte_dum1 psy_accepte_dum3 	///
						psy_menage_dum3 psy_a_menage_dum1 psy_a_menage_dum3 pearlin_1 						///
						pearlin_2 pearlin_3 pearlin_4 pearlin_5 pearlin_6 pearlin_7 violence_physical		///
						violence_emotional intrahh_1 intrahh_2 intrahh_7 intrahh_11 emploiw violence_1_2 	///
						violence_1_3 violence_1_4 violence_1_5 violence_1_6 violence_1_7 violence_1_8 		///
						violence_1_9 violence_1_10 violence_1_11 violence_1_16 violence_1_17 violence_1_18	///
						epargne_dette epargne_dette_cb_win 			{
						
						gen `var'bis = `var'
		}

rename 					source_info2_internal source_info2_intern
		
foreach var of varlist	q2_1_2_win q2_1_3 q2_1_4 q2_1_5 q2_1_6 q2_1_7 q2_1_8 q2_1_12 q2_1_13_win q2_1_14 	///
						q2_1_15 q2_1_16_win q2_1_9 q2_1_10 q2_1_11 q2_1_17 q2_1_18_win q2_1_19_win q2_1_20  ///
						q2_1_21 q2_1_22	intrahh_7 intrahh_11 psy_a_menage_dum3 initiatives_1 initiatives_2  ///
						initiatives_3 initiatives_4 initiatives_5 initiatives_6 initiatives_7 initiatives_8 ///
						utopie_a_dum1 utopie_b_dum1	source_info_internal source_info2_intern comite_c		///
						comite_c_menage	/*source_info_internal*/ {
						
						gen `var'bis2 = `var'
						
		}

rename 					source_info2_intern source_info2_internal
		
		
*change signs so that positive events take a positive sign
local sign 			emploi_comp_inut conflit_dispute_in conflit_dispute_out migration_cm_q1 migration_q1 ///
					security_dummy securite_1 securite_2 securite_3 securite_3bis securite_4 securite_5  ///
					securite_5bis securite_6 securite_6bis	violence_physicalbis violence_emotionalbis  ///
					utopie_a_dum3 utopie_b_dum3 isolation_dummy psy_anxiete psy_exploit 				///
					psy_depress5 psy_accepte_dum1 psy_a_menage_dum1 source_info_internal source_info2_internal	///
					source_info_internalbis source_info2_internalbis intrahh_7bis intrahh_11bis			///
					pearlin_2 pearlin_3 intrahh_7 intrahh_11 violence_1_2 violence_1_3 violence_1_4 	///
					violence_1_5 violence_1_6 violence_1_7 violence_1_8 violence_1_9 violence_1_10 		///
					violence_1_11 violence_1_16 violence_1_17 violence_1_18	violence_physical 			///
					violence_emotional conflit_dispute_inbis conflit_dispute_outbis migration_cm_q1bis 	///
					migration_q1bis pearlin_7 pearlin_7bis psy_anxietebis psy_exploitbis psy_depress5bis ///
					psy_accepte_dum1bis psy_a_menage_dum1bis epargne_dette epargne_dette_cb_win			 ///
					epargne_dettebis epargne_dette_cb_winbis g2_1 g2_2 g2_3 g2_4 g2_5 g2_6 g2_7 g2_8 	///
					g2_9 g2_10 g2_11 g2_12 g2_13 g2_14 g2_15 intrahh_7bis2 intrahh_11bis2				///
					source_info_internalbis2 source_info2_internbis2 distance_dispensaire  distance_ecoleprim distance_ecolesec distance_eau ///
					distance_marche  distance_transpublic

					
					
/*					g1_1 g1_3 g1_5 g1_6 g1_7 lithh_dum1 lithh_dum2 lit_dum1 lit_dum2 emploi_comp_inut empl_futurt_dum4 sante_lieux_dum4 ///
sante_lieux_dum5 distance_dispensaire_win distance_ecoleprim_win distance_ecolesec_win distance_eau_win sante_qualite_b_dum1 ///
sante_qualite_c_dum1 ecole_qualite_c_dum1 ecole_qualite_d_dum1 distance_eau distance_marche_win distance_transpublic_win ///
distance_ecoleprim distance_ecolesec distance_dispensaire distance_cheflieu_win conflit_dispute_in conflit_dispute_out migration_cm_q1 ///
migration_q1 securite_1 securite_2 securite_3 securite_4 securite_5 securite_6 utopie_a_dum3 utopie_b_dum3 source_info_7 source_info_8 ///
source_info2_7 source_info2_8 psy_anxiete psy_exploit psy_depress5 psy_accepte_dum1 psy_menage_dum1 psy_a_menage_dum1 pearlin_2 pearlin_3 ///
intrahh_7 intrahh_11 violence_1_2 violence_1_3 violence_1_4 violence_1_5 violence_1_6 violence_1_7 violence_1_8 violence_1_9 violence_1_10 ///
violence_1_11 violence_1_16 violence_1_17 violence_1_18 violence_physical violence_emotional */

foreach signvar of local sign  {
gen 	`signvar'I = -	`signvar'
rename 	`signvar'I  	`signvar'_t
rename	`signvar' 		`signvar'I
rename	`signvar'_t	 	`signvar'
}

save "$stata/enquete_All2", replace

*calculation of indexes by category of variables
do "$do/command_index"

/*
We have six "types" of individuals in our sample
1)      Workers on the ‘nominative lists’ (primary list of replacement lists) who were randomized into the program and ended up working
2)      Workers on the ‘nominative lists’ (primary list of replacement lists) who were randomized into the program and ended up not working (les desistes)
3)      Workers on the ‘nominative lists’ (primary list of replacement lists) who were randomized out of the program
4)      Representative random samples of individuals from treatment imadas
5)      Representative random samples of individuals from control imadas
6)      Eligible and randomly selected workers from control imadas (i.e., synthestic controls)

A)      Between villages effects on the workers:
a.      ITT: [(1) + (2)] vs (6)

B)      Within village effects on the workers:
a.      ITT: [(1) + (2)] vs (3)
b.      ATE: (1) vs (3)

C)      Spillover effects (two types)
a.      (4) vs (5)
b.      (3) vs (6)

D)     Heterogeneous effects
a.      Re-run Aa and Ab separately for subsamples stratify by the key program-related | contextual variables we decide on.
b.      Re-run Ba and Bb separately for subsamples stratify by the key program-related | contextual variables we decide on.
*/
********Producing the indexes**********

cap file close myfile
file open myfile using "$report/index.xls", write replace


*A)      Between villages effects on the workers:
*a.      ITT: [(1) + (2)] vs (6)
use "$stata/enquete_All2", replace 
keep if (parti==1 | desist==1 | enquete==3) 

 file write myfile "<!DOCTYPE html><html lang='en'><head>"
 file write myfile "<p align=center b> TABLE 1. Between villages effects on the workers:ITT </p><br>"
 file write myfile "<meta charset='utf-8' /></head><body><div><table border=1 align=center>" _n

 file write myfile "<tr><td>Level</td><td>Outcome Group</td><td>Outcome</td><td>Mean ctrl group</td><td>Sd ctrl group</td><td>Mean norm</td><td>Group Index</td><td>Overall Index</td>"
 
 index beneficiaire IAa myfile
 
 file write myfile "</table>"
 
keep key IAa*
sort key
save "$stata/indexAa", replace


*B)      Within village effects on the workers:
*a.      ITT: [(1) + (2)] vs (3)

use "$stata/enquete_All2", replace 
gen program=(parti==1 | desist==1)
keep if (parti==1 | desist==1 | control==1)

 file write myfile "<!DOCTYPE html><html lang='en'><head>"
 file write myfile "<p align=center b> TABLE 2. Within village effects on the workers:ITT </p><br>"
 file write myfile "<meta charset='utf-8' /></head><body><div><table border=1 align=center>" _n

 file write myfile "<tr><td>Level</td><td>Outcome Group</td><td>Outcome</td><td>Mean ctrl group</td><td>Sd ctrl group</td><td>Mean norm</td><td>Group Index</td><td>Overall Index</td>"
 
 index program IBa myfile
 
 file write myfile "</table>"
 
keep key IBa*
sort key
save "$stata/indexBa", replace

*B)      Within village effects on the workers:
*b.      ATE: (1) vs (3)
use "$stata/enquete_All2", replace 
keep if (parti==1 | control==1)

 file write myfile "<!DOCTYPE html><html lang='en'><head>"
 file write myfile "<p align=center b> TABLE 3. Within village effects on the workers:ATE </p><br>"
 file write myfile "<meta charset='utf-8' /></head><body><div><table border=1 align=center>" _n

 file write myfile "<tr><td>Level</td><td>Outcome Group</td><td>Outcome</td><td>Mean ctrl group</td><td>Sd ctrl group</td><td>Mean norm</td><td>Group Index</td><td>Overall Index</td>"
 
 index parti IBb myfile
 
 file write myfile "</table>"
 
keep key IBb*
sort key
save "$stata/indexBb", replace

*C)      Spillover effects (two types)
*a.      (4) vs (5)
use "$stata/enquete_All2", replace 
keep if enquete==1

 file write myfile "<!DOCTYPE html><html lang='en'><head>"
 file write myfile "<p align=center b> TABLE 4. Spillover effects:(4) vs (5)  </p><br>"
 file write myfile "<meta charset='utf-8' /></head><body><div><table border=1 align=center>" _n

 file write myfile "<tr><td>Level</td><td>Outcome Group</td><td>Outcome</td><td>Mean ctrl group</td><td>Sd ctrl group</td><td>Mean norm</td><td>Group Index</td><td>Overall Index</td>"
 
 index beneficiaire ICa myfile
 
 file write myfile "</table>"

keep key ICa*
sort key
save "$stata/indexCa", replace

*C)      Spillover effects (two types)
*b.      (3) vs (6)
use "$stata/enquete_All2", replace 
keep if (control==1 | enquete==3) 

 file write myfile "<!DOCTYPE html><html lang='en'><head>"
 file write myfile "<p align=center b> TABLE 5. Spillover effects:(3) vs (6) </p><br>"
 file write myfile "<meta charset='utf-8' /></head><body><div><table border=1 align=center>" _n

 file write myfile "<tr><td>Level</td><td>Outcome Group</td><td>Outcome</td><td>Mean ctrl group</td><td>Sd ctrl group</td><td>Mean norm</td><td>Group Index</td><td>Overall Index</td>"
 
 index beneficiaire ICb myfile
 
 file write myfile "</table>"
file close myfile
 
keep key ICb*
sort key
save "$stata/indexCb", replace


*merge with main dataset
use "$stata/enquete_All2", clear
sort key
merge 1:1 key using "$stata/indexAa"
sum IAa* if _merge==1
drop _merge
merge 1:1 key using "$stata/indexBa"
sum IBa* if _merge==1
drop _merge
merge 1:1 key using "$stata/indexBb"
sum IBb* if _merge==1
drop _merge
merge 1:1 key using "$stata/indexCa"
sum ICa* if _merge==1
drop _merge
merge 1:1 key using "$stata/indexCb"
sum ICb* if _merge==1
drop _merge


*delete temporary variables
foreach var of varlist	c3_a_1_win6 c3_a_2_win6 c3_a_3_win c3_a_4_win5 c3_a_5_win5 c3_a_6_win5 c3_a_7_win5 	///
						c3_a_8_win5 c3_a_9_win c3_a_10_win c3_a_11_win5 exp_food_win c4_win c5_win5 c6_win5 ///
						c7_win5 c8_win5 c9_win c11_win c12_win c13_win c14_win c15_win c16_win c18_win 		///
						g2_1 g2_2 g2_3 g2_4 g2_5 g2_6 g2_7 g2_8 g2_9 g2_10 g2_11 g2_12 g2_13 g2_14 g2_15	///	
						q2_1_2_win q2_1_3 q2_1_4 q2_1_5 q2_1_6 q2_1_7 q2_1_8 q2_1_9 q2_1_10 q2_1_11 			///
						q2_1_12 q2_1_13_win q2_1_14 q2_1_15 q2_1_16_win q2_1_17 q2_1_18_win q2_1_19_win 	///
						q2_1_20 q2_1_21 q2_1_22 q2_1_23_win mur_dummy toit_dummy proprietaire_dum1 titre	///
						proprietaire_terre superficie_m titre_terre f18_dummy formation formation_dum1 		///
						formation_dum2 formation_dum3 formation_dum4 formation_dum5 formation_dum6 			///
						formation_dum7 formation_dum9 formation_dum10 emploi_comp_inut emploi tspent_main 	///
						earned_main_win employedhh earnedhh_win paidjobhh earnedoth paidjoboth sec_empl 	///
						tspent_sec_win earned_sec employs pers_employ hoursperm_employ paid_employ epargne  ///		//any issue with oursperm_employ paid_employ?
						epargne_forme_3 epargne_cb futur_services emp_futur_cb_win							///
						association_dummy comite_c comite_c_menage conflit_dispute_in conflit_dispute_out 	///
						migration_cm_q1 migration_q1 security_dummy association_1 association_2 			///
						association_3 association_4 association_6 association_7 association_8 				///
						association_9 securite_1 securite_2 securite_3 securite_4 							///
						securite_5 securite_6 initiative_dummy utopie_a_dum1 utopie_b_dum1 					///
						source_info_internal source_info2_internal utopie_a_dum3 utopie_b_dum3				///
						isolation_dummy initiatives_1 initiatives_2 initiatives_3 initiatives_4 			///
						initiatives_5 initiatives_6 initiatives_7 initiatives_8 initiatives_9 				///
						initiatives_10 initiatives_11 initiatives_12 initiatives_13 initiatives_14 			///
						initiatives_15 isolement_1 isolement_2 isolement_3 									///
						isolement_4 psy_anxiete psy_exploit psy_depress5 psy_accepte_dum1 psy_accepte_dum3 	///
						psy_menage_dum3 psy_a_menage_dum1 psy_a_menage_dum3 pearlin_1 						///
						pearlin_2 pearlin_3 pearlin_4 pearlin_5 pearlin_6 pearlin_7 violence_physical 		///
						violence_emotional intrahh_1 intrahh_2 intrahh_7 intrahh_11 emploiw violence_1_2 	///
						violence_1_3 violence_1_4 violence_1_5 violence_1_6 violence_1_7 violence_1_8 		///
						violence_1_9 violence_1_10 violence_1_11 violence_1_16 violence_1_17 violence_1_18		{
						
						drop `var'bis 
		}

	local sign 			emploi_comp_inut conflit_dispute_in conflit_dispute_out migration_cm_q1 migration_q1 ///
						security_dummy securite_1 securite_2 securite_3 securite_4 securite_5 securite_6 	///
						utopie_a_dum3 utopie_b_dum3 isolation_dummy psy_anxiete psy_exploit 				///
						psy_depress5 psy_accepte_dum1 psy_a_menage_dum1 source_info_internal source_info2_internal	///
						pearlin_2 pearlin_3 intrahh_7 intrahh_11 violence_1_2 violence_1_3 violence_1_4 	///
						violence_1_5 violence_1_6 violence_1_7 violence_1_8 violence_1_9 violence_1_10 		///
						violence_1_11 violence_1_16 violence_1_17 violence_1_18	violence_physical 			///
						violence_emotional pearlin_7 epargne_dette epargne_dette_cb_win g2_1 g2_2 g2_3 g2_4 ///
						g2_5 g2_6 g2_7 g2_8 g2_9 g2_10 g2_11 g2_12 g2_13 g2_14 g2_15


	foreach signvar of local sign  {
	rename 	`signvar'	  	`signvar'_convert 
	rename	`signvar'I 		`signvar'
	}

save "$stata/enquete_All3", replace

*****************************



*FAMILYWISE ADJUSTMENT
*Will want to do this only once the estimation is done. need p-value for Ho: ///
*estimate coefficient ==0. refers to the coefficient for the treatment dummy.
/* Calculate bootstrap p-values (pbj) */

/* Calculate p-values for each replication under null hypothesis (sij ), ordering
by rij and imposing uniform p-value distribution across replications for each
of J parameters */


/* Calculate adjusted p-value (paj) */


/* Enforce monotonicity so that the order of outcomes according to bootstrap
per-comparison p-values is weakly preserved according to adjusted
p-values */

**************need change of sign OR excluded because neutral signification**************
/*
local product ///
emploi 
chomage OUI
chomage_recherche 
reserv_wage OUI
reserv_wage_win OUI
emploi_2015_a 
h_per_day 

local income ///
rev_total 
rev_total_win 
f2_val_2 
f2_val_2_win 

local consump ///
c12 
c3_a_1 
c3_b_1  
c3_a_4 
c3_b_4 
c3_a_6 
c3_b_6 ///
c3_a_11 
c3_b_11 
c4 pain  
pain_win 
legumes 
legumes_win 
tabac 
tabac_win 

local h_capital ///
c13 
c13_win 
formation 
formation_dum3 
formation_dum5 ///
formation_dum7 

local assets ///
c6 
c6_win 
c15 
c15_win 
epargne 
epargne_pret 

local credit ///
epargne_dette OUI
c20 OUI
migration_q5 OUI
migration_q5_win OUI
migration_cm_q5 
migration_cm_q5_win 

local service ///
sante_hopital 
sante_hopital_win 
sante_qualite_a exclu (categorical)
sante_qualite_a_dum1 OUI 
sante_qualite_a_dum2 EXLU (moyen)
sante_qualite_a_dum3 ///
sante_qualite_b exclu (categorical)
sante_qualite_b_dum1 OUI
sante_qualite_b_dum2 exclu (moyen)
sante_qualite_b_dum3 
sante_qualite_c_dum1 OUI
sante_qualite_c_dum2 exclu (moyen)
sante_qualite_c_dum3 
sante_qualite_d_dum1 OUI 
sante_qualite_d_dum2 exclu (moyen)
sante_qualite_d_dum3 

local cohesion ///
responsability exclu (categorical)
responsability_dum1 
responsability_dum2 
responsability_dum4
responsability_dum5 OUI
responsability_dum7 OUI 
utopie_accord_dum1 
psy_partage_qui exclu: categorical
psy_partage_dum1 
psy_partage_dum4 OUI
psy_solitude_dum2 OUI
psy_solitude_dum3 
psy_solitude_dum4 OUI
psy_exploit OUI

local crime ///
conflit_dispute_in OUI
conflit_dispute_out OUI

local mental ///
f17 exclu: categorical
f17_dum1 OUI
f17_dum2 EXCLU: ÉGAL
emploi_comp_inut OUI
emploidiffsal_1 OUI
emploidiffsal_4 
emploidiffsal_5 ///
emploidiffindep_1 OUI
emploidiffindep_4 ///
pearlin_1 
psy_depress5 OUI

local relation ///
te_3 exclu: categorical
te_3_dum2 OUI
te_3_dum3 
te_3_dum4 
psy_accepte exclu: categorical
psy_accepte_dum3 
psy_menage exclu: categorical
psy_menage_dum2 
psy_menage_dum3 ///
violence_1_7 OUI
violence_1_9 OUI
violence_2_1 OUI
violence_2_2 OUI
violence_2_3 OUI
violence_2_7 OUI
violence_2_9 OUI
*/
