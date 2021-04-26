********************************************************************************
********************************************************************************
*						IMPUT MISSING VARIABLE TUNISIA
********************************************************************************
********************************************************************************

********************************************************************************
********************************************************************************
* 0) Define global variables
********************************************************************************
********************************************************************************

global all 		c1_job_iga c1_job_iga_1 c1_job_iga_2 c1_job_iga_3 c1_job_covid business_profit 				///
				business_employee c3_haveskills c1_wageprimjob total_employement c2_borrow_all c2_borrow12 	///
				c2_borrow12n c2_repaiddebt c2_eliipsav c2_eliipsavn c2_depositac c2_depositacn c2_loan		///
				x9_1 x9_2 x9_3 x9_4 x9_5 x9_6 x9_7 x9_largepurchase x9_dailypurchase x9_wifepersonal 		///
				x9_borrow x9_lend x9_occupation x9_workplace x9_workhours x9_participation ///
				c1_headjob c1_headjobiga_1 c1_headjobiga_2 c1_headjobiga_3 c1_headjobiga_4 c1_headincome30 ///
				c1_othermemberswork c1_othermembersworkn c1_incomeotheriga ///
				c1_hengag c1_hengag_agr c1_rentlabor c1_rentlabor_num c1_fertilizer c1_pesticides ///
				productiona c1_cropprodna c1_cropvalna c1_cropconsna c1_cropdonna c1_cropsoldna c1_cropstoredna ///
				b3_a_1 b3_a_2 b3_a_3 b3_a_4 b3_a_5 b3_a_6 b3_a_7 b3_a_8 b3_a_9 b3_a_10 b3_a_11 ///
				b3_fooddrink_num b3_medical_num b3_leisure_num b3_clothes_num b3_publictransport_num ///
				b3_elec_gas_water_num b3_landline_phone_num b3_soap_num b3_otherservice_num ///
				b3_medicalexpnum b3_chool_expnum conso_tot conso_tot_w conso_tot_pc conso_tot_pc_w ///
				conso_food conso_food_pc conso_food_w conso_nofood conso_nofood_pc conso_nofood_w conso_food_pc_w conso_nofood_pc_w ///
				b2_assetnum_sheep b2_assetnum19_sheep b2_assetnum_duck b2_assetnum19_duck b2_numasset_cows ///
				b2_assetnum19_cows b2_assetnum_mule b2_assetnum19_mule b2_assetnum_room b2_assetnum19_room ///
				b2_assetnum19_vent  b2_assetnum_mattresses b2_assetnum19_mattresses b2_assetnum_radio ///
				b2_assetnum19_radio b2_assetnum_cellphone b2_assetnum19_cellphone b2_assetnum_smartphone ///
				b2_assetnum19_smartphone b2_assetnum_refrigerator b2_assetnum19_refrigerator b2_assetnum_bicycles ///
				b2_assetnum19_bicycles b2_assetnum_moto b2_assetnum19_moto b2_assetnum_chaise b2_assetnum19_chaise ///
				b2_assetnum_tablette b2_assetnum19_tablette b2_assetnum_vent b2_assetnum_clim b2_assetnum19_clim ///
				b2_assetnum_gr b2_assetnum19_gr b2_assetnum_nat b2_assetnum19_nat b2_assetnum_poch b2_assetnum19_poch ///
				b2_assetnum_table b2_assetnum19_table b2_assetnum_salon b2_assetnum19_salon b2_assetnum_bibli ///
				b2_assetnum19_bibli b2_assetnum_arm b2_assetnum19_arm b2_assetnum_ferer b2_assetnum19_ferer ///
				b2_assetnum_mach b2_assetnum19_mach b2_assetnum_dec b2_assetnum19_dec  ///
				d_b2_assetnum_sheep d_b2_assetnum19_sheep d_b2_assetnum_duck d_b2_assetnum19_duck d_b2_numasset_cows  d_b2_assetnum19_cows ///
				d_b2_assetnum_mule d_b2_assetnum19_mule d_b2_assetnum_room d_b2_assetnum19_room d_b2_assetnum_mattresses ///
				d_b2_assetnum19_mattresses d_b2_assetnum_radio d_b2_assetnum19_radio d_b2_assetnum_cellphone ///
				d_b2_assetnum19_cellphone d_b2_assetnum_smartphone d_b2_assetnum19_smartphone d_b2_assetnum_refrigerator ///
				d_b2_assetnum19_refrigerator d_b2_assetnum_bicycles d_b2_assetnum19_bicycles d_b2_assetnum_moto ///
				d_b2_assetnum19_moto d_b2_assetnum_chaise d_b2_assetnum19_chaise d_b2_assetnum_tablette d_b2_assetnum19_tablette ///
				d_b2_assetnum_vent d_b2_assetnum_clim d_b2_assetnum19_clim d_b2_assetnum_gr d_b2_assetnum19_gr d_b2_assetnum_nat ///
				d_b2_assetnum19_nat d_b2_assetnum_poch d_b2_assetnum19_poch d_b2_assetnum_table d_b2_assetnum19_table ///
				d_b2_assetnum_salon d_b2_assetnum19_salon d_b2_assetnum_bibli d_b2_assetnum19_bibli d_b2_assetnum_arm  ///
				d_b2_assetnum19_arm d_b2_assetnum_ferer d_b2_assetnum19_ferer d_b2_assetnum_mach d_b2_assetnum19_mach d_b2_assetnum_dec d_b2_assetnum19_dec ///
				b4_sufferevent_1 b4_sufferevent_2 b4_sufferevent_3 b4_sufferevent_4 b4_sufferevent_5 b4_sufferevent_6 b4_sufferevent_7 b4_sufferevent_8 b4_sufferevent_9 ///
				b4_sufferevent_99 b4_facesufferevent_1 b4_facesufferevent_2 b4_facesufferevent_3 b4_facesufferevent_4 b4_facesufferevent_5 b4_facesufferevent_6 ///
				b4_facesufferevent_7 b4_facesufferevent_8 b4_facesufferevent_9 b4_facesufferevent_10 b4_facesufferevent_11 b4_facesufferevent_12 b4_facesufferevent_13 ///
				b4_facesufferevent_14 b4_facesufferevent_15 b4_facesufferevent_0 b4_facesufferevent_99 ///
				c4_hhmig c4_hhmignum c4_hhmigreason_1 c4_hhmigreason_2 c4_hhmigreason_3 c4_hhmigreason_4 c4_hhmigreason_5 c4_hhmigreason_6 c4_hhmigreason_99 ///
				c4_respondtravel c4_traveldays c4_travelreason_1 c4_travelreason_2 c4_travelreason_3 c4_travelreason_4 c4_travelreason_5 c4_travelreason_6 c4_travelreason_99 ///
				c4_respfututra c4_respfututrareason_1 c4_respfututrareason_2 c4_respfututrareason_3 c4_respfututrareason_4 c4_respfututrareason_5 c4_respfututrareason_6 c4_respfututrareason_99 ///
				c4_hhfututra  c4_hhfututrareason_1 c4_hhfututrareason_2 c4_hhfututrareason_3 c4_hhfututrareason_4 c4_hhfututrareason_5 c4_hhfututrareason_6 c4_hhfututrareason_99  ///
				d1_ladder_present d1_ladder_1ago d1_ladder3years d1_ladderwealth ///
				d3_shortnessbreath d3_fearlosingcontrol  d3_worryest d3_feelingsfear d3_frighten ///
				d3_feeldeceiving d3_solitaryactivities d3_uncomfortabl d3_unwilling ///
				d3_lifethreatening d3_distressing d3_avoidthinking d3_remembering d3_lostinterest d3_feeldetached ///
				d3_oftenirritable d3_makedecisions d3_sleepeatinghabit d3_depressed d3_wrongmatter ///
				d3_alcoholdrugs d3_feltangry d3_troubllistening d3_wrongblame d3_recognition ///
				d3_believethink d3_frustrated d3_enoughsleep d3_lotofthings d3_nightmares ///
				d3_solveproblems d3_dependsmainly d3_feel_helpless d3_influence_many d3_taking_control ///
				d3_exploitedcheated d3_have_control d3_trust_worthy d3_achieveanything d3_beingaccepted
	
	
	
