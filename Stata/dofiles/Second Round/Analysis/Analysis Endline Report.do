********************************************************************************
********************************************************************************
*					ANALYSIS ENDLINE REPORT TUNISIA IE
********************************************************************************
********************************************************************************


********************************************************************************
********************************************************************************
global outcomes	z_anxiety_index2 covid_lost_job covid_new_job covid_change_inc_1 covid_change_inc_2 covid_change_inc_3 covid_concerned_1_1 covid_concerned_1_2 covid_concerned_1_3 covid_concerned_1_4 covid_concerned_1_5 covid_concerned_2_1 covid_concerned_2_2 covid_concerned_2_3 covid_concerned_2_4 covid_concerned_2_5

* Income generating activity
global iga_0 c1_headjob c1_headjob_t c1_
global iga_1 

* Female agency 
global fem_0 
global fem_1 
global fem_2 

* Household income generating activities
global biga_0
global biga_1
global biga_2 
global biga_3 
global biga_4 
global biga_5 

* Livestock 
global liv_0
global liv_1 
global liv_2 
global liv_3 

* Consumption 
global con_0 
global con_1 
global con_2 

* Asset index
global ass_0 
global ass_1 

* Subjective well being
global sub_0 
global sub_1 

* Migration 
global mig_0 
global mig_1 
global mig_2 
global mig_3 

* Shocks
global sho_0 
global sho_1 

* COVID-19
global cov_0 
global cov_1 
global cov_2 
global cov_3



if "`outcome'" == "iga_0"{	
	local title "Woman income generating activities"
}
if "`outcome'" == "iga_1"{
	local title "Woman financial outcomes"
}
if "`outcome'" == "fem_o"{
	local title ""
}
if "`outcome'" == "fem_1"{
	local title "Woman involved in the following household decisions:"
}
if "`outcome'" == "fem_2"{
	local title "Woman decides for the following personal decisions:"
}
if "`outcome'" == "biga_0"{
	local title "\textbf{Household head IGA}"
}
if "`outcome'" == "biga_1"{
	local title "\textbf{Other household members IGA}"
}
if "`outcome'" == "biga_2"{
	local title "\textbf{Agriculture}"
}
if "`outcome'" == "biga_3"{
	local title "From January 2019 to the present day"
}
if "`outcome'" == "biga_4"{
	local title "Agricultural production in 2019"
}
if "`outcome'" == "biga_5"{
	local title ""
}
if "`outcome'" == "liv_0"{
	local title "\textbf{Stock} \\ Extensive margin"
}
if "`outcome'" == "liv_1"{
	local title "Intensive margin"
}
if "`outcome'" == "liv_2"{
	local title "\textbf{Inflow (since January 2019)} \\  Extensive margin"
}
if "`outcome'" == "liv_3"{
	local title "Intensive margin"
}
if "`outcome'" == "con_0"{
	local title "Total consumption"
}
if "`outcome'" == "con_1"{
	local title "Food consumption"
}
if "`outcome'" == "con_2"{
	local title "Non-food consumption"
}
if "`outcome'" == "ass_0"{
	local title "Stock"
}
if "`outcome'" == "ass_1"{
	local title "Inflow (since Janauary 2019)"
}
if "`outcome'" == "sub_0"{
	local title "Cantril\'s ladder (codes:1-10, where 10 it the top of the ladder)"
}
if "`outcome'" == "sub_1"{
	local title "Psychological well-being"
}
if "`outcome'" == "mig_0"{
	local title "Household migration"
}
if "`outcome'" == "mig_1"{
	local title "Migration reasons"
}
if "`outcome'" == "mig_2"{
	local title "Migration intentions (respondent)"
}
if "`outcome'" == "mig_3"{
	local title "Migration intentions (other members)"
}
if "`outcome'" == "sho_0"{
	local title "Negative shock (dummy, last two year)"
}
if "`outcome'" == "sho_1"{
	local title "Coping strategy to face the shock (dummy)"
}
if "`outcome'" == "cov_0"{
	local title ""
}
if "`outcome'" == "cov_1"{
	local title "Household income toay vs. before the coronavirus epidemic"
}
if "`outcome'" == "cov_2"{
	local title "How concerned are you that you or any family member could contract COVID in the next 12 months"
}
if "`outcome'" == "cov_3"{
	local title "How concerned are you that you or any family member could lose your job or business in the next 12 months"
}



********************************************************************************
********************************************************************************

use "${data}/clean_analysis_CashXFollow_noPII.dta" , clear
 
drop if attrition == 1 | tot_complete == 0 | Intervention == "Follow up - TCLP" | Intervention == "" | Intervention == "Cash Grants - Partenaire"


