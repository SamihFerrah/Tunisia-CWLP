* import_DIME_Tunisia_Entrepreneurship_Encrypt.do
*
* 	Imports and aggregates "DIME_Tunisia_Entrepreneurship" (ID: DIME_Tunisia_Entrepreneurship_Encrypt) data.
*
*	Inputs:  "DIME_Tunisia_Entrepreneurship_WIDE.csv"
*	Outputs: "DIME_Tunisia_Entrepreneurship.dta"
*
*	Output by SurveyCTO December 26, 2020 5:44 PM.

* initialize Stata
clear all
set more off
set mem 100m

* initialize workflow-specific parameters
*	Set overwrite_old_data to 1 if you use the review and correction
*	workflow and allow un-approving of submissions. If you do this,
*	incoming data will overwrite old data, so you won't want to make
*	changes to data in your local .dta file (such changes can be
*	overwritten with each new import).
local overwrite_old_data 0

* initialize form-specific parameters
local csvfile "$vera/raw/DIME_Tunisia_Entrepreneurship_WIDE.csv"
local dtafile "$vera/temp/temp_import_CashXFollow.dta"
local corrfile "DIME_Tunisia_Entrepreneurship_corrections.csv"
local note_fields1 ""
local text_fields1 "deviceid1 subscriberid1 simid devicephonenum username duration calc_name calc_age calc_sex calc_cin calc_treatment calc_treatment2 complete_info complete_name complete_age complete_cin complete_phone"
local text_fields2 "a1_respondentname a1_respondentname_corr a1_other_notrespondant remain remain2 d_b1_respondent_start d_b1_respondent_end d_b1_headhousehold_start d_b1_headhousehold_end d_b2_hhasset_start"
local text_fields3 "d_b2_hhasset_end b2_hhhouse_other b2_hhhouse_others d_b2_housefix_start d_b2_housefix_end d_b3_hhconsuption_spending_start d_b3_pershase_expense_start b3_service_other d_b3_pershase_expense_end"
local text_fields4 "d_food_repeat_start b3_foodorigin_other1 b3_foodorigin_other2 b3_foodtype food_repeat_count food_repeat2_* food_id_* food_name_* d_food_repeat_end d_cons_houla_start d_cons_houla_end"
local text_fields5 "d_b3_hhconsuption_spending_end d_b4_ecodidinarsopmech_start b4_sufferevent b4_sufferevent_other b4_facesufferevent b4_facesufferevent_other d_b4_ecodidinarsopmech_end d_b4_assist_program_start"
local text_fields6 "b4_programother_other d_b4_assist_program_end d_c_econowelfare_start c1_activsearchworkn_other d_hasiga_start c1_employstatus_other c1_corebusiness_othe c1_corebusiness_other c1_descprimjocal"
local text_fields7 "d_business_owner1_start d_business_owner1_end d_business_owner2_start d_business_owner2_end d_hasiga_end c1_headjobiga_other c1_othermemworkind c1_othermeother d_agriculture_start"
local text_fields8 "d_landcultiveted_start c1_servicesorg c1_servicesorgother c1_cropsowna_other totala totalacal d_landcultiveted_end d_agriculture_end d_c1_employmentiga_end d_c2_debtsaving_start c2_saved12wher"
local text_fields9 "c2_spendsaved c2_spendsaved_other c2_borrowwho c2_borrowwho_other c2_borrow12on c2_borrow12on_other c2_company c2_access_who c2_borrowmore12on c2_borrowmore12oter d_c2_debtsaving_end c2_loan_who"
local text_fields10 "d_c3_workpersp_start c3_trainkind c3_trainkind_other c3_skills c3_skills_other c3_dreamjobdif c3_dreamjobdif_other c3_obssmallbusdif c3_obssmallbusdifother d_c3_workpersp_end d_c4_migration_start"
local text_fields11 "c4_hhmigreason c4_hhmigreasonother d_migration_hh_member_start d_migration_hh_member_end c4_hhmbernewreas c4_hhmbernewreasother c4_travelreason c4_travelreasonother c4_respfututrareason"
local text_fields12 "c4_respfututrareasonother c4_hhfututrareason c4_hhfututrareasonother d_c4_migration_end d_c5_childschoolwork_start c5_childnoschoolwhy c5_childnoschoolwhy_other c5_igakids_tasks"
local text_fields13 "d_c5_childschoolwork_end d_c_econowelfare_end d_socioecono_demograph_end d_d_motivations_start d_d1_cantriladmsures_start d_d1_cantriladmsures_end d_d1_ladderhappy_start d_d1_ladderhappy_end"
local text_fields14 "d_d2_patienceindex_start d_d2_characteristics_start d_d2_characteristics_end d_d2_patienceindex_end d_d3_selfesteempsycho_start d_d3_selfesteemfeeling_start d_d3_selfesteemfeeling_end"
local text_fields15 "d_d3_depresfrustration_start d_d3_depresfrustration_end d_d3_familysocialrelship_start d3_usuallyshareother d3_spendmosttimeother d3_spendaloneother d_d3_familysocialrelship_end"
local text_fields16 "d_d3_selfesteempsycho_end d_d_motivations_end d_e_socialinfraservices_start d_e1_modcomtyinfrastrure_start e1_modwater_f e1_modwater_e e1_modwater_a e1_moddrinkwaterother e1_modmarket_f e1_modmarket_e"
local text_fields17 "e1_modmarket_a e1_modfoodmarketother e1_modprimaryschoolother e1_modprimary_f e1_modprimary_e e1_modprimary_a e1_modsecdryschoolother e1_modsecondary_f e1_modsecondary_e e1_modsecondary_a"
local text_fields18 "e1_moddispensary_f e1_moddispensary_e e1_moddispensary_a e1_moddispsaryclinicother e1_modbusstopother e1_modbus_f e1_modbus_e e1_modbus_a e1_modfirestationother e1_modfire_f e1_modfire_e e1_modfire_a"
local text_fields19 "e1_modpolicestationother e1_modpolice_f e1_modpolice_e e1_modpolice_a e1_modadmincenterother e1_modadmin_f e1_modadmin_e e1_modadmin_a d_e1_modcomtyinfrastrure_end d_e2_healthcaraccess_start"
local text_fields20 "e2_hh_conditios e2_hh_conditiosother e2_visitedservices e2_hh_medicalcareother d_childsunder7_start e2_othterot d_childsunder7_end e2_childdeathreasonother d_e2_healthcenters_start"
local text_fields21 "d_e2_healthcenters_end d_e2_healthcaraccess_end d_e3_educationcenters_start d_e3_educationcontion_start d_e3_educationcontion_end d_e3_educationcenters_end d_e_socialinfraservices_end d_uct_start"
local text_fields22 "grant_oth_who d_grant_yes_start grant_use d_covid_bus_follow_start d_business_owner3_start d_business_owner3_end d_covid_bus_follow_end d_grant_yes_end d_grant_no_start d_grant_no_end d_uct_end"
local text_fields23 "d_fin_train_start d_participated_start d_participated_end d_fin_train_end d_covid_module_start d_imada_measure_start d_imada_measure1_start d_imada_measure1_end d_imada_measure_end d_cov_bus_start"
local text_fields24 "covid_worst d_cov_action_start d_cov_action_end d_cov_bus_end d_covid_module_end d_j_com_and_civic_start d_g1_comandcivicg1_start d_g1_groupasctypes_start g1_othergroup d_g1_groupasctypes_end"
local text_fields25 "d_g1_voluntarilyprojects_start g1_inithealthprjt g1_initroadprjt g1_initwaterprojet g1_initsecurityprjt g1_initreligiousprjt g1_initmarketprjt g1_otherproject g1_initotherprjt"
local text_fields26 "d_g1_voluntarilyprojects_end g1_mangmtleadother d_g1_comandcivicg1_end d_g2_relationshipinvillages_star g2_decisioninfluencebodies g2_bodiesother d_g2_relationshipinvillages_end"
local text_fields27 "d_g3_comnitycivicengagment_start d_g3_citizensoftenengagement_sta d_g3_citizensoftenengagement_end d_g3_comnityconcerns_start g3_safetyproblemother g3_conflictdisputesother g3_healthother"
local text_fields28 "g3_healthother1 g3_educationother g3_educationother1 g3_developmentother g3_developmentother_1 d_g3_comnityconcerns_end d_g3_electionpreslegislative_sta g3_electionnotvote_other1"
local text_fields29 "g3_electionnotvote_other2 g3_hhcandidatsspecify d_g3_electionpreslegislative_end d_g3_interestsinpolitics_start d_g3_interestsinpolitics_end d_g3_disagreementsviolences_star"
local text_fields30 "d_g3_disagreementsviolences_end d_g3_expdisagreemenviolences_sta d_g3_expdisagreemenviolences_end g3_sourcescominform g3_sourcescominformother g3_sourcesconinform g3_sourcesconinformother"
local text_fields31 "g3_sourcesprogramother d_g3_comnitycivicengagment_end d_g4_communityattitudes_start d_g4_communityattitudes1_start d_g4_communityattitudes1_end d_g4_communityattitudes2_start"
local text_fields32 "d_g4_communityattitudes2_end d_g4_communityattitudes3_start d_g4_communityattitudes3_end d_g4_communityattitudes4_start d_g4_communityattitudes4_end d_g4_communityattitudes5_start"
local text_fields33 "d_g4_communityattitudes5_end d_g4_communityattitudes6_start d_g4_communityattitudes6_end d_g4_communityattitudes7_start d_g4_communityattitudes7_end d_g4_communityattitudes8_start"
local text_fields34 "d_g4_communityattitudes8_end d_g4_communityattitudes9_start d_g4_communityattitudes9_end d_g4_communityattitudes10_start d_g4_communityattitudes10_end d_g4_communityattitudes_end d_j_com_and_civic_end"
local text_fields35 "d_h1_antiprosocialbehavior_start d_h1_personallyengageds_start d_h1_personallyengageds_end d_h1_antiprosocialbehavior_end d_x1_mengender_yesno_start d_x1_mengender_yesno_end d_x1_mengender_agree_start"
local text_fields36 "d_x1_mengender_agree_end d_x1_mengender1_start d_x1_mengender1_end d_x1_mengender2_start d_x1_mengender2_end d_x1_mengender_start d_x2_husbanwives_start d_x2_husbanwives_end d_x6_sexuality_start"
local text_fields37 "d_x6_sexuality_end d_x7_masculinity_start d_x7_masculinity_end d_x8_reprodhe_start d_x8_reprodhe_end d_x9_autonomy_start d_x9_autonomy_end d_x9_autonomy2_start x9_moneyspend x9_clothing x9_ornaments"
local text_fields38 "x9_chores d_x9_autonomy2_end d_x9_autonomy3_start d_x9_autonomy3_end d_x3_gbviolences_start d_x3_gbviolences_end d_x4_gbviolenceshh_start d_x4_gbviolenceshh_end d_x5_gbviolencesperp_start"
local text_fields39 "x5_perpemoviol1 x5_perpemoviol2 x5_perpphyviol1 x5_perpphyviol2 x5_perpecoviol1 x5_perpecoviol2 x5_perpecoviol3 x5_perpsexoviol d_x5_gbviolencesperp_end d_h3_victimizations_start"
local text_fields40 "d_h3_victimizations_end d_h4_conflictsincommunity_start d_hh_socialintegration_start hh_social_1 d_hh_socialintegration_end d_h4_conflictsincom_start d_h4_conflictsincom_end h4_otherconflictother"
local text_fields41 "d_h4_conflictledviol_start d_h4_conflictledviol_end d_h4_conflictafhh_start d_h4_conflictafhh_end d_h4_conflictrectact_start d_h4_conflictrectact_end d_h4_conflictresolution_start"
local text_fields42 "d_h4_conflictresolution_end d_h4_conflictsincommunity_end d_d_trauma_start trauma_fin d_d_trauma_end d_i2_taxes_start d_i2_taxes_end j_interstopped resultat_autre instanceid"
local date_fields1 "a1_date c2_depositacns"
local datetime_fields1 "submissiondate starttime"

disp
disp "Starting import of: `csvfile'"
disp

* import data from primary .csv file
insheet using "`csvfile'", names clear

* drop extra table-list columns
cap drop reserved_name_for_field_*
cap drop generated_table_list_lab*