********************************************************************************
********************************************************************************
* 1) Imput missing
********************************************************************************
********************************************************************************

	foreach var in $all {
			replace `var'=0 if `var'==.
	}
	
save "$vera/temp/clean_CashXFollow_PII_imputed.dta", replace

	
/*
*********************
* Logical Imputation 
*********************


#delimit ;
						

local all_outcomes 						c1_job_iga c1_days_nowork c1_daysnoworkunit business_hours 
										business_profit business_newemployee business_employee 
										grant grant_oth grant_oth_who c2_borrow_all c2_borrow12 c2_borrow12n
										c2_borrowwho c2_borrowwho_other c2_borrowrate c2_borrowperiode c2_borrow12on
										c1_job_iga c1_days_nowork c1_daysnoworkunit c1_descprimjob c1_corebusiness
										c1_timeprimjob c1_jprimjoblicense c1_hoursprimjob c1_daysprimjob c1_wageprimjob
										c1_headincome30 c1_wageprimjob business_profit c1_wagesecjob business_profit_2
										x9_1 x9_2 x9_3 x9_4 x9_5 x9_6 x9_7
										x9_largepurchase x9_dailypurchase x9_wifepersonal x9_borrow x9_lend x9_occupation
										x9_workplace x9_workhours x9_participation 
										x1_mghome x1_mgkids x1_mgdecisions x1_mgrights1 x1_mgleader1 x1_mgleader2
										x1_mgschlwork x1_mgill x1_mgopinion x1_mgpity x1_mgwork x1_mgedu x1_mgdomestic x1_mgobey
										x1_mgspeak x1_mgcapacity x1_eduopp x1_boysfood x1_coupledu x1_leader3 x1_mgrights2
										x1_mgrights2 x1_mgfriends x1_mgfreetime_men x1_mg_freetime_women x1_mg_womenopi x1_mg_marry
										x1_participation x1_leader4 x1_leader5 x1_leader6_1 x1_leader6_2 x1_leader6_3
										x1_leader6_4 x1_leader6_5 x1_leader6_6 x1_leader6_7 x1_leader6_8 x1_leader6_9 x1_leader6_10
										x2_hwtolerate x2_goesout x2_refuseshave x2_neglectsIf x2_burnsf x2_arguesshe x2_refusescook
										x2_doesinfid x2_contraceptive x2_drinksalcohol x2_refusesclean x2_dowry
										x8_pregn x8_contra x8_suggcontr x8_childresp x8_fatherchild x8_childdeci x8_contratype d_x8_reprodhe_end
										x9_10.1 x9_10.2 x9_10.3 x9_10.4 x9_10.5 x9_10.6 x9_10.7 x9_10.8 x9_10.9
										c1_job_iga c1_descprimjob c1_corebusiness c1_timeprimjob c1_jprimjoblicense c1_hoursprimjob c1_daysprimjob 
										c1_wageprimjob c1_headincome30 c1_wageprimjob business_profit c1_wagesecjob business_profit_2
										c1_headjobc 1_headjobiga  c1_othermemberswork c1_othermembersworkn c1_othermemworkind c1_othermeother c
										1_addotherincome c1_hengag c1_hengag_agr c1_incomeotheriga c1_addotherincomen 
										b3_fooddrink b3_fooddrink_num b3_medical b3_medical_num b3_leisure b3_leisure_num b3_clothes b3_clothes_num
										b3_publictransport b3_publictransport_num b3_elec_gas_water b3_elec_gas_water_num b3_landline_phone
										b3_landline_phone_num b3_soap b3_soap_num b3_otherservice b3_service_other b3_otherservice_num
										b3_medicalexp b3_medicalexpnum b3_chool_exp b3_chool_expnum b3_foodorigin1 b3_foodorigin_other1 b3_foodorigin2
										b3_foodorigin_other2 b3_mealsnumberyest b3_mealsnumber7 b3_foodtype b3_a b3_b
										b4_programfood b4_programfood_hm b4_programfood_am b4_programsorder b4_programsorder_hm b4_programsorder_am 
										b4_programschool b4_programschool_hm b4_programschool_am b4_programtransf b4_programtransf_hm b4_programtransf_am 
										b4_programother b4_programother_other b4_programother_other_hm b4_programother_other_am b4_scaleownhh b4_scaleownhh12
										b2_assetnum_sheep b2_assetnum19_sheep b2_assetnum_duck b2_assetnum19_duck b2_numasset_cows b2_assetnum19_cows 
										b2_assetnum_mule b2_assetnum19_mule b2_assetnum_room b2_assetnum19_room b2_assetnum19_room b2_assetnum_mattresses 
										b2_assetnum19_mattresses b2_assetnum_radio b2_assetnum19_radio b2_assetnum_cellphone b2_assetnum19_cellphone 	
										b2_assetnum_smartphone b2_assetnum19_smartphone b2_assetnum_refrigerator b2_assetnum19_refrigerator 
										b2_assetnum_bicycles b2_assetnum19_bicycles b2_assetnum_moto b2_assetnum19_moto b2_assetnum_chaise 
										b2_assetnum19_chaise b2_assetnum_tablette b2_assetnum19_tablette b2_assetnum_vent b2_assetnum_clim 
										b2_assetnum19_clim b2_assetnum_gr b2_assetnum19_gr b2_assetnum_nat b2_assetnum19_nat b2_assetnum_poch
										b2_assetnum19_poch b2_assetnum_table b2_assetnum19_table b2_assetnum_salon b2_assetnum19_salon b2_assetnum_bibli 
										b2_assetnum19_bibli b2_assetnum_arm b2_assetnum19_arm b2_assetnum_ferer b2_assetnum19_ferer b2_assetnum_mach
										b2_assetnum19_mach b2_assetnum_dec b2_assetnum19_dec c4_hhmig c4_hhmignum c4_hhmigreason c4_migration_q2 
										c4_migration_q4 c4_migration_q5 c4_migration_q6 c4_hhcomin c4_hhmembernew c4_hhmbernewreas c4_hhmbernewreasother
										c4_respondtravel c4_traveldays c4_travelreason c4_travelreasonother c4_travegain c4_travegainsent c4_travegainsave 
										c4_travelannoy c4_parentfrids c4_parentfridsspeak c4_parentfridsubj c4_parentfridguid c4_respfututra
										c4_respfututrareason c4_respfututrareasonother c4_hhfututra c4_hhfututrareason c4_hhfututrareasonother
										d1_ladder_present d1_ladder_1ago d1_ladder3years d1_ladderwealth_intro d1_ladderwealth d_d1_ladderhappy_start
										d1_happyperson d1_calmpeaceful d1_nervousperson d1_heartedblue  d1_cheerup d_d1_ladderhappy_end d2_thinkwrong
										d2_resisttempta d2_postponing d2_tooquickly d2_waiting d2_thinkingmuch d2_regretchoices d2_takeprecaution
										d2_workinginteam d2_opencomunication d2_defendopinions d2_managingtime d2_reachdecisions d2_illnesslifelong
										d2_easyhardtask d_d2_patienceindex_end d3_shortnessbreath d3_fearlosingcontrol d3_worryest d3_feelingsfear 
										d3_frighten d3_feeldeceiving d3_solitaryactivities d3_uncomfortabl d3_unwilling d_d3_selfesteemfeeling_end
										d3_lifethreatening d3_distressing d3_avoidthinking d3_remembering d3_lostinterest d3_feeldetached d3_oftenirritable
										d3_makedecisions d3_sleepeatinghabit d3_depressed d3_wrongmatter d3_alcoholdrugsm d3_feltangry d3_troubllistening
										d3_wrongblame d3_recognition d3_believethink d3_frustrated d3_enoughsleep d3_lotofthings d3_nightmares
										d3_solveproblems d3_dependsmainly d3_feel_helpless d3_influence_many d3_taking_control d3_exploitedcheated
										d3_have_control d3_trust_worthy d3_achieveanything d3_beingaccepted d_d3_depresfrustration_end
										c3_traintrade12 c3_trainkind c3_trainkind_other c3_typejob c3_earnjobmonth c3_haveskills c3_skills c3_skills_other
										c3_dreamjob c3_dreamjobdif c3_dreamjobdif_other c3_obssmallbus c3_obssmallbusdif c3_obssmallbusdifother
										c1_activsearchwork c1_activsearchwork_6m c1_activsearchwork_12m c1_activsearchworkn c1_activsearchworkn_6m 
										c1_activsearchworkn_12m c1_activsearchworkn_other g1_hhfeeling g1_hhtrouble g1_hhimportant g1_hhtrust
										g1_villagtrust g1_respectelders g1_vulnerablservice g1_newcomersconditions g1_managementlead g1_mangmtleadotherm 
										g1_projecttradeoff g1_fundsdonat g1_fundsdonatamount g1_volunteeract g1_volunteeracttime d_g1_comandcivicg1_end
										J16 J17 g1_farmersgroup g1_hhinfarmersgroup g1_farmersgroupship g1_womengroup g1_hhinwomengroup g1_womengroupship
										g1_humancomnitygroup g1_hhinhumancomnitygroup g1_Humancomnitygroupship g1_religiousgroup g1_hhinreligiousgroup 
										g1_religiousgroupship g1_politicalass g1_hhinpoliticalasc g1_politicalascship g1_savingscreditgroup 
										g1_hhinsavingscreditgroup g1_savingscreditgroupship g1_groupother g1_othergroup g1_hhinother1 g1_othership
										d_g1_groupasctypes_end g1_voluntarilyprojectin g1_healthprjt g1_inithealthprjt g1_hhhealthprjt g1_resphealthprjt
										g1_roadprjt g1_initroadprjt g1_hhroadprjt g1_resproadprjt g1_waterprojet g1_initwaterprojet g1_hhwaterprojet 
										g1_respwaterprojet g1_securityprjt g1_initsecurityprjt g1_hhsecurityprjt g1_respsecurityprjt g1_religiousprjt
										g1_initreligiousprjt g1_hhreligiousprjt g1_respreligiousprjt g1_marketprjt g1_initmarketprjt g1_hhmarketprjt
										g1_respmarketprjt g1_otherprjt g1_otherproject g1_initotherprjt g1_hhotherprjt g1_respotherprjt 
										d_g1_voluntarilyprojects_end g3_attendmeetings g3_givepointofview g3_raiseissuetomayor g3_raiseissuetomanagementc 
										g3_contactpolice g3_contactstate g3_contactgovernment g3_contactngo g3_contacteduhealth g3_contactpeople 	
										g3_peacefulparticipation g3_contactmedia g3_contactinfluential g3_meetreligious g3_volunterworks g3_moneydonation
										g3_meetfriends g3_healthprjt g3_resproadprjt g3_respwaterprojet g3_respsecurityprjt g3_respreligiousprjt
										g3_respmarketprjt d_g3_citizensoftenengagement_end g3_safetyproblems g3_safetyproblemother g3_conflictdisputes
										g3_conflictdisputesother g3_healthconcerns g3_healthother g3_healthother1 g3_educationconcerns g3_educationother
										g3_educationother1 g3_developmentconcerns g3_developmentother g3_developmentother_1d_g3_comnityconcerns_end
										i2_taxesintro i2_taxesintro_sup i2_taxesintro_sup_num i3_collectiveactionintro i3_personcontribut i3_vilgectribut 
										i3_vilgengthctribut d3_problemworries d3_usuallyshare d3_usuallyshareother d3_integralpart d3_friendssecrets 
										d3_spendmosttime d3_spendmosttimeother d3_spendalone d3_spendaloneother d3_informindvdualss d3_informindvdua 
										d3_informindvdua1 d3_informindvduals h3_landvictim h3_physivictim h3_stolenvictim h3_robbevictim h3_futurvictim 
										h3_hearphysivictim h3_heardomviol h4_land h4_crops h4_inheritance h4_youngelder h4_religious h4_ethnic h4_political
										h4_otherconflict h4_landhh h4_cropshh h4_inheritancehh h4_youngelderhh h4_religioushh h4_ethnichh  h4_politicalhh 
										h4_otherconflicthh h4_landled h4_cropsled h4_inheritanceled h4_youngelderled h4_religiousled h4_ethnicled 
										h4_politicalle h4_otherconflictled ;
	
/*

local all_outcomes c1_job_iga c1_job_iga_1 c1_job_iga_2 c1_job_iga_3 c1_job_covid business_profit 
				business_employee c3_haveskills c1_wageprimjob total_employement c2_borrow_all c2_borrow12 
				c2_borrow12n c2_repaiddebt c2_eliipsav c2_eliipsavn c2_depositac c2_depositacn c2_loan 
				x9_1 x9_2 x9_3 x9_4 x9_5 x9_6 x9_7 x9_largepurchase x9_dailypurchase x9_wifepersonal 
				x9_borrow x9_lend x9_occupation x9_workplace x9_workhours x9_participation 
				c1_headjob c1_headjobiga_1 c1_headjobiga_2 c1_headjobiga_3 c1_headjobiga_4 c1_headincome30 
				c1_othermemberswork c1_othermembersworkn c1_incomeotheriga 
				c1_hengag c1_hengag_agr c1_rentlabor c1_rentlabor_num c1_fertilizer c1_pesticides 
				productiona c1_cropprodna c1_cropvalna c1_cropconsna c1_cropdonna c1_cropsoldna c1_cropstoredna 
				b3_a_1 b3_a_2 b3_a_3 b3_a_4 b3_a_5 b3_a_6 b3_a_7 b3_a_8 b3_a_9 b3_a_10 b3_a_11 
				b3_fooddrink_num b3_medical_num b3_leisure_num b3_clothes_num b3_publictransport_num 
				b3_elec_gas_water_num b3_landline_phone_num b3_soap_num b3_otherservice_num 
				b3_medicalexpnum b3_chool_expnum conso_tot conso_tot_w conso_tot_pc conso_tot_pc_w 
				conso_food conso_food_pc conso_food_w conso_nofood conso_nofood_pc conso_nofood_w conso_food_pc_w conso_nofood_pc_w 
				b2_assetnum_sheep b2_assetnum19_sheep b2_assetnum_duck b2_assetnum19_duck b2_numasset_cows 
				b2_assetnum19_cows b2_assetnum_mule b2_assetnum19_mule b2_assetnum_room b2_assetnum19_room 
				b2_assetnum19_vent  b2_assetnum_mattresses b2_assetnum19_mattresses b2_assetnum_radio 
				b2_assetnum19_radio b2_assetnum_cellphone b2_assetnum19_cellphone b2_assetnum_smartphone 
				b2_assetnum19_smartphone b2_assetnum_refrigerator b2_assetnum19_refrigerator b2_assetnum_bicycles 
				b2_assetnum19_bicycles b2_assetnum_moto b2_assetnum19_moto b2_assetnum_chaise b2_assetnum19_chaise 
				b2_assetnum_tablette b2_assetnum19_tablette b2_assetnum_vent b2_assetnum_clim b2_assetnum19_clim 
				b2_assetnum_gr b2_assetnum19_gr b2_assetnum_nat b2_assetnum19_nat b2_assetnum_poch b2_assetnum19_poch 
				b2_assetnum_table b2_assetnum19_table b2_assetnum_salon b2_assetnum19_salon b2_assetnum_bibli 
				b2_assetnum19_bibli b2_assetnum_arm b2_assetnum19_arm b2_assetnum_ferer b2_assetnum19_ferer 
				b2_assetnum_mach b2_assetnum19_mach b2_assetnum_dec b2_assetnum19_dec  
				d_b2_assetnum_sheep d_b2_assetnum19_sheep d_b2_assetnum_duck d_b2_assetnum19_duck d_b2_numasset_cows  d_b2_assetnum19_cows 
				d_b2_assetnum_mule d_b2_assetnum19_mule d_b2_assetnum_room d_b2_assetnum19_room d_b2_assetnum_mattresses 
				d_b2_assetnum19_mattresses d_b2_assetnum_radio d_b2_assetnum19_radio d_b2_assetnum_cellphone 
				d_b2_assetnum19_cellphone d_b2_assetnum_smartphone d_b2_assetnum19_smartphone d_b2_assetnum_refrigerator 
				d_b2_assetnum19_refrigerator d_b2_assetnum_bicycles d_b2_assetnum19_bicycles d_b2_assetnum_moto 
				d_b2_assetnum19_moto d_b2_assetnum_chaise d_b2_assetnum19_chaise d_b2_assetnum_tablette d_b2_assetnum19_tablette 
				d_b2_assetnum_vent d_b2_assetnum_clim d_b2_assetnum19_clim d_b2_assetnum_gr d_b2_assetnum19_gr d_b2_assetnum_nat 
				d_b2_assetnum19_nat d_b2_assetnum_poch d_b2_assetnum19_poch d_b2_assetnum_table d_b2_assetnum19_table 
				d_b2_assetnum_salon d_b2_assetnum19_salon d_b2_assetnum_bibli d_b2_assetnum19_bibli d_b2_assetnum_arm  
				d_b2_assetnum19_arm d_b2_assetnum_ferer d_b2_assetnum19_ferer d_b2_assetnum_mach d_b2_assetnum19_mach d_b2_assetnum_dec d_b2_assetnum19_dec 
				b4_sufferevent_1 b4_sufferevent_2 b4_sufferevent_3 b4_sufferevent_4 b4_sufferevent_5 b4_sufferevent_6 b4_sufferevent_7 b4_sufferevent_8 b4_sufferevent_9 
				b4_sufferevent_99 b4_facesufferevent_1 b4_facesufferevent_2 b4_facesufferevent_3 b4_facesufferevent_4 b4_facesufferevent_5 b4_facesufferevent_6 
				b4_facesufferevent_7 b4_facesufferevent_8 b4_facesufferevent_9 b4_facesufferevent_10 b4_facesufferevent_11 b4_facesufferevent_12 b4_facesufferevent_13 
				b4_facesufferevent_14 b4_facesufferevent_15 b4_facesufferevent_0 b4_facesufferevent_99 
				c4_hhmig c4_hhmignum c4_hhmigreason_1 c4_hhmigreason_2 c4_hhmigreason_3 c4_hhmigreason_4 c4_hhmigreason_5 c4_hhmigreason_6 c4_hhmigreason_99 
				c4_respondtravel c4_traveldays c4_travelreason_1 c4_travelreason_2 c4_travelreason_3 c4_travelreason_4 c4_travelreason_5 c4_travelreason_6 c4_travelreason_99 
				c4_respfututra c4_respfututrareason_1 c4_respfututrareason_2 c4_respfututrareason_3 c4_respfututrareason_4 c4_respfututrareason_5 c4_respfututrareason_6 c4_respfututrareason_99 
				c4_hhfututra  c4_hhfututrareason_1 c4_hhfututrareason_2 c4_hhfututrareason_3 c4_hhfututrareason_4 c4_hhfututrareason_5 c4_hhfututrareason_6 c4_hhfututrareason_99  
				d1_ladder_present d1_ladder_1ago d1_ladder3years d1_ladderwealth 
				d3_shortnessbreath d3_fearlosingcontrol  d3_worryest d3_feelingsfear d3_frighten 
				d3_feeldeceiving d3_solitaryactivities d3_uncomfortabl d3_unwilling 
				d3_lifethreatening d3_distressing d3_avoidthinking d3_remembering d3_lostinterest d3_feeldetached 
				d3_oftenirritable d3_makedecisions d3_sleepeatinghabit d3_depressed d3_wrongmatter 
				d3_alcoholdrugs d3_feltangry d3_troubllistening d3_wrongblame d3_recognition 
				d3_believethink d3_frustrated d3_enoughsleep d3_lotofthings d3_nightmares 
				d3_solveproblems d3_dependsmainly d3_feel_helpless d3_influence_many d3_taking_control 
				d3_exploitedcheated d3_have_control d3_trust_worthy d3_achieveanything d3_beingaccepted ;
	
*/	
#delimit cr


	
	
