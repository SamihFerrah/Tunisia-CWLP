/*
1) REMPLACER LES CODES 98 99 ETC: ok
2) RECODER AU BESOIN: ok
3) CRÉER LES DUMMIES: ok
3.5) WINSORIZE: ok
4) LABELER (LABELDUM POUR NEW DUMMIES): ok
5) REMPLACER MISSINGS PAR ZERO S'IL Y A LIEU; REF À VAR MÈRE POUR LES _WIN: ok
6) TROUVER LES CENSORED (HIST): ok
7) RENAME REPETITION OF SAME VARS
8) read question and see if makes sense
9) CRÉER LES VARS EN LISTES DES STRING: ok
*/

set more off, perm
use "$stata/enquete_indiv4", clear
mvdecode _all, mv(.98=.n\-98=.n\.99=.a\-99=.a)

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
histogram repondant_age if repondant_age<=100
replace repondant_age=(2016-1975) if repondant_age==1975
replace repondant_age=(2016-1977) if repondant_age==1977
replace repondant_age=. if repondant_age==507
codebook repondant_age //[18,78]
hist repondant_age

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
histogram hhsize
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
				histogram		c3_`y'_`x'
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
				histogram		c3_`y'_`x'
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
hist exp_food 
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
hist exp_food_win
*/
egen exp_food_win=rowtotal	(c3_a_1_win6 c3_a_2_win6 c3_a_3_win c3_a_4_win5 c3_a_5_win5 c3_a_6_win5 c3_a_7_win5 ///
							c3_a_8_win5 c3_a_9_win c3_a_10_win c3_a_11_win5), m											// too much cut?

		
