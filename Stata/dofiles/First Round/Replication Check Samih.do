********************************************************************************
*							REPLICATION CHECK SAMIH 						   *
********************************************************************************
/*

Before chaning table formatting check that running the analysis do-files 
return (and output) the same tables as the one exported and use to write endline
report.

Methodlogy:
	1) Export all tables in a new folder, not replacing previous one 
	2) Import each newly exported tables and tempfile as tempdata
	3) Import each previously exported tables and tempfile as tempdata 
	4) Merge previous and newly on every variable (ranging from A to ??)
	5) Assert that cells content is the same in every tables 
*/

********************************************************************************
* 0) Define local with tables' name to test 
********************************************************************************
#delimit ;
local table_name "0Index_Analysis 1Food_Consumption 2Expenditure 3Coping_Mechanisms
				  4Assets 5Human_Capital 6Employment 7Saving 8Social_Cohesion
				  9Civic_Engagement 10Psych_Wellbeing 11Intrahh 12violence_ag_women" ;

#delimit cr

********************************************************************************
* 1) Export all tables in a new fodler
********************************************************************************

	global report "$dropbox/Resultats_Samih"									// Export tables here 

	* qui do "$do/Analysis"														// Run analysis do-file 

quietly{
********************************************************************************
* 2) Import each newly exported tables and tempfile 
********************************************************************************

foreach table_exported of local table_name{

	import delimited using "$dropbox/Resultats_Samih/`table_exported'.csv", clear

	// Rename variable and add suffix "_replication"
	rename * *_replication 
		
	// Generate merge id == line number 
	g id_merge = _n 
		
	tempfile replication 
	sa      `replication'
	
********************************************************************************
* 3) Import each previously exported tables and tempfile 
********************************************************************************

	cd "$dropbox/Resultats"
	local counter_file = 0 

	import delimited using "$dropbox/Resultats/`table_exported'.csv", clear

	// Rename variable and add suffix "_replication"
	rename * *_original 
		
	// Generate merge id == line number 
	g id_merge = _n 
		
	tempfile original
	sa      `original'
	
********************************************************************************
* 4) Merge previous and newly on every variable (ranging from A to ??)
********************************************************************************
	
	u `replication', clear 
	merge 1:1 id_merge using `original' 
		
	// 1) First Check --> Only Merge == 3 
		
	cap assert _merge == 3 
		if _rc ==0{
			di in red "Merge: Success"
		}
		if _rc !=0{
			di in red "Merge: Fail"
			pause
		}
			
	drop   _merge 

	capture : assert v1_replication == v1_original
		if _rc ==0{
			noisily di in red "Replication: Success for table `table_exported'"
		}
		if _rc !=0{
			noisily di in red "Replication: Fail for table `table_exported'"
			pause
		}

}		
}		
	
		
	


	
		
