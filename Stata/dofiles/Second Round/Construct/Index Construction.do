********************************************************************************
*				REPLICATION INDEX TUNISIA CWLP 								   *
********************************************************************************
********************************************************************************

********************************************************************************
********************************************************************************
* 0) DEFINE LOCAL USED TO BUILD INDEX 
********************************************************************************
********************************************************************************

** Indices 
* --------------
	
* Asset index	(first principal component of the assets list, following Filmer and Pritchett 2001) 
pca b2_assetnum_room  b2_assetnum_mattresses b2_assetnum_radio b2_assetnum_cellphone b2_assetnum_smartphone b2_assetnum_refrigerator b2_assetnum_bicycles b2_assetnum_moto b2_assetnum_chaise b2_assetnum_tablette b2_assetnum_vent b2_assetnum_clim b2_assetnum_gr b2_assetnum_nat b2_assetnum_poch b2_assetnum_table b2_assetnum_salon b2_assetnum_bibli b2_assetnum_arm b2_assetnum_ferer b2_assetnum_mach b2_assetnum_dec 	
predict assets_total
pca b2_assetnum19_room  b2_assetnum19_mattresses b2_assetnum19_radio b2_assetnum19_cellphone b2_assetnum19_smartphone b2_assetnum19_refrigerator b2_assetnum19_bicycles b2_assetnum19_moto b2_assetnum19_chaise b2_assetnum19_tablette b2_assetnum19_vent b2_assetnum19_clim b2_assetnum19_gr b2_assetnum19_nat b2_assetnum19_poch b2_assetnum19_table b2_assetnum19_salon b2_assetnum19_bibli b2_assetnum19_arm b2_assetnum19_ferer b2_assetnum19_mach b2_assetnum19_dec 		
predict assets19_total
pca d_b2_assetnum_room  d_b2_assetnum_mattresses d_b2_assetnum_radio d_b2_assetnum_cellphone d_b2_assetnum_smartphone d_b2_assetnum_refrigerator d_b2_assetnum_bicycles d_b2_assetnum_moto d_b2_assetnum_chaise d_b2_assetnum_tablette d_b2_assetnum_vent d_b2_assetnum_clim d_b2_assetnum_gr d_b2_assetnum_nat d_b2_assetnum_poch d_b2_assetnum_table d_b2_assetnum_salon d_b2_assetnum_bibli d_b2_assetnum_arm d_b2_assetnum_ferer d_b2_assetnum_mach d_b2_assetnum_dec 	
predict assets_d
pca d_b2_assetnum19_room  d_b2_assetnum19_mattresses d_b2_assetnum19_radio d_b2_assetnum19_cellphone d_b2_assetnum19_smartphone d_b2_assetnum19_refrigerator d_b2_assetnum19_bicycles d_b2_assetnum19_moto d_b2_assetnum19_chaise d_b2_assetnum19_tablette d_b2_assetnum19_vent d_b2_assetnum19_clim d_b2_assetnum19_gr d_b2_assetnum19_nat d_b2_assetnum19_poch d_b2_assetnum19_table d_b2_assetnum19_salon d_b2_assetnum19_bibli d_b2_assetnum19_arm d_b2_assetnum19_ferer d_b2_assetnum19_mach d_b2_assetnum19_dec 		
predict assets19_d

	
* Anxiety index
gen anxiety_index = (d3_shortnessbreath + d3_fearlosingcontrol + d3_worryest + d3_feelingsfear + d3_frighten + d3_feeldeceiving + ///
					d3_solitaryactivities + d3_uncomfortabl + d3_unwilling) / 9

* Depression index
gen depression_index = 	(d3_lifethreatening + d3_distressing + d3_avoidthinking + d3_remembering + d3_lostinterest + d3_feeldetached ///
						+ d3_oftenirritable + d3_makedecisions + d3_sleepeatinghabit + d3_depressed + d3_wrongmatter ///
						+ d3_alcoholdrugs + d3_feltangry + d3_troubllistening + d3_wrongblame + d3_recognition ///
						+ d3_believethink + d3_frustrated + d3_enoughsleep + d3_lotofthings + d3_nightmares ///
						+ d3_solveproblems + d3_dependsmainly + d3_feel_helpless + d3_influence_many + d3_taking_control ///
						+ d3_exploitedcheated + d3_have_control + d3_trust_worthy + d3_achieveanything + d3_beingaccepted) / 31

