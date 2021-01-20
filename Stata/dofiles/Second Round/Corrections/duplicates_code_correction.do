********************************************************************************
********************************************************************************
* 					DUPLICATES IN CODE CORRECTION
********************************************************************************
********************************************************************************

* Add correction or drop survey to resolve for duplicates based on Samir's comment from field


* Added 7th January - the survey of Ebdelli is the correct one; 
*The survey of HADDAS S was conducted under the wrong ID ( the coorect ID = 31066 for BESMA RAHMOUNI

replace hhid = 31066 if hhid == 39208 & key == "uuid:0e20c22a-c0d3-4b0b-b745-70bc37b45740"