/*		

**Food and beverages
*Value of meat and fish consumed
tab c3_a_3, m 
hist c3_a_3 
replace c3_a_3=0 if c3_a_3==.
winsor c3_a_3, gen(c3_a_3_win) p(0.01)
local c3_a_3_lab: variable label c3_a_3 
label variable c3_a_3_win "`c3_a_3_lab'"
replace c3_a_3_win=0 if c3_a_3==.
tab c3_a_3_win, m
hist c3_a_3_win

tab c3_a_4, m 
hist c3_a_4
replace c3_a_4=0 if c3_a_4==.
winsor c3_a_4, gen(c3_a_4_win) p(0.01)
local c3_a_4_lab: variable label c3_a_4 
label variable c3_a_4_win "`c3_a_4_lab'"
replace c3_a_4_win=0 if c3_a_4==.
tab c3_a_4_win
hist c3_a_4_win

*Value of fruit and legumes/vegetables consumed 
tab c3_a_6, m 
hist c3_a_6
replace c3_a_6=0 if c3_a_6==.
winsor c3_a_6, gen(c3_a_6_win) p(0.01)
local c3_a_6_lab: variable label c3_a_6 
label variable c3_a_6_win "`c3_a_6_lab'"
replace c3_a_6_win=0 if c3_a_6==.
tab c3_a_6_win
hist c3_a_6_win

*Value of egg and milk consumed 
tab c3_a_5, m 
hist c3_a_5
replace c3_a_5=0 if c3_a_5==.
winsor c3_a_5, gen(c3_a_5_win) p(0.01)
local c3_a_5_lab: variable label c3_a_5 
label variable c3_a_5_win "`c3_a_5_lab'"
replace c3_a_5_win=0 if c3_a_5==.
tab c3_a_5_win
hist c3_a_5_win

*Value of oil an fat consumed 
tab c3_a_8, m 
hist c3_a_8
replace c3_a_8=0 if c3_a_8==.
winsor c3_a_8, gen(c3_a_8_win) p(0.01)
local c3_a_8_lab: variable label c3_a_8 
label variable c3_a_8_win "`c3_a_8_lab'"
replace c3_a_8_win=0 if c3_a_8==.
tab c3_a_8_win
hist c3_a_8_win

*Value of beverages consumed 
tab c3_a_9, m
hist c3_a_9
replace c3_a_9=0 if c3_a_9==.
winsor c3_a_9, gen(c3_a_9_win) p(0.01)
local c3_a_9_lab: variable label c3_a_9 
label variable c3_a_9_win "`c3_a_9_lab'"
replace c3_a_9_win=0 if c3_a_9==.
tab c3_a_9_win
hist c3_a_9_win

*Value of cigarette, coffee and tea consumed 
tab c3_a_11, m
hist c3_a_11
replace c3_a_11=0 if c3_a_11==.
winsor c3_a_11, gen(c3_a_11_win) p(0.01)
local c3_a_11_lab: variable label c3_a_11 
label variable c3_a_11_win "`c3_a_11_lab'"
replace c3_a_11_win=0 if c3_a_11==.
tab c3_a_11_win
hist c3_a_11_win

*Value of other consumption, etc. 
tab c3_a_1, m
hist c3_a_1
replace c3_a_1=0 if c3_a_1==.
winsor c3_a_1, gen(c3_a_1_win) p(0.01)
local c3_a_1_lab: variable label c3_a_1 
label variable c3_a_1_win "`c3_a_1_lab'"
replace c3_a_1_win=0 if c3_a_1==.
tab c3_a_1_win
hist c3_a_1_win

tab c3_a_2, m
hist c3_a_2
replace c3_a_2=0 if c3_a_2==.
winsor c3_a_2, gen(c3_a_2_win) p(0.01)
local c3_a_2_lab: variable label c3_a_2 
label variable c3_a_2_win "`c3_a_2_lab'"
replace c3_a_2_win=0 if c3_a_2==.
tab c3_a_2_win
hist c3_a_2_win

tab c3_a_7, m
hist c3_a_7
replace c3_a_7=0 if c3_a_7==.
winsor c3_a_7, gen(c3_a_7_win) p(0.01)
local c3_a_7_lab: variable label c3_a_7 
label variable c3_a_7_win "`c3_a_7_lab'"
replace c3_a_7_win=0 if c3_a_7==.
tab c3_a_7_win
hist c3_a_7_win

tab c3_a_10, m
hist c3_a_10
replace c3_a_10=0 if c3_a_10==.
winsor c3_a_10, gen(c3_a_10_win) p(0.01)
local c3_a_10_lab: variable label c3_a_10 
label variable c3_a_10_win "`c3_a_10_lab'"
replace c3_a_10_win=0 if c3_a_10==.
tab c3_a_10_win
hist c3_a_10_win
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
												
			histogram		c`x'
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
			histogram		c`x'
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
			histogram		c18
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
hist c12
winsor c12, gen(c12_win) p(0.01)
local c12_lab: variable label c12 
label variable c12_win "`c12_lab'"
tab c12_win
hist c12_win

*Expenditures on education 
tab c13, m 
hist c13
winsor c13, gen(c13_win) p(0.01) high
local c13_lab: variable label c13 
label variable c13_win "`c13_lab'"
tab c13_win, m
hist c13_win 

*Expenditures on leisure 
tab c18, m 
hist c18
winsor c18, gen(c18_win) p(0.01)
local c18_lab: variable label c18 
label variable c18_win "`c18_lab'"
tab c18_win
hist c18_win

*Expenditure on transportation 
tab c8, m
hist c8
winsor c8, gen(c8_win) p(0.01)
local c8_lab: variable label c8 
label variable c8_win "`c8_lab'"
tab c8_win
hist c8_win

*Expenditures on electricity, gas water, etc. 
tab c5, m
hist c5
winsor c5, gen(c5_win) p(0.01)
local c5_lab: variable label c5 
label variable c5_win "`c5_lab'"
tab c5_win
hist c5_win

*Expenditures on communication (telephone, internet, etc.) 
tab c6, m
hist c6
winsor c6, gen(c6_win) p(0.01) high
local c6_lab: variable label c6 
label variable c6_win "`c6_lab'"
tab c6_win, m
hist c6_win //lots of zeros

*Expenditures on household chores (e.g., soap, detergent, cosmetics, etc.) 
tab c7, m
hist c7
winsor c7, gen(c7_win) p(0.01)
local c7_lab: variable label c7 
label variable c7_win "`c7_lab'"
tab c7_win
hist c7_win

*Expenditures on rent and/or housing repairs 
tab c4, m 
hist c4
winsor c4, gen(c4_win) p(0.01)
local c4_lab: variable label c4 
label variable c4_win "`c4_lab'"
tab c4_win
hist c4_win

tab c11, m
hist c11
winsor c11, gen(c11_win) p(0.01)
local c11_lab: variable label c11 
label variable c11_win "`c11_lab'"
tab c11_win
hist c11_win

*Expenditures on other services 
tab c14, m
hist c14
winsor c14, gen(c14_win) p(0.01)
local c14_lab: variable label c14 
label variable c14_win "`c14_lab'"
tab c14_win
hist c14_win

tab c9, m
hist c9
winsor c9, gen(c9_win) p(0.01)
local c9_lab: variable label c9 
label variable c9_win "`c9_lab'"
tab c9_win
hist c9_win

tab c16, m 
hist c16
winsor c16, gen(c16_win) p(0.01)
local c16_lab: variable label c16 
label variable c16_win "`c16_lab'"
tab c16_win
hist c16_win
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
			histogram		q2_1_`x'
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
			histogram		`var'
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
hist q2_1_18
replace q2_1_18=0 if q2_1_18==.
winsor q2_1_18, gen(q2_1_18_win) p(0.01)
local q2_1_18_lab: variable label q2_1_18 
label variable q2_1_18_win "`q2_1_18_lab'"
tab q2_1_18_win
hist q2_1_18_win

tab q2_1_19, m
hist q2_1_19
replace q2_1_19=0 if q2_1_19==.
winsor q2_1_19, gen(q2_1_19_win) p(0.01)
local q2_1_19_lab: variable label q2_1_19 
label variable q2_1_19_win "`q2_1_19_lab'"
replace q2_1_19_win=0 if q2_1_19==.
tab q2_1_19_win
hist q2_1_19_win

tab q2_1_20, m
replace q2_1_20=0 if q2_1_20==.

tab q2_1_21, m
replace q2_1_21=0 if q2_1_21==.

tab q2_1_22, m
hist q2_1_22
replace q2_1_22=0 if q2_1_22==.

tab q2_1_23, m
hist q2_1_23
replace q2_1_23=0 if q2_1_23==.
winsor q2_1_23, gen(q2_1_23_win) p(0.01)
local q2_1_23_lab: variable label q2_1_23 
label variable q2_1_23_win "`q2_1_23_lab'"
replace q2_1_23_win=0 if q2_1_23==.
tab q2_1_23_win
hist q2_1_23_win

*Furniture (e.g., bed, mattress, bicycles, etc.) // will be considered censored 
tab q2_1_2, m
hist q2_1_2
replace q2_1_2=0 if q2_1_2==.
winsor q2_1_2, gen(q2_1_2_win) p(0.01)
local q2_1_2_lab: variable label q2_1_2 
label variable q2_1_2_win "`q2_1_2_lab'"
replace q2_1_2_win=0 if q2_1_2==.
tab q2_1_2_win
hist q2_1_2_win

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
hist q2_1_13
replace q2_1_13=0 if q2_1_13==.
winsor q2_1_13, gen(q2_1_13_win) p(0.01)
local q2_1_13_lab: variable label q2_1_13 
label variable q2_1_13_win "`q2_1_13_lab'"
replace q2_1_13_win=0 if q2_1_13==.
tab q2_1_13_win
hist q2_1_13_win

tab q2_1_14, m
replace q2_1_14=0 if q2_1_14==.

tab q2_1_15, m
replace q2_1_15=0 if q2_1_15==.

tab q2_1_16, m
hist q2_1_16
replace q2_1_16=0 if q2_1_16==.
winsor q2_1_16, gen(q2_1_16_win) p(0.01)
local q2_1_16_lab: variable label q2_1_16 
label variable q2_1_16_win "`q2_1_16_lab'"
replace q2_1_16_win=0 if q2_1_16==.
tab q2_1_16_win
hist q2_1_16_win

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
hist superficie
winsor superficie, gen(superficie_win) p(0.01)
local superficie_lab: variable label superficie 
label variable superficie_win "`superficie_lab'"
tab superficie_win
hist superficie_win

tab superficie_m, m
tab superficie_m, m
hist superficie_m
winsor superficie_m, gen(superficie_m_win) p(0.01)
local superficie_m_lab: variable label superficie_m 
label variable superficie_m_win "`superficie_m_lab'"
tab superficie_m_win
hist superficie_m_win
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
			histogram		`var'
			sum 			`var', d
			replace			`var'  = 0		if   `var'  == . 
			
			winsor			`var', gen(`var'_win)  p(0.002)
			winsor			`var', gen(`var'_win5) p(0.05)
			local 			`var'_lab: 	variable label `var' 
			label variable 	`var'_win 		"``var'_lab'"
			label variable 	`var'_win5		"``var'_lab'"

			sum 			`var'_win, d
			sum 			`var'_win5, d
		}
		
/*
egen earned_main=rowmax(type_emploi_q3_1 type_emploi_q3_2 type_emploi_q3_3 type_emploi_q3_4 ///
type_emploi_q3_5 type_emploi_q3_6 type_emploi_q3_7 type_emploi_q3_8 type_emploi_q3_9 type_emploi_q3_10 ///
type_emploi_q3_11 type_emploi_q3_12 type_emploi_q3_13 type_emploi_q3_14)
label variable earned_main "Received wage from main job last month"
tab earned_main
hist earned_main
winsor earned_main, gen(earned_main_win) p(0.01)
local earned_main_lab: variable label earned_main 
label variable earned_main_win "`earned_main_lab'"
tab earned_main_win
hist earned_main_win
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
hist tspent_sec
winsor tspent_sec, gen(tspent_sec_win) p(0.01)
local tspent_sec_lab: variable label tspent_sec 
label variable tspent_sec_win "`tspent_sec_lab'"
tab tspent_sec_win
hist tspent_sec_win

*Money earned with this activity in the last 30 days
egen earned_sec1=rowtotal(type_emploi_q3_1 type_emploi_q3_2 type_emploi_q3_3 type_emploi_q3_4 ///
type_emploi_q3_5 type_emploi_q3_6 type_emploi_q3_7 type_emploi_q3_8 type_emploi_q3_9 type_emploi_q3_10 ///
type_emploi_q3_11 type_emploi_q3_12 type_emploi_q3_13 type_emploi_q3_14), m
gen earned_sec=(earned_sec1-earned_main)
label variable earned_sec "Money earned with this activity in the last 30 days"
tab earned_sec, m
hist earned_sec

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
hist hoursperm_employ

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
hist paid_employ

replace paid_employ = 0 if pers_employ == 0										// Imput to 0 if no employees

*Non-agriculture enterprise index: weighted standardized average of the above variables.

*5.1.8 AGRICULTURAL PRODUCTIVITY AND INCOME
*Agricultural income (produced) 
*Agricultural income (consumed) 
*Agricultural income (sales) 

tab business_q5, m
hist business_q5
/*winsor business_q5, gen(business_q5_win) p(0.01)
local business_q5_lab: variable label business_q5 
label variable business_q5_win "`business_q5_lab'"
tab business_q5_win
hist business_q5_win*/

