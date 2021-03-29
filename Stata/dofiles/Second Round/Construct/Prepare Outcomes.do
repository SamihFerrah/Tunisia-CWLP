********************************************************************************
********************************************************************************
*								PREPARE OUTCOME			
********************************************************************************
********************************************************************************

* u "$vera/temp/clean_CashXFollow_PII_3.dta", clear 							// Commented out for replication purpose 

  u "$home/clean_CashXFollow_PII_3.dta", clear

** Cleaning
* ---------------------

	* Female businesses, income generating activities and financial access
	
	gen c1_job_iga_1 = 1 if c1_descprimjob == 1  & c1_job_iga==1				// Wage employed
	gen c1_job_iga_2 = 1 if c1_descprimjob == 2  & c1_job_iga==1				// Self employed
	gen c1_job_iga_3 = 1 if c1_descprimjob == 99 & c1_job_iga==1 				// Other employed
	
	replace c1_wageprimjob 	= 0 if c1_job_iga == 0 & c1_wageprimjob  !=. 		// Wage from activity prior to Covid
	replace business_profit = 0 if c1_job_iga == 0 & business_profit !=. 		// Profit from activity prior to Covid
	
	egen total_employement = rowtotal(c1_wageprimjob business_profit)
	
	* Head IGA
	
	gen c1_headjobiga_1 = 1 if c1_headjobiga == 1 								// Wage employed
	gen c1_headjobiga_2 = 1 if c1_headjobiga == 2 | c1_headjobiga == 3 			// Self employed
	gen c1_headjobiga_3 = 1 if c1_headjobiga == 4 | c1_headjobiga == 5			// 
	gen c1_headjobiga_4 = 1 if c1_headjobiga == 99 								// Other employed
	
	* Other HH members income
	
	rename 	c1_incomeotheriga temp
	egen 	c1_incomeotheriga = rowtotal(temp c1_addotherincomen)				
	
	drop temp
	
	replace c1_othermembersworkn = c1_othermembersworkn/100 if c1_othermembersworkn !=. & c1_othermembersworkn > 10
	
	* Woman agency (change sign so that a higher value indicate a higher level of woman agency)
	
	local woman_recode 	x9_1 x9_2 x9_3 x9_4 x9_5 x9_6 x9_7 x9_largepurchase x9_dailypurchase x9_wifepersonal ///
						x9_borrow x9_lend x9_occupation x9_workplace x9_workhours x9_participation
						
	foreach var in 	`woman_recode'{
					
		replace `var' = 10 	if `var' == 3
		replace `var' = 3 	if `var' == 2 
		replace `var' = 2	if `var' == 10
		
	}
	
	* Conso (turn weekly and monthly amount in days)
	replace b3_fooddrink_num = (b3_fooddrink_num/30)*0.75 						// Multiplied by 0.75 to avoid double counting consumption of last week
	
	foreach var in 	b3_a_1 b3_a_2 b3_a_3 b3_a_4 b3_a_5 b3_a_6 b3_a_7 b3_a_8 b3_a_9 b3_a_10 b3_a_11 {
	
			replace `var'=`var'/7
			
	}
	
	foreach var in 	b3_medical_num b3_leisure_num b3_clothes_num b3_publictransport_num b3_elec_gas_water_num ///
					b3_landline_phone_num b3_soap_num b3_otherservice_num  {
					
			replace `var' = `var'/30
			
	}
	
	foreach var in 	b3_medicalexpnum  b3_chool_expnum {
	
			replace `var' = `var'/180
			
	}	
		
	
	egen conso_food = rowtotal(b3_a_* b3_fooddrink_num)							// Create total food expenses variable
	
	gen conso_food_pc = conso_food/b1_introt									// Create total food expenses per person
	
	egen conso_nofood = rowtotal(b3_medical_num b3_leisure_num b3_clothes_num b3_publictransport_num 	///
						b3_elec_gas_water_num b3_landline_phone_num b3_soap_num b3_otherservice_num 	///
						b3_medicalexpnum b3_chool_expnum)
	
	gen conso_nofood_pc = conso_nofood/b1_introt								// Create total non food expenses per person
	
	* Winsorize expenses variables at the 5% level
	
	foreach var in conso_food conso_food_pc conso_nofood conso_nofood_pc {
	
			winsor `var', gen(`var'_w) p(0.05)
	
	}
	
	egen conso_tot		= rowtotal(conso_food conso_nofood)						// Total expenses
	egen conso_tot_w	= rowtotal(conso_food_w conso_nofood_w)					// Total expenses (winsorized)
	egen conso_tot_pc	= rowtotal(conso_food_pc conso_nofood_pc)				// Total expenses (per person)
	egen conso_tot_pc_w	= rowtotal(conso_food_pc_w conso_nofood_pc_w)			// Total expenses (per person winsorized)
	
	* Livestock, assets
	
	replace b2_assetnum19_duck = 0 if b2_assetnum19_duck == -515				// Correct issue 
	
	* Imput for missing asset num (logically equal to 0 if question missing)
	
	foreach var in b2_assetnum_sheep b2_assetnum19_sheep b2_assetnum_duck b2_assetnum19_duck b2_numasset_cows 			///
				b2_assetnum19_cows b2_assetnum_mule b2_assetnum19_mule b2_assetnum_room b2_assetnum19_room 				///
				b2_assetnum_mattresses b2_assetnum19_mattresses b2_assetnum_radio 										///
				b2_assetnum19_radio b2_assetnum_cellphone b2_assetnum19_cellphone b2_assetnum_smartphone 				///
				b2_assetnum19_smartphone b2_assetnum_refrigerator b2_assetnum19_refrigerator b2_assetnum_bicycles 		///
				b2_assetnum19_bicycles b2_assetnum_moto b2_assetnum19_moto b2_assetnum_chaise b2_assetnum19_chaise 		///
				b2_assetnum_tablette b2_assetnum19_tablette b2_assetnum_vent b2_assetnum_clim b2_assetnum19_clim 		///
				b2_assetnum_gr b2_assetnum19_gr b2_assetnum_nat b2_assetnum19_nat b2_assetnum_poch b2_assetnum19_poch 	///
				b2_assetnum_table b2_assetnum19_table b2_assetnum_salon b2_assetnum19_salon b2_assetnum_bibli 			///
				b2_assetnum19_bibli b2_assetnum_arm b2_assetnum19_arm b2_assetnum_ferer b2_assetnum19_ferer 			///
				b2_assetnum_mach b2_assetnum19_mach b2_assetnum_dec b2_assetnum19_dec b2_assetnum19_vent {
				
			gen 	d_`var' = 0 if   `var' == 0 | `var' == .
			replace d_`var' = 1 if d_`var' == .
			
		}
	
	
	* Psychological well-being (change sign so that a higher value indicate a better outcome)

	foreach var in d3_dependsmainly d3_solveproblems d3_have_control d3_trust_worthy d3_achieveanything{
		
		replace	`var' = -`var' 		if `var'!=. 
		replace `var' = `var'+1 	if `var'!=. 
			
	}

	


	
	* Missing values
	
	global all 	c1_job_iga c1_job_iga_1 c1_job_iga_2 c1_job_iga_3 c1_job_covid business_profit 												///
				business_employee c3_haveskills c1_wageprimjob total_employement c2_borrow_all c2_borrow12 									///
				c2_borrow12n c2_repaiddebt c2_eliipsav c2_eliipsavn c2_depositac c2_depositacn c2_loan 										///
				x9_1 x9_2 x9_3 x9_4 x9_5 x9_6 x9_7 x9_largepurchase x9_dailypurchase x9_wifepersonal 										///
				x9_borrow x9_lend x9_occupation x9_workplace x9_workhours x9_participation 													///
				c1_headjob c1_headjobiga_1 c1_headjobiga_2 c1_headjobiga_3 c1_headjobiga_4 c1_headincome30 									///
				c1_othermemberswork c1_othermembersworkn c1_incomeotheriga 																	///
				c1_hengag c1_hengag_agr c1_rentlabor c1_rentlabor_num c1_fertilizer c1_pesticides 											///
				productiona c1_cropprodna c1_cropvalna c1_cropconsna c1_cropdonna c1_cropsoldna c1_cropstoredna 							///
				b3_a_1 b3_a_2 b3_a_3 b3_a_4 b3_a_5 b3_a_6 b3_a_7 b3_a_8 b3_a_9 b3_a_10 b3_a_11 												///
				b3_fooddrink_num b3_medical_num b3_leisure_num b3_clothes_num b3_publictransport_num 										///		
				b3_elec_gas_water_num b3_landline_phone_num b3_soap_num b3_otherservice_num 												///
				b3_medicalexpnum b3_chool_expnum conso_tot conso_tot_w conso_tot_pc conso_tot_pc_w 											///
				conso_food conso_food_pc conso_food_w conso_nofood conso_nofood_pc conso_nofood_w conso_food_pc_w conso_nofood_pc_w 		///
				b2_assetnum_sheep b2_assetnum19_sheep b2_assetnum_duck b2_assetnum19_duck b2_numasset_cows 									///
				b2_assetnum19_cows b2_assetnum_mule b2_assetnum19_mule b2_assetnum_room b2_assetnum19_room 									///
				b2_assetnum19_vent  b2_assetnum_mattresses b2_assetnum19_mattresses b2_assetnum_radio 										///
				b2_assetnum19_radio b2_assetnum_cellphone b2_assetnum19_cellphone b2_assetnum_smartphone 									///
				b2_assetnum19_smartphone b2_assetnum_refrigerator b2_assetnum19_refrigerator b2_assetnum_bicycles 							///
				b2_assetnum19_bicycles b2_assetnum_moto b2_assetnum19_moto b2_assetnum_chaise b2_assetnum19_chaise 							///
				b2_assetnum_tablette b2_assetnum19_tablette b2_assetnum_vent b2_assetnum_clim b2_assetnum19_clim 							///
				b2_assetnum_gr b2_assetnum19_gr b2_assetnum_nat b2_assetnum19_nat b2_assetnum_poch b2_assetnum19_poch 						///
				b2_assetnum_table b2_assetnum19_table b2_assetnum_salon b2_assetnum19_salon b2_assetnum_bibli 								///
				b2_assetnum19_bibli b2_assetnum_arm b2_assetnum19_arm b2_assetnum_ferer b2_assetnum19_ferer 								///
				b2_assetnum_mach b2_assetnum19_mach b2_assetnum_dec b2_assetnum19_dec  														///
				d_b2_assetnum_sheep d_b2_assetnum19_sheep d_b2_assetnum_duck d_b2_assetnum19_duck d_b2_numasset_cows  d_b2_assetnum19_cows 	///
				d_b2_assetnum_mule d_b2_assetnum19_mule d_b2_assetnum_room d_b2_assetnum19_room d_b2_assetnum_mattresses 					///
				d_b2_assetnum19_mattresses d_b2_assetnum_radio d_b2_assetnum19_radio d_b2_assetnum_cellphone 								///
				d_b2_assetnum19_cellphone d_b2_assetnum_smartphone d_b2_assetnum19_smartphone d_b2_assetnum_refrigerator 					///
				d_b2_assetnum19_refrigerator d_b2_assetnum_bicycles d_b2_assetnum19_bicycles d_b2_assetnum_moto 							///
				d_b2_assetnum19_moto d_b2_assetnum_chaise d_b2_assetnum19_chaise d_b2_assetnum_tablette d_b2_assetnum19_tablette 			///
				d_b2_assetnum_vent d_b2_assetnum_clim d_b2_assetnum19_clim d_b2_assetnum_gr d_b2_assetnum19_gr d_b2_assetnum_nat 			///
				d_b2_assetnum19_nat d_b2_assetnum_poch d_b2_assetnum19_poch d_b2_assetnum_table d_b2_assetnum19_table 						///
				d_b2_assetnum_salon d_b2_assetnum19_salon d_b2_assetnum_bibli d_b2_assetnum19_bibli d_b2_assetnum_arm  						///
				d_b2_assetnum19_arm d_b2_assetnum_ferer d_b2_assetnum19_ferer d_b2_assetnum_mach d_b2_assetnum19_mach d_b2_assetnum_dec 	///
				d_b2_assetnum19_dec 																										///
				b4_sufferevent_1 b4_sufferevent_2 b4_sufferevent_3 b4_sufferevent_4 b4_sufferevent_5 										///
				b4_sufferevent_6 b4_sufferevent_7 b4_sufferevent_8 b4_sufferevent_9 														///
				b4_sufferevent_99 b4_facesufferevent_1 b4_facesufferevent_2 b4_facesufferevent_3 											///
				b4_facesufferevent_4 b4_facesufferevent_5 b4_facesufferevent_6																///	
				b4_facesufferevent_7 b4_facesufferevent_8 b4_facesufferevent_9 b4_facesufferevent_10 b4_facesufferevent_11					///
				b4_facesufferevent_12 b4_facesufferevent_13 																				///
				b4_facesufferevent_14 b4_facesufferevent_15 b4_facesufferevent_0 b4_facesufferevent_99 										///
				c4_hhmig c4_hhmignum c4_hhmigreason_1 c4_hhmigreason_2 c4_hhmigreason_3 c4_hhmigreason_4 c4_hhmigreason_5 					///
				c4_hhmigreason_6 c4_hhmigreason_99 																							///
				c4_respondtravel c4_traveldays c4_travelreason_1 c4_travelreason_2 c4_travelreason_3 c4_travelreason_4 						///
				c4_travelreason_5 c4_travelreason_6 c4_travelreason_99 																		///
				c4_respfututra c4_respfututrareason_1 c4_respfututrareason_2 c4_respfututrareason_3 c4_respfututrareason_4 					///
				c4_respfututrareason_5 c4_respfututrareason_6 c4_respfututrareason_99 														///	
				c4_hhfututra  c4_hhfututrareason_1 c4_hhfututrareason_2 c4_hhfututrareason_3 c4_hhfututrareason_4 							///
				c4_hhfututrareason_5 c4_hhfututrareason_6 c4_hhfututrareason_99  															///
				d1_ladder_present d1_ladder_1ago d1_ladder3years d1_ladderwealth 															///
				d3_shortnessbreath d3_fearlosingcontrol  d3_worryest d3_feelingsfear d3_frighten 											///
				d3_feeldeceiving d3_solitaryactivities d3_uncomfortabl d3_unwilling 														///
				d3_lifethreatening d3_distressing d3_avoidthinking d3_remembering d3_lostinterest d3_feeldetached 							///
				d3_oftenirritable d3_makedecisions d3_sleepeatinghabit d3_depressed d3_wrongmatter 											///
				d3_alcoholdrugs d3_feltangry d3_troubllistening d3_wrongblame d3_recognition 												///
				d3_believethink d3_frustrated d3_enoughsleep d3_lotofthings d3_nightmares 													///
				d3_solveproblems d3_dependsmainly d3_feel_helpless d3_influence_many d3_taking_control 										///
				d3_exploitedcheated d3_have_control d3_trust_worthy d3_achieveanything d3_beingaccepted
	
	
	foreach var in $all {
	
		replace `var'=0 if `var'==.
	}
	
	sum $all
	
	
	* Monetary variables => IHS, quantile
	foreach var in 	business_profit c1_wageprimjob c1_headincome30 c1_incomeotheriga 							///
					c2_borrow_all c2_borrow12n c2_eliipsavn total_employement c1_cropvalna 						///
					conso_food conso_nofood conso_tot conso_food_pc conso_nofood_pc conso_tot_pc  c2_depositacn ///
					c1_cropprodna c1_cropconsna c1_cropdonna c1_cropsoldna c1_cropstoredna 						///
					b3_a_1 b3_a_2 b3_a_3 b3_a_4 b3_a_5 b3_a_6 b3_a_7 b3_a_8 b3_a_9 b3_a_10 b3_a_11 				///
					b3_fooddrink_num b3_medical_num b3_leisure_num b3_clothes_num b3_publictransport_num 		///
					b3_elec_gas_water_num b3_landline_phone_num b3_soap_num b3_otherservice_num 				///
					b3_medicalexpnum b3_chool_expnum {	
					
		* Quantile transformation
			
		sum `var'
			
		scalar nobs = r(N)
			
		egen 	`var'_q = rank(`var')
		replace `var'_q=`var'_q/(nobs+1)
			
		* IHS transformation
			
		gen ihs_`var' = asinh(`var') 
	}

	

