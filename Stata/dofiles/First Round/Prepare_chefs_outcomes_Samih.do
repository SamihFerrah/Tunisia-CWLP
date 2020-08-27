
use "$stata/tunisia_chefs_benef", clear
mvdecode _all, mv(.98=.n\-98=.n\.99=.a\-99=.a\.97=.d\-97=.d)

sort imada
by imada: count //2, one 3 per imada



*Controls
	*QUESTIONNAIRE CHEFS
	*cours d'eau
	tab q0_1, nol m //no missings; vary little
	

	tab q1_1, m //string of list 
	gen q1_1_1=regexm(q1_1,"1")
	tab q1_1_1, m
	browse q1_1 q1_1_1
	gen q1_1_2=regexm(q1_1,"2")
	gen q1_1_3=regexm(q1_1,"3")
	gen q1_1_4=regexm(q1_1,"4")
	gen q1_1_5=regexm(q1_1,"5")
	gen q1_1_6=regexm(q1_1,"6")
	gen q1_1_7=regexm(q1_1,"7")
	egen six_months=rowtotal(q1_1_1-q1_1_7)
	label variable six_months "Number of events last 6 months"

	
	*negative chocs: NO: not prior to treatment
/*	tab q1_3, m //string of list 
	gen q1_3_1=regexm(q1_3,"1")
	tab q1_3_1, m
	browse q1_3 q1_3_1
	gen q1_3_2=regexm(q1_3,"2")
	gen q1_3_3=regexm(q1_3,"3")
	gen q1_3_4=regexm(q1_3,"4")
	gen q1_3_5=regexm(q1_3,"5")
	gen q1_3_6=regexm(q1_3,"6")
	gen q1_3_7=regexm(q1_3,"7")
	gen q1_3_8=regexm(q1_3,"8")
	gen q1_3_9=regexm(q1_3,"9")
	egen neg_chocs=rowtotal(q1_3_1-q1_3_9)
	label variable neg_chocs "Score événements négatifs depuis 5 ans dans communauté"
*/
	*positive chocs: NO: not prior to treatment
/*	tab q1_4, m 
	gen q1_4_1=regexm(q1_4,"1")
	gen q1_4_2=regexm(q1_4,"2")
	gen q1_4_3=regexm(q1_4,"3")
	gen q1_4_4=regexm(q1_4,"4")
	gen q1_4_5=regexm(q1_4,"5")
	gen q1_4_6=regexm(q1_4,"6")
	gen q1_4_7=regexm(q1_4,"7")
	gen q1_4_8=regexm(q1_4,"8")
	egen pos_chocs=rowtotal(q1_4_1-q1_4_8)
	label variable pos_chocs "Score événements positifs depuis 5 ans dans communauté"
*/	
	*activité écon (toutes conti)
	tab q2_1, m 
	gen 			q2_1_prop = q2_1/100
	label variable	q2_1_prop "Proportion of hhs in agriculture in the imada"
	
	tab q2_2, m //vary little
	tab q2_3, m 
	tab q2_4, m 
	tab q2_5, m 
	tab q2_6, m
	
	*type de droits de propriété
	tab q2_9, m //no miss
	gen q2_9_dum1=regexm(q1_4,"1")
	gen q2_9_dum2=regexm(q1_4,"2")
	gen q2_9_dum3=regexm(q1_4,"3")
	gen q2_9_dum4=regexm(q1_4,"4")
	label variable q2_9_dum1 "droits de propriété sur leurs propres parcelles"
	label variable q2_9_dum2 "possession exclusive de la récolte, mais pas de droits de propriété"
	label variable q2_9_dum3 "parcelles qui appartiennent en commun soit au village ou à leur famille"
	label variable q2_9_dum4 "permettent à d'autres d'utiliser leurs terres pour un prix ou % de la récolte"
	sum q2_9_dum1 q2_9_dum2 q2_9_dum3 q2_9_dum4
	
	*type projet cash-for-work
	tab q0_6, m
	gen q0_6_dum1=regexm(q0_6,"1")
	gen q0_6_dum2=regexm(q0_6,"2")
	gen q0_6_dum3=regexm(q0_6,"3")
	gen q0_6_dum4=regexm(q0_6,"4")
	label variable q0_6_dum1 "Réhabilitation école Primaire"
	label variable q0_6_dum2 "Réaménagement piste rurale"
	label variable q0_6_dum3 "Nettoyage pare feu"
	label variable q0_6_dum4 "Pépinière forestière"
	sum q0_6_dum1 q0_6_dum2 q0_6_dum3 q0_6_dum4
