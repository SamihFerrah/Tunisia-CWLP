********************************************************************************
********************************************************************************
* 					DUPLICATES IN CODE CORRECTION
********************************************************************************
********************************************************************************

* Add correction or drop survey to resolve for duplicates based on Samir's comment from field


* Added 7th January - the survey of Ebdelli is the correct one; 
*The survey of HADDAS S was conducted under the wrong ID ( the coorect ID = 31066 for BESMA RAHMOUNI

replace hhid = 31066 if hhid == 39208 & key == "uuid:0e20c22a-c0d3-4b0b-b745-70bc37b45740"
replace HHID = 31066 if key == "uuid:0e20c22a-c0d3-4b0b-b745-70bc37b45740"

*Added 02/23

replace hhid = 292 if key =="uuid:91e4b651-660d-4e9f-b420-e133e1105383"
replace HHID = 292 if key =="uuid:91e4b651-660d-4e9f-b420-e133e1105383"

replace hhid = 10722 if key =="uuid:82045b46-f0a8-4c56-8d12-54e0b66efae0"
replace HHID = 10722 if key =="uuid:82045b46-f0a8-4c56-8d12-54e0b66efae0"

replace hhid = 30407 if key == "uuid:e0e07ebf-22f8-482b-8cf5-afd41f55c39d"
replace HHID = 30407 if key == "uuid:e0e07ebf-22f8-482b-8cf5-afd41f55c39d"

replace hhid = 33537 if key =="uuid:5aa89f31-c79e-4101-b0e0-cffa21edeeeb"
replace HHID = 33537 if key =="uuid:5aa89f31-c79e-4101-b0e0-cffa21edeeeb"

replace hhid = 39142 if key == "uuid:e5b66a6a-03a1-45ff-84ae-217ff93241a0"
replace HHID = 39142 if key == "uuid:e5b66a6a-03a1-45ff-84ae-217ff93241a0"

replace hhid = 39055 if key == "uuid:65742e3a-dc54-4484-bf3f-1f9d8eeb14fa"
replace HHID = 39055 if key == "uuid:65742e3a-dc54-4484-bf3f-1f9d8eeb14fa"

replace hhid = 39918 if key == "uuid:d7e3c6ee-a431-4f50-b0bc-a201e682648b"
replace HHID = 39918 if key == "uuid:d7e3c6ee-a431-4f50-b0bc-a201e682648b"

replace hhid = 39607 if key == "uuid:ba5c6b16-bc35-411e-a2ea-3a6f5372d4a4"
replace HHID = 39607 if key == "uuid:ba5c6b16-bc35-411e-a2ea-3a6f5372d4a4"

replace hhid = 39315 if key == "uuid:30db90e2-9d34-4f81-8db9-14155a0420a4"
replace HHID = 39315 if key == "uuid:30db90e2-9d34-4f81-8db9-14155a0420a4"

replace hhid = 39394 if key == "uuid:929633aa-fd23-494c-9034-94abd10c350d"
replace HHID = 39394 if key == "uuid:929633aa-fd23-494c-9034-94abd10c350d"

replace hhid = 39673 if key == "uuid:2a54b6cd-6eb9-4514-98e4-2cf55ee73802"
replace HHID = 39673 if key == "uuid:2a54b6cd-6eb9-4514-98e4-2cf55ee73802"

replace hhid = 39753 if key == "uuid:2f0c504e-4858-4886-83a9-8bfba55a2154"
replace HHID = 39753 if key == "uuid:2f0c504e-4858-4886-83a9-8bfba55a2154"

replace hhid = 39827 if key == "uuid:1637ffac-3208-414e-96df-76f7698f40a4"
replace HHID = 39827 if key == "uuid:1637ffac-3208-414e-96df-76f7698f40a4"

replace hhid = 39837 if key == "uuid:3231129f-9256-413b-8d81-266f1664f69b"
replace HHID = 39837 if key == "uuid:3231129f-9256-413b-8d81-266f1664f69b"

replace hhid = 39847 if key == "uuid:6ddff959-e6b6-4a0c-a443-c0b5e6b1b506"
replace HHID = 39847 if key == "uuid:6ddff959-e6b6-4a0c-a443-c0b5e6b1b506"

replace hhid = 39286 if key == "uuid:f37552e6-def4-48a9-aa83-e07d6f1304b6"
replace HHID = 39286 if key == "uuid:f37552e6-def4-48a9-aa83-e07d6f1304b6"

replace hhid = 10796 if key == "uuid:db4573cf-5d22-4ce3-8c62-733b3454a1fa"
replace HHID = 10796 if key == "uuid:db4573cf-5d22-4ce3-8c62-733b3454a1fa"

replace hhid = 292 if key == "uuid:91e4b651-660d-4e9f-b420-e133e1105383"
replace HHID = 292 if key == "uuid:91e4b651-660d-4e9f-b420-e133e1105383"

drop if key == "uuid:386e4ea9-d585-497f-ab87-8ab4ff345dab" & HHID == 31424

drop if key == "uuid:c7312290-47bf-4ad5-b28e-69b0282e75f2" & HHID == 32770

replace HHID = 39432 if key == "uuid:e351c299-0bd9-40d7-b2eb-67966117e988"
replace hhid = 39432 if key == "uuid:e351c299-0bd9-40d7-b2eb-67966117e988"

replace HHID = 39974 if key == "uuid:ef5a6d24-b5d0-4c91-9ce9-a3bd5cbb502a"
replace hhid = 39974 if key == "uuid:ef5a6d24-b5d0-4c91-9ce9-a3bd5cbb502a"


drop if HHID == 1194 & key == "uuid:59bd6025-16b1-4950-a879-b90d1819adf4"

replace HHID = 30654 if key == "uuid:c48fb60a-7ba9-48ed-b5b8-f99ab0c79b7c"
replace hhid = 30654 if key == "uuid:c48fb60a-7ba9-48ed-b5b8-f99ab0c79b7c"

drop if HHID == 31937 & key == "uuid:cf65218e-c983-4ddb-968b-d64df5de4d32"

replace HHID = 39108 if key == "uuid:66042087-c142-4eea-8f6f-4a77134c6d96"
replace hhid = 39108 if key == "uuid:66042087-c142-4eea-8f6f-4a77134c6d96"

drop if HHID == 39340 & key == "uuid:0e0eee9b-103c-437c-ae37-65611cf69395"

drop if HHID == 39584 & key == "uuid:e9f56d63-3298-46d0-b963-24435034091b"

drop if HHID == 39607 & key == "uuid:ba5c6b16-bc35-411e-a2ea-3a6f5372d4a4"

/*
replace HHID = if key == ""
replace hhid = if key == ""

replace HHID = if key == ""
replace hhid = if key == ""

replace HHID = if key == ""
replace hhid = if key == ""
*/
