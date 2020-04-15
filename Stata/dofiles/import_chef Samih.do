* import_chef.do
*
* 	Imports and aggregates "enquete_chef_arabic" (ID: chef) data.
*
*	Inputs: .csv file(s) exported by the SurveyCTO Sync
*	Outputs: "/Users/heyuprettything/Dropbox/Tunisia/do/enquete_chef_arabic.dta"
*
*	Output by the SurveyCTO Sync October 21, 2016 2:33 PM.

* initialize Stata
clear all
set more off
set mem 100m

* initialize form-specific parameters
local csvfile "$raw/enquete_chef_arabic.csv"
local dtafile "$stata/enquete_chef_arabic.dta"
local corrfile "$raw/enquete_chef_arabic_corrections.csv"
local repeat_groups_csv1 "vie_eco-arrangement_repeat infra_trans-infra_repeat devt_aide-C_PHD"
local repeat_groups_stata1 "arrangement_repeat infra_repeat c_phd"
local repeat_groups_short_stata1 "arrangement_repeat infra_repeat c_phd"
local note_fields1 "generated_note_name_12 generated_note_name_28 generated_note_name_34 generated_note_name_37 arrangement_repeat_count infra_repeat_count generated_note_name_85 projets_human"
local text_fields1 "deviceid subscriberid simserial phonenumber repondant_o repondant_name q0_6 thimo_o q1_1 q1_2 q1_3 q1_4 q1_5 q1_6 q2_8 q2_9 q2_9_o arrangement_id* arrangement_name* q2_14 q2_14_o q2_16 q2_16_o q3_0"
local text_fields2 "infra_id* infra_name* q5_2* q5_3*"
local date_fields1 "q5_4* q5_5*"
local datetime_fields1 "submissiondate cq10_debut cq10_fin"

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
	* merge in any data from repeat groups (which get saved into additional .csv files)
	forvalues i = 1/100 {
		if "`repeat_groups_csv`i''" ~= "" {
			foreach repeatgroup in `repeat_groups_csv`i'' {
				* save primary data in memory
				preserve
				
				* load data for repeat group
				insheet using "$raw/enquete_chef_arabic-`repeatgroup'.csv", names clear

				* drop extra table-list columns
				cap drop reserved_name_for_field_*
				cap drop generated_table_list_lab*
		
				* drop extra repeat-group fields
				forvalues j = 1/100 {
					if "`repeat_groups_short_stata`j''" ~= "" {
						foreach innergroup in `repeat_groups_short_stata`j'' {
							cap drop setof`innergroup'
						}
					}
				}
					
				* if there's data in the group, sort and reshape it
				if _N>0 {
					* sort, number, and prepare for merge
					sort parent_key, stable
					by parent_key: gen rownum=_n
					drop key
					rename parent_key key
					sort key rownum
			
					* reshape the data
					ds key rownum, not
					local allvars "`r(varlist)'"
					reshape wide `allvars', i(key) j(rownum)
				}
				else {
					* otherwise, just fix the key to be a string for merging in the fields
					tostring key, replace
				}
				
				* save to temporary file
				tempfile rgfile
				save "`rgfile'", replace
						
				* restore primary data		
				restore
				
				* merge in repeat-group data
				merge 1:1 key using "`rgfile'", nogen
			}
		}
	}
	
	* drop extra repeat-group fields (if any)
	forvalues j = 1/100 {
		if "`repeat_groups_stata`j''" ~= "" {
			foreach repeatgroup in `repeat_groups_stata`j'' {
				drop setof`repeatgroup'
			}
		}
	}
	
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
				foreach dtvar of varlist `dtvarlist' {
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
		if "`date_fields`i''" ~= "" {
			foreach dtvarlist in `date_fields`i'' {
				foreach dtvar of varlist `dtvarlist' {
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

	* ensure that text fields are always imported as strings (with "" for missing values)
	* (note that we treat "calculate" fields as text; you can destring later if you wish)
	tempvar ismissingvar
	quietly: gen `ismissingvar'=.
	forvalues i = 1/100 {
		if "`text_fields`i''" ~= "" {
			foreach svarlist in `text_fields`i'' {
				foreach stringvar of varlist `svarlist' {
					quietly: replace `ismissingvar'=.
					quietly: cap replace `ismissingvar'=1 if `stringvar'==.
					cap tostring `stringvar', format(%100.0g) replace
					cap replace `stringvar'="" if `ismissingvar'==1
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


	label variable superviseur "Veuillez sélectionner le nom du superviseur."
	note superviseur: "Veuillez sélectionner le nom du superviseur."
	label define superviseur 1 "1 (Abd elhamid barka)" 2 "2 (Aymen Nasraoui)" 3 "3 (Fatah Mezni)" 4 "4 (Ibrahim Nakoussi)" 5 "5 (Khaled gharbi)" 6 "6 (Mohamed Boufath)" 7 "7 (Saber Tlili)"
	label values superviseur superviseur

	label variable imada "Sélectionnez le nom de l'imada"
	note imada: "Sélectionnez le nom de l'imada"
	label define imada 1 "Abd jabar" 2 "Ain Draham Banlieus" 3 "Ain Krima" 4 "Ain Lbaya" 5 "Ain Salem" 6 "Ain Snoussi" 7 "Ain sobh" 8 "Ain Soltan" 9 "Al-itha" 10 "Assila" 11 "Atatfa" 12 "Azima" 13 "Balta" 14 "Bellarigia" 15 "Ben bachir" 16 "Bni Mhimid" 17 "Bni mtir" 18 "Bouawen" 19 "Bouhertma" 20 "Boulaaba" 21 "Chemtou" 22 "Chwewla" 23 "Dkhaylia" 24 "Edir" 25 "Edoura" 26 "El Brahmi" 27 "El Hamem" 28 "El koudia" 29 "El Malgua" 30 "El Mrassen" 31 "Elaadher" 32 "Elbir Lakhdher" 33 "Elkhadhra" 34 "Ennadhour" 35 "Erwaii" 36 "Esraya" 37 "Faj Hssine" 38 "Fargsan" 39 "Ferdaws" 40 "Fernana" 41 "Galaa" 42 "Ghardima Nord" 43 "Ghzala" 44 "Gloub Thiren Nord" 45 "Gloub Thiren Sud" 46 "Gwaidia" 47 "Hamdia" 48 "Hdhil" 49 "Hkim Sud" 50 "Hlima" 51 "Homran" 52 "Jwewda" 53 "khmayria" 54 "Laawawdha" 55 "Lbaldia" 56 "Maloula" 57 "Manguouch" 58 "Marja" 59 "Oued ezzen" 60 "Oued kasseb" 61 "Oued Mliz Ouest" 62 "Ouled sedra" 63 "Rakha" 64 "Rbiaa" 65 "Rihan" 66 "Satfoura" 67 "Sidi Abid" 68 "Sidi Amar" 69 "Sloul" 70 "Somran" 71 "Souk Jemaa" 72 "Souk Sebt" 73 "Swani" 74 "Tabarka" 75 "Tbaynia" 76 "Tegma" 77 "Wechtata" 78 "Wed Elmaaden" 79 "Wed Ghrib" 80 "Wled Mfada"
	label values imada imada

	label variable repondant "Sélectionnez le type de répondant"
	note repondant: "Sélectionnez le type de répondant"
	label define repondant 1 "OMDA" 2 "Autre"
	label values repondant repondant

	label variable repondant_o "Précisez le type de répondant"
	note repondant_o: "Précisez le type de répondant"

	label variable repondant_name "Quel est le nom du répondant?"
	note repondant_name: "Quel est le nom du répondant?"

	label variable q0_1 "Ya-t-il des rivières ou lacs qui traverse ce IMADA ?"
	note q0_1: "Ya-t-il des rivières ou lacs qui traverse ce IMADA ?"
	label define q0_1 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas"
	label values q0_1 q0_1

	label variable q0_2 "Ya-t-il une partie de cet IMADA couverte d’une forêt?"
	note q0_2: "Ya-t-il une partie de cet IMADA couverte d’une forêt?"
	label define q0_2 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas"
	label values q0_2 q0_2

	label variable q0_3 "Avez-vous des montagnes et collines dans ce IMADA ?"
	note q0_3: "Avez-vous des montagnes et collines dans ce IMADA ?"
	label define q0_3 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas"
	label values q0_3 q0_3

	label variable q0_5 "Cet imada a-t-elle bénéficié d'un projet de type THIMO/TCPL/Travail communautair"
	note q0_5: "Cet imada a-t-elle bénéficié d'un projet de type THIMO/TCPL/Travail communautaire avec associations?"
	label define q0_5 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas"
	label values q0_5 q0_5

	label variable q0_6 "De quel type?"
	note q0_6: "De quel type?"

	label variable thimo_o "Vous avez coché autre, précisez"
	note thimo_o: "Vous avez coché autre, précisez"

	label variable q1_1 "Je vais énumérer un certain nombre des problèmes que les gens rencontrent parfoi"
	note q1_1: "Je vais énumérer un certain nombre des problèmes que les gens rencontrent parfois. Veuillez me dire si votre imada a connu ce problème dans les six derniers mois."

	label variable q1_2 "Au cours l’année passée, avez-vous personnellement…"
	note q1_2: "Au cours l’année passée, avez-vous personnellement…"

	label variable q1_3 "S'il vous plaît décrire les événements négatifs importants qui ont eu lieu dans "
	note q1_3: "S'il vous plaît décrire les événements négatifs importants qui ont eu lieu dans cette communauté depuis [CINQ ANS], y compris tous les événements négatifs qui ont eu lieu cette année. Nous sommes particulièrement intéressés par les événements qui ont changé le bien-être des personnes dans cette communauté pour le meilleur ou pour le pire."

	label variable q1_4 "S'il vous plaît décrire les événements positifs importants qui ont eu lieu dans "
	note q1_4: "S'il vous plaît décrire les événements positifs importants qui ont eu lieu dans cette communauté depuis [CINQ ANS], y compris tous les événements positifs qui ont eu lieu cette année. Nous sommes particulièrement intéressés par les événements qui ont changé le bien-être des personnes dans cette communauté pour le meilleur ou pour le pire."

	label variable q1_5 "Dans les 12 derniers mois, des ménages de votre IMADA ont-ils vécus les évènemen"
	note q1_5: "Dans les 12 derniers mois, des ménages de votre IMADA ont-ils vécus les évènements suivants…? CHOISIR TOUT CE QUI EST APPLICABLE.]"

	label variable q1_6 "Que ce que la plus part de ces ménages ont fait pour subvenir a leur besoins? [N"
	note q1_6: "Que ce que la plus part de ces ménages ont fait pour subvenir a leur besoins? [NE LISEZ PAS LES ASSERTIONS, MAIS CHOISISSEZ TOUT CE QUI EST APPLICABLE.]"

	label variable q2_1 "Agriculture"
	note q2_1: "Agriculture"

	label variable q2_2 "Pêche"
	note q2_2: "Pêche"

	label variable q2_3 "Ferme / Elevage"
	note q2_3: "Ferme / Elevage"

	label variable q2_4 "Industrie (usine ou manufacture)"
	note q2_4: "Industrie (usine ou manufacture)"

	label variable q2_5 "Commerce (pour les produits manufacturés /industriels seulement)"
	note q2_5: "Commerce (pour les produits manufacturés /industriels seulement)"

	label variable q2_6 "Autres services (par ex, bâtiment, enseignement)"
	note q2_6: "Autres services (par ex, bâtiment, enseignement)"

	label variable q2_7 "Autre"
	note q2_7: "Autre"

	label variable q2_8 "Pouvez-vous nous dire les produits agricoles qui sont produit dans ce IMADA?"
	note q2_8: "Pouvez-vous nous dire les produits agricoles qui sont produit dans ce IMADA?"

	label variable q2_9 "Je voudrais vous poser des questions sur la façon dont la terre est utilisée dan"
	note q2_9: "Je voudrais vous poser des questions sur la façon dont la terre est utilisée dans le village et comment les ménages acquièrent l'accès ou des droits à la terre. Les ménages dans ce village :"

	label variable q2_9_o "Vous avez coché 'Autre', veuillez spécifier."
	note q2_9_o: "Vous avez coché 'Autre', veuillez spécifier."

	label variable q2_13 "Y at-il une augmentation de la population saisonnière (pendant les vacances, réc"
	note q2_13: "Y at-il une augmentation de la population saisonnière (pendant les vacances, récolte, etc.) au cours des 2 dernières années?"
	label define q2_13 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas"
	label values q2_13 q2_13

	label variable q2_14 "Quelles sont les 2 raisons principales de l'augmentation saisonnière? [selection"
	note q2_14: "Quelles sont les 2 raisons principales de l'augmentation saisonnière? [selectionner 2 MAX]"

	label variable q2_14_o "Précisez"
	note q2_14_o: "Précisez"

	label variable q2_15 "Y a t-il diminution de la population saisonnière?"
	note q2_15: "Y a t-il diminution de la population saisonnière?"
	label define q2_15 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas"
	label values q2_15 q2_15

	label variable q2_16 "Quelles sont les raisons de cette diminution?"
	note q2_16: "Quelles sont les raisons de cette diminution?"

	label variable q2_16_o "Précisez"
	note q2_16_o: "Précisez"

	label variable q3_0 "Nous souhaiterions vous poser des questions sur la qualité et la disponibilité d"
	note q3_0: "Nous souhaiterions vous poser des questions sur la qualité et la disponibilité des infrastructures collectives ainsi que l’accessibilité des habitants de la IMADA aux infrastructures suivantes (sélectionnez les infrastructures présentes dans l'Imada):"

	label variable q4_1 "L'accès au transport"
	note q4_1: "L'accès au transport"
	label define q4_1 1 "Vraiment pire" 2 "Pire" 3 "Pareil" 4 "Mieux" 5 "Beaucoup mieux" 6 "Pas applicable"
	label values q4_1 q4_1

	label variable q4_2 "Communication avec les autres en dehors de la communauté"
	note q4_2: "Communication avec les autres en dehors de la communauté"
	label define q4_2 1 "Vraiment pire" 2 "Pire" 3 "Pareil" 4 "Mieux" 5 "Beaucoup mieux" 6 "Pas applicable"
	label values q4_2 q4_2

	label variable q4_3 "Disponibilité des produits manufacturés commerciaux"
	note q4_3: "Disponibilité des produits manufacturés commerciaux"
	label define q4_3 1 "Vraiment pire" 2 "Pire" 3 "Pareil" 4 "Mieux" 5 "Beaucoup mieux" 6 "Pas applicable"
	label values q4_3 q4_3

	label variable q4_4 "Disponibilité de vêtements"
	note q4_4: "Disponibilité de vêtements"
	label define q4_4 1 "Vraiment pire" 2 "Pire" 3 "Pareil" 4 "Mieux" 5 "Beaucoup mieux" 6 "Pas applicable"
	label values q4_4 q4_4

	label variable q4_5 "La disponibilité de l'eau potable"
	note q4_5: "La disponibilité de l'eau potable"
	label define q4_5 1 "Vraiment pire" 2 "Pire" 3 "Pareil" 4 "Mieux" 5 "Beaucoup mieux" 6 "Pas applicable"
	label values q4_5 q4_5

	label variable q4_6 "Utilisation d'installations sanitaires améliorées"
	note q4_6: "Utilisation d'installations sanitaires améliorées"
	label define q4_6 1 "Vraiment pire" 2 "Pire" 3 "Pareil" 4 "Mieux" 5 "Beaucoup mieux" 6 "Pas applicable"
	label values q4_6 q4_6

	label variable q4_7 "Disponibilité de l'électricité"
	note q4_7: "Disponibilité de l'électricité"
	label define q4_7 1 "Vraiment pire" 2 "Pire" 3 "Pareil" 4 "Mieux" 5 "Beaucoup mieux" 6 "Pas applicable"
	label values q4_7 q4_7

	label variable q4_8 "Disponibilité de bois de chauffage"
	note q4_8: "Disponibilité de bois de chauffage"
	label define q4_8 1 "Vraiment pire" 2 "Pire" 3 "Pareil" 4 "Mieux" 5 "Beaucoup mieux" 6 "Pas applicable"
	label values q4_8 q4_8

	label variable q4_9 "Disponibilité de charbon de bois"
	note q4_9: "Disponibilité de charbon de bois"
	label define q4_9 1 "Vraiment pire" 2 "Pire" 3 "Pareil" 4 "Mieux" 5 "Beaucoup mieux" 6 "Pas applicable"
	label values q4_9 q4_9

	label variable q4_10 "Disponibilité des aliments de base sur le marché"
	note q4_10: "Disponibilité des aliments de base sur le marché"
	label define q4_10 1 "Vraiment pire" 2 "Pire" 3 "Pareil" 4 "Mieux" 5 "Beaucoup mieux" 6 "Pas applicable"
	label values q4_10 q4_10

	label variable q4_11 "L'état nutritionnel des jeunes enfants"
	note q4_11: "L'état nutritionnel des jeunes enfants"
	label define q4_11 1 "Vraiment pire" 2 "Pire" 3 "Pareil" 4 "Mieux" 5 "Beaucoup mieux" 6 "Pas applicable"
	label values q4_11 q4_11

	label variable q4_12 "Disponibilité des vaccinations pour les enfants"
	note q4_12: "Disponibilité des vaccinations pour les enfants"
	label define q4_12 1 "Vraiment pire" 2 "Pire" 3 "Pareil" 4 "Mieux" 5 "Beaucoup mieux" 6 "Pas applicable"
	label values q4_12 q4_12

	label variable q4_13 "Disponibilité des soins de santé"
	note q4_13: "Disponibilité des soins de santé"
	label define q4_13 1 "Vraiment pire" 2 "Pire" 3 "Pareil" 4 "Mieux" 5 "Beaucoup mieux" 6 "Pas applicable"
	label values q4_13 q4_13

	label variable q4_14 "Disponibilité des soins pour les femmes enceintes"
	note q4_14: "Disponibilité des soins pour les femmes enceintes"
	label define q4_14 1 "Vraiment pire" 2 "Pire" 3 "Pareil" 4 "Mieux" 5 "Beaucoup mieux" 6 "Pas applicable"
	label values q4_14 q4_14

	label variable q4_15 "Incidence des maladies chroniques"
	note q4_15: "Incidence des maladies chroniques"
	label define q4_15 1 "Vraiment pire" 2 "Pire" 3 "Pareil" 4 "Mieux" 5 "Beaucoup mieux" 6 "Pas applicable"
	label values q4_15 q4_15

	label variable q4_16 "Connaissances à éviter l'infection à VIH"
	note q4_16: "Connaissances à éviter l'infection à VIH"
	label define q4_16 1 "Vraiment pire" 2 "Pire" 3 "Pareil" 4 "Mieux" 5 "Beaucoup mieux" 6 "Pas applicable"
	label values q4_16 q4_16

	label variable q4_17 "Connaissances sur la diarrhée et ses traitements traitement"
	note q4_17: "Connaissances sur la diarrhée et ses traitements traitement"
	label define q4_17 1 "Vraiment pire" 2 "Pire" 3 "Pareil" 4 "Mieux" 5 "Beaucoup mieux" 6 "Pas applicable"
	label values q4_17 q4_17

	label variable q4_18 "Connaissances sur la tuberculose et ses traitements"
	note q4_18: "Connaissances sur la tuberculose et ses traitements"
	label define q4_18 1 "Vraiment pire" 2 "Pire" 3 "Pareil" 4 "Mieux" 5 "Beaucoup mieux" 6 "Pas applicable"
	label values q4_18 q4_18

	label variable q4_19 "L'accès aux services de planification familiale"
	note q4_19: "L'accès aux services de planification familiale"
	label define q4_19 1 "Vraiment pire" 2 "Pire" 3 "Pareil" 4 "Mieux" 5 "Beaucoup mieux" 6 "Pas applicable"
	label values q4_19 q4_19

	label variable q4_20 "les niveaux d'alphabétisation des adultes"
	note q4_20: "les niveaux d'alphabétisation des adultes"
	label define q4_20 1 "Vraiment pire" 2 "Pire" 3 "Pareil" 4 "Mieux" 5 "Beaucoup mieux" 6 "Pas applicable"
	label values q4_20 q4_20

	label variable q4_21 "Qualité de l'enseignement primaire"
	note q4_21: "Qualité de l'enseignement primaire"
	label define q4_21 1 "Vraiment pire" 2 "Pire" 3 "Pareil" 4 "Mieux" 5 "Beaucoup mieux" 6 "Pas applicable"
	label values q4_21 q4_21

	label variable q4_22 "Qualité de l'enseignement secondaire"
	note q4_22: "Qualité de l'enseignement secondaire"
	label define q4_22 1 "Vraiment pire" 2 "Pire" 3 "Pareil" 4 "Mieux" 5 "Beaucoup mieux" 6 "Pas applicable"
	label values q4_22 q4_22

	label variable q4_23 "L'accès au crédit non agricole des entreprises"
	note q4_23: "L'accès au crédit non agricole des entreprises"
	label define q4_23 1 "Vraiment pire" 2 "Pire" 3 "Pareil" 4 "Mieux" 5 "Beaucoup mieux" 6 "Pas applicable"
	label values q4_23 q4_23

	label variable q4_24 "Opportunités d'emploi"
	note q4_24: "Opportunités d'emploi"
	label define q4_24 1 "Vraiment pire" 2 "Pire" 3 "Pareil" 4 "Mieux" 5 "Beaucoup mieux" 6 "Pas applicable"
	label values q4_24 q4_24

	label variable q4_25 "Les services de police"
	note q4_25: "Les services de police"
	label define q4_25 1 "Vraiment pire" 2 "Pire" 3 "Pareil" 4 "Mieux" 5 "Beaucoup mieux" 6 "Pas applicable"
	label values q4_25 q4_25

	label variable q4_26 "Vol"
	note q4_26: "Vol"
	label define q4_26 1 "Vraiment pire" 2 "Pire" 3 "Pareil" 4 "Mieux" 5 "Beaucoup mieux" 6 "Pas applicable"
	label values q4_26 q4_26

	label variable q4_27 "La violence"
	note q4_27: "La violence"
	label define q4_27 1 "Vraiment pire" 2 "Pire" 3 "Pareil" 4 "Mieux" 5 "Beaucoup mieux" 6 "Pas applicable"
	label values q4_27 q4_27

	label variable q4_28 "Niveau de confiance dans la communauté"
	note q4_28: "Niveau de confiance dans la communauté"
	label define q4_28 1 "Vraiment pire" 2 "Pire" 3 "Pareil" 4 "Mieux" 5 "Beaucoup mieux" 6 "Pas applicable"
	label values q4_28 q4_28

	label variable q4_29 "Volonté des membres de la communauté pour aider les uns les autres"
	note q4_29: "Volonté des membres de la communauté pour aider les uns les autres"
	label define q4_29 1 "Vraiment pire" 2 "Pire" 3 "Pareil" 4 "Mieux" 5 "Beaucoup mieux" 6 "Pas applicable"
	label values q4_29 q4_29

	label variable q4_30 "Volonté des membres de la communauté à verser des contributions en espèces aux p"
	note q4_30: "Volonté des membres de la communauté à verser des contributions en espèces aux projets communautaires"
	label define q4_30 1 "Vraiment pire" 2 "Pire" 3 "Pareil" 4 "Mieux" 5 "Beaucoup mieux" 6 "Pas applicable"
	label values q4_30 q4_30

	label variable q4_31 "La participation des membres de la communauté dans les activités communautaires"
	note q4_31: "La participation des membres de la communauté dans les activités communautaires"
	label define q4_31 1 "Vraiment pire" 2 "Pire" 3 "Pareil" 4 "Mieux" 5 "Beaucoup mieux" 6 "Pas applicable"
	label values q4_31 q4_31

	label variable q4_32 "Niveau de pauvreté dans la communauté"
	note q4_32: "Niveau de pauvreté dans la communauté"
	label define q4_32 1 "Vraiment pire" 2 "Pire" 3 "Pareil" 4 "Mieux" 5 "Beaucoup mieux" 6 "Pas applicable"
	label values q4_32 q4_32

	label variable q4_33 "Niveau de l'inégalité dans la communauté"
	note q4_33: "Niveau de l'inégalité dans la communauté"
	label define q4_33 1 "Vraiment pire" 2 "Pire" 3 "Pareil" 4 "Mieux" 5 "Beaucoup mieux" 6 "Pas applicable"
	label values q4_33 q4_33

	label variable q4_34 "manifestations ou d'émeutes violentes"
	note q4_34: "manifestations ou d'émeutes violentes"
	label define q4_34 1 "Vraiment pire" 2 "Pire" 3 "Pareil" 4 "Mieux" 5 "Beaucoup mieux" 6 "Pas applicable"
	label values q4_34 q4_34

	label variable q4_35 "Des manifestations pacifiques"
	note q4_35: "Des manifestations pacifiques"
	label define q4_35 1 "Vraiment pire" 2 "Pire" 3 "Pareil" 4 "Mieux" 5 "Beaucoup mieux" 6 "Pas applicable"
	label values q4_35 q4_35



	capture {
		foreach rgvar of varlist q2_10* {
			label variable `rgvar' "Le nombre de ménages dans le village qui ont l'arrangement foncier '\${arrangement_name}'"
			note `rgvar': "Le nombre de ménages dans le village qui ont l'arrangement foncier '\${arrangement_name}'?"
			label define `rgvar' 1 "Plus de la moitié des ménages" 2 "La moitié des ménages" 3 "Moins de la moitié des ménages" 4 "Cette disposition ne ne pas exister"
			label values `rgvar' `rgvar'
		}
	}

	capture {
		foreach rgvar of varlist q2_11* {
			label variable `rgvar' "L'arrangement foncier '\${arrangement_name}' bénéficie-t-il également aux femmes"
			note `rgvar': "L'arrangement foncier '\${arrangement_name}' bénéficie-t-il également aux femmes?"
			label define `rgvar' 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas"
			label values `rgvar' `rgvar'
		}
	}

	capture {
		foreach rgvar of varlist q2_12* {
			label variable `rgvar' "Combien ça coûte pour obtenir un hectare de terrain avec l'arrengement foncier '"
			note `rgvar': "Combien ça coûte pour obtenir un hectare de terrain avec l'arrengement foncier '\${arrangement_name}'?"
		}
	}

	capture {
		foreach rgvar of varlist q3_1* {
			label variable `rgvar' "Indiquer la qualité de l'infrastructure \${infra_name}! [des moins satisfaisants"
			note `rgvar': "Indiquer la qualité de l'infrastructure \${infra_name}! [des moins satisfaisants 1 au plus satisfaisants 5 ]"
			label define `rgvar' 1 "1" 2 "2" 3 "3" 4 "4" 5 "5"
			label values `rgvar' `rgvar'
		}
	}

	capture {
		foreach rgvar of varlist q3_2* {
			label variable `rgvar' "A quelle distance se situe l'infrastructure \${infra_name} la plus proche à part"
			note `rgvar': "A quelle distance se situe l'infrastructure \${infra_name} la plus proche à partir du centre de cet IMADA ? [ SI MOINS DE 1 KM, UTILISER LES DECIMAUX]"
		}
	}

	capture {
		foreach rgvar of varlist q3_3* {
			label variable `rgvar' "Quel est le moyen de transport le plus fréquemment utilise pour atteindre/visite"
			note `rgvar': "Quel est le moyen de transport le plus fréquemment utilise pour atteindre/visiter l'infrastructure \${infra_name}?"
			label define `rgvar' 1 "MARCHE A PIED" 2 "MULET/CHEVAL" 3 "VELO" 4 "VEHICULE/MOTOCYCLETTE" 5 "BUS/MINI-BUS" 6 "TAXI" 7 "VOITURE PRIVEE" 8 "AUTRE (SPECIFIER)"
			label values `rgvar' `rgvar'
		}
	}

	capture {
		foreach rgvar of varlist q3_4* {
			label variable `rgvar' "Combien coute (un trajet) pour rejoindre l'infrastructure \${infra_name} par ce "
			note `rgvar': "Combien coute (un trajet) pour rejoindre l'infrastructure \${infra_name} par ce moyen de transport le plus fréquemment utilisé?"
		}
	}

	capture {
		foreach rgvar of varlist q3_5* {
			label variable `rgvar' "Combien de temps prend (un trajet) pour rejoindre l'infrastructure \${infra_name"
			note `rgvar': "Combien de temps prend (un trajet) pour rejoindre l'infrastructure \${infra_name} par ce moyen de transport le plus fréquemment utilisé? [en minutes]"
		}
	}

	capture {
		foreach rgvar of varlist q5_1* {
			label variable `rgvar' "Nom de l'organisation"
			note `rgvar': "Nom de l'organisation"
			label define `rgvar' 1 "ONU" 2 "PNUD" 3 "IRC" 4 "CARE" 5 "CONCERN" 6 "MONUC/MONUSCO" 7 "Croix-rouge" 8 "Medecin sans frontière" 9 "ACTED" 10 "Action contre la faim" 0 "Aucune" 11 "UNICEF" 12 "COOPI" 13 "HCR" 14 "COOPERA" 15 "Malteser" 16 "Oxfam" 17 "Rapid" 18 "KFC" 50 "Autre" -7 "refus de repondre" -8 "non applicable" -9 "ne sais pas"
			label values `rgvar' `rgvar'
		}
	}

	capture {
		foreach rgvar of varlist q5_2* {
			label variable `rgvar' "De quoi le projet s'occupe -t-il?"
			note `rgvar': "De quoi le projet s'occupe -t-il?"
		}
	}

	capture {
		foreach rgvar of varlist q5_3* {
			label variable `rgvar' "Nom du projet"
			note `rgvar': "Nom du projet"
		}
	}

	capture {
		foreach rgvar of varlist q5_4* {
			label variable `rgvar' "début des opérations(année)"
			note `rgvar': "début des opérations(année)"
		}
	}

	capture {
		foreach rgvar of varlist q5_5* {
			label variable `rgvar' "cloture des opérations(année)"
			note `rgvar': "cloture des opérations(année)"
		}
	}

	capture {
		foreach rgvar of varlist q5_6* {
			label variable `rgvar' "catégorie de projet"
			note `rgvar': "catégorie de projet"
			label define `rgvar' 1 "Puits (ou autre eau)" 2 "Drainages / Irrigation" 3 "Centre religieux (ou renovation)" 4 "Centre social (ou renovation)" 5 "Autre construction (ou renovation)" 6 "Systeme de Credit" 7 "Route" 8 "Elevage de chevres" 9 "Elevage de vaches" 10 "Elevage de poules/lapins/volaille" 11 "Autre Elevage" 12 "Distribution argent" 13 "Distribution semences de mais" 14 "Distribution outils de construction" 15 "Distribution materiel scolaire" 16 "Distribution medicaments" 17 "Distribution preventifs" 18 "Autre Distribution" 19 "Moulin (ou renovation)" 20 "Ecole (ou renovation)" 21 "Centre de Sante (ou renovation)" 22 "Latrines (ou renovation)" 23 "Distribution engrais" 24 "Distribution d'outils pour l'agriculture" 25 "Champ communautaire" 26 "Un Marche" 27 "Pisciculture" 28 "Projet prive pour sa famille ou lui" 29 "Fabrication de Briques" 30 "Charbon" 32 "Distribution semences arachides" 33 "Distribiution semences haricots" 34 "Distribution semences choux" 35 "Distribution semences tomates" 36 "Distribution semences soja" 37 "Distribution semences Gombo" 38 "Distribution semences Lengalenga" 39 "Distribution semences Ognons" 40 "Distribution semences Ail" 41 "Distribution semences Riz" 42 "Distribution semences (Autre)" 43 "Electricite" 44 "Formation" 45 "Riserie" 46 "Pont" 49 "Actions contre violences sexuelles" 50 "l'adduction/l'eau potable" 51 "Autre" -98 "refus de repondre" -99 "ne sais pas"
			label values `rgvar' `rgvar'
		}
	}

	capture {
		foreach rgvar of varlist q5_7* {
			label variable `rgvar' "Montant du projet [en TND]"
			note `rgvar': "Montant du projet [en TND]"
		}
	}

	capture {
		foreach rgvar of varlist q5_8* {
			label variable `rgvar' "Les habitants du IMADA se sont-ils réuni pour voter/ se prononcer sur ce Project"
			note `rgvar': "Les habitants du IMADA se sont-ils réuni pour voter/ se prononcer sur ce Project avant la mise en œuvre?"
			label define `rgvar' 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas"
			label values `rgvar' `rgvar'
		}
	}

	capture {
		foreach rgvar of varlist q5_9* {
			label variable `rgvar' "type bénéficiaire spécial"
			note `rgvar': "type bénéficiaire spécial"
			label define `rgvar' 1 "Administrateur du Territoire" 2 "Un comité de développement" 3 "Chef de Groupement" 4 "Chef de localité" 5 "Chef de sous-village" 6 "Chef de village" 7 "Chefs religieux" 8 "Les organisations des femmes" 9 "Les organisations des jeunes, les associations" 10 "Membres du comité de développement" 11 "Les habitants du village" 12 "ONGs" 13 "Secteur privé" 14 "Personnes déplacées immigrant vers le village" 15 "Personnes déplacées originaire du village" 16 "Membres des groupes armés" 17 "Le gouvernement" 18 "Les plus pauvres" 19 "Ex combatants" 20 "Un professeur/president de l’ecole" 21 "Un medecin / infirmiere" 22 "Police" 23 "Autre" -98 "Ne souhaite pas répondre" -99 "Ne sait pas"
			label values `rgvar' `rgvar'
		}
	}




	* append old, previously-imported data (if any)
	cap confirm file "`dtafile'"
	if _rc == 0 {
		* mark all new data before merging with old data
		gen new_data_row=1
		
		* pull in old data
		append using "`dtafile'"
		
		* drop duplicates in favor of old, previously-imported data
		sort key
		by key: gen num_for_key = _N
		drop if num_for_key > 1 & new_data_row == 1
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

* apply corrections (if any)
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
					gen origvalue=value
					replace value=string(clock(value,"DMYhms",2025),"%25.0g") if strmatch(fieldname,"`dtvar'")
					* allow for cases where seconds haven't been specified
					replace value=string(clock(origvalue,"DMYhm",2025),"%25.0g") if strmatch(fieldname,"`dtvar'") & value=="." & origvalue~="."
					drop origvalue
				}
			}
			if "`date_fields`i''" ~= "" {
				foreach dtvar in `date_fields`i'' {
					replace value=string(clock(value,"DMY",2025),"%25.0g") if strmatch(fieldname,"`dtvar'")
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
			file write dofile $stata/type_project_tab _tab `"disp"' _n
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
