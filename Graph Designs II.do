use "https://docs.google.com/uc?id=1IFhpDFeP4jon94KIgXpIheDnt9RLo6NR&export=download", clear
*Data source World Bank and UN

/* Getting straight to merging the files. Here I had a separate data for violent
crime by state and I mereged it with my orignal data, which looked at
impact of refugee settlement, GDP per capita, Expenditure on Students, net migration 
rate on happiness, Poverty rate by state, & violent crime .*/ 

/* I hypothesize that GDP per capita and violent rate are greatest predicter of 
happiness score. */


*Expenditure on Students
*https://www.governing.com/gov-data/education-data/state-education-spending-per-pupil-data.html
merge 1:1 State using "https://docs.google.com/uc?id=1IFhpDFeP4jon94KIgXpIheDnt9RLo6NR&export=download"
drop _merge

*Vote Turnout 2018 Retried: http://www.electproject.org/2018g
merge 1:1 State using "https://docs.google.com/uc?id=1oLXjr5aoQgZSAPm6FlqwmifGVgJ7HlNX&export=download"
drop _merge

*Population density by state 
/*Retrived: http://worldpopulationreview.com/states/state-densities */
merge 1:1 State using "https://docs.google.com/uc?id=1wTDKRYSzHTyZQ-a7IY_4CVzr8bReooIh&export=download"
drop _merge
/* In terms of not match It's District of Columbia that is there in some data while not in others. */

*Poverty rate by state
/*Retrived: https://www.census.gov/data/tables/time-series/demo/income-poverty/historical-poverty-people.html */
merge 1:1 State using "https://docs.google.com/uc?id=1U5jYi1cqyEDmlRjg2a-tLDR1ypzK7pwY&export=download"
/* This time mismatch is DC and United States. */
drop _merge

list


reshape long Poverty, i(State) j(year)

list Poverty year State
/*Reshape is now reflected in a longer way such that "poverty" has become 
an overarching catergory and it is consolidated into one column. */

reshape wide Poverty, i(State) j(year)
/*I didn't like the previous look so reshaped it back to the wider
shape , which had three columns.*/

edit
/*as you can there are three diffrent columns for poverty now by years. */


/*Here I've violent crime by city state. A one to many */

merge 1:m State using "https://docs.google.com/uc?id=1YmqTEmKvQ07FMcL0-TycMC8eGWyUF2xM&export=download"
drop _merge

/*It's District of Columbia and United States placed in there which is the
mismatch. */

twoway (scatter HappinessScore Violentcrime) if Violentcrime < 20000 || lfit HappinessScore Violentcrime


drop if State=="District Of Columbia"
drop if State=="District of Columbia"
graph bar (mean) HappinessScore if HappinessScore > 62, over(State)
* All happy state with a score above 62

 scatter HappinessScore GDPCapita || lfit  HappinessScore GDPCapita
 /* There is a strong uphill relationship between happiness and gdp capita. So 
 I suppose money does make people happy.*/
 
graph bar (mean) HappinessScore [pweight = HappinessScore] in 1/6, over(State)
 /* This is better which shows happiness in six states alabetically. But I'd
 like to show you top five happy states. */
 
scatter  CombinedSettledRefugee HappinessScore  || lfit  CombinedSettledRefugee HappinessScore
 /*There appears to be an uphill relationship between happiness and where the 
 refugee wind up being placed by the government.*/
