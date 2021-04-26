
local gender_role_index 	z_gender_role x1_mghome x1_mgkids x1_mgdecisions x1_mgrights1 x1_mgleader1 x1_mgleader2 	///
							x1_mgschlwork x1_mgill x1_mgopinion x1_mgpity x1_mgwork x1_mgedu 						///
							x1_mgdomestic x1_mgobey x1_mgspeak x1_mgcapacity x1_eduopp x1_boysfood 					///
							x1_coupledu x1_leader3 x1_mgrights2 x1_mgequality x1_mgfriends 							///
							x1_mgfreetime_men x1_mg_freetime_women x1_mg_womenopi x1_mg_marry 						///
							x1_participation x1_leader4 x1_leader5 x9_daughwork
					
local abilities_index		z_abilities x1_leader6_1 x1_leader6_2 x1_leader6_3 x1_leader6_4 x1_leader6_5 				///
							x1_leader6_6 x1_leader6_7 x1_leader6_8 x1_leader6_9 x1_leader6_10
					
local views_index			z_views x2_hwtolerate x2_goesout x2_refuseshave x2_neglectsif x2_burnsf 					///
							x2_arguesshe x2_refusescook x2_doesinfid x2_contraceptive x2_drinksalcohol				///
							x2_refusesclean x2_dowry
					
local reproductive_index	z_reproductive x6_sxmore x6_sxtalk x6_sxready x6_gay x6_friend x8_pregn x8_contra 		///
							x8_suggcontr x8_childresp x8_fatherchild x8_childdeci x8_contratype
					
local bargaining_index 		z_bargaining x9_1 x9_2 x9_3 x9_4 x9_5 x9_6 x9_7 x9_largepurchase x9_dailypurchase 		///
							x9_wifepersonal x9_borrow x9_lend x9_occupation x9_workplace x9_workhours 				///
							x9_participation x9_moneycontrol 
					
local communication_index 	z_communication x9_103 x9_104 x9_105 x9_106 x9_107 x9_108 x9_109		// Removed because not asked to anyone  x9_101 x9_102


u "$vera/clean/clean_analysis_CashXFollow.dta", clear

keep if tot_complete == 1

label var z_gender_role 	"Men views on gender role"
label var z_abilities 		"Men views on woman ability"
label var z_views 			"Men views on GBV"
label var z_reproductive 	"Men views on reproductive health"
label var z_bargaining      "Men views on intra household bargaining"
label var z_communication 	"Quality of communication"

cap file close Table
file open Table using "$git_tunisia/outputs/Second round/Partner/partner_trt_effect.tex", text write replace


********************************************************************************
* MAIN INDEX TABLES
********************************************************************************

* Create table 

local i = 1 

foreach var in gender_role abilities views reproductive bargaining communication{
	
	sum z_`var' if trt_cash_part_1 == 0
	
	local m`i' :di%12.3f `r(mean)'
	local s`i' :di%12.3f `r(sd)'
	
	reg z_`var' trt_cash_part_1, robust 
	
	local c`i'  : di%12.3f  _b[trt_cash_part_1]
	local se`i' : di%12.3f _se[trt_cash_part_1]
	local n = e(N)
	
	* Compute p-value
	
	local p`i' = ttail(e(df_r),abs(_b[trt_cash_part_1]/_se[trt_cash_part_1]))*2
	
	* Format local 
	local p`i' : di%12.3f `p`i''
	local se`i' = trim("`se`i''")
	local se`i' 	   "(`se`i'')"
	local se`i' = trim("`se`i''")
				
	local st`i' ""
			
	* Add stars
	if `p`i'' < 0.1{
		local st`i' "*"
	}
	if `p`i'' < 0.05{
		local st`i' "**"
	}
	if `p`i'' < 0.01{
		local st`i' "***"
	}
	
	local l_var : variable label z_`var'
	
	* Write table
	
	file write Table 														_n ///
	"`l_var' 	& `m`i'' 	& `s`i'' & `c`i'' `st`i''	& `p`i'' & `n' \\"	_n ///
	"			&			&		 &	`se`i''			&		 &	   \\"  _n
	
	local i = `i' + 1
}

file close Table


********************************************************************************
* Detailled tables regression
********************************************************************************

foreach group in gender_role_index abilities_index views_index reproductive_index bargaining_index communication_index{
	
cap file close Table
file open Table using "$git_tunisia/outputs/Second round/Partner/partner_trt_effect_`group'.tex", text write replace

* Create table 

local i = 1 

foreach var of local `group'{
	
	sum `var' if trt_cash_part_1 == 0
	
	local m`i' :di%12.3f `r(mean)'
	local s`i' :di%12.3f `r(sd)'
	
	reg `var' trt_cash_part_1, robust 
	
	local c`i'  : di%12.3f  _b[trt_cash_part_1]
	local se`i' : di%12.3f _se[trt_cash_part_1]
	local n = e(N)
	
	* Compute p-value
	
	local p`i' = ttail(e(df_r),abs(_b[trt_cash_part_1]/_se[trt_cash_part_1]))*2
	
	* Format local 
	local p`i' : di%12.3f `p`i''
	local se`i' = trim("`se`i''")
	local se`i' 	   "(`se`i'')"
	local se`i' = trim("`se`i''")
				
	local st`i' ""
			
	* Add stars
	if `p`i'' < 0.1{
		local st`i' "*"
	}
	if `p`i'' < 0.05{
		local st`i' "**"
	}
	if `p`i'' < 0.01{
		local st`i' "***"
	}
	
	local l_var : variable label `var'
	
	* Write table
	
	file write Table 														_n ///
	"`l_var' 	& `m`i'' 	& `s`i'' & `c`i'' `st`i''	& `p`i'' & `n' \\"	_n ///
	"			&			&		 &	`se`i''			&		 &	   \\"  _n
	
	local i = `i' + 1
}

file close Table

}