* continue only if there's at least one row of data to import
if _N>0 {
	* drop note fields (since they don't contain any real data)
	forvalues i = 1/100 {
		if "`note_fields`i''" ~= "" {
			drop `note_fields`i''
		}
	}
	/*
	* format date and date/time fields
	forvalues i = 1/100 {
		if "`datetime_fields`i''" ~= "" {
			foreach dtvarlist in `datetime_fields`i'' {
				cap unab dtvarlist : `dtvarlist'
				if _rc==0 {
					foreach dtvar in `dtvarlist' {
						tempvar tempdtvar
						rename `dtvar' `tempdtvar'
						gen double `dtvar'=.
						cap replace `dtvar'=clock(`tempdtvar',"DMYhms",2025)
						* automatically try without seconds, just in case
						cap replace `dtvar'=clock(`tempdtvar',"DMYhm",2025) if `dtvar'==. & `tempdtvar'~=""
						format %tc `dtvar'
						drop `tempdtvar'
					}
				}
			}
		}
		if "`date_fields`i''" ~= "" {
			foreach dtvarlist in `date_fields`i'' {
				cap unab dtvarlist : `dtvarlist'
				if _rc==0 {
					foreach dtvar in `dtvarlist' {
						tempvar tempdtvar
						rename `dtvar' `tempdtvar'
						gen double `dtvar'=.
						cap replace `dtvar'=date(`tempdtvar',"DMY",2025)
						format %td `dtvar'
						drop `tempdtvar'
					}
				}
			}
		}
	}
	*/
	* ensure that text fields are always imported as strings (with "" for missing values)
	* (note that we treat "calculate" fields as text; you can destring later if you wish)
	tempvar ismissingvar
	quietly: gen `ismissingvar'=.
	forvalues i = 1/100 {
		if "`text_fields`i''" ~= "" {
			foreach svarlist in `text_fields`i'' {
				cap unab svarlist : `svarlist'
				if _rc==0 {
					foreach stringvar in `svarlist' {
						quietly: replace `ismissingvar'=.
						quietly: cap replace `ismissingvar'=1 if `stringvar'==.
						cap tostring `stringvar', format(%100.0g) replace
						cap replace `stringvar'="" if `ismissingvar'==1
					}
				}
			}
		}
	}
	quietly: drop `ismissingvar'


	* consolidate unique ID into "key" variable
	replace key=instanceid if key==""
	drop instanceid


	* label variables
	label variable key "Unique submission ID"
	cap label variable submissiondate "Date/time submitted"
	cap label variable formdef_version "Form version used on device"
	cap label variable review_status "Review status"
	cap label variable review_comments "Comments made during review"
	cap label variable review_corrections "Corrections made during review"


	label variable imada "Select imada's name"
	note imada: "Select imada's name"
	label define imada 1 "Abd jabar" 2 "Ain Draham Banlieus" 3 "Ain Krima" 4 "Ain Lbaya" 5 "Ain Salem" 6 "Ain Snoussi" 7 "Ain sobh" 8 "Ain Soltan" 9 "Al-itha" 10 "Assila" 11 "Atatfa" 12 "Azima" 13 "Balta" 14 "Bellarigia" 15 "Ben bachir / Ezzouhour" 16 "Bni Mhimid" 17 "Bni mtir" 18 "Bouawen" 19 "Bouhertma" 20 "Boulaaba" 21 "Chemtou" 22 "Chwewla" 23 "Dkhaylia" 24 "Edir" 25 "Edoura" 26 "El Brahmi" 27 "El Hamem" 28 "El koudia" 29 "El Malgua" 30 "El Mrassen" 31 "Elaadher" 32 "Elbir Lakhdher" 33 "Elkhadhra" 34 "Ennadhour" 35 "Erwaii" 36 "Esraya" 37 "Faj Hssine" 38 "Fargsan" 39 "Ferdaws" 40 "Fernana" 41 "Galaa" 42 "Ghardima Nord" 43 "Ghzala" 44 "Gloub Thiren Nord" 45 "Gloub Thiren Sud" 46 "Gwaidia" 47 "Hamdia" 48 "Hdhil" 49 "Hkim Sud" 50 "Hlima" 51 "Homran" 52 "Jwewda" 53 "khmayria" 54 "Laawawdha" 55 "Lbaldia" 56 "Maloula" 57 "Manguouch" 58 "Marja" 59 "Oued ezzen" 60 "Oued kasseb" 61 "Oued Mliz Ouest" 62 "Ouled sedra" 63 "Rakha" 64 "Rbiaa" 65 "Rihan" 66 "Satfoura" 67 "Sidi Abid" 68 "Sidi Amar" 69 "Sloul" 70 "Somran" 71 "Souk Jemaa" 72 "Souk Sebt" 73 "Swani" 74 "Tabarka" 75 "Tbaynia" 76 "Tegma" 77 "Wechtata" 78 "Wed Elmaaden" 79 "Wed Ghrib" 80 "Wled Mfada"
	label values imada imada

	label variable psu "Enter PSU code as displayed on the assignment list"
	note psu: "Enter PSU code as displayed on the assignment list"

	label variable a1_enumerator "Enumerator select your name"
	note a1_enumerator: "Enumerator select your name"
	label define a1_enumerator 1 "Abidi Aida" 2 "Afef HERMI" 3 "Amal Jemai" 4 "Amina Abidi" 5 "Bouslimi Ameni" 6 "Ebdelli Raouf" 7 "Farah Rezgui" 8 "Ghribi Marwen" 9 "Haddad Sofiene" 10 "Hend Azizi" 11 "Imen Balti" 12 "Khemissi Emna" 13 "Maroua Mezni" 14 "Marwen Bechini" 15 "Mohamed Ilyes Amiri" 16 "Nawres Rhimi" 17 "Nawres Saidi" 18 "Ouji Imen" 19 "Ouji Mariem" 20 "Rim Bchini" 21 "Salsabil Kouki" 22 "Sana Jemai" 23 "Soumaya Abidi" 24 "Tarek Belaidi" 25 "Tissaoui Khira" 26 "Tissaoui Takwa" 27 "Zaieneb Bechini" 28 "Zied guesmi"
	label values a1_enumerator a1_enumerator

	label variable a1_date "A.1.2 Date"
	note a1_date: "A.1.2 Date"

	label variable a1_timeinterview "A.1.2 (B) Time of the interview"
	note a1_timeinterview: "A.1.2 (B) Time of the interview"

	label variable gpslatitude "Please take GPS coordinates (latitude)"
	note gpslatitude: "Please take GPS coordinates (latitude)"

	label variable gpslongitude "Please take GPS coordinates (longitude)"
	note gpslongitude: "Please take GPS coordinates (longitude)"

	label variable gpsaltitude "Please take GPS coordinates (altitude)"
	note gpsaltitude: "Please take GPS coordinates (altitude)"

	label variable gpsaccuracy "Please take GPS coordinates (accuracy)"
	note gpsaccuracy: "Please take GPS coordinates (accuracy)"

	label variable hhid "Enter the code of the candidate"
	note hhid: "Enter the code of the candidate"

	label variable hhid_confirm "Confirm candidate's code"
	note hhid_confirm: "Confirm candidate's code"

	label variable a1_respondentname "A.1.7. Respondent’s Name"
	note a1_respondentname: "A.1.7. Respondent’s Name"

	label variable a1_respondentage "Enter respondent age"
	note a1_respondentage: "Enter respondent age"

	label variable a1_phonerespond "A.1.1.7.3 Telephone number of respondent"
	note a1_phonerespond: "A.1.1.7.3 Telephone number of respondent"

	label variable confirm_resp "Here's the respondent information number \${hhid}, please confirm these informat"
	note confirm_resp: "Here's the respondent information number \${hhid}, please confirm these informations are correct."
	label define confirm_resp 1 "Yes" 0 "No"
	label values confirm_resp confirm_resp

	label variable confirm_name "Nom : \${calc_name}\${a1_respondentname}"
	note confirm_name: "Nom : \${calc_name}\${a1_respondentname}"
	label define confirm_name 1 "Yes" 0 "No"
	label values confirm_name confirm_name

	label variable confirm_age "Age : \${calc_age}\${a1_respondentage}"
	note confirm_age: "Age : \${calc_age}\${a1_respondentage}"
	label define confirm_age 1 "Yes" 0 "No"
	label values confirm_age confirm_age

	label variable confirm_cin "CIN : \${calc_CIN}"
	note confirm_cin: "CIN : \${calc_CIN}"
	label define confirm_cin 1 "Yes" 0 "No"
	label values confirm_cin confirm_cin

	label variable a1_respondentname_corr "Enter the correct name of the respondent"
	note a1_respondentname_corr: "Enter the correct name of the respondent"

	label variable a1_respondentage_corr "Enter the correct age of the respondent"
	note a1_respondentage_corr: "Enter the correct age of the respondent"

	label variable a1_truerespondant "A.1.9. Was the respondent successfully identified?"
	note a1_truerespondant: "A.1.9. Was the respondent successfully identified?"
	label define a1_truerespondant 1 "Yes" 0 "No"
	label values a1_truerespondant a1_truerespondant

	label variable a1_notrespondant "A.1.10. What was the main reason of unsuccessful visit?"
	note a1_notrespondant: "A.1.10. What was the main reason of unsuccessful visit?"
	label define a1_notrespondant 1 "1. Respondent was unavailable during interview period" 2 "2. Respondent moved out of avenue/cannot be located" 3 "3. Respondent was present, but unable to interview" 4 "4. Aucune information correcte concernant le répondant dans l'annuaire" 99 "99. Other" -97 "Refuse to say" -98 "Non applicable" -99 "Don't know"
	label values a1_notrespondant a1_notrespondant

	label variable a1_other_notrespondant "A.1.10. What was the other reason of unsuccessful visit?"
	note a1_other_notrespondant: "A.1.10. What was the other reason of unsuccessful visit?"

	label variable conf_cash_control "BASED ON THE INFORMATION PROVIDED, YOU WILL BE PREPARED TO TAKE THE SURVEY WITH "
	note conf_cash_control: "BASED ON THE INFORMATION PROVIDED, YOU WILL BE PREPARED TO TAKE THE SURVEY WITH A RESPONDENT SELECTED TO RECEIVE THE MAIN SURVEY FOR ONE OF THE WOMEN WHO ARE PART OF THE MONETARY GRANT PROGRAM CONTROL GROUP. DO YOU CONFIRM THAT?"
	label define conf_cash_control 1 "Yes" 0 "No"
	label values conf_cash_control conf_cash_control

	label variable conf_cash_treatment "BASED ON THE INFORMATION PROVIDED, YOU WILL BE ABLE TO TAKE THE SURVEY WITH A RE"
	note conf_cash_treatment: "BASED ON THE INFORMATION PROVIDED, YOU WILL BE ABLE TO TAKE THE SURVEY WITH A RESPONDENT SELECTED TO RECEIVE THE MAIN SURVEY FOR ONE OF THE WOMEN WHO ARE PART OF THE TREATMENT GROUP OF THE MONETARY GRANT PROGRAM. DO YOU CONFIRM THAT?"
	label define conf_cash_treatment 1 "Yes" 0 "No"
	label values conf_cash_treatment conf_cash_treatment

	label variable conf_cash_partner "BASED ON THE INFORMATION PROVIDED, YOU WILL BE ABLE TO TAKE THE SURVEY WITH A RE"
	note conf_cash_partner: "BASED ON THE INFORMATION PROVIDED, YOU WILL BE ABLE TO TAKE THE SURVEY WITH A RESPONDENT SELECTED TO RECEIVE THE SHORT SURVEY BECAUSE OF THE PARTNER OF ONE OF THE WOMEN WHO ARE PART OF THE TREATMENT OR CONTROL GROUP OF THE MONETARY GRANT PROGRAM. DO YOU CONFIRM THAT?"
	label define conf_cash_partner 1 "Yes" 0 "No"
	label values conf_cash_partner conf_cash_partner

	label variable conf_followup "BASED ON THE INFORMATION PROVIDED, YOU ARE PREPARING TO TAKE THE SURVEY WITH A R"
	note conf_followup: "BASED ON THE INFORMATION PROVIDED, YOU ARE PREPARING TO TAKE THE SURVEY WITH A RESPONDENT SELECTED FOR HIS PARTICIPATION IN THE TCLP IMPLEMENTED PROGRAM IN 2016. DO YOU CONFIRM THIS?"
	label define conf_followup 1 "Yes" 0 "No"
	label values conf_followup conf_followup

	label variable a1_a2_consent_6 "Your collected data will be managed as confidential as possible. If the results "
	note a1_a2_consent_6: "Your collected data will be managed as confidential as possible. If the results of this study are published or presented, names and other identifying information will not be used or shared with third parties. Your answers will be coded and the code linking your identity to your answers will be encrypted and saved in files protected by passwords. If you have any questions about this research, you can ask us now or later at the details below. BJKA consulting au 71 712 907. If you have any questions about your rights or treatment as a research participant in this study, you may contact: DIME Laboratory at dimesupport@worldbank.org ( +1 (202) 473-2012 | ext : 32012); or SolutionIRB at participants@solutionsirb.com (#855-226-4472) Do you agree to participate?"
	label define a1_a2_consent_6 1 "Yes" 0 "No"
	label values a1_a2_consent_6 a1_a2_consent_6

	label variable b1_introt "How many people (household members), including yourself, live in your household?"
	note b1_introt: "How many people (household members), including yourself, live in your household?"

	label variable b1_men "B1.1 How many men (adults and children) live in your household?"
	note b1_men: "B1.1 How many men (adults and children) live in your household?"

	label variable b1_women "B1.1 How many women (adults and children) live in your household?"
	note b1_women: "B1.1 How many women (adults and children) live in your household?"

	label variable b1_headhousehold "B1.14. Are you the head of this household ?"
	note b1_headhousehold: "B1.14. Are you the head of this household ?"
	label define b1_headhousehold 1 "Yes" 0 "No"
	label values b1_headhousehold b1_headhousehold

	label variable b1_respmaritalstatus "B1.16. Marital Status"
	note b1_respmaritalstatus: "B1.16. Marital Status"
	label define b1_respmaritalstatus 1 "1. Married / cohabitant" 2 "2. Divorced / Separated" 3 "3. Widow/er" 4 "4. Single"
	label values b1_respmaritalstatus b1_respmaritalstatus

	label variable b1_respeducationlevel "B1.21. How many years in total have you studied ? (primary, secondary, superior)"
	note b1_respeducationlevel: "B1.21. How many years in total have you studied ? (primary, secondary, superior)"

	label variable b1_respreadwrite "B1.22. Knows how to read and write?"
	note b1_respreadwrite: "B1.22. Knows how to read and write?"
	label define b1_respreadwrite 1 "Yes" 0 "No"
	label values b1_respreadwrite b1_respreadwrite

	label variable b1_headgender "B1.15. Gender"
	note b1_headgender: "B1.15. Gender"
	label define b1_headgender 0 "Female" 1 "Male"
	label values b1_headgender b1_headgender

	label variable b1_headmaritalstatus "B1.16. Marital Status"
	note b1_headmaritalstatus: "B1.16. Marital Status"
	label define b1_headmaritalstatus 1 "1. Married / cohabitant" 2 "2. Divorced / Separated" 3 "3. Widow/er" 4 "4. Single"
	label values b1_headmaritalstatus b1_headmaritalstatus

	label variable b1_headeducationlevel "B1.21. HH chief highest educational level"
	note b1_headeducationlevel: "B1.21. HH chief highest educational level"

	label variable b1_headreadwrite "B1.22 Knows how to read and write?"
	note b1_headreadwrite: "B1.22 Knows how to read and write?"
	label define b1_headreadwrite 1 "Yes" 0 "No"
	label values b1_headreadwrite b1_headreadwrite

	label variable b2_asset_sheep "B.2.1.1 sheep, goats"
	note b2_asset_sheep: "B.2.1.1 sheep, goats"
	label define b2_asset_sheep 1 "Yes" 0 "No"
	label values b2_asset_sheep b2_asset_sheep

	label variable b2_assetnum_sheep "How many sheep, goats?"
	note b2_assetnum_sheep: "How many sheep, goats?"

	label variable b2_assetnum19_sheep "How manysheep goats have been bought since January 2019 ?"
	note b2_assetnum19_sheep: "How manysheep goats have been bought since January 2019 ?"

	label variable b2_asset_duck "B.2.1.2. duck, pigeon, chicken"
	note b2_asset_duck: "B.2.1.2. duck, pigeon, chicken"
	label define b2_asset_duck 1 "Yes" 0 "No"
	label values b2_asset_duck b2_asset_duck

	label variable b2_assetnum_duck "How many duck, pigeon chicken ?"
	note b2_assetnum_duck: "How many duck, pigeon chicken ?"

	label variable b2_assetnum19_duck "How many have been bought since January 2019 ?"
	note b2_assetnum19_duck: "How many have been bought since January 2019 ?"

	label variable b2_asset_cows "B.2.1.3. cows, buffalo"
	note b2_asset_cows: "B.2.1.3. cows, buffalo"
	label define b2_asset_cows 1 "Yes" 0 "No"
	label values b2_asset_cows b2_asset_cows

	label variable b2_numasset_cows "B.2.1.3. How many cows, buffalo ?"
	note b2_numasset_cows: "B.2.1.3. How many cows, buffalo ?"

	label variable b2_assetnum19_cows "How many have been bought since January 2019 ?"
	note b2_assetnum19_cows: "How many have been bought since January 2019 ?"

	label variable b2_asset_mule "B.2.1.4. mules, donkeys"
	note b2_asset_mule: "B.2.1.4. mules, donkeys"
	label define b2_asset_mule 1 "Yes" 0 "No"
	label values b2_asset_mule b2_asset_mule

	label variable b2_assetnum_mule "How many mules donkey?"
	note b2_assetnum_mule: "How many mules donkey?"

	label variable b2_assetnum19_mule "How many have been bought since January 2019 ?"
	note b2_assetnum19_mule: "How many have been bought since January 2019 ?"

	label variable b2_asset_room "B.2.1.5. rooms (total)"
	note b2_asset_room: "B.2.1.5. rooms (total)"
	label define b2_asset_room 1 "Yes" 0 "No"
	label values b2_asset_room b2_asset_room

	label variable b2_assetnum_room "How many rooms?"
	note b2_assetnum_room: "How many rooms?"

	label variable b2_assetnum19_room "How many have been bought since January 2019 ?"
	note b2_assetnum19_room: "How many have been bought since January 2019 ?"

	label variable b2_asset_mattresses "B.2.1.7. foam mattresses"
	note b2_asset_mattresses: "B.2.1.7. foam mattresses"
	label define b2_asset_mattresses 1 "Yes" 0 "No"
	label values b2_asset_mattresses b2_asset_mattresses

	label variable b2_assetnum_mattresses "How many foam matresses?"
	note b2_assetnum_mattresses: "How many foam matresses?"

	label variable b2_assetnum19_mattresses "How many have been bought since January 2019 ?"
	note b2_assetnum19_mattresses: "How many have been bought since January 2019 ?"

	label variable b2_asset_radio "B.2.1.8. radio player"
	note b2_asset_radio: "B.2.1.8. radio player"
	label define b2_asset_radio 1 "Yes" 0 "No"
	label values b2_asset_radio b2_asset_radio

	label variable b2_assetnum_radio "How many foam matresses?"
	note b2_assetnum_radio: "How many foam matresses?"

	label variable b2_assetnum19_radio "How many have been bought since January 2019 ?"
	note b2_assetnum19_radio: "How many have been bought since January 2019 ?"

	label variable b2_asset_cellphone "B.2.1.10. Regular cellphone"
	note b2_asset_cellphone: "B.2.1.10. Regular cellphone"
	label define b2_asset_cellphone 1 "Yes" 0 "No"
	label values b2_asset_cellphone b2_asset_cellphone

	label variable b2_assetnum_cellphone "How many regular cellphone?"
	note b2_assetnum_cellphone: "How many regular cellphone?"

	label variable b2_assetnum19_cellphone "How many have been bought since January 2019 ?"
	note b2_assetnum19_cellphone: "How many have been bought since January 2019 ?"

	label variable b2_asset_smartphone "B.2.1.11. Smart phone (iPhone, Samsung, Huawei, etc.)"
	note b2_asset_smartphone: "B.2.1.11. Smart phone (iPhone, Samsung, Huawei, etc.)"
	label define b2_asset_smartphone 1 "Yes" 0 "No"
	label values b2_asset_smartphone b2_asset_smartphone

	label variable b2_assetnum_smartphone "How many smartphone?"
	note b2_assetnum_smartphone: "How many smartphone?"

	label variable b2_assetnum19_smartphone "How many have been bought since January 2019 ?"
	note b2_assetnum19_smartphone: "How many have been bought since January 2019 ?"

	label variable b2_asset_refrigerator "B.2.1.13. Refrigerator"
	note b2_asset_refrigerator: "B.2.1.13. Refrigerator"
	label define b2_asset_refrigerator 1 "Yes" 0 "No"
	label values b2_asset_refrigerator b2_asset_refrigerator

	label variable b2_assetnum_refrigerator "How many refrigerator ?"
	note b2_assetnum_refrigerator: "How many refrigerator ?"

	label variable b2_assetnum19_refrigerator "How many have been bought since January 2019 ?"
	note b2_assetnum19_refrigerator: "How many have been bought since January 2019 ?"

	label variable b2_asset_bicycles "B.2.1.14. bicycles"
	note b2_asset_bicycles: "B.2.1.14. bicycles"
	label define b2_asset_bicycles 1 "Yes" 0 "No"
	label values b2_asset_bicycles b2_asset_bicycles

	label variable b2_assetnum_bicycles "How many bicycles ?"
	note b2_assetnum_bicycles: "How many bicycles ?"

	label variable b2_assetnum19_bicycles "How many have been bought since January 2019 ?"
	note b2_assetnum19_bicycles: "How many have been bought since January 2019 ?"

	label variable b2_asset_moto "B.2.1.15. motorcycle or scooter"
	note b2_asset_moto: "B.2.1.15. motorcycle or scooter"
	label define b2_asset_moto 1 "Yes" 0 "No"
	label values b2_asset_moto b2_asset_moto

	label variable b2_assetnum_moto "How many motorcycle or scooter ?"
	note b2_assetnum_moto: "How many motorcycle or scooter ?"

	label variable b2_assetnum19_moto "How many have been bought since January 2019 ?"
	note b2_assetnum19_moto: "How many have been bought since January 2019 ?"

	label variable b2_asset_chaise "B.2.1.16. Chair / Bench"
	note b2_asset_chaise: "B.2.1.16. Chair / Bench"
	label define b2_asset_chaise 1 "Yes" 0 "No"
	label values b2_asset_chaise b2_asset_chaise

	label variable b2_assetnum_chaise "How many chair, bench ?"
	note b2_assetnum_chaise: "How many chair, bench ?"

	label variable b2_assetnum19_chaise "How many have been bought since January 2019 ?"
	note b2_assetnum19_chaise: "How many have been bought since January 2019 ?"

	label variable b2_asset_tablette "B.2.1.19. Tablets"
	note b2_asset_tablette: "B.2.1.19. Tablets"
	label define b2_asset_tablette 1 "Yes" 0 "No"
	label values b2_asset_tablette b2_asset_tablette

	label variable b2_assetnum_tablette "How many tablets ?"
	note b2_assetnum_tablette: "How many tablets ?"

	label variable b2_assetnum19_tablette "How many have been bought since January 2019 ?"
	note b2_assetnum19_tablette: "How many have been bought since January 2019 ?"

	label variable b2_asset_vent "B.2.1.20. Fan"
	note b2_asset_vent: "B.2.1.20. Fan"
	label define b2_asset_vent 1 "Yes" 0 "No"
	label values b2_asset_vent b2_asset_vent

	label variable b2_assetnum_vent "How many fan ?"
	note b2_assetnum_vent: "How many fan ?"

	label variable b2_assetnum19_vent "How many have been bought since January 2019 ?"
	note b2_assetnum19_vent: "How many have been bought since January 2019 ?"

	label variable b2_asset_clim "B.2.1.21. AC unit"
	note b2_asset_clim: "B.2.1.21. AC unit"
	label define b2_asset_clim 1 "Yes" 0 "No"
	label values b2_asset_clim b2_asset_clim

	label variable b2_assetnum_clim "How many AC unit ?"
	note b2_assetnum_clim: "How many AC unit ?"

	label variable b2_assetnum19_clim "How many have been bought since January 2019 ?"
	note b2_assetnum19_clim: "How many have been bought since January 2019 ?"

	label variable b2_asset_gr "B.2.1.22. Generator"
	note b2_asset_gr: "B.2.1.22. Generator"
	label define b2_asset_gr 1 "Yes" 0 "No"
	label values b2_asset_gr b2_asset_gr

	label variable b2_assetnum_gr "How many generator ?"
	note b2_assetnum_gr: "How many generator ?"

	label variable b2_assetnum19_gr "How many have been bought since January 2019 ?"
	note b2_assetnum19_gr: "How many have been bought since January 2019 ?"

	label variable b2_asset_nat "B.2.1.23. Natte"
	note b2_asset_nat: "B.2.1.23. Natte"
	label define b2_asset_nat 1 "Yes" 0 "No"
	label values b2_asset_nat b2_asset_nat

	label variable b2_assetnum_nat "How many natte ?"
	note b2_assetnum_nat: "How many natte ?"

	label variable b2_assetnum19_nat "How many have been bought since January 2019 ?"
	note b2_assetnum19_nat: "How many have been bought since January 2019 ?"

	label variable b2_asset_poch "B.2.1.24. Pocket / head lamp"
	note b2_asset_poch: "B.2.1.24. Pocket / head lamp"
	label define b2_asset_poch 1 "Yes" 0 "No"
	label values b2_asset_poch b2_asset_poch

	label variable b2_assetnum_poch "How many lamp ?"
	note b2_assetnum_poch: "How many lamp ?"

	label variable b2_assetnum19_poch "How many have been bought since January 2019 ?"
	note b2_assetnum19_poch: "How many have been bought since January 2019 ?"

	label variable b2_asset_table "B.2.1.25. Table"
	note b2_asset_table: "B.2.1.25. Table"
	label define b2_asset_table 1 "Yes" 0 "No"
	label values b2_asset_table b2_asset_table

	label variable b2_assetnum_table "How many table ?"
	note b2_assetnum_table: "How many table ?"

	label variable b2_assetnum19_table "How many have been bought since January 2019 ?"
	note b2_assetnum19_table: "How many have been bought since January 2019 ?"

	label variable b2_asset_salon "B.2.1.26. Living room"
	note b2_asset_salon: "B.2.1.26. Living room"
	label define b2_asset_salon 1 "Yes" 0 "No"
	label values b2_asset_salon b2_asset_salon

	label variable b2_assetnum_salon "How many living room ?"
	note b2_assetnum_salon: "How many living room ?"

	label variable b2_assetnum19_salon "How many have been bought since January 2019 ?"
	note b2_assetnum19_salon: "How many have been bought since January 2019 ?"

	label variable b2_asset_bibli "B.2.1.27. Library"
	note b2_asset_bibli: "B.2.1.27. Library"
	label define b2_asset_bibli 1 "Yes" 0 "No"
	label values b2_asset_bibli b2_asset_bibli

	label variable b2_assetnum_bibli "How many library ?"
	note b2_assetnum_bibli: "How many library ?"

	label variable b2_assetnum19_bibli "How many have been bought since January 2019 ?"
	note b2_assetnum19_bibli: "How many have been bought since January 2019 ?"

	label variable b2_asset_arm "B.2.1.29. Dresser"
	note b2_asset_arm: "B.2.1.29. Dresser"
	label define b2_asset_arm 1 "Yes" 0 "No"
	label values b2_asset_arm b2_asset_arm

	label variable b2_assetnum_arm "How many dresser?"
	note b2_assetnum_arm: "How many dresser?"

	label variable b2_assetnum19_arm "How many have been bought since January 2019 ?"
	note b2_assetnum19_arm: "How many have been bought since January 2019 ?"

	label variable b2_asset_ferer "B.2.1.31. Electric iron"
	note b2_asset_ferer: "B.2.1.31. Electric iron"
	label define b2_asset_ferer 1 "Yes" 0 "No"
	label values b2_asset_ferer b2_asset_ferer

	label variable b2_assetnum_ferer "How many electric iron?"
	note b2_assetnum_ferer: "How many electric iron?"

	label variable b2_assetnum19_ferer "How many have been bought since January 2019 ?"
	note b2_assetnum19_ferer: "How many have been bought since January 2019 ?"

	label variable b2_asset_mach "B.2.1.34. Sewing machine"
	note b2_asset_mach: "B.2.1.34. Sewing machine"
	label define b2_asset_mach 1 "Yes" 0 "No"
	label values b2_asset_mach b2_asset_mach

	label variable b2_assetnum_mach "How many sewing machine?"
	note b2_assetnum_mach: "How many sewing machine?"

	label variable b2_assetnum19_mach "How many have been bought since January 2019 ?"
	note b2_assetnum19_mach: "How many have been bought since January 2019 ?"

	label variable b2_asset_dec "B.2.1.35. TV Box"
	note b2_asset_dec: "B.2.1.35. TV Box"
	label define b2_asset_dec 1 "Yes" 0 "No"
	label values b2_asset_dec b2_asset_dec

	label variable b2_assetnum_dec "How many tv box?"
	note b2_assetnum_dec: "How many tv box?"

	label variable b2_assetnum19_dec "How many have been bought since January 2019 ?"
	note b2_assetnum19_dec: "How many have been bought since January 2019 ?"

	label variable b2_hhhouse "B.2.2.0 What are the living condition of your household today ?"
	note b2_hhhouse: "B.2.2.0 What are the living condition of your household today ?"
	label define b2_hhhouse 1 "1. We own house / apartment" 2 "2. We rent a house / apartment" 3 "3. We live for free in a house / apartment that belongs to a family or friend" 99 "99. Other"
	label values b2_hhhouse b2_hhhouse

	label variable b2_hhhouse_other "B.2.2.1.0 Specify other"
	note b2_hhhouse_other: "B.2.2.1.0 Specify other"

	label variable b2_hhhouses "B.2.2.0 What were the living condition of your household before January 2019 ?"
	note b2_hhhouses: "B.2.2.0 What were the living condition of your household before January 2019 ?"
	label define b2_hhhouses 1 "1. We own house / apartment" 2 "2. We rent a house / apartment" 3 "3. We live for free in a house / apartment that belongs to a family or friend" 99 "99. Other"
	label values b2_hhhouses b2_hhhouses

	label variable b2_hhhouse_others "B.2.2.1.1. Specify other"
	note b2_hhhouse_others: "B.2.2.1.1. Specify other"

	label variable b2_title_house "Does the household chief owns a land title for this house / apartment"
	note b2_title_house: "Does the household chief owns a land title for this house / apartment"
	label define b2_title_house 1 "Yes" 0 "No"
	label values b2_title_house b2_title_house

	label variable b2_listing_fixes_note "B.2.3. In the last year, from January 2019 to today has your household…?"
	note b2_listing_fixes_note: "B.2.3. In the last year, from January 2019 to today has your household…?"
	label define b2_listing_fixes_note 1 "Yes" 0 "No"
	label values b2_listing_fixes_note b2_listing_fixes_note

	label variable b2_move "Moved and now live in a different place ?"
	note b2_move: "Moved and now live in a different place ?"
	label define b2_move 1 "Yes" 0 "No"
	label values b2_move b2_move

	label variable b2_newhouse "Bought or built a new house?"
	note b2_newhouse: "Bought or built a new house?"
	label define b2_newhouse 1 "Yes" 0 "No"
	label values b2_newhouse b2_newhouse

	label variable b2_addrooms "added rooms or made major repairs to the house or apartment?"
	note b2_addrooms: "added rooms or made major repairs to the house or apartment?"
	label define b2_addrooms 1 "Yes" 0 "No"
	label values b2_addrooms b2_addrooms

	label variable b2_minorrepairs "made minor repairs to the house or apartment?"
	note b2_minorrepairs: "made minor repairs to the house or apartment?"
	label define b2_minorrepairs 1 "Yes" 0 "No"
	label values b2_minorrepairs b2_minorrepairs

	label variable b2_otherinvest "made other investments to house or property?"
	note b2_otherinvest: "made other investments to house or property?"
	label define b2_otherinvest 1 "Yes" 0 "No"
	label values b2_otherinvest b2_otherinvest

	label variable b3_rent_num "B3.1.0 Rent in the last month (in Dinars) (If the respondent is the homeowner, a"
	note b3_rent_num: "B3.1.0 Rent in the last month (in Dinars) (If the respondent is the homeowner, ask how much rent would cost in an equivalent location"

	label variable b3_fooddrink "Food/drinks at home"
	note b3_fooddrink: "Food/drinks at home"
	label define b3_fooddrink 1 "Yes" 0 "No"
	label values b3_fooddrink b3_fooddrink

	label variable b3_fooddrink_num "Food/drinks at home"
	note b3_fooddrink_num: "Food/drinks at home"

	label variable b3_medical "Medical expenses"
	note b3_medical: "Medical expenses"
	label define b3_medical 1 "Yes" 0 "No"
	label values b3_medical b3_medical

	label variable b3_medical_num "Medical expenses"
	note b3_medical_num: "Medical expenses"

	label variable b3_leisure "Leisure (movies or food in a restaurant/shisha and tea, etc.)"
	note b3_leisure: "Leisure (movies or food in a restaurant/shisha and tea, etc.)"
	label define b3_leisure 1 "Yes" 0 "No"
	label values b3_leisure b3_leisure

	label variable b3_leisure_num "Leisure (movies or food in a restaurant/shisha and tea, etc.)"
	note b3_leisure_num: "Leisure (movies or food in a restaurant/shisha and tea, etc.)"

	label variable b3_clothes "Clothes / decorations"
	note b3_clothes: "Clothes / decorations"
	label define b3_clothes 1 "Yes" 0 "No"
	label values b3_clothes b3_clothes

	label variable b3_clothes_num "Clothes / decorations"
	note b3_clothes_num: "Clothes / decorations"

	label variable b3_publictransport "a fee for transportation (public transportation and fuel, but not fuel for the h"
	note b3_publictransport: "a fee for transportation (public transportation and fuel, but not fuel for the household's vehicle )"
	label define b3_publictransport 1 "Yes" 0 "No"
	label values b3_publictransport b3_publictransport

	label variable b3_publictransport_num "a fee for transportation (public transportation and fuel, but not fuel for the h"
	note b3_publictransport_num: "a fee for transportation (public transportation and fuel, but not fuel for the household's vehicle )"

	label variable b3_elec_gas_water "Electricity, gas, gas, water, firewood, in the last month (in Dinars)"
	note b3_elec_gas_water: "Electricity, gas, gas, water, firewood, in the last month (in Dinars)"
	label define b3_elec_gas_water 1 "Yes" 0 "No"
	label values b3_elec_gas_water b3_elec_gas_water

	label variable b3_elec_gas_water_num "Electricity, gas, gas, water, firewood, in the last month (in Dinars)"
	note b3_elec_gas_water_num: "Electricity, gas, gas, water, firewood, in the last month (in Dinars)"

	label variable b3_landline_phone "Landline, mobile phone calls and internet in the last month (in Dinars)"
	note b3_landline_phone: "Landline, mobile phone calls and internet in the last month (in Dinars)"
	label define b3_landline_phone 1 "Yes" 0 "No"
	label values b3_landline_phone b3_landline_phone

	label variable b3_landline_phone_num "Landline, mobile phone calls and internet in the last month (in Dinars)"
	note b3_landline_phone_num: "Landline, mobile phone calls and internet in the last month (in Dinars)"

	label variable b3_soap "Soap, detergent, cosmetics, in the last month (in Dinars)"
	note b3_soap: "Soap, detergent, cosmetics, in the last month (in Dinars)"
	label define b3_soap 1 "Yes" 0 "No"
	label values b3_soap b3_soap

	label variable b3_soap_num "Soap, detergent, cosmetics, in the last month (in Dinars)"
	note b3_soap_num: "Soap, detergent, cosmetics, in the last month (in Dinars)"

	label variable b3_otherservice "Other services (hairdresser, veterinarian, repairman) in the last month (in Dina"
	note b3_otherservice: "Other services (hairdresser, veterinarian, repairman) in the last month (in Dinars)"
	label define b3_otherservice 1 "Yes" 0 "No"
	label values b3_otherservice b3_otherservice

	label variable b3_service_other "Please specify other"
	note b3_service_other: "Please specify other"

	label variable b3_otherservice_num "\${b3_service_other}"
	note b3_otherservice_num: "\${b3_service_other}"

	label variable b3_medicalexp "B.3.2. In the last six months, did your household incur medical expenses?"
	note b3_medicalexp: "B.3.2. In the last six months, did your household incur medical expenses?"
	label define b3_medicalexp 1 "Yes" 0 "No"
	label values b3_medicalexp b3_medicalexp

	label variable b3_medicalexpnum "B.3.2.1 What was the total amount (in Dinars) of the medical expenses incurred i"
	note b3_medicalexpnum: "B.3.2.1 What was the total amount (in Dinars) of the medical expenses incurred in the last 6 months?"

	label variable b3_chool_exp "B.3.3. In the last six months, did your household incur school-related expenses?"
	note b3_chool_exp: "B.3.3. In the last six months, did your household incur school-related expenses?"
	label define b3_chool_exp 1 "Yes" 0 "No"
	label values b3_chool_exp b3_chool_exp

	label variable b3_chool_expnum "B.3.3.1 What was the total amount (in Dinars) of school-related expenses incurre"
	note b3_chool_expnum: "B.3.3.1 What was the total amount (in Dinars) of school-related expenses incurred in the last 6 months?"

	label variable b3_foodorigin1 "B.3.4. In general, where does MOST of the food your household consumes come from"
	note b3_foodorigin1: "B.3.4. In general, where does MOST of the food your household consumes come from? Source1"
	label define b3_foodorigin1 1 "1. Field of the househol" 2 "2. bought at the market" 3 "3. gifts for friends / other households" 4 "4. family" 5 "5. social assistance/ charity" 99 "99. other" 0 "Non applicable (pas d'autre sources)"
	label values b3_foodorigin1 b3_foodorigin1

	label variable b3_foodorigin_other1 "specify other"
	note b3_foodorigin_other1: "specify other"

	label variable b3_foodorigin2 "B.3.4. In general, where does MOST of the food your household consumes come from"
	note b3_foodorigin2: "B.3.4. In general, where does MOST of the food your household consumes come from? Source 2"
	label define b3_foodorigin2 1 "1. Field of the househol" 2 "2. bought at the market" 3 "3. gifts for friends / other households" 4 "4. family" 5 "5. social assistance/ charity" 99 "99. other" 0 "Non applicable (pas d'autre sources)"
	label values b3_foodorigin2 b3_foodorigin2

	label variable b3_foodorigin_other2 "specify other"
	note b3_foodorigin_other2: "specify other"

	label variable b3_mealsnumberyest "B.3.9. Yesterday, how many meals did members of this household eat?"
	note b3_mealsnumberyest: "B.3.9. Yesterday, how many meals did members of this household eat?"

	label variable b3_mealsnumber7 "B.3.10. Over the last 7 days, how many days your households eat few meals than \"
	note b3_mealsnumber7: "B.3.10. Over the last 7 days, how many days your households eat few meals than \${b3_mealsnumberyest} meals?"

	label variable b3_foodtype "I now will enumerate common food items consumed in Tunisia, and you will let me "
	note b3_foodtype: "I now will enumerate common food items consumed in Tunisia, and you will let me kbow if you happened to consume them in the last 7 days."

	label variable houla_huile_2019 "Since 2019, did your HH done the houla for olive oil ?"
	note houla_huile_2019: "Since 2019, did your HH done the houla for olive oil ?"
	label define houla_huile_2019 1 "Yes" 0 "No"
	label values houla_huile_2019 houla_huile_2019

	label variable houla_huile_v_2019 "how much did the household spend in olive oil houla since January 2019 ?"
	note houla_huile_v_2019: "how much did the household spend in olive oil houla since January 2019 ?"

	label variable houla_ble_2019 "Since January 2019, did your household did the houla for wheat product (semolina"
	note houla_ble_2019: "Since January 2019, did your household did the houla for wheat product (semolina, flour) ?"
	label define houla_ble_2019 1 "Yes" 0 "No"
	label values houla_ble_2019 houla_ble_2019

	label variable houla_ble_v_2019 "How much did the household spend in wheat product houla since January 2019 ?"
	note houla_ble_v_2019: "How much did the household spend in wheat product houla since January 2019 ?"

	label variable houla_oth_2019 "Since January 2019, did your household did the houla for other thing than olive "
	note houla_oth_2019: "Since January 2019, did your household did the houla for other thing than olive oir or wheat product ?"
	label define houla_oth_2019 1 "Yes" 0 "No"
	label values houla_oth_2019 houla_oth_2019

	label variable houla_oth_v_2019 "How much did you household spend in other product houla since January 2019 ?"
	note houla_oth_v_2019: "How much did you household spend in other product houla since January 2019 ?"

	label variable b3_receivemoneycity "B.3.5. Since January 2019, have members of this household received money in cash"
	note b3_receivemoneycity: "B.3.5. Since January 2019, have members of this household received money in cash from friends or family members who live in this city?"
	label define b3_receivemoneycity 1 "Yes" 0 "No" -99 "Don't know" -97 "Refuse to say"
	label values b3_receivemoneycity b3_receivemoneycity

	label variable b3_receivemoneycity_num "B.3.5.1. What was the total value of the assistance that the household received "
	note b3_receivemoneycity_num: "B.3.5.1. What was the total value of the assistance that the household received (Dinars)?"

	label variable b3_receivemoneydrc "B.3.6. Since January 2019 have members of this household received money from fri"
	note b3_receivemoneydrc: "B.3.6. Since January 2019 have members of this household received money from friends or family members who live outside this city, but in the Tunisia?"
	label define b3_receivemoneydrc 1 "Yes" 0 "No" -99 "Don't know" -97 "Refuse to say"
	label values b3_receivemoneydrc b3_receivemoneydrc

	label variable b3_receivemoneydrc_num "B.3.6.1. What was the total value of the assistance that the household received "
	note b3_receivemoneydrc_num: "B.3.6.1. What was the total value of the assistance that the household received (in Dinars )?"

	label variable b3_receivemoneyabroad_19 "B.3.7. Since January 2019, have the members of this household received money fro"
	note b3_receivemoneyabroad_19: "B.3.7. Since January 2019, have the members of this household received money from friends or family members who live abroad?"
	label define b3_receivemoneyabroad_19 1 "Yes" 0 "No" -99 "Don't know" -97 "Refuse to say"
	label values b3_receivemoneyabroad_19 b3_receivemoneyabroad_19

	label variable b3_receivemoneyabroad_num_19 "B.3.7.1. What was the total value of the assistance that the household received "
	note b3_receivemoneyabroad_num_19: "B.3.7.1. What was the total value of the assistance that the household received since Janaury 2019?"

	label variable b3_sendmoney_19 "B.3.8. Since January 2019 2019, have you or any other member of this household s"
	note b3_sendmoney_19: "B.3.8. Since January 2019 2019, have you or any other member of this household sent money to a friend or family member not living here?"
	label define b3_sendmoney_19 1 "Yes" 0 "No" -99 "Don't know" -97 "Refuse to say"
	label values b3_sendmoney_19 b3_sendmoney_19

	label variable b3_sendmoney_num_19 "B.3.8.1. What was the total value of the assistance that the household send sinc"
	note b3_sendmoney_num_19: "B.3.8.1. What was the total value of the assistance that the household send since Janaury 2019 ?"

	label variable b4_sufferevent "B.4.1. Over the past 2 years, did your household suffer an event that led to a l"
	note b4_sufferevent: "B.4.1. Over the past 2 years, did your household suffer an event that led to a loss of income / cash?"

	label variable b4_sufferevent_other "Specify other"
	note b4_sufferevent_other: "Specify other"

	label variable b4_facesufferevent "B.4.1.1. What did your household do to meet its needs?"
	note b4_facesufferevent: "B.4.1.1. What did your household do to meet its needs?"

	label variable b4_facesufferevent_other "specify other"
	note b4_facesufferevent_other: "specify other"

	label variable b4_ngohelp "B 4.2. Since January 2019, did you or a household member receive money, food or "
	note b4_ngohelp: "B 4.2. Since January 2019, did you or a household member receive money, food or other social assistance THAT IS NOT CASH FOR WORK from the government or NGOs?"
	label define b4_ngohelp 1 "Yes" 0 "No"
	label values b4_ngohelp b4_ngohelp

	label variable b4_programfood "Was it a program of: Food / food products"
	note b4_programfood: "Was it a program of: Food / food products"
	label define b4_programfood 1 "Yes" 0 "No"
	label values b4_programfood b4_programfood

	label variable b4_programfood_hm "Food / food products for whom ?"
	note b4_programfood_hm: "Food / food products for whom ?"
	label define b4_programfood_hm 0 "0. Specific members" 1 "1. All the household"
	label values b4_programfood_hm b4_programfood_hm

	label variable b4_programfood_am "Food / food products amount ?"
	note b4_programfood_am: "Food / food products amount ?"

	label variable b4_programsorder "Was it a program of: Voucher (for cash or food)"
	note b4_programsorder: "Was it a program of: Voucher (for cash or food)"
	label define b4_programsorder 1 "Yes" 0 "No"
	label values b4_programsorder b4_programsorder

	label variable b4_programsorder_hm "Voucher (for cash or food)for whom ?"
	note b4_programsorder_hm: "Voucher (for cash or food)for whom ?"
	label define b4_programsorder_hm 0 "0. Specific members" 1 "1. All the household"
	label values b4_programsorder_hm b4_programsorder_hm

	label variable b4_programsorder_am "Voucher (for cash or food) amount ?"
	note b4_programsorder_am: "Voucher (for cash or food) amount ?"

	label variable b4_programschool "Was it a program of: School feeding program"
	note b4_programschool: "Was it a program of: School feeding program"
	label define b4_programschool 1 "Yes" 0 "No"
	label values b4_programschool b4_programschool

	label variable b4_programschool_hm "School feeding program for whom ?"
	note b4_programschool_hm: "School feeding program for whom ?"
	label define b4_programschool_hm 0 "0. Specific members" 1 "1. All the household"
	label values b4_programschool_hm b4_programschool_hm

	label variable b4_programschool_am "School feeding program amount ?"
	note b4_programschool_am: "School feeding program amount ?"

	label variable b4_programtransf "Was it a program of: Transfer direct money"
	note b4_programtransf: "Was it a program of: Transfer direct money"
	label define b4_programtransf 1 "Yes" 0 "No"
	label values b4_programtransf b4_programtransf

	label variable b4_programtransf_hm "Transfer direct money for whom ?"
	note b4_programtransf_hm: "Transfer direct money for whom ?"
	label define b4_programtransf_hm 0 "0. Specific members" 1 "1. All the household"
	label values b4_programtransf_hm b4_programtransf_hm

	label variable b4_programtransf_am "Transfer direct money amount ?"
	note b4_programtransf_am: "Transfer direct money amount ?"

	label variable b4_programother "Was it another program ?"
	note b4_programother: "Was it another program ?"
	label define b4_programother 1 "Yes" 0 "No"
	label values b4_programother b4_programother

	label variable b4_programother_other "specify other"
	note b4_programother_other: "specify other"

	label variable b4_programother_other_hm "\${b4_programother} form ?"
	note b4_programother_other_hm: "\${b4_programother} form ?"
	label define b4_programother_other_hm 0 "0. Specific members" 1 "1. All the household"
	label values b4_programother_other_hm b4_programother_other_hm

	label variable b4_programother_other_am "\${b4_programother} amount ?"
	note b4_programother_other_am: "\${b4_programother} amount ?"

	label variable b4_hhecocomparehh "B 4.6. How are the economic conditions of your household compared to situation b"
	note b4_hhecocomparehh: "B 4.6. How are the economic conditions of your household compared to situation before January 2019?"
	label define b4_hhecocomparehh 1 "Pires" 2 "Egale" 3 "Meilleures" -97 "Refuse to say" -98 "Non applicable" -99 "Don't know"
	label values b4_hhecocomparehh b4_hhecocomparehh

	label variable b4_scaleownhh "B.4.7. Please imagine a ladder with 5 stages, the poorest of the City/avenue is "
	note b4_scaleownhh: "B.4.7. Please imagine a ladder with 5 stages, the poorest of the City/avenue is the lowest (the first stage) and the richest people of this City/avenue avenue is on the top fifth stage). On what stage does your household stand today?"

	label variable b4_scaleownhh12 "B.4.8. On what stage did your household stand before January 2019?"
	note b4_scaleownhh12: "B.4.8. On what stage did your household stand before January 2019?"

	label variable c1_job_iga "C.1.1. Do you currently have a job or an income-generating activity?"
	note c1_job_iga: "C.1.1. Do you currently have a job or an income-generating activity?"
	label define c1_job_iga 1 "Yes" 0 "No"
	label values c1_job_iga c1_job_iga

	label variable c1_job_covid "Did you had an income generating activity before the COVID-19 crisis hit Tunisia"
	note c1_job_covid: "Did you had an income generating activity before the COVID-19 crisis hit Tunisia (ie in March 2020)"
	label define c1_job_covid 1 "Yes" 0 "No"
	label values c1_job_covid c1_job_covid

	label variable c1_job_covidlost "Did you loose your income generating activity because of the COVID-19 crisis ?"
	note c1_job_covidlost: "Did you loose your income generating activity because of the COVID-19 crisis ?"
	label define c1_job_covidlost 1 "Yes" 0 "No"
	label values c1_job_covidlost c1_job_covidlost

	label variable c1_days_nowork "C.1.2. How long have you been without employment or an income generating activit"
	note c1_days_nowork: "C.1.2. How long have you been without employment or an income generating activity?"

	label variable c1_daysnoworkunit "Indicate the unit"
	note c1_daysnoworkunit: "Indicate the unit"
	label define c1_daysnoworkunit 1 "Jours" 2 "Mois" 3 "Années"
	label values c1_daysnoworkunit c1_daysnoworkunit

	label variable c1_activsearchwork "C.1.3a. Have you actively searched for paid work in the last 30 days?"
	note c1_activsearchwork: "C.1.3a. Have you actively searched for paid work in the last 30 days?"
	label define c1_activsearchwork 1 "Yes" 0 "No"
	label values c1_activsearchwork c1_activsearchwork

	label variable c1_activsearchwork_6m "Have you actively searched for paid work in the last 6 months?"
	note c1_activsearchwork_6m: "Have you actively searched for paid work in the last 6 months?"
	label define c1_activsearchwork_6m 1 "Yes" 0 "No"
	label values c1_activsearchwork_6m c1_activsearchwork_6m

	label variable c1_activsearchwork_12m "Have you actively searched for paid work in the last 12 months?"
	note c1_activsearchwork_12m: "Have you actively searched for paid work in the last 12 months?"
	label define c1_activsearchwork_12m 1 "Yes" 0 "No"
	label values c1_activsearchwork_12m c1_activsearchwork_12m

	label variable c1_activsearchworkn "C.13b Why haven’t you looked for a job in the last 30 days?"
	note c1_activsearchworkn: "C.13b Why haven’t you looked for a job in the last 30 days?"
	label define c1_activsearchworkn 1 "1. Still in school or training" 2 "2. Lack of better job opportunity" 3 "3. Maladie ou handicap" 4 "4. Pas besoin de travailler" 5 "5. Occupation du ménage" 6 "6. COVID 19" 99 "Autre"
	label values c1_activsearchworkn c1_activsearchworkn

	label variable c1_activsearchworkn_6m "Why haven’t you looked for a job in the last 6 month?"
	note c1_activsearchworkn_6m: "Why haven’t you looked for a job in the last 6 month?"
	label define c1_activsearchworkn_6m 1 "1. Still in school or training" 2 "2. Lack of better job opportunity" 3 "3. Maladie ou handicap" 4 "4. Pas besoin de travailler" 5 "5. Occupation du ménage" 6 "6. COVID 19" 99 "Autre"
	label values c1_activsearchworkn_6m c1_activsearchworkn_6m

	label variable c1_activsearchworkn_12m "Why haven’t you looked for a job in the last 12 months?"
	note c1_activsearchworkn_12m: "Why haven’t you looked for a job in the last 12 months?"
	label define c1_activsearchworkn_12m 1 "1. Still in school or training" 2 "2. Lack of better job opportunity" 3 "3. Maladie ou handicap" 4 "4. Pas besoin de travailler" 5 "5. Occupation du ménage" 6 "6. COVID 19" 99 "Autre"
	label values c1_activsearchworkn_12m c1_activsearchworkn_12m

	label variable c1_activsearchworkn_other "C.13b specify"
	note c1_activsearchworkn_other: "C.13b specify"

	label variable c1_descprimjob "C.1.6. How would you describe your primary job activity?"
	note c1_descprimjob: "C.1.6. How would you describe your primary job activity?"
	label define c1_descprimjob 1 "1. Self-employment" 2 "2. Waged employment" 99 "Other"
	label values c1_descprimjob c1_descprimjob

	label variable c1_employstatus_other "C.1.4. specify"
	note c1_employstatus_other: "C.1.4. specify"

	label variable c1_corebusiness "C.1.5. What is your core business or sphere that you work in?"
	note c1_corebusiness: "C.1.5. What is your core business or sphere that you work in?"
	label define c1_corebusiness 1 "1. Housework/homemaker" 2 "2. Farmer/breeder" 3 "3. Healthcare professional (e.g., nurse, doctor, lobbyist, etc.)" 4 "4. Finance professional (e.g., banker, accountant, etc.)" 5 "5. Government/civil service" 6 "6. Media (audio, visual, print, electronic)" 7 "7. Education sector (e.g., teach, professor, principal, etc.)" 8 "8. Construction worker (e.g., carpenter, masonry, etc.)" 9 "9. NGO" 10 "10. Religious work" 11 "11.Commerce et petit commerce" 12 "12. Autre travail qualifié" 13 "13. Menuiserie, Soudure, couture, mecanique" 14 "14. Transport (transport en commun, taxi moto)" 15 "15 Retired" 99 "99. Autre travail non qualifié"
	label values c1_corebusiness c1_corebusiness

	label variable c1_corebusiness_othe "C.1.5. specify"
	note c1_corebusiness_othe: "C.1.5. specify"

	label variable c1_corebusiness_other "C.1.5. specify"
	note c1_corebusiness_other: "C.1.5. specify"

	label variable c1_timeprimjob "C.1.7. How long (in months) have you been in this profession or business (\${c1_"
	note c1_timeprimjob: "C.1.7. How long (in months) have you been in this profession or business (\${c1_descprimjocal})?"

	label variable c1_jprimjoblicense "C.1.8. Is it formally registered with the government (i.e., do you obtain proper"
	note c1_jprimjoblicense: "C.1.8. Is it formally registered with the government (i.e., do you obtain proper business license to operate?)"
	label define c1_jprimjoblicense 1 "Yes" 0 "No"
	label values c1_jprimjoblicense c1_jprimjoblicense

	label variable c1_hoursprimjob "C.1.9 How many hours do you spend at your main job during a typical week?"
	note c1_hoursprimjob: "C.1.9 How many hours do you spend at your main job during a typical week?"

	label variable c1_daysprimjob "C.1.10. How many days do you spend at your main job during a typical month?"
	note c1_daysprimjob: "C.1.10. How many days do you spend at your main job during a typical month?"

	label variable c1_wageprimjob "C.1.13. In the past 30 days, what was your total wage (total income) from the pr"
	note c1_wageprimjob: "C.1.13. In the past 30 days, what was your total wage (total income) from the primary job?"

	label variable business_newemployee "C.1.27.How many new employees (if any) have you hired in the last 12 months?"
	note business_newemployee: "C.1.27.How many new employees (if any) have you hired in the last 12 months?"

	label variable business_employee "How many employees work in your business ?"
	note business_employee: "How many employees work in your business ?"

	label variable business_supply "How many suppliers do you have ?"
	note business_supply: "How many suppliers do you have ?"

	label variable business_profit "What is your monthly profit ?"
	note business_profit: "What is your monthly profit ?"

	label variable business_hours "How many hours per day do you usually spend at your business per week"
	note business_hours: "How many hours per day do you usually spend at your business per week"

	label variable business_partner "Do you have any business partner?"
	note business_partner: "Do you have any business partner?"
	label define business_partner 1 "Yes" 0 "No"
	label values business_partner business_partner

	label variable business_partner_f "How many female business partner"
	note business_partner_f: "How many female business partner"

	label variable business_partner_m "How many male business partner"
	note business_partner_m: "How many male business partner"

	label variable business_q6 "Have you register in a notebook expenses and profit related to the activity of t"
	note business_q6: "Have you register in a notebook expenses and profit related to the activity of this business ?"
	label define business_q6 1 "Yes" 0 "No"
	label values business_q6 business_q6

	label variable business_q7 "Is it a registered business ?"
	note business_q7: "Is it a registered business ?"
	label define business_q7 1 "Yes" 0 "No"
	label values business_q7 business_q7

	label variable business_q8 "Do you pay taxes for your business ?"
	note business_q8: "Do you pay taxes for your business ?"
	label define business_q8 1 "Yes" 0 "No"
	label values business_q8 business_q8

	label variable business_q9 "How much did you paid last year ?"
	note business_q9: "How much did you paid last year ?"
	label define business_q9 1 "Yes" 0 "No"
	label values business_q9 business_q9

	label variable c1_secondjob "C.1.16. Do you have any other secondary job or income-generating activity, other"
	note c1_secondjob: "C.1.16. Do you have any other secondary job or income-generating activity, other than the one we just talked about?"
	label define c1_secondjob 1 "Yes" 0 "No"
	label values c1_secondjob c1_secondjob

	label variable c1_descsecjob "C.1.17. How would you describe your secondary job activity?"
	note c1_descsecjob: "C.1.17. How would you describe your secondary job activity?"
	label define c1_descsecjob 1 "1. Self-employment" 2 "2. Waged employment" 99 "Other"
	label values c1_descsecjob c1_descsecjob

	label variable c1_timesecjob "C.1.18. How long (in months or years) have you been in this profession or busine"
	note c1_timesecjob: "C.1.18. How long (in months or years) have you been in this profession or business?"

	label variable c1_timesecjob_unit "C.1.18. Unit"
	note c1_timesecjob_unit: "C.1.18. Unit"
	label define c1_timesecjob_unit 1 "Jours" 2 "Mois" 3 "Années"
	label values c1_timesecjob_unit c1_timesecjob_unit

	label variable c1_jsecjoblicense "C.1.19. Is it properly registered with the government (i.e., do you obtain prope"
	note c1_jsecjoblicense: "C.1.19. Is it properly registered with the government (i.e., do you obtain proper business license to operate?)"
	label define c1_jsecjoblicense 1 "Yes" 0 "No"
	label values c1_jsecjoblicense c1_jsecjoblicense

	label variable c1_hourssecjob "C.1.20. How many hours do you spend at your secondary job during a typical week?"
	note c1_hourssecjob: "C.1.20. How many hours do you spend at your secondary job during a typical week?"

	label variable c1_dayssecjob "C.1.21 How many days do you spend at your secondary job during a typical month?"
	note c1_dayssecjob: "C.1.21 How many days do you spend at your secondary job during a typical month?"

	label variable c1_wagesecjob "C.1.24. In the past 30 days, what was your total wage (total income) from the se"
	note c1_wagesecjob: "C.1.24. In the past 30 days, what was your total wage (total income) from the secondary job?"

	label variable business_newemployee_2 "C.1.27.How many new employees (if any) have you hired in the last 12 months?"
	note business_newemployee_2: "C.1.27.How many new employees (if any) have you hired in the last 12 months?"

	label variable business_employee_2 "How many employees work in your business ?"
	note business_employee_2: "How many employees work in your business ?"

	label variable business_supply_2 "How many suppliers do you have ?"
	note business_supply_2: "How many suppliers do you have ?"

	label variable business_profit_2 "What is your monthly profit ?"
	note business_profit_2: "What is your monthly profit ?"

	label variable business_hours_2 "How many hours per day do you usually spend at your business per week"
	note business_hours_2: "How many hours per day do you usually spend at your business per week"

	label variable business_partner_2 "Do you have any business partner?"
	note business_partner_2: "Do you have any business partner?"
	label define business_partner_2 1 "Yes" 0 "No"
	label values business_partner_2 business_partner_2

	label variable business_partner_f_2 "How many female business partner"
	note business_partner_f_2: "How many female business partner"

	label variable business_partner_m_2 "How many male business partner"
	note business_partner_m_2: "How many male business partner"

	label variable business_q6_2 "Have you register in a notebook expenses and profit related to the activity of t"
	note business_q6_2: "Have you register in a notebook expenses and profit related to the activity of this business ?"
	label define business_q6_2 1 "Yes" 0 "No"
	label values business_q6_2 business_q6_2

	label variable business_q7_2 "Is it a registered business ?"
	note business_q7_2: "Is it a registered business ?"
	label define business_q7_2 1 "Yes" 0 "No"
	label values business_q7_2 business_q7_2

	label variable business_q8_2 "Do you pay taxes for your business ?"
	note business_q8_2: "Do you pay taxes for your business ?"
	label define business_q8_2 1 "Yes" 0 "No"
	label values business_q8_2 business_q8_2

	label variable business_q9_2 "How much did you paid last year ?"
	note business_q9_2: "How much did you paid last year ?"
	label define business_q9_2 1 "Yes" 0 "No"
	label values business_q9_2 business_q9_2

	label variable c1_headjob "C.1.28. Does the head of the household have a job or income generating activity?"
	note c1_headjob: "C.1.28. Does the head of the household have a job or income generating activity?"
	label define c1_headjob 1 "Yes" 0 "No"
	label values c1_headjob c1_headjob

	label variable c1_headjobiga "C.1.29. What kind of job or income generating activity is it?"
	note c1_headjobiga: "C.1.29. What kind of job or income generating activity is it?"
	label define c1_headjobiga 1 "1. Casual/temporary/seasonal work" 2 "2. Family/Self-employment (part-time)" 3 "3. Family/Self-employment (full-time)" 4 "4. Waged employment (part-time)" 5 "5. Waged employment (full-time)" 99 "99. Other"
	label values c1_headjobiga c1_headjobiga

	label variable c1_headjobiga_other "C.1.29. specify"
	note c1_headjobiga_other: "C.1.29. specify"

	label variable c1_headincome30 "C.1.30 With his/her job or income-generating activity, how much money did the he"
	note c1_headincome30: "C.1.30 With his/her job or income-generating activity, how much money did the head of the household earn in the last 30 days?"

	label variable c1_othermemberswork "C1.31. Are there other members of the household who have employment?"
	note c1_othermemberswork: "C1.31. Are there other members of the household who have employment?"
	label define c1_othermemberswork 1 "Yes" 0 "No"
	label values c1_othermemberswork c1_othermemberswork

	label variable c1_othermembersworkn "C.1.32. How many?"
	note c1_othermembersworkn: "C.1.32. How many?"

	label variable c1_othermemworkind "C.1.32. What kind of job or income generating activity do they have?"
	note c1_othermemworkind: "C.1.32. What kind of job or income generating activity do they have?"

	label variable c1_othermeother "C.1.32. specify"
	note c1_othermeother: "C.1.32. specify"

	label variable c1_incomeotheriga "C.1.33. With their jobs or income-generating activities, how much money did othe"
	note c1_incomeotheriga: "C.1.33. With their jobs or income-generating activities, how much money did other members of the household (besides yourself and/or the head of the household) earn in the last 30 days?"

	label variable c1_addotherincome "C1.34. Do the other members of this household have additional income-generating "
	note c1_addotherincome: "C1.34. Do the other members of this household have additional income-generating activities of any kind whatsoever?"
	label define c1_addotherincome 1 "Yes" 0 "No"
	label values c1_addotherincome c1_addotherincome

	label variable c1_addotherincomen "C1.35. With these income-generating activities, how much money did the other mem"
	note c1_addotherincomen: "C1.35. With these income-generating activities, how much money did the other members of the household earn in the last 30 days?"

	label variable c1_hengag "C.1.36. Does you or anyone in your household have an agricultural or livestock a"
	note c1_hengag: "C.1.36. Does you or anyone in your household have an agricultural or livestock activity ?"
	label define c1_hengag 1 "Yes" 0 "No"
	label values c1_hengag c1_hengag

	label variable c1_hengag_agr "Is it an agricultural activity ?"
	note c1_hengag_agr: "Is it an agricultural activity ?"
	label define c1_hengag_agr 1 "Yes" 0 "No"
	label values c1_hengag_agr c1_hengag_agr

	label variable c1_hengigan "C1.37. What is the total size of your land ?"
	note c1_hengigan: "C1.37. What is the total size of your land ?"

	label variable c1_hengigan_unit "C1.37.1. Enter unit"
	note c1_hengigan_unit: "C1.37.1. Enter unit"
	label define c1_hengigan_unit 1 "m2" 2 "Hectare"
	label values c1_hengigan_unit c1_hengigan_unit

	label variable c1_hhlandaran "C1.38. How much arable land does your household have?"
	note c1_hhlandaran: "C1.38. How much arable land does your household have?"

	label variable c1_hhlandaran_unit "C1.39.1. Enter unit"
	note c1_hhlandaran_unit: "C1.39.1. Enter unit"
	label define c1_hhlandaran_unit 1 "m2" 2 "Hectare"
	label values c1_hhlandaran_unit c1_hhlandaran_unit

	label variable c1_rentlabor "C1.41. From January 2019 to the present day, have you hired labor to work in you"
	note c1_rentlabor: "C1.41. From January 2019 to the present day, have you hired labor to work in your fields?"
	label define c1_rentlabor 1 "Yes" 0 "No"
	label values c1_rentlabor c1_rentlabor

	label variable c1_rentlabor_num "How many people have you hired since January 2019 ?"
	note c1_rentlabor_num: "How many people have you hired since January 2019 ?"

	label variable c1_fertilizer "C1.42. Did you use chemical fertilizers?"
	note c1_fertilizer: "C1.42. Did you use chemical fertilizers?"
	label define c1_fertilizer 1 "Yes" 0 "No"
	label values c1_fertilizer c1_fertilizer

	label variable c1_adviceag "C1.43. Have you received advice from an agricultural monitor?"
	note c1_adviceag: "C1.43. Have you received advice from an agricultural monitor?"
	label define c1_adviceag 1 "Yes" 0 "No"
	label values c1_adviceag c1_adviceag

	label variable c1_pesticides "C1.43. Did you use pesticides?"
	note c1_pesticides: "C1.43. Did you use pesticides?"
	label define c1_pesticides 1 "Yes" 0 "No"
	label values c1_pesticides c1_pesticides

	label variable c1_pesticidloans "C1.43.1. Did the purchase of pesticides require a loan?"
	note c1_pesticidloans: "C1.43.1. Did the purchase of pesticides require a loan?"
	label define c1_pesticidloans 1 "Yes" 0 "No"
	label values c1_pesticidloans c1_pesticidloans

	label variable c1_monitorservices "C1.44. Have you received any other extensions services from government entities,"
	note c1_monitorservices: "C1.44. Have you received any other extensions services from government entities, private entities or NGOs?"
	label define c1_monitorservices 1 "Yes" 0 "No"
	label values c1_monitorservices c1_monitorservices

	label variable c1_extservices "C1.45. Have you received other training services from government entities, priva"
	note c1_extservices: "C1.45. Have you received other training services from government entities, private entities or NGOs?"
	label define c1_extservices 1 "Yes" 0 "No"
	label values c1_extservices c1_extservices

	label variable c1_servicesorg "C1.46. Which of the entities or organizations did you receive services from?"
	note c1_servicesorg: "C1.46. Which of the entities or organizations did you receive services from?"

	label variable c1_servicesorgother "C1.46. specify A"
	note c1_servicesorgother: "C1.46. specify A"

	label variable productiona "Did you use your land to produce agrictultural product in 2019 ?"
	note productiona: "Did you use your land to produce agrictultural product in 2019 ?"
	label define productiona 1 "Yes" 0 "No"
	label values productiona productiona

	label variable c1_cropsowna "C1.46. Main crop sown?"
	note c1_cropsowna: "C1.46. Main crop sown?"
	label define c1_cropsowna 1 "Tomato" 2 "2. Kasava" 3 "3. sorghum" 4 "4. Orgo" 5 "5. bean" 6 "6. potato" 7 "7. Chili" 99 "99. Other"
	label values c1_cropsowna c1_cropsowna

	label variable c1_cropsowna_other "C1.46. specify 2019"
	note c1_cropsowna_other: "C1.46. specify 2019"

	label variable c1_cropprodna "C1.47. Quantity produced? 2019"
	note c1_cropprodna: "C1.47. Quantity produced? 2019"

	label variable c1_cropvalna "C1.51. Value amount? 2019"
	note c1_cropvalna: "C1.51. Value amount? 2019"

	label variable c1_cropconsna "C1.48. Quantity consumed? 2019"
	note c1_cropconsna: "C1.48. Quantity consumed? 2019"

	label variable c1_cropdonna "C1.49. Quantity donated? 2019"
	note c1_cropdonna: "C1.49. Quantity donated? 2019"

	label variable c1_cropsoldna "C1.50. Quantity sold? 2019"
	note c1_cropsoldna: "C1.50. Quantity sold? 2019"

	label variable c1_cropstoredna "C1.52. Quantity stored? 2019"
	note c1_cropstoredna: "C1.52. Quantity stored? 2019"

	label variable c2_eliipsav "C.2.1. Did you save any money since January 2019?"
	note c2_eliipsav: "C.2.1. Did you save any money since January 2019?"
	label define c2_eliipsav 1 "Yes" 0 "No"
	label values c2_eliipsav c2_eliipsav

	label variable c2_saved12wher "C.2.3.1. What do you use to save money since Janaury 2019?"
	note c2_saved12wher: "C.2.3.1. What do you use to save money since Janaury 2019?"

	label variable c2_eliipsavn "C.2.1.2 How much did you save in total since January 2019?"
	note c2_eliipsavn: "C.2.1.2 How much did you save in total since January 2019?"

	label variable c2_spendsaved "C.2.1.4. What did you spend the saved money on?"
	note c2_spendsaved: "C.2.1.4. What did you spend the saved money on?"

	label variable c2_spendsaved_other "C.2.1.3 specify"
	note c2_spendsaved_other: "C.2.1.3 specify"

	label variable c2_borrow12 "C.2.2. Since January 2019 have you borrowed money or contracted a debt from anot"
	note c2_borrow12: "C.2.2. Since January 2019 have you borrowed money or contracted a debt from another person or organization?"
	label define c2_borrow12 1 "Yes" 0 "No"
	label values c2_borrow12 c2_borrow12

	label variable c2_borrow12n "C.2.2.1 How much did you borrow in total?"
	note c2_borrow12n: "C.2.2.1 How much did you borrow in total?"

	label variable c2_borrowwho "C.2.1.3 Which individuals or organizations did you borrow the money from?"
	note c2_borrowwho: "C.2.1.3 Which individuals or organizations did you borrow the money from?"

	label variable c2_borrowwho_other "C.2.1.3 specify"
	note c2_borrowwho_other: "C.2.1.3 specify"

	label variable c2_borrow_all "How much is your total amount of debt ?"
	note c2_borrow_all: "How much is your total amount of debt ?"

	label variable c2_borrowrate "C.2.2.2. What was the rate of interest"
	note c2_borrowrate: "C.2.2.2. What was the rate of interest"

	label variable c2_borrowperiode "C.2.2.2. What was the period"
	note c2_borrowperiode: "C.2.2.2. What was the period"
	label define c2_borrowperiode 1 "Hebdomendaire" 2 "Mensuelle" 3 "Trimestrielle" 4 "Semestrielle" 5 "Annuelle" 6 "Quand il pourra."
	label values c2_borrowperiode c2_borrowperiode

	label variable c2_borrow12on "C.2.2.3. What did you spend the money on?"
	note c2_borrow12on: "C.2.2.3. What did you spend the money on?"

	label variable c2_borrow12on_other "C.2.2.3.1 specify"
	note c2_borrow12on_other: "C.2.2.3.1 specify"

	label variable c2_repaiddebt "C.2.2.4. Have you repaid your debt?"
	note c2_repaiddebt: "C.2.2.4. Have you repaid your debt?"
	label define c2_repaiddebt 1 "1. Not yet" 2 "2. Yes, some of it" 3 "3. Yes, all of it" -97 "Refuse to say" -99 "Don't know"
	label values c2_repaiddebt c2_repaiddebt

	label variable c2_depositac "C.2.4. Do you currently have a savings or deposit account?"
	note c2_depositac: "C.2.4. Do you currently have a savings or deposit account?"
	label define c2_depositac 1 "Yes" 0 "No"
	label values c2_depositac c2_depositac

	label variable c2_depositacns "C 2.4.0. When did you open this account?"
	note c2_depositacns: "C 2.4.0. When did you open this account?"

	label variable c2_company "Who else apart from you knows about this account?"
	note c2_company: "Who else apart from you knows about this account?"

	label variable c2_access "Does anyone else have access to the account?"
	note c2_access: "Does anyone else have access to the account?"
	label define c2_access 1 "Yes" 0 "No"
	label values c2_access c2_access

	label variable c2_access_who "Who has access to your bank account"
	note c2_access_who: "Who has access to your bank account"

	label variable c2_access_plan "Do you plan to give anyone access to this account, if not already?"
	note c2_access_plan: "Do you plan to give anyone access to this account, if not already?"
	label define c2_access_plan 1 "Yes" 0 "No"
	label values c2_access_plan c2_access_plan

	label variable c2_depositacn "C 2.4.1. Please estimate the amount of money that you currently have saved (taki"
	note c2_depositacn: "C 2.4.1. Please estimate the amount of money that you currently have saved (taking into account all forms of savings)?"

	label variable c2_borrowmore12 "C.2.5. Do you plan to borrow more money in the next 12 months?"
	note c2_borrowmore12: "C.2.5. Do you plan to borrow more money in the next 12 months?"
	label define c2_borrowmore12 1 "Yes" 0 "No" -99 "Don't know" -97 "Refuse to say"
	label values c2_borrowmore12 c2_borrowmore12

	label variable c2_borrowmore12on "C.2.5.1. What do you plan to spend this money on?"
	note c2_borrowmore12on: "C.2.5.1. What do you plan to spend this money on?"

	label variable c2_borrowmore12oter "C.2.5.1.1. specify"
	note c2_borrowmore12oter: "C.2.5.1.1. specify"

	label variable c2_loan "Did you loan money to someone since January 2019 ?"
	note c2_loan: "Did you loan money to someone since January 2019 ?"
	label define c2_loan 1 "Yes" 0 "No"
	label values c2_loan c2_loan

	label variable c2_loan_who "Select all the person to whom you loan money to since January 2019"
	note c2_loan_who: "Select all the person to whom you loan money to since January 2019"

	label variable c2_loan_amount "How much did you loan in total ?"
	note c2_loan_amount: "How much did you loan in total ?"

	label variable c3_traintrade12 "C.3.1. Since January 2019, did you receive a particular work training ?"
	note c3_traintrade12: "C.3.1. Since January 2019, did you receive a particular work training ?"
	label define c3_traintrade12 1 "Yes" 0 "No"
	label values c3_traintrade12 c3_traintrade12

	label variable c3_trainkind "C.3.1.1. What kind of training?"
	note c3_trainkind: "C.3.1.1. What kind of training?"

	label variable c3_trainkind_other "C.3.1.1. specify"
	note c3_trainkind_other: "C.3.1.1. specify"

	label variable c3_typejob "C.3.2. IF you could choose your career, what type of job would you do?"
	note c3_typejob: "C.3.2. IF you could choose your career, what type of job would you do?"
	label define c3_typejob 1 "Employee" 2 "Own business" 3 "Indifferent"
	label values c3_typejob c3_typejob

	label variable c3_earnjobmonth "C.3.2.2. How much money would you expect to earn per month in this job?"
	note c3_earnjobmonth: "C.3.2.2. How much money would you expect to earn per month in this job?"

	label variable c3_haveskills "C3.3. Do you have skills that you would like to use but have not used yet?"
	note c3_haveskills: "C3.3. Do you have skills that you would like to use but have not used yet?"
	label define c3_haveskills 1 "Yes" 0 "No"
	label values c3_haveskills c3_haveskills

	label variable c3_skills "C.3.3.1. What are these skills?"
	note c3_skills: "C.3.3.1. What are these skills?"

	label variable c3_skills_other "C.3.3.1. specify"
	note c3_skills_other: "C.3.3.1. specify"

	label variable c3_dreamjob "C.3.4. Do people like you have difficulties finding their dream job ?"
	note c3_dreamjob: "C.3.4. Do people like you have difficulties finding their dream job ?"
	label define c3_dreamjob 1 "Yes" 0 "No"
	label values c3_dreamjob c3_dreamjob

	label variable c3_dreamjobdif "C.3.4.1 What are the most important difficulties?"
	note c3_dreamjobdif: "C.3.4.1 What are the most important difficulties?"

	label variable c3_dreamjobdif_other "C.3.4.1. specify"
	note c3_dreamjobdif_other: "C.3.4.1. specify"

	label variable c3_obssmallbus "C.3.5. Do people like you face obstacles or challenges in starting a small busin"
	note c3_obssmallbus: "C.3.5. Do people like you face obstacles or challenges in starting a small business/microenterprise?"
	label define c3_obssmallbus 1 "Yes" 0 "No"
	label values c3_obssmallbus c3_obssmallbus

	label variable c3_obssmallbusdif "C.3.5.1 What are the most important challenges or difficulties in starting a sma"
	note c3_obssmallbusdif: "C.3.5.1 What are the most important challenges or difficulties in starting a small business?"

	label variable c3_obssmallbusdifother "C.3.5.1. specify"
	note c3_obssmallbusdifother: "C.3.5.1. specify"

	label variable c4_hhmig "C.4.1. Since January 2019, is there member of this household whom do not live an"
	note c4_hhmig: "C.4.1. Since January 2019, is there member of this household whom do not live anymore ?"
	label define c4_hhmig 1 "Yes" 0 "No"
	label values c4_hhmig c4_hhmig

	label variable c4_hhmignum "C.4.1.1. How many HH member do not live in the household anymore ?"
	note c4_hhmignum: "C.4.1.1. How many HH member do not live in the household anymore ?"

	label variable c4_hhmigreason "C.4.1.1. Why does these members do not live in the household anymore?"
	note c4_hhmigreason: "C.4.1.1. Why does these members do not live in the household anymore?"

	label variable c4_hhmigreasonother "C.4.1.2. specify"
	note c4_hhmigreasonother: "C.4.1.2. specify"

	label variable c4_migration_q2 "How many weeks on average are those HH member travelling ?"
	note c4_migration_q2: "How many weeks on average are those HH member travelling ?"

	label variable c4_migration_q4 "How much does these HH member (excluding the HH chief) earn on average per month"
	note c4_migration_q4: "How much does these HH member (excluding the HH chief) earn on average per month in their migration activity ?"

	label variable c4_migration_q5 "How much are they sending you back ?"
	note c4_migration_q5: "How much are they sending you back ?"

	label variable c4_migration_q6 "What is the main disavantadge about this migration ?"
	note c4_migration_q6: "What is the main disavantadge about this migration ?"
	label define c4_migration_q6 1 "None" 2 "Less security" 3 "More house work" 4 "Psychological issue" 5 "Other" -97 "Refuse to say" -99 "Don't know"
	label values c4_migration_q6 c4_migration_q6

	label variable c4_hhcomin "Today, is there new member in the household that did not live here before Januar"
	note c4_hhcomin: "Today, is there new member in the household that did not live here before January 2019."
	label define c4_hhcomin 1 "Yes" 0 "No"
	label values c4_hhcomin c4_hhcomin

	label variable c4_hhmembernew "C.4.2.1. How many household member lvie inthis HH but did not live here before J"
	note c4_hhmembernew: "C.4.2.1. How many household member lvie inthis HH but did not live here before January 2019 ?"

	label variable c4_hhmbernewreas "Why are those new members living in the household today?"
	note c4_hhmbernewreas: "Why are those new members living in the household today?"

	label variable c4_hhmbernewreasother "C.4.1.2. specify"
	note c4_hhmbernewreasother: "C.4.1.2. specify"

	label variable c4_respondtravel "Since Janaury 2019, did you personally travel or move to another city / governor"
	note c4_respondtravel: "Since Janaury 2019, did you personally travel or move to another city / governorat during some time ?"
	label define c4_respondtravel 0 "No" 1 "Yes in another city or province in Tunisa" 2 "Yes outside of Tunisia"
	label values c4_respondtravel c4_respondtravel

	label variable c4_traveldays "C.4.3.2. How many days have you spent outside of this city ? [ENUMERATOR CONVERT"
	note c4_traveldays: "C.4.3.2. How many days have you spent outside of this city ? [ENUMERATOR CONVERT IN DAYS]"

	label variable c4_travelreason "C.4.3.3.Why did you travel / move ?"
	note c4_travelreason: "C.4.3.3.Why did you travel / move ?"

	label variable c4_travelreasonother "C.4.3.3.1 specify"
	note c4_travelreasonother: "C.4.3.3.1 specify"

	label variable c4_travegain "C.4.3.4. How much have you earn during this time?"
	note c4_travegain: "C.4.3.4. How much have you earn during this time?"

	label variable c4_travegainsent "C.4.3.5. How much of the money earn has been sent back to your HH?"
	note c4_travegainsent: "C.4.3.5. How much of the money earn has been sent back to your HH?"

	label variable c4_travegainsave "C.4.3.6. How much have you saved during this time?"
	note c4_travegainsave: "C.4.3.6. How much have you saved during this time?"

	label variable c4_travelannoy "What are the main disavantadge of this migration ?"
	note c4_travelannoy: "What are the main disavantadge of this migration ?"
	label define c4_travelannoy 1 "None" 2 "Less security" 3 "More house work" 4 "Psychological issue" 5 "Other" -97 "Refuse to say" -99 "Don't know"
	label values c4_travelannoy c4_travelannoy

	label variable c4_parentfrids "C.4.4. Today, do you have friends / family working in another city / gouvernorat"
	note c4_parentfrids: "C.4.4. Today, do you have friends / family working in another city / gouvernorat / country ?"
	label define c4_parentfrids 1 "Yes" 0 "No"
	label values c4_parentfrids c4_parentfrids

	label variable c4_parentfridsspeak "C.4.4.1. At which frequency do yo ?talk with your relatives / family / friends t"
	note c4_parentfridsspeak: "C.4.4.1. At which frequency do yo ?talk with your relatives / family / friends through phone, Whatsapp, Skype or any other mean of communication ?"
	label define c4_parentfridsspeak 1 "1-Jamais" 2 "2 Rarement" 3 "3-Parfois" 4 "4 Souvent" 5 "5-Régulièrement"
	label values c4_parentfridsspeak c4_parentfridsspeak

	label variable c4_parentfridsubj "C.4.4.2. Do you talk about work opportunity in the place your relative / family "
	note c4_parentfridsubj: "C.4.4.2. Do you talk about work opportunity in the place your relative / family / friend live ?"
	label define c4_parentfridsubj 1 "Yes" 0 "No"
	label values c4_parentfridsubj c4_parentfridsubj

	label variable c4_parentfridguid "C.4.4.3. Did your friend / relative living in another place gave you advice on h"
	note c4_parentfridguid: "C.4.4.3. Did your friend / relative living in another place gave you advice on how to join them ?"
	label define c4_parentfridguid 1 "Yes" 0 "No"
	label values c4_parentfridguid c4_parentfridguid

	label variable c4_respfututra "C.4.5. What is the likelihood of you travelling or moving to another city / gouv"
	note c4_respfututra: "C.4.5. What is the likelihood of you travelling or moving to another city / gouvernorat in the next 12 months ?"
	label define c4_respfututra 0 "None" 1 "0-peu probable" 2 "2-plutôt probable" 3 "3-Très probablement"
	label values c4_respfututra c4_respfututra

	label variable c4_respfututrareason "C.4.5.1. What would be the reason for you to move in the next 12 months?"
	note c4_respfututrareason: "C.4.5.1. What would be the reason for you to move in the next 12 months?"

	label variable c4_respfututrareasonother "C.4.5.1.1 specify"
	note c4_respfututrareasonother: "C.4.5.1.1 specify"

	label variable c4_hhfututra "C.4.6. What is the likelihood of someone else form your HH travelling or moving "
	note c4_hhfututra: "C.4.6. What is the likelihood of someone else form your HH travelling or moving to another city / gouvernorat in the next 12 months ?"
	label define c4_hhfututra 0 "None" 1 "0-peu probable" 2 "2-plutôt probable" 3 "3-Très probablement"
	label values c4_hhfututra c4_hhfututra

	label variable c4_hhfututrareason "C.4.6.1. What would be the reason for this person to move in the next 12 month ?"
	note c4_hhfututrareason: "C.4.6.1. What would be the reason for this person to move in the next 12 month ?"

	label variable c4_hhfututrareasonother "C.4.1.2. specify"
	note c4_hhfututrareasonother: "C.4.1.2. specify"

	label variable c5_child "Do you have any child aged 5 to 14 years old ?"
	note c5_child: "Do you have any child aged 5 to 14 years old ?"
	label define c5_child 1 "Yes" 0 "No"
	label values c5_child c5_child

	label variable c5_childnoschooln "C 5.1. How many school-age children (5-14 years) of this household have never be"
	note c5_childnoschooln: "C 5.1. How many school-age children (5-14 years) of this household have never been to school?"

	label variable c5_childstopschooln "C 5.2. How many school-age children (5-14 years) in this household have interrup"
	note c5_childstopschooln: "C 5.2. How many school-age children (5-14 years) in this household have interrupted their schooling since Janaury 2019 (for other reason then the COVID 19 crisis)?"

	label variable c5_childnoschoolwhy "C 5.3. What are the most important reasons why some children in your household h"
	note c5_childnoschoolwhy: "C 5.3. What are the most important reasons why some children in your household have never been to school or have dropped out of school. [ENUMERATOR : DO NOT READ, BUT MARK ALL THAT APPLY.]"

	label variable c5_childnoschoolwhy_other "C 5.3.1 specify"
	note c5_childnoschoolwhy_other: "C 5.3.1 specify"

	label variable c5_igakids_tasks "Since January 2019. which of this tasks have been done by children living in thi"
	note c5_igakids_tasks: "Since January 2019. which of this tasks have been done by children living in this HH"

	label variable c5_landchildh "C 5.5.1 Did any of these activities require them life heavy objects or operate d"
	note c5_landchildh: "C 5.5.1 Did any of these activities require them life heavy objects or operate dangerous and heavy machinery (knives etc)?"
	label define c5_landchildh 1 "Yes" 0 "No"
	label values c5_landchildh c5_landchildh

	label variable d1_ladder_present "D.1.1. On which step of the ladder would you say you personally feel you stand a"
	note d1_ladder_present: "D.1.1. On which step of the ladder would you say you personally feel you stand at this time?"

	label variable d1_ladder_1ago "On which step of the ladder would you say you personally feel you stood one year"
	note d1_ladder_1ago: "On which step of the ladder would you say you personally feel you stood one year back?"

	label variable d1_ladder3years "D.1.2. On which step do you think you will stand about 3 years from now? Ladder "
	note d1_ladder3years: "D.1.2. On which step do you think you will stand about 3 years from now? Ladder in 3 years"

	label variable d1_ladderwealth "Imagine a ladder with 10 steps, poorer household of this imada being on first st"
	note d1_ladderwealth: "Imagine a ladder with 10 steps, poorer household of this imada being on first step and wealthier on the 10th step. At which step are you now ?"

	label variable d1_happyperson "A. During the past month, how much of the time were you a happy person?"
	note d1_happyperson: "A. During the past month, how much of the time were you a happy person?"
	label define d1_happyperson 1 "All of the time" 2 "Most of the time" 3 "A good bit of the time" 4 "Some of the time" 5 "A little of the time" 6 "None of the time" -99 "Don't know" -97 "Refuse to say"
	label values d1_happyperson d1_happyperson

	label variable d1_calmpeaceful "B. How much of the time, during the past month, have you felt calm and peaceful?"
	note d1_calmpeaceful: "B. How much of the time, during the past month, have you felt calm and peaceful?"
	label define d1_calmpeaceful 1 "All of the time" 2 "Most of the time" 3 "A good bit of the time" 4 "Some of the time" 5 "A little of the time" 6 "None of the time" -99 "Don't know" -97 "Refuse to say"
	label values d1_calmpeaceful d1_calmpeaceful

	label variable d1_nervousperson "C. How much of the time during the past month, have you been a very nervous pers"
	note d1_nervousperson: "C. How much of the time during the past month, have you been a very nervous person?"
	label define d1_nervousperson 1 "All of the time" 2 "Most of the time" 3 "A good bit of the time" 4 "Some of the time" 5 "A little of the time" 6 "None of the time" -99 "Don't know" -97 "Refuse to say"
	label values d1_nervousperson d1_nervousperson

	label variable d1_heartedblue "D. How much of the time during the past month, have you felt down-hearted and bl"
	note d1_heartedblue: "D. How much of the time during the past month, have you felt down-hearted and blue?"
	label define d1_heartedblue 1 "All of the time" 2 "Most of the time" 3 "A good bit of the time" 4 "Some of the time" 5 "A little of the time" 6 "None of the time" -99 "Don't know" -97 "Refuse to say"
	label values d1_heartedblue d1_heartedblue

	label variable d1_cheerup "E. How much of the time, during the past month, did you feel so down that nothin"
	note d1_cheerup: "E. How much of the time, during the past month, did you feel so down that nothing could cheer you up?"
	label define d1_cheerup 1 "All of the time" 2 "Most of the time" 3 "A good bit of the time" 4 "Some of the time" 5 "A little of the time" 6 "None of the time" -99 "Don't know" -97 "Refuse to say"
	label values d1_cheerup d1_cheerup

	label variable d2_thinkwrong "A. You are sometimes not able to stop yourself from doing something you think is"
	note d2_thinkwrong: "A. You are sometimes not able to stop yourself from doing something you think is wrong."
	label define d2_thinkwrong 1 "Pas du tout d’accord" 2 "Un peu d’accord" 3 "D’accord" 4 "Très d’accord"
	label values d2_thinkwrong d2_thinkwrong

	label variable d2_resisttempta "B. You are good at resisting temptation."
	note d2_resisttempta: "B. You are good at resisting temptation."
	label define d2_resisttempta 1 "Pas du tout d’accord" 2 "Un peu d’accord" 3 "D’accord" 4 "Très d’accord"
	label values d2_resisttempta d2_resisttempta

	label variable d2_postponing "C. Most activities that you plan to do, you tend to keep postponing until later "
	note d2_postponing: "C. Most activities that you plan to do, you tend to keep postponing until later ('I will do it tomorrow')."
	label define d2_postponing 1 "Pas du tout d’accord" 2 "Un peu d’accord" 3 "D’accord" 4 "Très d’accord"
	label values d2_postponing d2_postponing

	label variable d2_tooquickly "D. If you get money, you spend it too quickly."
	note d2_tooquickly: "D. If you get money, you spend it too quickly."
	label define d2_tooquickly 1 "Pas du tout d’accord" 2 "Un peu d’accord" 3 "D’accord" 4 "Très d’accord"
	label values d2_tooquickly d2_tooquickly

	label variable d2_waiting "E. You would spend an afternoon waiting just to get a free medical examination. "
	note d2_waiting: "E. You would spend an afternoon waiting just to get a free medical examination. The quality of the examination is identical whether you pay for immediate medical care or wait to receive the examination."
	label define d2_waiting 1 "Pas du tout d’accord" 2 "Un peu d’accord" 3 "D’accord" 4 "Très d’accord"
	label values d2_waiting d2_waiting

	label variable d2_thinkingmuch "F. You sometimes act quickly instead of thinking too much about the results of y"
	note d2_thinkingmuch: "F. You sometimes act quickly instead of thinking too much about the results of your actions."
	label define d2_thinkingmuch 1 "Pas du tout d’accord" 2 "Un peu d’accord" 3 "D’accord" 4 "Très d’accord"
	label values d2_thinkingmuch d2_thinkingmuch

	label variable d2_regretchoices "G. You regret many choices you have made in the past."
	note d2_regretchoices: "G. You regret many choices you have made in the past."
	label define d2_regretchoices 1 "Pas du tout d’accord" 2 "Un peu d’accord" 3 "D’accord" 4 "Très d’accord"
	label values d2_regretchoices d2_regretchoices

	label variable d2_takeprecaution "H. You think it’s important to take precautions about negative outcomes seriousl"
	note d2_takeprecaution: "H. You think it’s important to take precautions about negative outcomes seriously even if they may not occur for many years."
	label define d2_takeprecaution 1 "Pas du tout d’accord" 2 "Un peu d’accord" 3 "D’accord" 4 "Très d’accord"
	label values d2_takeprecaution d2_takeprecaution

	label variable d2_workinginteam "I. You get better results working in a team, rather than individually"
	note d2_workinginteam: "I. You get better results working in a team, rather than individually"
	label define d2_workinginteam 1 "Pas du tout d’accord" 2 "Un peu d’accord" 3 "D’accord" 4 "Très d’accord"
	label values d2_workinginteam d2_workinginteam

	label variable d2_opencomunication "J. You believe many disputes at work or with family and friends can be resolved "
	note d2_opencomunication: "J. You believe many disputes at work or with family and friends can be resolved through open and candid communication"
	label define d2_opencomunication 1 "Pas du tout d’accord" 2 "Un peu d’accord" 3 "D’accord" 4 "Très d’accord"
	label values d2_opencomunication d2_opencomunication

	label variable d2_defendopinions "K. You can influence others by defending your opinions in a firm, but non-aggres"
	note d2_defendopinions: "K. You can influence others by defending your opinions in a firm, but non-aggressive way"
	label define d2_defendopinions 1 "Pas du tout d’accord" 2 "Un peu d’accord" 3 "D’accord" 4 "Très d’accord"
	label values d2_defendopinions d2_defendopinions

	label variable d2_managingtime "L. You are very good at managing your time"
	note d2_managingtime: "L. You are very good at managing your time"
	label define d2_managingtime 1 "Pas du tout d’accord" 2 "Un peu d’accord" 3 "D’accord" 4 "Très d’accord"
	label values d2_managingtime d2_managingtime

	label variable d2_reachdecisions "M. You are usually active in discussions with friends or co-workers and try to r"
	note d2_reachdecisions: "M. You are usually active in discussions with friends or co-workers and try to reach decisions"
	label define d2_reachdecisions 1 "Pas du tout d’accord" 2 "Un peu d’accord" 3 "D’accord" 4 "Très d’accord"
	label values d2_reachdecisions d2_reachdecisions

	label variable d2_illnesslifelong "D2.2 Suppose you are sick. The illness is not life-long, but it will last for a "
	note d2_illnesslifelong: "D2.2 Suppose you are sick. The illness is not life-long, but it will last for a few months. You have the choice between two options: Option A: You can get some medicine today, which will make you feel somewhat better. Option B: You can wait a week until a better medicine is available that will make you feel entirely good again. You can only choose one medicine. Which option do you choose?"
	label define d2_illnesslifelong 1 "1. Option A" 2 "2.Option B" 3 "3. NoPreference"
	label values d2_illnesslifelong d2_illnesslifelong

	label variable d2_easyhardtask "D2.3 Suppose you have two tasks, one easy and one hard. Both need to be done tod"
	note d2_easyhardtask: "D2.3 Suppose you have two tasks, one easy and one hard. Both need to be done today, and you have enough time and resources to do both today. You have the choice between two options: Option A: Do the easy task first. Option B: Do the hard task first. Which option would you choose?"
	label define d2_easyhardtask 1 "1. Option A" 2 "2.Option B" 3 "3. NoPreference"
	label values d2_easyhardtask d2_easyhardtask

	label variable d3_giveviews "Please for each of the following question below give me your view"
	note d3_giveviews: "Please for each of the following question below give me your view"
	label define d3_giveviews 1 "Yes" 0 "No"
	label values d3_giveviews d3_giveviews

	label variable d3_shortnessbreath "D3.1.1. Do you experience shortness of breath or shaking when you try to rest?"
	note d3_shortnessbreath: "D3.1.1. Do you experience shortness of breath or shaking when you try to rest?"
	label define d3_shortnessbreath 1 "Yes" 0 "No"
	label values d3_shortnessbreath d3_shortnessbreath

	label variable d3_fearlosingcontrol "D3.1.2. Do you have a fear of losing control of yourself or of 'going crazy'?"
	note d3_fearlosingcontrol: "D3.1.2. Do you have a fear of losing control of yourself or of 'going crazy'?"
	label define d3_fearlosingcontrol 1 "Yes" 0 "No"
	label values d3_fearlosingcontrol d3_fearlosingcontrol

	label variable d3_worryest "D3.1.3. Do you feel that you worry about many things?"
	note d3_worryest: "D3.1.3. Do you feel that you worry about many things?"
	label define d3_worryest 1 "Yes" 0 "No"
	label values d3_worryest d3_worryest

	label variable d3_feelingsfear "D3.1.4. Do you avoid social situations because of feelings of fear?"
	note d3_feelingsfear: "D3.1.4. Do you avoid social situations because of feelings of fear?"
	label define d3_feelingsfear 1 "Yes" 0 "No"
	label values d3_feelingsfear d3_feelingsfear

	label variable d3_frighten "D3.1.5. Does the idea of leaving home frighten you?"
	note d3_frighten: "D3.1.5. Does the idea of leaving home frighten you?"
	label define d3_frighten 1 "Yes" 0 "No"
	label values d3_frighten d3_frighten

	label variable d3_feeldeceiving "D3.2.1. Do you often feel that others are exploiting or deceiving you?"
	note d3_feeldeceiving: "D3.2.1. Do you often feel that others are exploiting or deceiving you?"
	label define d3_feeldeceiving 1 "Yes" 0 "No"
	label values d3_feeldeceiving d3_feeldeceiving

	label variable d3_solitaryactivities "D3.2.2. Do you prefer solitary activities to group activities?"
	note d3_solitaryactivities: "D3.2.2. Do you prefer solitary activities to group activities?"
	label define d3_solitaryactivities 1 "Yes" 0 "No"
	label values d3_solitaryactivities d3_solitaryactivities

	label variable d3_uncomfortabl "D3.2.3. Do you feel uncomfortable in situations where you are not in charge?"
	note d3_uncomfortabl: "D3.2.3. Do you feel uncomfortable in situations where you are not in charge?"
	label define d3_uncomfortabl 1 "Yes" 0 "No"
	label values d3_uncomfortabl d3_uncomfortabl

	label variable d3_unwilling "D3.2.4. Are you unwilling to get involved with people unless you are certain of "
	note d3_unwilling: "D3.2.4. Are you unwilling to get involved with people unless you are certain of being liked?"
	label define d3_unwilling 1 "Yes" 0 "No"
	label values d3_unwilling d3_unwilling

	label variable d3_pointofview "Please for each of the following question below give me your view"
	note d3_pointofview: "Please for each of the following question below give me your view"
	label define d3_pointofview 1 "Yes" 0 "No" -99 "Don't know" -97 "Refuse to say"
	label values d3_pointofview d3_pointofview

	label variable d3_lifethreatening "D3.3.1. Have you experienced any life-threatening events?"
	note d3_lifethreatening: "D3.3.1. Have you experienced any life-threatening events?"
	label define d3_lifethreatening 1 "Yes" 0 "No" -99 "Don't know" -97 "Refuse to say"
	label values d3_lifethreatening d3_lifethreatening

	label variable d3_distressing "D3.3.2. Do you have distressing memories or dreams?"
	note d3_distressing: "D3.3.2. Do you have distressing memories or dreams?"
	label define d3_distressing 1 "Yes" 0 "No" -99 "Don't know" -97 "Refuse to say"
	label values d3_distressing d3_distressing

	label variable d3_avoidthinking "D3.3.3. Do you avoid thinking or talking about certain things from the past?"
	note d3_avoidthinking: "D3.3.3. Do you avoid thinking or talking about certain things from the past?"
	label define d3_avoidthinking 1 "Yes" 0 "No" -99 "Don't know" -97 "Refuse to say"
	label values d3_avoidthinking d3_avoidthinking

	label variable d3_remembering "D3.3.4. Do you have trouble remembering important parts of past events?"
	note d3_remembering: "D3.3.4. Do you have trouble remembering important parts of past events?"
	label define d3_remembering 1 "Yes" 0 "No" -99 "Don't know" -97 "Refuse to say"
	label values d3_remembering d3_remembering

	label variable d3_lostinterest "D3.3.5. Have you lost interest in activities that you used to enjoy?"
	note d3_lostinterest: "D3.3.5. Have you lost interest in activities that you used to enjoy?"
	label define d3_lostinterest 1 "Yes" 0 "No" -99 "Don't know" -97 "Refuse to say"
	label values d3_lostinterest d3_lostinterest

	label variable d3_feeldetached "D3.3.6. Do you feel detached from other people?"
	note d3_feeldetached: "D3.3.6. Do you feel detached from other people?"
	label define d3_feeldetached 1 "Yes" 0 "No" -99 "Don't know" -97 "Refuse to say"
	label values d3_feeldetached d3_feeldetached

	label variable d3_oftenirritable "D3.3.7. Do you feel like you are often irritable?"
	note d3_oftenirritable: "D3.3.7. Do you feel like you are often irritable?"
	label define d3_oftenirritable 1 "Yes" 0 "No" -99 "Don't know" -97 "Refuse to say"
	label values d3_oftenirritable d3_oftenirritable

	label variable d3_makedecisions "D3.3.8. Do you feel like it takes you longer to make decisions than it used to?"
	note d3_makedecisions: "D3.3.8. Do you feel like it takes you longer to make decisions than it used to?"
	label define d3_makedecisions 1 "Yes" 0 "No" -99 "Don't know" -97 "Refuse to say"
	label values d3_makedecisions d3_makedecisions

	label variable d3_sleepeatinghabit "D3.3.9. Have you experienced major changes in sleeping or eating habits in recen"
	note d3_sleepeatinghabit: "D3.3.9. Have you experienced major changes in sleeping or eating habits in recent years?"
	label define d3_sleepeatinghabit 1 "Yes" 0 "No" -99 "Don't know" -97 "Refuse to say"
	label values d3_sleepeatinghabit d3_sleepeatinghabit

	label variable d3_depressed "D3.3.10. Do you often feel sad or depressed?"
	note d3_depressed: "D3.3.10. Do you often feel sad or depressed?"
	label define d3_depressed 1 "Yes" 0 "No" -99 "Don't know" -97 "Refuse to say"
	label values d3_depressed d3_depressed

	label variable d3_wrongmatter "D3.3.11. Do you feel like things will always go wrong no matter how hard you try"
	note d3_wrongmatter: "D3.3.11. Do you feel like things will always go wrong no matter how hard you try?"
	label define d3_wrongmatter 1 "Yes" 0 "No" -99 "Don't know" -97 "Refuse to say"
	label values d3_wrongmatter d3_wrongmatter

	label variable d3_alcoholdrugs "D3.3.12. In the last year, did you fail to fulfill responsibilities due to alcoh"
	note d3_alcoholdrugs: "D3.3.12. In the last year, did you fail to fulfill responsibilities due to alcohol or drugs?"
	label define d3_alcoholdrugs 1 "Yes" 0 "No" -99 "Don't know" -97 "Refuse to say"
	label values d3_alcoholdrugs d3_alcoholdrugs

	label variable d3_feltangry "D3.4.1. During the past week have you felt angry?"
	note d3_feltangry: "D3.4.1. During the past week have you felt angry?"
	label define d3_feltangry 1 "Yes" 0 "No" -99 "Don't know" -97 "Refuse to say"
	label values d3_feltangry d3_feltangry

	label variable d3_troubllistening "D3.4.2. Do you have trouble listening to people who disagree with you?"
	note d3_troubllistening: "D3.4.2. Do you have trouble listening to people who disagree with you?"
	label define d3_troubllistening 1 "Yes" 0 "No" -99 "Don't know" -97 "Refuse to say"
	label values d3_troubllistening d3_troubllistening

	label variable d3_wrongblame "D3.4.3. When something goes wrong, is the most important thing to find out who i"
	note d3_wrongblame: "D3.4.3. When something goes wrong, is the most important thing to find out who is to blame?"
	label define d3_wrongblame 1 "Yes" 0 "No" -99 "Don't know" -97 "Refuse to say"
	label values d3_wrongblame d3_wrongblame

	label variable d3_recognition "D3.4.4. Do other people get more recognition for less effort than you make?"
	note d3_recognition: "D3.4.4. Do other people get more recognition for less effort than you make?"
	label define d3_recognition 1 "Yes" 0 "No" -99 "Don't know" -97 "Refuse to say"
	label values d3_recognition d3_recognition

	label variable d3_believethink "D3.4.5. Do you believe that what you think and feel doesn’t matter to others?"
	note d3_believethink: "D3.4.5. Do you believe that what you think and feel doesn’t matter to others?"
	label define d3_believethink 1 "Yes" 0 "No" -99 "Don't know" -97 "Refuse to say"
	label values d3_believethink d3_believethink

	label variable d3_frustrated "D3.4.6. Do you become frustrated when people do not behave as they should?"
	note d3_frustrated: "D3.4.6. Do you become frustrated when people do not behave as they should?"
	label define d3_frustrated 1 "Yes" 0 "No" -99 "Don't know" -97 "Refuse to say"
	label values d3_frustrated d3_frustrated

	label variable d3_enoughsleep "D3.4.7. Do you never get enough sleep?"
	note d3_enoughsleep: "D3.4.7. Do you never get enough sleep?"
	label define d3_enoughsleep 1 "Yes" 0 "No" -99 "Don't know" -97 "Refuse to say"
	label values d3_enoughsleep d3_enoughsleep

	label variable d3_lotofthings "D3.4.8. Do you put up with a lot of things you don’t like?"
	note d3_lotofthings: "D3.4.8. Do you put up with a lot of things you don’t like?"
	label define d3_lotofthings 1 "Yes" 0 "No" -99 "Don't know" -97 "Refuse to say"
	label values d3_lotofthings d3_lotofthings

	label variable d3_nightmares "D3.4.10. Do you have restless nights or nightmares at night?"
	note d3_nightmares: "D3.4.10. Do you have restless nights or nightmares at night?"
	label define d3_nightmares 1 "Yes" 0 "No" -99 "Don't know" -97 "Refuse to say"
	label values d3_nightmares d3_nightmares

	label variable d3_solveproblems "D.3.5.1 Do you feel that you can solve problems by yourself?"
	note d3_solveproblems: "D.3.5.1 Do you feel that you can solve problems by yourself?"
	label define d3_solveproblems 1 "Yes" 0 "No" -99 "Don't know" -97 "Refuse to say"
	label values d3_solveproblems d3_solveproblems

	label variable d3_dependsmainly "D.3. 5.2 Do you feel that your future depends mainly on you?"
	note d3_dependsmainly: "D.3. 5.2 Do you feel that your future depends mainly on you?"
	label define d3_dependsmainly 1 "Yes" 0 "No" -99 "Don't know" -97 "Refuse to say"
	label values d3_dependsmainly d3_dependsmainly

	label variable d3_feel_helpless "D.3. 5.3 Do you feel helpless to deal with the problems in your life?"
	note d3_feel_helpless: "D.3. 5.3 Do you feel helpless to deal with the problems in your life?"
	label define d3_feel_helpless 1 "Yes" 0 "No" -99 "Don't know" -97 "Refuse to say"
	label values d3_feel_helpless d3_feel_helpless

	label variable d3_influence_many "D.3. 5.4 Do you feel that you can do little to influence many of the important e"
	note d3_influence_many: "D.3. 5.4 Do you feel that you can do little to influence many of the important events in your life?"
	label define d3_influence_many 1 "Yes" 0 "No" -99 "Don't know" -97 "Refuse to say"
	label values d3_influence_many d3_influence_many

	label variable d3_taking_control "D.3. 5.5 Do you sometimes feel like you're not taking control of your life?"
	note d3_taking_control: "D.3. 5.5 Do you sometimes feel like you're not taking control of your life?"
	label define d3_taking_control 1 "Yes" 0 "No" -99 "Don't know" -97 "Refuse to say"
	label values d3_taking_control d3_taking_control

	label variable d3_exploitedcheated "D.3. 5.6 Have you often felt that you have been exploited or cheated by other pe"
	note d3_exploitedcheated: "D.3. 5.6 Have you often felt that you have been exploited or cheated by other people?"
	label define d3_exploitedcheated 1 "Yes" 0 "No" -99 "Don't know" -97 "Refuse to say"
	label values d3_exploitedcheated d3_exploitedcheated

	label variable d3_have_control "D.3. 5.7 Do you feel like you have control over what happens in your life?"
	note d3_have_control: "D.3. 5.7 Do you feel like you have control over what happens in your life?"
	label define d3_have_control 1 "Yes" 0 "No" -99 "Don't know" -97 "Refuse to say"
	label values d3_have_control d3_have_control

	label variable d3_trust_worthy "D.3. 5.8 Do you feel people are generally trust-worthy?"
	note d3_trust_worthy: "D.3. 5.8 Do you feel people are generally trust-worthy?"
	label define d3_trust_worthy 1 "Yes" 0 "No" -99 "Don't know" -97 "Refuse to say"
	label values d3_trust_worthy d3_trust_worthy

	label variable d3_achieveanything "D.3. 5.9 Do you feel that you can achieve anything if you are dedicated?"
	note d3_achieveanything: "D.3. 5.9 Do you feel that you can achieve anything if you are dedicated?"
	label define d3_achieveanything 1 "Yes" 0 "No" -99 "Don't know" -97 "Refuse to say"
	label values d3_achieveanything d3_achieveanything

	label variable d3_beingaccepted "D.3. 5.10 Today, do you have problems being accepted in your household?"
	note d3_beingaccepted: "D.3. 5.10 Today, do you have problems being accepted in your household?"
	label define d3_beingaccepted 1 "Yes" 0 "No" -99 "Don't know" -97 "Refuse to say"
	label values d3_beingaccepted d3_beingaccepted

	label variable d3_problemworries "D3.6. When you have problems or worries that torment you, do you often share wit"
	note d3_problemworries: "D3.6. When you have problems or worries that torment you, do you often share with friends, household/family members or anyone else in the community?"
	label define d3_problemworries 1 "Yes" 0 "No"
	label values d3_problemworries d3_problemworries

	label variable d3_usuallyshare "D3.6.1 With whom do you usually share your problems and concerns at first?"
	note d3_usuallyshare: "D3.6.1 With whom do you usually share your problems and concerns at first?"
	label define d3_usuallyshare 1 "1.Member of the HH/family" 2 "2.Friends" 3 "3.work colleagues" 99 "4.Other"
	label values d3_usuallyshare d3_usuallyshare

	label variable d3_usuallyshareother "Specify other"
	note d3_usuallyshareother: "Specify other"

	label variable d3_integralpart "D3.7. To what extent do other members of your family/household consider you an i"
	note d3_integralpart: "D3.7. To what extent do other members of your family/household consider you an integral part of the household/family?"
	label define d3_integralpart 1 "1. Never" 2 "2. rarely" 3 "3 sometimes" 4 "4. Often" 5 "5 Always"
	label values d3_integralpart d3_integralpart

	label variable d3_friendssecrets "D3.8. What is the proportion of your friends who share most of their secrets wit"
	note d3_friendssecrets: "D3.8. What is the proportion of your friends who share most of their secrets with you?"
	label define d3_friendssecrets 1 "1.Almost everyone" 2 "2.Only a few of them" 3 "3.Almost no one]"
	label values d3_friendssecrets d3_friendssecrets

	label variable d3_spendmosttime "D3.9 With whom do you spend most of your free time?"
	note d3_spendmosttime: "D3.9 With whom do you spend most of your free time?"
	label define d3_spendmosttime 1 "1.Member of the HH/family" 2 "2.Friends" 3 "3.Work colleagues" 4 "4.Alone" 99 "5.Other [Specify] :"
	label values d3_spendmosttime d3_spendmosttime

	label variable d3_spendmosttimeother "Specify other"
	note d3_spendmosttimeother: "Specify other"

	label variable d3_spendalone "D3.10. Why do you spend time alone?"
	note d3_spendalone: "D3.10. Why do you spend time alone?"
	label define d3_spendalone 1 "1.Other people usually not available/are busy" 2 "2.Other people don’t want to be with me" 3 "3.I just feel sad" 4 "4.I just want to be alone" 99 "5.Other [Specify]"
	label values d3_spendalone d3_spendalone

	label variable d3_spendaloneother "Specify other"
	note d3_spendaloneother: "Specify other"

	label variable d3_informindvdua "D3.11.1.Who would you inform first"
	note d3_informindvdua: "D3.11.1.Who would you inform first"
	label define d3_informindvdua 1 "Chef de ménage" 2 "Père/Mère" 3 "Grand parent" 4 "Epoux/relation religieuse" 5 "Enfant (incl. Adoption)" 6 "Frère ou sœur" 7 "Oncle ou tante" 8 "Nièce ou neveu" 9 "Petit-fils/petite-fille" 10 "Beaux-parents" 11 "Beau-frère/sœur" 12 "Cousin" 14 "Beau fils/belle fille" 15 "Friends" 16 "Coworkers" 17 "No Member" 99 "Autre"
	label values d3_informindvdua d3_informindvdua

	label variable d3_informindvdua1 "D3.11.2. Who would you inform in second position"
	note d3_informindvdua1: "D3.11.2. Who would you inform in second position"
	label define d3_informindvdua1 1 "Chef de ménage" 2 "Père/Mère" 3 "Grand parent" 4 "Epoux/relation religieuse" 5 "Enfant (incl. Adoption)" 6 "Frère ou sœur" 7 "Oncle ou tante" 8 "Nièce ou neveu" 9 "Petit-fils/petite-fille" 10 "Beaux-parents" 11 "Beau-frère/sœur" 12 "Cousin" 14 "Beau fils/belle fille" 15 "Friends" 16 "Coworkers" 17 "No Member" 99 "Autre"
	label values d3_informindvdua1 d3_informindvdua1

	label variable d3_informindvduals "D3.11.3. Who would you know in third position"
	note d3_informindvduals: "D3.11.3. Who would you know in third position"
	label define d3_informindvduals 1 "Chef de ménage" 2 "Père/Mère" 3 "Grand parent" 4 "Epoux/relation religieuse" 5 "Enfant (incl. Adoption)" 6 "Frère ou sœur" 7 "Oncle ou tante" 8 "Nièce ou neveu" 9 "Petit-fils/petite-fille" 10 "Beaux-parents" 11 "Beau-frère/sœur" 12 "Cousin" 14 "Beau fils/belle fille" 15 "Friends" 16 "Coworkers" 17 "No Member" 99 "Autre"
	label values d3_informindvduals d3_informindvduals

	label variable e1_drinkwater "A. Is there a: Place where you get drinking water"
	note e1_drinkwater: "A. Is there a: Place where you get drinking water"
	label define e1_drinkwater 1 "Yes" 0 "No"
	label values e1_drinkwater e1_drinkwater

	label variable e1_moddrinkwater "A. Transport mode used to get to : Place where you get drinking water"
	note e1_moddrinkwater: "A. Transport mode used to get to : Place where you get drinking water"
	label define e1_moddrinkwater 1 "Walking" 2 "Bicycle" 3 "Mule/ donkey" 4 "Car/motorcycle" 5 "Bus/ microbus" 6 "Boat/ canoe" 99 "Other" -99 "Don't know"
	label values e1_moddrinkwater e1_moddrinkwater

	label variable e1_moddrinkwaterother "Specify other"
	note e1_moddrinkwaterother: "Specify other"

	label variable e1_timedrinkwater "E.1.3.2. Necessary time to get to this services using \${e1_modwater_e}\${e1_mod"
	note e1_timedrinkwater: "E.1.3.2. Necessary time to get to this services using \${e1_modwater_e}\${e1_moddrinkwaterother} from your home (simple way)"

	label variable e1_hhdrinkwater "E.1.4 Did a member of your HH used this services in the last 6 month ?"
	note e1_hhdrinkwater: "E.1.4 Did a member of your HH used this services in the last 6 month ?"
	label define e1_hhdrinkwater 1 "Yes" 0 "No"
	label values e1_hhdrinkwater e1_hhdrinkwater

	label variable e1_foodmarket "B. Is there a: Food market/grocery store"
	note e1_foodmarket: "B. Is there a: Food market/grocery store"
	label define e1_foodmarket 1 "Yes" 0 "No"
	label values e1_foodmarket e1_foodmarket

	label variable e1_modfoodmarket "B. Transport mode used to get to : Food market/grocery store"
	note e1_modfoodmarket: "B. Transport mode used to get to : Food market/grocery store"
	label define e1_modfoodmarket 1 "Walking" 2 "Bicycle" 3 "Mule/ donkey" 4 "Car/motorcycle" 5 "Bus/ microbus" 6 "Boat/ canoe" 99 "Other" -99 "Don't know"
	label values e1_modfoodmarket e1_modfoodmarket

	label variable e1_modfoodmarketother "Specify other"
	note e1_modfoodmarketother: "Specify other"

	label variable e1_timefoodmarket "E.1.3 Necessary time to get to this services using \${e1_modmarket_e}\${e1_modfo"
	note e1_timefoodmarket: "E.1.3 Necessary time to get to this services using \${e1_modmarket_e}\${e1_modfoodmarketother} from your home (simple way)"

	label variable e1_hhfoodmarket "Did a member of your HH used this services in the last 6 month ?"
	note e1_hhfoodmarket: "Did a member of your HH used this services in the last 6 month ?"
	label define e1_hhfoodmarket 1 "Yes" 0 "No"
	label values e1_hhfoodmarket e1_hhfoodmarket

	label variable e1_primaryschool "D. Is there a: Primary School"
	note e1_primaryschool: "D. Is there a: Primary School"
	label define e1_primaryschool 1 "Yes" 0 "No"
	label values e1_primaryschool e1_primaryschool

	label variable e1_modprimaryschool "D. Transport mode used to get to : Primary school"
	note e1_modprimaryschool: "D. Transport mode used to get to : Primary school"
	label define e1_modprimaryschool 1 "Walking" 2 "Bicycle" 3 "Mule/ donkey" 4 "Car/motorcycle" 5 "Bus/ microbus" 6 "Boat/ canoe" 99 "Other" -99 "Don't know"
	label values e1_modprimaryschool e1_modprimaryschool

	label variable e1_modprimaryschoolother "Specify other"
	note e1_modprimaryschoolother: "Specify other"

	label variable e1_timeprimaryschool "E.1.3 Necessary time to get to this services using \${e1_modprimary_e}\${e1_modp"
	note e1_timeprimaryschool: "E.1.3 Necessary time to get to this services using \${e1_modprimary_e}\${e1_modprimaryschoolother} from your home (simple way)"

	label variable e1_hhprimaryschool "Did a member of your HH used this services in the last 6 month ?"
	note e1_hhprimaryschool: "Did a member of your HH used this services in the last 6 month ?"
	label define e1_hhprimaryschool 1 "Yes" 0 "No"
	label values e1_hhprimaryschool e1_hhprimaryschool

	label variable e1_secondaryschool "E. Is there a: Secondary School"
	note e1_secondaryschool: "E. Is there a: Secondary School"
	label define e1_secondaryschool 1 "Yes" 0 "No"
	label values e1_secondaryschool e1_secondaryschool

	label variable e1_modsecondaryschool "E. Transport mode used to get to : Scondary school"
	note e1_modsecondaryschool: "E. Transport mode used to get to : Scondary school"
	label define e1_modsecondaryschool 1 "Walking" 2 "Bicycle" 3 "Mule/ donkey" 4 "Car/motorcycle" 5 "Bus/ microbus" 6 "Boat/ canoe" 99 "Other" -99 "Don't know"
	label values e1_modsecondaryschool e1_modsecondaryschool

	label variable e1_modsecdryschoolother "Specify other"
	note e1_modsecdryschoolother: "Specify other"

	label variable e1_timesecondaryschool "E.1.3 Necessary time to get to this services using \${e1_modsecondary_e}\${e1_mo"
	note e1_timesecondaryschool: "E.1.3 Necessary time to get to this services using \${e1_modsecondary_e}\${e1_modsecdryschoolother} from your home (simple way)"

	label variable e1_hhsecondaryschool "Did a member of your HH used this services in the last 6 month ?"
	note e1_hhsecondaryschool: "Did a member of your HH used this services in the last 6 month ?"
	label define e1_hhsecondaryschool 1 "Yes" 0 "No"
	label values e1_hhsecondaryschool e1_hhsecondaryschool

	label variable e1_dispensaryclinic "G. Is there a: Dispensary or clinic"
	note e1_dispensaryclinic: "G. Is there a: Dispensary or clinic"
	label define e1_dispensaryclinic 1 "Yes" 0 "No"
	label values e1_dispensaryclinic e1_dispensaryclinic

	label variable e1_moddispensaryclinic "G. Transport mode used to get to : Dispensary or clinic"
	note e1_moddispensaryclinic: "G. Transport mode used to get to : Dispensary or clinic"
	label define e1_moddispensaryclinic 1 "Walking" 2 "Bicycle" 3 "Mule/ donkey" 4 "Car/motorcycle" 5 "Bus/ microbus" 6 "Boat/ canoe" 99 "Other" -99 "Don't know"
	label values e1_moddispensaryclinic e1_moddispensaryclinic

	label variable e1_moddispsaryclinicother "Specify other"
	note e1_moddispsaryclinicother: "Specify other"

	label variable e1_timedispensaryclinic1 "E.1.3 Necessary time to get to this services using \${e1_moddispensary_e}\${e1_m"
	note e1_timedispensaryclinic1: "E.1.3 Necessary time to get to this services using \${e1_moddispensary_e}\${e1_moddispsaryclinicother} from your home (simple way)"

	label variable e1_hhdispensaryclinic "Did a member of your HH used this services in the last 6 month ?"
	note e1_hhdispensaryclinic: "Did a member of your HH used this services in the last 6 month ?"
	label define e1_hhdispensaryclinic 1 "Yes" 0 "No"
	label values e1_hhdispensaryclinic e1_hhdispensaryclinic

	label variable e1_busstop "P. Is there a: Bus/Minibus stop"
	note e1_busstop: "P. Is there a: Bus/Minibus stop"
	label define e1_busstop 1 "Yes" 0 "No"
	label values e1_busstop e1_busstop

	label variable e1_modbusstop "P. Transport mode used to get to : Bust stop"
	note e1_modbusstop: "P. Transport mode used to get to : Bust stop"
	label define e1_modbusstop 1 "Walking" 2 "Bicycle" 3 "Mule/ donkey" 4 "Car/motorcycle" 5 "Bus/ microbus" 6 "Boat/ canoe" 99 "Other" -99 "Don't know"
	label values e1_modbusstop e1_modbusstop

	label variable e1_modbusstopother "Specify other"
	note e1_modbusstopother: "Specify other"

	label variable e1_timebusstop "E.1.3 Necessary time to get to this services using \${e1_modbus_e}\${e1_modbusst"
	note e1_timebusstop: "E.1.3 Necessary time to get to this services using \${e1_modbus_e}\${e1_modbusstopother} from your home (simple way)"

	label variable e1_hhbusstop "Did a member of your HH used this services in the last 6 month ?"
	note e1_hhbusstop: "Did a member of your HH used this services in the last 6 month ?"
	label define e1_hhbusstop 1 "Yes" 0 "No"
	label values e1_hhbusstop e1_hhbusstop

	label variable e1_firestation "V. Is there a: Fire station"
	note e1_firestation: "V. Is there a: Fire station"
	label define e1_firestation 1 "Yes" 0 "No"
	label values e1_firestation e1_firestation

	label variable e1_modfirestation "V. Transport mode used to get to : Fire station"
	note e1_modfirestation: "V. Transport mode used to get to : Fire station"
	label define e1_modfirestation 1 "Walking" 2 "Bicycle" 3 "Mule/ donkey" 4 "Car/motorcycle" 5 "Bus/ microbus" 6 "Boat/ canoe" 99 "Other" -99 "Don't know"
	label values e1_modfirestation e1_modfirestation

	label variable e1_modfirestationother "Specify other"
	note e1_modfirestationother: "Specify other"

	label variable e1_timefirestation "E.1.3 Necessary time to get to this services using \${e1_modfire_e}\${e1_modfire"
	note e1_timefirestation: "E.1.3 Necessary time to get to this services using \${e1_modfire_e}\${e1_modfirestationother} from your home (simple way)"

	label variable e1_hhfirestation "Did a member of your HH used this services in the last 6 month ?"
	note e1_hhfirestation: "Did a member of your HH used this services in the last 6 month ?"
	label define e1_hhfirestation 1 "Yes" 0 "No"
	label values e1_hhfirestation e1_hhfirestation

	label variable e1_policestation "W. Is there a : Police Station"
	note e1_policestation: "W. Is there a : Police Station"
	label define e1_policestation 1 "Yes" 0 "No"
	label values e1_policestation e1_policestation

	label variable e1_modpolicestation "W. Transport mode used to get to : Police station"
	note e1_modpolicestation: "W. Transport mode used to get to : Police station"
	label define e1_modpolicestation 1 "Walking" 2 "Bicycle" 3 "Mule/ donkey" 4 "Car/motorcycle" 5 "Bus/ microbus" 6 "Boat/ canoe" 99 "Other" -99 "Don't know"
	label values e1_modpolicestation e1_modpolicestation

	label variable e1_modpolicestationother "Specify other"
	note e1_modpolicestationother: "Specify other"

	label variable e1_timepolicestation "E.1.3 Necessary time to get to this services using \${e1_modpolice_e} \${e1_modp"
	note e1_timepolicestation: "E.1.3 Necessary time to get to this services using \${e1_modpolice_e} \${e1_modpolicestationother from your home (simple way)"

	label variable e1_hhpolicestation "Did a member of your HH used this services in the last 6 month ?"
	note e1_hhpolicestation: "Did a member of your HH used this services in the last 6 month ?"
	label define e1_hhpolicestation 1 "Yes" 0 "No"
	label values e1_hhpolicestation e1_hhpolicestation

	label variable e1_admincenter "Is there an Imada administrative center"
	note e1_admincenter: "Is there an Imada administrative center"
	label define e1_admincenter 1 "Yes" 0 "No"
	label values e1_admincenter e1_admincenter

	label variable e1_modadmincenter "Transport mode used to get to : Administrative center of Imada"
	note e1_modadmincenter: "Transport mode used to get to : Administrative center of Imada"
	label define e1_modadmincenter 1 "Walking" 2 "Bicycle" 3 "Mule/ donkey" 4 "Car/motorcycle" 5 "Bus/ microbus" 6 "Boat/ canoe" 99 "Other" -99 "Don't know"
	label values e1_modadmincenter e1_modadmincenter

	label variable e1_modadmincenterother "Specify other"
	note e1_modadmincenterother: "Specify other"

	label variable e1_timeadmincenter "E.1.3 Necessary time to get to this services using \${e1_modadmin_e}\${e1_modadm"
	note e1_timeadmincenter: "E.1.3 Necessary time to get to this services using \${e1_modadmin_e}\${e1_modadmincenterother} from your home (simple way)"

	label variable e1_hhadmincenter "Did a member of your HH used this services in the last 6 month ?"
	note e1_hhadmincenter: "Did a member of your HH used this services in the last 6 month ?"
	label define e1_hhadmincenter 1 "Yes" 0 "No"
	label values e1_hhadmincenter e1_hhadmincenter

	label variable e2_hh_conditions "E 2.1.Since January 2019, did you or someone from your HH felt sick and looked f"
	note e2_hh_conditions: "E 2.1.Since January 2019, did you or someone from your HH felt sick and looked for medical aid ?"
	label define e2_hh_conditions 1 "Yes" 0 "No"
	label values e2_hh_conditions e2_hh_conditions

	label variable e2_hh_conditios "E 2.0. What did you/they suffer from?"
	note e2_hh_conditios: "E 2.0. What did you/they suffer from?"

	label variable e2_hh_conditiosother "Specify other"
	note e2_hh_conditiosother: "Specify other"

	label variable e2_visitedservices "E.2.0.1. What services did they visit?"
	note e2_visitedservices: "E.2.0.1. What services did they visit?"

	label variable e2_hh_medicalcare "E 2.2. Where does your household usually seek medical care in case of an illness"
	note e2_hh_medicalcare: "E 2.2. Where does your household usually seek medical care in case of an illness?"
	label define e2_hh_medicalcare 1 "Hospital / Public Health Center" 2 "Private Health Center" 3 "NGO Health Center" 4 "Traditional Healers" 5 "Buy the medicine at the pharmacy" 6 "stay home" 7 "Centre de traitement du corona" 99 "Other (specify)"
	label values e2_hh_medicalcare e2_hh_medicalcare

	label variable e2_hh_medicalcareother "Specify other"
	note e2_hh_medicalcareother: "Specify other"

	label variable e2_hh_visitshservices "E 2.3 In the past few years, since January 2019, how many members of your househ"
	note e2_hh_visitshservices: "E 2.3 In the past few years, since January 2019, how many members of your household have visited a clinic or hospital for medical care?"

	label variable e2_hh_healthcare_spend "E 2.4 In the past years, since January 2019, how much money has your household s"
	note e2_hh_healthcare_spend: "E 2.4 In the past years, since January 2019, how much money has your household spent on this health care?"

	label variable e2_hhchildund7 "E 2.5 How many children aged 7 or under live in this household?"
	note e2_hhchildund7: "E 2.5 How many children aged 7 or under live in this household?"

	label variable e2_hhchilvac "E 2.6 How many of these children have been vaccinated in the course since Januar"
	note e2_hhchilvac: "E 2.6 How many of these children have been vaccinated in the course since January 2019?"

	label variable e2_fever "E 2.7. During the last 6 months, did any children suffer from: High Fever"
	note e2_fever: "E 2.7. During the last 6 months, did any children suffer from: High Fever"
	label define e2_fever 1 "Yes" 0 "No"
	label values e2_fever e2_fever

	label variable e2_fever1 "E 2.7. Have you brought your kids to the clinic or hospital for la fièvre élevée"
	note e2_fever1: "E 2.7. Have you brought your kids to the clinic or hospital for la fièvre élevée"
	label define e2_fever1 1 "Yes" 0 "No"
	label values e2_fever1 e2_fever1

	label variable e2_cough "E 2.8. During the last 6 months, did any children suffer from: La toux"
	note e2_cough: "E 2.8. During the last 6 months, did any children suffer from: La toux"
	label define e2_cough 1 "Yes" 0 "No"
	label values e2_cough e2_cough

	label variable e2_cough1 "E 2.8. Have you brought your kids to the clinic or hospital for: Cough"
	note e2_cough1: "E 2.8. Have you brought your kids to the clinic or hospital for: Cough"
	label define e2_cough1 1 "Yes" 0 "No"
	label values e2_cough1 e2_cough1

	label variable e2_diarrhea "E 2.9. During the last 6 months, did any children suffer from: diarrhea"
	note e2_diarrhea: "E 2.9. During the last 6 months, did any children suffer from: diarrhea"
	label define e2_diarrhea 1 "Yes" 0 "No"
	label values e2_diarrhea e2_diarrhea

	label variable e2_diarrhea1 "E 2.9. Have you brought your kids to the clinic or hospital for diarea"
	note e2_diarrhea1: "E 2.9. Have you brought your kids to the clinic or hospital for diarea"
	label define e2_diarrhea1 1 "Yes" 0 "No"
	label values e2_diarrhea1 e2_diarrhea1

	label variable e2_vomiting "E 2.10. During the last 6 months, did any children suffer from: Vomiting"
	note e2_vomiting: "E 2.10. During the last 6 months, did any children suffer from: Vomiting"
	label define e2_vomiting 1 "Yes" 0 "No"
	label values e2_vomiting e2_vomiting

	label variable e2_vomiting1 "E 2.10. Have you brought your kids to the clinic or hospital for vomiting"
	note e2_vomiting1: "E 2.10. Have you brought your kids to the clinic or hospital for vomiting"
	label define e2_vomiting1 1 "Yes" 0 "No"
	label values e2_vomiting1 e2_vomiting1

	label variable e2_chickenpox "E 2.11. During the last 6 months, did any children suffer from: chicken pox"
	note e2_chickenpox: "E 2.11. During the last 6 months, did any children suffer from: chicken pox"
	label define e2_chickenpox 1 "Yes" 0 "No"
	label values e2_chickenpox e2_chickenpox

	label variable e2_chickenpox1 "E 2.11. Have you brought your kids to the clinic or hospital for chicken pox"
	note e2_chickenpox1: "E 2.11. Have you brought your kids to the clinic or hospital for chicken pox"
	label define e2_chickenpox1 1 "Yes" 0 "No"
	label values e2_chickenpox1 e2_chickenpox1

	label variable e2_aththma "E 2.12. During the last 6 months, did any children suffer from: Asthma"
	note e2_aththma: "E 2.12. During the last 6 months, did any children suffer from: Asthma"
	label define e2_aththma 1 "Yes" 0 "No"
	label values e2_aththma e2_aththma

	label variable e2_aththma1 "E 2.12. Have you brought your kids to the clinic or hospital for asthma"
	note e2_aththma1: "E 2.12. Have you brought your kids to the clinic or hospital for asthma"
	label define e2_aththma1 1 "Yes" 0 "No"
	label values e2_aththma1 e2_aththma1

	label variable e2_smallmeasles "E 2.13. During the last 6 months, did any children suffer from: Small measles"
	note e2_smallmeasles: "E 2.13. During the last 6 months, did any children suffer from: Small measles"
	label define e2_smallmeasles 1 "Yes" 0 "No"
	label values e2_smallmeasles e2_smallmeasles

	label variable e2_smallmeasles1 "E 2.13. Have you brought your kids to the clinic or hospital for small measles"
	note e2_smallmeasles1: "E 2.13. Have you brought your kids to the clinic or hospital for small measles"
	label define e2_smallmeasles1 1 "Yes" 0 "No"
	label values e2_smallmeasles1 e2_smallmeasles1

	label variable e2_infectioneno "E 2.14. During the last 6 months, did any children suffer from: Ear or eyes infe"
	note e2_infectioneno: "E 2.14. During the last 6 months, did any children suffer from: Ear or eyes infection"
	label define e2_infectioneno 1 "Yes" 0 "No"
	label values e2_infectioneno e2_infectioneno

	label variable e2_infectioneno1 "E 2.14. Have you brought your kids to the clinic or hospital for the ear of eyes"
	note e2_infectioneno1: "E 2.14. Have you brought your kids to the clinic or hospital for the ear of eyes infection"
	label define e2_infectioneno1 1 "Yes" 0 "No"
	label values e2_infectioneno1 e2_infectioneno1

	label variable e2_pneumonia "E 2.15. During the last 6 months, did any children suffer from: Pneumonia ?"
	note e2_pneumonia: "E 2.15. During the last 6 months, did any children suffer from: Pneumonia ?"
	label define e2_pneumonia 1 "Yes" 0 "No"
	label values e2_pneumonia e2_pneumonia

	label variable e2_pneumonia1 "E 2.15. Have you brought your kids to the clinic or hospital for pneumonia"
	note e2_pneumonia1: "E 2.15. Have you brought your kids to the clinic or hospital for pneumonia"
	label define e2_pneumonia1 1 "Yes" 0 "No"
	label values e2_pneumonia1 e2_pneumonia1

	label variable e2_leukemia "E 2.17. During the last 6 months, did any children suffer from: Leukemia"
	note e2_leukemia: "E 2.17. During the last 6 months, did any children suffer from: Leukemia"
	label define e2_leukemia 1 "Yes" 0 "No"
	label values e2_leukemia e2_leukemia

	label variable e2_leukemia1 "E 2.17. Have you brought your kids to the clinic or hospital for leukemia"
	note e2_leukemia1: "E 2.17. Have you brought your kids to the clinic or hospital for leukemia"
	label define e2_leukemia1 1 "Yes" 0 "No"
	label values e2_leukemia1 e2_leukemia1

	label variable e2_othter "E.2.18 During the last 6 months, did any children suffer from another deases not"
	note e2_othter: "E.2.18 During the last 6 months, did any children suffer from another deases not listed above ?"
	label define e2_othter 1 "Yes" 0 "No"
	label values e2_othter e2_othter

	label variable e2_othterot "Specify other"
	note e2_othterot: "Specify other"

	label variable e2_othter1 "E.2.18 Have you brought your kids to the clinic or hospital for \${e2_othterot}"
	note e2_othter1: "E.2.18 Have you brought your kids to the clinic or hospital for \${e2_othterot}"
	label define e2_othter1 1 "Yes" 0 "No"
	label values e2_othter1 e2_othter1

	label variable e2_childdeath "E 2.18. Sometime si thappens that children die. It can be hurtful to think about"
	note e2_childdeath: "E 2.18. Sometime si thappens that children die. It can be hurtful to think about it, and I'm sorry talaving to talk about it. However it is important that we gather information on this. In total, how many children age 7 or less have died since January 2019?"

	label variable e2_childdeathreason "E 2.19. Do you mind telling me the the cause of death ? [SELECT ALL THAT APPLY]"
	note e2_childdeathreason: "E 2.19. Do you mind telling me the the cause of death ? [SELECT ALL THAT APPLY]"
	label define e2_childdeathreason 1 "Complications avec une maladi" 2 "Manque de soins médicaux / médicaments" 3 "malnutrition" 4 "Crime violent" 5 "Conflit armé / guerre" 6 "accident de la route" 7 ".Autre accident (p. Ex., Une chute ou impacts/collision)" 8 "Causes inconnues" 9 "Birth complication" -97 "Refuse to say" -99 "Don't know" 99 "Autre"
	label values e2_childdeathreason e2_childdeathreason

	label variable e2_childdeathreasonother "Specify other"
	note e2_childdeathreasonother: "Specify other"

	label variable pregnantwomen "E 2.20. Since January 2019, has any pregnant women lost the child they were carr"
	note pregnantwomen: "E 2.20. Since January 2019, has any pregnant women lost the child they were carrying ?"
	label define pregnantwomen 1 "Yes" 0 "No"
	label values pregnantwomen pregnantwomen

	label variable e2_healthcent "E 2.5. Do you think the health center is .."
	note e2_healthcent: "E 2.5. Do you think the health center is .."
	label define e2_healthcent 0 "Bad" 1 "Average" 2 "Good"
	label values e2_healthcent e2_healthcent

	label variable e2_buildingqal "A. The quality of the building"
	note e2_buildingqal: "A. The quality of the building"
	label define e2_buildingqal 0 "Bad" 1 "Average" 2 "Good"
	label values e2_buildingqal e2_buildingqal

	label variable e2_equipmentqal "B. Availability and quality of equipment"
	note e2_equipmentqal: "B. Availability and quality of equipment"
	label define e2_equipmentqal 0 "Bad" 1 "Average" 2 "Good"
	label values e2_equipmentqal e2_equipmentqal

	label variable e2_careqal "C. Quality of care"
	note e2_careqal: "C. Quality of care"
	label define e2_careqal 0 "Bad" 1 "Average" 2 "Good"
	label values e2_careqal e2_careqal

	label variable e2_staffqal "D. The competence of the nursing staff"
	note e2_staffqal: "D. The competence of the nursing staff"
	label define e2_staffqal 0 "Bad" 1 "Average" 2 "Good"
	label values e2_staffqal e2_staffqal

	label variable e2_nursingtiming "E. The hours of operations / presence of nursing staff"
	note e2_nursingtiming: "E. The hours of operations / presence of nursing staff"
	label define e2_nursingtiming 0 "Bad" 1 "Average" 2 "Good"
	label values e2_nursingtiming e2_nursingtiming

	label variable e2_communityinteraction "F. Interaction with the community"
	note e2_communityinteraction: "F. Interaction with the community"
	label define e2_communityinteraction 0 "Bad" 1 "Average" 2 "Good"
	label values e2_communityinteraction e2_communityinteraction

	label variable e2_costslevel "G. The affordability of healthcare costs"
	note e2_costslevel: "G. The affordability of healthcare costs"
	label define e2_costslevel 0 "Bad" 1 "Average" 2 "Good"
	label values e2_costslevel e2_costslevel

	label variable e2_healhinformation "H. The provision of health information (e.g. vaccination against epidemic diseas"
	note e2_healhinformation: "H. The provision of health information (e.g. vaccination against epidemic diseases)"
	label define e2_healhinformation 0 "Bad" 1 "Average" 2 "Good"
	label values e2_healhinformation e2_healhinformation

	label variable e3_educationinstitution "E 3.1. What type of educational institution do household children attend?"
	note e3_educationinstitution: "E 3.1. What type of educational institution do household children attend?"
	label define e3_educationinstitution 1 "Public" 2 "Private" 3 "Religious" 4 "Do not go to school" 5 "No school age children"
	label values e3_educationinstitution e3_educationinstitution

	label variable e3_educationcent "E 3.2. Do you think the institution is"
	note e3_educationcent: "E 3.2. Do you think the institution is"
	label define e3_educationcent 0 "Bad" 1 "Average" 2 "Good"
	label values e3_educationcent e3_educationcent

	label variable e3_educbuildingqal "A. The quality of the building"
	note e3_educbuildingqal: "A. The quality of the building"
	label define e3_educbuildingqal 0 "Bad" 1 "Average" 2 "Good"
	label values e3_educbuildingqal e3_educbuildingqal

	label variable e3_materialsqal "B. Availability and quality of books / other teaching materials"
	note e3_materialsqal: "B. Availability and quality of books / other teaching materials"
	label define e3_materialsqal 0 "Bad" 1 "Average" 2 "Good"
	label values e3_materialsqal e3_materialsqal

	label variable e3_educationqal "C. The quality of education"
	note e3_educationqal: "C. The quality of education"
	label define e3_educationqal 0 "Bad" 1 "Average" 2 "Good"
	label values e3_educationqal e3_educationqal

	label variable e3_teachersqal "D. The competence of teachers"
	note e3_teachersqal: "D. The competence of teachers"
	label define e3_teachersqal 0 "Bad" 1 "Average" 2 "Good"
	label values e3_teachersqal e3_teachersqal

	label variable e3_teacherstiming "E. The hours of operation / teacher presence"
	note e3_teacherstiming: "E. The hours of operation / teacher presence"
	label define e3_teacherstiming 0 "Bad" 1 "Average" 2 "Good"
	label values e3_teacherstiming e3_teacherstiming

	label variable e3_interactionparents "F. Interaction of teachers with parents/ children"
	note e3_interactionparents: "F. Interaction of teachers with parents/ children"
	label define e3_interactionparents 0 "Bad" 1 "Average" 2 "Good"
	label values e3_interactionparents e3_interactionparents

	label variable e3_educationcosts "G. The affordability of education costs"
	note e3_educationcosts: "G. The affordability of education costs"
	label define e3_educationcosts 0 "Bad" 1 "Average" 2 "Good"
	label values e3_educationcosts e3_educationcosts

	label variable e3_educationaccess "H. The accessibility of the education institution"
	note e3_educationaccess: "H. The accessibility of the education institution"
	label define e3_educationaccess 0 "Bad" 1 "Average" 2 "Good"
	label values e3_educationaccess e3_educationaccess

	label variable grant "Since January 2019, did you receive an unconditional cash grants or a commercial"
	note grant: "Since January 2019, did you receive an unconditional cash grants or a commercial loan ?"
	label define grant 0 "No" 1 "Yes a grant" 2 "Yes a commerical credit" 3 "Yes, both"
	label values grant grant

	label variable grant_oth "Do you know someone who receive an unconditional grant / commercial loan to star"
	note grant_oth: "Do you know someone who receive an unconditional grant / commercial loan to start an enterprise?"
	label define grant_oth 1 "Yes" 0 "No"
	label values grant_oth grant_oth

	label variable grant_oth_who "Who ?"
	note grant_oth_who: "Who ?"

	label variable grant_amount "How much did you receive (in Dinars)"
	note grant_amount: "How much did you receive (in Dinars)"

	label variable grant_form "How did you receive the grant?"
	note grant_form: "How did you receive the grant?"
	label define grant_form 1 "Cash" 2 "Wire transfer"
	label values grant_form grant_form

	label variable grant_received "Did you went get the cash by yourself, someone came with you or someone went ins"
	note grant_received: "Did you went get the cash by yourself, someone came with you or someone went instead of you ?"
	label define grant_received 1 "By myself" 2 "With someone else" 3 "Someone went instead of me"
	label values grant_received grant_received

	label variable grant_received_with "Who ?"
	note grant_received_with: "Who ?"
	label define grant_received_with 1 "Chef de ménage" 2 "Père/Mère" 3 "Grand parent" 4 "Epoux/relation religieuse" 5 "Enfant (incl. Adoption)" 6 "Frère ou sœur" 7 "Oncle ou tante" 8 "Nièce ou neveu" 9 "Petit-fils/petite-fille" 10 "Beaux-parents" 11 "Beau-frère/sœur" 12 "Cousin" 14 "Beau fils/belle fille" 15 "Friends" 16 "Coworkers" 17 "No Member" 99 "Autre"
	label values grant_received_with grant_received_with

	label variable grant_use "How did you use the grant ?"
	note grant_use: "How did you use the grant ?"

	label variable grant_use_3 "To whom belong this business"
	note grant_use_3: "To whom belong this business"
	label define grant_use_3 1 "Chef de ménage" 2 "Père/Mère" 3 "Grand parent" 4 "Epoux/relation religieuse" 5 "Enfant (incl. Adoption)" 6 "Frère ou sœur" 7 "Oncle ou tante" 8 "Nièce ou neveu" 9 "Petit-fils/petite-fille" 10 "Beaux-parents" 11 "Beau-frère/sœur" 12 "Cousin" 14 "Beau fils/belle fille" 15 "Friends" 16 "Coworkers" 17 "No Member" 99 "Autre"
	label values grant_use_3 grant_use_3

	label variable grant_bus_prev "Is it the same business as the one you mentionned in the employment section ?"
	note grant_bus_prev: "Is it the same business as the one you mentionned in the employment section ?"
	label define grant_bus_prev 1 "Yes" 0 "No"
	label values grant_bus_prev grant_bus_prev

	label variable business_own_3 "Are you the owner of this business ?"
	note business_own_3: "Are you the owner of this business ?"
	label define business_own_3 1 "Yes" 0 "No"
	label values business_own_3 business_own_3

	label variable business_noown_3 "Who is the owner of this business ?"
	note business_noown_3: "Who is the owner of this business ?"
	label define business_noown_3 1 "Chef de ménage" 2 "Père/Mère" 3 "Grand parent" 4 "Epoux/relation religieuse" 5 "Enfant (incl. Adoption)" 6 "Frère ou sœur" 7 "Oncle ou tante" 8 "Nièce ou neveu" 9 "Petit-fils/petite-fille" 10 "Beaux-parents" 11 "Beau-frère/sœur" 12 "Cousin" 14 "Beau fils/belle fille" 15 "Friends" 16 "Coworkers" 17 "No Member" 99 "Autre"
	label values business_noown_3 business_noown_3

	label variable business_employee_3 "1. no of employees"
	note business_employee_3: "1. no of employees"

	label variable business_supply_3 "2. no of suppliers"
	note business_supply_3: "2. no of suppliers"

	label variable business_profit_3 "4. monthly profits"
	note business_profit_3: "4. monthly profits"

	label variable business_hours_3 "6. hours dedicated to the business per week"
	note business_hours_3: "6. hours dedicated to the business per week"

	label variable business_partner_3 "Do you have any business partner?"
	note business_partner_3: "Do you have any business partner?"
	label define business_partner_3 1 "Yes" 0 "No"
	label values business_partner_3 business_partner_3

	label variable business_partner_f_3 "How many female business partner"
	note business_partner_f_3: "How many female business partner"

	label variable business_partner_m_3 "How many male business partner"
	note business_partner_m_3: "How many male business partner"

	label variable business_q6_3 "Have you register in a notebook expenses and profit related to the activity of t"
	note business_q6_3: "Have you register in a notebook expenses and profit related to the activity of this business ?"
	label define business_q6_3 1 "Yes" 0 "No"
	label values business_q6_3 business_q6_3

	label variable business_q7_3 "Is it a registered business ?"
	note business_q7_3: "Is it a registered business ?"
	label define business_q7_3 1 "Yes" 0 "No"
	label values business_q7_3 business_q7_3

	label variable business_q8_3 "Do you pay taxes for your business ?"
	note business_q8_3: "Do you pay taxes for your business ?"
	label define business_q8_3 1 "Yes" 0 "No"
	label values business_q8_3 business_q8_3

	label variable business_q9_3 "How much did you paid last year ?"
	note business_q9_3: "How much did you paid last year ?"
	label define business_q9_3 1 "Yes" 0 "No"
	label values business_q9_3 business_q9_3

	label variable grant_business "Is the business still running?"
	note grant_business: "Is the business still running?"
	label define grant_business 1 "Yes" 0 "No"
	label values grant_business grant_business

	label variable grant_tried "Did you try to secure a grant or commercial credit ?"
	note grant_tried: "Did you try to secure a grant or commercial credit ?"
	label define grant_tried 1 "Yes" 0 "No"
	label values grant_tried grant_tried

	label variable grants_noresaon "Why were you not able to secure a credit or grant ?"
	note grants_noresaon: "Why were you not able to secure a credit or grant ?"
	label define grants_noresaon 1 "I don't have a bank account" 2 "I don't have a guarantee" 3 "I don't have the necessary repayment capacity" 4 "No banking service in the delegation" 5 "The rates offered are too expensive"
	label values grants_noresaon grants_noresaon

	label variable participate_module "Since January 2019, did you participate in financial and/or vocation training of"
	note participate_module: "Since January 2019, did you participate in financial and/or vocation training of any kind ?"
	label define participate_module 1 "Yes" 0 "No"
	label values participate_module participate_module

	label variable sessions_participated "How many sessions did you participate in?"
	note sessions_participated: "How many sessions did you participate in?"

	label variable participated_whom "Is there anyother member of your household who took part to any such or similar "
	note participated_whom: "Is there anyother member of your household who took part to any such or similar training during the same period (since January 2019)"
	label define participated_whom 1 "Chef de ménage" 2 "Père/Mère" 3 "Grand parent" 4 "Epoux/relation religieuse" 5 "Enfant (incl. Adoption)" 6 "Frère ou sœur" 7 "Oncle ou tante" 8 "Nièce ou neveu" 9 "Petit-fils/petite-fille" 10 "Beaux-parents" 11 "Beau-frère/sœur" 12 "Cousin" 14 "Beau fils/belle fille" 15 "Friends" 16 "Coworkers" 17 "No Member" 99 "Autre"
	label values participated_whom participated_whom

	label variable covid_know "I.1. Are you aware of the COVID-19 pendemic in Tunisia?"
	note covid_know: "I.1. Are you aware of the COVID-19 pendemic in Tunisia?"
	label define covid_know 1 "Yes" 0 "No"
	label values covid_know covid_know

	label variable covid_knowsick "I.2. Do you know anyone personally who has contracted the illness?"
	note covid_knowsick: "I.2. Do you know anyone personally who has contracted the illness?"
	label define covid_knowsick 1 "Yes" 0 "No"
	label values covid_knowsick covid_knowsick

	label variable covid_meetings "I.4. Has the imada ever organized meetings or sensitization campaigns about COVI"
	note covid_meetings: "I.4. Has the imada ever organized meetings or sensitization campaigns about COVID in the last 6 months?"
	label define covid_meetings 1 "Yes" 0 "No"
	label values covid_meetings covid_meetings

	label variable covid_meetings_count "I.5. How many meetings, just in the last 4 weeks?"
	note covid_meetings_count: "I.5. How many meetings, just in the last 4 weeks?"

	label variable prep_covid "I.3. Has this imada taken any step to prepare for the COVID epidemic? [Interview"
	note prep_covid: "I.3. Has this imada taken any step to prepare for the COVID epidemic? [Interviewer: read response options]"
	label define prep_covid 1 "Yes" 0 "No"
	label values prep_covid prep_covid

	label variable ban_gather "I.3.1. Ban gatherings"
	note ban_gather: "I.3.1. Ban gatherings"

	label variable resid_educ_meeting "I.3.2. Community meeting to educate residents"
	note resid_educ_meeting: "I.3.2. Community meeting to educate residents"

	label variable hhvisit_educ "I.3.3. Household visits to educate residents"
	note hhvisit_educ: "I.3.3. Household visits to educate residents"

	label variable curfew "I.3.4. Declare curfew"
	note curfew: "I.3.4. Declare curfew"

	label variable close_shops "I.3.5. Close shops"
	note close_shops: "I.3.5. Close shops"

	label variable give_handwash_water "I.3.6. Provide hand washing materials or water"
	note give_handwash_water: "I.3.6. Provide hand washing materials or water"

	label variable prep_covid_o "I.3.11. Other measures (Specify)"
	note prep_covid_o: "I.3.11. Other measures (Specify)"

	label variable covid_lost_job "I.6. Has anyone in your household (including you) lost their job (or main source"
	note covid_lost_job: "I.6. Has anyone in your household (including you) lost their job (or main source of income) since the coronavirus epidemic began?"
	label define covid_lost_job 1 "Yes" 0 "No"
	label values covid_lost_job covid_lost_job

	label variable covid_new_job "I.7. Have you or anyone in your household gained a new job (or main source of in"
	note covid_new_job: "I.7. Have you or anyone in your household gained a new job (or main source of income) since the coronavirus epidemic began?"
	label define covid_new_job 1 "Yes" 0 "No"
	label values covid_new_job covid_new_job

	label variable covid_change_inc "I.8. Think of the income your HH earned each month before the coronavirus epidem"
	note covid_change_inc: "I.8. Think of the income your HH earned each month before the coronavirus epidemic began. How does that compare to the income you are earning now?"
	label define covid_change_inc 1 "Making more income than before the coronavirus epidemic began?" 2 "Making about the same income you were making before the coronavirus epidemic beg" 3 "Making less income than before the coronavirus epidemic began?"
	label values covid_change_inc covid_change_inc

	label variable covid_gov_action "I.9. In the past 6 months: Has the government udertaken actions to support livel"
	note covid_gov_action: "I.9. In the past 6 months: Has the government udertaken actions to support livelihoods of people in this imada because of COVID-19?"
	label define covid_gov_action 1 "Yes" 0 "No"
	label values covid_gov_action covid_gov_action

	label variable covid_ngo_action "I.10. In the past 6 months: Have international NGOs udertaken actions to support"
	note covid_ngo_action: "I.10. In the past 6 months: Have international NGOs udertaken actions to support livelihoods of people in this imada because of COVID-19?"
	label define covid_ngo_action 1 "Yes" 0 "No"
	label values covid_ngo_action covid_ngo_action

	label variable covid_concerned_1 "I.11. How concerned are you that you or any family member could contract COVID i"
	note covid_concerned_1: "I.11. How concerned are you that you or any family member could contract COVID in the next 12 months?"
	label define covid_concerned_1 1 "Not concerned at all" 2 "Not very concerned" 3 "Neither concerned nor unconcerned" 4 "Somewhat concerned" 5 "Very concerned"
	label values covid_concerned_1 covid_concerned_1

	label variable covid_concerned_2 "I.12. How concerned are you that you or any family member could lose your job or"
	note covid_concerned_2: "I.12. How concerned are you that you or any family member could lose your job or business in the next 12 months?"
	label define covid_concerned_2 1 "Not concerned at all" 2 "Not very concerned" 3 "Neither concerned nor unconcerned" 4 "Somewhat concerned" 5 "Very concerned"
	label values covid_concerned_2 covid_concerned_2

	label variable covid_change "I.14. Did you notice any change with the business situation, compared to the per"
	note covid_change: "I.14. Did you notice any change with the business situation, compared to the period pre health crisis ?"
	label define covid_change 1 "Yes" 0 "No"
	label values covid_change covid_change

	label variable covid_compare "I.15. How would you characterize your business situation compared to the period "
	note covid_compare: "I.15. How would you characterize your business situation compared to the period pre health crisis ?"
	label define covid_compare 1 "Way worst" 2 "Worst" 3 "Same" 4 "Better" 5 "Way better"
	label values covid_compare covid_compare

	label variable covid_worst "I.16 What has made the situation worst than before the health crisis ?"
	note covid_worst: "I.16 What has made the situation worst than before the health crisis ?"

	label variable covid_support "1.17. In the last 2 weeks, did your business received support from the governmen"
	note covid_support: "1.17. In the last 2 weeks, did your business received support from the government ?"
	label define covid_support 1 "Yes" 0 "No"
	label values covid_support covid_support

	label variable covid_action "I.20. Did you had to take any of the following action:"
	note covid_action: "I.20. Did you had to take any of the following action:"
	label define covid_action 1 "Yes" 0 "No"
	label values covid_action covid_action

	label variable covid_action_1 "I.21. Lay off employee ?"
	note covid_action_1: "I.21. Lay off employee ?"
	label define covid_action_1 1 "Yes" 0 "No"
	label values covid_action_1 covid_action_1

	label variable covid_action_2 "I.22. Reduce capital spending ?"
	note covid_action_2: "I.22. Reduce capital spending ?"
	label define covid_action_2 1 "Yes" 0 "No"
	label values covid_action_2 covid_action_2

	label variable covid_action_3 "I.23. Delay debt repayment"
	note covid_action_3: "I.23. Delay debt repayment"
	label define covid_action_3 1 "Yes" 0 "No"
	label values covid_action_3 covid_action_3

	label variable j16 "Economic condition of this Imada are: WORST, SAME, BETTER than other imadas of t"
	note j16: "Economic condition of this Imada are: WORST, SAME, BETTER than other imadas of this delegation"
	label define j16 1 "Way worst" 2 "Worst" 3 "Same" 4 "Better" 5 "Way better"
	label values j16 j16

	label variable j17 "Economic condition of your household are: WORST, SAME, BETTER than before covid "
	note j17: "Economic condition of your household are: WORST, SAME, BETTER than before covid 19"
	label define j17 1 "Way worst" 2 "Worst" 3 "Same" 4 "Better" 5 "Way better"
	label values j17 j17

	label variable g1_farmersgroup "A. Does the following group or asc exist: A farmer’s group/cooperative"
	note g1_farmersgroup: "A. Does the following group or asc exist: A farmer’s group/cooperative"
	label define g1_farmersgroup 1 "Yes" 0 "No"
	label values g1_farmersgroup g1_farmersgroup

	label variable g1_hhinfarmersgroup "A. Are you or anyone else from your HH a member of : A farmer’s group/cooperativ"
	note g1_hhinfarmersgroup: "A. Are you or anyone else from your HH a member of : A farmer’s group/cooperative"
	label define g1_hhinfarmersgroup 1 "Yes" 0 "No"
	label values g1_hhinfarmersgroup g1_hhinfarmersgroup

	label variable g1_farmersgroupship "A. Does the group accept members who are not from this village/community: A farm"
	note g1_farmersgroupship: "A. Does the group accept members who are not from this village/community: A farmer’s group/cooperative"
	label define g1_farmersgroupship 1 "Yes" 0 "No"
	label values g1_farmersgroupship g1_farmersgroupship

	label variable g1_womengroup "D. Does the following group or asc exist: Women’s group"
	note g1_womengroup: "D. Does the following group or asc exist: Women’s group"
	label define g1_womengroup 1 "Yes" 0 "No"
	label values g1_womengroup g1_womengroup

	label variable g1_hhinwomengroup "D. Are you or anyone else from your HH a member of : Women’s group"
	note g1_hhinwomengroup: "D. Are you or anyone else from your HH a member of : Women’s group"
	label define g1_hhinwomengroup 1 "Yes" 0 "No"
	label values g1_hhinwomengroup g1_hhinwomengroup

	label variable g1_womengroupship "D. Does the group accept members who are not from this village/community: Women’"
	note g1_womengroupship: "D. Does the group accept members who are not from this village/community: Women’s group"
	label define g1_womengroupship 1 "Yes" 0 "No"
	label values g1_womengroupship g1_womengroupship

	label variable g1_humancomnitygroup "H. Does the following group or asc exist: Human rights/ NGO/ community group"
	note g1_humancomnitygroup: "H. Does the following group or asc exist: Human rights/ NGO/ community group"
	label define g1_humancomnitygroup 1 "Yes" 0 "No"
	label values g1_humancomnitygroup g1_humancomnitygroup

	label variable g1_hhinhumancomnitygroup "H. Are you or anyone else from your HH a member of : Human rights/ NGO/ communit"
	note g1_hhinhumancomnitygroup: "H. Are you or anyone else from your HH a member of : Human rights/ NGO/ community group"
	label define g1_hhinhumancomnitygroup 1 "Yes" 0 "No"
	label values g1_hhinhumancomnitygroup g1_hhinhumancomnitygroup

	label variable g1_humancomnitygroupship "H. Does the group accept members who are not from this village/community: Human "
	note g1_humancomnitygroupship: "H. Does the group accept members who are not from this village/community: Human rights/ NGO/ community group"
	label define g1_humancomnitygroupship 1 "Yes" 0 "No"
	label values g1_humancomnitygroupship g1_humancomnitygroupship

	label variable g1_religiousgroup "I. Does the following group or asc exist: An asc affiliated to the church / mosq"
	note g1_religiousgroup: "I. Does the following group or asc exist: An asc affiliated to the church / mosque"
	label define g1_religiousgroup 1 "Yes" 0 "No"
	label values g1_religiousgroup g1_religiousgroup

	label variable g1_hhinreligiousgroup "I. Are you or anyone else from your HH a member of :An asc affiliated to the chu"
	note g1_hhinreligiousgroup: "I. Are you or anyone else from your HH a member of :An asc affiliated to the church / mosque"
	label define g1_hhinreligiousgroup 1 "Yes" 0 "No"
	label values g1_hhinreligiousgroup g1_hhinreligiousgroup

	label variable g1_religiousgroupship "I. Does the group accept members who are not from this village/community: An asc"
	note g1_religiousgroupship: "I. Does the group accept members who are not from this village/community: An asc affiliated to the church / mosque"
	label define g1_religiousgroupship 1 "Yes" 0 "No"
	label values g1_religiousgroupship g1_religiousgroupship

	label variable g1_politicalass "J. Does the following group or asc exist: Political asc"
	note g1_politicalass: "J. Does the following group or asc exist: Political asc"
	label define g1_politicalass 1 "Yes" 0 "No"
	label values g1_politicalass g1_politicalass

	label variable g1_hhinpoliticalasc "J. Are you or anyone else from your HH a member of :Political asc"
	note g1_hhinpoliticalasc: "J. Are you or anyone else from your HH a member of :Political asc"
	label define g1_hhinpoliticalasc 1 "Yes" 0 "No"
	label values g1_hhinpoliticalasc g1_hhinpoliticalasc

	label variable g1_politicalascship "J. Does the group accept members who are not from this village/community: Politi"
	note g1_politicalascship: "J. Does the group accept members who are not from this village/community: Political asc"
	label define g1_politicalascship 1 "Yes" 0 "No"
	label values g1_politicalascship g1_politicalascship

	label variable g1_savingscreditgroup "K. Does the following group or asc exist: Savings and credit group"
	note g1_savingscreditgroup: "K. Does the following group or asc exist: Savings and credit group"
	label define g1_savingscreditgroup 1 "Yes" 0 "No"
	label values g1_savingscreditgroup g1_savingscreditgroup

	label variable g1_hhinsavingscreditgroup "K. Are you or anyone else from your HH a member of : Savings and credit group"
	note g1_hhinsavingscreditgroup: "K. Are you or anyone else from your HH a member of : Savings and credit group"
	label define g1_hhinsavingscreditgroup 1 "Yes" 0 "No"
	label values g1_hhinsavingscreditgroup g1_hhinsavingscreditgroup

	label variable g1_savingscreditgroupship "K. Does the group accept members who are not from this village/community: Saving"
	note g1_savingscreditgroupship: "K. Does the group accept members who are not from this village/community: Savings and credit group"
	label define g1_savingscreditgroupship 1 "Yes" 0 "No"
	label values g1_savingscreditgroupship g1_savingscreditgroupship

	label variable g1_groupother "L. Does the following group or asc exist: Other"
	note g1_groupother: "L. Does the following group or asc exist: Other"
	label define g1_groupother 1 "Yes" 0 "No"
	label values g1_groupother g1_groupother

	label variable g1_othergroup "Specify other"
	note g1_othergroup: "Specify other"

	label variable g1_hhinother1 "L. Are you or anyone else from your HH a member of : \${g1_othergroup}"
	note g1_hhinother1: "L. Are you or anyone else from your HH a member of : \${g1_othergroup}"
	label define g1_hhinother1 1 "Yes" 0 "No"
	label values g1_hhinother1 g1_hhinother1

	label variable g1_othership "L. Does the group accept members who are not from this village/community: \${g1_"
	note g1_othership: "L. Does the group accept members who are not from this village/community: \${g1_othergroup}"
	label define g1_othership 1 "Yes" 0 "No"
	label values g1_othership g1_othership

	label variable g1_healthprjt "A. In the past 6 months, has the sub-district/imada undertaken the following vol"
	note g1_healthprjt: "A. In the past 6 months, has the sub-district/imada undertaken the following voluntary project : Rebuild (restore) a school or a clinic / dispensary?"
	label define g1_healthprjt 1 "Yes" 0 "No"
	label values g1_healthprjt g1_healthprjt

	label variable g1_inithealthprjt "A. Who took the initiative for the following project: Rebuild (restore) a school"
	note g1_inithealthprjt: "A. Who took the initiative for the following project: Rebuild (restore) a school or a clinic / dispensary?"

	label variable g1_hhhealthprjt "A. Did your household contribute to the following project in time, money or labo"
	note g1_hhhealthprjt: "A. Did your household contribute to the following project in time, money or labor : Rebuild (restore) a school or a clinic / dispensary?"
	label define g1_hhhealthprjt 1 "Yes" 0 "No"
	label values g1_hhhealthprjt g1_hhhealthprjt

	label variable g1_resphealthprjt "A. Did Residents of other neighborhood participate to the following project: Reb"
	note g1_resphealthprjt: "A. Did Residents of other neighborhood participate to the following project: Rebuild (restore) a school or a clinic / dispensary?"
	label define g1_resphealthprjt 1 "Yes" 0 "No"
	label values g1_resphealthprjt g1_resphealthprjt

	label variable g1_roadprjt "B. In the past 6 months, has the sub-district/imada undertaken the following vol"
	note g1_roadprjt: "B. In the past 6 months, has the sub-district/imada undertaken the following voluntary project : Clearing brush or enlarge the road?"
	label define g1_roadprjt 1 "Yes" 0 "No"
	label values g1_roadprjt g1_roadprjt

	label variable g1_initroadprjt "B. Who took the initiative for the following project: Clearing brush or enlarge "
	note g1_initroadprjt: "B. Who took the initiative for the following project: Clearing brush or enlarge the road?"

	label variable g1_hhroadprjt "B. Did your household contribute to the following project in time, money or labo"
	note g1_hhroadprjt: "B. Did your household contribute to the following project in time, money or labor : Clearing brush or enlarge the road?"
	label define g1_hhroadprjt 1 "Yes" 0 "No"
	label values g1_hhroadprjt g1_hhroadprjt

	label variable g1_resproadprjt "B. Did Residents of other neighborhood participate to the following project: Cle"
	note g1_resproadprjt: "B. Did Residents of other neighborhood participate to the following project: Clearing brush or enlarge the road?"
	label define g1_resproadprjt 1 "Yes" 0 "No"
	label values g1_resproadprjt g1_resproadprjt

	label variable g1_waterprojet "C. In the past 6 months, has the sub-district/imada undertaken the following vol"
	note g1_waterprojet: "C. In the past 6 months, has the sub-district/imada undertaken the following voluntary project : Dig or repair a well or tap?"
	label define g1_waterprojet 1 "Yes" 0 "No"
	label values g1_waterprojet g1_waterprojet

	label variable g1_initwaterprojet "C. Who took the initiative for the following project: Dig or repair a well or ta"
	note g1_initwaterprojet: "C. Who took the initiative for the following project: Dig or repair a well or tap?"

	label variable g1_hhwaterprojet "C. Did your household contribute to the following project in time, money or labo"
	note g1_hhwaterprojet: "C. Did your household contribute to the following project in time, money or labor : Dig or repair a well or tap?"
	label define g1_hhwaterprojet 1 "Yes" 0 "No"
	label values g1_hhwaterprojet g1_hhwaterprojet

	label variable g1_respwaterprojet "C. Did Residents of other neighborhood participate to the following project: Dig"
	note g1_respwaterprojet: "C. Did Residents of other neighborhood participate to the following project: Dig or repair a well or tap?"
	label define g1_respwaterprojet 1 "Yes" 0 "No"
	label values g1_respwaterprojet g1_respwaterprojet

	label variable g1_securityprjt "D. In the past 6 months, has the sub-district/imada undertaken the following vol"
	note g1_securityprjt: "D. In the past 6 months, has the sub-district/imada undertaken the following voluntary project : Organize patrols to secure the village/ neighborhood?"
	label define g1_securityprjt 1 "Yes" 0 "No"
	label values g1_securityprjt g1_securityprjt

	label variable g1_initsecurityprjt "D Who took the initiative for the following project: . Organize patrols to secur"
	note g1_initsecurityprjt: "D Who took the initiative for the following project: . Organize patrols to secure the village/ neighborhood?"

	label variable g1_hhsecurityprjt "D. Did your household contribute to the following project in time, money or labo"
	note g1_hhsecurityprjt: "D. Did your household contribute to the following project in time, money or labor : Organize patrols to secure the village/ neighborhood?"
	label define g1_hhsecurityprjt 1 "Yes" 0 "No"
	label values g1_hhsecurityprjt g1_hhsecurityprjt

	label variable g1_respsecurityprjt "D. Did Residents of other neighborhood participate to the following project: Org"
	note g1_respsecurityprjt: "D. Did Residents of other neighborhood participate to the following project: Organize patrols to secure the village/ neighborhood?"
	label define g1_respsecurityprjt 1 "Yes" 0 "No"
	label values g1_respsecurityprjt g1_respsecurityprjt

	label variable g1_religiousprjt "E. In the past 6 months, has the sub-district/imada undertaken the following vol"
	note g1_religiousprjt: "E. In the past 6 months, has the sub-district/imada undertaken the following voluntary project : Rebuild a mosque or church?"
	label define g1_religiousprjt 1 "Yes" 0 "No"
	label values g1_religiousprjt g1_religiousprjt

	label variable g1_initreligiousprjt "E. Who took the initiative for the following project: Rebuild a mosque or church"
	note g1_initreligiousprjt: "E. Who took the initiative for the following project: Rebuild a mosque or church?"

	label variable g1_hhreligiousprjt "E. Did your household contribute to the following project in time, money or labo"
	note g1_hhreligiousprjt: "E. Did your household contribute to the following project in time, money or labor : Rebuild a mosque or church?"
	label define g1_hhreligiousprjt 1 "Yes" 0 "No"
	label values g1_hhreligiousprjt g1_hhreligiousprjt

	label variable g1_respreligiousprjt "E. Did Residents of other neighborhood participate to the following project: Reb"
	note g1_respreligiousprjt: "E. Did Residents of other neighborhood participate to the following project: Rebuild a mosque or church?"
	label define g1_respreligiousprjt 1 "Yes" 0 "No"
	label values g1_respreligiousprjt g1_respreligiousprjt

	label variable g1_marketprjt "F. In the past 6 months, has the sub-district/imada undertaken the following vol"
	note g1_marketprjt: "F. In the past 6 months, has the sub-district/imada undertaken the following voluntary project : Build a market"
	label define g1_marketprjt 1 "Yes" 0 "No"
	label values g1_marketprjt g1_marketprjt

	label variable g1_initmarketprjt "F Who took the initiative for the following project: . Build a market"
	note g1_initmarketprjt: "F Who took the initiative for the following project: . Build a market"

	label variable g1_hhmarketprjt "F. Did your household contribute to the following project in time, money or labo"
	note g1_hhmarketprjt: "F. Did your household contribute to the following project in time, money or labor : Build a market"
	label define g1_hhmarketprjt 1 "Yes" 0 "No"
	label values g1_hhmarketprjt g1_hhmarketprjt

	label variable g1_respmarketprjt "F. Did Residents of other neighborhood participate to the following project: Bui"
	note g1_respmarketprjt: "F. Did Residents of other neighborhood participate to the following project: Build a market"
	label define g1_respmarketprjt 1 "Yes" 0 "No"
	label values g1_respmarketprjt g1_respmarketprjt

	label variable g1_otherprjt "G. In the past 6 months, has the sub-district/imada undertaken the following vol"
	note g1_otherprjt: "G. In the past 6 months, has the sub-district/imada undertaken the following voluntary project : Other [SPECIFY]"
	label define g1_otherprjt 1 "Yes" 0 "No"
	label values g1_otherprjt g1_otherprjt

	label variable g1_otherproject "G. SPECIFY other"
	note g1_otherproject: "G. SPECIFY other"

	label variable g1_initotherprjt "G. Who took the initiative for the following project: \${g1_otherproject}"
	note g1_initotherprjt: "G. Who took the initiative for the following project: \${g1_otherproject}"

	label variable g1_hhotherprjt "G. Did your household contribute to the following project in time, money or labo"
	note g1_hhotherprjt: "G. Did your household contribute to the following project in time, money or labor : \${g1_otherproject} ?"
	label define g1_hhotherprjt 1 "Yes" 0 "No"
	label values g1_hhotherprjt g1_hhotherprjt

	label variable g1_respotherprjt "G. Did Residents of other neighborhood participate to the following project: \${"
	note g1_respotherprjt: "G. Did Residents of other neighborhood participate to the following project: \${g1_otherproject} ?"
	label define g1_respotherprjt 1 "Yes" 0 "No"
	label values g1_respotherprjt g1_respotherprjt

	label variable g1_hhfeeling "J.1.54. Do you feel that your neighbors understand and/or treat you and your hou"
	note g1_hhfeeling: "J.1.54. Do you feel that your neighbors understand and/or treat you and your household well?"
	label define g1_hhfeeling 1 "1.Always" 2 "2.Sometimes" 3 "3.Never"
	label values g1_hhfeeling g1_hhfeeling

	label variable g1_hhtrouble "J.1.55. In the lax six months, how often have you had trouble getting along with"
	note g1_hhtrouble: "J.1.55. In the lax six months, how often have you had trouble getting along with your neighbors?"
	label define g1_hhtrouble 1 "1.Often" 2 "2.Sometimes" 3 "3.Almost never"
	label values g1_hhtrouble g1_hhtrouble

	label variable g1_hhimportant "J.1.56. To what extent do you feel an important part of your village/ neighborho"
	note g1_hhimportant: "J.1.56. To what extent do you feel an important part of your village/ neighborhood?"
	label define g1_hhimportant 1 "1.Very important" 2 "2.Somewhat" 3 "3.Not at all"
	label values g1_hhimportant g1_hhimportant

	label variable g1_hhtrust "J.1.57. In general, do you trust people in your village/ neighborhood?"
	note g1_hhtrust: "J.1.57. In general, do you trust people in your village/ neighborhood?"
	label define g1_hhtrust 1 "1.Very much" 2 "2.Somewhat" 3 "3.Not at all"
	label values g1_hhtrust g1_hhtrust

	label variable g1_villagtrust "J.1.58. In general, do feel people in this village/ neighborhood trust you?"
	note g1_villagtrust: "J.1.58. In general, do feel people in this village/ neighborhood trust you?"
	label define g1_villagtrust 1 "1.Very much" 2 "2.Somewhat" 3 "3.Not at all"
	label values g1_villagtrust g1_villagtrust

	label variable g1_respectelders "J.1.59. Do you feel a great deal of respect for the elders in your village/ neig"
	note g1_respectelders: "J.1.59. Do you feel a great deal of respect for the elders in your village/ neighborhood?"
	label define g1_respectelders 1 "1.Always" 2 "2.Sometimes" 3 "3.Never"
	label values g1_respectelders g1_respectelders

	label variable g1_vulnerablservice "J.1.60. How important is it to provide service to vulnerable people such as the "
	note g1_vulnerablservice: "J.1.60. How important is it to provide service to vulnerable people such as the poor, elderly, migrants or people w/ disability?"
	label define g1_vulnerablservice 1 "1.Very much" 2 "2.Somewhat" 3 "3.Not at all"
	label values g1_vulnerablservice g1_vulnerablservice

	label variable g1_newcomersconditions "J.1.61. To what extent have the newcomers (migrants; refugees, etc.) in your vil"
	note g1_newcomersconditions: "J.1.61. To what extent have the newcomers (migrants; refugees, etc.) in your village/ neighborhood worsened the economic conditions (for example, lead to rising food prices or criminality)?"
	label define g1_newcomersconditions 1 "1.Very much" 2 "2.Somewhat" 3 "3.Not at all"
	label values g1_newcomersconditions g1_newcomersconditions

	label variable g1_managementlead "J.1.62. If the village received 1000 Dinars for its development, who should be g"
	note g1_managementlead: "J.1.62. If the village received 1000 Dinars for its development, who should be given the responsibility to manage that amount to ensure that the money is used for the welfare of the village?"
	label define g1_managementlead 1 "National Gov / Governorat" 2 "NGO" 3 "Omda" 4 "Village member" 5 "Private company" 6 "Other" 0 "Nobody" -97 "Refuse to say" -99 "Don't know"
	label values g1_managementlead g1_managementlead

	label variable g1_mangmtleadother "J.1.62.1. Specify other"
	note g1_mangmtleadother: "J.1.62.1. Specify other"

	label variable g1_projecttradeoff "J.1.63. If an NGO had a significant sum to use for development projects, would y"
	note g1_projecttradeoff: "J.1.63. If an NGO had a significant sum to use for development projects, would you prefer that it implements a big project in this village/ neighborhood [A], or two small projects – one in this village/ neighborhood and the other in a similar village/ neighborhood in your area [B]?"
	label define g1_projecttradeoff 1 "1 project (A)" 2 "2 projects (B)"
	label values g1_projecttradeoff g1_projecttradeoff

	label variable g1_fundsdonat "J.1.64 In the past 6 months, have you DONATED funds to charitable organizations?"
	note g1_fundsdonat: "J.1.64 In the past 6 months, have you DONATED funds to charitable organizations?"
	label define g1_fundsdonat 1 "Yes" 0 "No"
	label values g1_fundsdonat g1_fundsdonat

	label variable g1_fundsdonatamount "J.1.65 How much money (in total) did you donate?"
	note g1_fundsdonatamount: "J.1.65 How much money (in total) did you donate?"

	label variable g1_volunteeract "J.1.66. During the past 6 months, have you been involved in volunteering activit"
	note g1_volunteeract: "J.1.66. During the past 6 months, have you been involved in volunteering activities in your village / neighborhood?"
	label define g1_volunteeract 1 "Yes" 0 "No"
	label values g1_volunteeract g1_volunteeract

	label variable g1_volunteeracttime "J.1.66.1 How many hours (in total) did you spend volunteering in your village / "
	note g1_volunteeracttime: "J.1.66.1 How many hours (in total) did you spend volunteering in your village / neighborhood?"

	label variable g2_familyties "J.2.1 Do you have family ties with the Omda?"
	note g2_familyties: "J.2.1 Do you have family ties with the Omda?"
	label define g2_familyties 1 "Yes" 0 "No"
	label values g2_familyties g2_familyties

	label variable g2_chiefrequirmoney "J.2.2 When you meet the omda for any problem, does he require money, gift or ser"
	note g2_chiefrequirmoney: "J.2.2 When you meet the omda for any problem, does he require money, gift or services before he receives you?"
	label define g2_chiefrequirmoney 1 "Yes" 0 "No" -99 "Don't know" -97 "Refuse to say"
	label values g2_chiefrequirmoney g2_chiefrequirmoney

	label variable g2_chiefmoneyamount "J2.3 What was the amount you paid in your last visit?"
	note g2_chiefmoneyamount: "J2.3 What was the amount you paid in your last visit?"

	label variable g2_chiefstrive "J.2.4 When it comes to take important decisions, does the omda strive to inform "
	note g2_chiefstrive: "J.2.4 When it comes to take important decisions, does the omda strive to inform the population on the reasons of his decisions?"
	label define g2_chiefstrive 1 "Yes" 0 "No" -99 "Don't know" -97 "Refuse to say"
	label values g2_chiefstrive g2_chiefstrive

	label variable g2_decisioninfluence "J.2.5 When some members are not satisfied with the decisions of the omda, are th"
	note g2_decisioninfluence: "J.2.5 When some members are not satisfied with the decisions of the omda, are there any other bodies that can influence these decisions?"
	label define g2_decisioninfluence 1 "Yes" 0 "No" -99 "Don't know" -97 "Refuse to say"
	label values g2_decisioninfluence g2_decisioninfluence

	label variable g2_decisioninfluencebodies "J.2.6 IF YES… Which bodies?"
	note g2_decisioninfluencebodies: "J.2.6 IF YES… Which bodies?"

	label variable g2_bodiesother "J.2.6.1. Specify other"
	note g2_bodiesother: "J.2.6.1. Specify other"

	label variable g3_citizensoftenengage "J.3.1 Here is a list of acts that citizens often commit. For each of these acts,"
	note g3_citizensoftenengage: "J.3.1 Here is a list of acts that citizens often commit. For each of these acts, please tell me if you have personally performed it during the last 6 months:"
	label define g3_citizensoftenengage 1 "Yes" 0 "No"
	label values g3_citizensoftenengage g3_citizensoftenengage

	label variable g3_attendmeetings "J.3.1.1. Attend a community or neighborhood meeting?"
	note g3_attendmeetings: "J.3.1.1. Attend a community or neighborhood meeting?"
	label define g3_attendmeetings 1 "Yes" 0 "No"
	label values g3_attendmeetings g3_attendmeetings

	label variable g3_givepointofview "J.3.1.2. If Yes: Do you have a speech or give your point of view at the recent m"
	note g3_givepointofview: "J.3.1.2. If Yes: Do you have a speech or give your point of view at the recent meeting with members of the community?"
	label define g3_givepointofview 1 "Yes" 0 "No"
	label values g3_givepointofview g3_givepointofview

	label variable g3_raiseissuetomayor "J.3.1.3. Meet the mayor/ community leader to raise an issue?"
	note g3_raiseissuetomayor: "J.3.1.3. Meet the mayor/ community leader to raise an issue?"
	label define g3_raiseissuetomayor 1 "Yes" 0 "No"
	label values g3_raiseissuetomayor g3_raiseissuetomayor

	label variable g3_raiseissuetomanagementc "J.3.1.4. Meet a member the community management committee to raise an issue?"
	note g3_raiseissuetomanagementc: "J.3.1.4. Meet a member the community management committee to raise an issue?"
	label define g3_raiseissuetomanagementc 1 "Yes" 0 "No"
	label values g3_raiseissuetomanagementc g3_raiseissuetomanagementc

	label variable g3_contactpolice "J.3.1.5. Contact the police, prosecutor or the courts about some problems you ha"
	note g3_contactpolice: "J.3.1.5. Contact the police, prosecutor or the courts about some problems you had?"
	label define g3_contactpolice 1 "Yes" 0 "No"
	label values g3_contactpolice g3_contactpolice

	label variable g3_contactstate "J.3.1.6. Meet or contact other state officials or agencies about some problems y"
	note g3_contactstate: "J.3.1.6. Meet or contact other state officials or agencies about some problems you had?"
	label define g3_contactstate 1 "Yes" 0 "No"
	label values g3_contactstate g3_contactstate

	label variable g3_contactgovernment "J.3.1.7. Meet or contact your government representatives to raise an issue"
	note g3_contactgovernment: "J.3.1.7. Meet or contact your government representatives to raise an issue"
	label define g3_contactgovernment 1 "Yes" 0 "No"
	label values g3_contactgovernment g3_contactgovernment

	label variable g3_contactngo "J.3.1.8 Meet or contact a NGO representative to raise issue?"
	note g3_contactngo: "J.3.1.8 Meet or contact a NGO representative to raise issue?"
	label define g3_contactngo 1 "Yes" 0 "No"
	label values g3_contactngo g3_contactngo

	label variable g3_contacteduhealth "J.3.1.9. Meet other leaders such as school principals, doctors or nurses, Water "
	note g3_contacteduhealth: "J.3.1.9. Meet other leaders such as school principals, doctors or nurses, Water Committee, etc. to raise an issue?"
	label define g3_contacteduhealth 1 "Yes" 0 "No"
	label values g3_contacteduhealth g3_contacteduhealth

	label variable g3_contactpeople "J.3.1.10 Join with other people to contact authorities about issues of importanc"
	note g3_contactpeople: "J.3.1.10 Join with other people to contact authorities about issues of importance to you?"
	label define g3_contactpeople 1 "Yes" 0 "No"
	label values g3_contactpeople g3_contactpeople

	label variable g3_peacefulparticipation "J.3.1.11. Participating in a peaceful demonstration?"
	note g3_peacefulparticipation: "J.3.1.11. Participating in a peaceful demonstration?"
	label define g3_peacefulparticipation 1 "Yes" 0 "No"
	label values g3_peacefulparticipation g3_peacefulparticipation

	label variable g3_contactmedia "J.3.1.12. Contact the media or press to raise attention to an issue or political"
	note g3_contactmedia: "J.3.1.12. Contact the media or press to raise attention to an issue or political leaders?"
	label define g3_contactmedia 1 "Yes" 0 "No"
	label values g3_contactmedia g3_contactmedia

	label variable g3_contactinfluential "J.3.1.13. Meet with influential individuals, but without authority recognized by"
	note g3_contactinfluential: "J.3.1.13. Meet with influential individuals, but without authority recognized by the state?"
	label define g3_contactinfluential 1 "Yes" 0 "No"
	label values g3_contactinfluential g3_contactinfluential

	label variable g3_meetreligious "J.3.1.14. Meet with religious leaders"
	note g3_meetreligious: "J.3.1.14. Meet with religious leaders"
	label define g3_meetreligious 1 "Yes" 0 "No"
	label values g3_meetreligious g3_meetreligious

	label variable g3_volunterworks "J.3.1.15. Performed volunteer work?"
	note g3_volunterworks: "J.3.1.15. Performed volunteer work?"
	label define g3_volunterworks 1 "Yes" 0 "No"
	label values g3_volunterworks g3_volunterworks

	label variable g3_moneydonation "J.3.1.16. Donated money to charitable organization?"
	note g3_moneydonation: "J.3.1.16. Donated money to charitable organization?"
	label define g3_moneydonation 1 "Yes" 0 "No"
	label values g3_moneydonation g3_moneydonation

	label variable g3_meetfriends "J.3.1.17. Meet with friends / family member"
	note g3_meetfriends: "J.3.1.17. Meet with friends / family member"
	label define g3_meetfriends 1 "Yes" 0 "No"
	label values g3_meetfriends g3_meetfriends

	label variable g3_healthprjt "J.3.1.18. Rebuild (restore) a school or a clinic / dispensary?"
	note g3_healthprjt: "J.3.1.18. Rebuild (restore) a school or a clinic / dispensary?"
	label define g3_healthprjt 1 "Yes" 0 "No"
	label values g3_healthprjt g3_healthprjt

	label variable g3_resproadprjt "J.3.1.19. Clearing brush or enlarge the road?"
	note g3_resproadprjt: "J.3.1.19. Clearing brush or enlarge the road?"
	label define g3_resproadprjt 1 "Yes" 0 "No"
	label values g3_resproadprjt g3_resproadprjt

	label variable g3_respwaterprojet "J.3.1.20. Dig or repair a well or tap?"
	note g3_respwaterprojet: "J.3.1.20. Dig or repair a well or tap?"
	label define g3_respwaterprojet 1 "Yes" 0 "No"
	label values g3_respwaterprojet g3_respwaterprojet

	label variable g3_respsecurityprjt "J.3.1.21. Organize patrols to secure the village/ neighborhood?"
	note g3_respsecurityprjt: "J.3.1.21. Organize patrols to secure the village/ neighborhood?"
	label define g3_respsecurityprjt 1 "Yes" 0 "No"
	label values g3_respsecurityprjt g3_respsecurityprjt

	label variable g3_respreligiousprjt "J.3.1.22. Rebuild a mosque or church?"
	note g3_respreligiousprjt: "J.3.1.22. Rebuild a mosque or church?"
	label define g3_respreligiousprjt 1 "Yes" 0 "No"
	label values g3_respreligiousprjt g3_respreligiousprjt

	label variable g3_respmarketprjt "J.3.1.22. Build a market"
	note g3_respmarketprjt: "J.3.1.22. Build a market"
	label define g3_respmarketprjt 1 "Yes" 0 "No"
	label values g3_respmarketprjt g3_respmarketprjt

	label variable g3_safetyproblems "A. If you have security and safety problems that threaten you, which individual "
	note g3_safetyproblems: "A. If you have security and safety problems that threaten you, which individual or body will you see first for your protection?"
	label define g3_safetyproblems 1 "1. police" 2 "2. army" 3 "3. the community leader" 4 "4. powerful families" 5 "5. neighborhood gangs" 6 "6. neighborhood protection groups" 7 "7. other" 9 "None" 99 "8. other non-governmental organisations"
	label values g3_safetyproblems g3_safetyproblems

	label variable g3_safetyproblemother "Specify other"
	note g3_safetyproblemother: "Specify other"

	label variable g3_conflictdisputes "B. If you have conflict or disputes with other residents such as land disputes, "
	note g3_conflictdisputes: "B. If you have conflict or disputes with other residents such as land disputes, which individual or body will you see first to seek redress?"
	label define g3_conflictdisputes 1 "1. tribunaux" 2 "2. bureau du procureur" 3 "3. Police" 4 "4. Armée" 5 "5. le leader de la communauté" 6 "6. Solutions amiables" 7 "7. Services administratifs" 99 "8. autres à préciser"
	label values g3_conflictdisputes g3_conflictdisputes

	label variable g3_conflictdisputesother "Specify other"
	note g3_conflictdisputesother: "Specify other"

	label variable g3_healthconcerns "C. If you have a health-related concerns you cannot solve yourself, which indivi"
	note g3_healthconcerns: "C. If you have a health-related concerns you cannot solve yourself, which individual or body will you see to find the solution?"
	label define g3_healthconcerns 1 "1. Unités médicales (Aire de santé et Zone de santé, Dispensaires, Cliniques) Ho" 2 "2. Services/Programmes du ministère de la santé" 3 "3. Postes sanitaires" 4 "4. Cliniques privées/ religieuses matunzo yaku ma kanisa" 5 "5. Guérisseurs, soins traditionnels matunzo ya mayani" 7 "No one" 99 "6. autres organisations non gouvernementales" 999 "7. Autres à préciser nyengine"
	label values g3_healthconcerns g3_healthconcerns

	label variable g3_healthother "Specify other"
	note g3_healthother: "Specify other"

	label variable g3_healthother1 "Specify other"
	note g3_healthother1: "Specify other"

	label variable g3_educationconcerns "D. If you have concerns related to the education of your children that, which in"
	note g3_educationconcerns: "D. If you have concerns related to the education of your children that, which individual or body will you see to find the solution?"
	label define g3_educationconcerns 1 "1. state schools" 2 "2. education administration" 3 "3. other governmental" 4 "4. private schools" 5 "5. tutors" 6 "No one" 99 "6. other non-governmental" 999 "7. Autres à préciser nyengine"
	label values g3_educationconcerns g3_educationconcerns

	label variable g3_educationother "Specify other"
	note g3_educationother: "Specify other"

	label variable g3_educationother1 "Specify other"
	note g3_educationother1: "Specify other"

	label variable g3_developmentconcerns "E. If you have concerns regarding general development issues in your community w"
	note g3_developmentconcerns: "E. If you have concerns regarding general development issues in your community which individual or body will you see to find the solution?"
	label define g3_developmentconcerns 1 "1. Gouverneur de la province" 2 "2. Maire de la ville" 3 "3. Bourgmestre" 4 "4. Chef du quartier" 5 "5. Administration des protections sociales" 6 "6. Administration de l'infrastructure" 99 "7. autres gouvernements" 8 "8. Private Entreprises" 9 "9. Organisations de la Société Civile (ONG, Confessions religieuse, …) vikundi v" 10 "No one" 999 "10. autres organisations non gouvernementales" -97 "Refuse to say" -98 "Non applicable" -99 "Don't know"
	label values g3_developmentconcerns g3_developmentconcerns

	label variable g3_developmentother "Specify other"
	note g3_developmentother: "Specify other"

	label variable g3_developmentother_1 "Specify other"
	note g3_developmentother_1: "Specify other"

	label variable g3_electionvoter_nat "J.3.3.1 Did you vote in the 2019 national elections?"
	note g3_electionvoter_nat: "J.3.3.1 Did you vote in the 2019 national elections?"
	label define g3_electionvoter_nat 1 "Yes" 0 "No" -99 "Don't know" -97 "Refuse to say"
	label values g3_electionvoter_nat g3_electionvoter_nat

	label variable g3_electionvoter_par "J.3.3.2 Did you vote in the 2019 parliamentary elections?"
	note g3_electionvoter_par: "J.3.3.2 Did you vote in the 2019 parliamentary elections?"
	label define g3_electionvoter_par 1 "Yes" 0 "No" -99 "Don't know" -97 "Refuse to say"
	label values g3_electionvoter_par g3_electionvoter_par

	label variable g3_electionnotvote_nat "J.3.3.3 Why were you not able to vote to the national election?"
	note g3_electionnotvote_nat: "J.3.3.3 Why were you not able to vote to the national election?"
	label define g3_electionnotvote_nat 1 "1.was not registered" 2 "2.was too young to vote" 3 "3.could not find the information" 4 "4.was prevented from voting" 5 "5.did not have the time" 6 "6.registration site was too far" 7 "7.did not have ID card" 8 "8.do not trust the elections" 9 "9.The vote did not take place" 10 "10 Don'T wont to do" 99 "11.Other [Specify]"
	label values g3_electionnotvote_nat g3_electionnotvote_nat

	label variable g3_electionnotvote_other1 "Specify other"
	note g3_electionnotvote_other1: "Specify other"

	label variable g3_electionnotvote_par "J.3.3.4 Why were you not able to vote to the parliamentary election?"
	note g3_electionnotvote_par: "J.3.3.4 Why were you not able to vote to the parliamentary election?"
	label define g3_electionnotvote_par 1 "1.was not registered" 2 "2.was too young to vote" 3 "3.could not find the information" 4 "4.was prevented from voting" 5 "5.did not have the time" 6 "6.registration site was too far" 7 "7.did not have ID card" 8 "8.do not trust the elections" 9 "9.The vote did not take place" 10 "10 Don'T wont to do" 99 "11.Other [Specify]"
	label values g3_electionnotvote_par g3_electionnotvote_par

	label variable g3_electionnotvote_other2 "Specify other"
	note g3_electionnotvote_other2: "Specify other"

	label variable g3_election_nat_fair "J.3.3.5. Do you think the presidential election were fair and voters were able t"
	note g3_election_nat_fair: "J.3.3.5. Do you think the presidential election were fair and voters were able to able freely ?"
	label define g3_election_nat_fair 1 "Yes" 0 "No"
	label values g3_election_nat_fair g3_election_nat_fair

	label variable g3_election_par_fair "J.3.3.6. Do you think the parlementary election were fair and voters were able t"
	note g3_election_par_fair: "J.3.3.6. Do you think the parlementary election were fair and voters were able to able freely ?"
	label define g3_election_par_fair 1 "Yes" 0 "No"
	label values g3_election_par_fair g3_election_par_fair

	label variable g3_election_candidate "J.3.3.7. Do you thinkt that the presidential candidate the most wanted by the Tu"
	note g3_election_candidate: "J.3.3.7. Do you thinkt that the presidential candidate the most wanted by the Tunisian people was elected ?"
	label define g3_election_candidate 1 "Yes" 0 "No"
	label values g3_election_candidate g3_election_candidate

	label variable g3_campagncontribution "J.3.3.8. Did you contribute in time or money to the campaign of a political cand"
	note g3_campagncontribution: "J.3.3.8. Did you contribute in time or money to the campaign of a political candidate?"
	label define g3_campagncontribution 1 "Yes" 0 "No"
	label values g3_campagncontribution g3_campagncontribution

	label variable g3_hhcandidats "J.3.3.9. Were you or someone else from your household a candidate at a parliamen"
	note g3_hhcandidats: "J.3.3.9. Were you or someone else from your household a candidate at a parliamentarian or provincial election?"
	label define g3_hhcandidats 1 "Yes" 0 "No"
	label values g3_hhcandidats g3_hhcandidats

	label variable g3_hhcandidatsspecify "J.3.3.9.1. Please specify which one?"
	note g3_hhcandidatsspecify: "J.3.3.9.1. Please specify which one?"

	label variable g3_politicsdiscuss "J.3.4.1 When you meet with friends and family, how often do you discuss politics"
	note g3_politicsdiscuss: "J.3.4.1 When you meet with friends and family, how often do you discuss politics?"
	label define g3_politicsdiscuss 0 "Never" 1 "Rarely" 2 "Sometimes" 3 "Most of the time." 4 "Regularly"
	label values g3_politicsdiscuss g3_politicsdiscuss

	label variable g3_campagnparticipation "J.3.4.2 Did you participate in a political campaign in the last presidential or "
	note g3_campagnparticipation: "J.3.4.2 Did you participate in a political campaign in the last presidential or legislative elections?"
	label define g3_campagnparticipation 1 "Yes" 0 "No"
	label values g3_campagnparticipation g3_campagnparticipation

	label variable g3_campagndonation "J.3.4.3 Did you received donation of some election candidates to win your suppor"
	note g3_campagndonation: "J.3.4.3 Did you received donation of some election candidates to win your support?"
	label define g3_campagndonation 1 "Yes" 0 "No"
	label values g3_campagndonation g3_campagndonation

	label variable g3_viewsconsideration "J.3.4.4 Regarding politics, to what extent your friends family members consider "
	note g3_viewsconsideration: "J.3.4.4 Regarding politics, to what extent your friends family members consider your views?"
	label define g3_viewsconsideration 0 "Never" 1 "Rarely" 2 "Sometimes" 3 "Most of the time." 4 "Regularly"
	label values g3_viewsconsideration g3_viewsconsideration

	label variable g3_cominfluencecapacity "J.3.4.5 How capable do feel WITH OTHER CITIZENS to influence your leaders on iss"
	note g3_cominfluencecapacity: "J.3.4.5 How capable do feel WITH OTHER CITIZENS to influence your leaders on issues and problems importance to you or your community?"
	label define g3_cominfluencecapacity 0 "0-Not at all able" 1 "1- a little capable" 2 "2-Capable" 3 "3 Very capable"
	label values g3_cominfluencecapacity g3_cominfluencecapacity

	label variable g3_owninfluencecapacity "J.3.5 How capable do feel ON YOUR OWN to influence your leaders on issues and pr"
	note g3_owninfluencecapacity: "J.3.5 How capable do feel ON YOUR OWN to influence your leaders on issues and problems important to you?"
	label define g3_owninfluencecapacity 0 "0-Not at all able" 1 "1- a little capable" 2 "2-Capable" 3 "3 Very capable"
	label values g3_owninfluencecapacity g3_owninfluencecapacity

	label variable g3_disagreementviolences "J.3.6 In any society, people will sometimes disagree with one another. These dis"
	note g3_disagreementviolences: "J.3.6 In any society, people will sometimes disagree with one another. These disagreements occasionally escalate into physical collision."
	label define g3_disagreementviolences 1 "Yes" 0 "No"
	label values g3_disagreementviolences g3_disagreementviolences

	label variable g3_disagreementviolence "J.3.7. Please tell me whether, in the last Presidential elections, you have pers"
	note g3_disagreementviolence: "J.3.7. Please tell me whether, in the last Presidential elections, you have personally feared any of the following types of violence?"
	label define g3_disagreementviolence 0 "0.No Never" 1 "1.Feared, but didn’t experience" 2 "2.Feared and experienced"
	label values g3_disagreementviolence g3_disagreementviolence

	label variable g3_neighborhood "A. among people in your neighborhood or settlement"
	note g3_neighborhood: "A. among people in your neighborhood or settlement"
	label define g3_neighborhood 0 "0.No Never" 1 "1.Feared, but didn’t experience" 2 "2.Feared and experienced"
	label values g3_neighborhood g3_neighborhood

	label variable g3_publicspace "B. breaking out in a crowded public space, like a market or at a sporting event"
	note g3_publicspace: "B. breaking out in a crowded public space, like a market or at a sporting event"
	label define g3_publicspace 0 "0.No Never" 1 "1.Feared, but didn’t experience" 2 "2.Feared and experienced"
	label values g3_publicspace g3_publicspace

	label variable g3_politicalrally "C. at a political rally or campaign event"
	note g3_politicalrally: "C. at a political rally or campaign event"
	label define g3_politicalrally 0 "0.No Never" 1 "1.Feared, but didn’t experience" 2 "2.Feared and experienced"
	label values g3_politicalrally g3_politicalrally

	label variable g3_publicprotests "D. occurring during a public demonstration or protests"
	note g3_publicprotests: "D. occurring during a public demonstration or protests"
	label define g3_publicprotests 0 "0.No Never" 1 "1.Feared, but didn’t experience" 2 "2.Feared and experienced"
	label values g3_publicprotests g3_publicprotests

	label variable g3_pltcalrlgiousextremist "E. An armed collision by political or religious extremists"
	note g3_pltcalrlgiousextremist: "E. An armed collision by political or religious extremists"
	label define g3_pltcalrlgiousextremist 0 "0.No Never" 1 "1.Feared, but didn’t experience" 2 "2.Feared and experienced"
	label values g3_pltcalrlgiousextremist g3_pltcalrlgiousextremist

	label variable g3_politicalparties "F. Violence between members of different political parties"
	note g3_politicalparties: "F. Violence between members of different political parties"
	label define g3_politicalparties 0 "0.No Never" 1 "1.Feared, but didn’t experience" 2 "2.Feared and experienced"
	label values g3_politicalparties g3_politicalparties

	label variable g3_ethnicgroups "G. Violence between members of different ethnic groups"
	note g3_ethnicgroups: "G. Violence between members of different ethnic groups"
	label define g3_ethnicgroups 0 "0.No Never" 1 "1.Feared, but didn’t experience" 2 "2.Feared and experienced"
	label values g3_ethnicgroups g3_ethnicgroups

	label variable g3_religiousgroups "H. Violence between members of different religious groups"
	note g3_religiousgroups: "H. Violence between members of different religious groups"
	label define g3_religiousgroups 0 "0.No Never" 1 "1.Feared, but didn’t experience" 2 "2.Feared and experienced"
	label values g3_religiousgroups g3_religiousgroups

	label variable g3_expdisagreementviolence "J.3.8. Have you actually personally experienced this type of violence or intimid"
	note g3_expdisagreementviolence: "J.3.8. Have you actually personally experienced this type of violence or intimidation?"
	label define g3_expdisagreementviolence 0 "0.No Never" 1 "1.Feared, but didn’t experience" 2 "2.Feared and experienced"
	label values g3_expdisagreementviolence g3_expdisagreementviolence

	label variable g3_expneighborhood "A. among people in your neighborhood or settlement"
	note g3_expneighborhood: "A. among people in your neighborhood or settlement"
	label define g3_expneighborhood 0 "0.No Never" 1 "1.Feared, but didn’t experience" 2 "2.Feared and experienced"
	label values g3_expneighborhood g3_expneighborhood

	label variable g3_exppublicspace "B. breaking out in a crowded public space, like a market or at a sporting event"
	note g3_exppublicspace: "B. breaking out in a crowded public space, like a market or at a sporting event"
	label define g3_exppublicspace 0 "0.No Never" 1 "1.Feared, but didn’t experience" 2 "2.Feared and experienced"
	label values g3_exppublicspace g3_exppublicspace

	label variable g3_exppoliticalrally "C. at a political rally or campaign event"
	note g3_exppoliticalrally: "C. at a political rally or campaign event"
	label define g3_exppoliticalrally 0 "0.No Never" 1 "1.Feared, but didn’t experience" 2 "2.Feared and experienced"
	label values g3_exppoliticalrally g3_exppoliticalrally

	label variable g3_exppublicprotests "D. occurring during a public demonstration or protests"
	note g3_exppublicprotests: "D. occurring during a public demonstration or protests"
	label define g3_exppublicprotests 0 "0.No Never" 1 "1.Feared, but didn’t experience" 2 "2.Feared and experienced"
	label values g3_exppublicprotests g3_exppublicprotests

	label variable g3_exppltcalrlgiousextremist "E. An armed collision by political or religious extremists"
	note g3_exppltcalrlgiousextremist: "E. An armed collision by political or religious extremists"
	label define g3_exppltcalrlgiousextremist 0 "0.No Never" 1 "1.Feared, but didn’t experience" 2 "2.Feared and experienced"
	label values g3_exppltcalrlgiousextremist g3_exppltcalrlgiousextremist

	label variable g3_exppoliticalparties "F. Violence between members of different political parties"
	note g3_exppoliticalparties: "F. Violence between members of different political parties"
	label define g3_exppoliticalparties 0 "0.No Never" 1 "1.Feared, but didn’t experience" 2 "2.Feared and experienced"
	label values g3_exppoliticalparties g3_exppoliticalparties

	label variable g3_expethnicgroups "G. Violence between members of different ethnic groups"
	note g3_expethnicgroups: "G. Violence between members of different ethnic groups"
	label define g3_expethnicgroups 0 "0.No Never" 1 "1.Feared, but didn’t experience" 2 "2.Feared and experienced"
	label values g3_expethnicgroups g3_expethnicgroups

	label variable g3_expreligiousgroups "H. Violence between members of different religious groups"
	note g3_expreligiousgroups: "H. Violence between members of different religious groups"
	label define g3_expreligiousgroups 0 "0.No Never" 1 "1.Feared, but didn’t experience" 2 "2.Feared and experienced"
	label values g3_expreligiousgroups g3_expreligiousgroups

	label variable g3_habitsinterestsdiscuss "J.3.9.1. When you meet with friends and family, how often do you discuss issues "
	note g3_habitsinterestsdiscuss: "J.3.9.1. When you meet with friends and family, how often do you discuss issues concerning your community and the country?"
	label define g3_habitsinterestsdiscuss 0 "Never" 1 "Rarely" 2 "Sometimes" 3 "Most of the time." 4 "Regularly"
	label values g3_habitsinterestsdiscuss g3_habitsinterestsdiscuss

	label variable g3_habitsinterestsview "J.3.9.2. On these same issues, to what extent your friends or your family member"
	note g3_habitsinterestsview: "J.3.9.2. On these same issues, to what extent your friends or your family members consider your views"
	label define g3_habitsinterestsview 0 "Never" 1 "Rarely" 2 "Sometimes" 3 "Most of the time." 4 "Regularly"
	label values g3_habitsinterestsview g3_habitsinterestsview

	label variable g3_habitsinterestsown "J.3.9.3. How capable do feel ON YOUR OWN to influence your leaders on issues and"
	note g3_habitsinterestsown: "J.3.9.3. How capable do feel ON YOUR OWN to influence your leaders on issues and problems importance to you?"
	label define g3_habitsinterestsown 0 "0-Not at all able" 1 "1- a little capable" 2 "2-Capable" 3 "3 Very capable"
	label values g3_habitsinterestsown g3_habitsinterestsown

	label variable g3_habitsinterestscitizens "J.3.9.4.How capable do feel WITH OTHER CITIZENS to influence your leaders on iss"
	note g3_habitsinterestscitizens: "J.3.9.4.How capable do feel WITH OTHER CITIZENS to influence your leaders on issues and problems importance to you or your community? (0-Not at all capable; 1-Somewhat capable; 2-Very capable)."
	label define g3_habitsinterestscitizens 0 "0-Not at all able" 1 "1- a little capable" 2 "2-Capable" 3 "3 Very capable"
	label values g3_habitsinterestscitizens g3_habitsinterestscitizens

	label variable g3_sourcescominform "J.3.10.1. What are the different sources through which you access the informatio"
	note g3_sourcescominform: "J.3.10.1. What are the different sources through which you access the information about your community?"

	label variable g3_sourcescominformother "Specify Other"
	note g3_sourcescominformother: "Specify Other"

	label variable g3_sourcesconinform "J.3.10.2. What are the different sources through which you access the informatio"
	note g3_sourcesconinform: "J.3.10.2. What are the different sources through which you access the information about your country?"

	label variable g3_sourcesconinformother "Specify Other"
	note g3_sourcesconinformother: "Specify Other"

	label variable g3_informprogram "J.3.10.3 What program do you follow the most [SELECT ONE RESPONSE]?"
	note g3_informprogram: "J.3.10.3 What program do you follow the most [SELECT ONE RESPONSE]?"
	label define g3_informprogram 1 "1.News" 2 "2. Entertainment / Music and Sport" 3 "3-Democracy and Human Rights" 4 "4. Elections" 5 "5. None (non applicable)" 6 "6. Religion" 99 "5. Other Program [specify]"
	label values g3_informprogram g3_informprogram

	label variable g3_sourcesprogramother "Specify Other"
	note g3_sourcesprogramother: "Specify Other"

	label variable g4_chiefdecision "Which of these statements is closest to your view? A: As habitants of a neighbor"
	note g4_chiefdecision: "Which of these statements is closest to your view? A: As habitants of a neighborohood, we should regurlarly questionned the act of the community chiefs B: Because the chief of community takes care of important question, we should not discuss it's decision"
	label define g4_chiefdecision 0 "Agree with neither" 1 "Agree with A" 2 "Agree with B"
	label values g4_chiefdecision g4_chiefdecision

	label variable g4_leadersdecision "Which of these statements is closest to your view? A: As citizen, we have to dis"
	note g4_leadersdecision: "Which of these statements is closest to your view? A: As citizen, we have to discuss and question the choice of our political leaders. B: Because our national political leader takes care of important questions we should not discuss their decision."
	label define g4_leadersdecision 0 "Agree with neither" 1 "Agree with A" 2 "Agree with B"
	label values g4_leadersdecision g4_leadersdecision

	label variable g4_governmentright "Which of these statements is closest to your view? A: Government has the right t"
	note g4_governmentright: "Which of these statements is closest to your view? A: Government has the right to collect taxes of everyone and can put in jail people that refuse to pay. B: Government does not have the right to perceive taxes except if he assures peoples security."
	label define g4_governmentright 0 "Agree with neither" 1 "Agree with A" 2 "Agree with B"
	label values g4_governmentright g4_governmentright

	label variable g4_forceuse "Which of these statements is closest to your view? A: When it's complicated to o"
	note g4_forceuse: "Which of these statements is closest to your view? A: When it's complicated to obtain rights, it is necessary to use force. B: Even if it's difficult to obtain right, nothing justify using force."
	label define g4_forceuse 0 "Agree with neither" 1 "Agree with A" 2 "Agree with B"
	label values g4_forceuse g4_forceuse

	label variable g4_familyhelp "Which of these statements is closest to your view? Some people think that: A. If"
	note g4_familyhelp: "Which of these statements is closest to your view? Some people think that: A. If a member of my family held a government position, she should use her position to help family members Others believe that: B. Since members of government are at the service of everyone, a leader should not favor anyone, including family members."
	label define g4_familyhelp 0 "Agree with neither" 1 "Agree with A" 2 "Agree with B"
	label values g4_familyhelp g4_familyhelp

	label variable g4_economicdecisions "Which of these statements is closest to your view? Some people think that: A. Ev"
	note g4_economicdecisions: "Which of these statements is closest to your view? Some people think that: A. Everyone should have the right to take part in economic decision-making, even if they do not understand all aspects of the problem Others think that: B. Only those who understand all aspects of the problem should participate in"
	label define g4_economicdecisions 0 "Agree with neither" 1 "Agree with A" 2 "Agree with B"
	label values g4_economicdecisions g4_economicdecisions

	label variable g4_chiefperiod "Which of these statements is closest to your view? Some people think that: A. Th"
	note g4_chiefperiod: "Which of these statements is closest to your view? Some people think that: A. The authorities should be chosen for a fixed period in order to prevent them from becoming too powerful and to prevent democratic decision-making. Others believe that: B. Authorities should stay in office their entire lives because they embody traditional power. s"
	label define g4_chiefperiod 0 "Agree with neither" 1 "Agree with A" 2 "Agree with B"
	label values g4_chiefperiod g4_chiefperiod

	label variable g4_womenright "Which of these statements is closest to your view? Certaines personnes pensent q"
	note g4_womenright: "Which of these statements is closest to your view? Certaines personnes pensent que: A. Dans notre pays, les femmes devraient avoir les mêmes droits et devoirs que les hommes D'autres pensent que: B. Selon nos coutumes et nos coutumes, les femmes devraient être soumises et devraient rester comme telles."
	label define g4_womenright 0 "Agree with neither" 1 "Agree with A" 2 "Agree with B"
	label values g4_womenright g4_womenright

	label variable g4_womenmen "Which of these statements is closest to your view? Some people think that: A. Wo"
	note g4_womenmen: "Which of these statements is closest to your view? Some people think that: A. Women should have the same chances as men to occupy socio-administrative positions in this neighborhood Others think that: B. Men are better leaders and they should occupy the socio-administrative positions in this neighborhood"
	label define g4_womenmen 0 "Agree with neither" 1 "Agree with A" 2 "Agree with B"
	label values g4_womenmen g4_womenmen

	label variable g4_menwomen "Which of these statements is closest to your view? Some people think that: A. On"
	note g4_menwomen: "Which of these statements is closest to your view? Some people think that: A. Only men should be chairmen of management committees Others think that: B. Women have contributions to make. Therefore, they should be eligible to chair management committees."
	label define g4_menwomen 0 "Agree with neither" 1 "Agree with A" 2 "Agree with B"
	label values g4_menwomen g4_menwomen

	label variable h1_personally "K.1.2. Did you personnaly took part to any of the following activities / behavio"
	note h1_personally: "K.1.2. Did you personnaly took part to any of the following activities / behavior during the last 30 days ?"
	label define h1_personally 1 "Yes" 0 "No"
	label values h1_personally h1_personally

	label variable h1_respectparweek "A. Displayed lack of respect for parents/elders?"
	note h1_respectparweek: "A. Displayed lack of respect for parents/elders?"
	label define h1_respectparweek 1 "Yes" 0 "No"
	label values h1_respectparweek h1_respectparweek

	label variable h1_culturaltraweek "B. Refusal to participate in cultural customs or traditions"
	note h1_culturaltraweek: "B. Refusal to participate in cultural customs or traditions"
	label define h1_culturaltraweek 1 "Yes" 0 "No"
	label values h1_culturaltraweek h1_culturaltraweek

	label variable h1_disputfigweek "C. Engaged in disputes or fights?"
	note h1_disputfigweek: "C. Engaged in disputes or fights?"
	label define h1_disputfigweek 1 "Yes" 0 "No"
	label values h1_disputfigweek h1_disputfigweek

	label variable h1_arrestedpoweek "D. Arrested by the police?"
	note h1_arrestedpoweek: "D. Arrested by the police?"
	label define h1_arrestedpoweek 1 "Yes" 0 "No"
	label values h1_arrestedpoweek h1_arrestedpoweek

	label variable h1_jailpaidweek "E. Went to jail or paid a fine?"
	note h1_jailpaidweek: "E. Went to jail or paid a fine?"
	label define h1_jailpaidweek 1 "Yes" 0 "No"
	label values h1_jailpaidweek h1_jailpaidweek

	label variable h1_policyautweek "F. Got into an argument with the policy or other authorities?"
	note h1_policyautweek: "F. Got into an argument with the policy or other authorities?"
	label define h1_policyautweek 1 "Yes" 0 "No"
	label values h1_policyautweek h1_policyautweek

	label variable h1_selfdefproweek "G. Carried a self-defense weapon (gun, knife, batt, etc.) for protection"
	note h1_selfdefproweek: "G. Carried a self-defense weapon (gun, knife, batt, etc.) for protection"
	label define h1_selfdefproweek 1 "Yes" 0 "No"
	label values h1_selfdefproweek h1_selfdefproweek

	label variable h1_robbeweek "H. Engaged in theft or robberies?"
	note h1_robbeweek: "H. Engaged in theft or robberies?"
	label define h1_robbeweek 1 "Yes" 0 "No"
	label values h1_robbeweek h1_robbeweek

	label variable h1_drunkalweek "I. Drunk too much alcohol?"
	note h1_drunkalweek: "I. Drunk too much alcohol?"
	label define h1_drunkalweek 1 "Yes" 0 "No"
	label values h1_drunkalweek h1_drunkalweek

	label variable h1_drugscweek "J. Sold/bought drugs or other contrabands?"
	note h1_drugscweek: "J. Sold/bought drugs or other contrabands?"
	label define h1_drugscweek 1 "Yes" 0 "No"
	label values h1_drugscweek h1_drugscweek

	label variable h1_peopleproweek "K. Stole other people’s property"
	note h1_peopleproweek: "K. Stole other people’s property"
	label define h1_peopleproweek 1 "Yes" 0 "No"
	label values h1_peopleproweek h1_peopleproweek

	label variable h1_gambweek "L. Engaged in gambling"
	note h1_gambweek: "L. Engaged in gambling"
	label define h1_gambweek 1 "Yes" 0 "No"
	label values h1_gambweek h1_gambweek

	label variable h1_damagedproweek "M. Damaged somebody’s property"
	note h1_damagedproweek: "M. Damaged somebody’s property"
	label define h1_damagedproweek 1 "Yes" 0 "No"
	label values h1_damagedproweek h1_damagedproweek

	label variable h1_gangsweek "N. Participated in gangs/other groups that disturb order & peace in community"
	note h1_gangsweek: "N. Participated in gangs/other groups that disturb order & peace in community"
	label define h1_gangsweek 1 "Yes" 0 "No"
	label values h1_gangsweek h1_gangsweek

	label variable h1_socialcweek "O. Volunteered time for social cause"
	note h1_socialcweek: "O. Volunteered time for social cause"
	label define h1_socialcweek 1 "Yes" 0 "No"
	label values h1_socialcweek h1_socialcweek

	label variable h1_contributedorweek "P. Contributed to charitable organizations"
	note h1_contributedorweek: "P. Contributed to charitable organizations"
	label define h1_contributedorweek 1 "Yes" 0 "No"
	label values h1_contributedorweek h1_contributedorweek

	label variable h1_vulnerablelweek "Q. Cared for the vulnerable & elderly"
	note h1_vulnerablelweek: "Q. Cared for the vulnerable & elderly"
	label define h1_vulnerablelweek 1 "Yes" 0 "No"
	label values h1_vulnerablelweek h1_vulnerablelweek

	label variable h1_resolvdispweek "R. Helped to resolved disputes/conflict"
	note h1_resolvdispweek: "R. Helped to resolved disputes/conflict"
	label define h1_resolvdispweek 1 "Yes" 0 "No"
	label values h1_resolvdispweek h1_resolvdispweek

	label variable h1_help11 "S. Provided financial or other material assistance to a person in need related t"
	note h1_help11: "S. Provided financial or other material assistance to a person in need related to you or who knows you."
	label define h1_help11 1 "Yes" 0 "No"
	label values h1_help11 h1_help11

	label variable h1_help21 "T. Provided financial or other material assistance to a person in need who is no"
	note h1_help21: "T. Provided financial or other material assistance to a person in need who is not related to you or who knows you"
	label define h1_help21 1 "Yes" 0 "No"
	label values h1_help21 h1_help21

	label variable h1_sharer11 "U. You shared a resource you needed (for example, providing food for someone or "
	note h1_sharer11: "U. You shared a resource you needed (for example, providing food for someone or letting them stay in your home) with someone you know or know you well."
	label define h1_sharer11 1 "Yes" 0 "No"
	label values h1_sharer11 h1_sharer11

	label variable h1_sharer21 "V. You shared a resource you needed (for example, providing food for someone or "
	note h1_sharer21: "V. You shared a resource you needed (for example, providing food for someone or letting it stay in your home) with a person in need who was not related to you"
	label define h1_sharer21 1 "Yes" 0 "No"
	label values h1_sharer21 h1_sharer21

	label variable h1_reconfort11 "W. Provided comfort to an injured person related to you or who knows you."
	note h1_reconfort11: "W. Provided comfort to an injured person related to you or who knows you."
	label define h1_reconfort11 1 "Yes" 0 "No"
	label values h1_reconfort11 h1_reconfort11

	label variable h1_reconfort21 "X. Provide comfort to an injured person who is not related or known to you."
	note h1_reconfort21: "X. Provide comfort to an injured person who is not related or known to you."
	label define h1_reconfort21 1 "Yes" 0 "No"
	label values h1_reconfort21 h1_reconfort21

	label variable h1_visite1 "Y. Visiting a sick person who is not related or known to you in a clinic, hospit"
	note h1_visite1: "Y. Visiting a sick person who is not related or known to you in a clinic, hospital or other health facility."
	label define h1_visite1 1 "Yes" 0 "No"
	label values h1_visite1 h1_visite1

	label variable x1_mgroles "K.2.1.1. Do you agree with the following statements?"
	note x1_mgroles: "K.2.1.1. Do you agree with the following statements?"
	label define x1_mgroles 1 "Yes" 0 "No"
	label values x1_mgroles x1_mgroles

	label variable x1_mghome "A. Women's most important role is to take care of home and cook"
	note x1_mghome: "A. Women's most important role is to take care of home and cook"
	label define x1_mghome 1 "Yes" 0 "No"
	label values x1_mghome x1_mghome

	label variable x1_mgkids "B. Changing clothes, giving kids a bath, and feeding kids are mother's responsib"
	note x1_mgkids: "B. Changing clothes, giving kids a bath, and feeding kids are mother's responsibilities"
	label define x1_mgkids 1 "Yes" 0 "No"
	label values x1_mgkids x1_mgkids

	label variable x1_mgdecisions "C. A man should have the final word about decisions in his home"
	note x1_mgdecisions: "C. A man should have the final word about decisions in his home"
	label define x1_mgdecisions 1 "Yes" 0 "No"
	label values x1_mgdecisions x1_mgdecisions

	label variable x1_mgrights1 "D. In our country, the women should have the same rights and obligations as that"
	note x1_mgrights1: "D. In our country, the women should have the same rights and obligations as that of men"
	label define x1_mgrights1 1 "Yes" 0 "No"
	label values x1_mgrights1 x1_mgrights1

	label variable x1_mgleader1 "E. Women should occupy leadership positions in society"
	note x1_mgleader1: "E. Women should occupy leadership positions in society"
	label define x1_mgleader1 1 "Yes" 0 "No"
	label values x1_mgleader1 x1_mgleader1

	label variable x1_mgleader2 "G. Women have knowledge to contribute, they should therefore be eligible for the"
	note x1_mgleader2: "G. Women have knowledge to contribute, they should therefore be eligible for the post of president of the management committees of the village"
	label define x1_mgleader2 1 "Yes" 0 "No"
	label values x1_mgleader2 x1_mgleader2

	label variable x1_mgschlwork "H. The woman should help the children with their studies at home"
	note x1_mgschlwork: "H. The woman should help the children with their studies at home"
	label define x1_mgschlwork 1 "Yes" 0 "No"
	label values x1_mgschlwork x1_mgschlwork

	label variable x1_mgill "I. The woman should be responsible for looking after ill persons at home"
	note x1_mgill: "I. The woman should be responsible for looking after ill persons at home"
	label define x1_mgill 1 "Yes" 0 "No"
	label values x1_mgill x1_mgill

	label variable x1_mgopinion "J. Do you think that a wife has a right to express her opinion even when she dis"
	note x1_mgopinion: "J. Do you think that a wife has a right to express her opinion even when she disagrees with her husband?"
	label define x1_mgopinion 1 "Yes" 0 "No"
	label values x1_mgopinion x1_mgopinion

	label variable x1_mgpity "K. A thirty year old woman who has a good job but is not yet married is to be pi"
	note x1_mgpity: "K. A thirty year old woman who has a good job but is not yet married is to be pitied"
	label define x1_mgpity 1 "Yes" 0 "No"
	label values x1_mgpity x1_mgpity

	label variable x1_mgwork "L. Women should be allowed to work outside of home"
	note x1_mgwork: "L. Women should be allowed to work outside of home"
	label define x1_mgwork 1 "Yes" 0 "No"
	label values x1_mgwork x1_mgwork

	label variable x1_mgedu "M. Educating boys is more important than educating girls"
	note x1_mgedu: "M. Educating boys is more important than educating girls"
	label define x1_mgedu 1 "Yes" 0 "No"
	label values x1_mgedu x1_mgedu

	label variable x1_mgdomestic "N. Boys should do as much domestic work as girls"
	note x1_mgdomestic: "N. Boys should do as much domestic work as girls"
	label define x1_mgdomestic 1 "Yes" 0 "No"
	label values x1_mgdomestic x1_mgdomestic

	label variable x1_mgobey "O. A girl must obey her brother’s opinion even if he’s younger than her"
	note x1_mgobey: "O. A girl must obey her brother’s opinion even if he’s younger than her"
	label define x1_mgobey 1 "Yes" 0 "No"
	label values x1_mgobey x1_mgobey

	label variable x1_mgspeak "P. Girls should speak as much as boys in the classroom"
	note x1_mgspeak: "P. Girls should speak as much as boys in the classroom"
	label define x1_mgspeak 1 "Yes" 0 "No"
	label values x1_mgspeak x1_mgspeak

	label variable x1_mgcapacity "Q. Girls are capable of doing as well as boys in school"
	note x1_mgcapacity: "Q. Girls are capable of doing as well as boys in school"
	label define x1_mgcapacity 1 "Yes" 0 "No"
	label values x1_mgcapacity x1_mgcapacity

	label variable x1_eduopp "R. Boys should be allowed to get more opportunities and resources for education "
	note x1_eduopp: "R. Boys should be allowed to get more opportunities and resources for education than girls"
	label define x1_eduopp 1 "Yes" 0 "No"
	label values x1_eduopp x1_eduopp

	label variable x1_boysfood "S. Boys should be fed first and given more food than girls"
	note x1_boysfood: "S. Boys should be fed first and given more food than girls"
	label define x1_boysfood 1 "Yes" 0 "No"
	label values x1_boysfood x1_boysfood

	label variable x1_coupledu "T. A husband should be more educated than wife"
	note x1_coupledu: "T. A husband should be more educated than wife"
	label define x1_coupledu 1 "Yes" 0 "No"
	label values x1_coupledu x1_coupledu

	label variable x1_leader3 "K.2.1.4. Would you appreciate if a female member of your household wishes to par"
	note x1_leader3: "K.2.1.4. Would you appreciate if a female member of your household wishes to participate in village committees as a member"
	label define x1_leader3 1 "Yes" 0 "No"
	label values x1_leader3 x1_leader3

	label variable x1_agreerole "K.2.1.2.To what degree do you agree with the following statements?"
	note x1_agreerole: "K.2.1.2.To what degree do you agree with the following statements?"
	label define x1_agreerole 1 "Totally agree" 2 "Agree" 3 "Disagree" 4 "Totally disagree" -99 "Don't know" -97 "Refuse to say"
	label values x1_agreerole x1_agreerole

	label variable x1_mgrights2 "A. When women get rights, they are taking rights away from men"
	note x1_mgrights2: "A. When women get rights, they are taking rights away from men"
	label define x1_mgrights2 1 "Totally agree" 2 "Agree" 3 "Disagree" 4 "Totally disagree" -99 "Don't know" -97 "Refuse to say"
	label values x1_mgrights2 x1_mgrights2

	label variable x1_mgequality "B. Gender equality, meaning that men and women are equal, has come far enough al"
	note x1_mgequality: "B. Gender equality, meaning that men and women are equal, has come far enough already"
	label define x1_mgequality 1 "Totally agree" 2 "Agree" 3 "Disagree" 4 "Totally disagree" -99 "Don't know" -97 "Refuse to say"
	label values x1_mgequality x1_mgequality

	label variable x1_mgfriends "C. A woman should be able to choose her friends, even if her husband dissaproves"
	note x1_mgfriends: "C. A woman should be able to choose her friends, even if her husband dissaproves"
	label define x1_mgfriends 1 "Totally agree" 2 "Agree" 3 "Disagree" 4 "Totally disagree" -99 "Don't know" -97 "Refuse to say"
	label values x1_mgfriends x1_mgfriends

	label variable x1_mgfreetime_men "D. A man should decide how to spend his free time on his own"
	note x1_mgfreetime_men: "D. A man should decide how to spend his free time on his own"
	label define x1_mgfreetime_men 1 "Totally agree" 2 "Agree" 3 "Disagree" 4 "Totally disagree" -99 "Don't know" -97 "Refuse to say"
	label values x1_mgfreetime_men x1_mgfreetime_men

	label variable x1_mg_freetime_women "E. A woman should decide how to spend his free time on his own"
	note x1_mg_freetime_women: "E. A woman should decide how to spend his free time on his own"
	label define x1_mg_freetime_women 1 "Totally agree" 2 "Agree" 3 "Disagree" 4 "Totally disagree" -99 "Don't know" -97 "Refuse to say"
	label values x1_mg_freetime_women x1_mg_freetime_women

	label variable x1_mg_womenopi "F. Women's opinions are valuable and should always be considered while making ho"
	note x1_mg_womenopi: "F. Women's opinions are valuable and should always be considered while making household decisions"
	label define x1_mg_womenopi 1 "Totally agree" 2 "Agree" 3 "Disagree" 4 "Totally disagree" -99 "Don't know" -97 "Refuse to say"
	label values x1_mg_womenopi x1_mg_womenopi

	label variable x1_mg_marry "G. Women should be able to marry whomever they want, regardless of their parent'"
	note x1_mg_marry: "G. Women should be able to marry whomever they want, regardless of their parent's view"
	label define x1_mg_marry 1 "Totally agree" 2 "Agree" 3 "Disagree" 4 "Totally disagree" -99 "Don't know" -97 "Refuse to say"
	label values x1_mg_marry x1_mg_marry

	label variable x1_participation "K.2.1.3. Do you think women can generally change things in this village if they "
	note x1_participation: "K.2.1.3. Do you think women can generally change things in this village if they want to"
	label define x1_participation 1 "Totally agree" 2 "Agree" 3 "Disagree" 4 "Totally disagree" -99 "Don't know" -97 "Refuse to say"
	label values x1_participation x1_participation

	label variable x1_leader4 "K.2.1.5. It would be a good idea to elect a woman as the President of Tunisia"
	note x1_leader4: "K.2.1.5. It would be a good idea to elect a woman as the President of Tunisia"
	label define x1_leader4 1 "Totally agree" 2 "Agree" 3 "Disagree" 4 "Totally disagree" -99 "Don't know" -97 "Refuse to say"
	label values x1_leader4 x1_leader4

	label variable x1_leader5 "K.2.1.6. It would be a good idea to elect a woman as the chief/omda of your vill"
	note x1_leader5: "K.2.1.6. It would be a good idea to elect a woman as the chief/omda of your village"
	label define x1_leader5 1 "Totally agree" 2 "Agree" 3 "Disagree" 4 "Totally disagree" -99 "Don't know" -97 "Refuse to say"
	label values x1_leader5 x1_leader5

	label variable x1_leader6_1 "A. Run their own business"
	note x1_leader6_1: "A. Run their own business"
	label define x1_leader6_1 1 "1" 2 "2" 3 "3" 4 "4" 5 "5" 6 "6" 7 "7" 8 "8" 9 "9" 10 "10"
	label values x1_leader6_1 x1_leader6_1

	label variable x1_leader6_2 "B. Identify business opportunities to start a new business"
	note x1_leader6_2: "B. Identify business opportunities to start a new business"
	label define x1_leader6_2 1 "1" 2 "2" 3 "3" 4 "4" 5 "5" 6 "6" 7 "7" 8 "8" 9 "9" 10 "10"
	label values x1_leader6_2 x1_leader6_2

	label variable x1_leader6_3 "C. Obtain credit to start up a new business/ expand existing business"
	note x1_leader6_3: "C. Obtain credit to start up a new business/ expand existing business"
	label define x1_leader6_3 1 "1" 2 "2" 3 "3" 4 "4" 5 "5" 6 "6" 7 "7" 8 "8" 9 "9" 10 "10"
	label values x1_leader6_3 x1_leader6_3

	label variable x1_leader6_4 "D. Save in order to invest in future business opportunities"
	note x1_leader6_4: "D. Save in order to invest in future business opportunities"
	label define x1_leader6_4 1 "1" 2 "2" 3 "3" 4 "4" 5 "5" 6 "6" 7 "7" 8 "8" 9 "9" 10 "10"
	label values x1_leader6_4 x1_leader6_4

	label variable x1_leader6_5 "E. Make sure that your employees get the work done properly"
	note x1_leader6_5: "E. Make sure that your employees get the work done properly"
	label define x1_leader6_5 1 "1" 2 "2" 3 "3" 4 "4" 5 "5" 6 "6" 7 "7" 8 "8" 9 "9" 10 "10"
	label values x1_leader6_5 x1_leader6_5

	label variable x1_leader6_6 "F. Manage financial accounts"
	note x1_leader6_6: "F. Manage financial accounts"
	label define x1_leader6_6 1 "1" 2 "2" 3 "3" 4 "4" 5 "5" 6 "6" 7 "7" 8 "8" 9 "9" 10 "10"
	label values x1_leader6_6 x1_leader6_6

	label variable x1_leader6_7 "G. Bargain to obtain cheap prices when they are buying something for the busines"
	note x1_leader6_7: "G. Bargain to obtain cheap prices when they are buying something for the business"
	label define x1_leader6_7 1 "1" 2 "2" 3 "3" 4 "4" 5 "5" 6 "6" 7 "7" 8 "8" 9 "9" 10 "10"
	label values x1_leader6_7 x1_leader6_7

	label variable x1_leader6_8 "H. Bargain to obtain high pricess when selling"
	note x1_leader6_8: "H. Bargain to obtain high pricess when selling"
	label define x1_leader6_8 1 "1" 2 "2" 3 "3" 4 "4" 5 "5" 6 "6" 7 "7" 8 "8" 9 "9" 10 "10"
	label values x1_leader6_8 x1_leader6_8

	label variable x1_leader6_9 "I. Protect their business assets from harm by others"
	note x1_leader6_9: "I. Protect their business assets from harm by others"
	label define x1_leader6_9 1 "1" 2 "2" 3 "3" 4 "4" 5 "5" 6 "6" 7 "7" 8 "8" 9 "9" 10 "10"
	label values x1_leader6_9 x1_leader6_9

	label variable x1_leader6_10 "J. Collecting the money that someone owes you"
	note x1_leader6_10: "J. Collecting the money that someone owes you"
	label define x1_leader6_10 1 "1" 2 "2" 3 "3" 4 "4" 5 "5" 6 "6" 7 "7" 8 "8" 9 "9" 10 "10"
	label values x1_leader6_10 x1_leader6_10

	label variable x1_leader7_1 "A. Run their own business"
	note x1_leader7_1: "A. Run their own business"
	label define x1_leader7_1 1 "1" 2 "2" 3 "3" 4 "4" 5 "5" 6 "6" 7 "7" 8 "8" 9 "9" 10 "10"
	label values x1_leader7_1 x1_leader7_1

	label variable x1_leader7_2 "B. Identify business opportunities to start a new business"
	note x1_leader7_2: "B. Identify business opportunities to start a new business"
	label define x1_leader7_2 1 "1" 2 "2" 3 "3" 4 "4" 5 "5" 6 "6" 7 "7" 8 "8" 9 "9" 10 "10"
	label values x1_leader7_2 x1_leader7_2

	label variable x1_leader7_3 "C. Obtain credit to start up a new business/ expand existing business"
	note x1_leader7_3: "C. Obtain credit to start up a new business/ expand existing business"
	label define x1_leader7_3 1 "1" 2 "2" 3 "3" 4 "4" 5 "5" 6 "6" 7 "7" 8 "8" 9 "9" 10 "10"
	label values x1_leader7_3 x1_leader7_3

	label variable x1_leader7_4 "D. Save in order to invest in future business opportunities"
	note x1_leader7_4: "D. Save in order to invest in future business opportunities"
	label define x1_leader7_4 1 "1" 2 "2" 3 "3" 4 "4" 5 "5" 6 "6" 7 "7" 8 "8" 9 "9" 10 "10"
	label values x1_leader7_4 x1_leader7_4

	label variable x1_leader7_5 "E. Make sure that your employees get the work done properly"
	note x1_leader7_5: "E. Make sure that your employees get the work done properly"
	label define x1_leader7_5 1 "1" 2 "2" 3 "3" 4 "4" 5 "5" 6 "6" 7 "7" 8 "8" 9 "9" 10 "10"
	label values x1_leader7_5 x1_leader7_5

	label variable x1_leader7_6 "F. Manage financial accounts"
	note x1_leader7_6: "F. Manage financial accounts"
	label define x1_leader7_6 1 "1" 2 "2" 3 "3" 4 "4" 5 "5" 6 "6" 7 "7" 8 "8" 9 "9" 10 "10"
	label values x1_leader7_6 x1_leader7_6

	label variable x1_leader7_7 "G. Bargain to obtain cheap prices when they are buying something for the busines"
	note x1_leader7_7: "G. Bargain to obtain cheap prices when they are buying something for the business"
	label define x1_leader7_7 1 "1" 2 "2" 3 "3" 4 "4" 5 "5" 6 "6" 7 "7" 8 "8" 9 "9" 10 "10"
	label values x1_leader7_7 x1_leader7_7

	label variable x1_leader7_8 "H. Bargain to obtain high pricess when selling"
	note x1_leader7_8: "H. Bargain to obtain high pricess when selling"
	label define x1_leader7_8 1 "1" 2 "2" 3 "3" 4 "4" 5 "5" 6 "6" 7 "7" 8 "8" 9 "9" 10 "10"
	label values x1_leader7_8 x1_leader7_8

	label variable x1_leader7_9 "I. Protect their business assets from harm by others"
	note x1_leader7_9: "I. Protect their business assets from harm by others"
	label define x1_leader7_9 1 "1" 2 "2" 3 "3" 4 "4" 5 "5" 6 "6" 7 "7" 8 "8" 9 "9" 10 "10"
	label values x1_leader7_9 x1_leader7_9

	label variable x1_leader7_10 "J. Collecting the money that someone owes you"
	note x1_leader7_10: "J. Collecting the money that someone owes you"
	label define x1_leader7_10 1 "1" 2 "2" 3 "3" 4 "4" 5 "5" 6 "6" 7 "7" 8 "8" 9 "9" 10 "10"
	label values x1_leader7_10 x1_leader7_10

	label variable x1_leader9 "K.2.1.9. Do you agree: A woman in your community has little voice in public disc"
	note x1_leader9: "K.2.1.9. Do you agree: A woman in your community has little voice in public discussions about development opportunities"
	label define x1_leader9 1 "Totally agree" 2 "Agree" 3 "Disagree" 4 "Totally disagree" -99 "Don't know" -97 "Refuse to say"
	label values x1_leader9 x1_leader9

	label variable x1_leader10 "K.2.1.10. Do you agree: Women are just as capable as men of contributing ot hous"
	note x1_leader10: "K.2.1.10. Do you agree: Women are just as capable as men of contributing ot household income"
	label define x1_leader10 1 "Totally agree" 2 "Agree" 3 "Disagree" 4 "Totally disagree" -99 "Don't know" -97 "Refuse to say"
	label values x1_leader10 x1_leader10

	label variable x1_participation2 "K.2.1.11. Do you agree: Compared to a few years back, there are now more opportu"
	note x1_participation2: "K.2.1.11. Do you agree: Compared to a few years back, there are now more opportunities for women to become influential actors in how your community is developed"
	label define x1_participation2 1 "Totally agree" 2 "Agree" 3 "Disagree" 4 "Totally disagree" -99 "Don't know" -97 "Refuse to say"
	label values x1_participation2 x1_participation2

	label variable x1_participation3 "K.2.1.12. If a woman wanted to voice her opinion in public meetings, community l"
	note x1_participation3: "K.2.1.12. If a woman wanted to voice her opinion in public meetings, community leaders would encourage her to do so"
	label define x1_participation3 1 "Totally agree" 2 "Agree" 3 "Disagree" 4 "Totally disagree" -99 "Don't know" -97 "Refuse to say"
	label values x1_participation3 x1_participation3

	label variable x2_hwviolenceintro "K.2.2.2. Under which conditions would it be ok for a man to beat his wife?"
	note x2_hwviolenceintro: "K.2.2.2. Under which conditions would it be ok for a man to beat his wife?"
	label define x2_hwviolenceintro 1 "Yes" 0 "No"
	label values x2_hwviolenceintro x2_hwviolenceintro

	label variable x2_hwtolerate "K.2.2.1. To keep her family together"
	note x2_hwtolerate: "K.2.2.1. To keep her family together"
	label define x2_hwtolerate 1 "Yes" 0 "No"
	label values x2_hwtolerate x2_hwtolerate

	label variable x2_goesout "A. If she goes out without telling him."
	note x2_goesout: "A. If she goes out without telling him."
	label define x2_goesout 1 "Yes" 0 "No"
	label values x2_goesout x2_goesout

	label variable x2_refuseshave "B: If she refuses to have sex with him"
	note x2_refuseshave: "B: If she refuses to have sex with him"
	label define x2_refuseshave 1 "Yes" 0 "No"
	label values x2_refuseshave x2_refuseshave

	label variable x2_neglectsif "C. If she neglects the children."
	note x2_neglectsif: "C. If she neglects the children."
	label define x2_neglectsif 1 "Yes" 0 "No"
	label values x2_neglectsif x2_neglectsif

	label variable x2_burnsf "D. If she burns the food"
	note x2_burnsf: "D. If she burns the food"
	label define x2_burnsf 1 "Yes" 0 "No"
	label values x2_burnsf x2_burnsf

	label variable x2_arguesshe "E: If she argues with him"
	note x2_arguesshe: "E: If she argues with him"
	label define x2_arguesshe 1 "Yes" 0 "No"
	label values x2_arguesshe x2_arguesshe

	label variable x2_refusescook "F. If she refuses to cook."
	note x2_refusescook: "F. If she refuses to cook."
	label define x2_refusescook 1 "Yes" 0 "No"
	label values x2_refusescook x2_refusescook

	label variable x2_doesinfid "G: If she does Infidelity"
	note x2_doesinfid: "G: If she does Infidelity"
	label define x2_doesinfid 1 "Yes" 0 "No"
	label values x2_doesinfid x2_doesinfid

	label variable x2_contraceptive "H: If she requires the use of contraceptive methods"
	note x2_contraceptive: "H: If she requires the use of contraceptive methods"
	label define x2_contraceptive 1 "Yes" 0 "No"
	label values x2_contraceptive x2_contraceptive

	label variable x2_drinksalcohol "I: If she drinks alcohol"
	note x2_drinksalcohol: "I: If she drinks alcohol"
	label define x2_drinksalcohol 1 "Yes" 0 "No"
	label values x2_drinksalcohol x2_drinksalcohol

	label variable x2_refusesclean "J. If she refuses to clean the house."
	note x2_refusesclean: "J. If she refuses to clean the house."
	label define x2_refusesclean 1 "Yes" 0 "No"
	label values x2_refusesclean x2_refusesclean

	label variable x2_dowry "K. If he has paid dowry"
	note x2_dowry: "K. If he has paid dowry"
	label define x2_dowry 1 "Yes" 0 "No"
	label values x2_dowry x2_dowry

	label variable x6_sxmore "A. Men need sex more than women do"
	note x6_sxmore: "A. Men need sex more than women do"
	label define x6_sxmore 1 "Totally agree" 2 "Agree" 3 "Disagree" 4 "Totally disagree" -99 "Don't know" -97 "Refuse to say"
	label values x6_sxmore x6_sxmore

	label variable x6_sxtalk "B. Men don't talk about sex, they just do"
	note x6_sxtalk: "B. Men don't talk about sex, they just do"
	label define x6_sxtalk 1 "Totally agree" 2 "Agree" 3 "Disagree" 4 "Totally disagree" -99 "Don't know" -97 "Refuse to say"
	label values x6_sxtalk x6_sxtalk

	label variable x6_sxready "C. Men are always ready to have sex"
	note x6_sxready: "C. Men are always ready to have sex"
	label define x6_sxready 1 "Totally agree" 2 "Agree" 3 "Disagree" 4 "Totally disagree" -99 "Don't know" -97 "Refuse to say"
	label values x6_sxready x6_sxready

	label variable x6_gay "D. I would never have a gay friend"
	note x6_gay: "D. I would never have a gay friend"
	label define x6_gay 1 "Totally agree" 2 "Agree" 3 "Disagree" 4 "Totally disagree" -99 "Don't know" -97 "Refuse to say"
	label values x6_gay x6_gay

	label variable x6_friend "E. Its important for men to have friends to talk to about their problems"
	note x6_friend: "E. Its important for men to have friends to talk to about their problems"
	label define x6_friend 1 "Totally agree" 2 "Agree" 3 "Disagree" 4 "Totally disagree" -99 "Don't know" -97 "Refuse to say"
	label values x6_friend x6_friend

	label variable x7_tough "A. To be a man, you need to be tough"
	note x7_tough: "A. To be a man, you need to be tough"
	label define x7_tough 1 "Totally agree" 2 "Agree" 3 "Disagree" 4 "Totally disagree" -99 "Don't know" -97 "Refuse to say"
	label values x7_tough x7_tough

	label variable x7_insult "B. If someone insults me, I will defend my reputation, with force if I have to"
	note x7_insult: "B. If someone insults me, I will defend my reputation, with force if I have to"
	label define x7_insult 1 "Totally agree" 2 "Agree" 3 "Disagree" 4 "Totally disagree" -99 "Don't know" -97 "Refuse to say"
	label values x7_insult x7_insult

	label variable x8_pregn "A. It is a women's responsibility to avoid getting pregnant"
	note x8_pregn: "A. It is a women's responsibility to avoid getting pregnant"
	label define x8_pregn 1 "Totally agree" 2 "Agree" 3 "Disagree" 4 "Totally disagree" -99 "Don't know" -97 "Refuse to say"
	label values x8_pregn x8_pregn

	label variable x8_contra "B. I would be outraged if my wife asked me to use contraception"
	note x8_contra: "B. I would be outraged if my wife asked me to use contraception"
	label define x8_contra 1 "Totally agree" 2 "Agree" 3 "Disagree" 4 "Totally disagree" -99 "Don't know" -97 "Refuse to say"
	label values x8_contra x8_contra

	label variable x8_suggcontr "C. Either a man or a woman can suggest using contraception"
	note x8_suggcontr: "C. Either a man or a woman can suggest using contraception"
	label define x8_suggcontr 1 "Totally agree" 2 "Agree" 3 "Disagree" 4 "Totally disagree" -99 "Don't know" -97 "Refuse to say"
	label values x8_suggcontr x8_suggcontr

	label variable x8_childresp "D. The child is the responsibility of both the man and the woman"
	note x8_childresp: "D. The child is the responsibility of both the man and the woman"
	label define x8_childresp 1 "Totally agree" 2 "Agree" 3 "Disagree" 4 "Totally disagree" -99 "Don't know" -97 "Refuse to say"
	label values x8_childresp x8_childresp

	label variable x8_fatherchild "E. The participation of the father is important in raising children"
	note x8_fatherchild: "E. The participation of the father is important in raising children"
	label define x8_fatherchild 1 "Totally agree" 2 "Agree" 3 "Disagree" 4 "Totally disagree" -99 "Don't know" -97 "Refuse to say"
	label values x8_fatherchild x8_fatherchild

	label variable x8_childdeci "F. Couple should decide together if they want to have children"
	note x8_childdeci: "F. Couple should decide together if they want to have children"
	label define x8_childdeci 1 "Totally agree" 2 "Agree" 3 "Disagree" 4 "Totally disagree" -99 "Don't know" -97 "Refuse to say"
	label values x8_childdeci x8_childdeci

	label variable x8_contratype "G. A man and woman should decide together what type of contraceptive to use"
	note x8_contratype: "G. A man and woman should decide together what type of contraceptive to use"
	label define x8_contratype 1 "Totally agree" 2 "Agree" 3 "Disagree" 4 "Totally disagree" -99 "Don't know" -97 "Refuse to say"
	label values x8_contratype x8_contratype

	label variable x9_1 "A. How to spend the money earned from IGA"
	note x9_1: "A. How to spend the money earned from IGA"
	label define x9_1 1 "Husband" 2 "Wife" 3 "Both" -99 "Don't know" -97 "Refuse to say"
	label values x9_1 x9_1

	label variable x9_2 "B. What food to buy and consume"
	note x9_2: "B. What food to buy and consume"
	label define x9_2 1 "Husband" 2 "Wife" 3 "Both" -99 "Don't know" -97 "Refuse to say"
	label values x9_2 x9_2

	label variable x9_3 "C. Purchase of furniture of the house/other household improvements"
	note x9_3: "C. Purchase of furniture of the house/other household improvements"
	label define x9_3 1 "Husband" 2 "Wife" 3 "Both" -99 "Don't know" -97 "Refuse to say"
	label values x9_3 x9_3

	label variable x9_4 "D. Purchase and sale of cattle/other livestock"
	note x9_4: "D. Purchase and sale of cattle/other livestock"
	label define x9_4 1 "Husband" 2 "Wife" 3 "Both" -99 "Don't know" -97 "Refuse to say"
	label values x9_4 x9_4

	label variable x9_5 "E. Purchase of plots of land"
	note x9_5: "E. Purchase of plots of land"
	label define x9_5 1 "Husband" 2 "Wife" 3 "Both" -99 "Don't know" -97 "Refuse to say"
	label values x9_5 x9_5

	label variable x9_6 "F. Purchase of large pots/pans"
	note x9_6: "F. Purchase of large pots/pans"
	label define x9_6 1 "Husband" 2 "Wife" 3 "Both" -99 "Don't know" -97 "Refuse to say"
	label values x9_6 x9_6

	label variable x9_7 "G. What to gift relatives when they marry/have children"
	note x9_7: "G. What to gift relatives when they marry/have children"
	label define x9_7 1 "Husband" 2 "Wife" 3 "Both" -99 "Don't know" -97 "Refuse to say"
	label values x9_7 x9_7

	label variable x9_largepurchase "H. Making large household purchases"
	note x9_largepurchase: "H. Making large household purchases"
	label define x9_largepurchase 1 "Husband" 2 "Wife" 3 "Both" -99 "Don't know" -97 "Refuse to say"
	label values x9_largepurchase x9_largepurchase

	label variable x9_dailypurchase "I. Making daily household purchases"
	note x9_dailypurchase: "I. Making daily household purchases"
	label define x9_dailypurchase 1 "Husband" 2 "Wife" 3 "Both" -99 "Don't know" -97 "Refuse to say"
	label values x9_dailypurchase x9_dailypurchase

	label variable x9_wifepersonal "J. Wife’s personal purchases"
	note x9_wifepersonal: "J. Wife’s personal purchases"
	label define x9_wifepersonal 1 "Husband" 2 "Wife" 3 "Both" -99 "Don't know" -97 "Refuse to say"
	label values x9_wifepersonal x9_wifepersonal

	label variable x9_borrow "K. Borrowing money"
	note x9_borrow: "K. Borrowing money"
	label define x9_borrow 1 "Husband" 2 "Wife" 3 "Both" -99 "Don't know" -97 "Refuse to say"
	label values x9_borrow x9_borrow

	label variable x9_lend "L. Lending money"
	note x9_lend: "L. Lending money"
	label define x9_lend 1 "Husband" 2 "Wife" 3 "Both" -99 "Don't know" -97 "Refuse to say"
	label values x9_lend x9_lend

	label variable x9_occupation "M. Wife’s choice of occupation"
	note x9_occupation: "M. Wife’s choice of occupation"
	label define x9_occupation 1 "Husband" 2 "Wife" 3 "Both" -99 "Don't know" -97 "Refuse to say"
	label values x9_occupation x9_occupation

	label variable x9_workplace "N. Wife’s place of work (home vs outside)"
	note x9_workplace: "N. Wife’s place of work (home vs outside)"
	label define x9_workplace 1 "Husband" 2 "Wife" 3 "Both" -99 "Don't know" -97 "Refuse to say"
	label values x9_workplace x9_workplace

	label variable x9_workhours "O. Wife’s working hours"
	note x9_workhours: "O. Wife’s working hours"
	label define x9_workhours 1 "Husband" 2 "Wife" 3 "Both" -99 "Don't know" -97 "Refuse to say"
	label values x9_workhours x9_workhours

	label variable x9_participation "P. Wife’s participation in groups"
	note x9_participation: "P. Wife’s participation in groups"
	label define x9_participation 1 "Husband" 2 "Wife" 3 "Both" -99 "Don't know" -97 "Refuse to say"
	label values x9_participation x9_participation

	label variable budget_hh "Does your household have a budget?"
	note budget_hh: "Does your household have a budget?"
	label define budget_hh 1 "Yes" 0 "No"
	label values budget_hh budget_hh

	label variable x9_daughwork "K.2.9.2. Would you like your daughter(s) to work outside the home when they beco"
	note x9_daughwork: "K.2.9.2. Would you like your daughter(s) to work outside the home when they become adults?"
	label define x9_daughwork 1 "Yes" 0 "No"
	label values x9_daughwork x9_daughwork

	label variable x9_sonwork "K.2.9.3. Would you like your son(s) to work outside the home when they become ad"
	note x9_sonwork: "K.2.9.3. Would you like your son(s) to work outside the home when they become adults?"
	label define x9_sonwork 1 "Yes" 0 "No"
	label values x9_sonwork x9_sonwork

	label variable x9_moneycontrol "K.2.9.4. Who do you think should have greater control over the money that your w"
	note x9_moneycontrol: "K.2.9.4. Who do you think should have greater control over the money that your wife earns?"
	label define x9_moneycontrol 1 "Spouse" 2 "Father" 3 "Mother" 4 "Brother" 5 "Sister" 6 "Uncle" 7 "Aunt" 8 "Uncle" 9 "Grandfather" 99 "Other"
	label values x9_moneycontrol x9_moneycontrol

	label variable x9_moneyspend "K.2.9.5. What do you think your wife's money should be spent on?"
	note x9_moneyspend: "K.2.9.5. What do you think your wife's money should be spent on?"

	label variable x9_clothing "K.2.9.6. Who do you think should decide what women should wear?"
	note x9_clothing: "K.2.9.6. Who do you think should decide what women should wear?"

	label variable x9_ornaments "K.2.9.7. Who do you think should keep the women's jewellery/ornaments?"
	note x9_ornaments: "K.2.9.7. Who do you think should keep the women's jewellery/ornaments?"

	label variable x9_chores "K.2.9.8. Who do you think should help your wife when she needs assistance in som"
	note x9_chores: "K.2.9.8. Who do you think should help your wife when she needs assistance in some household chores?"

	label variable x9_101 "A. Children's expenses"
	note x9_101: "A. Children's expenses"
	label define x9_101 1 "1. Never" 2 "2. rarely" 3 "3 sometimes" 4 "4. Often" 5 "5 Always"
	label values x9_101 x9_101

	label variable x9_102 "B. Children's education"
	note x9_102: "B. Children's education"
	label define x9_102 1 "1. Never" 2 "2. rarely" 3 "3 sometimes" 4 "4. Often" 5 "5 Always"
	label values x9_102 x9_102

	label variable x9_103 "C. Alcohol consumption"
	note x9_103: "C. Alcohol consumption"
	label define x9_103 1 "1. Never" 2 "2. rarely" 3 "3 sometimes" 4 "4. Often" 5 "5 Always"
	label values x9_103 x9_103

	label variable x9_104 "D. Your partner's relatives"
	note x9_104: "D. Your partner's relatives"
	label define x9_104 1 "1. Never" 2 "2. rarely" 3 "3 sometimes" 4 "4. Often" 5 "5 Always"
	label values x9_104 x9_104

	label variable x9_105 "E. How to use the money from the loan"
	note x9_105: "E. How to use the money from the loan"
	label define x9_105 1 "1. Never" 2 "2. rarely" 3 "3 sometimes" 4 "4. Often" 5 "5 Always"
	label values x9_105 x9_105

	label variable x9_106 "F. Domestic Work"
	note x9_106: "F. Domestic Work"
	label define x9_106 1 "1. Never" 2 "2. rarely" 3 "3 sometimes" 4 "4. Often" 5 "5 Always"
	label values x9_106 x9_106

	label variable x9_107 "G. How to use the land"
	note x9_107: "G. How to use the land"
	label define x9_107 1 "1. Never" 2 "2. rarely" 3 "3 sometimes" 4 "4. Often" 5 "5 Always"
	label values x9_107 x9_107

	label variable x9_108 "H. How to run the business"
	note x9_108: "H. How to run the business"
	label define x9_108 1 "1. Never" 2 "2. rarely" 3 "3 sometimes" 4 "4. Often" 5 "5 Always"
	label values x9_108 x9_108

	label variable x9_109 "I. Health Expenses"
	note x9_109: "I. Health Expenses"
	label define x9_109 1 "1. Never" 2 "2. rarely" 3 "3 sometimes" 4 "4. Often" 5 "5 Always"
	label values x9_109 x9_109

	label variable x3_gbviol "K.2.3.1. Has […] happened to you personally OR to another member of your househo"
	note x3_gbviol: "K.2.3.1. Has […] happened to you personally OR to another member of your household in the past 6 months?"
	label define x3_gbviol 1 "Yes" 0 "No"
	label values x3_gbviol x3_gbviol

	label variable x3_emoviol1 "A .Insulted you or deliberately made you feel bad about yourself (publicly or no"
	note x3_emoviol1: "A .Insulted you or deliberately made you feel bad about yourself (publicly or not)?"
	label define x3_emoviol1 1 "Yes" 0 "No"
	label values x3_emoviol1 x3_emoviol1

	label variable x3_emoviol2 "B .Did things to purposely scare or intimidate you (threatened to hurt you or so"
	note x3_emoviol2: "B .Did things to purposely scare or intimidate you (threatened to hurt you or someone you care about)?"
	label define x3_emoviol2 1 "Yes" 0 "No"
	label values x3_emoviol2 x3_emoviol2

	label variable x3_phyviol1 "C .Pushed you, slapped you, kicked you, strangled you, purposely burned you"
	note x3_phyviol1: "C .Pushed you, slapped you, kicked you, strangled you, purposely burned you"
	label define x3_phyviol1 1 "Yes" 0 "No"
	label values x3_phyviol1 x3_phyviol1

	label variable x3_phyviol2 "D .Used or threatened to use a gun, knife, or other weapon against you?"
	note x3_phyviol2: "D .Used or threatened to use a gun, knife, or other weapon against you?"
	label define x3_phyviol2 1 "Yes" 0 "No"
	label values x3_phyviol2 x3_phyviol2

	label variable x3_ecoviol1 "F .Prohibited you from getting a job, going to work, trading, or earning money?"
	note x3_ecoviol1: "F .Prohibited you from getting a job, going to work, trading, or earning money?"
	label define x3_ecoviol1 1 "Yes" 0 "No"
	label values x3_ecoviol1 x3_ecoviol1

	label variable x3_ecoviol2 "G .Took or controlled your money against your will?"
	note x3_ecoviol2: "G .Took or controlled your money against your will?"
	label define x3_ecoviol2 1 "Yes" 0 "No"
	label values x3_ecoviol2 x3_ecoviol2

	label variable x3_ecoviol3 "H .Threw you out of the house?"
	note x3_ecoviol3: "H .Threw you out of the house?"
	label define x3_ecoviol3 1 "Yes" 0 "No"
	label values x3_ecoviol3 x3_ecoviol3

	label variable x3_sexoviol "I .Forced you to have sexual intercourse or to perform any other sexual acts whe"
	note x3_sexoviol: "I .Forced you to have sexual intercourse or to perform any other sexual acts when you did not want to?"
	label define x3_sexoviol 1 "Yes" 0 "No"
	label values x3_sexoviol x3_sexoviol

	label variable x4_hhemoviol1 "A. Insults"
	note x4_hhemoviol1: "A. Insults"

	label variable x4_hhemoviol2 "B .Intimidation by scaring"
	note x4_hhemoviol2: "B .Intimidation by scaring"

	label variable x4_hhphyviol1 "C .Pushing, slapping, kicking, strangling, purposely burning someone"
	note x4_hhphyviol1: "C .Pushing, slapping, kicking, strangling, purposely burning someone"

	label variable x4_hhphyviol2 "D. Were threatened by a gun, knifem or other weapon"
	note x4_hhphyviol2: "D. Were threatened by a gun, knifem or other weapon"

	label variable x4_hhecoviol1 "F .Prohibited from getting a job, going to work, trading, or earning money?"
	note x4_hhecoviol1: "F .Prohibited from getting a job, going to work, trading, or earning money?"

	label variable x4_hhecoviol2 "G .Confiscation of their money"
	note x4_hhecoviol2: "G .Confiscation of their money"

	label variable x4_hhecoviol3 "H. Thrown out of house"
	note x4_hhecoviol3: "H. Thrown out of house"

	label variable x4_hhsexoviol "I .Forced to have sexual intercourse or to perform any other sexual acts when th"
	note x4_hhsexoviol: "I .Forced to have sexual intercourse or to perform any other sexual acts when they did not want to?"

	label variable x5_perpemoviol1 "A .Insulted you or deliberately made you feel bad about yourself (publicly or no"
	note x5_perpemoviol1: "A .Insulted you or deliberately made you feel bad about yourself (publicly or not)?"

	label variable x5_perpemoviol2 "B .Did things to purposely scare or intimidate you (threatened to hurt you or so"
	note x5_perpemoviol2: "B .Did things to purposely scare or intimidate you (threatened to hurt you or someone you care about)?"

	label variable x5_perpphyviol1 "C .Pushed you, slapped you, kicked you, strangled you, purposely burned you"
	note x5_perpphyviol1: "C .Pushed you, slapped you, kicked you, strangled you, purposely burned you"

	label variable x5_perpphyviol2 "D .Used or threatened to use a gun, knife, or other weapon against you?"
	note x5_perpphyviol2: "D .Used or threatened to use a gun, knife, or other weapon against you?"

	label variable x5_perpecoviol1 "F .Prohibited you from getting a job, going to work, trading, or earning money?"
	note x5_perpecoviol1: "F .Prohibited you from getting a job, going to work, trading, or earning money?"

	label variable x5_perpecoviol2 "G .Took or controlled your money against your will?"
	note x5_perpecoviol2: "G .Took or controlled your money against your will?"

	label variable x5_perpecoviol3 "H .Threw you out of the house?"
	note x5_perpecoviol3: "H .Threw you out of the house?"

	label variable x5_perpsexoviol "I .Forced you to have sexual intercourse or to perform any other sexual acts whe"
	note x5_perpsexoviol: "I .Forced you to have sexual intercourse or to perform any other sexual acts when you did not want to?"

	label variable h3_victimizationsintro "In the last 6 months (Read aloud)"
	note h3_victimizationsintro: "In the last 6 months (Read aloud)"
	label define h3_victimizationsintro 1 "Yes" 0 "No" -99 "Don't know" -97 "Refuse to say"
	label values h3_victimizationsintro h3_victimizationsintro

	label variable h3_landvictim "K.3.1. Have you or a member of your household been victim of land conflict?"
	note h3_landvictim: "K.3.1. Have you or a member of your household been victim of land conflict?"
	label define h3_landvictim 1 "Yes" 0 "No" -99 "Don't know" -97 "Refuse to say"
	label values h3_landvictim h3_landvictim

	label variable h3_physivictim "K.3.2. Have you or a member of your household been victim of physical aggression"
	note h3_physivictim: "K.3.2. Have you or a member of your household been victim of physical aggression?"
	label define h3_physivictim 1 "Yes" 0 "No" -99 "Don't know" -97 "Refuse to say"
	label values h3_physivictim h3_physivictim

	label variable h3_stolenvictim "K.3.3. Has you or a member of your household had valuables stolen from your hous"
	note h3_stolenvictim: "K.3.3. Has you or a member of your household had valuables stolen from your house, farm or business?"
	label define h3_stolenvictim 1 "Yes" 0 "No" -99 "Don't know" -97 "Refuse to say"
	label values h3_stolenvictim h3_stolenvictim

	label variable h3_robbevictim "K.3.4. Have you or a member of your household been victim of violent robbery?"
	note h3_robbevictim: "K.3.4. Have you or a member of your household been victim of violent robbery?"
	label define h3_robbevictim 1 "Yes" 0 "No" -99 "Don't know" -97 "Refuse to say"
	label values h3_robbevictim h3_robbevictim

	label variable h3_futurvictim "K.3.6. Do you fear any of these incidents may happen to you or a member of your "
	note h3_futurvictim: "K.3.6. Do you fear any of these incidents may happen to you or a member of your household in the future?"
	label define h3_futurvictim 1 "Yes" 0 "No" -99 "Don't know" -97 "Refuse to say"
	label values h3_futurvictim h3_futurvictim

	label variable h3_hearphysivictim "K.3.7. Have you witnessed or heard about physical aggression in this community?"
	note h3_hearphysivictim: "K.3.7. Have you witnessed or heard about physical aggression in this community?"
	label define h3_hearphysivictim 1 "Yes" 0 "No" -99 "Don't know" -97 "Refuse to say"
	label values h3_hearphysivictim h3_hearphysivictim

	label variable h3_heardomviol "K.3.10. Have you heard or witness domestic violence in a neighbor’s household in"
	note h3_heardomviol: "K.3.10. Have you heard or witness domestic violence in a neighbor’s household in this community?"
	label define h3_heardomviol 1 "Yes" 0 "No" -99 "Don't know" -97 "Refuse to say"
	label values h3_heardomviol h3_heardomviol

	label variable hh_social_1 "During the past month, did you (or your HH)"
	note hh_social_1: "During the past month, did you (or your HH)"

	label variable hh_social_2 "Today, does your family have issue being integrated with other HH of the communi"
	note hh_social_2: "Today, does your family have issue being integrated with other HH of the community ?"
	label define hh_social_2 1 "With a lot of difficulties" 2 "With some difficulties" 3 "No difficulties" -97 "Refuse to say" -99 "Don't know"
	label values hh_social_2 hh_social_2

	label variable hh_social_3 "How would you describe the relationship between member of your HH ?"
	note hh_social_3: "How would you describe the relationship between member of your HH ?"
	label define hh_social_3 1 "Bad" 2 "Good" 3 "Really good" -97 "Refuse to say" -99 "Don't know"
	label values hh_social_3 hh_social_3

	label variable h4_conflictyp "K.4.1. Did the conflict or dispute occur in the village/ community?"
	note h4_conflictyp: "K.4.1. Did the conflict or dispute occur in the village/ community?"
	label define h4_conflictyp 1 "Yes" 0 "No"
	label values h4_conflictyp h4_conflictyp

	label variable h4_land "A. Conflict or dispute over land or property"
	note h4_land: "A. Conflict or dispute over land or property"
	label define h4_land 1 "Yes" 0 "No"
	label values h4_land h4_land

	label variable h4_crops "B. Destruction of crops by livestock"
	note h4_crops: "B. Destruction of crops by livestock"
	label define h4_crops 1 "Yes" 0 "No"
	label values h4_crops h4_crops

	label variable h4_inheritance "D. Conflict of inheritance"
	note h4_inheritance: "D. Conflict of inheritance"
	label define h4_inheritance 1 "Yes" 0 "No"
	label values h4_inheritance h4_inheritance

	label variable h4_youngelder "G. Conflicts or disputes between young people and older people"
	note h4_youngelder: "G. Conflicts or disputes between young people and older people"
	label define h4_youngelder 1 "Yes" 0 "No"
	label values h4_youngelder h4_youngelder

	label variable h4_religious "H. Religious conflict or disputes (between people from different denominations)"
	note h4_religious: "H. Religious conflict or disputes (between people from different denominations)"
	label define h4_religious 1 "Yes" 0 "No"
	label values h4_religious h4_religious

	label variable h4_ethnic "I. Ethnic conflict (between different ethic or tribal groups)"
	note h4_ethnic: "I. Ethnic conflict (between different ethic or tribal groups)"
	label define h4_ethnic 1 "Yes" 0 "No"
	label values h4_ethnic h4_ethnic

	label variable h4_political "J. Conflict between people belonging to different political parties/groups"
	note h4_political: "J. Conflict between people belonging to different political parties/groups"
	label define h4_political 1 "Yes" 0 "No"
	label values h4_political h4_political

	label variable h4_otherconflict "L. Other communal conflict (Specify)"
	note h4_otherconflict: "L. Other communal conflict (Specify)"
	label define h4_otherconflict 1 "Yes" 0 "No"
	label values h4_otherconflict h4_otherconflict

	label variable h4_otherconflictother "specify other"
	note h4_otherconflictother: "specify other"

	label variable h4_conflictled "K.4.2. Has this conflict or dispute led to violence?"
	note h4_conflictled: "K.4.2. Has this conflict or dispute led to violence?"
	label define h4_conflictled 1 "Yes" 0 "No"
	label values h4_conflictled h4_conflictled

	label variable h4_landled "A. Conflict or dispute over land or property"
	note h4_landled: "A. Conflict or dispute over land or property"
	label define h4_landled 1 "Yes" 0 "No"
	label values h4_landled h4_landled

	label variable h4_cropsled "B. Destruction of crops by livestock"
	note h4_cropsled: "B. Destruction of crops by livestock"
	label define h4_cropsled 1 "Yes" 0 "No"
	label values h4_cropsled h4_cropsled

	label variable h4_inheritanceled "D. Conflict of inheritance"
	note h4_inheritanceled: "D. Conflict of inheritance"
	label define h4_inheritanceled 1 "Yes" 0 "No"
	label values h4_inheritanceled h4_inheritanceled

	label variable h4_youngelderled "G. Conflicts or disputes between young people and older people"
	note h4_youngelderled: "G. Conflicts or disputes between young people and older people"
	label define h4_youngelderled 1 "Yes" 0 "No"
	label values h4_youngelderled h4_youngelderled

	label variable h4_religiousled "H. Religious conflict or disputes (between people from different denominations)"
	note h4_religiousled: "H. Religious conflict or disputes (between people from different denominations)"
	label define h4_religiousled 1 "Yes" 0 "No"
	label values h4_religiousled h4_religiousled

	label variable h4_ethnicled "I. Ethnic conflict (between different ethic or tribal groups)"
	note h4_ethnicled: "I. Ethnic conflict (between different ethic or tribal groups)"
	label define h4_ethnicled 1 "Yes" 0 "No"
	label values h4_ethnicled h4_ethnicled

	label variable h4_politicalled "J. Conflict between people belonging to different political parties/groups"
	note h4_politicalled: "J. Conflict between people belonging to different political parties/groups"
	label define h4_politicalled 1 "Yes" 0 "No"
	label values h4_politicalled h4_politicalled

	label variable h4_otherconflictled "L. (\${h4_otherconflictother})"
	note h4_otherconflictled: "L. (\${h4_otherconflictother})"
	label define h4_otherconflictled 1 "Yes" 0 "No"
	label values h4_otherconflictled h4_otherconflictled

	label variable h4_conflicthh "K.4.3. Your household was affected by this conflict or dispute?"
	note h4_conflicthh: "K.4.3. Your household was affected by this conflict or dispute?"
	label define h4_conflicthh 1 "Yes" 0 "No"
	label values h4_conflicthh h4_conflicthh

	label variable h4_landhh "A. Conflict or dispute over land or property"
	note h4_landhh: "A. Conflict or dispute over land or property"
	label define h4_landhh 1 "Yes" 0 "No"
	label values h4_landhh h4_landhh

	label variable h4_cropshh "B. Destruction of crops by livestock"
	note h4_cropshh: "B. Destruction of crops by livestock"
	label define h4_cropshh 1 "Yes" 0 "No"
	label values h4_cropshh h4_cropshh

	label variable h4_inheritancehh "D. Conflict of inheritance"
	note h4_inheritancehh: "D. Conflict of inheritance"
	label define h4_inheritancehh 1 "Yes" 0 "No"
	label values h4_inheritancehh h4_inheritancehh

	label variable h4_youngelderhh "G. Conflicts or disputes between young people and older people"
	note h4_youngelderhh: "G. Conflicts or disputes between young people and older people"
	label define h4_youngelderhh 1 "Yes" 0 "No"
	label values h4_youngelderhh h4_youngelderhh

	label variable h4_religioushh "H. Religious conflict or disputes (between people from different denominations)"
	note h4_religioushh: "H. Religious conflict or disputes (between people from different denominations)"
	label define h4_religioushh 1 "Yes" 0 "No"
	label values h4_religioushh h4_religioushh

	label variable h4_ethnichh "I. Ethnic conflict (between different ethic or tribal groups)"
	note h4_ethnichh: "I. Ethnic conflict (between different ethic or tribal groups)"
	label define h4_ethnichh 1 "Yes" 0 "No"
	label values h4_ethnichh h4_ethnichh

	label variable h4_politicalhh "J. Conflict between people belonging to different political parties/groups"
	note h4_politicalhh: "J. Conflict between people belonging to different political parties/groups"
	label define h4_politicalhh 1 "Yes" 0 "No"
	label values h4_politicalhh h4_politicalhh

	label variable h4_otherconflicthh "L. (\${h4_otherconflictother})"
	note h4_otherconflicthh: "L. (\${h4_otherconflictother})"
	label define h4_otherconflicthh 1 "Yes" 0 "No"
	label values h4_otherconflicthh h4_otherconflicthh

	label variable h4_conflictctact "K.4.4. Did you contact the authorities?"
	note h4_conflictctact: "K.4.4. Did you contact the authorities?"
	label define h4_conflictctact 1 "Yes" 0 "No"
	label values h4_conflictctact h4_conflictctact

	label variable h4_landctact "A. Concerning the conflict or dispute over land or property"
	note h4_landctact: "A. Concerning the conflict or dispute over land or property"
	label define h4_landctact 1 "Yes" 0 "No"
	label values h4_landctact h4_landctact

	label variable h4_cropsctact "B. Concerning the destruction of crops by livestock"
	note h4_cropsctact: "B. Concerning the destruction of crops by livestock"
	label define h4_cropsctact 1 "Yes" 0 "No"
	label values h4_cropsctact h4_cropsctact

	label variable h4_inheritancectact "D. Concerning the conflict of inheritance"
	note h4_inheritancectact: "D. Concerning the conflict of inheritance"
	label define h4_inheritancectact 1 "Yes" 0 "No"
	label values h4_inheritancectact h4_inheritancectact

	label variable h4_youngelderact "G. Conflicts or disputes between young people and older people"
	note h4_youngelderact: "G. Conflicts or disputes between young people and older people"
	label define h4_youngelderact 1 "Yes" 0 "No"
	label values h4_youngelderact h4_youngelderact

	label variable h4_religiousctact "H. Concerning the religious conflict or disputes (between people from different "
	note h4_religiousctact: "H. Concerning the religious conflict or disputes (between people from different denominations)"
	label define h4_religiousctact 1 "Yes" 0 "No"
	label values h4_religiousctact h4_religiousctact

	label variable h4_ethnicctact "I. Concerning the ethnic conflict (between different ethic or tribal groups)"
	note h4_ethnicctact: "I. Concerning the ethnic conflict (between different ethic or tribal groups)"
	label define h4_ethnicctact 1 "Yes" 0 "No"
	label values h4_ethnicctact h4_ethnicctact

	label variable h4_politicalctact "J. Concerning the conflict between people belonging to different political parti"
	note h4_politicalctact: "J. Concerning the conflict between people belonging to different political parties/groups"
	label define h4_politicalctact 1 "Yes" 0 "No"
	label values h4_politicalctact h4_politicalctact

	label variable h4_otherconflictctact "L. (Concerning the \${h4_otherconflictother})"
	note h4_otherconflictctact: "L. (Concerning the \${h4_otherconflictother})"
	label define h4_otherconflictctact 1 "Yes" 0 "No"
	label values h4_otherconflictctact h4_otherconflictctact

	label variable h4_conflictres "K.4.5. Did you contact the authorities?"
	note h4_conflictres: "K.4.5. Did you contact the authorities?"
	label define h4_conflictres 1 "Yes" 0 "No"
	label values h4_conflictres h4_conflictres

	label variable h4_landres "A. Conflict or dispute over land or property"
	note h4_landres: "A. Conflict or dispute over land or property"
	label define h4_landres 1 "Yes" 0 "No"
	label values h4_landres h4_landres

	label variable h4_cropsres "B. Destruction of crops by livestock"
	note h4_cropsres: "B. Destruction of crops by livestock"
	label define h4_cropsres 1 "Yes" 0 "No"
	label values h4_cropsres h4_cropsres

	label variable h4_inheritanceres "E. Conflict of inheritance"
	note h4_inheritanceres: "E. Conflict of inheritance"
	label define h4_inheritanceres 1 "Yes" 0 "No"
	label values h4_inheritanceres h4_inheritanceres

	label variable h4_youngelderes "G. Conflicts or disputes between young people and older people"
	note h4_youngelderes: "G. Conflicts or disputes between young people and older people"
	label define h4_youngelderes 1 "Yes" 0 "No"
	label values h4_youngelderes h4_youngelderes

	label variable h4_religiousres "I. Religious conflict or disputes (between people from different denominations)"
	note h4_religiousres: "I. Religious conflict or disputes (between people from different denominations)"
	label define h4_religiousres 1 "Yes" 0 "No"
	label values h4_religiousres h4_religiousres

	label variable h4_ethnicres "J. Ethnic conflict (between different ethic or tribal groups)"
	note h4_ethnicres: "J. Ethnic conflict (between different ethic or tribal groups)"
	label define h4_ethnicres 1 "Yes" 0 "No"
	label values h4_ethnicres h4_ethnicres

	label variable h4_politicalres "K. Conflict between people belonging to different political parties/groups"
	note h4_politicalres: "K. Conflict between people belonging to different political parties/groups"
	label define h4_politicalres 1 "Yes" 0 "No"
	label values h4_politicalres h4_politicalres

	label variable h4_otherconflictres "M. Other communal conflict (\${h4_otherconflictother})"
	note h4_otherconflictres: "M. Other communal conflict (\${h4_otherconflictother})"
	label define h4_otherconflictres 1 "Yes" 0 "No"
	label values h4_otherconflictres h4_otherconflictres

	label variable trauma_cauchemars "When you thought of the revolution or the war on terror, did you have restless n"
	note trauma_cauchemars: "When you thought of the revolution or the war on terror, did you have restless nights, or did you have nightmares at night?"
	label define trauma_cauchemars 1 "Yes" 0 "No"
	label values trauma_cauchemars trauma_cauchemars

	label variable trauma_souvenirs "When you thought of the revolution or the war on terror, did you experience ches"
	note trauma_souvenirs: "When you thought of the revolution or the war on terror, did you experience chest pains or headaches?"
	label define trauma_souvenirs 1 "Yes" 0 "No"
	label values trauma_souvenirs trauma_souvenirs

	label variable trauma_fin "M.8. In general, what do you do to feel better when thinking about the revolutio"
	note trauma_fin: "M.8. In general, what do you do to feel better when thinking about the revolution or about the war ?"

	label variable i2_taxesintro "We have finished our conversation. As a thank you, we have a small token of 10 D"
	note i2_taxesintro: "We have finished our conversation. As a thank you, we have a small token of 10 Dinars for you. As you know, the government of Tunisia requires every citizen to pay taxes on their income or on the money they receive. These resources are essential for the government to provide basic services such as security, health care, education, etc. By law, the current tax rate FOR AN INCOME OF THIS SIZE IS 35%, which means for the gift we have given you. you would be supposed to pay 3 Dinars in taxes. You can choose to pay this amount to the government, to any other amount you want, or to nothing at all. If you do not wish to pay anything, the government will not be notified of your decision or anything that we have discussed today. How much money are you willing to pay for taxes?"

	label variable i2_taxesintro_sup "Would you like to contribute more than the maximu of 10 Dinars allowed ?"
	note i2_taxesintro_sup: "Would you like to contribute more than the maximu of 10 Dinars allowed ?"
	label define i2_taxesintro_sup 1 "Yes" 0 "No"
	label values i2_taxesintro_sup i2_taxesintro_sup

	label variable i2_taxesintro_sup_num "How much in total would you want to contribute to the taxes effort ?"
	note i2_taxesintro_sup_num: "How much in total would you want to contribute to the taxes effort ?"

	label variable i3_personcontribut "L.2.1. Does the person want to contribute to a project?"
	note i3_personcontribut: "L.2.1. Does the person want to contribute to a project?"
	label define i3_personcontribut 1 "Yes" 0 "No"
	label values i3_personcontribut i3_personcontribut

	label variable i3_vilgectribut "L.2.2. How much would you like to contribute to a community project in your vill"
	note i3_vilgectribut: "L.2.2. How much would you like to contribute to a community project in your village/ neighborhood?"

	label variable i3_vilgengthctribut "L.2.3. How much would you like to contribute to a joint community project betwee"
	note i3_vilgengthctribut: "L.2.3. How much would you like to contribute to a joint community project between your village/ neighborhood and a neighboring community?"

	label variable j_interviewlang "N1. Language used to conduct the interview"
	note j_interviewlang: "N1. Language used to conduct the interview"
	label define j_interviewlang 1 "1.ARABE" 2 "2.Francais (M)"
	label values j_interviewlang j_interviewlang

	label variable j_respondentability "N2. How do you judge the ability of the respondent (s) to understand the languag"
	note j_respondentability: "N2. How do you judge the ability of the respondent (s) to understand the language used to conduct the interview?"
	label define j_respondentability 0 "Has not experienced difficulties" 1 "Experienced medium difficulty" 2 "A great difficulty"
	label values j_respondentability j_respondentability

	label variable j_respondentdisposal "N3. Do you think the respondent wanted to share the information?"
	note j_respondentdisposal: "N3. Do you think the respondent wanted to share the information?"
	label define j_respondentdisposal 0 "Very willing to share" 1 "indifferent" 2 "Unwilling to share"
	label values j_respondentdisposal j_respondentdisposal

	label variable j_respondentfocus "N4. Do you think the respondent remained focused throughout the interview?"
	note j_respondentfocus: "N4. Do you think the respondent remained focused throughout the interview?"
	label define j_respondentfocus 0 "Focused during all maintenance" 1 "Lost in the middle concentration" 2 "Was distracted throughout the interview"
	label values j_respondentfocus j_respondentfocus

	label variable j_interviewflows "N5. The interview stopped before completing all the questions?"
	note j_interviewflows: "N5. The interview stopped before completing all the questions?"
	label define j_interviewflows 1 "Yes" 0 "No"
	label values j_interviewflows j_interviewflows

	label variable j_interstopped "Why did the interview stop"
	note j_interstopped: "Why did the interview stop"

	label variable resultat "N7. Interview results"
	note resultat: "N7. Interview results"
	label define resultat 1 "ENTRETIEN REALISE" 2 "PARTIELLEMENT COMPLETE" 3 "CHEF DE MENAGE/AUTRE PERSONNE A REFUSE D'AUTORISER L'ENTRETIEN" 4 "MENAGE VIDE" 99 "AUTRE, SPECIFIER"
	label values resultat resultat

	label variable resultat_autre "N8. Results of the interview if other"
	note resultat_autre: "N8. Results of the interview if other"

	label variable a1_gpslatitude "A.1.7.(C) GPS Coordinates (latitude)"
	note a1_gpslatitude: "A.1.7.(C) GPS Coordinates (latitude)"

	label variable a1_gpslongitude "A.1.7.(C) GPS Coordinates (longitude)"
	note a1_gpslongitude: "A.1.7.(C) GPS Coordinates (longitude)"

	label variable a1_gpsaltitude "A.1.7.(C) GPS Coordinates (altitude)"
	note a1_gpsaltitude: "A.1.7.(C) GPS Coordinates (altitude)"

	label variable a1_gpsaccuracy "A.1.7.(C) GPS Coordinates (accuracy)"
	note a1_gpsaccuracy: "A.1.7.(C) GPS Coordinates (accuracy)"



	capture {
		foreach rgvar of varlist b3_a_* {
			label variable `rgvar' "What is the value in Dinars of the \${food_name} bought by your HH during the la"
			note `rgvar': "What is the value in Dinars of the \${food_name} bought by your HH during the last 7 days"
		}
	}

	capture {
		foreach rgvar of varlist b3_b_* {
			label variable `rgvar' "How much time did your HH bought \${food_name} during the last 30 days ?"
			note `rgvar': "How much time did your HH bought \${food_name} during the last 30 days ?"
		}
	}




	* append old, previously-imported data (if any)
	cap confirm file "`dtafile'"
	if _rc == 0 {
		* mark all new data before merging with old data
		gen new_data_row=1
		
		* pull in old data
		append using "`dtafile'"
		
		* drop duplicates in favor of old, previously-imported data if overwrite_old_data is 0
		* (alternatively drop in favor of new data if overwrite_old_data is 1)
		sort key
		by key: gen num_for_key = _N
		drop if num_for_key > 1 & ((`overwrite_old_data' == 0 & new_data_row == 1) | (`overwrite_old_data' == 1 & new_data_row ~= 1))
		drop num_for_key

		* drop new-data flag
		drop new_data_row
	}
	
	* save data to Stata format
	save "`dtafile'", replace

	* show codebook and notes
	codebook
	notes list
}

disp
disp "Finished import of: `csvfile'"
disp

* OPTIONAL: LOCALLY-APPLIED STATA CORRECTIONS
*
* Rather than using SurveyCTO's review and correction workflow, the code below can apply a list of corrections
* listed in a local .csv file. Feel free to use, ignore, or delete this code.
*
*   Corrections file path and filename:  DIME_Tunisia_Entrepreneurship_corrections.csv
*
*   Corrections file columns (in order): key, fieldname, value, notes

capture confirm file "`corrfile'"
if _rc==0 {
	disp
	disp "Starting application of corrections in: `corrfile'"
	disp

	* save primary data in memory
	preserve

	* load corrections
	insheet using "`corrfile'", names clear
	
	if _N>0 {
		* number all rows (with +1 offset so that it matches row numbers in Excel)
		gen rownum=_n+1
		
		* drop notes field (for information only)
		drop notes
		
		* make sure that all values are in string format to start
		gen origvalue=value
		tostring value, format(%100.0g) replace
		cap replace value="" if origvalue==.
		drop origvalue
		replace value=trim(value)
		
		* correct field names to match Stata field names (lowercase, drop -'s and .'s)
		replace fieldname=lower(subinstr(subinstr(fieldname,"-","",.),".","",.))
		
		/*
		* format date and date/time fields (taking account of possible wildcards for repeat groups)
		forvalues i = 1/100 {
			if "`datetime_fields`i''" ~= "" {
				foreach dtvar in `datetime_fields`i'' {
					* skip fields that aren't yet in the data
					cap unab dtvarignore : `dtvar'
					if _rc==0 {
						gen origvalue=value
						replace value=string(clock(value,"DMYhms",2025),"%25.0g") if strmatch(fieldname,"`dtvar'")
						* allow for cases where seconds haven't been specified
						replace value=string(clock(origvalue,"DMYhm",2025),"%25.0g") if strmatch(fieldname,"`dtvar'") & value=="." & origvalue~="."
						drop origvalue
					}
				}
			}
			if "`date_fields`i''" ~= "" {
				foreach dtvar in `date_fields`i'' {
					* skip fields that aren't yet in the data
					cap unab dtvarignore : `dtvar'
					if _rc==0 {
						replace value=string(clock(value,"DMY",2025),"%25.0g") if strmatch(fieldname,"`dtvar'")
					}
				}
			}
		}
		*/
		
		* write out a temp file with the commands necessary to apply each correction
		tempfile tempdo
		file open dofile using "`tempdo'", write replace
		local N = _N
		forvalues i = 1/`N' {
			local fieldnameval=fieldname[`i']
			local valueval=value[`i']
			local keyval=key[`i']
			local rownumval=rownum[`i']
			file write dofile `"cap replace `fieldnameval'="`valueval'" if key=="`keyval'""' _n
			file write dofile `"if _rc ~= 0 {"' _n
			if "`valueval'" == "" {
				file write dofile _tab `"cap replace `fieldnameval'=. if key=="`keyval'""' _n
			}
			else {
				file write dofile _tab `"cap replace `fieldnameval'=`valueval' if key=="`keyval'""' _n
			}
			file write dofile _tab `"if _rc ~= 0 {"' _n
			file write dofile _tab _tab `"disp"' _n
			file write dofile _tab _tab `"disp "CAN'T APPLY CORRECTION IN ROW #`rownumval'""' _n
			file write dofile _tab _tab `"disp"' _n
			file write dofile _tab `"}"' _n
			file write dofile `"}"' _n
		}
		file close dofile
	
		* restore primary data
		restore
		
		* execute the .do file to actually apply all corrections
		do "`tempdo'"

		* re-save data
		save "`dtafile'", replace
	}
	else {
		* restore primary data		
		restore
	}

	disp
	disp "Finished applying corrections in: `corrfile'"
	disp
}
