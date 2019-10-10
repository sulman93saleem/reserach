/* Sulman Saleem
PS 2
Dr. Adam OK
Stata Version 13 */
version 13

use "https://docs.google.com/uc?id=1IFhpDFeP4jon94KIgXpIheDnt9RLo6NR&export=download", clear
/* Preamble: This is a data set on violent crime by state for 2017 in this United 
States. My aim is to study happiness and I want to do that by looking at the 
impact of crime on happiness at state level. In addtion to that I'll by looking 
at the impact of refugee settlement, GDP per capita, and net migration rate. */

/* Getting straight to merging the files. Here I had a separate data for violent
crime by state and I mereged it with my orignal data, which looked at
impact of refugee settlement, GDP per capita, and net migration rate on happiness.*/ 
merge 1:1 State using "https://docs.google.com/uc?id=1lL63CDkYpki4sD9UUEqJCuX0ixRBbOZA&export=download"
 
 /* I got the data for violent crime from here: 
 https://www.worldatlas.com/articles/the-most-dangerous-states-in-the-u-s.html */
 
 
 list
/* Here you the combined data from the merged comand listed here. */ 

*Too long of a name.
rename ViolentCrimeRatePer100000In ViolentCrimeRate


/* I like classify anything lower than 300 in terms of ViolentCrimeRate
as 0(low crime) & anything above 299 as 1(high crime). */

generate SeverityCrime=.
replace SeverityCrime=0 if ViolentCrimeRate >400
replace SeverityCrime=1 if ViolentCrimeRate <399
label data "0 =>300 & 1=<299"

/*Now I want to know average happiness index of those states that are lower 
than 300 in terms of ViolentCrimeRate as 0(low crime) & anything above 299 as 
1(high crime)*/

bysort SeverityCrime: egen meanhappiness=mean(HappinessScore)
label variable meanhappiness "avg happiness indx of those states that less violent and more violent"

/* According to the result less violent states tend to have happiness index of
47.97 and less expericing state tend to have a happiness index of 52.729. In other
words if a state expereinces less violent crime it is more happy. Note higher
the score happier the state. */ 


/* Genrating variable and then dropping it. */
gen test1=.
gen test2=.
drop test1 
drop test2

generate meanhapmig=.
replace meanhapmig=0 if NetMigrationRate >0
replace meanhapmig=1 if NetMigrationRate <0

/* Created a variable. If migration rate is above 0 it will will be 1.If migration
rate is below 0 it will be code 0. */

/* I want to know what is happiness score for state that are expereincing 
immigration and emigration. Any thing that is below is 0 is consider emigration
and anything that above 0 is a state experiencing immigration.*/
bysort meanhapmig: egen EmigImigHapp=mean(HappinessScore)
/*Based on the results it appears migration doesn't have much to do with whether
a state is happier or not. For instance, state that are experiencing emigration
has a happiness index of 51.2 while those that experincing immigration has a 
happiness index of 50.3. Surprisingly there isn't much of diffrence in terms
happiness among the state that expereincing immigration and emigration. In other
words there happiness is about the same as diffrence is merely a point.*/


/* All my region variables are string so first I'll destring them into numeric
then I'll recode them from 1-4 respectively. */
encode Region, gen(numRegion)
tab numRegion
recode numRegion (4/1 = 4), gen(typeRegion)
*Looks like they have been successfully recoded from 1-4 regionally. 

recode CombinedSettledRefugee (.=0), gen(newVar)
/*Here I'm fundementally telling stata to turn any value that is =. to make it 0.
*/

collapse (mean) avgphappiness=HappinessScore (mean)avgmigration=NetMigrationRate , by(Region)
edit
/* Here we see regional happiness and average migration rate. For instance 
based on the result we see that north is the happiest region with the highest
immigration 
