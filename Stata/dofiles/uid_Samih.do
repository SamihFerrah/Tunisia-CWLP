*replace existing instancename?
*concat('HHID_ ', ${imada},${PSU},${hh_id})

*create new unique id instancename// current one is not unique, + needs modifs after modifs to vars used for concatenation
*WAIT UNTIL IDS ARE REDISTRIBUTED!
gen uid_instancename="HHID_" + "00" + string(imada) + "00" + string(psu) + "00"+ string(hh_id)

*explore duplicates
duplicates report uid* //0