/*
	*SECONDARY
	*Access to & quality of service 
	*q3_score_quality 
	tab q3_11, m //85% de missings...
	sum q3_11 q3_12 q3_13 q3_14 q3_15 q3_16 q3_17 q3_18 q3_19 q3_110 ///
	q3_111 q3_112 q3_113 q3_114 q3_115 q3_116 q3_117 q3_118 q3_119 q3_120 ///
	q3_121 q3_122 q3_123 q3_124 q3_125 //19, 11 21 don't vary; 8, 9, 10, 12 peu d'obs
	egen q3_score_quality = rowtotal(q3_11 q3_12 q3_13 q3_14 q3_15 q3_16 q3_17 q3_18 q3_19 q3_110 ///
	q3_111 q3_112 q3_113 q3_114 q3_115 q3_116 q3_117 q3_118 q3_119 q3_120 ///
	q3_121 q3_122 q3_123 q3_124 q3_125)
	label variable q3_score_quality "Score qualité infrastructures"	
	codebook q3_score_quality
	tab q3_score_quality, m 
	/*
	label variable q3_11  "Qualité infrastructure: Maternelle"
	label variable q3_12  "Qualité infrastructure: Primaire"
	label variable q3_13  "Qualité infrastructure: Collège"
	label variable q3_14  "Qualité infrastructure: lycée secondaire"
	label variable q3_15  "Qualité infrastructure: Centre de formation professionnelle"
	label variable q3_16  "Qualité infrastructure: Dispensaire"
	label variable q3_17  "Qualité infrastructure: Centre de santé de base"
	label variable q3_18  "Qualité infrastructure: Infirmeries"
	label variable q3_19  "Qualité infrastructure: Clinique Privée"
	label variable q3_110  "Qualité infrastructure: Docteur/Spécialiste privé"
	label variable q3_111  "Qualité infrastructure: Sage-femme"
	label variable q3_112  "Qualité infrastructure: Dentiste"
	label variable q3_113  "Qualité infrastructure: Pharmacie"
	label variable q3_114  "Qualité infrastructure: téléphone fixe"
	label variable q3_115  "Qualité infrastructure: Couverture Réseau mobile"
	label variable q3_116  "Qualité infrastructure: Connexion internet"
	label variable q3_117  "Qualité infrastructure: Services postaux"
	label variable q3_118  "Qualité infrastructure: Eclairage publics"
	label variable q3_119  "Qualité infrastructure: Route goudronnées"
	label variable q3_120  "Qualité infrastructure: Sources d’Eau potable publique"
	label variable q3_121  "Qualité infrastructure: Institution de Microfinance BTS /INDA etc…)"
	label variable q3_122  "Qualité infrastructure: Poste de Police"
	label variable q3_123  "Qualité infrastructure: Marchés fixes ou hebdomadaires"
	label variable q3_124  "Qualité infrastructure: Mosquée"
	label variable q3_125 "Qualité infrastructure: Centre loisir et/ou de culture"
*/
	*q3_score_dist PAS FIABLE!
	tab q3_21, m //it's in kilometers... and 1== maternelle.
	sum q3_21 q3_22 q3_23 q3_24 q3_25 q3_26 q3_27 q3_28 q3_29 q3_210 ///
	q3_211 q3_212 q3_213 q3_214 q3_215 q3_216 q3_217 q3_218 q3_219 q3_220 ///
	q3_221 q3_222 q3_223 q3_224 q3_225 //9, 11, 21 don't vary
	foreach var of varlist q3_21 q3_22 q3_23 q3_24 q3_25 q3_26 q3_27 q3_28 q3_29 q3_210 ///
	q3_211 q3_212 q3_213 q3_214 q3_215 q3_216 q3_217 q3_218 q3_219 q3_220 ///
	q3_221 q3_222 q3_223 q3_224 q3_225 {
	list vil_superviseur if `var'>99
	}
	tab q3_21 
	tab q3_22 
	tab q3_23 
	tab q3_24 
	tab q3_25 
	tab q3_26 
	tab q3_27 
	tab q3_28 
	tab q3_29 
	tab q3_210 
	tab q3_211 
	tab q3_212 
	tab q3_213 
	tab q3_214 
	tab q3_215 
	tab q3_216 
	tab q3_217 
	tab q3_218 
	tab q3_219 
	tab q3_220 
	tab q3_221 
	tab q3_222 
	tab q3_223 
	tab q3_224 
	tab q3_225
	
	egen q3_score_dist = rowtotal(q3_21 q3_22 q3_23 q3_24 q3_25 q3_26 q3_27 q3_28 q3_29 q3_210 ///
	q3_211 q3_212 q3_213 q3_214 q3_215 q3_216 q3_217 q3_218 q3_219 q3_220 ///
	q3_221 q3_222 q3_223 q3_224 q3_225)
	label variable q3_score_dist "Score distance intrastructures (km)"	
	tab q3_score_dist

	*q3_score_time
	tab q3_51, m
	sum q3_51 q3_52 q3_53 q3_54 q3_55 q3_56 q3_57 q3_58 q3_59 q3_510 ///
	q3_511 q3_512 q3_513 q3_514 q3_515 q3_516 q3_517 q3_518 q3_519 q3_520 ///
	q3_521 q3_522 q3_523 q3_524 q3_525
	egen q3_score_time = rowtotal(q3_51 q3_52 q3_53 q3_54 q3_55 q3_56 q3_57 q3_58 q3_59 q3_510 ///
	q3_511 q3_512 q3_513 q3_514 q3_515 q3_516 q3_517 q3_518 q3_519 q3_520 ///
	q3_521 q3_522 q3_523 q3_524 q3_525)
	label variable q3_score_time "Score temps pour rejoindre infrastructures (min)"
	tab q3_score_time
	/*
	label variable q3_11  "Durée trajet: Maternelle"
	label variable q3_12  "Durée trajet: Primaire"
	label variable q3_13  "Durée trajet: Collège"
	label variable q3_14  "Durée trajet: lycée secondaire"
	label variable q3_15  "Durée trajet: Centre de formation professionnelle"
	label variable q3_16  "Durée trajet: Dispensaire"
	label variable q3_17  "Durée trajet: Centre de santé de base"
	label variable q3_18  "Durée trajet: Infirmeries"
	label variable q3_19  "Durée trajet: Clinique Privée"
	label variable q3_110  "Durée trajet: Docteur/Spécialiste privé"
	label variable q3_111  "Durée trajet: Sage-femme"
	label variable q3_112  "Durée trajet: Dentiste"
	label variable q3_113  "Durée trajet: Pharmacie"
	label variable q3_114  "Durée trajet: téléphone fixe"
	label variable q3_115  "Durée trajet: Couverture Réseau mobile"
	label variable q3_116  "Durée trajet: Connexion internet"
	label variable q3_117  "Durée trajet: Services postaux"
	label variable q3_118  "Durée trajet: Eclairage publics"
	label variable q3_119  "Durée trajet: Route goudronnées"
	label variable q3_120  "Durée trajet: Sources d’Eau potable publique"
	label variable q3_121  "Durée trajet: Institution de Microfinance BTS /INDA etc…)"
	label variable q3_122  "Durée trajet: Poste de Police"
	label variable q3_123  "Durée trajet: Marchés fixes ou hebdomadaires"
	label variable q3_124  "Durée trajet: Mosquée"
	label variable q3_125 "Durée trajet: Centre loisir et/ou de culture"
	*/
	*q4_score
	
	
	
	
	*changes last 5 years: FOCUS ON SERVICES 1 5 6 7 10 12 13 21 22 23 24 25 
	tab q4_1, m //6: NA
	sum q4_1 q4_5 q4_6 q4_7 q4_10 q4_12 q4_13 q4_21 q4_22 q4_23 q4_24 q4_25
	mvdecode q4_1 q4_5 q4_6 q4_7 q4_10 q4_12 q4_13 q4_21 q4_22 q4_23 q4_24 q4_25, mv(6)
	egen q4_score = rowtotal(q4_1 q4_5 q4_6 q4_7 q4_10 q4_12 q4_13 q4_21 q4_22 q4_23 q4_24 q4_25)
	label variable q4_score "Score conditions dans l'imada depuis 5 ans"
	tab q4_score*
	*/
	
	* negative to positive dummies
	foreach var of varlist 			q4_26 q4_27 q4_34 q4_28 q4_29 q4_30 q4_31 q4_35		{
		gen 	`var'_dum = 0
		replace	`var'_dum = 1	if 	`var' == 4	|	`var' == 5
	}
	
	label variable q4_26_dum	"Robbery change last 5 years"	
	label variable q4_27_dum	"Violence change 5 years"
	label variable q4_28_dum	"Community trust change 5 years"
	label variable q4_29_dum	"Help others change 5 years"
	label variable q4_30_dum	"Contributions comm proj change 5 years"
	label variable q4_31_dum	"Communal participation change 5 years"
	label variable q4_34_dum	"Violent protest change 5 years"
	label variable q4_35_dum	"Peaceful protest change 5 years"
	

	/*
	*Propensity to engage in crime and violence
	*q4_26 
	tab q4_26, m
	mvdecode q4_26, mv(6)
	
	*q4_27 
	tab q4_27, m
	mvdecode q4_27, mv(6)
	
	*q1_score
	tab q1_1, m //40% other only... (7)
	gen q1_1_1=regexm(q1_1,"1")
	gen q1_1_2=regexm(q1_1,"2")
	gen q1_1_3=regexm(q1_1,"3")
	gen q1_1_4=regexm(q1_1,"4")
	gen q1_1_5=regexm(q1_1,"5")
	gen q1_1_6=regexm(q1_1,"6")
	gen q1_1_7=regexm(q1_1,"7")
	egen q1_score=rowtotal(q1_1_1 q1_1_2 q1_1_3 q1_1_4 q1_1_5 q1_1_6 q1_1_7)
	label variable q1_score "Score problèmes dans l'imada depuis 6 mois"
	tab q1_score
	
	*identifiy the censored among the continuous
	hist q2_1
	hist q2_3
	hist q2_4 //could be
	hist q2_5 //could be
	hist q2_6
	hist q2_9_dum4
	hist q0_6_dum2 
	hist q3_score_quality 
	hist q3_score_time
	hist q4_score
	hist q4_26
	hist q4_27
	hist q1_score
*/
	
