/*
1) REMPLACER LES CODES 98 99 ETC: ok
2) RECODER AU BESOIN: ok
3) CRÉER LES DUMMIES: ok
3.5) WINSORIZE: ok
4) LABELER (LABELDUM POUR NEW DUMMIES): ok
5) REMPLACER MISSINGS PAR ZERO S'IL Y A LIEU; REF À VAR MÈRE POUR LES _WIN: ok
6) TROUVER LES CENSORED (* hist): ok
7) RENAME REPETITION OF SAME VARS
8) read question and see if makes sense
9) CRÉER LES VARS EN LISTES DES STRING: ok
*/

set more off, perm
use "$stata/enquete_indiv4", clear
mvdecode _all, mv(.98=.n\-98=.n\.99=.a\-99=.a\.97=.d\-97=.d)

*run command for labeling vars from categorical
do "$do/command_dumlab"

*key dummies
tab parti, m

tab beneficiaire, m
label variable beneficiaire "Community received CWLP program"


*Controls
tab extra, m
label variable extra "Observation from secondary randomization"

codebook superviseur //no miss; labeled
tab superviseur, nol m //1 à 7 continu
tab superviseur, gen(superv_dum) //**extraire les labels de l'originale	
codebook superv_*
tab superv_dum7 

codebook repondant_rel
tab repondant_rel, nol 
tab repondant_rel, nol
tab repondant_rel, gen(relation_dum) //**extraire les labels de l'originale
labeldum repondant_rel relation_dum
*codebook relation_dum* //4 to 14 don't vary much; mostly==0


codebook repondant_age //max 1977 !!, no missings
count if repondant_age>100 //3
list repondant_age if repondant_age>100
/*
      +----------+
      | repon~ge |
      |----------|
2088. |     1975 |
2111. |     1977 |
2832. |      507 |
      +----------+
*/
* histogram repondant_age if repondant_age<=100
replace repondant_age=(2016-1975) if repondant_age==1975
replace repondant_age=(2016-1977) if repondant_age==1977
replace repondant_age=. if repondant_age==507
codebook repondant_age //[18,78]
* hist repondant_age

codebook repondant_sex //18 missings
tab repondant_sex, nol m //46% H, 53% F
recode repondant_sex (2=0)
tab repondant_sex, nol m 


gen 			drepondant_mat 	= 0
replace		 	drepondant_mat	= 1 if repondant_mat == 2 | repondant_mat == 3 | repondant_mat == 4
label variable	drepondant_mat "dummy from repondant_mat: = 1 if respondent unmarried"
/*codebook repondant_educ	//no missings, 1-7 continu NO BECAUSE POST-TREATMENT
tab repondant_educ, gen(educ_dum) //extraire les labels de l'originale
sum educ_dum* //4, 6, 7 don't vary much
*/

gen 			no_primary	= 0
replace			no_primary  = 1 if repondant_educ == 1 | repondant_educ == 2
label variable	no_primary  "dummy from repondant_educ, lower than primary education"

gen 			lycee_above = 0
replace			lycee_above = 1 if repondant_educ >= 3 & repondant_educ < 7 
label variable	lycee_above  "dummy from repondant_educ, at least lycee education"


/*codebook repondant_educ	//no missings, 1-7 continu NO BECAUSE POST-TREATMENT
tab repondant_educ, gen(educ_dum) //extraire les labels de l'originale
sum educ_dum* //4, 6, 7 don't vary much
*/
/*
codebook hhsize //no missings, 1-13 NO BECAUSE POST-TREATMENT
* histogram hhsize
*/
/*codebook jeunes_lireecrire //attn -99 NO BECAUSE POST-TREATMENT
tab jeunes_lireecrire
*mvdecode jeunes_lireecrire, mv(-99=.a)
tab jeunes_lireecrire, m
*/
codebook handicap //attn -99
tab handicap
*mvdecode handicap, mv(-99=.a)
tab handicap, m
/*
codebook calcul_1 //attn -99 NO BECAUSE POST-TREATMENT
tab calcul_1, m
*mvdecode calcul_1, mv(-99=.a)
tab calcul_1, m nol
recode calcul_1 (2=0)
tab calcul_1, m nol
*/
codebook calcul_2 //attn -99
tab calcul_2, m //lol: doit corriger le résultat.


***************************************
*NEW HUNDRED OUTCOMES



*5.2.1 CONSUMPTION (FOOD AND EXPENDITURES) // will be considered censored



***********************************************************************************************************************************************************
			*1. USE WIN 1 ALL
			*2. USE ALL WIN 5 EXCEPT 3, 9, AND 10 WIN 1, WIN 6 FOR 1 AND 2
***********************************************************************************************************************************************************

	*Food and Beverages
	local letter "a b"															//more winsorisation needed - what units are being understood (should be expenditure)?
																				//what expenditure is feasible?
		forvalues x = 1/11	{
			foreach y of local letter		{
				* histogram		c3_`y'_`x'
				replace 		c3_`y'_`x' = 0		if   c3_`y'_`x'  == .
				sum 			c3_`y'_`x', d
				
				winsor			c3_`y'_`x', 		gen(c3_`y'_`x'_win) p(0.01)
				winsor			c3_`y'_`x', 		gen(c3_`y'_`x'_win5) p(0.05)

				local 			c3_`y'_`x'_lab: 	variable label c3_`y'_`x' 
				label variable 	c3_`y'_`x'_win 		"`c3_`y'_`x'_lab'"
				label variable 	c3_`y'_`x'_win5		"`c3_`y'_`x'_lab'"

				sum 			c3_`y'_`x'_win, d
				sum 			c3_`y'_`x'_win5, d				
			}
		}
	
	local letter				a													//more winsorisation needed - what units are being understood (should be expenditure)?
		forvalues x = 1/2							{
				foreach y of local letter		{
				* histogram		c3_`y'_`x'
				replace 		c3_`y'_`x' = 0		if   c3_`y'_`x'  == .
				sum 			c3_`y'_`x', d
				
				winsor			c3_`y'_`x', 		gen(c3_`y'_`x'_win6) p(0.06)

				local 			c3_`y'_`x'_lab: 	variable label c3_`y'_`x' 
				label variable 	c3_`y'_`x'_win6		"`c3_`y'_`x'_lab'"

				sum 			c3_`y'_`x'_win6, d
			}
		}

egen exp_food=rowtotal(c3_a_1 c3_a_2 c3_a_3 c3_a_4 c3_a_5 c3_a_6 c3_a_7 c3_a_8 c3_a_9 c3_a_10 c3_a_11), m
tab exp_food, m
* hist exp_food 
replace exp_food=0 if exp_food==.
/*
winsor exp_food, gen(exp_food_win) p(0.01)
winsor exp_food, gen(exp_food_win5) p(0.05)

local exp_food_lab: variable label exp_food 
label variable exp_food_win "`exp_food_lab'"
label variable exp_food_win5 "`exp_food_lab'"
replace exp_food_win=0 if exp_food==.
replace exp_food_win5=0 if exp_food==.
tab exp_food_win, m
* hist exp_food_win
*/
egen exp_food_win5=rowtotal	(c3_a_1_win5 c3_a_2_win5 c3_a_3_win5 c3_a_4_win5 c3_a_5_win5 c3_a_6_win5 c3_a_7_win5 ///
							c3_a_8_win5 c3_a_9_win c3_a_10_win c3_a_11_win5), m											// too much cut?

		
/*		

**Food and beverages
*Value of meat and fish consumed
tab c3_a_3, m 
* hist c3_a_3 
replace c3_a_3=0 if c3_a_3==.
winsor c3_a_3, gen(c3_a_3_win) p(0.01)
local c3_a_3_lab: variable label c3_a_3 
label variable c3_a_3_win "`c3_a_3_lab'"
replace c3_a_3_win=0 if c3_a_3==.
tab c3_a_3_win, m
* hist c3_a_3_win

tab c3_a_4, m 
* hist c3_a_4
replace c3_a_4=0 if c3_a_4==.
winsor c3_a_4, gen(c3_a_4_win) p(0.01)
local c3_a_4_lab: variable label c3_a_4 
label variable c3_a_4_win "`c3_a_4_lab'"
replace c3_a_4_win=0 if c3_a_4==.
tab c3_a_4_win
* hist c3_a_4_win

*Value of fruit and legumes/vegetables consumed 
tab c3_a_6, m 
* hist c3_a_6
replace c3_a_6=0 if c3_a_6==.
winsor c3_a_6, gen(c3_a_6_win) p(0.01)
local c3_a_6_lab: variable label c3_a_6 
label variable c3_a_6_win "`c3_a_6_lab'"
replace c3_a_6_win=0 if c3_a_6==.
tab c3_a_6_win
* hist c3_a_6_win

*Value of egg and milk consumed 
tab c3_a_5, m 
* hist c3_a_5
replace c3_a_5=0 if c3_a_5==.
winsor c3_a_5, gen(c3_a_5_win) p(0.01)
local c3_a_5_lab: variable label c3_a_5 
label variable c3_a_5_win "`c3_a_5_lab'"
replace c3_a_5_win=0 if c3_a_5==.
tab c3_a_5_win
* hist c3_a_5_win

*Value of oil an fat consumed 
tab c3_a_8, m 
* hist c3_a_8
replace c3_a_8=0 if c3_a_8==.
winsor c3_a_8, gen(c3_a_8_win) p(0.01)
local c3_a_8_lab: variable label c3_a_8 
label variable c3_a_8_win "`c3_a_8_lab'"
replace c3_a_8_win=0 if c3_a_8==.
tab c3_a_8_win
* hist c3_a_8_win

*Value of beverages consumed 
tab c3_a_9, m
* hist c3_a_9
replace c3_a_9=0 if c3_a_9==.
winsor c3_a_9, gen(c3_a_9_win) p(0.01)
local c3_a_9_lab: variable label c3_a_9 
label variable c3_a_9_win "`c3_a_9_lab'"
replace c3_a_9_win=0 if c3_a_9==.
tab c3_a_9_win
* hist c3_a_9_win

*Value of cigarette, coffee and tea consumed 
tab c3_a_11, m
* hist c3_a_11
replace c3_a_11=0 if c3_a_11==.
winsor c3_a_11, gen(c3_a_11_win) p(0.01)
local c3_a_11_lab: variable label c3_a_11 
label variable c3_a_11_win "`c3_a_11_lab'"
replace c3_a_11_win=0 if c3_a_11==.
tab c3_a_11_win
* hist c3_a_11_win

*Value of other consumption, etc. 
tab c3_a_1, m
* hist c3_a_1
replace c3_a_1=0 if c3_a_1==.
winsor c3_a_1, gen(c3_a_1_win) p(0.01)
local c3_a_1_lab: variable label c3_a_1 
label variable c3_a_1_win "`c3_a_1_lab'"
replace c3_a_1_win=0 if c3_a_1==.
tab c3_a_1_win
* hist c3_a_1_win

tab c3_a_2, m
* hist c3_a_2
replace c3_a_2=0 if c3_a_2==.
winsor c3_a_2, gen(c3_a_2_win) p(0.01)
local c3_a_2_lab: variable label c3_a_2 
label variable c3_a_2_win "`c3_a_2_lab'"
replace c3_a_2_win=0 if c3_a_2==.
tab c3_a_2_win
* hist c3_a_2_win

tab c3_a_7, m
* hist c3_a_7
replace c3_a_7=0 if c3_a_7==.
winsor c3_a_7, gen(c3_a_7_win) p(0.01)
local c3_a_7_lab: variable label c3_a_7 
label variable c3_a_7_win "`c3_a_7_lab'"
replace c3_a_7_win=0 if c3_a_7==.
tab c3_a_7_win
* hist c3_a_7_win

tab c3_a_10, m
* hist c3_a_10
replace c3_a_10=0 if c3_a_10==.
winsor c3_a_10, gen(c3_a_10_win) p(0.01)
local c3_a_10_lab: variable label c3_a_10 
label variable c3_a_10_win "`c3_a_10_lab'"
replace c3_a_10_win=0 if c3_a_10==.
tab c3_a_10_win
* hist c3_a_10_win
*/
label variable c3_a_1_win 	"Pains, farine, orge, sorgho"
label variable c3_a_2_win 	"Pâtes, riz et semoule"
label variable c3_a_3_win 	"Poisson/produits de la mer"
label variable c3_a_4_win 	"Viande"
label variable c3_a_5_win 	"Œuf et produit laitiers"
label variable c3_a_6_win 	"Legumes (Pommes de terre, carottes, tomates, etc.)"
label variable c3_a_7_win 	"Fruits (orange, pomme,etc.)"
label variable c3_a_8_win 	"Huiles d’olive et autres huiles végétales "
label variable c3_a_9_win 	"Boissons ( eau , jus, gazeuses, et toutes autres boissons)  "
label variable c3_a_10_win 	"Epices (sels,  poivre , curcuma,…)"
label variable c3_a_1 		"Pains, farine, orge, sorgho"
label variable c3_a_2 		"Pâtes, riz et semoule"
label variable c3_a_3 		"Poisson/produits de la mer"
label variable c3_a_4 		"Viande"
label variable c3_a_5 		"Œuf et produit laitiers"
label variable c3_a_6 		"Legumes (Pommes de terre, carottes, tomates, etc.)"
label variable c3_a_7 		"Fruits (orange, pomme,etc.)"
label variable c3_a_8 		"Huiles d’olive et autres huiles végétales "
label variable c3_a_9 		"Boissons ( eau , jus, gazeuses, et toutes autres boissons)  "
label variable c3_a_10 		"Epices (sels,  poivre , curcuma,…)"

*Food consumption index: weighted standardized average of the above variables.
/*

***********************************************************************************************************************************************************
			*1. USE WIN 1 FOR ALL
			*2. USE WIN 5 FOR 5, 6, 7, 8 
***********************************************************************************************************************************************************
*/
		
		forvalues x = 4/9			{
												
			* histogram		c`x'
			replace 		c`x' = 0		if   c`x'  == .
			sum 			c`x', d
			
			winsor			c`x', gen(c`x'_win)  p(0.01)
			winsor			c`x', gen(c`x'_win5) p(0.05)

			local 			c`x'_lab: 	variable label c`x' 
			label variable 	c`x'_win 		"`c`x'_lab'"
			label variable 	c`x'_win5		"`c`x'_lab'"

			sum 			c`x'_win, d
			sum 			c`x'_win5, d
			
		}
		
		forvalues x = 11/16			{
			* histogram		c`x'
			replace 		c`x' = 0		if   c`x'  == .
			sum 			c`x', d
			
			winsor			c`x', gen(c`x'_win)  p(0.01)
			winsor			c`x', gen(c`x'_win5) p(0.05)

			local 			c`x'_lab: 	variable label c`x' 
			label variable 	c`x'_win 		"`c`x'_lab'"
			label variable 	c`x'_win5		"`c`x'_lab'"

			sum 			c`x'_win, d
			sum 			c`x'_win5, d
			}

			
			sum c18, d
			* histogram		c18
			replace 		c18 = 0		if   c18  == .
			sum 			c18
			
			winsor		c18, gen(c18_win)  p(0.01)
			winsor		c18, gen(c18_win5) p(0.05)

			local 			c18_lab: 	variable label c18 
			label variable 	c18_win 		"`c18_lab'"
			label variable 	c18_win5		"`c18_lab'"

			sum 			c18_win, d
			sum 			c18_win5, d
			
			