gen agri_income=business_q5 if type_emploi_1==1 //NO OBSERVATION
/*gen agri_income_win=business_q5_win if type_emploi_1==1*/

*Agricultural income (gifted) 
*Agricultural income (stored) 
*Took loan to buy equipment or other inputs 
*Invested
tab business_q3, m
hist business_q3
/*winsor business_q3, gen(business_q3_win) p(0.01)
local business_q3_lab: variable label business_q3 
label variable business_q3_win "`business_q3_lab'"
tab business_q3_win
hist business_q3_win*/

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
			histogram		epargne_`type'
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
hist epargne_cb
replace epargne_cb=0 if epargne_cb==.
winsor epargne_cb, gen(epargne_cb_win) p(0.01)
local epargne_cb_lab: variable label epargne_cb 
label variable epargne_cb_win "`epargne_cb_lab'"
replace epargne_cb_win=0 if epargne_cb==.
tab epargne_cb_win
hist epargne_cb_win
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
		label variable 		emp_futur_cb_win 	"`emp_futur_cb_lab'"
		label variable 		emp_futur_cb_win5	"`emp_futur_cb_lab'"

		sum 				emp_futur_cb_win , d
		sum 				emp_futur_cb_win5, d		
		
		
		
/*
tab emploi_futur_cb, m
ren emploi_futur_cb emp_futur_cb
hist emp_futur_cb
winsor emp_futur_cb, gen(emp_futur_cb_win) p(0.01)
local emp_futur_cb_lab: variable label emp_futur_cb 
label variable emp_futur_cb_win "`emp_futur_cb_lab'"
tab emp_futur_cb_win
hist emp_futur_cb_win
*/

*5.1.12	EMPLOYMENT AND INCOME BY OTHER HOUSEHOLD MEMBERS
*The head of HH has employment 
gen employedhh = emploi if repondant_rel==1
label variable employedhh "The head of HH has employment"


*Income head of HH earned in the last month 
egen earnedhh = rowtotal(type_emploi_q3_1 type_emploi_q3_2 type_emploi_q3_3 type_emploi_q3_4 ///
type_emploi_q3_5 type_emploi_q3_6 type_emploi_q3_7 type_emploi_q3_8 type_emploi_q3_9 type_emploi_q3_10 ///
type_emploi_q3_11 type_emploi_q3_12 type_emploi_q3_13 type_emploi_q3_14) if repondant_rel==1, m
label variable earnedhh "Income head of HH earned in the last month"
replace earnedhh = 0 if (repondant_rel == 1 & earnedhh == .)
winsor earnedhh, gen(earnedhh_win) p(0.003)
local earnedhh_lab: variable label earnedhh 
label variable earnedhh_win "`earnedhh_lab'"


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
			histogram		distance_`type'
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
hist distance_dispensaire
winsor distance_dispensaire, gen(distance_dispensaire_win) p(0.01)
local distance_dispensaire_lab: variable label distance_dispensaire 
label variable distance_dispensaire_win "`distance_dispensaire_lab'"
tab distance_dispensaire_win
hist distance_dispensaire_win

