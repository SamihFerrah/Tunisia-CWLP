********************************************************************************
********************************************************************************
*				SUMMARY STATISTICS  TUNISIA CWLP 							   *
********************************************************************************
********************************************************************************
cd "$git_tunisia/outputs/Main/"
pause on 
clear 
********************************************************************************
********************************************************************************
* 0) DEFINE LOCAL USED TO BUILD INDEX 
********************************************************************************
********************************************************************************


local lab_market_main 	 		emploi_main days_work_main hours_work_main inc_work_main profit_work_main								///
								business_q0_main business_q3_main business_q5_main
								
/*local lab_market_sec 	 		emploi_sec days_work_sec hours_work_sec inc_work_sec 													///
								profit_work_sec business_q0_sec business_q3_sec business_q5_sec*/
							
local eco_welfare 				c3_a_1_win5 c3_a_2_win5 c3_a_3_win5 c3_a_4_win5 c3_a_5_win5 c3_a_6_win5 c3_a_7_win5 					///
								c3_a_8_win5 c3_a_9_win5 c3_a_10_win5 c3_a_11_win5 c4_win5 c5_win5 c6_win5 								///
								c7_win5 c8_win5 c9_win5 c11_win5 c12_win5 c13_win5 c14_win5 c16_win5 c18_win5 

local assets					q2_1_2_win5 q2_1_3_win5 q2_1_4_win5 q2_1_5_win5 q2_1_6_win5 q2_1_7_win5 q2_1_8_win5 					///
								q2_1_9_win5 q2_1_10_win5 q2_1_11_win5 q2_1_12_win5 q2_1_13_win5 q2_1_14_win5 							///
								q2_1_15_win5 q2_1_16_win5 q2_1_17_win5 q2_1_18_win q2_1_19_win5 										///
								q2_1_20_win5 q2_1_21_win5 q2_1_22_win5 

local credit_access				epargne_dette epargne_dette_cb_win5 epargne epargne_cb epargne_pret											


local pos_coping_mechanisms		g2_3 g2_4 g2_5 g2_6  g2_8 g2_9 g2_10 g2_11 g2_12 

local neg_coping_mechanisms		g2_1 g2_2 g2_7 g2_13 g2_14 g2_15	


local shocks					g1_1 g1_2 g1_3 g1_4 g1_5 g1_6 g1_7 g1_8 g1_9


* comite_c comite_c_menage comite_cbis comite_c_menagebis association_dummy  migration_cm_q1 migration_q1

local social				association_1 association_2 initiatives_9 association_9											///
							association_3 association_4 association_6 /*association_7 association_8*/  
							
							
local civic					initiatives_1 initiatives_2 initiatives_3 initiatives_4 initiatives_5 initiatives_6 			///
							initiatives_7 initiatives_8  initiatives_10 initiatives_11 										///
							initiatives_12 initiatives_13 initiatives_14 initiatives_15									

							

local well_being 			psy_anxiete psy_exploit psy_depress5 /*psy_accepte_dum1*/ psy_accepte_dum3 						///
							psy_menage_dum3 /*psy_a_menage_dum1*/ psy_a_menage_dum3	 										///
							psycho_depress4 psycho_depress3 psycho_depress2 psycho_depress1


local woman_empowerment		violence_1_2 violence_1_3 violence_1_4 violence_1_5 violence_1_6 								///
							violence_1_7 violence_1_8 violence_1_9 violence_1_10 violence_1_11 								///
							violence_1_16 violence_1_17 violence_1_18 intrahh_1 intrahh_2 intrahh_7 intrahh_11 emploiw association_2


local Index_ALL 			lab_market_main /*lab_market_sec*/ eco_welfare assets credit_access pos_coping_mechanisms neg_coping_mechanisms	///
							shocks social civic well_being woman_empowerment
	
	
							
********************************************************************************
********************************************************************************
* 1) Summary Statistics 
********************************************************************************
********************************************************************************
use "$stata/enquete_All3", clear 


foreach specification in between within spillovers{								// Loop over every specification (control group differ between those)

	* Define local specific to specification
	
	if "`specification'" == "between"{
	local prg_condition = "between"
	local trt_indicator = "beneficiaire"
	local spec_prefix 	= "IAaS"
	local var_prefix 	= "b"
	}
	
	if "`specification'" == "within"{
	local prg_condition = "within"
	local trt_indicator = "program"
	local spec_prefix 	= "IBaS"
	local var_prefix 	= "w"
	}
	
	if "`specification'" == "spillovers"{
	local prg_condition = "spillovers"
	local trt_indicator = "beneficiaire"
	local spec_prefix 	= "ICbS"
	local var_prefix 	= "s"
	}
	
	* Set excel file 
	putexcel set "Summary Statistics.xlsx", sheet("`specification'", replace) modify

	* Set column names 
	putexcel A1 = ""
	putexcel B1 = "Min"
	putexcel C1 = "Max"
	putexcel D1 = "Mean"
	putexcel E1 = "St. Dev."
	putexcel F1 = "Obs"
		

	* Loop over every index 
	local counter_index = 2

	foreach index in `Index_ALL'{
		
		local l_`index' : variable label IAaS`index'
		
		putexcel A`counter_index' = "`l_`index'' index"
		
		sum `spec_prefix'`index' if `prg_condition' == 1
			
			local min 	: di%12.3f `r(min)'
			local max 	: di%12.3f `r(max)'
			local mean 	: di%12.3f `r(mean)'
			local sd 	: di%12.3f `r(sd)'
			
			putexcel B`counter_index' = "`min'"
			putexcel C`counter_index' = "`max'"
			putexcel D`counter_index' = "`mean'"
			putexcel E`counter_index' = "`sd'"
			putexcel F`counter_index' = "`r(N)'"
			
		local counter_indiv = `counter_index' + 1
		
		foreach individual_outcome of local `index' {
			
			local l_`indiv' : variable label `individual_outcome'
			 
			putexcel A`counter_indiv' = "`l_`indiv''"
		
			sum `individual_outcome'_`var_prefix' if `prg_condition' == 1
			
				local min 	: di%12.3f `r(min)'
				local max 	: di%12.3f `r(max)'
				local mean 	: di%12.3f `r(mean)'
				local sd 	: di%12.3f `r(sd)'
				
				putexcel B`counter_indiv' = "`min'"
				putexcel C`counter_indiv' = "`max'"
				putexcel D`counter_indiv' = "`mean'"
				putexcel E`counter_indiv' = "`sd'"
				putexcel F`counter_indiv' = "`r(N)'"
				
			local counter_indiv = `counter_indiv' + 1
					
		}
			
		local counter_index = `counter_indiv' + 1 
	}	
}