/*			
**Expenditures on basic/productive and luxury goods
*Expenditures on food 
tab c3_a_1, m
tab c3_a_2, m
tab c3_a_3, m
tab c3_a_4, m
tab c3_a_5, m
tab c3_a_6, m
tab c3_a_7, m
tab c3_a_8, m
tab c3_a_9, m
tab c3_a_10, m
egen exp_food=rowtotal(c3_a_1 c3_a_2 c3_a_3 c3_a_4 c3_a_5 c3_a_6 c3_a_7 c3_a_8 c3_a_9 c3_a_10), m
tab exp_food, m

*Expenditures on healthcare (medical expenses) 
tab c12, m 
* hist c12
winsor c12, gen(c12_win) p(0.01)
local c12_lab: variable label c12 
label variable c12_win "`c12_lab'"
tab c12_win
* hist c12_win

*Expenditures on education 
tab c13, m 
* hist c13
winsor c13, gen(c13_win) p(0.01) high
local c13_lab: variable label c13 
label variable c13_win "`c13_lab'"
tab c13_win, m
* hist c13_win 

*Expenditures on leisure 
tab c18, m 
* hist c18
winsor c18, gen(c18_win) p(0.01)
local c18_lab: variable label c18 
label variable c18_win "`c18_lab'"
tab c18_win
* hist c18_win

*Expenditure on transportation 
tab c8, m
* hist c8
winsor c8, gen(c8_win) p(0.01)
local c8_lab: variable label c8 
label variable c8_win "`c8_lab'"
tab c8_win
* hist c8_win

*Expenditures on electricity, gas water, etc. 
tab c5, m
* hist c5
winsor c5, gen(c5_win) p(0.01)
local c5_lab: variable label c5 
label variable c5_win "`c5_lab'"
tab c5_win
* hist c5_win

*Expenditures on communication (telephone, internet, etc.) 
tab c6, m
* hist c6
winsor c6, gen(c6_win) p(0.01) high
local c6_lab: variable label c6 
label variable c6_win "`c6_lab'"
tab c6_win, m
* hist c6_win //lots of zeros

*Expenditures on household chores (e.g., soap, detergent, cosmetics, etc.) 
tab c7, m
* hist c7
winsor c7, gen(c7_win) p(0.01)
local c7_lab: variable label c7 
label variable c7_win "`c7_lab'"
tab c7_win
* hist c7_win

*Expenditures on rent and/or housing repairs 
tab c4, m 
* hist c4
winsor c4, gen(c4_win) p(0.01)
local c4_lab: variable label c4 
label variable c4_win "`c4_lab'"
tab c4_win
* hist c4_win

tab c11, m
* hist c11
winsor c11, gen(c11_win) p(0.01)
local c11_lab: variable label c11 
label variable c11_win "`c11_lab'"
tab c11_win
* hist c11_win

*Expenditures on other services 
tab c14, m
* hist c14
winsor c14, gen(c14_win) p(0.01)
local c14_lab: variable label c14 
label variable c14_win "`c14_lab'"
tab c14_win
* hist c14_win

tab c9, m
* hist c9
winsor c9, gen(c9_win) p(0.01)
local c9_lab: variable label c9 
label variable c9_win "`c9_lab'"
tab c9_win
* hist c9_win

tab c16, m 
* hist c16
winsor c16, gen(c16_win) p(0.01)
local c16_lab: variable label c16 
label variable c16_win "`c16_lab'"
tab c16_win
* hist c16_win
*Expenditures index: weighted standardized average of the above variables.

*/

*5.1.2 SHOCKS AND COPING MECHANISMS
*Death of household principal income earner in the HH 
tab g1, m 
gen g1_1=g1=="1"
replace g1_1=1 if strpos(g1,"1 ")!=0
gen g1_2=(strpos(g1,"2")!=0)
gen g1_3=(strpos(g1,"3")!=0)
gen g1_4=(strpos(g1,"4")!=0)
gen g1_5=(strpos(g1,"5")!=0)
gen g1_6=(strpos(g1,"6")!=0)
gen g1_7=(strpos(g1,"7")!=0)
gen g1_8=(strpos(g1,"8")!=0)
gen g1_9=(strpos(g1,"9")!=0)
label variable g1_1 "Décès du chef du ménage/ source principale de revenus"
label variable g1_2 "Décès d’autres membres du ménage"
label variable g1_3 "Maladie grave du chef du ménage / source principale de revenus"
label variable g1_4 "Maladie grave d’autres membres du ménage"
label variable g1_5 "Perte d'emploi ou échec dans les affaires parmi les membres du ménage" 
label variable g1_6 "Pertes de moyens de subsistance / propriété en raison d’un incendie, de la guerre ou d'autres catastrophes"
label variable g1_7 "Échec de récolte / mauvaise récolte"
label variable g1_8 "Confiscation de vos champs"
label variable g1_9 "Autre"

tab g1_1, m

*Serious illness of principal income earner in the HH 
tab g1_3, m

*Job loss or business failure among HH members 
tab g1_5, m

*Loss of livelihood/property due to fire, natural or other disasters 
tab g1_6, m

*Failed or bad harvest 
tab g1_7, m

*Shocks index: weighted standardized average of the above variables.
*Reduce the number of meals 
tab g2, m
gen g2_1=g2=="1"
replace g2_1=1 if strpos(g2,"1 ")!=0
gen g2_2=(strpos(g2,"2")!=0)
gen g2_3=(strpos(g2,"3")!=0)
gen g2_4=(strpos(g2,"4")!=0)
gen g2_5=(strpos(g2,"5")!=0)
gen g2_6=(strpos(g2,"6")!=0)
gen g2_7=(strpos(g2,"7")!=0)
gen g2_8=(strpos(g2,"8")!=0)
gen g2_9=(strpos(g2,"9")!=0)
gen g2_10=(strpos(g2,"10")!=0)
gen g2_11=(strpos(g2,"11")!=0)
gen g2_12=(strpos(g2,"12")!=0)
gen g2_13=(strpos(g2,"13")!=0)
gen g2_14=(strpos(g2,"14")!=0)
gen g2_15=(strpos(g2,"15")!=0)
gen g2_16=(strpos(g2,"16")!=0)
replace g2_7=0 if g2=="-97" | g2=="-98" | g2=="-99" 
replace g2_8=0 if g2=="-97" | g2=="-98" | g2=="-99" 
replace g2_9=0 if g2=="-97" | g2=="-98" | g2=="-99" 
label variable g2_1 	"Réduit la quantité de nourriture consommée"
label variable g2_2 	"Retirer les enfants de l’école"
label variable g2_3 	"Dettes auprès des amis"
label variable g2_4 	"Dettes auprès des coopératives"
label variable g2_5 	"Dettes auprès des voisins"
label variable g2_6 	"Aide des membres de la famille en dehors du village"
label variable g2_7 	"Envoi des enfants chez les amis"
label variable g2_8 	"Aide par les membres de la communauté"
label variable g2_9 	"Aide du Omda"
label variable g2_10 	"D’autres Omdas"
label variable g2_11 	"Aide des ONG"
label variable g2_12 	"Aide du gouvernement"
label variable g2_13 	"Vente des biens du ménage/champs"
label variable g2_14 	"Vente du bétail"
label variable g2_15 	"Utilisé les épargnes"
label variable g2_16 	"Autre"

tab g2_1, m
*Debts with friends, neighbors or cooperatives 
tab g2_3, m
tab g2_4, m
tab g2_5, m

*Help from friends or other community members/chief 
tab g2_6, m
tab g2_7, m
tab g2_8, m
tab g2_9, m
tab g2_10, m

*Help from NGOs or government 
tab g2_11, m
tab g2_12, m

*Sale of assets (e.g., HH goods, fields, cattle, etc.) 
tab g2_13, m
tab g2_14, m

*Use of savings 
tab g2_15, m

*Extract child from school 
tab g2_2, m

*Coping mechanisms index: weighted standardized average of the above variables.

*5.1.3	HOUSEHOLD ASSETS/WEALTH



***********************************************************************************************************************************************************
			*1. USE WIN 1 FOR 2, 13, 16, 18, 19, 23, superficie and superficie_m like Catherine
***********************************************************************************************************************************************************


		forvalues x = 2/23			{		
										//winsorise superficie more and some assets
			* histogram		q2_1_`x'
			replace 		q2_1_`x' = 0		if   q2_1_`x'  == .
			sum 			q2_1_`x', d
			
			winsor			q2_1_`x', gen(q2_1_`x'_win)  p(0.01)
			winsor			q2_1_`x', gen(q2_1_`x'_win5) p(0.05)

			local 			q2_1_`x'_lab: 	variable label q2_1_`x' 
			label variable 	q2_1_`x'_win 		"`q2_1_`x'_lab'"
			label variable 	q2_1_`x'_win5		"`q2_1_`x'_lab'"

			sum 			q2_1_`x'_win, d
			sum 			q2_1_`x'_win5, d
		}

		local					area			superficie superficie_m  				//don't winsorise time spent...
		foreach var of local 	area	{
			* histogram		`var'
			replace 		`var' = 0		if   `var'  == .
			sum 			`var', d
			
			winsor			`var', gen(`var'_win)  p(0.01)
			winsor			`var', gen(`var'_win5) p(0.05)

			local 			`var'_lab: 	variable label `var' 
			label variable 	`var'_win 		"``var'_lab'"
			label variable 	`var'_win5		"``var'_lab'"

			sum 			`var'_win, d
			sum 			`var'_win5, d
		}