* local all_controls


#delimit ;

local asset 		sheep duck cows 
					mule  room room  
					mattresses radio cellphone 	
					smartphone refrigerator 
					bicycles moto  
					chaise tablette vent clim 
					gr nat poch
					table salon bibli 
					arm ferer mach
					dec;
					
#delimit cr

	* Assets 
	
	foreach var in `asset'{
	
		cap noi replace b2_assetnum19_`var' = 0 if b2_asset_`var' == 0
		cap noi replace b2_assetnum_`var' 	= 0 if b2_asset_`var' == 0
	
	}
	
	* House
	
	replace b2_title_house = 0 if b2_hhhouses != 1
	
	* Perchase expenditures 
	
#delimit ;

local perchase 	fooddrink medical leisure clothes
				publictransport elec_gas_water
				soap landline_phone otherservice;
				
#delimit cr

	foreach var in `perchase'{
		
		replace b3_`var'_num = 0 if b3_`var' == 0
	
	}
	
	replace b3_medicalexpnum 	= 0 if b3_medicalexp 	== 0
	replace b3_chool_expnum 	= 0 if b3_chool_exp 	== 0
	
	* Food items 
	
	forvalue i = 1/11{
	
		replace b3_a_`i' 		= 0 if b3_foodtype_`i' 	== 0 
		replace b3_b_`i' 		= 0 if b3_foodtype_`i' 	== 0 
	
	}
	
	* Houla 
	
	foreach houla in huile ble oth{
	
		replace houla_`houla'_v_2019 = 0 if houla_`houla'_2019 == 0
	
	}
	
	* Received money 
	
	replace b3_receivemoneycity_num = 0 if b3_receivemoneycity 	== 0
	replace b3_receivemoneydrc_num 	= 0 if b3_receivemoneydrc	== 0
	replace b3_receivemoneyabroad_num_19 = 0 if b3_receivemoneyabroad_19 == 0
	replace b3_sendmoney_num_19 	= 0 if b3_sendmoney_num_19 	== 0
	
	* Assistance
	
	foreach program in food sorder school transf{
	
		replace b4_program`program'_am = 0 if b4_program`program' == 0
	
	}
	
	/* c1_job_covid and c1_job_iga, we can not infere in the case somene has an activity now about if it already had the activity before */
	
	replace c1_job_covidlost 	= 0 if c1_job_covid 	== 0 
	replace c1_days_nowork 	 	= 0 if c1_job_iga	 	== 0
	
	foreach var in activsearchwork activsearchwork_6m activsearchwork_12m{
	
	replace c1_`var'	= 0 if c1_job_iga == 1
	
	}
	
	/* We need to consider the trade off between intensive and extensive margins for the whole group "has iga", I would personally leave the genral imputation (no logical assumptions) to look at the intensive margins trt effect on respondent whom have an iga. Same apply to business_owner1 and business_owner2" */
	
	
	replace c1_headincome30 		= 0 if c1_headjob 			== 0 
	replace c1_othermembersworkn 	= 0 if c1_othermemberswork 	== 0
	replace c1_incomeotheriga 		= 0 if c1_othermemberswork 	== 0
	replace c1_addotherincome		= 0 if c1_othermemberswork 	== 0
	replace c1_addotherincomen		= 0 if c1_othermemberswork 	== 0
	
	
	* Agriculture 
	
	foreach var in hengigan hhlandaran{
	
		replace c1_`var' = 0 if c1_hengag_agr == 0
		
	}
	
	
	foreach var in rentlabor rentlabor_num fertilizer adviceag pesticides pesticidloans monitorservices extservices  productionA cropprodnA cropvalnA cropdonnA cropsoldnA cropstorednA {
	
		replace c1_`var' = 0 if c1_hengag_agr == 0
	
	}
	

	
	* Debt and savings 
	
	forvalue i = 1/9{
	
		replace c2_saved12wher_`i' = 0 	if c2_eliipsav == 0
		
	}
	
	replace c2_eliipsavn = 0 		if c2_eliipsav == 0 
	
	forvalue i = 1/10 {
	
		replace c2_spendsaved_`i' = 0 if c2_eliipsav == 0 
	
	}
	
	/* We can not infere from survey data on logical imputation for c2_borrow12 since they might have contracted debt between 2019 and now and already reimbuse them, however the survey ask about the total amout of debt and then condition other questions to the total amount of debt (thus if 0 question not asked) */
	
	replace c2_borrow12n  = 0 if c2_borrow12 == 0 
	
	forvalue i = 1/6{
	
		replace c2_borrowwho_`i' = 0 if c2_borrow12 == 0
	}
	
	
	forvalue i = 1/10{
	
		replace c2_borrow12on_`i' = 0 if c2_borrow12 == 0
	}
	
	forvalue i = 1/17 {
	
		cap noi replace c2_loan_who_`i' = 0 if c2_loan == 0 

	}
	
	replace c2_loan_amount 	= 0 if c2_loan == 0
	
	* Work perspective
	
	forvalue i = 1/18 {
	
		replace c3_trainkind_`i' = 0 if c3_traintrade12 == 0
	
	}
	
	* Migration 
	
	replace c4_hhmignum = 0 if c4_hhmig == 0 
	
	forvalue i = 1/6{
		
		replace c4_hhmigreason_`i' = 0 if c4_hhmig == 0
	
	}
	
	foreach i in 2 4 5 6{
	
		replace c4_migration_q`i' = 0 if c4_hhmig == 0 
		
	}
	
	replace c4_hhmembernew = 0 if c4_hhcomin == 0
	
	replace c4_traveldays = 0 if c4_respondtravel == 0
	
	foreach var in travegain travegainsent travegainsave{
	
		replace c4_`var' = 0 if c4_respondtravel == 0 
		
	}
	
	foreach var in parentfridsspeak parentfridsubj parentfridguid{
	
		replace c4_`var' =  0 if c4_parentfrids == 0 
	
	}
	
	* Children schooling and work
	
	foreach var in childnoschooln childstopschooln landchildh{
	
		replace c5_`var' = 0 if c5_child == 0
	
	}
	
	forvalue i = 0/4 {
	
		replace c5_igakids_tasks_`i' = 0 if c5_child == 0 
		
	}
	
	forvalue i = 1/9 {
	
		replace c5_childnoschoolwhy_`i' = 0 if c5_child == 0 
		
	}
	
	* Psychological well being 
	
	replace d3_usuallyshare = 0 if d3_problemworries == 0
	
	* Access mode to community infratructure 
	
	foreach mode in drinkwater foodmarket primaryschool secondaryschool dispensaryclinic busstop firestation policestation admincenter{
	
	replace e1_time`mode' 	= 0 if e1_`mode' == 0 
	replace e1_hh`mode'		= 0 if e1_`mode' == 0
	
	}
	
	* Access to health care
	
	forvalue i = 1/24 {
	
		cap noi replace e2_hh_conditios_`i' = 0 if e2_hh_conditions == 0 
	}
	
	* Children health 
	
	foreach diseases in fever cough diarrhea vomiting chickenpox aththma smallmeasles infectioneno pneumonia leukemia{
	
		replace e2_`diseases'1 = 0 if e2_`diseases' == 0 & e2_hhchildund7 > 0 & e2_hhchildund7 !=.
	
	}
	
	* Grant 
	
	foreach var in amount form received{
		
		replace grant_`var' = 0 if grant == 0
	
	}
	
	forvalue i = 1/4{
	
		replace grant_use_`i' = 0 if grant == 0
	}
	
	replace business_partner_f_3 = 0 if business_partner_3 == 0 
	replace business_partner_m_3 = 0 if business_partner_3 == 0 
	
	
	* Covid 
	
	replace covid_meetings_count = 0 if covid_meetings == 0
	
	foreach var in covid_change covid_compare covid_support{
	
		replace `var' = 0 if c1_descprimjob != 1 | c1_descsecjob != 1 | grant_bus_prev == 1
	
	}
	
	* Group or asc types 
		
	foreach groupe in farmersgroup womengroup humancomnitygroup religiousgroup politicalasc savingscreditgroup{
	
		replace g1_hhin`groupe' = 0 if g1_`groupe' == 0
		replace g1_`groupe'ship = 0 if g1_`groupe' == 0
		
	}
	
	* Project voluntarily undertaken 
	
	rename g1_waterprojet 		g1_waterprjt
	rename g1_hhwaterprojet 	g1_hhwaterprjt
	rename g1_respwaterprojet 	g1_respwaterprjt
	
	foreach project in health water religious market other{
	
		forvalue i = 1/8{
		
		cap rename g1_initwaterprojet_`i' g1_initwaterprjt_`i'
		
		replace g1_init`project'prjt_`i' 	=  0 if g1_`project'prjt == 0
		replace g1_hh`project'prjt 			=  0 if g1_`project'prjt == 0
		replace g1_resp`project'prjt 		=  0 if g1_`project'prjt == 0
		
		}
	
	}
	
	replace g1_fundsdonatamount = 0 if g1_fundsdonat == 0
	
	replace g2_chiefmoneyamount = 0 if g2_chiefrequirmoney == 0
	
	
	* Violence in community
	
	foreach var in neighborhood publicspace politicalrally publicprotests pltcalrlgiousextremist politicalparties ethnicgroups religiousgroups{
	
		replace g3_exp`var' = 0 if g3_`var' == 0
	
	}
	
	* HH member victim
	
	foreach violence in emoviol1 emoviol2 phyviol1 phyviol2 ecoviol1 ecoviol2 ecoviol3 sexoviol{
	
		replace x4_hh`violence' = 0 if x3_`violence' == 0
		
		forvalue i = 1/3 {
		
			replace x5_perp`violence'_`i' = 0 if x3_`violence' == 0
		
		}
	
	}
	
	rename h4_youngelderact h4_youngelderctact
	rename h4_youngelderes	h4_youngelderres
	
	foreach victim in land crops inheritance youngelder religious ethnic political{
	
		replace h4_`victim'led	= 0 if h4_`victim' == 0
		replace h4_`victim'hh	= 0 if h4_`victim' == 0
		replace h4_`victim'ctact	= 0 if h4_`victim' == 0
		replace h4_`victim'res	= 0 if h4_`victim' == 0
	
	}
	
	* Tax efforts 
	
	replace i2_taxesintro_sup_num 	= 0 if i2_taxesintro_sup  == 0
	replace i3_vilgectribut			= 0 if i3_personcontribut == 0
	replace i3_vilgengthctribut		= 0 if i3_personcontribut == 0
	


