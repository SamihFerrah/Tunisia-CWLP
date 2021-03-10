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
	
		
		foreach var in g1_hhimportant d3_friendssecrets{
		
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
	
	
	
	********************************************************
	* MISC CORRECTIONS
	********************************************************
 
	forvalue i = 1/2{
		
		replace b3_foodorigin`i' = .a if b3_foodorigin`i' == 0
	
	}
 
	* Replace others to .o
	
	foreach var in g1_managementlead{
	
		replace `var' = .o if `var' == 6
	
	}
	
	foreach var in c4_migration_q6 c4_travelannoy{
	
		replace `var' = .o if `var' == 5
	
	}
	
	foreach var in g3_safetyproblems{
	
		cap replace `var' =.o if `var' == 7
		cap replace `var' = 0 if `var' == 9 
		
	}
 