/*
*Movable assets  // will be considered censored
tab q2_1_9, m
replace q2_1_9=0 if q2_1_9==.

tab q2_1_10, m
replace q2_1_10=0 if q2_1_10==.

*Livestock (e.g., cows, goats, chickens, etc.)  // will be considered censored
tab q2_1_18, m
* hist q2_1_18
replace q2_1_18=0 if q2_1_18==.
winsor q2_1_18, gen(q2_1_18_win) p(0.01)
local q2_1_18_lab: variable label q2_1_18 
label variable q2_1_18_win "`q2_1_18_lab'"
tab q2_1_18_win
* hist q2_1_18_win

tab q2_1_19, m
* hist q2_1_19
replace q2_1_19=0 if q2_1_19==.
winsor q2_1_19, gen(q2_1_19_win) p(0.01)
local q2_1_19_lab: variable label q2_1_19 
label variable q2_1_19_win "`q2_1_19_lab'"
replace q2_1_19_win=0 if q2_1_19==.
tab q2_1_19_win
* hist q2_1_19_win

tab q2_1_20, m
replace q2_1_20=0 if q2_1_20==.

tab q2_1_21, m
replace q2_1_21=0 if q2_1_21==.

tab q2_1_22, m
* hist q2_1_22
replace q2_1_22=0 if q2_1_22==.

tab q2_1_23, m
* hist q2_1_23
replace q2_1_23=0 if q2_1_23==.
winsor q2_1_23, gen(q2_1_23_win) p(0.01)
local q2_1_23_lab: variable label q2_1_23 
label variable q2_1_23_win "`q2_1_23_lab'"
replace q2_1_23_win=0 if q2_1_23==.
tab q2_1_23_win
* hist q2_1_23_win

*Furniture (e.g., bed, mattress, bicycles, etc.) // will be considered censored 
tab q2_1_2, m
* hist q2_1_2
replace q2_1_2=0 if q2_1_2==.
winsor q2_1_2, gen(q2_1_2_win) p(0.01)
local q2_1_2_lab: variable label q2_1_2 
label variable q2_1_2_win "`q2_1_2_lab'"
replace q2_1_2_win=0 if q2_1_2==.
tab q2_1_2_win
* hist q2_1_2_win

tab q2_1_3, m
replace q2_1_3=0 if q2_1_3==.

tab q2_1_4, m
replace q2_1_4=0 if q2_1_4==.

tab q2_1_5, m
replace q2_1_5=0 if q2_1_5==.

tab q2_1_6, m
replace q2_1_6=0 if q2_1_6==.

tab q2_1_7, m
replace q2_1_7=0 if q2_1_7==.

tab q2_1_8, m
replace q2_1_8=0 if q2_1_8==.

tab q2_1_11, m
replace q2_1_11=0 if q2_1_11==.

*Electronic equipment (e.g., radio, TV, cell phones, etc.) // will be considered censored
tab q2_1_12, m
replace q2_1_12=0 if q2_1_12==.

tab q2_1_13, m
* hist q2_1_13
replace q2_1_13=0 if q2_1_13==.
winsor q2_1_13, gen(q2_1_13_win) p(0.01)
local q2_1_13_lab: variable label q2_1_13 
label variable q2_1_13_win "`q2_1_13_lab'"
replace q2_1_13_win=0 if q2_1_13==.
tab q2_1_13_win
* hist q2_1_13_win

tab q2_1_14, m
replace q2_1_14=0 if q2_1_14==.

tab q2_1_15, m
replace q2_1_15=0 if q2_1_15==.

tab q2_1_16, m
* hist q2_1_16
replace q2_1_16=0 if q2_1_16==.
winsor q2_1_16, gen(q2_1_16_win) p(0.01)
local q2_1_16_lab: variable label q2_1_16 
label variable q2_1_16_win "`q2_1_16_lab'"
replace q2_1_16_win=0 if q2_1_16==.
tab q2_1_16_win
* hist q2_1_16_win

tab q2_1_17, m
replace q2_1_17=0 if q2_1_17==.
*/
label variable q2_1_2 "Gazinière"
label variable q2_1_3 "Frigidaires"
label variable q2_1_4 "Chauffage"
label variable q2_1_5 "Climatiseurs "
label variable q2_1_6 "Machine à laver "
label variable q2_1_7 "Lits/Matelas de mousse/à ressorts"
label variable q2_1_8 "Armoires"
label variable q2_1_9 "Voitures/camionnette/tracteur"
label variable q2_1_10 "Moto ou scooter"
label variable q2_1_11 "Vélos"
label variable q2_1_12 "Télés"
label variable q2_1_13 "Parabole"
label variable q2_1_14 "Appareil photo"
label variable q2_1_15 "Radio/radiocassette "
label variable q2_1_16 "Téléphones  (fixe ou portable)"
label variable q2_1_17 "Ordinateur (fixe ou portable)/tablette"
label variable q2_1_18 "Moutons /chèvres"
label variable q2_1_19 "Canards / poulets / dindons / lapins"
label variable q2_1_20 "Ruche"
label variable q2_1_21 "Vaches /bœufs  "
label variable q2_1_22 "Anes/chevaux"
label variable q2_1_23 "Chiens/chats/oiseaux"

*Quality of materials used to build one’s home walls 
codebook mur
tab mur, nol
tab mur, gen(mur_dum)
sum mur*

recode mur (1=0) (2=0) (3=1) (4=0) (5=0) (6=1) (7=0) (8=0) (9=0) , gen(mur_dummy)
label variable mur_dummy	"mur dummy 1 if wall cement or brick"

*Quality of materials used to build one’s home roof 
codebook toit
tab toit, nol
tab toit, gen(toit_dum)
sum toit*

recode toit (1=0) (2=0) (3=0) (4=0) (5=1) (6=1) (7=0) (8=0) , gen(toit_dummy)
label variable toit_dummy	"toit dummy 1 if roof cement or tiles"


*House ownership 
codebook proprietaire
tab proprietaire, nol
tab proprietaire, gen(proprietaire_dum)
sum proprietaire*
tab proprietaire_dum1

tab titre, m

*Land ownership 
tab proprietaire_terre, m
/*
tab superficie, m
replace superficie=. if superficie==-96

tab superficie, m
* hist superficie
winsor superficie, gen(superficie_win) p(0.01)
local superficie_lab: variable label superficie 
label variable superficie_win "`superficie_lab'"
tab superficie_win
* hist superficie_win

tab superficie_m, m
tab superficie_m, m
* hist superficie_m
winsor superficie_m, gen(superficie_m_win) p(0.01)
local superficie_m_lab: variable label superficie_m 
label variable superficie_m_win "`superficie_m_lab'"
tab superficie_m_win
* hist superficie_m_win
*/
tab titre_terre, m

*Self-ranking on poverty scale (the ladder question) 
tab f18, m

recode f18 (1=0) (2=0) (3=1) (4=1) (5=1), gen(f18_dummy)
label variable f18_dummy "dummy for 3 or more on the imada poverty scale"

*HH assets index: weighted standardized average of the above variables.

*5.1.4	HUMAN CAPITAL (HARD AND SOFT/LIFE SKILLS) 
*Literacy (can read and write) of head of the HH 
codebook repondant_educ	
gen literacyhh=repondant_educ if repondant_rel==1
tab literacyhh, gen(lithh_dum) 
labeldum repondant_educ lithh_dum
sum lithh_dum* //4, 6, 7 don't vary much
tab lithh_dum1

*Respondent’s highest level of education 
codebook repondant_educ
tab repondant_educ, gen (lit_dum)
sum lit_dum*
tab lit_dum1

*Received training in a trade 
tab formation, m

codebook formation_type 
tab formation_type, nol m //"8" is missing
tab formation_type, gen(formation_dum)
rename formation_dum9 formation_dum10
rename formation_dum8 formation_dum9
sum formation_dum* //1, 2, 4, 6, 9, 10 don't vary much
tab formation_dum1

*Has skills will like to use for a job 
tab emploi_competence_inutilisee, m
ren emploi_competence_inutilisee emploi_comp_inut
tab emploi_comp_inut, m nol
*Human capital index: weighted standardized average of the above variables.

*5.1.5	WAGE EMPLOYMENT AND INCOME
*Waged-employment 
tab emploi, m nol //15% had a job.

* Type Employment
**emploi type_emploi business_q0 type_emploi_q1 type_emploi_q2
gen type_emploi_a=type_emploi=="1"
gen type_emploi_b=type_emploi=="2"
gen type_emploi_c=type_emploi=="3"
gen type_emploi_d=type_emploi=="4"
gen type_emploi_e=type_emploi=="5"
gen type_emploi_f=type_emploi=="6"
gen type_emploi_g=type_emploi=="7"
gen type_emploi_h=type_emploi=="8"
gen type_emploi_i=type_emploi=="9"
gen type_emploi_j=type_emploi=="10"
gen type_emploi_k=type_emploi=="11"
gen type_emploi_l=type_emploi=="12"
gen type_emploi_m=type_emploi=="13"
gen type_emploi_n=type_emploi=="14"
replace type_emploi_h = 0 if type_emploi == "-98"
replace type_emploi_i = 0 if type_emploi == "-98" | type_emploi == "-99"

gen 	informal_sector = 0 if 	emploi == 1 
replace	informal_sector = 1 if 	type_emploi_a == 1 | type_emploi_b == 1 | type_emploi_c == 1 | type_emploi_d == 1 | ///
								type_emploi_e == 1 | type_emploi_f == 1

gen 	formal_sector = 0 if 	emploi == 1 
replace	formal_sector = 1 if 	type_emploi_g == 1 | type_emploi_h == 1 | type_emploi_i == 1 | type_emploi_j == 1 | ///
								type_emploi_k == 1 | type_emploi_l == 1 | type_emploi_m == 1

*total days in month worked
egen 	days_worked	= rowtotal(	type_emploi_q1_1 type_emploi_q1_2 type_emploi_q1_3 type_emploi_q1_4 type_emploi_q1_5 ///
								type_emploi_q1_6 type_emploi_q1_7 type_emploi_q1_8 type_emploi_q1_9 type_emploi_q1_10 ///
								type_emploi_q1_11 type_emploi_q1_12 type_emploi_q1_13 type_emploi_q1_14) if emploi == 1
replace days_worked = 30 if days_worked == 60
								
*total hours in day worked
egen 	hours_worked	= rowtotal(	type_emploi_q2_1 type_emploi_q2_2 type_emploi_q2_3 type_emploi_q2_4 type_emploi_q2_5 ///
								type_emploi_q2_6 type_emploi_q2_7 type_emploi_q2_8 type_emploi_q2_9 type_emploi_q2_10 ///
								type_emploi_q2_11 type_emploi_q2_12 type_emploi_q2_13 type_emploi_q2_14)  if emploi == 1
replace hours_worked = 24 if hours_worked == 30

				
*Days spent in the main job in last 30 days 
tab type_emploi_q1_1, m
tab type_emploi_q1_2, m
tab type_emploi_q1_3, m
tab type_emploi_q1_4, m
tab type_emploi_q1_5, m
tab type_emploi_q1_6, m
tab type_emploi_q1_7, m
tab type_emploi_q1_8, m //does not vary
tab type_emploi_q1_9, m 
tab type_emploi_q1_10, m 
tab type_emploi_q1_11, m 
tab type_emploi_q1_12, m
tab type_emploi_q1_13, m
tab type_emploi_q1_14, m 

egen tspent_main=rowmax(type_emploi_q1_1 type_emploi_q1_2 type_emploi_q1_3 type_emploi_q1_4 ///
type_emploi_q1_5 type_emploi_q1_6 type_emploi_q1_7 type_emploi_q1_8 type_emploi_q1_9 type_emploi_q1_10 ///
type_emploi_q1_11 type_emploi_q1_12 type_emploi_q1_13 type_emploi_q1_14)
label variable tspent_main "Days spent in the main job in last 30 days"
tab tspent_main


*Received wage from main job last month (and amount) 
tab type_emploi_q3_2, m
tab type_emploi_q3_3, m
tab type_emploi_q3_4, m
tab type_emploi_q3_5, m
tab type_emploi_q3_6, m
tab type_emploi_q3_7, m
tab type_emploi_q3_8, m //does not vary
tab type_emploi_q3_9, m 
tab type_emploi_q3_10, m 
tab type_emploi_q3_11, m 
tab type_emploi_q3_12, m
tab type_emploi_q3_13, m
tab type_emploi_q3_14, m 



***********************************************************************************************************************************************************
			*1. USE WIN 1 AND NOT WIN
***********************************************************************************************************************************************************


egen earned_main=rowmax(type_emploi_q3_1 type_emploi_q3_2 type_emploi_q3_3 type_emploi_q3_4 ///
						type_emploi_q3_5 type_emploi_q3_6 type_emploi_q3_7 type_emploi_q3_8 type_emploi_q3_9 type_emploi_q3_10 ///
						type_emploi_q3_11 type_emploi_q3_12 type_emploi_q3_13 type_emploi_q3_14)

label variable earned_main "Received wage from main job last month"

		local					income			earned_main  				//don't winsorise time spent...
		foreach var of local 	income	{
			* histogram		`var'
			sum 			`var', d
			replace			`var'  = 0		if   `var'  == . 
			
			winsor			`var', gen(`var'_win)  p(0.002)
			winsor			`var', gen(`var'_win5) p(0.05)
			local 			`var'_lab: 	variable label `var' 
			label variable 	`var'_win 		"``var'_lab' (win = 0.01)"
			label variable 	`var'_win5		"``var'_lab'  "

			sum 			`var'_win, d
			sum 			`var'_win5, d
		}
		
