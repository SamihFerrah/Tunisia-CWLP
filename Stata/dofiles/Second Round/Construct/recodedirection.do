********************************************************************************
********************************************************************************
* 				PREPARE OUTCOMES 
********************************************************************************
********************************************************************************


 *********************************************************************
 * Recoding variable so that a higher value indicate a better outcome
 *********************************************************************
 
 * Define list of outcomes to recode 
 
 local varlist "e2_buildingqal g1_hhtrouble g1_hhimportant g1_hhtrust g1_villagtrust g1_respectelders g1_newcomersconditions g1_vulnerablservice hh_social_2 j_respondentdisposal j_respondentfocus g1_hhtrouble"

 * Loop over each variable and recode
 foreach var of local varlist{
     
	* Recode variables 
	 recode `var'(1=3) (3=1), gen(`var'2)
	 
	 * Drop old variable 
	 drop `var'
	 
	 * Rename newly created variable as old var (avoid change between form and dataset)
	 rename `var'2 `var'
	 
}

 **********************************************************************
 * RECODE VARIABLE IN THE SAME SENSE 
 **********************************************************************

	* Agreeness scale
	local agreensess x1_agreerole x1_mgrights2 x1_mgequality x1_mgfriends x1_mgfreetime_men ///
					 x1_mg_freetime_women x1_mg_womenopi x1_mg_marry x1_participation 		///
					 x1_leader4 x1_leader5 x1_leader9 x1_leader10 x1_participation2 		///
					 x1_participation3 x6_sxmore x6_sxtalk x6_sxready x6_gay x6_friend 		///
					 x7_tough x7_insult x8_pregn x8_contra x8_suggcontr x8_childresp 		///
					 x8_fatherchild x8_childdeci x8_contratype

	label define agree 	1 "Totally disagree" 	///
						2 "Disagree"			///
						3 "Agree"				///
						4 "Totally agree"
						
	foreach var in `agreeness'{
	
		g `var'2 = `var'
		
		replace `var'2 = 4 if `var' == 1
		replace `var'2 = 3 if `var' == 2
		replace `var'2 = 2 if `var' == 3
		replace `var'2 = 1 if `var' == 4
		
		label val `var' agree
	
	}
	
	* Add english label to var using caracteristic type
	
	local caracteristic d2_thinkwrong d2_resisttempta d2_postponing d2_tooquickly 		///
						d2_waiting d2_thinkingmuch d2_regretchoices d2_takeprecaution 	///
						d2_workinginteam d2_opencomunication d2_defendopinions 			///
						d2_managingtime d2_reachdecisions

	foreach var in `caracteristic'{
	
		label val `var' agree
		
	}
	
	* Comparison 
	/* note that type: econcomp and change do not use the same scale:
		- econcomp vary from 1 to 5 (include way worst and way better)
		- chaneg vary from 1 to 4 (doesn't include way worst and way better)
	
	*/
	
	******************
	* Time frequency 
	******************
	
		/* ALREADY DONE ABOVE BY VARADA'S LOOP 
		
		local feeling_troubl "g1_hhfeeling g1_hhtrouble g1_respectelders"
		
		foreach var in `feeling_troubl'{
		
			g `var'2 = `var'
			
			replace `var'2 = 1 if `var' == 3
			replace `var'2 = 2 if `var' == 2
			replace `var'2 = 3 if `var' == 1
			
		}
		
	*/
	
		local var likert "d1_happyperson d1_calmpeaceful d1_nervousperson d1_heartblue d1_cheerup"
		
		foreach var in `likert'{
		
			g `var'2 = `var'
			
			replace `var'2 = 1 if `var' == 6
			replace `var'2 = 2 if `var' == 5
			replace `var'2 = 3 if `var' == 4
			replace `var'2 = 4 if `var' == 3
			replace `var'2 = 5 if `var' == 2
			replace `var'2 = 6 if `var' == 1
		
		}
	
		
		foreach var in g1_hhimportant{
		
			g `var'2 = `var'
			
			replace `var'2 = 1 if `var' == 3
			replace `var'2 = 2 if `var' == 2
			replace `var'2 = 3 if `var' == 1
		
		}
	
		local plusone "g3_viewsconsideration g3_politicsdiscuss g3_habitsinterestsdiscuss g3_habitsinterestsview"
		
		foreach var in `plusone'{
			
			replace `var' = `var'  + 1				// So that never = 0 like other time frequency variables
		}
	
	* Don't know 
	
	
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 /*
 forvalues i=1/3 {
	replace postld_worry_money=4-`i' if inlist(fu_e2_`i'_worry_postld_rank`i',5,7,13)
	replace postld_worry_nojob=4-`i' if inlist(fu_e2_`i'_worry_postld_rank`i',1)
	replace postld_worry_prefjob=4-`i' if inlist(fu_e2_`i'_worry_postld_rank`i',2,3,4)
	replace postld_worry_biz=4-`i' if inlist(fu_e2_`i'_worry_postld_rank`i',6,9,10)
	replace postld_worry_travel=4-`i' if inlist(fu_e2_`i'_worry_postld_rank`i',8)
	} 
	/* 4-i since we want to record the intensity of worry students have about a particular
	aspect of livelihoods. Survey Qnnaire asks students to rank worries: therefore most worried=1,
	second-most worried=2, third most-worried=3. 
	But in order to calculate intensity of worry, we need to invert these rankings. 
	Most worried=3, second most worried=2, third-most worried=1, others=0. */
	
	

 
 * Recoding individually for select_one (feeling, importance, truste, troubl, dispo, fous, integration)
 
 recode g1_hhtrouble(1 = 3) (3 = 1), gen(g1_hhtrouble2)
 recode g1_hhimportant(1 = 3) (3 = 1), gen(g1_hhimportant2)
 recode g1_hhtrust(1 = 3) (3 = 1), gen(g1_hhtrust2)
 recode g1_villagtrust(1 = 3) (3 = 1), gen(g1_villagtrust2)
 recode g1_respectelders(1 = 3) (3 = 1), gen(g1_respectelders2)
 recode g1_vulnerablservice(1 = 3) (3 = 1), gen(g1_vulnerablservice)
 recode g1_newcomersconditions(1 = 3) (3 = 1), gen(g1_newcomersconditions)
 recode hh_social_2(1 = 3) (3 = 1), gen(hh_social_2)
 recode j_respondentdisposal(1 = 3) (3 = 1), gen(j_respondentdisposal2)
 recode j_respondentfocus(1 = 3) (3 = 1), gen(j_respondentfocus2)
 

 	
 * Coding for select_one center
 
 *recode e2_healthcent (0 = 1) (1 = 2) (2 = 3), gen(e2_healthcent2) 
 
 
 *recode e2_equipmentqal (1 = 3) (3 = 1), gen(e2_equipmentqal) 
 *recode e2_careqal (1 = 3) (3 = 1), gen(e2_careqal) 
 *recode e2_staffqal (1 = 3) (3 = 1), gen(e2_staffqal) 
 *recode e2_staffqal (1 = 3) (3 = 1), gen(e2_staffqal) 
 *recode e2_nursingtiming (1 = 3) (3 = 1), gen(e2_nursingtiming)
 *recode e2_communityinteraction (1 = 3) (3 = 1), gen(e2_communityinteraction)
 *recode e2_costslevel (1 = 3) (3 = 1), gen(e2_costslevel)
 *recode e2_costslevel (1 = 3) (3 = 1), gen(e2_costslevel)
 *recode e2_healhinformation (1 = 3) (3 = 1), gen(e2_healhinformation)
 *recode e3_educationcent(1 = 3) (3 = 1), gen(e3_educationcent)
 *recode e3_educbuildingqal(1 = 3) (3 = 1), gen(e3_educbuildingqal) */
 
 
 
 