foreach sample in cash_0 cash_1{		// followup										// Loop over different dataset 

	if "`sample'" == "followup"{
		local trt_indicator		"program"
		local cond			  `"& Intervention == "Follow up - TCLP""'			// Empty for now but might be useful later for the heterogeneity
	}

	if "`sample'" == "cash_0"{
		local trt_indicator "trt_cash_0"
		local cond			`"& Intervention == "Cash Grants - Women" & Partenaire == "Non""'			// Empty for now but might be useful later for the heterogeneity
	}
	
	if "`sample'" == "cash_1"{
		local trt_indicator "trt_cash_1"
		local cond			`"& Intervention == "Cash Grants - Women" & Partenaire == "Oui""'			// Empty for now but might be useful later for the heterogeneity
	}
	
	foreach variables in $all {

		cap g ori_`variables' = `variables'										// Create original version of each outcomes (cap for the different sample)
		
		cap confirm numeric variable `variables'								// Check variable types 
		
		if _rc !=0{
		
		 di in red "Non numeric variables: `variables'"
		 
		}
		else{																	// If numeric
		
			forvalue i = 0/1 {
		
				sum     `variables' if `trt_indicator' == `i' `cond'
				
				if `r(N)' > 0{													// If var not always missing
	
					replace `variables' = `r(mean)' if   `variables' ==.a & `trt_indicator' == `i' `cond' | ///
														 `variables' ==.k & `trt_indicator' == `i' `cond' | ///
														 `variables' ==.w & `trt_indicator' == `i' `cond' | ///
														 `variables' ==.z & `trt_indicator' == `i' `cond'
				 
				}
			}
		}
	}	
}

* Test that imputation worked
			
foreach variables in $all {

	cap noisily assert `variables' !=. if ori_`variables' == . & Intervention == "Cash Grants - Women"

}

*/
	