/*
egen earned_main=rowmax(type_emploi_q3_1 type_emploi_q3_2 type_emploi_q3_3 type_emploi_q3_4 ///
type_emploi_q3_5 type_emploi_q3_6 type_emploi_q3_7 type_emploi_q3_8 type_emploi_q3_9 type_emploi_q3_10 ///
type_emploi_q3_11 type_emploi_q3_12 type_emploi_q3_13 type_emploi_q3_14)
label variable earned_main "Received wage from main job last month"
tab earned_main
* hist earned_main
winsor earned_main, gen(earned_main_win) p(0.01)
local earned_main_lab: variable label earned_main 
label variable earned_main_win "`earned_main_lab'"
tab earned_main_win
* hist earned_main_win
*/

*Looked for paid work in the last 30 days 
tab chomage_recherche, nol m 
replace chomage_recherche=0 if chomage_recherche==.

*Wage employment index: weighted standardized average of the above variables.

*5.1.6	OTHER EMPLOYMENT AND INCOME
*Other employment/income generating activity 
egen sec_empl1=rowtotal(type_emploi_q1_1 type_emploi_q1_2 type_emploi_q1_3 type_emploi_q1_4 ///
type_emploi_q1_5 type_emploi_q1_6 type_emploi_q1_7 type_emploi_q1_8 type_emploi_q1_9 type_emploi_q1_10 ///
type_emploi_q1_11 type_emploi_q1_12 type_emploi_q1_13 type_emploi_q1_14), m
gen sec_empl=(sec_empl1>tspent_main)
replace sec_empl=. if sec_empl1==.
label variable sec_empl "Other employment/income generating activity"

*Days spent working on this activity in the last 30 days 
egen tspent_sec1=rowtotal(type_emploi_q1_1 type_emploi_q1_2 type_emploi_q1_3 type_emploi_q1_4 ///
type_emploi_q1_5 type_emploi_q1_6 type_emploi_q1_7 type_emploi_q1_8 type_emploi_q1_9 type_emploi_q1_10 ///
type_emploi_q1_11 type_emploi_q1_12 type_emploi_q1_13 type_emploi_q1_14), m
gen tspent_sec=(tspent_sec1-tspent_main)
label variable tspent_sec "Days spent working on this activity in the last 30 days"
tab tspent_sec, m
* hist tspent_sec
winsor tspent_sec, gen(tspent_sec_win) p(0.01)
winsor tspent_sec, gen(tspent_sec_win5) p(0.05)
local tspent_sec_lab: variable label tspent_sec 
label variable tspent_sec_win  "`tspent_sec_lab' (win = 0.01)"
label variable tspent_sec_win5 "`tspent_sec_lab'  "
tab tspent_sec_win
* hist tspent_sec_win

*Money earned with this activity in the last 30 days
egen earned_sec1=rowtotal(type_emploi_q3_1 type_emploi_q3_2 type_emploi_q3_3 type_emploi_q3_4 ///
type_emploi_q3_5 type_emploi_q3_6 type_emploi_q3_7 type_emploi_q3_8 type_emploi_q3_9 type_emploi_q3_10 ///
type_emploi_q3_11 type_emploi_q3_12 type_emploi_q3_13 type_emploi_q3_14), m
gen earned_sec=(earned_sec1-earned_main)
label variable earned_sec "Money earned with this activity in the last 30 days"
winsor earned_sec, gen(earned_sec_win) p(0.01)
winsor earned_sec, gen(earned_sec_win5) p(0.05)
local earned_sec_lab: variable label earned_sec 
label variable earned_sec_win  "`earned_sec_lab' (win = 0.01)"
label variable earned_sec_win5 "`earned_sec_lab'  "
tab earned_sec, m
* hist earned_sec

*Other employment index: weighted standardized average of the above variables.
*5.1.7	NON-AGRICULTURAL ENTERPRISE
*Employs people 
tab type_emploi, m 
gen type_emploi_1=type_emploi=="1"
replace type_emploi_1=1 if strpos(type_emploi,"1 ")!=0
gen type_emploi_2=(strpos(type_emploi,"2")!=0)
gen type_emploi_3=(strpos(type_emploi,"3")!=0)
gen type_emploi_4=(strpos(type_emploi,"4")!=0)
gen type_emploi_5=(strpos(type_emploi,"5")!=0)
gen type_emploi_6=(strpos(type_emploi,"6")!=0)
gen type_emploi_7=(strpos(type_emploi,"7")!=0)
gen type_emploi_8=(strpos(type_emploi,"8")!=0)
gen type_emploi_9=(strpos(type_emploi,"9")!=0)
gen type_emploi_10=(strpos(type_emploi,"10")!=0)
gen type_emploi_11=(strpos(type_emploi,"11")!=0)
gen type_emploi_12=(strpos(type_emploi,"12")!=0)
gen type_emploi_13=(strpos(type_emploi,"13")!=0)
gen type_emploi_14=(strpos(type_emploi,"14")!=0)
replace type_emploi_7=0 if type_emploi=="-97" | type_emploi=="-98" | type_emploi=="-99" 
replace type_emploi_8=0 if type_emploi=="-97" | type_emploi=="-98" | type_emploi=="-99" 
replace type_emploi_9=0 if type_emploi=="-97" | type_emploi=="-98" | type_emploi=="-99" 
label variable type_emploi_1 "Agriculteur"
label variable type_emploi_2 "Eleveur"
label variable type_emploi_3 "Pécheur"
label variable type_emploi_4 "Industrie  agro alimentaire"
label variable type_emploi_5 "Construction"
label variable type_emploi_6 "Mécanique et électrique"
label variable type_emploi_7 "Transport"
label variable type_emploi_8 "Banque et assurance"
label variable type_emploi_9 "Hôtels café et restaurant"
label variable type_emploi_10 "Commerçant"
label variable type_emploi_11 "Fonctionnaire d’Etat"
label variable type_emploi_12 "Enseignant"
label variable type_emploi_13 "Militaire/Combattant"
label variable type_emploi_14 "Autre"

tab type_emploi_q6_1, m
replace type_emploi_q6_1=0 if type_emploi_q6_1==.

tab type_emploi_q6_2, m
replace type_emploi_q6_2=0 if type_emploi_q6_2==.

tab type_emploi_q6_3, m nol //does not vary
replace type_emploi_q6_3=0 if type_emploi_q6_3==.

tab type_emploi_q6_4, m nol //does not vary
replace type_emploi_q6_4=0 if type_emploi_q6_4==.

tab type_emploi_q6_5, m
replace type_emploi_q6_5=0 if type_emploi_q6_5==.

tab type_emploi_q6_6, m
replace type_emploi_q6_6=0 if type_emploi_q6_6==.

tab type_emploi_q6_7, m nol //does not vary
replace type_emploi_q6_7=0 if type_emploi_q6_7==.

tab type_emploi_q6_8, m nol //does not vary
replace type_emploi_q6_8=0 if type_emploi_q6_8==.

tab type_emploi_q6_9, m nol //does not vary
replace type_emploi_q6_9=0 if type_emploi_q6_9==.

tab type_emploi_q6_10, m 
replace type_emploi_q6_10=0 if type_emploi_q6_10==.

tab type_emploi_q6_11, m 
replace type_emploi_q6_11=0 if type_emploi_q6_11==.

tab type_emploi_q6_12, m
replace type_emploi_q6_12=0 if type_emploi_q6_12==.

tab type_emploi_q6_13, m nol //does not vary
replace type_emploi_q6_13=0 if type_emploi_q6_13==.

tab type_emploi_q6_14, m 
replace type_emploi_q6_14=0 if type_emploi_q6_14==.

egen employs1=rowmax(type_emploi_q6_1 type_emploi_q6_2 type_emploi_q6_3 type_emploi_q6_4 ///
type_emploi_q6_5 type_emploi_q6_6 type_emploi_q6_7 type_emploi_q6_8 type_emploi_q6_9 type_emploi_q6_10 ///
type_emploi_q6_11 type_emploi_q6_12 type_emploi_q6_13 type_emploi_q6_14) if type_emploi_1 !=1

gen employs=employs1>0
replace employs=. if employs1==.
label variable employs "Employs people"

*Number of people employed 
tab type_emploi_q7_1, m
replace type_emploi_q7_1=0 if type_emploi_q7_1==.

tab type_emploi_q7_2, m
replace type_emploi_q7_2=0 if type_emploi_q7_2==.

tab type_emploi_q7_3, m nol //does not vary
replace type_emploi_q7_3=0 if type_emploi_q7_3==.

tab type_emploi_q7_4, m nol //does not vary
replace type_emploi_q7_4=0 if type_emploi_q7_4==.

tab type_emploi_q7_5, m
replace type_emploi_q7_5=0 if type_emploi_q7_5==.

tab type_emploi_q7_6, m
replace type_emploi_q7_6=0 if type_emploi_q7_6==.

tab type_emploi_q7_7, m nol //does not vary
replace type_emploi_q7_7=0 if type_emploi_q7_7==.

tab type_emploi_q7_8, m nol //does not vary
replace type_emploi_q7_8=0 if type_emploi_q7_8==.

tab type_emploi_q7_9, m nol //does not vary
replace type_emploi_q7_9=0 if type_emploi_q7_9==.

tab type_emploi_q7_10, m 
replace type_emploi_q7_10=0 if type_emploi_q7_10==.

tab type_emploi_q7_11, m 
replace type_emploi_q7_11=0 if type_emploi_q7_11==.

tab type_emploi_q7_12, m
replace type_emploi_q7_12=0 if type_emploi_q7_12==.

tab type_emploi_q7_13, m nol //does not vary
replace type_emploi_q7_13=0 if type_emploi_q7_13==.

tab type_emploi_q7_14, m 
replace type_emploi_q7_14=0 if type_emploi_q7_14==.

egen pers_employ=rowtotal(type_emploi_q7_1 type_emploi_q7_2 type_emploi_q7_3 type_emploi_q7_4 ///
type_emploi_q7_5 type_emploi_q7_6 type_emploi_q7_7 type_emploi_q7_8 type_emploi_q7_9 type_emploi_q7_10 ///
type_emploi_q7_11 type_emploi_q7_12 type_emploi_q7_13 type_emploi_q7_14) if type_emploi_1 !=1, m

label variable pers_employ "Number of people employed"
tab pers_employ, m

replace pers_employ = 0 if pers_employ == 0								// Imput to 0 if no employee

*Number of hours employees worked in the past month (average) 
tab type_emploi_q8_1, m
tab type_emploi_q8_2, m
tab type_emploi_q8_3, m nol //does not vary
tab type_emploi_q8_4, m nol //does not vary
tab type_emploi_q8_5, m
tab type_emploi_q8_6, m
tab type_emploi_q8_7, m nol //does not vary
tab type_emploi_q8_8, m nol //does not vary
tab type_emploi_q8_9, m nol //does not vary
tab type_emploi_q8_10, m 
tab type_emploi_q8_11, m 
tab type_emploi_q8_12, m
tab type_emploi_q8_13, m nol //does not vary
tab type_emploi_q8_14, m 

egen daysperm_employ1=rowtotal(type_emploi_q8_1 type_emploi_q8_2 type_emploi_q8_3 type_emploi_q8_4 ///
type_emploi_q8_5 type_emploi_q8_6 type_emploi_q8_7 type_emploi_q8_8 type_emploi_q8_9 type_emploi_q8_10 ///
type_emploi_q8_11 type_emploi_q8_12 type_emploi_q8_13 type_emploi_q8_14) if type_emploi_1 !=1, m

replace daysperm_employ1 = 0 if pers_employ == 0								// Imput to 0 if no employee

tab type_emploi_q9_1, m
tab type_emploi_q9_2, m
tab type_emploi_q9_3, m nol //does not vary
tab type_emploi_q9_4, m nol //does not vary
tab type_emploi_q9_5, m
tab type_emploi_q9_6, m
tab type_emploi_q9_7, m nol //does not vary
tab type_emploi_q9_8, m nol //does not vary
tab type_emploi_q9_9, m nol //does not vary
tab type_emploi_q9_10, m 
tab type_emploi_q9_11, m 
tab type_emploi_q9_12, m
tab type_emploi_q9_13, m nol //does not vary
tab type_emploi_q9_14, m 

egen hoursperd_employ1=rowtotal(type_emploi_q9_1 type_emploi_q9_2 type_emploi_q9_3 type_emploi_q9_4 ///
type_emploi_q9_5 type_emploi_q9_6 type_emploi_q9_7 type_emploi_q9_8 type_emploi_q9_9 type_emploi_q9_10 ///
type_emploi_q9_11 type_emploi_q9_12 type_emploi_q9_13 type_emploi_q9_14) if type_emploi_1 !=1, m

gen hoursperm_employ=(daysperm_employ1*hoursperd_employ1)/pers_employ
label variable hoursperm_employ "Number of hours employees worked in the past month"
tab hoursperm_employ, m
* hist hoursperm_employ

replace hoursperm_employ = 0 if pers_employ == 0								// Imput to 0 if no employee

