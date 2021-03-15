********************************************************************************
********************************************************************************
*						IMPUT MISSING VARIABLE TUNISIA
********************************************************************************
********************************************************************************

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
										
										
#delimit cr
	
	
* local all_controls


********************************************************************************
********************************************************************************
* 1) Imput outcomes variables
********************************************************************************
********************************************************************************

u "$vera/clean/clean_CashXFollow_PII.dta", clear

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
	
	foreach variables in `all_outcomes' {

		cap confirm numeric variable `variables'								// Check variable types 
		
		if _rc !=0{
		
		 di in red "Non numeric variables: `variables'"
		 
		}
		else{																	// If numeric
		
			forvalue i = 0/1 {
		
				sum     `variables' if `trt_indicator' == `i' `cond'
				
				if `r(N)' > 0{													// If var not always missing
				
					replace `variables' = `r(mean)' if   `variables' ==.  & `trt_indicator' == `i' `cond' | ///
														 `variables' ==.d & `trt_indicator' == `i' `cond' | ///
														 `variables' ==.a & `trt_indicator' == `i' `cond' | ///
														 `variables' ==.n & `trt_indicator' == `i' `cond'
													 
				}
			}
		}
	}
	
}


********************************************************************************
********************************************************************************
* 2) Imput control variables 
********************************************************************************
********************************************************************************

/* foreach sample in followup cash{												// Loop over different dataset 

			
	if "`sample'" == "followup"{
		local trt_indicator		"beneficiaire"
		local cond			  `"& Intervention == "Follow up - TCLP""'					// Empty for now but might be useful later for the heterogeneity
	}

	if "`sample'" == "followup"{
		local trt_indicator "trt_cash"
		local cond			`"& Intervention == "Cash Grants - Women""'															// Empty for now but might be useful later for the heterogeneity
	}
		
	foreach variables in `all_controls' {

			forvalue i = 0/1 {
		
				g     	m_`variables' = 0 
				replace m_`variables' = 1 if `variables' ==.   `cond' | ///
											 `variables' ==.d  `cond' | ///
											 `variables' ==.a  `cond' | ///
											 `variables' ==.n  `cond'
				
				replace `variables' = 1 if   `variables' ==.   `cond' | ///
											 `variables' ==.d  `cond' | ///
											 `variables' ==.a  `cond' | ///
											 `variables' ==.n  `cond'
			}
	}
	
} */

save "$vera/temp/clean_CashXFollow_PII_imputed.dta", replace