* Z-scores index

	foreach var in anxiety_index depression_index assets_total assets19_total assets_d assets19_d {
	sum `var' 					if trt_cash==0 & attrition == 0 
	gen cmean_`var'				= r(mean)	if attrition == 0 
	gen csd_`var'				= r(sd)	if attrition == 0 
	gen z_`var'					= (`var' - cmean_`var')/csd_`var' if  attrition == 0 
	}

	sum z_* if trt_cash==0 & attrition == 0 
	
	


/*
* Define sub index local

local run_business 							c1_job_covid // c1_descprimjob c1_descsecjob

local busn_profit 							business_profit_2 business_profit

local busn_empl								business_newemployee business_employee business_employee_2

local fin_access							grant grant_oth grant_oth_who c2_borrow_all c2_borrow12 c2_borrow12n c2_borrowwho c2_borrowwho_other 			  								c2_borrowrate c2_borrowperiode c2_borrow12on c2_repaiddebt c2_depositac c2_depositacn c2_loan c2_loan_amount

local emp_tol								c1_job_iga c1_days_nowork c1_daysnoworkunit c1_corebusiness c1_timeprimjob c1_jprimjoblicense 	 										c1_hoursprimjob c1_daysprimjob c1_wageprimjob c1_job_covid 
// c1_descprimjob c1_descsecjob

local inc_from_emp_total					c1_headincome30 c1_wageprimjob business_profit c1_wagesecjob business_profit_2

local women_agency							x9_1 x9_2 x9_3 x9_4 x9_5 x9_6 x9_7 x9_largepurchase x9_dailypurchase x9_wifepersonal x9_borrow x9_lend 	 	      								  x9_occupation x9_workplace x9_workhours x9_participation x9_10.1

local gender_presp							x1_mghome x1_mgkids x1_mgdecisions x1_mgrights1 x1_mgleader1 x1_mgleader2 x1_mgschlwork x1_mgill x1_mgopinion    										 x1_mgpity x1_mgwork x1_mgedu x1_mgdomestic x1_mgobey x1_mgspeak x1_mgcapacity x1_eduopp x1_boysfood x1_coupledu 											x1_leader3 x1_mgrights2 x1_mgrights2 x1_mgfriends x1_mgfreetime_men x1_mg_freetime_women x1_mg_womenopi  	      								   x1_mg_marry x1_participation x1_leader4 x1_leader5 x1_participation x1_leader4 x1_leader5

local women_ability_presp					x1_leader6_1 x1_leader6_2 x1_leader6_3 x1_leader6_4 x1_leader6_5 x1_leader6_6 x1_leader6_7 x1_leader6_8    										   x1_leader6_9 x1_leader6_10 

local gbv_persp								x2_hwtolerate x2_goesout x2_refuseshave x2_neglectsIf x2_burnsf x2_arguesshe x2_refusescook x2_doesinfid         									x2_contraceptive x2_drinksalcohol x2_refusesclean x2_dowry

local reprod_health_persp					x8_pregn x8_contra x8_suggcontr x8_childresp x8_fatherchild x8_childdeci x8_contratype d_x8_reprodhe_end

local spouse_commu							x9_10.1 x9_10.2 x9_10.3 x9_10.4 x9_10.5 x9_10.6 x9_10.7 x9_10.8 x9_10.9

local hhead_iga								c1_job_iga c1_descprimjob c1_corebusiness c1_timeprimjob c1_jprimjoblicense c1_hoursprimjob c1_daysprimjob       									  c1_descsecjob

local hhead_income							c1_headincome30 c1_wageprimjob business_profit c1_wagesecjob business_profit_2

local hhmembers_iga							c1_headjobc 1_headjobiga  c1_othermemberswork c1_othermembersworkn c1_othermemworkind c1_othermeother            								 c1_addotherincome c1_hengag c1_hengag_agr 

local other_income							c1_incomeotheriga c1_addotherincomen 

local food_exp 								b3_fooddrink houla_* ?? b3_foodorigin1 b3_foodorigin_other1 b3_foodorigin2 b3_foodorigin_other2 										   b3_mealsnumberyest b3_mealsnumber7 b3_foodtype b3_a b3_b

local non_food_exp							b3_fooddrink_num b3_medical b3_medical_num b3_leisure b3_leisure_num b3_clothes b3_clothes_num            								  b3_publictransport b3_publictransport_num b3_elec_gas_water b3_elec_gas_water_num b3_landline_phone 											 b3_landline_phone_num b3_soap b3_soap_num b3_otherservice b3_service_other b3_otherservice_num b3_medicalexp 											 b3_medicalexpnum b3_chool_exp b3_chool_expnum 

local econ_diff								b4_programfood b4_programfood_hm b4_programfood_am b4_programsorder b4_programsorder_hm b4_programsorder_am 										   b4_programschool b4_programschool_hm b4_programschool_am b4_programtransf b4_programtransf_hm 											b4_programtransf_am b4_programother b4_programother_other b4_programother_other_hm b4_programother_other_am 										   b4_scaleownhh b4_scaleownhh12

local assets								b2_assetnum_sheep b2_assetnum19_sheep b2_assetnum_duck b2_assetnum19_duck b2_numasset_cows b2_assetnum19_cows 											 b2_assetnum_mule b2_assetnum19_mule b2_assetnum_room b2_assetnum19_room b2_assetnum19_room   										  	b2_assetnum_mattresses b2_assetnum19_mattresses b2_assetnum_radio b2_assetnum19_radio b2_assetnum_cellphone											 	b2_assetnum19_cellphone b2_assetnum_smartphone b2_assetnum19_smartphone b2_assetnum_refrigerator											 b2_assetnum19_refrigerator b2_assetnum_bicycles b2_assetnum19_bicycles b2_assetnum_moto b2_assetnum19_moto											   b2_assetnum_chaise b2_assetnum19_chaise b2_assetnum_tablette b2_assetnum19_tablette b2_assetnum_vent											   b2_assetnum_clim b2_assetnum19_clim b2_assetnum_gr b2_assetnum19_gr b2_assetnum_nat b2_assetnum19_nat 											b2_assetnum_poc b2_assetnum19_poch b2_assetnum_table b2_assetnum19_table b2_assetnum_salon b2_assetnum19_salon											  b2_assetnum_bibli b2_assetnum19_bibli b2_assetnum_arm b2_assetnum19_arm b2_assetnum_ferer b2_assetnum19_ferer							 				   b2_assetnum_mach b2_assetnum19_mach b2_assetnum_dec b2_assetnum19_dec b2_hhhouse b2_newhouse b2_addrooms 										   b2_minorrepairs b2_Otherinvest b3_rent_num
											
local migration								c4_hhmig c4_hhmignum c4_hhmigreason c4_migration_q2 c4_migration_q4 c4_migration_q5 c4_migration_q6 c4_hhcomin 											  c4_hhmembernew c4_hhmbernewreas c4_hhmbernewreasother c4_respondtravel c4_traveldays c4_travelreason											  c4_travelreasonother c4_travegain c4_travegainsent c4_travegainsave c4_travelannoy c4_parentfrids  										   c4_parentfridsspeak c4_parentfridsubj c4_parentfridguid c4_respfututra c4_respfututrareason											  c4_respfututrareasonother c4_hhfututra c4_hhfututrareason c4_hhfututrareasonother

local cantrill_ladder						d1_ladder_present d1_ladder_1ago d1_ladder3years d1_ladderwealth_intro d1_ladderwealth d_d1_ladderhappy_start

local psyc_well_being						d1_happyperson d1_calmpeaceful d1_nervousperson d1_heartedblue  d1_cheerup d_d1_ladderhappy_end d2_thinkwrong 											 d2_resisttempta d2_postponing d2_tooquickly d2_waiting d2_thinkingmuch d2_regretchoices d2_takeprecaution 											  d2_workinginteam d2_opencomunication d2_defendopinions d2_managingtime d2_reachdecisions d2_illnesslifelong 											 d2_easyhardtask d_d2_patienceindex_end d3_shortnessbreath d3_fearlosingcontrol d3_worryest d3_feelingsfear  										   d3_frighten d3_feeldeceiving d3_solitaryactivities d3_uncomfortabl d3_unwilling d_d3_selfesteemfeeling_end 											 d3_lifethreatening d3_distressing d3_avoidthinking d3_remembering d3_lostinterest d3_feeldetached 											  d3_oftenirritable d3_makedecisions d3_sleepeatinghabit d3_depressed d3_wrongmatter d3_alcoholdrugsm d3_feltangry 											  d3_troubllistening d3_wrongblame d3_recognition d3_believethink d3_frustrated d3_enoughsleep d3_lotofthings 											 d3_nightmares d3_solveproblems d3_dependsmainly d3_feel_helpless d3_influence_many d3_taking_control 											 d3_exploitedcheated d3_have_control d3_trust_worthy d3_achieveanything d3_beingaccepted											d_d3_depresfrustration_end

local wage_emp								c3_traintrade12 c3_trainkind c3_typejob c3_earnjobmonth c3_haveskills c3_skills 										   c3_dreamjob c3_dreamjobdif c3_obssmallbus c3_obssmallbusdif 											 

local job_search							c1_activsearchwork c1_activsearchwork_6m c1_activsearchwork_12m c1_activsearchworkn c1_activsearchworkn_6m 											  c1_activsearchworkn_12m

local social_life							g1_hhfeeling g1_hhtrouble g1_hhimportant g1_hhtrust g1_villagtrust g1_respectelders g1_vulnerablservice 										   g1_newcomersconditions g1_managementlead g1_mangmtleadotherm g1_projecttradeoff g1_fundsdonat 											g1_fundsdonatamount g1_volunteeract g1_volunteeracttime d_g1_comandcivicg1_end

local comm_life								J16 J17 g1_farmersgroup g1_hhinfarmersgroup g1_farmersgroupship g1_womengroup g1_hhinwomengroup 										   g1_womengroupship g1_humancomnitygroup g1_hhinhumancomnitygroup g1_Humancomnitygroupship g1_religiousgroup 											 g1_hhinreligiousgroup g1_religiousgroupship g1_politicalass g1_hhinpoliticalasc g1_politicalascship 											g1_savingscreditgroup g1_hhinsavingscreditgroup d_g1_groupasctypes_end g1_voluntarilyprojectin g1_healthprjt 											g1_inithealthprjt g1_hhhealthprjt g1_resphealthprjt g1_roadprjt g1_initroadprjt g1_hhroadprjt g1_resproadprjt 											 g1_waterprojet g1_initwaterprojet g1_hhwaterprojet g1_respwaterprojet g1_securityprjt g1_initsecurityprjt 											  g1_hhsecurityprjt g1_respsecurityprjt g1_religiousprjt g1_initreligiousprjt g1_hhreligiousprjt 											g1_respreligiousprjt g1_marketprjt g1_initmarketprjt g1_hhmarketprjt g1_respmarketprjt 											  d_g1_voluntarilyprojects_end g3_attendmeetings g3_givepointofview g3_raiseissuetomayor											g3_raiseissuetomanagementc g3_contactpolice g3_contactstate g3_contactgovernment g3_contactngo									 		  g3_contacteduhealth g3_contactpeople g3_peacefulparticipation g3_contactmedia g3_contactinfluential											 g3_meetreligious g3_volunterworks g3_moneydonation g3_meetfriends g3_healthprjt g3_resproadprjt											g3_respwaterprojet g3_respsecurityprjt g3_respreligiousprjt g3_respmarketprjt d_g3_citizensoftenengagement_end											  g3_safetyproblems g3_conflictdisputes g3_healthconcerns g3_educationconcerns 											  g3_developmentconcerns 

local tax_contr								i2_taxesintro i2_taxesintro_sup i2_taxesintro_sup_num i3_collectiveactionintro i3_personcontribut 											 i3_vilgectribut i3_vilgengthctribut

local anti_pro_soc_beh						d3_problemworries d3_usuallyshare d3_integralpart d3_friendssecrets d3_spendmosttime d3_spendalone 											  d3_informindvdualss d3_informindvdua d3_informindvdua1 d3_informindvduals 

local victimization							h3_landvictim h3_physivictim h3_stolenvictim h3_robbevictim h3_futurvictim h3_hearphysivictim h3_heardomviol

local comm_confl_disp						h4_land h4_crops h4_inheritance h4_youngelder h4_religious h4_ethnic h4_political h4_otherconflict h4_landhh 											h4_cropshh h4_inheritancehh h4_youngelderhh h4_religioushh h4_ethnichh h4_politicalhh h4_otherconflicthh 											h4_landled h4_cropsled h4_inheritanceled h4_youngelderled h4_religiousled h4_ethnicled h4_politicalled 											  h4_otherconflictled


* Define local with all index

local Index_ALL 		run_business busn_profit busn_empl fin_access emp_tol inc_from_emp_total 	///
						women_agency women_ability_presp gbv_persp reprod_health_persp spouse_commu ///
						hhead_iga hhead_income hhmembers_iga other_income food_exp non_food_exp		///
						assets migration cantrill_ladder psyc_well_being wage_emp job_search 		///
						social_life comm_life tax_contr anti_pro_soc_beh victimization comm_confl_disp
							
********************************************************************************
********************************************************************************
* 1) Prepare data (flip sign and stuff)
********************************************************************************
********************************************************************************
u "$vera/temp/clean_CashXFollow_PII_imputed.dta", clear

foreach sample in cash_0 cash_1{												// Loop over different dataset 


	if "`sample'" == "cash_0"{
		local trt_indicator "trt_cash_0"
		local cond			`"Intervention == "Cash Grants - Women""'			// Empty for now but might be useful later for the heterogeneity
		local spec_prefix	"CGW0"
	}
	if "`sample'" == "cash_1"{
		local trt_indicator "trt_cash_1"
		local cond			`"Intervention == "Cash Grants - Women""'			// Empty for now but might be useful later for the heterogeneity
		local spec_prefix	"CGW1"
	}


********************************************************************************
********************************************************************************
* 1) STANDARDIZE EVERY INDIVIDUAL OUTCOMES AGAINST RELEVANT CONTROL GROUP
********************************************************************************
********************************************************************************
	
	**********************************
	**********************************
	
	* Loop over every outcomes group
	
	foreach group_outcomes of local Index_ALL{
				
		* Create local used to store variable name to sum later 
		di in red "`group_outcomes'"
		
		local sum_`group_outcomes' 		 ""
		local var_num_`group_outcomes' = 0
		
		* Loop over every individual outcomes
		
		foreach indiv_outcomes of local `group_outcomes'{
		
			* Create control mean of individual outcomes
			
			sum `indiv_outcomes'							 	if `trt_indicator' == 0 & `cond'
			
			
			gen `spec_prefix'mean_`indiv_outcomes' = `r(mean)'	if `cond' 
			
			* Create control standard deviaiton 
			
			sum `indiv_outcomes'		 						if `trt_indicator' == 0 & `cond' 
			
			gen `spec_prefix'sd_`indiv_outcomes' = `r(sd)' 		if `cond' 
		
			* Normalize individual outcome 
			
			gen `spec_prefix'norm_`indiv_outcomes' = (`indiv_outcomes' - `spec_prefix'mean_`indiv_outcomes') / `spec_prefix'sd_`indiv_outcomes'
			
			* Fill local with variable name used later to sum all standardize outcomes
			
			local sum_`group_outcomes' "`sum_`group_outcomes'' `spec_prefix'norm_`indiv_outcomes'"
			
			* Fill local with variable counter 
			
			local var_num_`group_outcomes' = `var_num_`group_outcomes'' + 1
	
		}
		
		* Sum all standardize variable of relevant outcome group
		
		egen `spec_prefix'`group_outcomes' = rowtotal(`sum_`group_outcomes'') if `cond', missing 
		
		* Divide by the number of variable in outcomes group_outcomes
		
		replace `spec_prefix'`group_outcomes' = (`spec_prefix'`group_outcomes'/`var_num_`group_outcomes'') if `cond'
		* Standardize index 
		
		sum `spec_prefix'`group_outcomes'
		
		replace `spec_prefix'`group_outcomes' = `spec_prefix'`group_outcomes' / `r(sd)'  if `cond' 
		
		* Clean variables created
		
		drop *mean_*
		drop *sd_*
		drop *norm_*
	
	}
	
	* Label index 
						
	cap label variable `spec_prefix'run_business			"Run Business"
	cap label variable `spec_prefix'busn_profit				"Profits"
	cap label variable `spec_prefix'busn_empl				"Business employment"
	cap label variable `spec_prefix'fin_access				"Financial access"
	cap label variable `spec_prefix'emp_tol					"Total employment"
	cap label variable `spec_prefix'inc_from_emp_total		"Total Wage employment"
	cap label variable `spec_prefix'women_agency			"Women agency"
	cap label variable `spec_prefix'women_ability_presp		"View on women ability"
	cap label variable `spec_prefix'gbv_persp				"View on gender based violence"
	cap label variable `spec_prefix'reprod_health_persp		"View on reproductive health"
	cap label variable `spec_prefix'spouse_commu			"Communication"
	cap label variable `spec_prefix'hhead_iga 				"HH head IGA"
	cap label variable `spec_prefix'hhead_income			"HH head income"
	cap label variable `spec_prefix'hhmembers_iga			"HH member IGA"
	cap label variable `spec_prefix'other_income			"Other Income"
	cap label variable `spec_prefix'food_exp				"Food expenditure"
	cap label variable `spec_prefix'non_food_exp			"Non food expenditure"
	cap label variable `spec_prefix'assets					"Assets owning"
	cap label variable `spec_prefix'migration 				"Migration"
	cap label variable `spec_prefix'cantrill_ladder 		"Cantrill lader"
	cap label variable `spec_prefix'civic_engag 			"Civic Engagement"
	cap label variable `spec_prefix'psyc_well_being 		"Well Being"
	cap label variable `spec_prefix'wage_emp 				"Wage employment"
	cap label variable `spec_prefix'job_search				"Job search"
	cap label variable `spec_prefix'social_life 			"Social life"
	cap label variable `spec_prefix'comm_life 				"Community life"
	cap label variable `spec_prefix'anti_pro_soc_beh 		"Anti - Pro Social Behavior"	
	cap label variable `spec_prefix'victimization 			"Victimization"	
	cap label variable `spec_prefix'comm_confl_disp 		"Conflict"	

}

********************************************************************************
********************************************************************************
* SAVE DATA
********************************************************************************
********************************************************************************

save "$vera/clean/clean_analysis_CashXFollow.dta", replace

********************************************************************************
********************************************************************************
* DE-IDENTIFY DATA 
********************************************************************************
********************************************************************************

* 1) Define variable to be drop (Add variable below to be dropped)

local deidentification 	"username calc_name complete_name a1_respondentname confirm_name a1_respondentname_corr Nom Father devicephonenum Telephone1 Telephone2"


* 2) Drop ID variable 

foreach var of local deidentification {
	
	capture noisily drop `var' 													

}

sa "$home/14. Female Entrepreneurship Add on/Data/Second Round/cleandata/clean_CashXFollow_noPII.dta", replace