*Wages paid to employees in the past month (average) 
tab type_emploi_q10_1, m
tab type_emploi_q10_2, m
tab type_emploi_q10_3, m nol //does not vary
tab type_emploi_q10_4, m nol //does not vary
tab type_emploi_q10_5, m
tab type_emploi_q10_6, m nol //does not vary
tab type_emploi_q10_7, m nol //does not vary
tab type_emploi_q10_8, m nol //does not vary
tab type_emploi_q10_9, m nol //does not vary
tab type_emploi_q10_10, m 
tab type_emploi_q10_11, m 
tab type_emploi_q10_12, m
tab type_emploi_q10_13, m nol //does not vary
tab type_emploi_q10_14, m 

egen paid_employ1=rowtotal(type_emploi_q10_1 type_emploi_q10_2 type_emploi_q10_3 type_emploi_q10_4 ///
type_emploi_q10_5 type_emploi_q10_6 type_emploi_q10_7 type_emploi_q10_8 type_emploi_q10_9 type_emploi_q10_10 ///
type_emploi_q10_11 type_emploi_q10_12 type_emploi_q10_13 type_emploi_q10_14) if type_emploi_1 !=1, m
gen paid_employ=paid_employ1/pers_employ
label variable paid_employ "Wages paid to employees in the past month (average)"
tab paid_employ, m
* hist paid_employ

replace paid_employ = 0 if pers_employ == 0										// Imput to 0 if no employees

*Non-agriculture enterprise index: weighted standardized average of the above variables.

*5.1.8 AGRICULTURAL PRODUCTIVITY AND INCOME
*Agricultural income (produced) 
*Agricultural income (consumed) 
*Agricultural income (sales) 

tab business_q5, m
* hist business_q5
/*winsor business_q5, gen(business_q5_win) p(0.01)
local business_q5_lab: variable label business_q5 
label variable business_q5_win "`business_q5_lab'"
tab business_q5_win
* hist business_q5_win*/

gen agri_income=business_q5 if type_emploi_1==1 //NO OBSERVATION
/*gen agri_income_win=business_q5_win if type_emploi_1==1*/

*Agricultural income (gifted) 
*Agricultural income (stored) 
*Took loan to buy equipment or other inputs 
*Invested
tab business_q3, m
* hist business_q3
/*winsor business_q3, gen(business_q3_win) p(0.01)
local business_q3_lab: variable label business_q3 
label variable business_q3_win "`business_q3_lab'"
tab business_q3_win
* hist business_q3_win*/

gen agri_invest=business_q3 if type_emploi_1==1 //NO OBSERVATION
/*gen agri_invest_win=business_q3_win if type_emploi_1==1*/

*Agricultural productivity & income index: weighted standardized average of the above variables.

*5.1.9 OTHER FARMING ACTIVITIES 
*Practices hunting 
*Practices fishing 
tab type_emploi_3, m

*Income earned from farming activities in the last 7 days 
*Other farming activities index: weighted standardized average of the above

*5.1.10	DEBTS AND SAVINGS
*Saved money in the last 3 months 
tab epargne, m nol

*Has a saving account 
tab epargne_forme, m
gen epargne_forme_1=epargne_forme=="1"
replace epargne_forme_1=1 if strpos(epargne_forme,"1 ")!=0
gen epargne_forme_2=(strpos(epargne_forme,"2")!=0)
gen epargne_forme_3=(strpos(epargne_forme,"3")!=0)
gen epargne_forme_4=(strpos(epargne_forme,"4")!=0)

label variable epargne_forme_3 "Compte en banque"
tab epargne_forme_3, m

*How long able to pay expenses with savings 
*How much do you have in savings?  // will be considered censored

***********************************************************************************************************************************************************
			*1. USE WIN 1 FOR EPARGNE_CB AND NOT WIN OTHERS
***********************************************************************************************************************************************************



		local					saving			cb dette_cb						//pret dette 
		foreach type of local 	saving	{
			* histogram		epargne_`type'
			replace 		epargne_`type' = 0		if   epargne_`type'  == .
			sum 			epargne_`type', d
			
			winsor			epargne_`type', gen(epargne_`type'_win)  p(0.01)
			winsor			epargne_`type', gen(epargne_`type'_win5) p(0.05)

			local 			epargne_`type'_lab: 	variable label epargne_`type' 
			label variable 	epargne_`type'_win 		"`epargne_`type'_lab'"
			label variable 	epargne_`type'_win5		"`epargne_`type'_lab'"

			sum 			epargne_`type'_win, d
			sum 			epargne_`type'_win5,d
		}
		
		
		
/*
tab epargne_cb, m
* hist epargne_cb
replace epargne_cb=0 if epargne_cb==.
winsor epargne_cb, gen(epargne_cb_win) p(0.01)
local epargne_cb_lab: variable label epargne_cb 
label variable epargne_cb_win "`epargne_cb_lab'"
replace epargne_cb_win=0 if epargne_cb==.
tab epargne_cb_win
* hist epargne_cb_win
*/
*Had debt before participation in ELIIP
*Was able to pay debts 
*Debts and savings index: weighted standardized average of the above

*5.1.11 FUTURE EMPLOYMENT PREFERENCE
*Type of job would you like to do in the future 
codebook emploi_futur_type
tab emploi_futur_type, gen(empl_futurt_dum)
sum empl_futurt*
tab empl_futurt_dum1

codebook emploi_futur
tab emploi_futur, gen(empl_futur_dum)
sum empl_futur*
tab empl_futur_dum1

recode emploi_futur (1=1)(2=1)(3=1)(4=1)(5=0)(6=0)(7=0)(8=0)(9=0)(10=0)(11=0) ///
					(12=0)(13=0)(14=0), gen(futur_agriculture)

recode emploi_futur (1=0)(2=0)(3=0)(4=0)(5=0)(6=1)(7=1)(8=1)(9=1)(10=0)(11=0) ///
					(12=1)(13=1)(14=0), gen(futur_services)

label var futur_agriculture "Desire work in: agriculture"
label var futur_services 	"Desire work in: services"


*How much money you expect to earn from this job 

***********************************************************************************************************************************************************
			*1. USE WIN 1 
***********************************************************************************************************************************************************


		ren 				emploi_futur_cb 	emp_futur_cb

		sum					emp_futur_cb	, d
		replace 			emp_futur_cb = 0		if   emp_futur_cb  == .		
			
		winsor				emp_futur_cb, gen(emp_futur_cb_win)  p(0.01)
		winsor				emp_futur_cb, gen(emp_futur_cb_win5) p(0.05)

		local 				emp_futur_cb_lab: variable label emp_futur_cb 
		label variable 		emp_futur_cb_win 	"Income Aspiration (win = 0.01)"
		label variable 		emp_futur_cb_win5	"Income Aspiration  "

		sum 				emp_futur_cb_win , d
		sum 				emp_futur_cb_win5, d		
		
		
		
/*
tab emploi_futur_cb, m
ren emploi_futur_cb emp_futur_cb
* hist emp_futur_cb
winsor emp_futur_cb, gen(emp_futur_cb_win) p(0.01)
local emp_futur_cb_lab: variable label emp_futur_cb 
label variable emp_futur_cb_win "`emp_futur_cb_lab'"
tab emp_futur_cb_win
* hist emp_futur_cb_win
*/

*5.1.12	EMPLOYMENT AND INCOME BY OTHER HOUSEHOLD MEMBERS
*The head of HH has employment 

gen employedhh = 0 
replace employedhh = 1 if repondant_rel==1 & emploi == 1 
label variable employedhh "The head of HH has employment"


*Income head of HH earned in the last month 
egen earnedhh = rowtotal(type_emploi_q3_1 type_emploi_q3_2 type_emploi_q3_3 type_emploi_q3_4 ///
type_emploi_q3_5 type_emploi_q3_6 type_emploi_q3_7 type_emploi_q3_8 type_emploi_q3_9 type_emploi_q3_10 ///
type_emploi_q3_11 type_emploi_q3_12 type_emploi_q3_13 type_emploi_q3_14) if repondant_rel==1, m
label variable earnedhh "Income head of HH earned in the last month"
replace earnedhh = 0 if (repondant_rel == 1 & earnedhh == .)
winsor earnedhh, gen(earnedhh_win) p(0.01)
winsor earnedhh, gen(earnedhh_win5) p(0.05)
local earnedhh_lab: variable label earnedhh 
label variable earnedhh_win "`earnedhh_lab' (win = 0.01)"
label variable earnedhh_win5 "`earnedhh_lab'  "


*Head of HH has other income generating activities 
egen paidjobhh1=rowtotal(type_emploi_q1_1 type_emploi_q1_2 type_emploi_q1_3 type_emploi_q1_4 ///
type_emploi_q1_5 type_emploi_q1_6 type_emploi_q1_7 type_emploi_q1_8 type_emploi_q1_9 type_emploi_q1_10 ///
type_emploi_q1_11 type_emploi_q1_12 type_emploi_q1_13 type_emploi_q1_14) if repondant_rel==1, m
gen paidjobhh=(paidjobhh1>1)
replace paidjobhh=. if paidjobhh1==.
label variable paidjobhh "Head of HH has other income generating activities"

*Number of other HH members with income generating activities if repondant_rel is not 1)
*Income other members of HH earned in the last month 
egen earnedoth=rowtotal(type_emploi_q3_1 type_emploi_q3_2 type_emploi_q3_3 type_emploi_q3_4 ///
type_emploi_q3_5 type_emploi_q3_6 type_emploi_q3_7 type_emploi_q3_8 type_emploi_q3_9 type_emploi_q3_10 ///
type_emploi_q3_11 type_emploi_q3_12 type_emploi_q3_13 type_emploi_q3_14) if repondant_rel!=1, m
label variable earnedoth "Income other members of HH earned in the last month"
replace earnedoth = 1500 if earnedoth == 11000
replace earnedoth = 0 if (repondant_rel ~= 1 & earnedoth == .)
winsor earnedoth, gen(earnedoth_win) p(0.01)
winsor earnedoth, gen(earnedoth_win5) p(0.05)
local earnedoth_lab: variable label earnedhh 
label variable earnedoth_win "`earnedoth_lab' (win = 0.01)"
label variable earnedoth_win5 "`earnedoth_lab'  "


*Members of HH engage in additional income generating activities 
egen paidjoboth1=rowtotal(type_emploi_q1_1 type_emploi_q1_2 type_emploi_q1_3 type_emploi_q1_4 ///
type_emploi_q1_5 type_emploi_q1_6 type_emploi_q1_7 type_emploi_q1_8 type_emploi_q1_9 type_emploi_q1_10 ///
type_emploi_q1_11 type_emploi_q1_12 type_emploi_q1_13 type_emploi_q1_14) if repondant_rel!=1, m
gen paidjoboth=(paidjoboth1>1) 
replace paidjoboth=. if paidjoboth1==.
label variable paidjoboth "Members of HH engage in additional income generating activities"

*Employment and income by other HH members index: weighted standardized average of the above

*5.2 SECONDARY OUTCOMES OF INTEREST
*5.2.1 SOCIAL OUTCOMES
*Access to healthcare 
codebook sante_lieux
tab sante_lieux, nol
tab sante_lieux, gen(sante_lieux_dum)
sum sante_lieux*
tab sante_lieux_dum1


***********************************************************************************************************************************************************
			*1. USE WIN 1  FOR NOW
***********************************************************************************************************************************************************

		local					service			dispensaire ecoleprim ecolesec eau		///
												marche transpublic cheflieu
		foreach type of local 	service	{
			* histogram		distance_`type'
			replace 		distance_`type' = 0		if   distance_`type'  == .
			sum 			distance_`type', d
			
			winsor			distance_`type', gen(distance_`type'_win)  p(0.01)
			winsor			distance_`type', gen(distance_`type'_win5) p(0.05)

			local 			distance_`type'_lab: 		variable label distance_`type' 
			label variable 	distance_`type'_win 		"`distance_`type'_lab'"
			label variable 	distance_`type'_win5		"`distance_`type'_lab'"

			sum 			distance_`type'_win, d
			sum 			distance_`type'_win5, d
		}
		
/*
tab distance_dispensaire, m
* hist distance_dispensaire
winsor distance_dispensaire, gen(distance_dispensaire_win) p(0.01)
local distance_dispensaire_lab: variable label distance_dispensaire 
label variable distance_dispensaire_win "`distance_dispensaire_lab'"
tab distance_dispensaire_win
* hist distance_dispensaire_win

*Access to education 
tab distance_ecoleprim, m
* hist distance_ecoleprim
winsor distance_ecoleprim, gen(distance_ecoleprim_win) p(0.01)
local distance_ecoleprim_lab: variable label distance_ecoleprim 
label variable distance_ecoleprim_win "`distance_ecoleprim_lab'"
tab distance_ecoleprim_win
* hist distance_ecoleprim_win

tab distance_ecolesec, m
* hist distance_ecolesec
winsor distance_ecolesec, gen(distance_ecolesec_win) p(0.01)
local distance_ecolesec_lab: variable label distance_ecolesec 
label variable distance_ecolesec_win "`distance_ecolesec_lab'"
tab distance_ecolesec_win
* hist distance_ecolesec_win

*Having a source of potable water in the house 
tab distance_eau, m
* hist distance_eau
winsor distance_eau, gen(distance_eau_win) p(0.01)
local distance_eau_lab: variable label distance_eau 
label variable distance_eau_win "`distance_eau_lab'"
tab distance_eau_win
* hist distance_eau_win
*/
*Sickness of any HH member in the past year 
tab sante_soins, m

