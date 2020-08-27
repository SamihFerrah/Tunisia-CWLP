********************************************************************************
********************************************************************************
*				TUNISIA IE ENTREPENEURSHIP CLEANING 						   *
********************************************************************************
********************************************************************************



********************************************************************************
********************************************************************************
* 1) PREPARE OUTCOMES AND RECODE SO THAT A HIGHER VALUE INDICATE A "POSITIVE" OUTCOMES
********************************************************************************
********************************************************************************
/* 	We want all outcomes to be coded in the same direction to avoid having 
	interpretation issue when analysis phases start
*/


********************************************************************************
********************************************************************************
* 2) TEST ANSWERS CONSISTENCY 
********************************************************************************
********************************************************************************
/* 	Checking for variable consistency means to check that answer makes sense based on
	other questions. If the survey is well constructed (constraints and requirement) this
	should not be an issue, but it’s always better to check.
	Example : Does the 12 years old respondents have children and is so how many ?
*/


********************************************************************************
********************************************************************************
* 3) IDENTIFY AND DOCUMENT OUTLIERS
********************************************************************************
********************************************************************************
/*	An outliers is an observations far away from the mean of the sample. For example,
	someone would report an age of 99 years old when the average is 20. There isn’t a rule
	to check for outliers, some will consider an outlier as an observations superior 
	to 2.2 times the absolut standard deviation, some 1.8. 
	As for the variable consistency, checkking for outliers depends on the construction 
	of the survey, and because of the constraints it makes sense to check only 
	for integer (no categorical variable) and unbounded one.
*/


********************************************************************************
********************************************************************************
* 4) CATEGORIZE VARIABLE LISTED AS OTHERS 
********************************************************************************
********************************************************************************
/*	For every variable with “other” as a choices, check what are the choices and 
	if one answer is frequently given create a new value for the variable, replace 
	it if “other” correspond to it and label the value accordingly.	
*/




********************************************************************************
********************************************************************************
* 5) EXPLORE VARIABLES WITH FEW VARIABLES  
********************************************************************************
********************************************************************************
/* 	Check for variation by summarizing variable and creating a list of variable with 
	a standard deviation below a certain threshold. This will give you an idea on which
	variable without variation (==`x’ to in 99% or so).
*/


********************************************************************************
********************************************************************************
* 4) TARGET NUMBERS 
********************************************************************************
********************************************************************************
/*	Test for target number: since surveys are submitted in daily waves, keep track of the 
	numbers of surveys submitted and the target number of surveys needed for an area to be
	completed.
*/





********************************************************************************
********************************************************************************
* 5) EXPORT DAILY FIELD REPORT FOR FIELD TEAM TO CORRECT FOR ISSUE
********************************************************************************
********************************************************************************


