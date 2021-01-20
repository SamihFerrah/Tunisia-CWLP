u "$home/14. Female Entrepreneurship Add on/Data/Second Round/cleandata/clean_CashXFollow_noPII.dta", clear

drop if tot_complete == 0 

merge m:1 HHID using "$home/14. Female Entrepreneurship Add on/Survey material/Assignment/Full Sample.dta", keepusing(Status Intervention trt_followup) gen(merge2)

g 		surveyed = 1 if merge2 == 3
replace surveyed = 0 if merge2 == 2

bys Status Intervention: tab surveyed

tab surveyed if Status == "Follow Up" & replacement == 0
tab surveyed if Status == "Follow Up" & replacement == 1