* Simplify, merge variables
*-------------------------------
					
* Livestock dummy (indicator for owning livestock)

egen temp = rowtotal(b2_asset_sheep b2_assetnum_duck b2_asset_cows b2_asset_mule)

gen does_livestock = 1 if c1_hengag == 1 & temp > 0

replace does_livestock = 0 if does_livestock ==.

drop temp

* Chemicals dummy 

egen chemicals = rowtotal(c1_fertilizer c1_pesticides)							// Use of chemicals

* Household income

egen hh_income = rowtotal(c1_headincome30 c1_incomeotheriga c1_cropvalna)		// Total household income

* Experience shocks

egen b4_death 		= rowtotal(b4_sufferevent_1 b4_sufferevent_2)
egen b4_disease 	= rowtotal(b4_sufferevent_3 b4_sufferevent_4)
egen b4_business 	= rowtotal(b4_sufferevent_5 b4_sufferevent_7)

* Coping strategies

egen b4_debts 	= rowtotal(b4_facesufferevent_3 b4_facesufferevent_4 b4_facesufferevent_5)
egen b4_village = rowtotal(b4_facesufferevent_8 b4_facesufferevent_9 b4_facesufferevent_10) 
egen b4_ngogov 	= rowtotal(b4_facesufferevent_11 b4_facesufferevent_12) 
egen b4_sales 	= rowtotal(b4_facesufferevent_13 b4_facesufferevent_14)