************************************************************************************
*******ADDITIONS FROM BALANCE RERUNS************************************************
************************************************************************************
	
*PREPARE OUTCOMES

	replace q0_5 = .a if q0_5 == -99
	
*MOVE TO PREPARE_CHEFS_OUTCOMES
	*count variable 3_1 to dummies? //proportion rather than % number for village activities q2_1? //
	
* replace string variable listing events for event dummies	
	
	foreach var of 	varlist q1_3 q1_4			{
		forvalues 	x = 1 3 to 15							{		
			gen 		`var'_num`x' = substr(`var',`x',1)
			destring	`var'_num`x', replace	
			tab 		`var'_num`x',m
		}
	}
		
	forvalues no = 1/9							{
		gen 			negevent_`no' = 0
		forvalues 		x = 1 3 to 15							{			
			replace		negevent_`no' = 1 if q1_3_num`x' == `no'
		}
	}

	forvalues no = 1/8							{
		gen 			posevent_`no' = 0
		forvalues 		x = 1 3 to 15							{			
			replace		posevent_`no' = 1 if q1_4_num`x' == `no'
		}
	}
		
*no of + and - events in total

	egen posevent = rowtotal(posevent_1 posevent_2 posevent_3 posevent_4 posevent_5 posevent_6 posevent_7 posevent_8)
	
	egen negevent = rowtotal(negevent_1 negevent_2 negevent_3 negevent_4 negevent_5 negevent_6 negevent_7 negevent_8 negevent_9)
	
	label variable negevent_1 	"Event negative: drought"
	label variable negevent_2 	"Event negative: flood" 	
	label variable negevent_3 	"Event negative: fast increase in commodity prices"
	label variable negevent_4 	"Event negative: large loss of work"
	label variable negevent_5 	"Event negative: crop parasites"
	label variable negevent_6 	"Event negative: livestock illness"
	label variable negevent_7 	"Event negative: human epidemic"
	label variable negevent_8 	"Event negative: electricity cut off"
	label variable negevent_9 	"Event negative: other bad events"
	
	label variable posevent_1 	"Event positive: development project"
	label variable posevent_2 	"Event positive: electrification of the IMADA"
	label variable posevent_3 	"Event positive: new school"
	label variable posevent_4 	"Event positive: new road"
	label variable posevent_5 	"Event positive: new health centre"
	label variable posevent_6 	"Event positive: new employment opportunities"
	label variable posevent_7 	"Event positive: improved transport services"
	label variable posevent_8 	"Event positive: other good events"
	
	label variable negevent	  	"Event negative: number 5 years"
	label variable posevent		"Event positive: number 5 years"	
	
* dummy for infrastructure quality
	
	forval x = 1/25					{
	recode q3_1`x' (1=0) (2=0) (3=0) (4=1) (5=1), gen(dq3_1`x')	
	label variable dq3_1`x' "Infrastructure quality dummy for type `x'"
	}
	
************************************************************************************
************************************************************************************
	
	save "$stata/tunisia_chefs_benef2", replace