*Access to education 
tab distance_ecoleprim, m
hist distance_ecoleprim
winsor distance_ecoleprim, gen(distance_ecoleprim_win) p(0.01)
local distance_ecoleprim_lab: variable label distance_ecoleprim 
label variable distance_ecoleprim_win "`distance_ecoleprim_lab'"
tab distance_ecoleprim_win
hist distance_ecoleprim_win

tab distance_ecolesec, m
hist distance_ecolesec
winsor distance_ecolesec, gen(distance_ecolesec_win) p(0.01)
local distance_ecolesec_lab: variable label distance_ecolesec 
label variable distance_ecolesec_win "`distance_ecolesec_lab'"
tab distance_ecolesec_win
hist distance_ecolesec_win

*Having a source of potable water in the house 
tab distance_eau, m
hist distance_eau
winsor distance_eau, gen(distance_eau_win) p(0.01)
local distance_eau_lab: variable label distance_eau 
label variable distance_eau_win "`distance_eau_lab'"
tab distance_eau_win
hist distance_eau_win
*/
*Sickness of any HH member in the past year 
tab sante_soins, m

*Frequency of HH visit to a clinic or hospital in the past year and expenditures 
tab sante_hopital, m 
replace sante_hopital=2 if sante_hopital==-2
tab sante_hopital, m 
hist sante_hopital
winsor sante_hopital, gen(sante_hopital_win) p(0.01) high //lots of exageration
local sante_hopital_lab: variable label sante_hopital 
label variable sante_hopital_win "`sante_hopital_lab'"
tab sante_hopital_win, m
hist sante_hopital_win //lots of zeros

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
hist distance_marche
winsor distance_marche, gen(distance_marche_win) p(0.01)
local distance_marche_lab: variable label distance_marche 
label variable distance_marche_win "`distance_marche_lab'"
tab distance_marche_win
hist distance_marche_win

tab distance_transpublic, m
replace distance_transpublic=. if distance_marche==-96
hist distance_transpublic
winsor distance_transpublic, gen(distance_transpublic_win) p(0.01)
local distance_transpublic_lab: variable label distance_transpublic 
label variable distance_transpublic_win "`distance_transpublic_lab'"
tab distance_transpublic_win
hist distance_transpublic_win

tab distance_ecoleprim, m
tab distance_ecolesec, m
tab distance_dispensaire, m

tab distance_cheflieu, m
hist distance_cheflieu
winsor distance_cheflieu, gen(distance_cheflieu_win) p(0.01)
local distance_cheflieu_lab: variable label distance_cheflieu 
label variable distance_cheflieu_win "`distance_cheflieu_lab'"
tab distance_cheflieu_win
hist distance_cheflieu_win
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
label variable			association_dummy "member of any local association"

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
hist psy_depart
winsor psy_depart, gen(psy_depart_win) p(0.01)
local psy_depart_lab: variable label psy_depart 
label variable psy_depart_win "`psy_depart_lab'"
tab psy_depart_win
hist psy_depart_win

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


save "$stata/enquete_indiv5", replace
*/


























