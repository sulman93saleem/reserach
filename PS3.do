/*Sulman Saleem
Dr. Adam OK
PS3
Data Management */
*Version 13

/* Preamble: This is a data set on violent crime by state for 2017 in this United 
States. My aim is to study happiness and I want to do that by looking at the 
impact of crime on happiness at state level. In addtion to that I'll by looking 
at the impact of refugee settlement, GDP per capita, and net migration rate. */

use "https://docs.google.com/uc?id=1IFhpDFeP4jon94KIgXpIheDnt9RLo6NR&export=download", clear

/* Getting straight to merging the files. Here I had a separate data for violent
crime by state and I mereged it with my orignal data, which looked at
impact of refugee settlement, GDP per capita, and net migration rate on happiness.*/ 
merge 1:1 State using "https://docs.google.com/uc?id=1lL63CDkYpki4sD9UUEqJCuX0ixRBbOZA&export=download"

drop _merge


*Expenditure on Students
merge 1:1 State using "https://docs.google.com/uc?id=16CP1qhz9XPBq9el2WNlVv27tILJbBKvV&export=download"
drop _merge

*Population density by state 
/*Retrived: http://worldpopulationreview.com/states/state-densities */
merge 1:1 State using "https://docs.google.com/uc?id=1wTDKRYSzHTyZQ-a7IY_4CVzr8bReooIh&export=download"
drop _merge

*Poverty rate by state
/*Retrived: https://www.census.gov/data/tables/time-series/demo/income-poverty/historical-poverty-people.html */
merge 1:1 State using "https://docs.google.com/uc?id=1U5jYi1cqyEDmlRjg2a-tLDR1ypzK7pwY&export=download"
drop _merge

list


reshape long Poverty, i(State) j(year)

list Poverty year State
/*Reshape is now reflected in a longer way such that "poverty" has become 
an overarching catergory and it is consolidated into one column.  */

reshape wide Poverty, i(State) j(year)
/*I didn't like the previous look so reshaped it back to the wider
shape , which had three columns.*/

edit
/*as you can there are three diffrent columns for poverty now by years. /*



