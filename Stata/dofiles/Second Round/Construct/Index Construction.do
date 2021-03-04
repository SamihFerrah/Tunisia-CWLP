********************************************************************************
*				REPLICATION INDEX TUNISIA CWLP 								   *
********************************************************************************
********************************************************************************

********************************************************************************
********************************************************************************
* 0) DEFINE LOCAL USED TO BUILD INDEX 
********************************************************************************
********************************************************************************
pause on 

* Define sub index local

* Define local with all index

local Index_ALL 
							
********************************************************************************
********************************************************************************
* 1) Prepare data (flip sign and stuff)
********************************************************************************
********************************************************************************
u "$vera/temp/clean_CashXFollow_PII_imputed.dta", clear

foreach sample in followup cash{												// Loop over different dataset 


	if "`sample'" == "followup"{
		local trt_indicator		"beneficiaire"
		local cond			   `"Intervention == "Follow up - TCLP""'			// Empty for now but might be useful later for the heterogeneity
		local spec_prefix 		"FL"
	}

	if "`sample'" == "followup"{
		local trt_indicator "trt_cash"
		local cond			`"Intervention == "Cash Grants - Women""'			// Empty for now but might be useful later for the heterogeneity
		local spec_prefix	"CGW"
	}

/* Apply special character for missing variables 

foreach var of varlist _all{

capture confirm numeric variable `var'
	if _rc == 0{
	cap replace `var' =.d if `var' == -98
	cap replace `var' =.a if `var' == -98
	cap replace `var' =.n if `var' == -99
	}

} */ 

********************************************************************************
********************************************************************************
* 1) STANDARDIZE EVERY INDIVIDUAL OUTCOMES AGAINST RELEVANT CONTROL GROUP
********************************************************************************
********************************************************************************
	
	**********************************
	**********************************
	
	* Loop over every outcomes group
	
	foreach group_outcomes of local Index_ALL{
				
		* Create local used to store variable name to sum later 
		di in red "`group_outcomes'"
		
		local sum_`group_outcomes' 		 ""
		local var_num_`group_outcomes' = 0
		
		* Loop over every individual outcomes
		
		foreach indiv_outcomes of local `group_outcomes'{
		
			* Create control mean of individual outcomes
			
			sum `indiv_outcomes'_`var_suffix' 					if `trt_indicator' == 0 & `cond'
			
			
			gen mean_`indiv_outcomes' = `r(mean)'				if `cond' 
			
			* Create control standard deviaiton 
			
			sum `indiv_outcomes'_`var_suffix' 					if `trt_indicator' == 0 & `cond' 
			
			gen sd_`indiv_outcomes' = `r(sd)' 					if `cond' 
		
			* Normalize individual outcome 
			
			gen norm_`indiv_outcomes' = (`indiv_outcomes'_`var_suffix' - mean_`indiv_outcomes') / sd_`indiv_outcomes' if `cond'
			
			* Fill local with variable name used later to sum all standardize outcomes
			
			local sum_`group_outcomes' "`sum_`group_outcomes'' norm_`indiv_outcomes'"
			
			* Fill local with variable counter 
			
			local var_num_`group_outcomes' = `var_num_`group_outcomes'' + 1
	
		}
		
		* Sum all standardize variable of relevant outcome group
		
		egen `spec_prefix'`group_outcomes' = rowtotal(`sum_`group_outcomes'') if `cond', missing 
		
		* Divide by the number of variable in outcomes group_outcomes
		
		replace `spec_prefix'`group_outcomes' = (`spec_prefix'`group_outcomes'/`var_num_`group_outcomes'') if `cond'
		* Standardize index 
		
		sum `spec_prefix'`group_outcomes'
		
		replace `spec_prefix'`group_outcomes' = `spec_prefix'`group_outcomes' / `r(sd)'  if `cond' 
		
		* Clean variables created
		
		drop mean_*
		drop sd_*
		drop norm_*
	
	}
	
	* Label index 

	cap label variable `spec_prefix'home_assets				"Home assets"
	cap label variable `spec_prefix'comms_assets			"Communication assets"
	cap label variable `spec_prefix'productive_assets		"Productive assets"
	cap label variable `spec_prefix'consumption_food		"Food consumtion"
	cap label variable `spec_prefix'consumption_other		"Other consumption"
	cap label variable `spec_prefix'lab_market_main			"Labor market"
	*cap label variable `spec_prefix'lab_market_sec			"Labor market (other HH members)"
	cap label variable `spec_prefix'eco_welfare				"Consumption expenditures"
	cap label variable `spec_prefix'assets					"Assets owning"
	cap label variable `spec_prefix'credit_access			"Financial inclusion"
	cap label variable `spec_prefix'pos_coping_mechanisms	"Positive coping mechanisms"
	cap label variable `spec_prefix'neg_coping_mechanisms	"Negative coping mechanisms"
	cap label variable `spec_prefix'social 					"Social participation"
	cap label variable `spec_prefix'civic					"Civic engagement"
	cap label variable `spec_prefix'well_being				"Psychological well being"
	cap label variable `spec_prefix'woman_empowerment		"Women's empowerment"
	cap label variable `spec_prefix'woman_bargain			"Women's empowerment and agency"
	cap label variable `spec_prefix'woman_violence			"Intimate partner violence"
	cap label variable `spec_prefix'shocks					"Economic shock"
	cap label variable `spec_prefix'social_cohesion2 		"Social Cohesion"
	cap label variable `spec_prefix'comm_groups 			"Community Groups"
	cap label variable `spec_prefix'civic_engag 			"Civic Engagement"
	cap label variable `spec_prefix'initiatives 			"Local Participation"
	cap label variable `spec_prefix'initiatives_meeting 	"Local Meeting"
	cap label variable `spec_prefix'initiatives_acting		"Local Acting"
	cap label variable `spec_prefix'information_sources 	"Information Sources"
	cap label variable `spec_prefix'utopia 					"Liberal Norms"
	cap label variable `spec_prefix'isolation 				"Isolation"	


save "$vera/clean/clean_analysis_CashXFollow.dta"", replace