*Frequency of HH visit to a clinic or hospital in the past year and expenditures 
tab sante_hopital, m 
replace sante_hopital=2 if sante_hopital==-2
tab sante_hopital, m 
* hist sante_hopital
winsor sante_hopital, gen(sante_hopital_win) p(0.01) high //lots of exageration
local sante_hopital_lab: variable label sante_hopital 
label variable sante_hopital_win "`sante_hopital_lab'"
tab sante_hopital_win, m
* hist sante_hopital_win //lots of zeros

tab c12, m

*Quality of care 
codebook sante_qualite_b
tab sante_qualite_b, m
tab sante_qualite_b, gen(sante_qualite_b_dum)
recode sante_qualite_b (2=3) (1=2) (0=1)
label define sante_qualite_b 1 "Mauvaise" 2 "Moyenne" 3 "Bonne", modify
label values sante_qualite_b sante_qualite_b
sum sante_qualite_b_dum*

*Affordability of healthcare costs 
codebook sante_qualite_c
tab sante_qualite_c, nol m
tab sante_qualite_c, gen(sante_qualite_c_dum)
recode sante_qualite_c (2=3) (1=2) (0=1)
label define sante_qualite_c 1 "Mauvaise" 2 "Moyenne" 3 "Bonne", modify
label values sante_qualite_c sante_qualite_c
sum sante_qualite_c_dum*

*Quality of education 
codebook ecole_qualite_c
tab ecole_qualite_c, gen(ecole_qualite_c_dum)
recode ecole_qualite_c (2=3) (1=2) (0=1)
label define ecole_qualite_c 1 "Mauvaise" 2 "Moyenne" 3 "Bonne", modify
label values ecole_qualite_c ecole_qualite_c
sum ecole_qualite_c_dum*

*Affordability of education 
codebook ecole_qualite_d
tab ecole_qualite_d, gen(ecole_qualite_d_dum)
recode ecole_qualite_d (2=3) (1=2) (0=1)
label define ecole_qualite_d 1 "Mauvaise" 2 "Moyenne" 3 "Bonne", modify
label values ecole_qualite_d ecole_qualite_d
sum ecole_qualite_d_dum*

*Time it takes to reach infrastructure (average across the different infrastructure) 
/*
tab distance_eau, m

tab distance_marche, m 
replace distance_marche=. if distance_marche==-96
* hist distance_marche
winsor distance_marche, gen(distance_marche_win) p(0.01)
local distance_marche_lab: variable label distance_marche 
label variable distance_marche_win "`distance_marche_lab'"
tab distance_marche_win
* hist distance_marche_win

tab distance_transpublic, m
replace distance_transpublic=. if distance_marche==-96
* hist distance_transpublic
winsor distance_transpublic, gen(distance_transpublic_win) p(0.01)
local distance_transpublic_lab: variable label distance_transpublic 
label variable distance_transpublic_win "`distance_transpublic_lab'"
tab distance_transpublic_win
* hist distance_transpublic_win

tab distance_ecoleprim, m
tab distance_ecolesec, m
tab distance_dispensaire, m

tab distance_cheflieu, m
* hist distance_cheflieu
winsor distance_cheflieu, gen(distance_cheflieu_win) p(0.01)
local distance_cheflieu_lab: variable label distance_cheflieu 
label variable distance_cheflieu_win "`distance_cheflieu_lab'"
tab distance_cheflieu_win
* hist distance_cheflieu_win
*/

*Access to basic services index: weighted standardized average of the above variables.
*Community participation and cohesion 
tab association, m
gen association_1=association=="1"
replace association_1=1 if strpos(association,"1 ")!=0
gen association_2=(strpos(association,"2")!=0)
gen association_3=(strpos(association,"3")!=0)
gen association_4=(strpos(association,"4")!=0)
gen association_5=(strpos(association,"5")!=0) //DOES NOT VARY
gen association_6=(strpos(association,"6")!=0)
gen association_7=(strpos(association,"7")!=0)
gen association_8=(strpos(association,"8")!=0)
gen association_9=(strpos(association,"9")!=0)
replace association_7=0 if association=="-97" | association=="-98" | association=="-99" | association=="-97 -98" | association=="-97 -99"
replace association_8=0 if association=="-97" | association=="-98" | association=="-99" | association=="-97 -98" | association=="-97 -99"
replace association_9=0 if association=="-97" | association=="-98" | association=="-99" | association=="-97 -98" | association=="-97 -99"

label variable association_1 "Une association paysanne"
label variable association_2 "Une association de femmes"
label variable association_3 "Une association religieuse"
label variable association_4 "Une association de jeunes"
label variable association_5 "Une association des anciens combattants"
label variable association_6 "Une association d'épargne et de crédit"
label variable association_7 "Antenne de parti politique / une association de soutien aux hommes politiques"
label variable association_8 "Une association de droits de l'homme"
label variable association_9 "Un autre type d'association (si plusieurs mentionner uniquement la plus importante)"


gen 	association_dummy = 0
replace association_dummy = 1 	if  association_1 == 1 | association_2 == 1 | association_3 == 1 |		///
									association_4 == 1 | association_5 == 1 | association_6 == 1 |		///
									association_7 == 1 | association_8 == 1 | association_9 == 1
label variable			association_dummy "Member of any local association"

*Collective action 
sum comite*
label variable comite_c "Existe-t-il une coopérative (Elevage/Agriculture) dans cet Imada?"
tab comite_c, m

tab comite_c_menage, m
replace comite_c_menage=0 if comite_c_menage==.

*Inter-personal trust 
tab conflit_dispute_in, m
tab conflit_dispute_out, m

*Outer migration (respondent or member of HH lived out of town in the past year) 
tab migration_cm_q1, m

tab migration_q1, m 
replace migration_q1=. if migration_q1==-96

*Crime and violence 
tab securite, m
gen securite_1=securite=="1"
replace securite_1=1 if strpos(securite,"1 ")!=0
gen securite_2=(strpos(securite,"2")!=0)
gen securite_3=(strpos(securite,"3")!=0)
gen securite_4=(strpos(securite,"4")!=0)
gen securite_5=(strpos(securite,"5")!=0)
gen securite_6=(strpos(securite,"6")!=0)
label variable securite_1 "Conflit foncier ou de parcelle"
label variable securite_2 "Découvertes d'armes ou autre matériels et effets militaires"
label variable securite_3 "Cambriolages et vols des biens du ménage"
label variable securite_4 "Agression physique entre membres de l'IMADA"
label variable securite_5 "Violence domestique"
label variable securite_6 "Vols à main armée et meurtre"

gen 	security_dummy = 0
replace security_dummy = 1 if 	/* securite_1 == 1 | securite_2 == 1 | */ securite_3 == 1 | ///
								/* securite_4 == 1 | */ securite_5 == 1 | securite_6 == 1
label variable security_dummy "any security incident last 12 months"

*Social cohesion index: weighted standardized average of the above variables.
*Civic engagement 
tab initiatives, m
gen initiatives_1=initiatives=="1"
replace initiatives_1=1 if strpos(initiatives,"1 ")!=0
gen initiatives_2=(strpos(initiatives,"2")!=0)
gen initiatives_3=(strpos(initiatives,"3")!=0)
gen initiatives_4=(strpos(initiatives,"4")!=0)
gen initiatives_5=(strpos(initiatives,"5")!=0)
gen initiatives_6=(strpos(initiatives,"6")!=0)
gen initiatives_7=(strpos(initiatives,"7")!=0)
gen initiatives_8=(strpos(initiatives,"8")!=0)
gen initiatives_9=(strpos(initiatives,"9")!=0)
gen initiatives_10=(strpos(initiatives,"10")!=0)
gen initiatives_11=(strpos(initiatives,"11")!=0)
gen initiatives_12=(strpos(initiatives,"12")!=0)
gen initiatives_13=(strpos(initiatives,"13")!=0)
gen initiatives_14=(strpos(initiatives,"14")!=0)
gen initiatives_15=(strpos(initiatives,"15")!=0)

replace initiatives_7=0 if initiatives=="-97" | initiatives=="-98" | initiatives=="-99"
replace initiatives_8=0 if initiatives=="-97" | initiatives=="-98" | initiatives=="-99"
replace initiatives_9=0 if initiatives=="-97" | initiatives=="-98" | initiatives=="-99"

label variable initiatives_1 "Participer à une réunion du village?"
label variable initiatives_2 "Rencontrer le Omda pour solutionner un problème?"
label variable initiatives_3 "Rencontrer l'Imam pour parler d'un problème?"
label variable initiatives_4 "Contacter la police ou les tribunaux à propos de certains problèmes que vous aviez?"
label variable initiatives_5 "Rencontrer ou contacter d’autres représentants de l’Etat  à propos de certains problèmes que vous aviez?"
label variable initiatives_6 "Rencontrer les représentants des ONG pour soulever un problème?"
label variable initiatives_7 "Rencontrer le représentant de ce village à l’Assemblée Nationale"
label variable initiatives_8 "Rencontrer les individus influents, mais sans autorité reconnue par l’état"
label variable initiatives_9 "Rencontrer des amis ou des membres de familles"
label variable initiatives_10 "Reconstruire (réhabiliter) une école primaire ou une clinique/dispensaire"
label variable initiatives_11 "Débroussailler ou agrandir la route"
label variable initiatives_12 "Creuser ou réparer un puits ou robinet"
label variable initiatives_13 "Organiser des patrouilles pour sécuriser le village"
label variable initiatives_14 "Reconstruire une mosquée"
label variable initiatives_15 "Construire un marché"

gen 	initiative_dummy = 0
replace initiative_dummy = 1 if initiatives_1 == 1 | initiatives_2 == 1 | initiatives_3 == 1 | ///
								initiatives_4 == 1 | initiatives_5 == 1 | initiatives_6 == 1 | ///
								initiatives_7 == 1 | initiatives_8 == 1 | initiatives_9 == 1 | ///
								initiatives_10 ==1 | initiatives_11 ==1 | initiatives_12 ==1 | ///
								initiatives_13 ==1 | initiatives_14 ==1 | initiatives_15 ==1

*Political knowledge and attitudes 
codebook utopie_accord_a
tab utopie_accord_a, gen(utopie_a_dum)
sum utopie_a_dum*
tab utopie_a_dum1
label variable utopie_a_dum1 "droit participer prise décision: D'accord"
label variable utopie_a_dum2 "droit participer prise décision: Ni l'un, ni l'autre"
label variable utopie_a_dum3 "droit participer prise décision: Pas d'accord"
 
codebook utopie_accord_b
tab utopie_accord_b, gen(utopie_b_dum)
sum utopie_b_dum*
label variable utopie_b_dum1 "vérifier et questionner: D'accord"
label variable utopie_b_dum2 "vérifier et questionner: Ni l'un, ni l'autre"
label variable utopie_b_dum3 "vérifier et questionner: Pas d'accord"

codebook utopie_accord_c
tab utopie_accord_c, gen(utopie_c_dum)
sum utopie_c_dum*
label variable utopie_c_dum1 "vérifier et questionner: D'accord"
label variable utopie_c_dum2 "vérifier et questionner: Ni l'un, ni l'autre"
label variable utopie_c_dum3 "vérifier et questionner: Pas d'accord"

codebook utopie_accord_d
tab utopie_accord_d, gen(utopie_d_dum)
sum utopie_d_dum*
label variable utopie_d_dum1 "vérifier et questionner: D'accord"
label variable utopie_d_dum2 "vérifier et questionner: Ni l'un, ni l'autre"
label variable utopie_d_dum3 "vérifier et questionner: Pas d'accord"

codebook utopie_accord_e
tab utopie_accord_e, gen(utopie_e_dum)
sum utopie_e_dum*
label variable utopie_e_dum1 "vérifier et questionner: D'accord"
label variable utopie_e_dum2 "vérifier et questionner: Ni l'un, ni l'autre"
label variable utopie_e_dum3 "vérifier et questionner: Pas d'accord"

*Political isolation 
tab source_info, m
gen source_info_1=source_info=="1"
replace source_info_1=1 if strpos(source_info,"1 ")!=0
gen source_info_2=(strpos(source_info,"2")!=0)
gen source_info_3=(strpos(source_info,"3")!=0)
gen source_info_4=(strpos(source_info,"4")!=0)
gen source_info_5=(strpos(source_info,"5")!=0)
gen source_info_6=(strpos(source_info,"6")!=0)
gen source_info_7=(strpos(source_info,"7")!=0)
gen source_info_8=(strpos(source_info,"8")!=0)
gen source_info_9=(strpos(source_info,"9")!=0)
replace source_info_7=0 if source_info=="-97" | source_info=="-98" | source_info=="-99"
replace source_info_8=0 if source_info=="-97" | source_info=="-98" | source_info=="-99"
replace source_info_9=0 if source_info=="-97" | source_info=="-98" | source_info=="-99"

