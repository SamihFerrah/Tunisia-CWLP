	label variable key "Unique submission ID"
	cap label variable submissiondate "Date/time submitted"
	cap label variable formdef_version "Form version used on device"


	label variable enqueteur "Veuillez sélectionner votre numéro d'enquêteur."
	note enqueteur: "Veuillez sélectionner votre numéro d'enquêteur."
	label define enqueteur 1 "1 (Abd Elfattah Soltani)" 2 "2 (Abir Abidi)" 3 "3 (Achref Ghouinmi)" 4 "4 (Achref Khemaissia)" 5 "5 (Achref Khimiri)" 6 "6 (Ahmed Môtez Bousselmi)" 7 "7 (Atef Sedraoui)" 8 "8 (Azza Harzi)" 9 "9 (Belaïdi Meriem)" 10 "10 (Belaïdi Tarek)" 11 "11 (Bilel Belaidi)" 12 "12 (Cheheb Ediine Inoubli)" 13 "13 (Dalinda Medini)" 14 "14 (Fadi Zaibi)" 15 "15 (Ghazouani Nidham)" 16 "16 (Hajer Ochi)" 17 "17 (Haler Mersni)" 18 "18 (Imen Saîdi)" 19 "19 (Jaber Nasr)" 20 "20 (Lamia Khadraoui )" 21 "21 (Manel Kahlaoui)" 22 "22 (Mohamed Aymen Khemiri)" 23 "23 (Mohamed Ilyes Amiri)" 24 "24 (Mohamed Walid Zouaoui)" 25 "25 (Naîma Mezigui)" 26 "26 (Raja Hamdi)" 27 "27 (Ramzi Naghmouchi)" 28 "28 (Raouen Rjeibi)" 29 "29 (Saber Mersni)" 30 "30 (Saief Eddine Brinci)" 31 "31 (Sana Arfaji)" 32 "32 (Sana Jemaî)" 33 "33 (Souissi Emna)" 34 "34 (Wael Hermi)" 35 "35 (Wahid Boulehmi)" 36 "36 (Yassine Abidi)" 37 "37 (Zeîneb Harzi)" 38 "38 (Autre)", replace
	label values enqueteur enqueteur

	label variable superviseur "Veuillez sélectionner le nom du superviseur."
	note superviseur: "Veuillez sélectionner le nom du superviseur."
	label define superviseur 1 "1 (Abd elhamid barka)" 2 "2 (Aymen Nasraoui)" 3 "3 (Fatah Mezni)" 4 "4 (Ibrahim Nakoussi)" 5 "5 (Khaled gharbi)" 6 "6 (Mohamed Boufath)" 7 "7 (Riadh Marzouki)", replace
	label values superviseur superviseur

	label variable enquete "Comment cet(te) enquêté(e) a-t-il été choisi ?"
	note enquete: "Comment cet(te) enquêté(e) a-t-il été choisi ?"
	label define enquete 1 "Etude 1 'Recensement'" 2 "Etude 2 'Liste nominative'" 3 "Etude 3 'Les plus pauvres'", replace
	label values enquete enquete

	label variable lieu_entrevue "Sélectionnez le nom de l'imada"
	note lieu_entrevue: "Sélectionnez le nom de l'imada"
	label define lieu_entrevue 1 "Abd jabar" 2 "Ain Draham Banlieus" 3 "Ain Krima" 4 "Ain Lbaya" 5 "Ain Salem" 6 "Ain Snoussi" 7 "Ain sobh" 8 "Ain Soltan" 9 "Al-itha" 10 "Assila" 11 "Atatfa" 12 "Azima" 13 "Balta" 14 "Bellarigia" 15 "Ben bachir / Ezzouhour" 16 "Bni Mhimid" 17 "Bni mtir" 18 "Bouawen" 19 "Bouhertma" 20 "Boulaaba" 21 "Chemtou" 22 "Chwewla" 23 "Dkhaylia" 24 "Edir" 25 "Edoura" 26 "El Brahmi" 27 "El Hamem" 28 "El koudia" 29 "El Malgua" 30 "El Mrassen" 31 "Elaadher" 32 "Elbir Lakhdher" 33 "Elkhadhra" 34 "Ennadhour" 35 "Erwaii" 36 "Esraya" 37 "Faj Hssine" 38 "Fargsan" 39 "Ferdaws" 40 "Fernana" 41 "Galaa" 42 "Ghardima Nord" 43 "Ghzala" 44 "Gloub Thiren Nord" 45 "Gloub Thiren Sud" 46 "Gwaidia" 47 "Hamdia" 48 "Hdhil" 49 "Hkim Sud" 50 "Hlima" 51 "Homran" 52 "Jwewda" 53 "khmayria" 54 "Laawawdha" 55 "Lbaldia" 56 "Maloula" 57 "Manguouch" 58 "Marja" 59 "Oued ezzen" 60 "Oued kasseb" 61 "Oued Mliz Ouest" 62 "Ouled sedra" 63 "Rakha" 64 "Rbiaa" 65 "Rihan" 66 "Satfoura" 67 "Sidi Abid" 68 "Sidi Amar" 69 "Sloul" 70 "Somran" 71 "Souk Jemaa" 72 "Souk Sebt" 73 "Swani" 74 "Tabarka" 75 "Tbaynia" 76 "Tegma" 77 "Wechtata" 78 "Wed Elmaaden" 79 "Wed Ghrib" 80 "Wled Mfada", replace
	label values lieu_entrevue lieu_entrevue
	
	label variable psu "Sélectionnez le code PSU"
	note psu: "Sélectionnez le code PSU"
	label define psu 172 "220250" 173 "220257" 174 "220264" 166 "220302" 167 "220304" 168 "220306" 214 "220420" 215 "220422" 216 "220424" 160 "220434" 161 "220436" 162 "220438" 208 "220441" 209 "220447" 210 "220451" 211 "220457" 212 "220462" 213 "220467" 187 "220502" 188 "220504" 189 "220505" 202 "220508" 203 "220511" 204 "220514" 190 "220519" 191 "220524" 192 "220529" 184 "220534" 185 "220537" 186 "220540" 193 "220543" 194 "220546" 195 "220549" 205 "220553" 206 "220555" 207 "220557" 196 "220632" 197 "220635" 198 "220638" 181 "220665" 182 "220671" 183 "220677" 199 "220683" 200 "220686" 201 "220687" 178 "220702" 179 "220706" 180 "220710" 175 "220715" 176 "220720" 177 "220725" 169 "220731" 170 "220732" 171 "220735" 79 "220737" 80 "220740" 81 "220743" 76 "220747" 77 "220751" 78 "220755" 85 "220759" 86 "220763" 87 "220765" 70 "220859" 71 "220860" 72 "220862" 73 "220874" 74 "220878" 75 "220882" 82 "220887" 83 "220891" 84 "220895" 58 "220930" 59 "220933" 60 "220936" 52 "220939" 53 "220944" 40 "220955" 41 "220959" 42 "220963" 34 "220967" 35 "220969" 36 "220971" 67 "220975" 68 "220977" 69 "220979" 64 "221002" 65 "221005" 66 "221006" 61 "221009" 62 "221012" 63 "221015" 49 "221020" 50 "221022" 51 "221024" 46 "221028" 47 "221033" 48 "221038" 37 "221044" 38 "221048" 54 "221049" 39 "221052" 55 "221056" 56 "221059" 57 "221060" 43 "221063" 44 "221065" 45 "221067" 13 "221112" 14 "221114" 15 "221116" 4 "221119" 5 "221122" 6 "221125" 217 "221130" 218 "221132" 219 "221134" 28 "221137" 29 "221138" 30 "221139" 19 "221141" 8 "221143" 20 "221143" 21 "221145" 9 "221146" 16 "221147" 17 "221148" 18 "221149" 1 "221152" 2 "221155" 3 "221158" 31 "221163" 32 "221169" 33 "221173" 232 "221217" 233 "221221" 234 "221227" 220 "221234" 221 "221237" 222 "221240" 238 "221246" 239 "221254" 240 "221262" 224 "221276" 225 "221281" 229 "221360" 230 "221362" 231 "221364" 235 "221366" 236 "221367" 237 "221368" 226 "221370" 227 "221377" 228 "221384" 22 "221432" 23 "221434" 24 "221436" 7 "221440" 25 "221450" 26 "221456" 27 "221462" 10 "221468" 11 "221471" 12 "221474" 109 "221517" 110 "221518" 106 "221520" 107 "221525" 108 "221530" 111 "221536" 97 "221538" 98 "221541" 99 "221544" 112 "221547" 113 "221550" 114 "221553" 130 "221557" 131 "221560" 132 "221563" 118 "221567" 119 "221569" 120 "221571" 115 "221574" 116 "221578" 117 "221582" 88 "221602" 89 "221605" 90 "221608" 127 "221613" 128 "221615" 129 "221617" 91 "221622" 92 "221626" 93 "221630" 100 "221633" 101 "221636" 102 "221639" 94 "221642" 95 "221644" 96 "221646" 103 "221648" 104 "221652" 105 "221656" 124 "221661" 125 "221666" 126 "221671" 148 "221702" 149 "221709" 150 "221716" 121 "221723" 122 "221728" 123 "221733" 142 "221738" 143 "221742" 144 "221746" 136 "221752" 137 "221756" 138 "221760" 151 "221765" 152 "221768" 153 "221771" 223 "221771" 159 "221776" 154 "221811" 155 "221817" 156 "221823" 133 "221830" 134 "221836" 135 "221842" 163 "221850" 164 "221856" 165 "221862" 139 "221870" 140 "221875" 141 "221878" 145 "221902" 146 "221912" 147 "221922" 157 "221970" 158 "221973", replace
	label values psu psu

	label variable hh_id "Sélectionnez l'identifiant du ménage"
	note hh_id: "Sélectionnez l'identifiant du ménage"

	label variable hh_id_2 "Entrez à nouveau l'identifiant du ménage"
	note hh_id_2: "Entrez à nouveau l'identifiant du ménage"

	label variable date_v "La date d'aujourd'hui est bien \${date}?"
	note date_v: "La date d'aujourd'hui est bien \${date}?"
	label define date_v 1 "Oui" 0 "Non", replace
	label values date_v date_v

	label variable date_a "Quelle est la date d'aujourd'hui?"
	note date_a: "Quelle est la date d'aujourd'hui?"

	label variable time_v "L'heure est bien \${time}?"
	note time_v: "L'heure est bien \${time}?"
	label define time_v 1 "Oui" 0 "Non", replace
	label values time_v time_v

	label variable time_a "Quelle heure est-il?"
	note time_a: "Quelle heure est-il?"

	label variable gpslatitude "Veuillez prendre les coordonnées GPS (latitude)"
	note gpslatitude: "Veuillez prendre les coordonnées GPS (latitude)"

	label variable gpslongitude "Veuillez prendre les coordonnées GPS (longitude)"
	note gpslongitude: "Veuillez prendre les coordonnées GPS (longitude)"

	label variable gpsaltitude "Veuillez prendre les coordonnées GPS (altitude)"
	note gpsaltitude: "Veuillez prendre les coordonnées GPS (altitude)"

	label variable gpsaccuracy "Veuillez prendre les coordonnées GPS (accuracy)"
	note gpsaccuracy: "Veuillez prendre les coordonnées GPS (accuracy)"

	label variable gps_v "Vous n'avez pas pris les coordonnées GPS, est-ce que vous préférez les prendres "
	note gps_v: "Vous n'avez pas pris les coordonnées GPS, est-ce que vous préférez les prendres à la fin de l'enquête?"
	label define gps_v 1 "Oui" 0 "Non", replace
	label values gps_v gps_v

	label variable accept "Acceptez-vous de participer à cette enquête?"
	note accept: "Acceptez-vous de participer à cette enquête?"
	label define accept 1 "Oui" 0 "Non", replace
	label values accept accept

	label variable repondant_name "Pourriez-vous svp me donner votre nom?"
	note repondant_name: "Pourriez-vous svp me donner votre nom?"

	label variable repondant_rel "Quelle est votre relation avec le chef de ménage?"
	note repondant_rel: "Quelle est votre relation avec le chef de ménage?"
	label define repondant_rel 1 "Chef de ménage" 2 "Epouse/époux" 3 "Fils/fille" 4 "Fils/fille du conjoint(e)" 5 "Beau-fils/belle-fille/" 6 "Petit enfant" 7 "Père/mère" 8 "Beau-père/belle-mère" 9 "Frère/sœur" 10 "Grand parent" 11 "Tante/oncle" 12 "Autre proches" 13 "Autres non proches" 14 "Travailleur/domestique" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values repondant_rel repondant_rel

	label variable repondant_age "Quel est votre âge?"
	note repondant_age: "Quel est votre âge?"

	label variable repondant_sex "Quel est le genre du répondant?"
	note repondant_sex: "Quel est le genre du répondant?"
	label define repondant_sex 1 "Homme" 2 "Femme", replace
	label values repondant_sex repondant_sex

	label variable repondant_mat "Quel est votre statut matrimonial?"
	note repondant_mat: "Quel est votre statut matrimonial?"
	label define repondant_mat 1 "Marié" 2 "Divorcé / séparé" 3 "Veuf/ veuve" 4 "Célibataire" -98 "Ne souhaite pas répondre", replace
	label values repondant_mat repondant_mat

	label variable repondant_educ "Quel est le dernier niveau d'étude que vous avez atteint?"
	note repondant_educ: "Quel est le dernier niveau d'étude que vous avez atteint?"
	label define repondant_educ 1 "Ne sait ni lire ni écrire" 2 "Moins que l'école primaire" 3 "Ecole primaire achevée" 4 "Collège achevé" 5 "Lycée achevé" 6 "Université ou plus" 7 "Autre" -99 "Ne sait", replace
	label values repondant_educ repondant_educ

	label variable hhsize "En incluant vous-même, combien de membres vivent dans ce ménage?"
	note hhsize: "En incluant vous-même, combien de membres vivent dans ce ménage?"

	label variable enfant_moins5 "Combien de membres du ménage ont moins de 5 ans ?"
	note enfant_moins5: "Combien de membres du ménage ont moins de 5 ans ?"

	label variable enfant_1317 "Combien de membres du ménage ont entre 13 et 17 ans ?"
	note enfant_1317: "Combien de membres du ménage ont entre 13 et 17 ans ?"

	label variable enfant_primaire "Combien de membres du ménage ont entre 5 et 12 ans ?"
	note enfant_primaire: "Combien de membres du ménage ont entre 5 et 12 ans ?"

	label variable h_18_65 "Combien de membres du ménages sont des hommes entre 18 et 65 ans"
	note h_18_65: "Combien de membres du ménages sont des hommes entre 18 et 65 ans"

	label variable f_18_65 "Combien de membres du ménages sont des femmes entre 18 et 65 ans"
	note f_18_65: "Combien de membres du ménages sont des femmes entre 18 et 65 ans"

	label variable h_plus65 "Combien de membres du ménages sont des hommes de plus de 65 ans"
	note h_plus65: "Combien de membres du ménages sont des hommes de plus de 65 ans"

	label variable f_plus65 "Combien de membres du ménages sont des femmes de plus de 65 ans"
	note f_plus65: "Combien de membres du ménages sont des femmes de plus de 65 ans"

	label variable jeunes_lireecrire "Dans votre ménage : combien de membres ont entre 18 et 35 ans et ne savent ni li"
	note jeunes_lireecrire: "Dans votre ménage : combien de membres ont entre 18 et 35 ans et ne savent ni lire ni écrire ?"

	label variable handicap "Nombre d'handicapés physiques et mentaux parmi les membres du ménage"
	note handicap: "Nombre d'handicapés physiques et mentaux parmi les membres du ménage"

	label variable l_asset "Dans la liste suivante, quels sont les éléments que vous et votre ménage possède"
	note l_asset: "Dans la liste suivante, quels sont les éléments que vous et votre ménage possède ?"

	label variable l_asset_o "Vous avez coché 'Autre', veuillez spécifier."
	note l_asset_o: "Vous avez coché 'Autre', veuillez spécifier."

	label variable toit "Quel matériau a été utilisé principalement pour construire le toit de votre mais"
	note toit: "Quel matériau a été utilisé principalement pour construire le toit de votre maison?"
	label define toit 1 "Terre" 2 "Paille" 3 "Bois" 4 "Tôles de métal" 5 "Ciment/béton" 6 "Tuiles" 7 "Couverture de plastique" 8 "Autre" -98 "Ne souhaite pas répondre", replace
	label values toit toit

	label variable mur "Quel matériau a été utilisé principalement pour construire les murs de votre mai"
	note mur: "Quel matériau a été utilisé principalement pour construire les murs de votre maison ?"
	label define mur 1 "Terre /boue" 2 "Couverture de plastique" 3 "Briques" 4 "Bois" 5 "Pierres" 6 "Ciment/béton" 7 "Tôles de métal" 8 "Carton" 9 "Autre" -98 "Ne souhaite pas répondre", replace
	label values mur mur

	label variable sol "Quel matériau a été utilisé principalement pour construire le sol de votre maiso"
	note sol: "Quel matériau a été utilisé principalement pour construire le sol de votre maison ?"
	label define sol 1 "Terre batue" 2 "Ciment et/ou carlage" 3 "Autre" -98 "Ne souhaite pas répondre", replace
	label values sol sol

	label variable distance_eau "Place où vous puisez de l’eau à boire (aller), en MINUTES"
	note distance_eau: "Place où vous puisez de l’eau à boire (aller), en MINUTES"

	label variable distance_marche "Marché de produits alimentaires - Souk (aller), en MINUTES"
	note distance_marche: "Marché de produits alimentaires - Souk (aller), en MINUTES"

	label variable distance_transpublic "Station de Bus/camions/ transport publique (aller), en MINUTES"
	note distance_transpublic: "Station de Bus/camions/ transport publique (aller), en MINUTES"

	label variable distance_ecoleprim "École primaire (aller), en MINUTES"
	note distance_ecoleprim: "École primaire (aller), en MINUTES"

	label variable distance_ecolesec "École secondaire (aller), en MINUTES"
	note distance_ecolesec: "École secondaire (aller), en MINUTES"

	label variable distance_dispensaire "Dispensaire/ centre de santé de base/Hôpital (aller), en MINUTES"
	note distance_dispensaire: "Dispensaire/ centre de santé de base/Hôpital (aller), en MINUTES"

	label variable distance_cheflieu "Chef-lieu de l’imada, en MINUTES"
	note distance_cheflieu: "Chef-lieu de l’imada, en MINUTES"

	label variable proprietaire "Votre ménage est-il propriétaire de ce logement ?"
	note proprietaire: "Votre ménage est-il propriétaire de ce logement ?"
	label define proprietaire 1 "propriétaire" 2 "locataire" 3 "gratuitement" -98 "Ne souhaite pas répondre", replace
	label values proprietaire proprietaire

	label variable titre "Le chef du ménage a-t-il un titre de propriété pour ce logement?"
	note titre: "Le chef du ménage a-t-il un titre de propriété pour ce logement?"
	label define titre 1 "Oui" 0 "Non" -99 "Ne sait pas", replace
	label values titre titre

	label variable proprietaire_terre "Votre ménage possède-il des parcelles de terre?"
	note proprietaire_terre: "Votre ménage possède-il des parcelles de terre?"
	label define proprietaire_terre 1 "Oui" 0 "Non" -99 "Ne sait pas", replace
	label values proprietaire_terre proprietaire_terre

	label variable superficie "Quel est la superficie de ces parcelles que votre ménage possède? [hectars]"
	note superficie: "Quel est la superficie de ces parcelles que votre ménage possède? [hectars]"

	label variable superficie_m "Quel est la superficie de ces parcelles que votre ménage possède? [mètres carrés"
	note superficie_m: "Quel est la superficie de ces parcelles que votre ménage possède? [mètres carrés]"

	label variable titre_terre "Votre ménage a-t-il un document attestant qu’il est bien propriétaire de ces par"
	note titre_terre: "Votre ménage a-t-il un document attestant qu’il est bien propriétaire de ces parcelles?"
	label define titre_terre 1 "Oui" 0 "Non" -99 "Ne sait pas", replace
	label values titre_terre titre_terre

	label variable contestation_titre "Vos droits fonciers (pour les maisons ou parcelles) ont-ils été contestés dans l"
	note contestation_titre: "Vos droits fonciers (pour les maisons ou parcelles) ont-ils été contestés dans les 5 dernières années?"
	label define contestation_titre 1 "Oui" 0 "Non" -99 "Ne sait pas", replace
	label values contestation_titre contestation_titre

	label variable contestation_qui "Par qui?"
	note contestation_qui: "Par qui?"

	label variable c3 "Sélectionner dans cette liste les éléments que votre ménage a acheté au moins un"
	note c3: "Sélectionner dans cette liste les éléments que votre ménage a acheté au moins un fois dans les 7 derniers jours."

	label variable c3_o "Vous avez coché 'Autre', veuillez spécifier."
	note c3_o: "Vous avez coché 'Autre', veuillez spécifier."

	label variable c3_s "Durant les 7 derniers jours, d’où provenait la consommation en nourriture et tab"
	note c3_s: "Durant les 7 derniers jours, d’où provenait la consommation en nourriture et tabac?"

	label variable c1 "Durant les 7 derniers jours, combien de membres du ménage habitant sous ce toît,"
	note c1: "Durant les 7 derniers jours, combien de membres du ménage habitant sous ce toît, vous-même inclu, partagaient au moins 3 repas par jour?"

	label variable c2 "Durant les 7 derniers jours, combien de repas ont été mangés en dehors de la mai"
	note c2: "Durant les 7 derniers jours, combien de repas ont été mangés en dehors de la maison (pas issu de la nourriture du ménage) par l'ensemble des membres du ménage habitant sous ce toît, vous-même inclu?"

	label variable c4 "Loyer (si propriétaire combien couterait le loyer dans un logement équivalent en"
	note c4: "Loyer (si propriétaire combien couterait le loyer dans un logement équivalent en location). Au cours du dernier mois (valeur en DINARS):"

	label variable c5 "Electricité, gaz, essence, eau, bois de chauffage, etc. Au cours du dernier mois"
	note c5: "Electricité, gaz, essence, eau, bois de chauffage, etc. Au cours du dernier mois (valeur en DINARS):"

	label variable c6 "Téléphone fixe et portable, appels depuis cabine téléphonique, télécommunication"
	note c6: "Téléphone fixe et portable, appels depuis cabine téléphonique, télécommunication depuis un commerce, envois par la poste, internet, etc. Au cours du dernier mois (valeur en DINARS):"

	label variable c7 "Savon, détergeant, cosmétique, etc. Au cours du dernier mois (valeur en DINARS):"
	note c7: "Savon, détergeant, cosmétique, etc. Au cours du dernier mois (valeur en DINARS):"

	label variable c8 "Transport (transport public, essence/huile – ne pas inclure l'essence pour le vé"
	note c8: "Transport (transport public, essence/huile – ne pas inclure l'essence pour le véhicule du ménage). Au cours du dernier mois (valeur en DINARS):"

	label variable c9 "Coiffeur, Service vétérinaire, Aide-ménagère, Chauffeur et autre services. Au co"
	note c9: "Coiffeur, Service vétérinaire, Aide-ménagère, Chauffeur et autre services. Au cours du dernier mois (valeur en DINARS):"

	label variable c11 "Entretien du logement et petites réparations. Au cours des 12 dernier mois (vale"
	note c11: "Entretien du logement et petites réparations. Au cours des 12 dernier mois (valeur en DINARS):"

	label variable c12 "Dépenses médicales/de santé (hôpital, centre de santé, pharmacie, visites docteu"
	note c12: "Dépenses médicales/de santé (hôpital, centre de santé, pharmacie, visites docteur, médecine traditionnelle). Au cours des 12 dernier mois (valeur en DINARS):"

	label variable c13 "Education (coûts d’inscription, livres, fournitures scolaires, etc.). Au cours d"
	note c13: "Education (coûts d’inscription, livres, fournitures scolaires, etc.). Au cours des 12 dernier mois (valeur en DINARS):"

	label variable c14 "Vêtements, chaussures, chapeaux, tissus de confection, prêt-à-porter, etc. Au co"
	note c14: "Vêtements, chaussures, chapeaux, tissus de confection, prêt-à-porter, etc. Au cours des 12 dernier mois (valeur en DINARS):"

	label variable c15 "Biens durables et équipement du foyer (voiture, vélos, fours, réfrigirateurs, la"
	note c15: "Biens durables et équipement du foyer (voiture, vélos, fours, réfrigirateurs, lave-linge, meubles d’intérieurs, charettes, brouettes, etc…). Au cours des 12 dernier mois (valeur en DINARS):"

	label variable c16 "Taxes, impôts, assurances. Au cours des 12 dernier mois (valeur en DINARS):"
	note c16: "Taxes, impôts, assurances. Au cours des 12 dernier mois (valeur en DINARS):"

	label variable c18 "Fêtes et rituels (marriage, anniversaire,perlinage , circoncision, fêtes religie"
	note c18: "Fêtes et rituels (marriage, anniversaire,perlinage , circoncision, fêtes religieuses,etc.). Au cours des 12 dernier mois (valeur en DINARS):"

	label variable houla_huile "Au cours des 12 derniers mois, votre ménage a-t-il fait la houla pour l'huile d'"
	note houla_huile: "Au cours des 12 derniers mois, votre ménage a-t-il fait la houla pour l'huile d'olive?"
	label define houla_huile 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values houla_huile houla_huile

	label variable houla_huile_valeur "Combien le ménage a-t-il dépensé en tout pour toutes les houlas d'huile d'olive "
	note houla_huile_valeur: "Combien le ménage a-t-il dépensé en tout pour toutes les houlas d'huile d'olive pendant les 12 derniers mois?"

	label variable houla_ble "Au cours des 12 derniers mois, votre ménage a-t-il fait la houla pour les produi"
	note houla_ble: "Au cours des 12 derniers mois, votre ménage a-t-il fait la houla pour les produits dérivés du blé (semoule, farine, couscous, etc.)?"
	label define houla_ble 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values houla_ble houla_ble

	label variable houla_ble_valeur "Combien le ménage a-t-il dépensé en tout pour toutes les houlas des produits dér"
	note houla_ble_valeur: "Combien le ménage a-t-il dépensé en tout pour toutes les houlas des produits dérivés du blé (semoule, farine, couscous, etc.) pendant les 12 derniers mois?"

	label variable houla_autre "Au cours des 12 derniers mois, votre ménage a-t-il fait la houla pour des produi"
	note houla_autre: "Au cours des 12 derniers mois, votre ménage a-t-il fait la houla pour des produits autre que huile d'olive ou produits dérivés du blé (semoule, farine, couscous, etc.)?"
	label define houla_autre 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values houla_autre houla_autre

	label variable houla_autre_valeur "Combien le ménage a-t-il dépensé en tout pour toutes les houlas sur ces produits"
	note houla_autre_valeur: "Combien le ménage a-t-il dépensé en tout pour toutes les houlas sur ces produits autres que l'huile d'olive et les produits dérivés du blé (semoule, farine, couscous, etc.) pendant les 12 derniers mois?"

	label variable c20 "Au cours de 6 derniers mois, les membres de ce ménage ont-ils reçu de l’argent e"
	note c20: "Au cours de 6 derniers mois, les membres de ce ménage ont-ils reçu de l’argent en espèce de la part d’amis ou membres de la famille qui vivent en dehors de cet Imada, mais en Tunisie ?"
	label define c20 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values c20 c20

	label variable c21 "Quelle était la valeur totale de l’aide que le ménage a reçu (en Dinars Tunisien"
	note c21: "Quelle était la valeur totale de l’aide que le ménage a reçu (en Dinars Tunisiens)?"

	label variable c22 "Au cours de 12 derniers mois, les membres de ce ménage ont-ils reçu de l’argent "
	note c22: "Au cours de 12 derniers mois, les membres de ce ménage ont-ils reçu de l’argent en espèce de la part d’amis ou membres de la famille qui vivent à l’étranger ?"
	label define c22 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values c22 c22

	label variable c23 "Quelle était la valeur totale de l’aide que le ménage a reçu (en Dinars Tunisien"
	note c23: "Quelle était la valeur totale de l’aide que le ménage a reçu (en Dinars Tunisiens)?"

	label variable c24 "Hier quels repas ont été préparés/mangés dans votre ménage?"
	note c24: "Hier quels repas ont été préparés/mangés dans votre ménage?"

	label variable g1 "SCRIPT: Maintenant je vais vous poser quelques questions sur les évènements que "
	note g1: "SCRIPT: Maintenant je vais vous poser quelques questions sur les évènements que votre ménage a vécu durant les 12 derniers mois et qui peuvent avoir perturbé sa situation financière.  Au cours des 12 derniers mois, votre ménage a-t-il subi un de ces évènements ayant entraîné une perte de revenu/d'argent?"

	label variable g1_o "Vous avez coché 'Autre', veuillez spécifier."
	note g1_o: "Vous avez coché 'Autre', veuillez spécifier."

	label variable g2 "Qu'a fait le ménage pour faire face à ce(s) choc(s)?"
	note g2: "Qu'a fait le ménage pour faire face à ce(s) choc(s)?"

	label variable g2_o "Vous avez coché 'Autre', veuillez spécifier."
	note g2_o: "Vous avez coché 'Autre', veuillez spécifier."

	label variable f1 "Cochez tous les types de programmes auquel votre ménage a eu accès ces 12 dernie"
	note f1: "Cochez tous les types de programmes auquel votre ménage a eu accès ces 12 derniers mois:"

	label variable f1_o "Vous avez coché 'Autre', veuillez spécifier."
	note f1_o: "Vous avez coché 'Autre', veuillez spécifier."

	label variable f3 "Pourquoi votre ménage a-t-il participé au programme d'argent/vivre/nourriture co"
	note f3: "Pourquoi votre ménage a-t-il participé au programme d'argent/vivre/nourriture contre travail?"

	label variable f4 "Vous trouvez le travail proposé sur le chantier/projet du programme plutôt:"
	note f4: "Vous trouvez le travail proposé sur le chantier/projet du programme plutôt:"
	label define f4 1 "Facile." 2 "Difficile." 3 "Très difficile.", replace
	label values f4 f4

	label variable f5 "Le travailleur sur le chantier du programme devait manger plus de nourriture que"
	note f5: "Le travailleur sur le chantier du programme devait manger plus de nourriture que d’habitude pour travailler sur le chantier du programme?"
	label define f5 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values f5 f5

	label variable f6 "Vous deviez demander aux enfants de travailler à la maison pendant la période d'"
	note f6: "Vous deviez demander aux enfants de travailler à la maison pendant la période d'activité du chantier du programme?"
	label define f6 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values f6 f6

	label variable f7 "Vous deviez demander aux enfants de travailler à l'extérieur de la maison pendan"
	note f7: "Vous deviez demander aux enfants de travailler à l'extérieur de la maison pendant la période d'activité du chantier du programme?"
	label define f7 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values f7 f7

	label variable f8 "Un des membres du ménage pouvait-il travailler moins grâce à la participation au"
	note f8: "Un des membres du ménage pouvait-il travailler moins grâce à la participation au programme d’un autre membre du ménage?"
	label define f8 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values f8 f8

	label variable f9 "Pourquoi votre ménage n'a-t-il pas participé au programme d'argent contre travai"
	note f9: "Pourquoi votre ménage n'a-t-il pas participé au programme d'argent contre travail?"

	label variable f10 "Qui, normalement, constituait les listes des bénéficiaires du programme d'aide ?"
	note f10: "Qui, normalement, constituait les listes des bénéficiaires du programme d'aide ?"

	label variable f12 "Qui, normalement, distribue le programme/aides aux bénéficiaires ciblés ?"
	note f12: "Qui, normalement, distribue le programme/aides aux bénéficiaires ciblés ?"

	label variable f14 "Y a-t-il eu des manifestations ou conflits/combats concernant la façon dont ce p"
	note f14: "Y a-t-il eu des manifestations ou conflits/combats concernant la façon dont ce programme était mis en œuvre ?"
	label define f14 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values f14 f14

	label variable f15 "Dans l'ensemble, étiez-vous satisfait de la façon dont les bénéficiaires étaient"
	note f15: "Dans l'ensemble, étiez-vous satisfait de la façon dont les bénéficiaires étaient identifiés et servi ?"
	label define f15 1 "Très satisfaisant" 2 "Assez satisfaisant" 3 "Assez insatisfaisant" 4 "Très insatisfaisant" -98 "Refuse de répondre" -99 "Ne sait pas", replace
	label values f15 f15

	label variable f16 "Les conditions économiques de votre IMADA sont-elles PIRES, IDENTIQUES ou MEILLE"
	note f16: "Les conditions économiques de votre IMADA sont-elles PIRES, IDENTIQUES ou MEILLEURES que celles des IMADA de ce gouvernorat ?"
	label define f16 1 "Pires" 2 "Similaires" 3 "Meilleures" -98 "Ne souhaite pas répondre" -99 "Ne sait pas.", replace
	label values f16 f16

	label variable f17 "Les conditions économiques de votre MENAGE sont-elles PIRES, IDENTIQUES ou MEILL"
	note f17: "Les conditions économiques de votre MENAGE sont-elles PIRES, IDENTIQUES ou MEILLEURES qu'elles ne l'étaient l'ANNEE PASSEE ?"
	label define f17 1 "Pires" 2 "Similaires" 3 "Meilleures" -98 "Ne souhaite pas répondre" -99 "Ne sait pas.", replace
	label values f17 f17

	label variable f18 "Imaginez une échelle en 5 niveaux, les plus pauvres de cette IMADA étant sur le "
	note f18: "Imaginez une échelle en 5 niveaux, les plus pauvres de cette IMADA étant sur le plus bas (le premier niveau) et les personnes les plus riches de cet Imada étant sur le plus haut (le cinquième niveau). Sur quel niveau vous situez-vous aujourd'hui ?"
	label define f18 1 "1" 2 "2" 3 "3" 4 "4" 5 "5", replace
	label values f18 f18

	label variable rev_total "A combien estimez-vous les revenus totaux de votre ménage durant les 4 dernières"
	note rev_total: "A combien estimez-vous les revenus totaux de votre ménage durant les 4 dernières semaines?"

	label variable emploi "Aviez-vous une activité génératrice de revenu durant les 4 dernières semaines?"
	note emploi: "Aviez-vous une activité génératrice de revenu durant les 4 dernières semaines?"
	label define emploi 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values emploi emploi

	label variable chomage "Depuis combien de mois êtes-vous sans emploi salarié ni micro-entreprise (petit "
	note chomage: "Depuis combien de mois êtes-vous sans emploi salarié ni micro-entreprise (petit atelier, petit commerce au bord de la rue) génératrice de revenu ?"

	label variable chomage_recherche "Avez-vous cherché du travail rémunéré durant les 4 dernières semaines ?"
	note chomage_recherche: "Avez-vous cherché du travail rémunéré durant les 4 dernières semaines ?"
	label define chomage_recherche 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values chomage_recherche chomage_recherche

	label variable reserv_wage "En dessous de quel salaire mensuel (DINARS/mois) n'acceptez vous pas de travaill"
	note reserv_wage: "En dessous de quel salaire mensuel (DINARS/mois) n'acceptez vous pas de travailler?"

	label variable type_emploi "Nous parlons maintenant de votre activité professionnelle des 4 semaines passées"
	note type_emploi: "Nous parlons maintenant de votre activité professionnelle des 4 semaines passées. Cela inclue toutes vos activités contre rémunération ou commerce, pour vous ou pour votre ménage. Dans les 4 semaines passées avez-vous:"

	label variable type_emploi_o "Vous avez coché 'Autre ', veuillez spécifier."
	note type_emploi_o: "Vous avez coché 'Autre ', veuillez spécifier."

	label variable business_q0 "Avez-vous votre propre entreprise/business ?"
	note business_q0: "Avez-vous votre propre entreprise/business ?"
	label define business_q0 1 "Oui" 0 "Non", replace
	label values business_q0 business_q0

	label variable business_q1 "A propos de toutes ces activités, quelle est la valeur (de revente actuelle) de "
	note business_q1: "A propos de toutes ces activités, quelle est la valeur (de revente actuelle) de votre matériel (machines, gros et petit matériel) que vous possédez dans vos entreprises?"

	label variable business_q2 "Pour tous ces outils et machines juste mentionnés, quelle est la valeur de ce qu"
	note business_q2: "Pour tous ces outils et machines juste mentionnés, quelle est la valeur de ce que vous avez vous même acheté depuis Janvier 2015?"

	label variable business_q3 "Au total, combien avez-vous investi dans toutes vos entreprises lors de ces 4 de"
	note business_q3: "Au total, combien avez-vous investi dans toutes vos entreprises lors de ces 4 dernières semaines?"

	label variable business_q4 "Quelles est la valeur des dépenses totales courantes pour ces entreprises/busine"
	note business_q4: "Quelles est la valeur des dépenses totales courantes pour ces entreprises/business ces 4 dernières semaines?"

	label variable business_q5 "Quelles est la valeur des revenus totaux pour ces entreprises/business ces 4 der"
	note business_q5: "Quelles est la valeur des revenus totaux pour ces entreprises/business ces 4 dernières semaines?"

	label variable business_q6 "Est-ce que vous enregistrer dans un carnet tous vos dépenses et tous les revenus"
	note business_q6: "Est-ce que vous enregistrer dans un carnet tous vos dépenses et tous les revenus liés à vos activités économiques ?"
	label define business_q6 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values business_q6 business_q6

	label variable business_q7 "Est-ce que toutes ou partie de vos entreprises sont officiellement déclarées aup"
	note business_q7: "Est-ce que toutes ou partie de vos entreprises sont officiellement déclarées auprès des autorités ?"
	label define business_q7 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values business_q7 business_q7

	label variable business_q8 "Est-ce que vous payez des taxes liées à vos entreprises/business?"
	note business_q8: "Est-ce que vous payez des taxes liées à vos entreprises/business?"
	label define business_q8 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values business_q8 business_q8

	label variable emploi_2015_a "Avez-vous travaillé plus de 3 mois pendant les 12 derniers mois?"
	note emploi_2015_a: "Avez-vous travaillé plus de 3 mois pendant les 12 derniers mois?"
	label define emploi_2015_a 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values emploi_2015_a emploi_2015_a

	label variable emploi_2015_b "Quelle était votre activité principale pendant les 12 derniers mois?"
	note emploi_2015_b: "Quelle était votre activité principale pendant les 12 derniers mois?"
	label define emploi_2015_b 1 "Agriculteur" 2 "Eleveur" 3 "Pécheur" 4 "Industrie  agro alimentaire" 5 "Construction" 6 "Mécanique et électrique" 7 "Transport" 8 "Banque et assurance" 9 "Hôtels café et restaurant" 10 "Commerçant" 11 "Fonctionnaire d’Etat" 12 "Enseignant" 13 "Militaire/Combattant" 14 "Autre" -98 "Refuse de répondre" -99 "Ne sait pas", replace
	label values emploi_2015_b emploi_2015_b

	label variable emploi_2015_c "Combien de jours par mois consacriez-vous à votre emploi principal pendant les 1"
	note emploi_2015_c: "Combien de jours par mois consacriez-vous à votre emploi principal pendant les 12 derniers mois?"

	label variable emploi_2015_d "Combien d'argent gagniez-vous par mois pour cette activité pendant les 12 dernie"
	note emploi_2015_d: "Combien d'argent gagniez-vous par mois pour cette activité pendant les 12 derniers mois?"

	label variable emploi_2015_e "Combien d'années avez-vous exercé ce métier au cours de votre vie active ?"
	note emploi_2015_e: "Combien d'années avez-vous exercé ce métier au cours de votre vie active ?"

	label variable emploi_2015_f "Quelle satisfaction vous apporte cette activité principale?"
	note emploi_2015_f: "Quelle satisfaction vous apporte cette activité principale?"
	label define emploi_2015_f 1 "Très satisfaisant" 2 "Assez satisfaisant" 3 "Assez insatisfaisant" 4 "Très insatisfaisant" -98 "Refuse de répondre" -99 "Ne sait pas", replace
	label values emploi_2015_f emploi_2015_f

	label variable emploi_2015_h "Aviez-vous d'autres activités génératrices de revenus pendant les 12 derniers mo"
	note emploi_2015_h: "Aviez-vous d'autres activités génératrices de revenus pendant les 12 derniers mois, de quelque type que ce soit?"
	label define emploi_2015_h 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values emploi_2015_h emploi_2015_h

	label variable emploi_2015_i "De quelles activités génératrices de revenus s’agissait-il ?"
	note emploi_2015_i: "De quelles activités génératrices de revenus s’agissait-il ?"

	label variable emploi_2015_j "Combien de jours/mois consacriez-vous par semaine à ces activités génératrices d"
	note emploi_2015_j: "Combien de jours/mois consacriez-vous par semaine à ces activités génératrices de revenus en moyenne pendant les 12 derniers mois? (si plusieurs reporter le total)"

	label variable emploi_2015_k "Avec ces activités génératrices de revenus, combien d'argent gagniez-vous par mo"
	note emploi_2015_k: "Avec ces activités génératrices de revenus, combien d'argent gagniez-vous par mois en moyenne pendant les 12 derniers mois? (si plusieurs reporter le total)"

	label variable emploi_2014_a "Avez-vous travaillé plus de 3 mois en 2014 ?"
	note emploi_2014_a: "Avez-vous travaillé plus de 3 mois en 2014 ?"
	label define emploi_2014_a 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values emploi_2014_a emploi_2014_a

	label variable emploi_2014_b "Quelle était votre activité principale en 2014?"
	note emploi_2014_b: "Quelle était votre activité principale en 2014?"
	label define emploi_2014_b 1 "Agriculteur" 2 "Eleveur" 3 "Pécheur" 4 "Industrie  agro alimentaire" 5 "Construction" 6 "Mécanique et électrique" 7 "Transport" 8 "Banque et assurance" 9 "Hôtels café et restaurant" 10 "Commerçant" 11 "Fonctionnaire d’Etat" 12 "Enseignant" 13 "Militaire/Combattant" 14 "Autre" -98 "Refuse de répondre" -99 "Ne sait pas", replace
	label values emploi_2014_b emploi_2014_b

	label variable emploi_2014_c "Combien de jours par mois consacriez-vous à votre emploi principal en 2014?"
	note emploi_2014_c: "Combien de jours par mois consacriez-vous à votre emploi principal en 2014?"

	label variable emploi_2014_d "Combien d'argent gagniez-vous par mois pour cette activité en 2014?"
	note emploi_2014_d: "Combien d'argent gagniez-vous par mois pour cette activité en 2014?"

	label variable emploi_2013_a "Avez-vous travaillé plus de 3 mois en 2013 ?"
	note emploi_2013_a: "Avez-vous travaillé plus de 3 mois en 2013 ?"
	label define emploi_2013_a 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values emploi_2013_a emploi_2013_a

	label variable emploi_2013_b "Quelle était votre activité principale en 2013?"
	note emploi_2013_b: "Quelle était votre activité principale en 2013?"
	label define emploi_2013_b 1 "Agriculteur" 2 "Eleveur" 3 "Pécheur" 4 "Industrie  agro alimentaire" 5 "Construction" 6 "Mécanique et électrique" 7 "Transport" 8 "Banque et assurance" 9 "Hôtels café et restaurant" 10 "Commerçant" 11 "Fonctionnaire d’Etat" 12 "Enseignant" 13 "Militaire/Combattant" 14 "Autre" -98 "Refuse de répondre" -99 "Ne sait pas", replace
	label values emploi_2013_b emploi_2013_b

	label variable emploi_2013_c "Combien de jours par mois consacriez-vous à votre emploi principal en 2013?"
	note emploi_2013_c: "Combien de jours par mois consacriez-vous à votre emploi principal en 2013?"

	label variable emploi_2013_d "Combien d'argent gagniez-vous par mois pour cette activité en 2013?"
	note emploi_2013_d: "Combien d'argent gagniez-vous par mois pour cette activité en 2013?"

	label variable migration_cm_q1 "Avez-vous vécu hors de Jendouba dans l’année passée ?"
	note migration_cm_q1: "Avez-vous vécu hors de Jendouba dans l’année passée ?"
	label define migration_cm_q1 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values migration_cm_q1 migration_cm_q1

	label variable migration_cm_q2 "Combien de semaines en tout ?"
	note migration_cm_q2: "Combien de semaines en tout ?"

	label variable migration_cm_q3 "Où avez-vous passé le plus de temps en migration"
	note migration_cm_q3: "Où avez-vous passé le plus de temps en migration"
	label define migration_cm_q3 1 "Gouvernorats voisins de Jendouba" 2 "Autre en Tunisie" 3 "A l'étranger" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values migration_cm_q3 migration_cm_q3

	label variable migration_cm_q4 "Combien gagniez-vous par mois comme migrant à l'extérieur de Jendouba?"
	note migration_cm_q4: "Combien gagniez-vous par mois comme migrant à l'extérieur de Jendouba?"

	label variable migration_cm_q5 "Combien envoyiez-vous en moyenne par mois à votre ménage?"
	note migration_cm_q5: "Combien envoyiez-vous en moyenne par mois à votre ménage?"

	label variable migration_cm_q6 "Quel inconvénient principal présentez cette migration pour vous ?"
	note migration_cm_q6: "Quel inconvénient principal présentez cette migration pour vous ?"
	label define migration_cm_q6 1 "Aucun inconvenient" 2 "Moins de sécurité" 3 "Plus de travail dans le ménage" 4 "Mal-être psychologique" 5 "Autre problème" -98 "Refuse de répondre" -99 "Ne sait pas", replace
	label values migration_cm_q6 migration_cm_q6

	label variable migration_q1 "A part vous, combien de membres du ménage ont migré dans l’année révolue?"
	note migration_q1: "A part vous, combien de membres du ménage ont migré dans l’année révolue?"

	label variable migration_q2 "Combien de semaines en moyenne dans l'année révolue par migrant?"
	note migration_q2: "Combien de semaines en moyenne dans l'année révolue par migrant?"

	label variable migration_q4 "Combien gagnent ces membres migrants (autre que le chef de ménage) par mois en m"
	note migration_q4: "Combien gagnent ces membres migrants (autre que le chef de ménage) par mois en moyenne dans leur travail de migrant ?"

	label variable migration_q5 "Combien vous envoient-t-il en moyenne par mois?"
	note migration_q5: "Combien vous envoient-t-il en moyenne par mois?"

	label variable migration_q6 "Quel inconvénient principal présente ce travail de migrant pour vous ?"
	note migration_q6: "Quel inconvénient principal présente ce travail de migrant pour vous ?"
	label define migration_q6 1 "Aucun inconvenient" 2 "Moins de sécurité" 3 "Plus de travail dans le ménage" 4 "Mal-être psychologique" 5 "Autre problème" -98 "Refuse de répondre" -99 "Ne sait pas", replace
	label values migration_q6 migration_q6

	label variable epargne "Avez-vous épargné de l’argent au cours des 12 derniers mois ?"
	note epargne: "Avez-vous épargné de l’argent au cours des 12 derniers mois ?"
	label define epargne 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values epargne epargne

	label variable epargne_forme "Sous quelle forme avez-vous mis cet argent de côté ?"
	note epargne_forme: "Sous quelle forme avez-vous mis cet argent de côté ?"

	label variable epargne_cb "A combien estimez-vous l'argent que vous avez actuellement de côté ? (En prenant"
	note epargne_cb: "A combien estimez-vous l'argent que vous avez actuellement de côté ? (En prenant en compte TOUTES les formes d'épargne)"

	label variable epargne_dette "Avez-vous été ammené à vous endetter durant les 12 derniers mois ?"
	note epargne_dette: "Avez-vous été ammené à vous endetter durant les 12 derniers mois ?"
	label define epargne_dette 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values epargne_dette epargne_dette

	label variable epargne_dette_cb "A combien estimez-vous le montant de toutes les dettes que vous devez actuelleme"
	note epargne_dette_cb: "A combien estimez-vous le montant de toutes les dettes que vous devez actuellement ?"

	label variable epargne_pret "Avez-vous été ammené à préter de l'argent à quelqu'un d'autre durant les 12 dern"
	note epargne_pret: "Avez-vous été ammené à préter de l'argent à quelqu'un d'autre durant les 12 derniers mois ?"
	label define epargne_pret 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values epargne_pret epargne_pret

	label variable formation "Avez-vous suivi une formation professionnelle ou autres menant à un métier ?"
	note formation: "Avez-vous suivi une formation professionnelle ou autres menant à un métier ?"
	label define formation 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values formation formation

	label variable formation_type "De quel type de formation s'agit-t-il ?"
	note formation_type: "De quel type de formation s'agit-t-il ?"
	label define formation_type 1 "Langue" 2 "Informatique, télécommunications (internet, GSM)" 3 "Artisanat (coupé-couture, cordonnerie, braisière, cuisine, textile, etc.)" 4 "Batiment (peinture, charpentier, macconerie, electricité, etc.)" 5 "Agriculture (horticulture, plantation , élevage, …)" 6 "Gestion de petite entreprise, de petit commerce" 7 "Mécanique/électrique" 8 "Auto-école" 9 "Autres services" 10 "Autre" -98 "Ne souhaite pas répondre" -99 "Ne sait pas.", replace
	label values formation_type formation_type

	label variable emploi_futur_type "Si vous pouviez (re)commencer votre carrière une nouvelle fois, quel type d'empl"
	note emploi_futur_type: "Si vous pouviez (re)commencer votre carrière une nouvelle fois, quel type d'emploi aimeriez-vous faire ?"
	label define emploi_futur_type 1 "Salarié" 2 "Indépendant" 3 "Indifférent" 4 "Ne veut/peut pas travailler" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values emploi_futur_type emploi_futur_type

	label variable emploi_futur "Pour quel métier en particulier?"
	note emploi_futur: "Pour quel métier en particulier?"
	label define emploi_futur 1 "Agriculteur" 2 "Eleveur" 3 "Pécheur" 4 "Industrie  agro alimentaire" 5 "Construction" 6 "Mécanique et électrique" 7 "Transport" 8 "Banque et assurance" 9 "Hôtels café et restaurant" 10 "Commerçant" 11 "Fonctionnaire d’Etat" 12 "Enseignant" 13 "Militaire/Combattant" 14 "Autre" -98 "Refuse de répondre" -99 "Ne sait pas", replace
	label values emploi_futur emploi_futur

	label variable emploi_futur_cb "Combien d'argent espérez-vous ainsi gagner par mois ?"
	note emploi_futur_cb: "Combien d'argent espérez-vous ainsi gagner par mois ?"

	label variable emploi_competence_inutilisee "Avez-vous des compétence que vous voudriez exploiter mais que vous n'utilisez pa"
	note emploi_competence_inutilisee: "Avez-vous des compétence que vous voudriez exploiter mais que vous n'utilisez pas pour le moment ?"
	label define emploi_competence_inutilisee 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values emploi_competence_inutilisee emploi_competence_inutilisee

	label variable emploi_difficulte_salarie "Selon vous, quelles sont les difficultés pour trouver un emploi salarié ?"
	note emploi_difficulte_salarie: "Selon vous, quelles sont les difficultés pour trouver un emploi salarié ?"

	label variable emploi_difficulte_independant "Selon vous, quelles sont les difficultés pour créer une micro-entreprise ?"
	note emploi_difficulte_independant: "Selon vous, quelles sont les difficultés pour créer une micro-entreprise ?"

	label variable travail_enfant "Dans la semaine écoulée, lesquelles des tâches suivantes les enfants de 5-17 ans"
	note travail_enfant: "Dans la semaine écoulée, lesquelles des tâches suivantes les enfants de 5-17 ans ont éxercé ?"

	label variable te_3 "Comment décririez-vous l’environnement de travail de ces enfants pour leur santé"
	note te_3: "Comment décririez-vous l’environnement de travail de ces enfants pour leur santé et sécurité ?"
	label define te_3 1 "Très dangereux" 2 "Dangereux" 3 "Peu dangereux" 4 "Pas du tout dangereux" -98 "Ne souhaite pas répondre" -99 "Ne sait pas.", replace
	label values te_3 te_3

	label variable te_4 "Y-a-t-il des enfants qui ont manqué l’école une journée ces 30 derniers jours po"
	note te_4: "Y-a-t-il des enfants qui ont manqué l’école une journée ces 30 derniers jours pour travailler ?"
	label define te_4 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values te_4 te_4

	label variable taches_enfant "Dans les 7 derniers jours, un ou des enfants de 5-16 ans ont-ils exercées pour l"
	note taches_enfant: "Dans les 7 derniers jours, un ou des enfants de 5-16 ans ont-ils exercées pour le ménage les tâches suivantes ?"

	label variable taches_enfanto "Vous avez coché 'Autre', veuilez préciser"
	note taches_enfanto: "Vous avez coché 'Autre', veuilez préciser"

	label variable sante_soins "Pendant les 6 derniers mois, étiez-vous, vous ou un membre de votre ménage, mala"
	note sante_soins: "Pendant les 6 derniers mois, étiez-vous, vous ou un membre de votre ménage, malade au point de nécessiter des soins médicaux ?"
	label define sante_soins 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values sante_soins sante_soins

	label variable sante_lieux "Où votre ménage va-t-il habituellement chercher les soins médicaux en cas de mal"
	note sante_lieux: "Où votre ménage va-t-il habituellement chercher les soins médicaux en cas de maladie ?"
	label define sante_lieux 1 "Centre de sante de base" 2 "Hôpital/dispensaire" 3 "Clinique/médecin privé" 4 "Guérisseurs traditionnels" 5 "Acheter directement les médicaments à la pharmacie/automédication" 6 "Autre /rester à la maison", replace
	label values sante_lieux sante_lieux

	label variable sante_hopital "Au cours des 6 derniers mois, combien de fois les membres de votre ménage ont-t-"
	note sante_hopital: "Au cours des 6 derniers mois, combien de fois les membres de votre ménage ont-t-ils visité une clinique ou un hôpital pour des soins médicaux ?"

	label variable sante_qualite_a "Comment jugez-vous : la qualité du bâtiment de centre/poste de santé et de son é"
	note sante_qualite_a: "Comment jugez-vous : la qualité du bâtiment de centre/poste de santé et de son équipement"
	label define sante_qualite_a 0 "Mauvaise" 1 "Moyenne" 2 "Bonne" -98 "Ne souhaite pas répondre" -99 "Ne sait pas.", replace
	label values sante_qualite_a sante_qualite_a

	label variable sante_qualite_b "Comment jugez-vous : la qualité des soins, la compétence du personnel soignant e"
	note sante_qualite_b: "Comment jugez-vous : la qualité des soins, la compétence du personnel soignant et les heures de présence/d'opérations du personnel soignant"
	label define sante_qualite_b 0 "Mauvaise" 1 "Moyenne" 2 "Bonne" -98 "Ne souhaite pas répondre" -99 "Ne sait pas.", replace
	label values sante_qualite_b sante_qualite_b

	label variable sante_qualite_c "Comment jugez-vous : le coût des soins ? Sont-ils abordables ?"
	note sante_qualite_c: "Comment jugez-vous : le coût des soins ? Sont-ils abordables ?"
	label define sante_qualite_c 0 "Mauvaise" 1 "Moyenne" 2 "Bonne" -98 "Ne souhaite pas répondre" -99 "Ne sait pas.", replace
	label values sante_qualite_c sante_qualite_c

	label variable sante_qualite_d "Comment jugez-vous : la diffusion des informations sanitaire (p.ex. vaccination "
	note sante_qualite_d: "Comment jugez-vous : la diffusion des informations sanitaire (p.ex. vaccination contre maladies épidémiques) ?"
	label define sante_qualite_d 0 "Mauvaise" 1 "Moyenne" 2 "Bonne" -98 "Ne souhaite pas répondre" -99 "Ne sait pas.", replace
	label values sante_qualite_d sante_qualite_d

	label variable va_ecole "A présent je vais vous poser des questions sur l'école primaire que la majorité "
	note va_ecole: "A présent je vais vous poser des questions sur l'école primaire que la majorité des enfants de votre ménage fréquentent: Est-ce qu'au moins un des vos enfants en âge d'aller à l'école primaire fréquente un lieu d'éducation?"
	label define va_ecole 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values va_ecole va_ecole

	label variable ecole_type "Quel type d'établissement les enfants de votre ménage fréquentent-ils ?"
	note ecole_type: "Quel type d'établissement les enfants de votre ménage fréquentent-ils ?"
	label define ecole_type 0 "Publique" 1 "Privé-religieuse" 2 "Privé-non-religieuse" 3 "Associations/NGO" 4 "Autre" -98 "Ne souhaite pas répondre" -99 "Ne sait pas.", replace
	label values ecole_type ecole_type

	label variable ecole_qualite_a "Comment jugez-vous : la qualité du bâtiment et des espaces d'enseignement?"
	note ecole_qualite_a: "Comment jugez-vous : la qualité du bâtiment et des espaces d'enseignement?"
	label define ecole_qualite_a 0 "Mauvaise" 1 "Moyenne" 2 "Bonne" -98 "Ne souhaite pas répondre" -99 "Ne sait pas.", replace
	label values ecole_qualite_a ecole_qualite_a

	label variable ecole_qualite_b "Comment jugez-vous : la disponibilité et la qualité des livres, du matériel dida"
	note ecole_qualite_b: "Comment jugez-vous : la disponibilité et la qualité des livres, du matériel didactique ?"
	label define ecole_qualite_b 0 "Mauvaise" 1 "Moyenne" 2 "Bonne" -98 "Ne souhaite pas répondre" -99 "Ne sait pas.", replace
	label values ecole_qualite_b ecole_qualite_b

	label variable ecole_qualite_c "Comment jugez-vous : la qualité de l'éducation et de l'enseignement, la compéten"
	note ecole_qualite_c: "Comment jugez-vous : la qualité de l'éducation et de l'enseignement, la compétence des enseignants, la présence/les heures de cours des enseignants ?"
	label define ecole_qualite_c 0 "Mauvaise" 1 "Moyenne" 2 "Bonne" -98 "Ne souhaite pas répondre" -99 "Ne sait pas.", replace
	label values ecole_qualite_c ecole_qualite_c

	label variable ecole_qualite_d "Comment jugez-vous : le coût de l'éducation ? Est-ce abordable ?"
	note ecole_qualite_d: "Comment jugez-vous : le coût de l'éducation ? Est-ce abordable ?"
	label define ecole_qualite_d 0 "Mauvaise" 1 "Moyenne" 2 "Bonne" -98 "Ne souhaite pas répondre" -99 "Ne sait pas.", replace
	label values ecole_qualite_d ecole_qualite_d

	label variable education_jamais_interrompu "Dans votre ménage : combien d'enfants entre 6 et 12 ans n'ont jamais été à l'éco"
	note education_jamais_interrompu: "Dans votre ménage : combien d'enfants entre 6 et 12 ans n'ont jamais été à l'école, ou ont interrompu leur scolarité ?"

	label variable education_problemes "Quelles sont les raisons les plus importantes pour lesquelles certains enfants d"
	note education_problemes: "Quelles sont les raisons les plus importantes pour lesquelles certains enfants de votre ménage n'ont jamais été à l'école, ou ont interrompu leur scolarité ?"

	label variable origine_naissance "Etes vous né dans cette Imada ?"
	note origine_naissance: "Etes vous né dans cette Imada ?"
	label define origine_naissance 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values origine_naissance origine_naissance

	label variable origine_naissance_bis "Etes vous né dans le gouvernorat de Jendouba?"
	note origine_naissance_bis: "Etes vous né dans le gouvernorat de Jendouba?"
	label define origine_naissance_bis 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values origine_naissance_bis origine_naissance_bis

	label variable origine_arrivee "En quelle année êtes-vous arrivé dans cet Imada ?"
	note origine_arrivee: "En quelle année êtes-vous arrivé dans cet Imada ?"

	label variable origine_arrivee_cause "Pourquoi êtes-vous venu dans cet Imada village/ville ?"
	note origine_arrivee_cause: "Pourquoi êtes-vous venu dans cet Imada village/ville ?"

	label variable comite_c "Je voudrais maintenant vous poser des questions à propos des comités qui existen"
	note comite_c: "Je voudrais maintenant vous poser des questions à propos des comités qui existent dans l'IMADA pour gérer les ressources communes (eau, route, irrigation, etc.).   Existe-t-il une coopérative (Elevage/Agriculture) dans cet Imada?"
	label define comite_c 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values comite_c comite_c

	label variable comite_c_menage "Ce ménage en est-il membre ?"
	note comite_c_menage: "Ce ménage en est-il membre ?"
	label define comite_c_menage 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values comite_c_menage comite_c_menage

	label variable comite_c_representation "La coopérative représente-t-il toute la population concernée ?"
	note comite_c_representation: "La coopérative représente-t-il toute la population concernée ?"
	label define comite_c_representation 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values comite_c_representation comite_c_representation

	label variable comite_c_election "Les dirigeants en sont-ils élus ?"
	note comite_c_election: "Les dirigeants en sont-ils élus ?"
	label define comite_c_election 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values comite_c_election comite_c_election

	label variable comite_c_decision "Les décisions prises sont-elles exécutées ?"
	note comite_c_decision: "Les décisions prises sont-elles exécutées ?"
	label define comite_c_decision 1 "Toujours" 2 "Souvent" 3 "Rarement" 4 "Jamais" -98 "Ne souhaite pas répondre" -99 "Ne sait pas.", replace
	label values comite_c_decision comite_c_decision

	label variable comite_c_autrevillages "La coopérative travaille-t-elle avec d'autres Imadas?"
	note comite_c_autrevillages: "La coopérative travaille-t-elle avec d'autres Imadas?"
	label define comite_c_autrevillages 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values comite_c_autrevillages comite_c_autrevillages

	label variable comite_g "Sans prendre en compte les coopératives, existe-t-il un autre comité ?"
	note comite_g: "Sans prendre en compte les coopératives, existe-t-il un autre comité ?"
	label define comite_g 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values comite_g comite_g

	label variable comite_g2 "Précisez la nature de ce comité (si plusieurs le principal seulement)"
	note comite_g2: "Précisez la nature de ce comité (si plusieurs le principal seulement)"

	label variable comite_g_menage "Ce ménage en est-il membre ?"
	note comite_g_menage: "Ce ménage en est-il membre ?"
	label define comite_g_menage 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values comite_g_menage comite_g_menage

	label variable comite_g_representation "Le comité représente-t-il toute la population concernée ?"
	note comite_g_representation: "Le comité représente-t-il toute la population concernée ?"
	label define comite_g_representation 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values comite_g_representation comite_g_representation

	label variable comite_g_election "Les dirigeants en sont-ils élus ?"
	note comite_g_election: "Les dirigeants en sont-ils élus ?"
	label define comite_g_election 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values comite_g_election comite_g_election

	label variable comite_g_decision "Les décisions prises sont-elles exécutées ?"
	note comite_g_decision: "Les décisions prises sont-elles exécutées ?"
	label define comite_g_decision 1 "Toujours" 2 "Souvent" 3 "Rarement" 4 "Jamais" -98 "Ne souhaite pas répondre" -99 "Ne sait pas.", replace
	label values comite_g_decision comite_g_decision

	label variable comite_g_autrevillages "Le comité travaille-t-il avec d'autres villages/quartiers"
	note comite_g_autrevillages: "Le comité travaille-t-il avec d'autres villages/quartiers"
	label define comite_g_autrevillages 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values comite_g_autrevillages comite_g_autrevillages

	label variable association "Vous-même ou un membre de votre ménage participe-t-il aux associations suivantes"
	note association: "Vous-même ou un membre de votre ménage participe-t-il aux associations suivantes ?"

	label variable association_o "Précisez la nature de cette association"
	note association_o: "Précisez la nature de cette association"

	label variable conflit_dispute_in "Un des membres du ménage a-t-il été engagé dans un conflit / une dispute violent"
	note conflit_dispute_in: "Un des membres du ménage a-t-il été engagé dans un conflit / une dispute violente ces 12 derniers mois avec quelqu'un au sein de l'Imada?"
	label define conflit_dispute_in 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values conflit_dispute_in conflit_dispute_in

	label variable conflit_dispute_out "Un des membres du ménage a-t-il été engagé dans un conflit / une dispute violent"
	note conflit_dispute_out: "Un des membres du ménage a-t-il été engagé dans un conflit / une dispute violente ces 12 derniers mois avec quelqu'un en dehors de l'Imada?"
	label define conflit_dispute_out 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values conflit_dispute_out conflit_dispute_out

	label variable initiatives "Voici une liste d'initiatives que prennent souvent les citoyens. Pour chacune de"
	note initiatives: "Voici une liste d'initiatives que prennent souvent les citoyens. Pour chacune de celles-ci, dites-moi s'il vous plait, si vous ou un membre de votre ménage l'avez personnellement effectuée au cours des 6 derniers mois :"

	label variable responsability "Si l'imada recevait 10.000 DINARS pour son développement, à qui devrait-on donne"
	note responsability: "Si l'imada recevait 10.000 DINARS pour son développement, à qui devrait-on donner en premier lieu la responsabilité de gérer ce montant pour être sûr que l’argent est vraiment utilisé pour le bien être de toute l'imada ?"
	label define responsability 1 "L'Etat/le gouvernorat" 2 "ONG(s)" 3 "Chef de imada/Omda" 4 "Les habitants du village" 5 "Compagnie privée" 6 "Autre" -97 "Personne" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values responsability responsability

	label variable utopie_accord_a "Tout le monde devrait avoir droit de participer dans la prise des décisions poli"
	note utopie_accord_a: "Tout le monde devrait avoir droit de participer dans la prise des décisions politiques et économiques même s’ils ne maîtrisent pas tous les aspects du problème en question."
	label define utopie_accord_a 1 "D'accord" 2 "Ni l'un, ni l'autre (Pas d'opinion)" 3 "Pas d'accord" -98 "Ne souhaite pas répondre" -99 "Ne sait pas.", replace
	label values utopie_accord_a utopie_accord_a

	label variable utopie_accord_b "En tant que citoyens nous avons le devoir de vérifier régulièrement et de questi"
	note utopie_accord_b: "En tant que citoyens nous avons le devoir de vérifier régulièrement et de questionner les actions de nos dirigeants politiques provinciaux et nationaux."
	label define utopie_accord_b 1 "D'accord" 2 "Ni l'un, ni l'autre (Pas d'opinion)" 3 "Pas d'accord" -98 "Ne souhaite pas répondre" -99 "Ne sait pas.", replace
	label values utopie_accord_b utopie_accord_b

	label variable utopie_accord_c "Lorsqu’il est difficile d’obtenir gain de cause pour nos revendications, il faut"
	note utopie_accord_c: "Lorsqu’il est difficile d’obtenir gain de cause pour nos revendications, il faut parfois recourir à la manifestation."
	label define utopie_accord_c 1 "D'accord" 2 "Ni l'un, ni l'autre (Pas d'opinion)" 3 "Pas d'accord" -98 "Ne souhaite pas répondre" -99 "Ne sait pas.", replace
	label values utopie_accord_c utopie_accord_c

	label variable utopie_accord_d "En tant qu’habitants du village, nous avons le devoir de vérifier régulièrement "
	note utopie_accord_d: "En tant qu’habitants du village, nous avons le devoir de vérifier régulièrement et de questionner les actions de notre chef du imada (omda)."
	label define utopie_accord_d 1 "D'accord" 2 "Ni l'un, ni l'autre (Pas d'opinion)" 3 "Pas d'accord" -98 "Ne souhaite pas répondre" -99 "Ne sait pas.", replace
	label values utopie_accord_d utopie_accord_d

	label variable utopie_accord_e "Le gouvernement Tunisien a le droit de collecter les impôts auprès de tout le mo"
	note utopie_accord_e: "Le gouvernement Tunisien a le droit de collecter les impôts auprès de tout le monde et celui qui refuse de payer l’impôt n’aime pas ce pays."
	label define utopie_accord_e 1 "D'accord" 2 "Ni l'un, ni l'autre (Pas d'opinion)" 3 "Pas d'accord" -98 "Ne souhaite pas répondre" -99 "Ne sait pas.", replace
	label values utopie_accord_e utopie_accord_e

	label variable utopie_accord_f "Dans ce village, les femmes devraient avoir les mêmes droits et devoirs que les "
	note utopie_accord_f: "Dans ce village, les femmes devraient avoir les mêmes droits et devoirs que les hommes."
	label define utopie_accord_f 1 "D'accord" 2 "Ni l'un, ni l'autre (Pas d'opinion)" 3 "Pas d'accord" -98 "Ne souhaite pas répondre" -99 "Ne sait pas.", replace
	label values utopie_accord_f utopie_accord_f

	label variable source_info "Quelles sont les différentes sources d'information que vous utilisez pour vous r"
	note source_info: "Quelles sont les différentes sources d'information que vous utilisez pour vous rensiegner sur les nouvelles dans votre Imada?"

	label variable source_info2 "Quelles sont les différentes sources d'information que vous utilisez pour vous r"
	note source_info2: "Quelles sont les différentes sources d'information que vous utilisez pour vous rensiegner sur les nouvelles dans le reste du pays?"

	label variable securite "Je vais énumérer un certain nombre de problèmes que les gens rencontrent parfois"
	note securite: "Je vais énumérer un certain nombre de problèmes que les gens rencontrent parfois. Veuillez me dire si vous/votre ménage a connu ce problème dans les 6 derniers mois (demi-année passée):"

	label variable isolement "Au cours du mois passé avez-vous (ou votre ménage) :"
	note isolement: "Au cours du mois passé avez-vous (ou votre ménage) :"

	label variable pearlin_1 "Avez-vous le sentiment que vous pouvez résoudre vos problèmes vous même ?"
	note pearlin_1: "Avez-vous le sentiment que vous pouvez résoudre vos problèmes vous même ?"
	label define pearlin_1 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre", replace
	label values pearlin_1 pearlin_1

	label variable pearlin_2 "Est-ce que vous vous sentez désemparé pour faire face aux problèmes de la vie ?"
	note pearlin_2: "Est-ce que vous vous sentez désemparé pour faire face aux problèmes de la vie ?"
	label define pearlin_2 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre", replace
	label values pearlin_2 pearlin_2

	label variable pearlin_3 "Est-ce que vous avez des fois l’impression de vous laissez faire dans la vie ?"
	note pearlin_3: "Est-ce que vous avez des fois l’impression de vous laissez faire dans la vie ?"
	label define pearlin_3 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre", replace
	label values pearlin_3 pearlin_3

	label variable pearlin_4 "Est-ce que vous avez le sentiment d’avoir le contrôle sur les choses qui vous ar"
	note pearlin_4: "Est-ce que vous avez le sentiment d’avoir le contrôle sur les choses qui vous arrivent dans la vie ?"
	label define pearlin_4 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre", replace
	label values pearlin_4 pearlin_4

	label variable pearlin_5 "Est-ce que vous avez le sentiment que vous pouvez réussir toute chose dès lors q"
	note pearlin_5: "Est-ce que vous avez le sentiment que vous pouvez réussir toute chose dès lors que vous vous y dédiez totalement ?"
	label define pearlin_5 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre", replace
	label values pearlin_5 pearlin_5

	label variable pearlin_6 "Avez-vous le sentiment que ce qui vous arrivera dans le future dépend principale"
	note pearlin_6: "Avez-vous le sentiment que ce qui vous arrivera dans le future dépend principalement de vous ?"
	label define pearlin_6 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre", replace
	label values pearlin_6 pearlin_6

	label variable pearlin_7 "Avez-vous le sentiment que vous pouvez faire peu pour influencer un bon nombre d"
	note pearlin_7: "Avez-vous le sentiment que vous pouvez faire peu pour influencer un bon nombre des évènements importants de votre vie ?"
	label define pearlin_7 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre", replace
	label values pearlin_7 pearlin_7

	label variable psycho_partage_qui "Quand vous avez des problèmes ou des soucis qui vous tourmentent : Avec qui avez"
	note psycho_partage_qui: "Quand vous avez des problèmes ou des soucis qui vous tourmentent : Avec qui avez-vous souvent l'habitude de partager principalement ?"
	label define psycho_partage_qui 1 "Membre du ménage" 2 "Amis" 3 "Autre" -97 "Je n'ai personne avec qui partager" -98 "Ne souhaite pas répondre" -99 "Ne sait pas.", replace
	label values psycho_partage_qui psycho_partage_qui

	label variable psycho_accepte "Aujourd'hui, recontrez-vous des difficulté à être accepté par votre famille ?"
	note psycho_accepte: "Aujourd'hui, recontrez-vous des difficulté à être accepté par votre famille ?"
	label define psycho_accepte 1 "Oui, de grands problèmes" 2 "Quelques problèmes" 3 "Pas de problème" -98 "Ne souhaite pas répondre" -99 "Ne sait pas.", replace
	label values psycho_accepte psycho_accepte

	label variable psycho_accepte_menage "Aujourd'hui, votre famille rencontre-t-elle des difficulté à être acceptée par l"
	note psycho_accepte_menage: "Aujourd'hui, votre famille rencontre-t-elle des difficulté à être acceptée par les autres ménages de cette communauté ?"
	label define psycho_accepte_menage 1 "Oui, de grands problèmes" 2 "Quelques problèmes" 3 "Pas de problème" -98 "Ne souhaite pas répondre" -99 "Ne sait pas.", replace
	label values psycho_accepte_menage psycho_accepte_menage

	label variable psycho_depart "S'il vous arrivait de décider de quitter cet Imada, avec combien de personnes pr"
	note psycho_depart: "S'il vous arrivait de décider de quitter cet Imada, avec combien de personnes proches partageriez-vous cette décision ?"

	label variable psycho_menage "Comment décririez-vous les relations que les membres de votre ménages entretienn"
	note psycho_menage: "Comment décririez-vous les relations que les membres de votre ménages entretiennent les uns envers les autres ?"
	label define psycho_menage 1 "Mauvais" 2 "Bonne" 3 "Très bonne" -98 "Ne souhaite pas répondre" -99 "Ne sait pas.", replace
	label values psycho_menage psycho_menage

	label variable psycho_compagnie "Avec qui passez-vous le plus de temps?"
	note psycho_compagnie: "Avec qui passez-vous le plus de temps?"
	label define psycho_compagnie 1 "Famille" 2 "Collègues de travail" 3 "Amis de la communauté" -97 "Seul" -98 "Ne souhaite pas répondre" -99 "Ne sait pas.", replace
	label values psycho_compagnie psycho_compagnie

	label variable psycho_solitude "Quand vous passez du temps seul, pourquoi le faites-vous principalement?"
	note psycho_solitude: "Quand vous passez du temps seul, pourquoi le faites-vous principalement?"
	label define psycho_solitude 1 "Les autres sont indisponibles" 2 "Je me sens malheureux" 3 "Je veux juste être seul" 4 "Je n'ai confiance en personne" -98 "Ne souhaite pas répondre" -99 "Ne sait pas.", replace
	label values psycho_solitude psycho_solitude

	label variable psycho_anxiete "Avez-vous peur de perdre le contrôle de vous-même ou de «devenir fou» ?"
	note psycho_anxiete: "Avez-vous peur de perdre le contrôle de vous-même ou de «devenir fou» ?"
	label define psycho_anxiete 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre", replace
	label values psycho_anxiete psycho_anxiete

	label variable psycho_exploit "Avez-vous souvent eu le sentiment d’être exploité ou trompé par d’autres personn"
	note psycho_exploit: "Avez-vous souvent eu le sentiment d’être exploité ou trompé par d’autres personnes ?"
	label define psycho_exploit 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre", replace
	label values psycho_exploit psycho_exploit

	label variable psycho_depress1 "Vous sentez-vous souvent triste ou déprimé ?"
	note psycho_depress1: "Vous sentez-vous souvent triste ou déprimé ?"
	label define psycho_depress1 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre", replace
	label values psycho_depress1 psycho_depress1

	label variable psycho_depress2 "Avez-vous perdu l’intérêt pour des activités que vous aimiez auparavant ?"
	note psycho_depress2: "Avez-vous perdu l’intérêt pour des activités que vous aimiez auparavant ?"
	label define psycho_depress2 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre", replace
	label values psycho_depress2 psycho_depress2

	label variable psycho_depress3 "Vous sentez-vous souvent irritable ?"
	note psycho_depress3: "Vous sentez-vous souvent irritable ?"
	label define psycho_depress3 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre", replace
	label values psycho_depress3 psycho_depress3

	label variable psycho_depress4 "Vous arrive-t-il de perdre l'appétit?"
	note psycho_depress4: "Vous arrive-t-il de perdre l'appétit?"
	label define psycho_depress4 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre", replace
	label values psycho_depress4 psycho_depress4

	label variable psycho_depress5 "Croyez-vous que ce que vous pensez et ressentez n'a pas d'importance pour d’autr"
	note psycho_depress5: "Croyez-vous que ce que vous pensez et ressentez n'a pas d'importance pour d’autres ?"
	label define psycho_depress5 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre", replace
	label values psycho_depress5 psycho_depress5

	label variable calcul_1 "Imaginez que vous êtes un marchant et vous achetez une vache pour 1500 DINARS et"
	note calcul_1: "Imaginez que vous êtes un marchant et vous achetez une vache pour 1500 DINARS et la revendez à 2000 TDN. Quel est le profit issu de cette activité ?"
	label define calcul_1 1 "Réponse correct (500TND)" 2 "Réponse incorrecte (différent de 500 TND)" -99 "Ne sait pas.", replace
	label values calcul_1 calcul_1

	label variable calcul_2 "Je vais lire une lite de chiffres, essayez svp de les mémoriser et de répéter la"
	note calcul_2: "Je vais lire une lite de chiffres, essayez svp de les mémoriser et de répéter la liste: 32254"

	label variable trauma_abus "Durant la période 1987-2010, avez-vous, vous ou un membre de votre famille proch"
	note trauma_abus: "Durant la période 1987-2010, avez-vous, vous ou un membre de votre famille proche, été victime d'une violence physique ou psychologique?"
	label define trauma_abus 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre", replace
	label values trauma_abus trauma_abus

	label variable trauma_morts_cb "Avez-vous des membres de votre famille proches qui sont morts à cause de la révo"
	note trauma_morts_cb: "Avez-vous des membres de votre famille proches qui sont morts à cause de la révolution ou de la guerre contre le terrorisme ?"
	label define trauma_morts_cb 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre", replace
	label values trauma_morts_cb trauma_morts_cb

	label variable trauma_morts_amis "Avez-vous des amis (hors ménage) qui sont morts à cause de la révolution ou de l"
	note trauma_morts_amis: "Avez-vous des amis (hors ménage) qui sont morts à cause de la révolution ou de la guerre contre le terrorisme ?"
	label define trauma_morts_amis 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre", replace
	label values trauma_morts_amis trauma_morts_amis

	label variable trauma_cauchemars "Ces 6 derniers, quand vous pensiez à la révolution ou à la guerre contre le terr"
	note trauma_cauchemars: "Ces 6 derniers, quand vous pensiez à la révolution ou à la guerre contre le terrorisme, est-ce que vous passiez des nuits agitées, ou aviez-vous des cauchemars la nuit ?"
	label define trauma_cauchemars 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre", replace
	label values trauma_cauchemars trauma_cauchemars

	label variable trauma_souvenirs "Ces 6 derniers, quand vous pensiez à la révolution ou à la guerre contre le terr"
	note trauma_souvenirs: "Ces 6 derniers, quand vous pensiez à la révolution ou à la guerre contre le terrorisme, ressentiez-vous des douleurs dans la poitrine ou des maux de tête ?"
	label define trauma_souvenirs 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre", replace
	label values trauma_souvenirs trauma_souvenirs

	label variable trauma_abus_soins "Les victime d'une violence physique ou psychologique ont-elles reçu des soins mé"
	note trauma_abus_soins: "Les victime d'une violence physique ou psychologique ont-elles reçu des soins médicaux ?"
	label define trauma_abus_soins 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values trauma_abus_soins trauma_abus_soins

	label variable trauma_fin "Généralement, que faites-vous pour vous soulager lorsque vous pensez à la révolu"
	note trauma_fin: "Généralement, que faites-vous pour vous soulager lorsque vous pensez à la révolution ou à la guerre contre le terrorisme?"

	label variable intrahh_1 "Est-ce que vous avez gagné de l’argent au cours des 6 derniers mois ?"
	note intrahh_1: "Est-ce que vous avez gagné de l’argent au cours des 6 derniers mois ?"
	label define intrahh_1 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values intrahh_1 intrahh_1

	label variable intrahh_2 "Est-ce que vous décidez seule de la manière dont vous utilisez l'argent que vous"
	note intrahh_2: "Est-ce que vous décidez seule de la manière dont vous utilisez l'argent que vous gagnez ?"
	label define intrahh_2 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values intrahh_2 intrahh_2

	label variable intrahh_3 "Quelle est la personne la plus importante avec qui vous décidez comment l'argent"
	note intrahh_3: "Quelle est la personne la plus importante avec qui vous décidez comment l'argent que vous gagnez est utilisé?"
	label define intrahh_3 1 "Conjoint( e )" 2 "Père" 3 "Mère" 4 "Frère" 5 "Sœur" 6 "Oncle" 7 "Tante" 8 "Fils" 9 "Fille" 10 "Belle-mère" 11 "Beau-père" 12 "Grand-père" 13 "Grand-mère" 14 "Autre homme" 15 "Autre femme" -97 "Non-applicable" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values intrahh_3 intrahh_3

	label variable intrahh_4 "Quelle est la seconde personne la plus importante avec qui vous décidez comment "
	note intrahh_4: "Quelle est la seconde personne la plus importante avec qui vous décidez comment l'argent que vous gagnez est utilisé?"
	label define intrahh_4 1 "Conjoint( e )" 2 "Père" 3 "Mère" 4 "Frère" 5 "Sœur" 6 "Oncle" 7 "Tante" 8 "Fils" 9 "Fille" 10 "Belle-mère" 11 "Beau-père" 12 "Grand-père" 13 "Grand-mère" 14 "Autre homme" 15 "Autre femme" -97 "Non-applicable" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values intrahh_4 intrahh_4

	label variable intrahh_6 "Est-ce que vous avez un conjoint ?"
	note intrahh_6: "Est-ce que vous avez un conjoint ?"
	label define intrahh_6 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values intrahh_6 intrahh_6

	label variable intrahh_7 "Habituellement, votre conjoint décide-t-il seul de la manière dont l'argent qu'i"
	note intrahh_7: "Habituellement, votre conjoint décide-t-il seul de la manière dont l'argent qu'il gagne est utilisé ?"
	label define intrahh_7 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values intrahh_7 intrahh_7

	label variable intrahh_8 "Quelle est la personne la plus importante avec qui votre conjoint décide comment"
	note intrahh_8: "Quelle est la personne la plus importante avec qui votre conjoint décide comment l'argent qu'il gagne est utilisé ?"
	label define intrahh_8 1 "Conjoint( e )" 2 "Père" 3 "Mère" 4 "Frère" 5 "Sœur" 6 "Oncle" 7 "Tante" 8 "Fils" 9 "Fille" 10 "Belle-mère" 11 "Beau-père" 12 "Grand-père" 13 "Grand-mère" 14 "Autre homme" 15 "Autre femme" -97 "Non-applicable" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values intrahh_8 intrahh_8

	label variable intrahh_9 "Quelle est la seconde personne la plus importante avec qui votre conjoint décide"
	note intrahh_9: "Quelle est la seconde personne la plus importante avec qui votre conjoint décide comment l'argent qu'il gagne est utilisé ?"
	label define intrahh_9 1 "Conjoint( e )" 2 "Père" 3 "Mère" 4 "Frère" 5 "Sœur" 6 "Oncle" 7 "Tante" 8 "Fils" 9 "Fille" 10 "Belle-mère" 11 "Beau-père" 12 "Grand-père" 13 "Grand-mère" 14 "Autre homme" 15 "Autre femme" -97 "Non-applicable" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values intrahh_9 intrahh_9

	label variable intrahh_11 "Dans les 6 derniers mois, un membre de votre ménage a confisqué ou dépensé votre"
	note intrahh_11: "Dans les 6 derniers mois, un membre de votre ménage a confisqué ou dépensé votre argent sans votre consentement ?"
	label define intrahh_11 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values intrahh_11 intrahh_11

	label variable intrahh_12 "Qui a confisqué ou dépensé votre argent sans votre consentement ?"
	note intrahh_12: "Qui a confisqué ou dépensé votre argent sans votre consentement ?"
	label define intrahh_12 1 "Conjoint( e )" 2 "Père" 3 "Mère" 4 "Frère" 5 "Sœur" 6 "Oncle" 7 "Tante" 8 "Fils" 9 "Fille" 10 "Belle-mère" 11 "Beau-père" 12 "Grand-père" 13 "Grand-mère" 14 "Autre homme" 15 "Autre femme" -97 "Non-applicable" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
	label values intrahh_12 intrahh_12

	label variable violence_1 "Durant les 12 derniers mois avez-vous subi les violences suivantes? Vos réponses"
	note violence_1: "Durant les 12 derniers mois avez-vous subi les violences suivantes? Vos réponses sont strictement confidencielles, aucun membre de votre ménage n'y aura accès."

	label variable violence_2 "Durant le reste de votre vie (avant les 12 derniers mois), avez-vous subi les vi"
	note violence_2: "Durant le reste de votre vie (avant les 12 derniers mois), avez-vous subi les violences suivantes? Vos réponses sont strictement confidencielles, aucun membre de votre ménage n'y aura accès."

	label variable cell "Quel est votre numéro de téléphone?"
	note cell: "Quel est votre numéro de téléphone?"

	label variable q1 "Où est-ce que l'entretien a-t-il eu lieu?"
	note q1: "Où est-ce que l'entretien a-t-il eu lieu?"
	label define q1 0 "L'interview n'a pas eu lieu." 1 "Dans le logement de la personne interrogée." 2 "En dehors du logement la personne interrogée, mais sur sa propriété." 3 "En dehors du logement la personne interrogée, devant chez elle/lui." 4 "En dehors du logement la personne interrogée, dans un espace public.", replace
	label values q1 q1

	label variable q2 "L'entretien a-t-il été terminé?"
	note q2: "L'entretien a-t-il été terminé?"
	label define q2 1 "Oui" 0 "Non" -99 "Ne sait pas", replace
	label values q2 q2

	label variable q3 "Si non, veuillez expliquer pourquoi:"
	note q3: "Si non, veuillez expliquer pourquoi:"

	label variable q6 "Quel confiance avez-vous dans la qualité générale de l'entretien?"
	note q6: "Quel confiance avez-vous dans la qualité générale de l'entretien?"
	label define q6 1 "Très confiant de la véracité des réponses." 2 "Assez confiant de la véracité des réponses." 3 "Pas du tout confiant de la véracité des réponses.", replace
	label values q6 q6

	label variable q8latitude "Vous avez au début de l'enquête choisi de prendre les coordonées GPS à la fin de"
	note q8latitude: "Vous avez au début de l'enquête choisi de prendre les coordonées GPS à la fin de l'enquête. Veuillez procéder au relevé des coordonnées GPS maintenant. (latitude)"

	label variable q8longitude "Vous avez au début de l'enquête choisi de prendre les coordonées GPS à la fin de"
	note q8longitude: "Vous avez au début de l'enquête choisi de prendre les coordonées GPS à la fin de l'enquête. Veuillez procéder au relevé des coordonnées GPS maintenant. (longitude)"

	label variable q8altitude "Vous avez au début de l'enquête choisi de prendre les coordonées GPS à la fin de"
	note q8altitude: "Vous avez au début de l'enquête choisi de prendre les coordonées GPS à la fin de l'enquête. Veuillez procéder au relevé des coordonnées GPS maintenant. (altitude)"

	label variable q8accuracy "Vous avez au début de l'enquête choisi de prendre les coordonées GPS à la fin de"
	note q8accuracy: "Vous avez au début de l'enquête choisi de prendre les coordonées GPS à la fin de l'enquête. Veuillez procéder au relevé des coordonnées GPS maintenant. (accuracy)"

	label variable q9 "Vous n'avez pas relevé les coordonées GPS, pourquoi?"
	note q9: "Vous n'avez pas relevé les coordonées GPS, pourquoi?"
	label define q9 0 "J'ai oublié. Je vais essayer à nouveau avec ma tablette." 1 "Le GPS de la tablette fonctionne mal. Je vais reporter cela à mon superviseur.", replace
	label values q9 q9 

	capture {
		foreach rgvar of varlist q2_1* {
			label variable `rgvar' "Combien de \${asset_name} votre ménage possède-t-il?"
			note `rgvar': "Combien de \${asset_name} votre ménage possède-t-il?"
		}
	}

	capture {
		foreach rgvar of varlist q2_2* {
			label variable `rgvar' "Si vous deviez vendre tout votre avoir en \${asset_name} à combien pensez vous p"
			note `rgvar': "Si vous deviez vendre tout votre avoir en \${asset_name} à combien pensez vous pouvoir le vendre (en DINARS)?"
		}
	}

	capture {
		foreach rgvar of varlist c3_a* {
			label variable `rgvar' "Quelle est la valeur en DINARS des achats en \${food_name} pour votre ménage dur"
			note `rgvar': "Quelle est la valeur en DINARS des achats en \${food_name} pour votre ménage durant les 7 derniers jours?"
		}
	}

	capture {
		foreach rgvar of varlist c3_b* {
			label variable `rgvar' "Combien de fois par mois votre ménage a-t-il acheté en moyenne \${food_name} dur"
			note `rgvar': "Combien de fois par mois votre ménage a-t-il acheté en moyenne \${food_name} durant les 12 derniers mois?"
		}
	}

	capture {
		foreach rgvar of varlist f2* {
			label variable `rgvar' "L'aide '\${assistance_name}' était-elle apportée par à un membre du ménage en pa"
			note `rgvar': "L'aide '\${assistance_name}' était-elle apportée par à un membre du ménage en particulier, ou à l'ensemble du ménage?"
			label define `rgvar' 0 "un membre spécifique" 1 "tout le ménage" -99 "Ne sait", replace
			label values `rgvar' `rgvar'
		}
	}

	capture {
		foreach rgvar of varlist f2_val* {
			label variable `rgvar' "Quelle était la valeur en DINARS de l'aide '\${assistance_name}?'"
			note `rgvar': "Quelle était la valeur en DINARS de l'aide '\${assistance_name}?'"
		}
	}

	capture {
		foreach rgvar of varlist type_emploi_q1* {
			label variable `rgvar' "Lors des 4 semaines passes, combien de jours avez-vous travaillé comme \${type_e"
			note `rgvar': "Lors des 4 semaines passes, combien de jours avez-vous travaillé comme \${type_emploi_name} ?"
		}
	}

	capture {
		foreach rgvar of varlist type_emploi_q2* {
			label variable `rgvar' "En moyenne durant ces 4 dernières semaines combien d'heures travailliez-vous com"
			note `rgvar': "En moyenne durant ces 4 dernières semaines combien d'heures travailliez-vous comme \${type_emploi_name} par jour?"
		}
	}

	capture {
		foreach rgvar of varlist type_emploi_q3* {
			label variable `rgvar' "Combien avez-vous gagné au total lors des 4 dernières semaines comme \${type_emp"
			note `rgvar': "Combien avez-vous gagné au total lors des 4 dernières semaines comme \${type_emploi_name} (valeur en DINARS)?"
		}
	}

	capture {
		foreach rgvar of varlist type_emploi_q4* {
			label variable `rgvar' "Avez signé un contrat pour cette activité de \${type_emploi_name}?"
			note `rgvar': "Avez signé un contrat pour cette activité de \${type_emploi_name}?"
			label define `rgvar' 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
			label values `rgvar' `rgvar'
		}
	}

	capture {
		foreach rgvar of varlist type_emploi_q5* {
			label variable `rgvar' "Quel était votre profit au total lors des 4 dernières semaines sur cette activit"
			note `rgvar': "Quel était votre profit au total lors des 4 dernières semaines sur cette activité de \${type_emploi_name}? Je veux dire le gain net (le revenu moins les coûts de l’activité \${type_emploi_name})."
		}
	}

	capture {
		foreach rgvar of varlist type_emploi_q6* {
			label variable `rgvar' "Avez-vous payé des personnes pour travailler pour vous sur cette activité de \${"
			note `rgvar': "Avez-vous payé des personnes pour travailler pour vous sur cette activité de \${type_emploi_name}?"
			label define `rgvar' 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
			label values `rgvar' `rgvar'
		}
	}

	capture {
		foreach rgvar of varlist type_emploi_q7* {
			label variable `rgvar' "Combien de ces personnes (membres du ménage ou pas) avez-vous payé pour leur tra"
			note `rgvar': "Combien de ces personnes (membres du ménage ou pas) avez-vous payé pour leur travail dans cette activité de \${type_emploi_name} lors des 4 semaines passées ?"
		}
	}

	capture {
		foreach rgvar of varlist type_emploi_q8* {
			label variable `rgvar' "Combien de jours au total avez-vous employé toutes ces personnes (membres du mén"
			note `rgvar': "Combien de jours au total avez-vous employé toutes ces personnes (membres du ménage ou pas) dans cette activité de \${type_emploi_name} lors des 4 semaines passées ?"
		}
	}

	capture {
		foreach rgvar of varlist type_emploi_q9* {
			label variable `rgvar' "Sur une journée typique, combien d’heures avez-vous employé ces personnes (membr"
			note `rgvar': "Sur une journée typique, combien d’heures avez-vous employé ces personnes (membres du ménage ou pas) en moyenne par jour dans cette activité de \${type_emploi_name} lors des 4 semaines passées ?"
		}
	}

	capture {
		foreach rgvar of varlist type_emploi_q10* {
			label variable `rgvar' "Sur une journée typique, combien avez-vous payé au total toutes ces personnes (m"
			note `rgvar': "Sur une journée typique, combien avez-vous payé au total toutes ces personnes (membres du ménage ou pas) pour leur travail dans cette activité de \${type_emploi_name} lors des 4 semaines passées ? [Somme en DINARS de tout l’argent versé pour toutes les personnes employées sur cette activité de \${type_emploi_name}]"
		}
	}

	capture {
		foreach rgvar of varlist type_emploi_q11* {
			label variable `rgvar' "Est-ce qu’un programme argent contre travail (TCPL, THIMO, ou autres similaires "
			note `rgvar': "Est-ce qu’un programme argent contre travail (TCPL, THIMO, ou autres similaires impliquant un travail avec les associations/ONGs) a entraîné une augmentation du salaire demandé par les travailleurs sur cette activité de \${type_emploi_name}?"
			label define `rgvar' 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
			label values `rgvar' `rgvar'
		}
	}

	capture {
		foreach rgvar of varlist te_1* {
			label variable `rgvar' "Est-ce que l’activité '\${tache_name}' a nécessité de porter des charges lourdes"
			note `rgvar': "Est-ce que l’activité '\${tache_name}' a nécessité de porter des charges lourdes ?"
			label define `rgvar' 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
			label values `rgvar' `rgvar'
		}
	}

	capture {
		foreach rgvar of varlist te_2* {
			label variable `rgvar' "Est-ce que l’activité '\${tache_name}' a nécessite de travailler avec des outils"
			note `rgvar': "Est-ce que l’activité '\${tache_name}' a nécessite de travailler avec des outils dangereux (couteaux, etc.) ou de faire fonctionner des grosses machines ?"
			label define `rgvar' 1 "Oui" 0 "Non" -98 "Ne souhaite pas répondre" -99 "Ne sait pas", replace
			label values `rgvar' `rgvar'
		}
	}
