* import_DIME_Tunisia_Backcheck.do
*
* 	Imports and aggregates "DIME_Tunisia_Backcheck" (ID: DIME_Tunisia_Backcheck) data.
*
*	Inputs:  "DIME_Tunisia_Backcheck_WIDE.csv"
*	Outputs: "DIME_Tunisia_Backcheck.dta"
*
*	Output by SurveyCTO March 23, 2021 11:20 AM.

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
local csvfile "DIME_Tunisia_Backcheck_WIDE.csv"
local dtafile "DIME_Tunisia_Backcheck.dta"
local corrfile "DIME_Tunisia_Backcheck_corrections.csv"
local note_fields1 ""
local text_fields1 "deviceid1 subscriberid1 simid devicephonenum username duration name age sex calc_treatment calc_treatment2 date_interview enumerator_interview rand_module remain remain2 c2_saved12wher c2_spendsaved"
local text_fields2 "c2_spendsaved_other c2_borrowwho c2_borrowwho_other c2_borrow12on c2_borrow12on_other c2_company c2_access_who c2_borrowmore12on c2_borrowmore12oter c3_trainkind c3_trainkind_other c3_skills"
local text_fields3 "c3_skills_other c3_dreamjobdif c3_dreamjobdif_other c3_obssmallbusdif c3_obssmallbusdifother c4_hhmigreason c4_hhmigreasonother c4_hhmbernewreas c4_hhmbernewreasother c4_travelreason"
local text_fields4 "c4_travelreasonother e1_modwater_f e1_modwater_e e1_modwater_a e1_moddrinkwaterother e1_modmarket_f e1_modmarket_e e1_modmarket_a e1_modfoodmarketother e1_modprimaryschoolother e1_modprimary_f"
local text_fields5 "e1_modprimary_e e1_modprimary_a e1_modsecdryschoolother e1_modsecondary_f e1_modsecondary_e e1_modsecondary_a e1_moddispensary_f e1_moddispensary_e e1_moddispensary_a e1_moddispsaryclinicother"
local text_fields6 "e1_modbusstopother e1_modbus_f e1_modbus_e e1_modbus_a e1_modfirestationother e1_modfire_f e1_modfire_e e1_modfire_a e1_modpolicestationother e1_modpolice_f e1_modpolice_e e1_modpolice_a"
local text_fields7 "e1_modadmincenterother e1_modadmin_f e1_modadmin_e e1_modadmin_a e2_hh_conditios e2_hh_conditiosother e2_visitedservices e2_hh_medicalcareother g1_othergroup j_interstopped resultat_autre instanceid"
local date_fields1 "a1_date conf_date c2_depositacns"
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
						cap replace `dtvar'=clock(`tempdtvar',"MDYhms",2025)
						* automatically try without seconds, just in case
						cap replace `dtvar'=clock(`tempdtvar',"MDYhm",2025) if `dtvar'==. & `tempdtvar'~=""
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
						cap replace `dtvar'=date(`tempdtvar',"MDY",2025)
						format %td `dtvar'
						drop `tempdtvar'
					}
				}
			}
		}
	}

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
	label define a1_enumerator 1 "Dorra" 2 "Sonia" 3 "Nada" 4 "Asma"
	label values a1_enumerator a1_enumerator

	label variable a1_date "A.1.2 Date"
	note a1_date: "A.1.2 Date"

	label variable a1_timeinterview "A.1.2 (B) Time of the interview"
	note a1_timeinterview: "A.1.2 (B) Time of the interview"

	label variable hhid "Enter the code of the candidate"
	note hhid: "Enter the code of the candidate"

	label variable hhid_confirm "Confirm candidate's code"
	note hhid_confirm: "Confirm candidate's code"

	label variable confirm_resp "Here's the respondent information number \${hhid}, please confirm these informat"
	note confirm_resp: "Here's the respondent information number \${hhid}, please confirm these informations are correct."
	label define confirm_resp 1 "Yes" 0 "No"
	label values confirm_resp confirm_resp

	label variable confirm_name "Nom : \${name}"
	note confirm_name: "Nom : \${name}"
	label define confirm_name 1 "Yes" 0 "No"
	label values confirm_name confirm_name

	label variable confirm_age "Age : \${age}"
	note confirm_age: "Age : \${age}"
	label define confirm_age 1 "Yes" 0 "No"
	label values confirm_age confirm_age

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

	label variable conf_visit_2 "Have you been visited to take part to a survey ?"
	note conf_visit_2: "Have you been visited to take part to a survey ?"
	label define conf_visit_2 1 "Yes" 0 "No"
	label values conf_visit_2 conf_visit_2

	label variable conf_visit "Did \${enumerator_interview} visited you the \${date_interview} ?"
	note conf_visit: "Did \${enumerator_interview} visited you the \${date_interview} ?"
	label define conf_visit 1 "Yes" 0 "No"
	label values conf_visit conf_visit

	label variable wrong_enum "Have you been visited by another enumerator than \${enumerator_interview} ?"
	note wrong_enum: "Have you been visited by another enumerator than \${enumerator_interview} ?"
	label define wrong_enum 1 "Yes" 0 "No"
	label values wrong_enum wrong_enum

	label variable wrong_date "Have you been visited at a different date than \${date_interview} ?"
	note wrong_date: "Have you been visited at a different date than \${date_interview} ?"
	label define wrong_date 1 "Yes" 0 "No"
	label values wrong_date wrong_date

	label variable conf_enum "What was the name of the enumerator who visited you ?"
	note conf_enum: "What was the name of the enumerator who visited you ?"
	label define conf_enum 1 "Abidi Aida" 2 "Afef HERMI" 3 "Amal Jemai" 4 "Amina Abidi" 5 "Bouslimi Ameni" 6 "Ebdelli Raouf" 7 "Farah Rezgui" 8 "Ghribi Marwen" 9 "Haddad Sofiene" 10 "Hend Azizi" 11 "Imen Balti" 12 "Khemissi Emna" 13 "Maroua Mezni" 14 "Marwen Bechini" 15 "Mohamed Ilyes Amiri" 16 "Nawres Rhimi" 17 "Nawres Saidi" 18 "Ouji Imen" 19 "Ouji Mariem" 20 "Rim Bchini" 21 "Salsabil Kouki" 22 "Sana Jemai" 23 "Soumaya Abidi" 24 "Tarek Belaidi" 25 "Tissaoui Khira" 26 "Tissaoui Takwa" 27 "Zaieneb Bechini" 28 "Zied guesmi"
	label values conf_enum conf_enum

	label variable conf_date "When have you been visited ?"
	note conf_date: "When have you been visited ?"

	label variable conf_consent "Did the enumerator ask for your consent ?"
	note conf_consent: "Did the enumerator ask for your consent ?"
	label define conf_consent 1 "Yes" 0 "No"
	label values conf_consent conf_consent

	label variable conf_attitude "Did you feel that the enumerator was respectful with you and your family member "
	note conf_attitude: "Did you feel that the enumerator was respectful with you and your family member ?"
	label define conf_attitude 1 "Yes" 0 "No"
	label values conf_attitude conf_attitude

	label variable covid_protocal1 "Did the enumerators follow covid protocols like social distancing, wearing a mas"
	note covid_protocal1: "Did the enumerators follow covid protocols like social distancing, wearing a mask etc?"
	label define covid_protocal1 1 "Yes" 0 "No"
	label values covid_protocal1 covid_protocal1

	label variable covid_protocal2 "Did you feel anxious during the interview?"
	note covid_protocal2: "Did you feel anxious during the interview?"
	label define covid_protocal2 1 "Yes" 0 "No"
	label values covid_protocal2 covid_protocal2

	label variable b1_introt "How many people (household members), including yourself, live in your household?"
	note b1_introt: "How many people (household members), including yourself, live in your household?"

	label variable b1_men "B1.1 How many men (adults and children) live in your household?"
	note b1_men: "B1.1 How many men (adults and children) live in your household?"

	label variable b1_women "B1.1 How many women (adults and children) live in your household?"
	note b1_women: "B1.1 How many women (adults and children) live in your household?"

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

	label variable c1_activsearchwork_6m "Have you actively searched for paid work in the last 6 months?"
	note c1_activsearchwork_6m: "Have you actively searched for paid work in the last 6 months?"
	label define c1_activsearchwork_6m 1 "Yes" 0 "No"
	label values c1_activsearchwork_6m c1_activsearchwork_6m

	label variable c1_activsearchwork_12m "Have you actively searched for paid work in the last 12 months?"
	note c1_activsearchwork_12m: "Have you actively searched for paid work in the last 12 months?"
	label define c1_activsearchwork_12m 1 "Yes" 0 "No"
	label values c1_activsearchwork_12m c1_activsearchwork_12m

	label variable c1_activsearchworkn_6m "Why haven’t you looked for a job in the last 6 month?"
	note c1_activsearchworkn_6m: "Why haven’t you looked for a job in the last 6 month?"
	label define c1_activsearchworkn_6m 1 "1. Still in school or training" 2 "2. Lack of better job opportunity" 3 "3. Maladie ou handicap" 4 "4. Pas besoin de travailler" 5 "5. Occupation du ménage" 6 "6. COVID 19" 99 "Autre"
	label values c1_activsearchworkn_6m c1_activsearchworkn_6m

	label variable c1_activsearchworkn_12m "Why haven’t you looked for a job in the last 12 months?"
	note c1_activsearchworkn_12m: "Why haven’t you looked for a job in the last 12 months?"
	label define c1_activsearchworkn_12m 1 "1. Still in school or training" 2 "2. Lack of better job opportunity" 3 "3. Maladie ou handicap" 4 "4. Pas besoin de travailler" 5 "5. Occupation du ménage" 6 "6. COVID 19" 99 "Autre"
	label values c1_activsearchworkn_12m c1_activsearchworkn_12m

	label variable c1_hengag "C.1.36. Does you or anyone in your household have an agricultural or livestock a"
	note c1_hengag: "C.1.36. Does you or anyone in your household have an agricultural or livestock activity ?"
	label define c1_hengag 1 "Yes" 0 "No"
	label values c1_hengag c1_hengag

	label variable c1_hengag_agr "Is it an agricultural activity ?"
	note c1_hengag_agr: "Is it an agricultural activity ?"
	label define c1_hengag_agr 1 "Yes" 0 "No"
	label values c1_hengag_agr c1_hengag_agr

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

	label variable c4_parentfrids "C.4.4. Today, do you have friends / family working in another city / gouvernorat"
	note c4_parentfrids: "C.4.4. Today, do you have friends / family working in another city / gouvernorat / country ?"
	label define c4_parentfrids 1 "Yes" 0 "No"
	label values c4_parentfrids c4_parentfrids

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

	label variable i2_taxes1 "Did you receive the small token of 10 Dinars for completing the survey??"
	note i2_taxes1: "Did you receive the small token of 10 Dinars for completing the survey??"
	label define i2_taxes1 1 "Yes" 0 "No"
	label values i2_taxes1 i2_taxes1

	label variable i2_taxes2 "Did you choose to pay any tax contribution/donate any amount from the 10 Dinars?"
	note i2_taxes2: "Did you choose to pay any tax contribution/donate any amount from the 10 Dinars?"
	label define i2_taxes2 1 "Yes" 0 "No"
	label values i2_taxes2 i2_taxes2

	label variable i2_taxes3 "How many dinars did you contribute?"
	note i2_taxes3: "How many dinars did you contribute?"

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
*   Corrections file path and filename:  DIME_Tunisia_Backcheck_corrections.csv
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
		
		* format date and date/time fields (taking account of possible wildcards for repeat groups)
		forvalues i = 1/100 {
			if "`datetime_fields`i''" ~= "" {
				foreach dtvar in `datetime_fields`i'' {
					* skip fields that aren't yet in the data
					cap unab dtvarignore : `dtvar'
					if _rc==0 {
						gen origvalue=value
						replace value=string(clock(value,"MDYhms",2025),"%25.0g") if strmatch(fieldname,"`dtvar'")
						* allow for cases where seconds haven't been specified
						replace value=string(clock(origvalue,"MDYhm",2025),"%25.0g") if strmatch(fieldname,"`dtvar'") & value=="." & origvalue~="."
						drop origvalue
					}
				}
			}
			if "`date_fields`i''" ~= "" {
				foreach dtvar in `date_fields`i'' {
					* skip fields that aren't yet in the data
					cap unab dtvarignore : `dtvar'
					if _rc==0 {
						replace value=string(clock(value,"MDY",2025),"%25.0g") if strmatch(fieldname,"`dtvar'")
					}
				}
			}
		}

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