*OUTCOMES USED FROM SEPT 2016 TO APRIL 2017
/*
*PRIMARY
*Employment & productivity
codebook emploi //-99 ne sais pas, -98 ne veut pas répondre, no miss
tab emploi, m nol //15% had a job.
*mvdecode emploi, mv(-99=.a\-98=.n)
tab emploi, nol

codebook chomage //-99, -98, -12, -9, .99, 1000, 2012, 2555 
tab chomage, m
replace chomage=12 if chomage==-12
replace chomage=9 if chomage==-9
replace chomage=2016-2012 if chomage==2012 //**je peux faire cette interprétation?
replace chomage=-99 if chomage>.99 & chomage<1 // .99000001
*mvdecode chomage, mv(-99=.a\-98=.n)
tab chomage, m
*winsor chomage if (chomage !=.a & chomage !=.n), gen(chomage_win) h(5) high// not work well==risky
*mvdecode chomage, mv(2555=.a\ 9999=.a\ 99999=.a)
local chomage_lab: variable label chomage 
*label variable chomage_win "`chomage_lab'"
*tab chomage_win, m
hist chomage

codebook chomage_recherche
tab chomage_recherche, nol m //-98
*mvdecode chomage_recherche, mv(-98=.n)
tab chomage_recherche, nol 

codebook reserv_wage //-99, -98, 0 missings
tab reserv_wage, m
*mvdecode reserv_wage, mv(-99=.a\-98=.n)
tab reserv_wage, m
hist reserv_wage
winsor reserv_wage, gen(reserv_wage_win) p(0.01) high //POUR COUPER LES EXAGÉRATIONS 
local reserv_wage_lab: variable label reserv_wage 
label variable reserv_wage_win "`reserv_wage_lab'"
tab reserv_wage_win, m 
hist reserv_wage_win

codebook emploi_2015_a //-99, -98, 0 miss
tab emploi_2015_a, m nol
*mvdecode emploi_2015_a, mv(-99=.a \-98=.n)
tab emploi_2015_a, m nol

codebook rev_total //-99
tab rev_total, m
replace rev_total=-98 if rev_total==-96
replace rev_total=-99 if rev_total>.99 & rev_total<1 //.99000001
*mvdecode rev_total, mv(-99=.a \-98=.n)
tab rev_total, m
hist rev_total
winsor rev_total, gen(rev_total_win) p(0.01) high
local rev_total_lab: variable label rev_total 
label variable rev_total_win "`rev_total_lab'"
tab rev_total_win, m
hist rev_total_win //looks like a chi

codebook type_emploi_q1_1 //-99; vast majority are missing
tab type_emploi_q1_1 //-99
tab type_emploi_q1_2
tab type_emploi_q1_3
tab type_emploi_q1_4
tab type_emploi_q1_5 //-99
tab type_emploi_q1_6 //-99
tab type_emploi_q1_7 //-99
tab type_emploi_q1_8
tab type_emploi_q1_9 //-99
tab type_emploi_q1_10 //-99
tab type_emploi_q1_11 //-99
tab type_emploi_q1_12
tab type_emploi_q1_13
tab type_emploi_q1_14 //-99

*nb j par mois
*mvdecode type_emploi_q1_1 type_emploi_q1_2 type_emploi_q1_3 type_emploi_q1_4 type_emploi_q1_5 type_emploi_q1_6 ///
type_emploi_q1_7 type_emploi_q1_8 type_emploi_q1_9 type_emploi_q1_10 type_emploi_q1_11 type_emploi_q1_12 ///
type_emploi_q1_13 type_emploi_q1_14, mv(-99=.a)
	
tab type_emploi_q1_1, m //-99; .25/4.2 .a
tab type_emploi_q1_5, m //-99; .22/4.95 .a
tab type_emploi_q1_6, m //-99; .02/.45
tab type_emploi_q1_7, m //-99; .02/.22
tab type_emploi_q1_9, m //-99; .02/.25
tab type_emploi_q1_10, m //-99; .12/.85
tab type_emploi_q1_11, m //-99; .02/1.27
tab type_emploi_q1_14, m //-99; .07/2.33

egen d_per_m=rowtotal(type_emploi_q1_1 type_emploi_q1_2 type_emploi_q1_3 type_emploi_q1_4 type_emploi_q1_5 type_emploi_q1_6 ///
type_emploi_q1_7 type_emploi_q1_8 type_emploi_q1_9 type_emploi_q1_10 type_emploi_q1_11 type_emploi_q1_12 ///
type_emploi_q1_13 type_emploi_q1_14), m
tab d_per_m, m //86% missings
replace d_per_m=30.5 if d_per_m>31
label variable d_per_m "jours au travail par mois"
*winsor d_per_m, gen(d_per_m_win) p(0.01) high
local d_per_m_lab: variable label d_per_m 
*label variable d_per_m_win "`d_per_m_lab'"
*tab d_per_m_win, m

codebook type_emploi_q2_1 //-99
tab type_emploi_q2_1 //-99
tab type_emploi_q2_2 //-99
tab type_emploi_q2_3
tab type_emploi_q2_4
tab type_emploi_q2_5 //-99
tab type_emploi_q2_6 //-99
tab type_emploi_q2_7 //-99
tab type_emploi_q2_8
tab type_emploi_q2_9 //-99
tab type_emploi_q2_10 //-99
tab type_emploi_q2_11 //-99
tab type_emploi_q2_12 //-99
tab type_emploi_q2_13
tab type_emploi_q2_14 //-99
	
*nb h par j
*mvdecode type_emploi_q2_1 type_emploi_q2_2 type_emploi_q2_3 type_emploi_q2_4 type_emploi_q2_5 type_emploi_q2_6 ///
type_emploi_q2_7 type_emploi_q2_8 type_emploi_q2_9 type_emploi_q2_10 type_emploi_q2_11 type_emploi_q2_12 ///
type_emploi_q2_13 type_emploi_q2_14, mv(-99=.a)
	
tab type_emploi_q2_1, m //-99; .32
tab type_emploi_q2_2, m //-99; .02
tab type_emploi_q2_5, m //-99; .17
tab type_emploi_q2_6, m //-99; .07
tab type_emploi_q2_7, m //-99; .07
tab type_emploi_q2_9, m //-99; .02
tab type_emploi_q2_10, m //-99; .12
tab type_emploi_q2_11, m //-99; .05
tab type_emploi_q2_12, m //-99; .02
tab type_emploi_q2_14, m //-99; .12
	
egen h_per_day=rowtotal(type_emploi_q2_1 type_emploi_q2_2 type_emploi_q2_3 type_emploi_q2_4 type_emploi_q2_5 type_emploi_q2_6 ///
type_emploi_q2_7 type_emploi_q2_8 type_emploi_q2_9 type_emploi_q2_10 type_emploi_q2_11 type_emploi_q2_12 ///
type_emploi_q2_13 type_emploi_q2_14), m
tab h_per_day, m //86% missing
replace h_per_day=24 if h_per_day>24
label variable h_per_day "heures au travail par jr (moyenne sur 4 sem)"
*winsor h_per_day, gen(h_per_day_win) p(0.01) high
local h_per_day_lab: variable label h_per_day 
*label variable h_per_day_win "`h_per_day_lab'"
*tab h_per_day_win, m

*Income
*rev_total //checked earlier

codebook business_q0 
tab business_q0 , m nol //very little variation; 99%==0

codebook f2_val_2 //-99, lots of missings
tab f2_val_2, m nol //77% missings NEW, -99
*missings report f2_val_2, p
*mvdecode f2_val_2, mv(-99=.a) 
tab f2_val_2, m nol 
hist f2_val_2
winsor f2_val_2, gen(f2_val_2_win) p(0.01) high //QU'EST-CE QUI EST RÉALISTE?
local f2_val_2_lab: variable label f2_val_2 
label variable f2_val_2_win "`f2_val_2_lab'"
tab f2_val_2_win, m
hist f2_val_2_win //lots of zeros: negative binomial...?

*Consumption (basic needs and luxury) CASE FOR WINSORISATION
codebook c3_a_1 //-99
tab c3_a_1, m //3.5/85
tab c3_b_1, m //-99; 11.4/.85
tab c3_a_4, m //-99 -98
tab c3_b_4, m //-99
codebook c3_a_6
tab c3_a_6, m //-99
tab c3_b_6, m //-99 -98
tab c3_a_11, m //-99
tab c3_b_11, m //-99 -98
tab c4, m //-99 -98 .99 .98
replace c4=-99 if c4>.99 & c4<1
replace c4=-98 if c4>.98 & c4<99
*browse c4 if c4>.9 & c4<1 //none
*mvdecode c3_a_1 c3_a_4 c3_a_6 c3_a_11 c3_b_1 c3_b_4 c3_b_6 c3_b_11 c4, mv(-99=.a\ -98=.n)
gen pain = c3_a_1* c3_b_1 if c3_a_1>=0 & c3_b_1>=0
label variable pain "fréquence * valeur d'achat de pain"
tab pain,m 
hist pain
winsor pain, gen(pain_win) h(4) high //choix discrétionaire
*winsor pain, gen(pain_win) p(0.01) high //choix discrétionaire
local pain_lab: variable label pain 
label variable pain_win "`pain_lab'"
tab pain_win, m
hist pain_win //lots of zeros

gen legumes = c3_a_6* c3_b_6 if c3_a_6>=0 & c3_b_6>=0
label variable legumes "fréquence * valeur d'achat de légumes"
tab legumes, m 
hist legumes
winsor legumes, gen(legumes_win) h(6) high
local legumes_lab: variable label legumes 
label variable legumes_win "`legumes_lab'"
tab legumes_win, m
hist legumes_win //lots of zeros

gen tabac = c3_a_11* c3_b_11 if c3_a_11>=0 & c3_b_11>=0
label variable tabac "fréquence * valeur d'achat de tabac"
tab tabac, m
hist tabac
winsor tabac, gen(tabac_win) h(3) high
local tabac_lab: variable label tabac 
label variable tabac_win "`tabac_lab'"
tab tabac_win, m
hist tabac_win

codebook c12 //no missings
tab c12 //.98 .99 -98 -99
*mvdecode c12, mv(.98=.n\-98=.n\.99=.a\-99=.a)
hist c12
winsor c12, gen(c12_win) p(0.01)
tab c12_win
hist c12_win

*Human capital
codebook c13 //-99
tab c13, m //-99 -98 .99
replace c13=-99 if c13>.99 & c13<1
*mvdecode c13, mv(-99=.a\-98=.n)
tab c13, m
hist c13
winsor c13, gen(c13_win) p(0.01) high
local c13_lab: variable label c13 
label variable c13_win "`c13_lab'"
tab c13_win, m
hist c13_win //chi!!!

codebook formation //-98//88% non
tab formation, m nol
*mvdecode formation, mv(-98=.n)
tab formation, nol

codebook formation_type //88% missings
tab formation_type, nol m //"8" is missing
tab formation_type, gen(formation_dum)
rename formation_dum9 formation_dum10
rename formation_dum8 formation_dum9
sum formation_dum* //1, 2, 4, 6, 9, 10 don't vary much

*Assets holding savings, and investments 
codebook c6 //-99
tab c6 //-99 .99 .98 
replace c6=-99 if c6>.99 & c6<1
replace c6=-98 if c6>.98 & c6<99
*mvdecode c6, mv(-99=.a\-98=.n)
tab c6, nol
hist c6
winsor c6, gen(c6_win) p(0.01) high
local c6_lab: variable label c6 
label variable c6_win "`c6_lab'"
tab c6_win, m
hist c6_win //lots of zeros

codebook c15 //-99
tab c15, m //-99 -98 .99 .98
replace c15=-99 if c15>.99 & c15<1
replace c15=-98 if c15>.98 & c15<99
*mvdecode c15, mv(-99=.a\-98=.n)
tab c15, nol
hist c15
winsor c15, gen(c15_win) p(0.01) high
local c15_lab: variable label c15 
label variable c15_win "`c15_lab'"
tab c15_win, m
hist c15_win //lots of zeros

codebook epargne //-99 -98
tab epargne, m nol
*mvdecode epargne, mv(-99=.a\-98=.n)
tab epargne, nol //don't vary much; 98%==0

codebook epargne_dette //-99 -98 cest quoi cte cb??
tab epargne_dette, m nol
*mvdecode epargne_dette, mv(-99=.a\-98=.n)
tab epargne_dette, nol

codebook epargne_pret
tab epargne_pret, nol m //-99 -98
*mvdecode epargne_pret, mv(-99=.a\-98=.n)
tab epargne_pret, nol //don't vary much; 97%==0

*Credit resources 
codebook c20 //-99 -98
tab c20, nol m //95% no NEW
*mvdecode c20, mv(-99=.a\-98=.n)
tab c20, nol

codebook migration_q5 //-99; max à 200 000
tab migration_q5, m //93% missing
*mvdecode migration_q5, mv(-99=.a\-98=.n)
histogram migration_q5 
tab migration_q5, m 
winsor migration_q5, gen(migration_q5_win) p(0.01) high
local migration_q5_lab: variable label migration_q5 
label variable migration_q5_win "`migration_q5_lab'"
tab migration_q5_win, m
hist migration_q5_win //chi!!

codebook migration_cm_q5 //-99 
tab migration_cm_q5, m //97% missing
*mvdecode migration_cm_q5, mv(-99=.a)
tab migration_cm_q5, m 
hist migration_cm_q5
winsor migration_cm_q5, gen(migration_cm_q5_win) p(0.01) high
local migration_cm_q5_lab: variable label migration_cm_q5 
label variable migration_cm_q5_win "`migration_cm_q5_lab'"
tab migration_cm_q5_win, m
hist migration_cm_q5_win //lots of zeros
 
*epargne_dette

*SECONDARY
*Access to & quality of service 
codebook sante_hopital //-99 
tab sante_hopital, m //-99 -98 -2
replace sante_hopital=2 if sante_hopital==-2
*mvdecode sante_hopital, mv(-99=.a\-98=.n)
tab sante_hopital, m 
hist sante_hopital
winsor sante_hopital, gen(sante_hopital_win) p(0.01) high //lots of exageration
local sante_hopital_lab: variable label sante_hopital 
label variable sante_hopital_win "`sante_hopital_lab'"
tab sante_hopital_win, m
hist sante_hopital_win //lots of zeros

codebook sante_qualite_a sante_qualite_b sante_qualite_c sante_qualite_d
tab sante_qualite_a, nol m
*mvdecode sante_qualite_a, mv(-99=.a\-98=.n)
tab sante_qualite_a, nol
tab sante_qualite_a, gen(sante_qualite_a_dum)
recode sante_qualite_a (2=3) (1=2) (0=1)
labeldum sante_qualite_a sante_qualite_a_dum
sum sante_qualite_a_dum*

tab sante_qualite_b, nol m
*mvdecode sante_qualite_b, mv(-99=.a\-98=.n)
tab sante_qualite_b, nol
tab sante_qualite_b, gen(sante_qualite_b_dum)
recode sante_qualite_b (2=3) (1=2) (0=1)
labeldum sante_qualite_b sante_qualite_b_dum
sum sante_qualite_b_dum*

tab sante_qualite_c, nol m
*mvdecode sante_qualite_c, mv(-99=.a\-98=.n)
tab sante_qualite_c, nol
tab sante_qualite_c, gen(sante_qualite_c_dum)
recode sante_qualite_c (2=3) (1=2) (0=1)
labeldum sante_qualite_c sante_qualite_c_dum
sum sante_qualite_c_dum*

tab sante_qualite_d, nol m
*mvdecode sante_qualite_d, mv(-99=.a\-98=.n)
tab sante_qualite_d, nol
tab sante_qualite_d, gen(sante_qualite_d_dum)
recode sante_qualite_d (2=3) (1=2) (0=1)
labeldum sante_qualite_d sante_qualite_d_dum
sum sante_qualite_d_dum*


*Social cohesion: altruism/trust
codebook responsability //-99 -98 -97
tab responsability, m nol
*mvdecode responsability, mv(-99=.a\-98=.n)
replace responsability=7 if responsability==-97
tab responsability, nol
tab responsability, gen (responsability_dum)
labeldum responsability responsability_dum
sum responsability_dum* //3 and 6 don't vary much

codebook utopie_accord_f //-99 -98
*mvdecode utopie_accord_f, mv(-99=.a\-98=.n)
tab utopie_accord_f, nol
tab utopie_accord_f, gen(utopie_accord_dum)
labeldum utopie_accord_f utopie_accord_dum
sum utopie_accord_dum* //2, 3 don't vary much

codebook psycho_partage_qui //-99 -98 -97 
ren psycho_partage_qui psy_partage_qui 
*mvdecode psy_partage_qui, mv(-99=.a\-98=.n)
replace psy_partage_qui=4 if psy_partage_qui==-97
tab psy_partage_qui, nol
tab psy_partage_qui, gen(psy_partage_dum)
label variable psy_partage_dum4 " psy_partage_qui==personne"
labeldum psy_partage_qui psy_partage_dum
sum psy_partage_dum* //2, 3 don't vary much

codebook psycho_accepte_menage //-99 -98
ren psycho_accepte_menage psy_a_menage 
tab psy_a_menage, m nol
*mvdecode psy_a_menage, mv(-99=.a\-98=.n)
tab psy_a_menage, nol
tab psy_a_menage, gen(psy_a_menage_dum)
labeldum psy_a_menage psy_a_menage_dum
sum psy_a_menage_dum* //all don't vary much 

codebook psycho_solitude
ren psycho_solitude psy_solitude 
tab psy_solitude, nol m //-99 -98
*mvdecode psy_solitude, mv(-99=.a\-98=.n)
tab psy_solitude, nol
tab psy_solitude, gen(psy_solitude_dum)
labeldum psy_solitude psy_solitude_dum
sum psy_solitude_dum* //1 don't vary much

codebook psycho_exploit //-98
ren psycho_exploit psy_exploit 
tab psy_exploit, nol
*mvdecode psy_exploit, mv(-98=.n)
tab psy_exploit, nol

*Propensity to engage in crime and violence
codebook conflit_dispute_in //-99 -98
tab conflit_dispute_in, nol
*mvdecode conflit_dispute_in, mv(-99=.a\-98=.n)
tab conflit_dispute_in, nol //don't vary much

codebook conflit_dispute_out
tab conflit_dispute_out, nol
*mvdecode conflit_dispute_out, mv(-99=.a)
tab conflit_dispute_out, nol //don't vary much


*Mental health
codebook f17 //-99 -98
tab f17, m nol
*mvdecode f17, mv(-99=.a\-98=.n)
tab f17, m nol
tab f17, gen(f17_dum)
labeldum f17 f17_dum
sum f17_dum* //3 don't vary much

codebook emploi_competence_inutilisee //-99 -98
ren emploi_competence_inutilisee emploi_comp_inut
tab emploi_comp_inut, m nol
*mvdecode emploi_comp_inut, mv(-99=.a\-98=.n)
tab emploi_comp_inut, m nol

codebook emploi_difficulte_salarie
tab emploi_difficulte_salarie, m //CRÉÉER LES DUMMIES
gen emploidiffsal_1=(strpos(emploi_difficulte_salarie,"1 ")!=0)
gen emploidiffsal_2=(strpos(emploi_difficulte_salarie,"2 ")!=0)
gen emploidiffsal_3=(strpos(emploi_difficulte_salarie,"3 ")!=0)
gen emploidiffsal_4=(strpos(emploi_difficulte_salarie,"4 ")!=0)
gen emploidiffsal_5=(strpos(emploi_difficulte_salarie,"5 ")!=0)
gen emploidiffsal_6=(strpos(emploi_difficulte_salarie,"6 ")!=0)
gen emploidiffsal_7=(strpos(emploi_difficulte_salarie,"7 ")!=0)
sum emploidiffsal_1-emploidiffsal_7 // 1 4 5 varient
label variable emploidiffsal_1 "Manque d'intérêt"
label variable emploidiffsal_2 "Manque d'idée ou d'information"
label variable emploidiffsal_3 "Manque de qualifications ou compétences"
label variable emploidiffsal_4 "Absence ou insuffisance des moyens financiers"
label variable emploidiffsal_5 "Manque de réseaux ou contacts"
label variable emploidiffsal_6 "Il n'existe pas d'emploi"
label variable emploidiffsal_7 "Autre"
 
codebook emploi_difficulte_independant
tab emploi_difficulte_independant //CRÉÉER LES DUMMIES
gen emploidiffindep_1=(strpos(emploi_difficulte_independant,"1 ")!=0)
gen emploidiffindep_2=(strpos(emploi_difficulte_independant,"2 ")!=0)
gen emploidiffindep_3=(strpos(emploi_difficulte_independant,"3 ")!=0)
gen emploidiffindep_4=(strpos(emploi_difficulte_independant,"4 ")!=0)
gen emploidiffindep_5=(strpos(emploi_difficulte_independant,"5 ")!=0)
gen emploidiffindep_6=(strpos(emploi_difficulte_independant,"6 ")!=0)
gen emploidiffindep_7=(strpos(emploi_difficulte_independant,"7 ")!=0)
sum emploidiffindep_1-emploidiffindep_7 // 1 4 varient
label variable emploidiffindep_1 "Manque d'intérêt"
label variable emploidiffindep_2 "Manque d'idée ou d'information"
label variable emploidiffindep_3 "Manque de qualifications ou compétences"
label variable emploidiffindep_4 "Absence ou insuffisance des moyens financiers"
label variable emploidiffindep_5 "Manque de réseaux ou contacts"
label variable emploidiffindep_6 "Il n'existe pas d'emploi"
label variable emploidiffindep_7 "Autre"

codebook pearlin_1 
tab pearlin_1, nol m
*mvdecode pearlin_1, mv(-98=.n)
tab pearlin_1, nol m

*psy_a_menage 

codebook psycho_depress5
ren psycho_depress5 psy_depress5 
tab psy_depress5, nol m
*mvdecode psy_depress5, mv(-98=.n)
tab psy_depress5, nol m

*Quality of family relationships
codebook te_3 //-99
tab te_3, m nol //78% missings
label define te3 1 "Très dangereux" 2 "Dangereux" 3 "Peu dangereux" 4 "Pas du tout dangereux"
label values te_3 te3
*mvdecode te_3, mv(-99=.a)
tab te_3, m nol
tab te_3, gen(te_3_dum)
labeldum te_3 te_3_dum
sum te_3_dum* //1 don't vary much

codebook psycho_accepte //-99 -98
ren psycho_accepte psy_accepte
tab psy_accepte, m nol
*mvdecode psy_accepte, mv(-99=.a\-98=.n)
tab psy_accepte, m nol
tab psy_accepte, gen(psy_accepte_dum)
labeldum psy_accepte psy_accepte_dum
sum psy_accepte_dum* //1, 2 don't vary much

codebook psycho_menage //-99-98
ren psycho_menage psy_menage
tab psy_menage, m nol
*mvdecode psy_menage, mv(-99=.a\-98=.n)
tab psy_menage, m nol
tab psy_menage, gen(psy_menage_dum)
labeldum psy_menage psy_menage_dum
sum psy_menage_dum* //1 don't vary much

codebook intrahh_11 //-99 -98
tab intrahh_11, m nol //47% missing
*mvdecode intrahh_11, mv(-99=.a\-98=.n)
tab intrahh_11, m nol //minimal variation

codebook violence_1 //151 unique values, -97 -98 //85% missing
tab violence_1 //CRÉER LES DUMMIES
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

codebook violence_2 //263 unique values, -97 -98 //69% missing
tab violence_2 //CRÉER LES DUMMIES
gen violence_2_1=violence_2=="1"
replace violence_2_1=1 if strpos(violence_2,"1 ")!=0
gen violence_2_2=(strpos(violence_2,"2")!=0)
gen violence_2_3=(strpos(violence_2,"3")!=0)
gen violence_2_4=(strpos(violence_2,"4")!=0)
gen violence_2_5=(strpos(violence_2,"5")!=0)
gen violence_2_6=(strpos(violence_2,"6")!=0)
gen violence_2_7=(strpos(violence_2,"7")!=0)
gen violence_2_8=(strpos(violence_2,"8")!=0)
gen violence_2_9=(strpos(violence_2,"9")!=0)
gen violence_2_10=(strpos(violence_2,"10")!=0)
gen violence_2_11=(strpos(violence_2,"11")!=0)
gen violence_2_16=(strpos(violence_2,"16")!=0)
gen violence_2_17=(strpos(violence_2,"17")!=0)
gen violence_2_18=(strpos(violence_2,"18")!=0)
sum violence_2_1-violence_2_18 // 1, 2, 3, 7, 9 varient
label variable violence_2_1 "été délibérément insulté (e)."
label variable violence_2_2 "été rabaissé (e) ou humilié (e)."
label variable violence_2_3 "été intentionnellement intimidé (e) ou effrayé (e)."
label variable violence_2_4 "été menacé (e)."
label variable violence_2_5 "a menacé quelqu’un que vous chérissez."
label variable violence_2_6 "été giflé (e) ou on a jeté quelque chose sur vous."
label variable violence_2_7 "été poussé (e), bousculé (e) ou tiré (e) par les cheveux."
label variable violence_2_8 "été frappé (e) avec un coup de poing ou avec qq chose."
label variable violence_2_9 "été frappé (e) par des coups de pied."
label variable violence_2_10 "été volontairement étouffé (e) ou brûlé (e)."
label variable violence_2_11 "été menacé (e) ou on a effectivement utilisé des armes."
label variable violence_2_16 "été interdite d’obtenir un emploi."
label variable violence_2_17 "a pris votre revenu contre votre volonté."
label variable violence_2_18 "été jeté hors de la maison."

*identifiy the censored among the continuous
hist repondant_age
hist handicap
hist chomage //oui!
hist reserv_wage //oui!
hist reserv_wage_win //oui!
hist rev_total
hist rev_total_win //oui
hist h_per_day
hist d_per_m
hist f2_val_2
hist f2_val_2_win
hist c12
hist c3_a_1 //could be
hist c3_b_1 //could be
hist c3_a_6 //could be
hist c3_b_6 //could be
hist c3_a_11 //could be
hist c3_b_11 //could be
hist c4
hist pain //could be
hist pain_win //could be
hist legumes //could be
hist legumes_win //could be
hist tabac //could be
hist tabac_win //could be
hist c13 //could be
hist c13_win //could be
hist c6 //could be
hist c6_win //could be
hist c15 //could be
hist c15_win //could be
hist migration_q5
hist migration_q5_win
hist sante_hopital
hist sante_hopital_win

*/
