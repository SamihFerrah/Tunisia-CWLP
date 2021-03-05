
 capture log close
 clear
 log using codedirection.log,  replace

 use "D:\Dropbox\WB-Tunisia-CWLP-IE\14. Female Entrepreneurship Add on\Data\Second round\cleandata\clean_CashXFollow_noPII.dta"  

 * Recoding 
 
 local varlist "e2_buildingqal g1_hhtrouble g1_hhimportant g1_hhtrust g1_villagtrust g1_respectelders g1_newcomersconditions g1_vulnerablservice hh_social_2 j_respondentdisposal j_respondentfocus"

 set trace on
 foreach var of local varlist{
     recode `var'(1=3) (3=1), gen(`var'2)
}
set trace off



 * Dropping the old vars
 
 local varlist2 "e2_buildingqal g1_hhtrouble g1_hhimportant g1_hhtrust g1_villagtrust g1_respectelders g1_newcomersconditions g1_vulnerablservice hh_social_2 j_respondentdisposal j_respondentfocus"
 
 set trace on
 foreach var of local varlist2{
     drop `var'
     rename `var'2 `var'
}
 set trace off
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
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
 
 
 
 