label variable source_info_1 "Télévision"
label variable source_info_2 "Radio"
label variable source_info_3 "Internet"
label variable source_info_4 "Imam"
label variable source_info_5 "Omda"
label variable source_info_6 "ONG/associations"
label variable source_info_7 "Amis/famille"
label variable source_info_8 "Rumeurs"
label variable source_info_9 "Autre"

tab source_info2, m
gen source_info2_1=source_info2=="1"
replace source_info2_1=1 if strpos(source_info2,"1 ")!=0
gen source_info2_2=(strpos(source_info2,"2")!=0)
gen source_info2_3=(strpos(source_info2,"3")!=0)
gen source_info2_4=(strpos(source_info2,"4")!=0)
gen source_info2_5=(strpos(source_info2,"5")!=0)
gen source_info2_6=(strpos(source_info2,"6")!=0)
gen source_info2_7=(strpos(source_info2,"7")!=0)
gen source_info2_8=(strpos(source_info2,"8")!=0)
gen source_info2_9=(strpos(source_info2,"9")!=0)
replace source_info2_7=0 if source_info2=="-97" | source_info2=="-98" | source_info2=="-99"
replace source_info2_8=0 if source_info2=="-97" | source_info2=="-98" | source_info2=="-99"
replace source_info2_9=0 if source_info2=="-97" | source_info2=="-98" | source_info2=="-99"

label variable source_info2_1 "Télévision"
label variable source_info2_2 "Radio"
label variable source_info2_3 "Internet"
label variable source_info2_4 "Imam"
label variable source_info2_5 "Omda"
label variable source_info2_6 "ONG/associations"
label variable source_info2_7 "Amis/famille"
label variable source_info2_8 "Rumeurs"
label variable source_info2_9 "Autre"

gen 			source_info_internal	= 0
replace 		source_info_internal 	= 1 if source_info_7 == 1  | source_info_8 == 1
gen 			source_info2_internal	= 0
replace 		source_info2_internal 	= 1 if source_info2_7 == 1 | source_info2_8 == 1
label variable 	source_info_internal  "First Info Source Informal"
label variable 	source_info2_internal "Second Info Source Informal"

tab isolement, m
gen isolement_1=isolement=="1"
replace isolement_1=1 if strpos(isolement,"1 ")!=0
gen isolement_2=(strpos(isolement,"2")!=0)
gen isolement_3=(strpos(isolement,"3")!=0)
gen isolement_4=(strpos(isolement,"4")!=0)
label variable isolement_1 "...visité ou été visité par quelqu'un d'une autre IMADA ou à plus de 5km ?"
label variable isolement_2 "...fait des échanges économiques (achat/vente) avec quelqu'un d'une IMADA voisine ?"
label variable isolement_3 "...visité ou été visité par une personne d'une délégation voisine ?"
label variable isolement_4 "...visité un pays étranger ?"
*Civic engagement index: weighted standardized average of the above variables.

gen 			isolation_dummy	= 0
replace 		isolation_dummy = 1 if isolement_1 == 1 | isolement_2 == 1 | isolement_3 == 1 | isolement_4 == 1
label variable 	isolation_dummy "dummy for any of the external interaction variables - ealving imada, trading etc"



*5.2.2 PSYCHOLOGICAL OUTCOMES
*Mental health and self-esteem 
ren psycho_anxiete psy_anxiete
tab psy_anxiete, m

ren psycho_exploit psy_exploit 
tab psy_exploit, nol

tab psycho_depress5, m
ren psycho_depress5 psy_depress5 
tab psy_depress5, nol m

*Quality of family relationships ( e.g., family acceptance) 
codebook psycho_accepte 
ren psycho_accepte psy_accepte
tab psy_accepte, m 
tab psy_accepte, gen(psy_accepte_dum)
labeldum psy_accepte psy_accepte_dum
sum psy_accepte_dum* //1, 2 don't vary much

tab psycho_depart, m // will be considered censored
ren psycho_depart psy_depart
* hist psy_depart
winsor psy_depart, gen(psy_depart_win) p(0.01)
local psy_depart_lab: variable label psy_depart 
label variable psy_depart_win "`psy_depart_lab'"
tab psy_depart_win
* hist psy_depart_win

codebook psycho_menage
ren psycho_menage psy_menage
tab psy_menage, m 
tab psy_menage, gen(psy_menage_dum)
labeldum psy_menage psy_menage_dum
sum psy_menage_dum* //1 don't vary much

*Perception of HH acceptance in community 
codebook psycho_accepte_menage
ren psycho_accepte_menage psy_a_menage 
tab psy_a_menage, m 
tab psy_a_menage, gen(psy_a_menage_dum)
labeldum psy_a_menage psy_a_menage_dum
sum psy_a_menage_dum* //all don't vary much 

*Life skills 
tab pearlin_4, m

tab pearlin_5, m

*Psychological well-being index: weighted standardized average of the above variables. 

*5.2.3	WOMEN’S DECISION-MAKING AND VIOLENCE AGAINST WOMEN
*Women earned money in the last 6 months 
tab intrahh_1, m

*Women decide alone on the use of the money earned 
tab intrahh_2, m

*Women is the most important person to decide on the use of the money 
*Women’s spouse does not decide how to use the money a women earns 
tab intrahh_7, m //ATTN: VARIABLE SAYS THE OPPOSITE

*Women has not had their money stolen or spent without their consent 
tab intrahh_11, m //ATTN: VARIABLE SAYS THE OPPOSITE

*Wife has an income generating activity 
tab repondant_rel, m
gen emploiw=emploi if repondant_rel==2
label variable emploiw "Wife has an income generating activity"

*Women’s decision making index: weighted standardized average of the above variables.

*Physical violence dummy 
tab violence_1
gen violence_1_1=violence_1=="1"
replace violence_1_1=1 if strpos(violence_1,"1 ")!=0
gen violence_1_2=(strpos(violence_1,"2")!=0)
gen violence_1_3=(strpos(violence_1,"3")!=0)
gen violence_1_4=(strpos(violence_1,"4")!=0)
gen violence_1_5=(strpos(violence_1,"5")!=0)
gen violence_1_6=(strpos(violence_1,"6")!=0)
gen violence_1_7=(strpos(violence_1,"7")!=0)
gen violence_1_8=(strpos(violence_1,"8")!=0)
gen violence_1_9=(strpos(violence_1,"9")!=0)
gen violence_1_10=(strpos(violence_1,"10")!=0)
gen violence_1_11=(strpos(violence_1,"11")!=0)
gen violence_1_16=(strpos(violence_1,"16")!=0)
gen violence_1_17=(strpos(violence_1,"17")!=0)
gen violence_1_18=(strpos(violence_1,"18")!=0)
replace violence_1_7=0 if violence_1=="-97" | violence_1=="-98" | violence_1=="-99"
replace violence_1_8=0 if violence_1=="-97" | violence_1=="-98" | violence_1=="-99"
replace violence_1_9=0 if violence_1=="-97" | violence_1=="-98" | violence_1=="-99"

sum violence_1_1-violence_1_18 //seuls 7 et 9 varient
label variable violence_1_1 "Dernier an: été délibérément insulté (e)."
label variable violence_1_2 "Dernier an:été rabaissé (e) ou humilié (e)."
label variable violence_1_3 "Dernier an:été intentionnellement intimidé (e) ou effrayé (e)."
label variable violence_1_4 "Dernier an:été menacé (e)."
label variable violence_1_5 "Dernier an:a menacé quelqu’un que vous chérissez."
label variable violence_1_6 "Dernier an:été giflé (e) ou on a jeté quelque chose sur vous."
label variable violence_1_7 "Dernier an:été poussé (e), bousculé (e) ou tiré (e) par les cheveux."
label variable violence_1_8 "Dernier an:été frappé (e) avec un coup de poing ou avec qq chose."
label variable violence_1_9 "Dernier an:été frappé (e) par des coups de pied."
label variable violence_1_10 "Dernier an:été volontairement étouffé (e) ou brûlé (e)."
label variable violence_1_11 "Dernier an:été menacé (e) ou on a effectivement utilisé des armes."
label variable violence_1_16 "Dernier an:été interdite d’obtenir un emploi."
label variable violence_1_17 "Dernier an:a pris votre revenu contre votre volonté."
label variable violence_1_18 "Dernier an:été jeté hors de la maison."

*Emotional violence dummy 
tab violence_1_1, m
tab violence_1_2, m
tab violence_1_3, m
tab violence_1_4, m
tab violence_1_5, m

*Economic violence 
tab violence_1_16, m
tab violence_1_17, m
tab violence_1_18, m

gen 	violence_physical	= 0
gen 	violence_emotional	= 0
replace violence_physical 	= 1 if 	violence_1_6 == 1 | violence_1_7 == 1 | violence_1_8 == 1 | ///
									violence_1_9 == 1 | violence_1_10 ==1 | violence_1_11 ==1   
replace violence_emotional  = 1 if  violence_1_1 == 1 | violence_1_2 == 1 | violence_1_3 == 1 | ///
									violence_1_4 == 1 | violence_1_5 == 1 | violence_1_11 ==16| ///
									violence_1_6 ==17 | violence_1_18 == 1
label variable violence_physical	"using violence variable - any physical manifestations"
label variable violence_emotional	"using violence variable - any emotional manifestations"

*Violence against women index: weighted standardized average of the above variables.
*Overall intra-household index: weighted standardized average of women’s decision making index and violence against women index.


* Labor market outcome 

* Main IGA 
g emploi_main = emploi 
label var emploi_main "Had an IGA last 4 weeks"

* Main IGA (if not HH head)
g emploi_sec  = emploi if repondant_rel != 1
label var emploi_sec  "Had an IGA last 4 weeks (HH other)"

* Days worked in main iGA 
egen days_work_main 	= rowtotal(type_emploi_q1_?), mis
label var days_work_main "Number of days work main IGA last 4 weeks"

egen hours_work_main 	= rowtotal(type_emploi_q2_?) if repondant_rel == 1, mis
label var hours_work_main "Number of hours work main IGA last 4 weeks"

egen inc_work_main 		= rowtotal(type_emploi_q3_?), mis
label var inc_work_main "Income from main IGA last 4 weeks"

egen profit_work_main	= rowtotal(type_emploi_q5_?), mis
label var profit_work_main "Profit from main IGA last 4 weeks"

egen days_work_sec 	= rowtotal(type_emploi_q1_?) if repondant_rel != 1, mis
label var days_work_sec "Number of days work main IGA last 4 weeks"

egen hours_work_sec 	= rowtotal(type_emploi_q2_?) if repondant_rel != 1, mis
label var hours_work_sec "Number of hours work main IGA last 4 weeks"

egen inc_work_sec 		= rowtotal(type_emploi_q3_?) if repondant_rel != 1, mis
label var inc_work_sec "Income from main IGA last 4 weeks"

egen profit_work_sec	= rowtotal(type_emploi_q5_?) if repondant_rel != 1, mis
label var profit_work_sec "Profit from main IGA last 4 weeks"

g business_q0_main = business_q0 
g business_q3_main = business_q3 
g business_q5_main = business_q5 

g business_q0_sec 	= business_q0 if repondant_rel != 1
g business_q3_sec  	= business_q3 if repondant_rel != 1
g business_q5_sec	= business_q5 if repondant_rel != 1

label var business_q0_main "Have own business"
label var business_q3_main "Investment in business last 4 weeks"
label var business_q5_main "Profit from business last 4 weeks"

label var business_q0_sec "Have own business"
label var business_q3_sec "Investment in business last 4 weeks"
label var business_q5_sec "Profit from business last 4 weeks"


* Winsorize outcomes 

foreach var in days_work_main hours_work_main inc_work_main profit_work_main{

	cap winsor `var', gen(`var'_win5) p(0.05)
	
	if _rc ==0{
		local l_var : variable label `var'
		label var `var'_win5 "`l_var'"
	}
	else{
		g `var'_win5 = `var'													// When no value to winsor
		local l_var : variable label `var'
		label var `var'_win5 "`l_var'"
	}
	
	cap winsor `var', gen(`var'_win) p(0.01)
	
	if _rc ==0{
		local l_var : variable label `var'
		label var `var'_win "`l_var'"
	}
	else{
		g `var'_win = `var'													// When no value to winsor
		local l_var : variable label `var'
		label var `var'_win "`l_var'"
	}
}

foreach var in business_q3_main business_q5_main{

	cap winsor `var', gen(`var'_win5) p(0.05)
	
	if _rc ==0{
		local l_var : variable label `var'
		label var `var'_win5 "`l_var'"
	}
	else{
		g `var'_win5 = `var'													// When no value to winsor
		local l_var : variable label `var'
		label var `var'_win5 "`l_var'"
	}
	
	cap winsor `var', gen(`var'_win) p(0.01)
	
	if _rc ==0{
		local l_var : variable label `var'
		label var `var'_win "`l_var'"
	}
	else{
		g `var'_win = `var'													// When no value to winsor
		local l_var : variable label `var'
		label var `var'_win "`l_var'"
	}
	
}

