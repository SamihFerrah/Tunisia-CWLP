
*JE VEUX VOIR AUSSI LE % DE "JE NE VEUX PAS RÉPONDRE ET JE NE SAIS PAS". 
*MAYBE. I SAW THEY ARE FEW. THEN, LETS JUST LOOK AT THE OBSERVATIONS.


***COMMAND FOR COMPARING MEANS FOR TWO ARMS***	
	
cap program drop balance
program define balance
args variable variablename myfile condTC
 
*INTRODUCTION
		
	file write myfile "<tr><td>`variable'</td><td>`variablename'"
	
*TREATMENT VS CONTROL

	*Number of observations
	qui sum `variable'
	local resN=string(`r(N)')
	
	*Survey set-up
	svyset imada /*, fpc(_n)*/

	*Control mean and standard deviation
	qui svy: mean `variable' if `condTC'==0
	mat def X=r(table)
	local resC=string(X[1,1],"%9.3f")
	local resSDC=string(X[2,1],"%9.3f")
	
	*Treatment mean and standard deviation
	qui svy: mean `variable' if `condTC'==1
	mat def X=r(table)
	local resT=string(X[1,1],"%9.3f")
	local resSDT=string(X[2,1],"%9.3f")
	
	*Difference of means between control and treatment
	local diff=`resC'-`resT'
	local diffCT=string(`diff',"%9.3f")
	
	*Reset results variables
	local pv=.
	local stat=.
	
	*Check if variable is dummy
/*	qui distinct `variable'
	
	*Hypothesis testing for dummy variable
	if r(ndistinct)==2 {
		qui sum `variable'
		if r(min)==0 {
			if r(max)==1 {
			qui ttest `variable', by(`condTC') 
			local pv=2*(1-normal(abs(`r(z)')))
			local stat=`r(z)'
			}
		}
	}
	if r(ndistinct)==1 {
		qui sum `variable'
		if r(min)==0 {
			qui ttest `variable', by(`condTC')
			local pv=2*(1-normal(abs(`r(z)')))
			local stat=`r(z)'	
		}
		if r(min)==1 {
			qui prtest `variable' if, by(`condTC')
			local pv=2*(1-normal(abs(`r(z)')))
			local stat=`r(z)'
		}
	}
	

	*Hypothesis testing for non-binary variable (MEAN)
	else {
		qui clttest `variable', by(`condTC') cluster(imada)
		local pv=`r(p)'
		local stat=`r(t)'
	}
/*
	*Meaningful results
	local sig=""
	local tdprefix=""
	
	if `pv' <= 0.1 {
		local sig="*"
		local tdprefix=" style='background:yellow'"
	}	
	if `pv' <= 0.05 {
		local sig="**"
		local tdprefix=" style='background:yellow'"
	}
	if `pv' <= 0.001 {
		local sig="***"
		local tdprefix=" style='background:yellow'"
	}
	local resP=string(`pv',"%9.3f")
	local resstat=string(`stat',"%9.3f")
*/
*/	
	*Hypothesis testing for non-binary variable (DISTRIBUTION)

	/*if inlist(`variable',hhsize,jeunes_lireecrire,handicap,calcul_2,chomage_win,reserv_wage,reserv_wag, ///
		rev_total,rev_total_win,h_per_day,h_per_day_win,f2_val_2,f2_val_2_win,c3_a_1,c3_b_1,c3_a_4,c3_b_4, ///
		c3_a_6,c3_b_6,c3_a_11,c3_b_11,c4,pain,pain_win,legumes,legumes_win,tabac,tabac_win,c13,c13_win,c6, ///
		c6_win,c15,c15_win,migration_q5,migration_q5_win,migration_cm_q5,migration_cm_q5_win,sante_hopital,sante_hopital_win) {*/
	
		
	qui distinct `variable'
	if r(ndistinct)>=2 { //ARBITRARY
	
		qui clttest `variable', by(`condTC') cluster(imada)
			local pv=`r(p)'
			local stat=`r(t)'
			
			
		*Meaningful results
	local sig=""
	local tdprefix=""
	
	if `pv' <= 0.1 {
		local sig="*"
		local tdprefix=" style='background:yellow'"
	}	
	if `pv' <= 0.05 {
		local sig="**"
		local tdprefix=" style='background:yellow'"
	}
	if `pv' <= 0.001 {
		local sig="***"
		local tdprefix=" style='background:yellow'"
	}
	local resP=string(`pv',"%9.3f")
	local resstat=string(`stat',"%9.3f")
	
/*		
		qui ksmirnov `variable', by(`condTC')
			local pv2=`r(p)'
			local stat2=`r(D)'

		*Meaningful results		
		if `pv2' <= 0.1 {
			local sig2="*"
			local tdprefix2=" style='background:yellow'"
		}	
		if `pv2' <= 0.05 {
			local sig2="**"
			local tdprefix2=" style='background:yellow'"
		}
		if `pv2' <= 0.001 {
			local sig2="***"
			local tdprefix2=" style='background:yellow'"
		}
		local resP2=string(`pv2',"%9.3f")
		local resstat2=string(`stat2',"%9.3f")
		
*/
	}
		
*	file write myfile "</td><td>`resN'</td><td>`resC'</td><td>`resT'</td><td>`diffCT'`sig'</td><td>`resstat'</td><td`tdprefix'>`resP'</td><td>`resstat2'</td><td`tdprefix2'>`resP2'"
	file write myfile "</td><td>`resN'</td><td>`resC'</td><td>`resT'</td><td>`diffCT'`sig'</td><td>`resstat'</td><td`tdprefix'>`resP'"
	local pv2=""
	local stat2=""
	local sig2=""
	local tdprefix2=""
	local resP2=""
	local resstat2=""
		
	file write myfile "</td></tr>" _n
end	


	*****