moved_imada  does_livestock chemicals hh_income b4_death b4_disease b4_business b4_debts b4_village b4_ngogov b4_sales z_ptsd_index z_depression2_index z_lackselfeff_index ///
				c1_job_iga c1_job_iga_1 c1_job_iga_2 c1_job_iga_3 c1_job_covid business_profit ///
				business_employee c3_haveskills c1_wageprimjob total_employement c2_borrow_all c2_borrow12 ///
				c2_borrow12n c2_repaiddebt c2_eliipsav c2_eliipsavn c2_depositac c2_depositacn c2_loan ///
				x9_1 x9_2 x9_3 x9_4 x9_5 x9_6 x9_7 x9_largepurchase x9_dailypurchase x9_wifepersonal ///
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
				d3_exploitedcheated d3_have_control d3_trust_worthy d3_achieveanything d3_beingaccepted ///
				z_anxiety_index z_depression_index z_assets_total z_assets19_total z_assets_d z_assets19_d z_agency_index ///
				business_profit_q c1_wageprimjob_q c1_headincome30_q c1_incomeotheriga_q c2_borrow_all_q c2_borrow12n_q c2_eliipsavn_q c2_depositacn_q ///
				total_employement_q c1_cropvalna_q conso_food_q conso_nofood_q conso_tot_q conso_food_pc_q conso_nofood_pc_q conso_tot_pc_q c1_cropprodna_q  ///
				c1_cropconsna_q  c1_cropdonna_q  c1_cropsoldna_q  c1_cropstoredna_q */


	
		* analysis 
		foreach var in $outcomes {
		sum `var' if trt_cash==0
		local sd = `r(sd)'
		insert_into_file using "${stata_tex}/sample_table.csv", key(`var'_cmean) value(" `r(mean)'") format(%6.3f)
		insert_into_file using "${stata_tex}/sample_table.csv", key(`var'_csd) value(" `sd'") format(%6.3f)
		reg `var' trt_cash i.a1_enumerator , ro
		store_est_tpl using "${stata_tex}/sample_table.csv" , coef(trt_cash) name(`var'_t) all
		reg `var' trt_cash_0 trt_cash_1 i.a1_enumerator , ro
		store_est_tpl using "${stata_tex}/sample_table.csv" , coef(trt_cash_0) name(`var'_t0) all
		store_est_tpl using "${stata_tex}/sample_table.csv" , coef(trt_cash_1) name(`var'_t1) all
		test trt_cash_0 = trt_cash_1
		insert_into_file using "${stata_tex}/sample_table.csv", key(`var'_test) value(" `r(p)'") format(%6.3f)
		}

		
table_from_tpl, t("${stata_tex}/TPL_1_1_female_business_IGA.tex") r("${stata_tex}/sample_table.csv") o("${stata_tex}/1_1_female_business_IGA.tex")	
table_from_tpl, t("${stata_tex}/TPL_1_2_female_empowerment.tex") r("${stata_tex}/sample_table.csv") o("${stata_tex}/1_2_female_empowerment.tex")	
table_from_tpl, t("${stata_tex}/TPL_2_1_household_IGA.tex") r("${stata_tex}/sample_table.csv") o("${stata_tex}/2_1_household_IGA.tex")	
table_from_tpl, t("${stata_tex}/TPL_2_2a_conso.tex") r("${stata_tex}/sample_table.csv") o("${stata_tex}/2_2a_conso.tex")	
table_from_tpl, t("${stata_tex}/TPL_2_2a_conso2.tex") r("${stata_tex}/sample_table.csv") o("${stata_tex}/2_2a_conso2.tex")	
table_from_tpl, t("${stata_tex}/TPL_2_2b_livestock.tex") r("${stata_tex}/sample_table.csv") o("${stata_tex}/2_2b_livestock.tex")	
table_from_tpl, t("${stata_tex}/TPL_2_2b_assets.tex") r("${stata_tex}/sample_table.csv") o("${stata_tex}/2_2b_assets.tex")	
table_from_tpl, t("${stata_tex}/TPL_2_2b_assets2a.tex") r("${stata_tex}/sample_table.csv") o("${stata_tex}/2_2b_assets2a.tex")	
table_from_tpl, t("${stata_tex}/TPL_2_2b_assets2b.tex") r("${stata_tex}/sample_table.csv") o("${stata_tex}/2_2b_assets2b.tex")	
table_from_tpl, t("${stata_tex}/TPL_2_2b_assets2c.tex") r("${stata_tex}/sample_table.csv") o("${stata_tex}/2_2b_assets2c.tex")	
table_from_tpl, t("${stata_tex}/TPL_2_2b_assets2d.tex") r("${stata_tex}/sample_table.csv") o("${stata_tex}/2_2b_assets2d.tex")	
table_from_tpl, t("${stata_tex}/TPL_2_2c_coping.tex") r("${stata_tex}/sample_table.csv") o("${stata_tex}/2_2c_coping.tex")	
table_from_tpl, t("${stata_tex}/TPL_2_2d_migration.tex") r("${stata_tex}/sample_table.csv") o("${stata_tex}/2_2d_migration.tex")
table_from_tpl, t("${stata_tex}/TPL_2_3_well_being.tex") r("${stata_tex}/sample_table.csv") o("${stata_tex}/2_3_well_being.tex")
table_from_tpl, t("${stata_tex}/TPL_2_3_well_being_details.tex") r("${stata_tex}/sample_table.csv") o("${stata_tex}/2_3_well_being_details.tex")
table_from_tpl, t("${stata_tex}/TPL_covid.tex") r("${stata_tex}/sample_table.csv") o("${stata_tex}/covid.tex")



** Additional quick tests: marital status of the woman; CWLP heterogeneity

	forvalues x=1/4 {
	gen b1_respmaritalstatus_`x' = 1 if b1_respmaritalstatus == `x'
	replace b1_respmaritalstatus_`x' = 0 if b1_respmaritalstatus_`x' == .
	}
	
foreach var in c1_job_iga c3_haveskills c2_depositac total_employement conso_tot_pc conso_food hh_income c1_hengag {
reg `var' TCLP_trt##trt_cash i.a1_enumerator , ro
}