* Covid (change sign so that a higher value indicate a better outcome)

forvalues x=1/5 {

	foreach var in covid_change_inc covid_concerned_1 covid_concerned_2 {
	
	gen 	`var'_`x' = 1 if `var' == `x'
	replace `var'_`x' = 0 if `var'_`x' ==.
	
	}
}
		
			

** Prepare treatment variables

sum trt_*

replace trt_cash_0 = 0 if trt_cash_0 == .
replace trt_cash_0 = . if trt_cash_1 == 1

replace trt_cash_1 = 0 if trt_cash_1 == .
replace trt_cash_1 = . if trt_cash_0 == 1

gen 	trt_cash_2 = 0 if trt_cash_0 == 1
replace trt_cash_2 = 1 if trt_cash_1 == 1

sum trt_* trt_cash_2

gen 	group = 0 if  trt_cash 		== 0
replace group = 1 if  trt_cash_0 	== 1
replace group = 2 if  trt_cash_1 	== 1 


** winsorization 2

local winsor2 		business_profit c1_wageprimjob c1_headincome30 c1_incomeotheriga 							///
					c2_borrow_all c2_borrow12n c2_eliipsavn total_employement c1_cropvalna 						///
					conso_food conso_nofood conso_tot conso_food_pc conso_nofood_pc conso_tot_pc  c2_depositacn ///
					c1_cropprodna c1_cropconsna c1_cropdonna c1_cropsoldna c1_cropstoredna 						///
					b3_a_1 b3_a_2 b3_a_3 b3_a_4 b3_a_5 b3_a_6 b3_a_7 b3_a_8 b3_a_9 b3_a_10 b3_a_11 				///
					b3_fooddrink_num b3_medical_num b3_leisure_num b3_clothes_num b3_publictransport_num 		///
					b3_elec_gas_water_num b3_landline_phone_num b3_soap_num b3_otherservice_num 				///
					b3_medicalexpnum b3_chool_expnum
					
foreach var in	`winsor2'{	
					
	tab `var'
	
	count if `var' > 0
	local n = (`r(N)'*10)/100 													// 10% of positive values
					
	local n_rounded = round(`n',1) 												// round
	
	winsor `var' , gen(w_`var') h(`n_rounded')
	
	tab w_`var'
	
	drop `var'
	
	rename w_`var' `var'

}
					