* Manual imputation of labor market outcomes 

foreach var in days_work_main hours_work_main inc_work_main profit_work_main{

	replace `var' 		= 0 	if emploi_main 	== 0
	replace `var' 		= .a 	if emploi_main 	==.a
	replace `var' 		= .n 	if emploi_main 	==.n
	replace `var'_win5 	= 0 	if emploi_main 	== 0
	replace `var'_win5 	= .a 	if emploi_main 	==.a
	replace `var'_win5 	= .n 	if emploi_main 	==.n
	replace `var'_win 	= 0 	if emploi_main 	== 0
	replace `var'_win 	= .a 	if emploi_main 	==.a
	replace `var'_win 	= .n 	if emploi_main 	==.n
}

foreach var in business_q3_main business_q5_main{

	replace `var' 		= 0 	if business_q0_main 	== 0
	replace `var' 		= .a 	if business_q0_main		==.a
	replace `var' 		= .n 	if business_q0_main 	==.n
	replace `var'_win5 	= 0 	if business_q0_main 	== 0
	replace `var'_win5 	= .a 	if business_q0_main 	==.a
	replace `var'_win5 	= .n 	if business_q0_main 	==.n
	replace `var'_win 	= 0 	if emploi_main 	== 0
	replace `var'_win 	= .a 	if emploi_main 	==.a
	replace `var'_win 	= .n 	if emploi_main 	==.n
}

* Manual imputation of labor market outcomes 

foreach var in days_work_sec hours_work_sec inc_work_sec profit_work_sec{

	replace `var' = 0 if emploi_sec == 0
}

foreach var in business_q3_sec business_q5_sec{

	replace `var' = 0 if business_q0_sec == 0
}

* Compute number of adult in HH 

egen 	adult_num = rowtotal(h_18_65 f_18_65), mis 
replace adult_num = 1 if adult_num == 0 & repondant_age > 17 & repondant_age < 66

* Label variables

label variable adult_num			"Adult 18-65 years old"
label variable futur_services		"Aspire to work in service"
label variable emp_futur_cb_win	"Income aspiration"
label variable emploi				"Had an IGA during the last 4 weeks"
label variable tspent_main			"Days spent in main IGA"
label variable earned_main_win		"Wage from main activity last month"
label variable employedhh			"HH head main IGA"
label variable earnedhh_win		"HH head main income last month"
label variable paidjobhh			"HH head second IGA"
label variable earnedoth_win		"Other HH member income last month"
label variable paidjoboth			"HH members IGA"
label variable sec_empl				"Other IGA"
label variable tspent_sec_win		"Days spent in other IGA"
label variable earned_sec_win		"Wage from other IGA activity last month"
label variable c3_a_1_win 	"Bread, flour..."
label variable c3_a_2_win 	"Pasta, rice..."
label variable c3_a_3_win 	"Fish"
label variable c3_a_4_win 	"Meat"
label variable c3_a_5_win 	"Eggs and diary"
label variable c3_a_6_win 	"Vegetables"
label variable c3_a_7_win 	"Fruits"
label variable c3_a_8_win 	"Oil"
label variable c3_a_9_win 	"Water and soda"
label variable c3_a_10_win "Seasonning"
label variable c3_a_11_win "Tobacco, coffee and tea"
label variable c4_win 		"Rent"
label variable c5_win 		"Electricity, gaz, petrol..."
label variable c6_win 		"Phone"
label variable c7_win 		"Soap"
label variable c8_win 		"Transport"
label variable c9_win 		"Hairdresser"
label variable c11_win 	"household small repairs"
label variable c12_win 	"Medical expenses"
label variable c13_win 	"Education expenses"
label variable c14_win 	"Clothes"
label variable c15_win 	"Assets"
label variable c16_win 	"Taxes"
label variable c18_win 	"Festivity"
label variable q2_1_2_win 			"Stove"
label variable q2_1_3_win 			"Fridge"
label variable q2_1_4_win 			"Heating"
label variable q2_1_5_win 			"Air conditionner"
label variable q2_1_6_win 			"Washing machine"
label variable q2_1_7_win 			"Bed"
label variable q2_1_8_win 			"Shelf"
label variable q2_1_9_win 			"Automobile"
label variable q2_1_10_win 		"Moto"
label variable q2_1_11_win 		"Bike"
label variable q2_1_12_win 		"Television"
label variable q2_1_13_win 		"Satellite"
label variable q2_1_14_win 		"Camera"
label variable q2_1_16_win 		"Phone"
label variable q2_1_17_win 		"Computer"
label variable q2_1_18_win 		"Sheep"
label variable q2_1_19_win 		"Poultry"
label variable q2_1_20_win 		"Hives"
label variable q2_1_21_win 		"Cattle"
label variable q2_1_22_win 		"Horses"
label variable q2_1_23_win 		"Dog or cat"
label variable mur_dummy 			"Cement or brick wall"
label variable toit_dummy 			"Cement or tiles roof"
label variable proprietaire_dum1 	"Proprietary: house"
label variable titre 				"Tilting property"	
label variable proprietaire_terre 	"Proprietary: land"
label variable superficie_m 		"Size land"
label variable titre_terre 			"Titling land"
label variable g2_1 	"Reduce food consumption"
label variable g2_2 	"Withdraw children from school"
label variable g2_3 	"Debt with friends"
label variable g2_4 	"Debt with coop"
label variable g2_5 	"Debt with neighbors"
label variable g2_6 	"Help from family outside of village"
label variable g2_7 	"Send children away"
label variable g2_8 	"Help from community member"
label variable g2_9		"Help from Omda"
label variable g2_10 	"Help from other Omda"
label variable g2_11 	"Help from NGO"
label variable g2_12 	"Help from Gov."
label variable g2_13 	"Selling assets"
label variable g2_14 	"Selling cattles"
label variable g2_15 	"Use savings"
label variable g1_1 	"Death of HH head (or main income earner)"
label variable g1_2 	"Death of other HH members"
label variable g1_3 	"Serious disease HH head (or main income earner)"
label variable g1_4 	"Serious disease of other HH members"
label variable g1_5 	"Loss of employment or fail business in HH"
label variable g1_6 	"Loss of means because of incident (fire, war..)"
label variable g1_7 	"Bad harvest"
label variable g1_8 	"Land Seizure"
label variable g1_9		"Other"
label variable association_1	"Farmer association"
label variable association_2	"Women association"								
label variable association_3	"Religious association"
label variable association_4	"Youth association"
label variable association_5	"Veteran association"
label variable association_6	"Saving association"
label variable association_7	"Political association"
label variable association_8	"Human right association"
label variable association_9	"Other association"
label variable initiatives_1 	"Participate in townhall"
label variable initiatives_2 	"Meet the Omda"
label variable initiatives_3 	"Meet the Imam"
label variable initiatives_4 	"Contact police or court"
label variable initiatives_5 	"Meet other state representative"
label variable initiatives_6 	"Meet NGO"
label variable initiatives_7 	"Meet village representative at House"
label variable initiatives_8 	"Meet influencial but not official people"
label variable initiatives_9 	"Friends or Family"								
label variable initiatives_10 	"Maintain school or clinic"
label variable initiatives_11 	"Maintain road"
label variable initiatives_12 	"Maintain wells"
label variable initiatives_13 	"Security in village"
label variable initiatives_14 	"Maintain mosquee"
label variable initiatives_15 	"Maintain market"
label variable psy_anxiete			"No fear of losing control"
label variable psy_exploit			"No feeling of being exploited"
label variable psy_depress5			"No useless for others"
label variable psy_accepte_dum3		"Accepted by family"
label variable psy_menage_dum3		"Good relation between HH member"
label variable psy_a_menage_dum3	"Accepted by other HH"
label variable psycho_depress4		"No loss of appetite"
label variable psycho_depress3		"Not feeling irritable"
label variable psycho_depress2		"No loss of interest for activity"
label variable psycho_depress1		"Feeling joy"
label variable violence_1_2 		"Humiliated"
label variable violence_1_3 		"Intimidated"
label variable violence_1_4 		"Threatened"
label variable violence_1_5 		"Threatened relatives"
label variable violence_1_6 		"Slapped"
label variable violence_1_7 		"Pushed"
label variable violence_1_8 		"Punched (hand)"
label variable violence_1_9 		"Punched (feet)"
label variable violence_1_10 		"Burned or strangled"
label variable violence_1_11 		"Threatened with a knife"
label variable violence_1_16 		"Prevented from going to work"
label variable violence_1_17 		"Stole your money"
label variable violence_1_18 		"Laid off"
label variable intrahh_1	"Earn income"
label variable intrahh_2	"Decide by self how own's income is used"
label variable intrahh_7	"Husband doesn't decide by itself how its income is used"
label variable intrahh_11	"Income not being confiscated"
label variable emploiw		"Women IGA"


local lab_market_main 	 		emploi_main days_work_main_win hours_work_main_win inc_work_main_win									///
								profit_work_main_win business_q0_main business_q3_main_win business_q5_main_win
								
/*local lab_market_sec 	 		emploi_sec days_work_sec hours_work_sec inc_work_sec 													///
								profit_work_sec business_q0_sec business_q3_sec business_q5_sec*/
														
local eco_welfare 				c3_a_1_win c3_a_2_win c3_a_3_win c3_a_4_win c3_a_5_win c3_a_6_win c3_a_7_win 					///
								c3_a_8_win c3_a_9_win c3_a_10_win c3_a_11_win c4_win c5_win c6_win 								///
								c7_win c8_win c9_win c11_win c12_win c13_win c14_win c16_win c18_win 

local assets					q2_1_2_win q2_1_3_win q2_1_4_win q2_1_5_win q2_1_6_win q2_1_7_win q2_1_8_win 					///
								q2_1_9_win q2_1_10_win q2_1_11_win q2_1_12_win q2_1_13_win q2_1_14_win 							///
								q2_1_15_win q2_1_16_win q2_1_17_win q2_1_18_win q2_1_19_win 										///
								q2_1_20_win q2_1_21_win q2_1_22_win 

local credit_access				epargne_dette epargne_dette_cb_win epargne epargne_cb_win epargne_pret											


local pos_coping_mechanisms		g2_3 g2_4 g2_5 g2_6  g2_8 g2_9 g2_10 g2_11 g2_12 

local neg_coping_mechanisms		g2_1 g2_2 g2_7 g2_13 g2_14 g2_15	


local shocks					g1_1 g1_2 g1_3 g1_4 g1_5 g1_6 g1_7 g1_8 g1_9


local social				association_1 association_2 initiatives_9 association_9											///
							association_3 association_4 association_6 /*association_7 association_8*/  
							
							
local civic					initiatives_1 initiatives_2 initiatives_3 initiatives_4 initiatives_5 initiatives_6 			///
							initiatives_7 initiatives_8  initiatives_10 initiatives_11 										///
							initiatives_12 initiatives_13 initiatives_14 initiatives_15									

							

local well_being 			psy_anxiete psy_exploit psy_depress5 /*psy_accepte_dum1*/ psy_accepte_dum3 						///
							psy_menage_dum3 /*psy_a_menage_dum1*/ psy_a_menage_dum3	 										///
							psycho_depress4 psycho_depress3 psycho_depress2 psycho_depress1


local woman_empowerment		intrahh_1 intrahh_2 intrahh_7 intrahh_11 emploiw 												///
							violence_1_2 violence_1_3 violence_1_4 violence_1_5 violence_1_6 								///
							violence_1_7 violence_1_8 violence_1_9 violence_1_10 violence_1_11 								///
							violence_1_16 violence_1_17 violence_1_18  

local Index_ALL 			lab_market_main lab_market_sec eco_welfare assets credit_access pos_coping_mechanisms neg_coping_mechanisms	///
							shocks social civic well_being woman_empowerment
							
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

g 		full = . 
replace full = 1 if parti==1 | desist==1 | enquete==3 | control==1

g 		trt_full = 1 if full == 1
replace trt_full = 0 if beneficiaire == 0 & programs == 0  & full == 1


foreach spec in between within spillovers full{

	if "`spec'" == "between"{
	local prg_condition = "between"
	local var_prefix 	= "b"
	}
	
	if "`spec'" == "within"{
	local prg_condition = "within"
	local var_prefix 	= "w"
	}
	
	if "`spec'" == "spillovers"{
	local prg_condition = "spillovers"
	local var_prefix 	= "s"
	}
	
	if "`spec'" == "full"{
	local prg_condition = "full"
	local var_prefix 	= "f"
	}
	
	foreach index of local Index_ALL{

		foreach indiv of local `index'{
		
		g `indiv'_`var_prefix' = `indiv' if `prg_condition' == 1
		
		}
	}
}

save "$stata/enquete_indiv5", replace
