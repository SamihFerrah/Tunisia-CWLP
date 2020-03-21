list key if inlist(ID,30841,30007,30839,30219,30250,30969,30214,30146,31156,30472,30181,30618,31137,30819,30429,30235,30023,30255,30593,31021,30324,30659,30269,31176,30413,31096,30476)

*participants as drop-outs
replace ID=20058 if ID==30841
replace ID=20087 if ID==30007
replace ID=20054 if ID==30839
replace ID=20214 if ID==30219
replace ID=20388 if ID==30250
replace ID=20182 if ID==30969
replace ID=20212 if ID==30214
replace ID=20260 if ID==30146
*replace ID=20258 if ID==31156
replace ID=20221 if ID==30472
replace ID=20283 if ID==30181
replace ID=20107 if ID==30618
replace ID=20046 if ID==31137
replace ID=20418 if ID==30819
replace ID=20436 if ID==30429
replace ID=20219 if ID==30235
replace ID=20092 if ID==30023
replace ID=20389 if ID==30255
replace ID=20001 if ID==30593
replace ID=20033 if ID==31021
replace ID=20273 if ID==30324
replace ID=20099 if ID==30659
replace ID=20386 if ID==30269
replace ID=20291 if ID==31176
replace ID=20071 if ID==30413
replace ID=20234 if ID==31096
replace ID=20230 if ID==30476

list key if inlist(ID,/*10258,10623,10638,10276,10634,10639,*/10271,10280,10205,10744,10105,10319,10630,10285,10281,10426,10637,10413,10324,10022,10635)

*controls as participants
replace ID=30571 if ID==10271
replace ID=30562 if ID==10280
replace ID=30193 if ID==10205
replace ID=30797 if ID==10744
replace ID=30289 if ID==10105
replace ID=30057 if ID==10319
replace ID=30265 if ID==10630
replace ID=30553 if ID==10285
replace ID=30560 if ID==10281
replace ID=30148 if ID==10426
replace ID=30248 if ID==10637
replace ID=30388 if ID==10413
replace ID=30045 if ID==10324
replace ID=30925 if ID==10022
replace ID=30263 if ID==10635

*check for duplicates in ID (used for merge with nominative lists)
duplicates report ID if enquete==2
duplicates tag ID, gen(dup3)
tab dup3 if enquete==2
sort ID
*browse hh_id ID repondant_name key if dup3==1 //drop key=="uuid:dd9b95fa-3e3a-4d57-b0cf-97426c13918e" and not change 31156

drop if key=="uuid:dd9b95fa-3e3a-4d57-b0cf-97426c13918e" //ID duplicate, wrong name at address

