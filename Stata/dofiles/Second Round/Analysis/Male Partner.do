u "$vera/clean/clean_analysis_CashXFollow.dta", clear

keep if tot_complete == 1 & Intervention == "Cash Grants - Partenaire"

label var z_gender_role 	"Men views on gender role"
label var z_abilities 		"Men views on woman ability"
label var z_views 			"Men views on GBV"
label var z_reproductive 	"Men views on reproductive health"
label var z_bargaining      "Men views on intra household bargaining"
label var z_communication 	"Quality of communication"

cap file close Table
file open Table using "$git_tunisia/outputs/Second round/Partner/partner_trt_effect.tex", text write replace

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