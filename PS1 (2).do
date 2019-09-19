/*SULMAN SALEEM*/

use "https://docs.google.com/uc?id=1IFhpDFeP4jon94KIgXpIheDnt9RLo6NR&export=download", clear

save states.dta,replace

/*Prior to importing the file I had bit of difficulty as the data needed to be
destring. So I went through the entire file destring it one by one on excel. */
des
/* To give you an overview description of the database. */
list
/* This is to show you what variables are in the database.*/
sum
/* So you will see five variable: state, happiness score, combined refugee 
settlement per state and gdp per captia for the year 2018. Indeed state does
not have any observation as they merely name of the states. */


sum HappinessScore
/* "In order to determine the happiest states in America, WalletHub compared the
50 states across three key dimensions: 1) Emotional & Physical Well-Being, 2) 
Work Environment and 3) Community & Environment. We evaluated those dimensions 
using 31 relevant metrics, which are listed below with their corresponding 
weights. Each metric was graded on a 100-point scale, with a score of 100 
representing maximum happiness. Finally, we determined each state’s weighted 
average across all metrics to calculate its overall score and used the resulting
 scores to rank-order our sample." 
 Source: https://wallethub.com/edu/happiest-states/6959/#methodology
 So what you see here is happiness meanscore of nearly 50 and with min of 33 and
 max of 66.
 */

 sum GDPCapita
 /* Here you see 50 observation or 50 states with me mean GDP per capita of 
 about 48k and lowest capita of about 31k and per capita of 65k. */
 
 graph bar (mean) HappinessScore [pweight = HappinessScore], over(State)
 /* Here we see the happiness graphed by state. Sadly we can't see the name 
 of the states very clearly. I tried to limit it to top 5 but had difficulty.*/
 
 graph bar (mean) HappinessScore [pweight = HappinessScore] in 1/6, over(State)
 /* This is better which shows happiness in six states alabetically. But I'd
 like to show you top five happy states. */
 
 scatter HappinessScore NetMigrationRate || lfit  HappinessScore NetMigrationRate
 /* There appears to be a rather weak relationship between happiness and migration 
 however I can't say it conclusively from visual.  So I'll run correlation test. */
 
 pwcorr HappinessScore NetMigrationRate , star(.05)
 /* Yeah there appears to be a weak correlation between migration of people
 and happiness at .05. */
 
 scatter HappinessScore GDPCapita || lfit  HappinessScore GDPCapita
 /* There is a strong uphill relationship between happiness and gdp capita. So 
 I suppose money does make people happy.*/
 
 reg HappinessScore GDPCapita
 /* This is a regression result which suggest that there is strong relationship
 between GDPCapita and Happiness as the p-value is 0.001 and both the upper and
 lower 95% confidence interncal are same sign positive suggesting a strong relationship
 between the two variable. However, r-squared is only able to explain 20% of the 
 variation." */
 
 pwcorr  CombinedSettledRefugee HappinessScore , star (.05)
 /*There appears to be strong correlation between happiness and where the refugee
 wind up being placed by the government. */
 
 scatter  CombinedSettledRefugee HappinessScore  || lfit  CombinedSettledRefugee HappinessScore
 /*There appears to be an uphill relationship between happiness and where the 
 refugee wind up being placed by the government.*/
 
 reg CombinedSettledRefugee HappinessScore
 /* One point incresase in happiness score is assocaited with about 18 refugees
 being settlng into a specific state. It is strong relation as p-value is 0.021
 and both the confidence  interval for both the upper and lower interval are 
 both same sign (i.e. positve)."*/
 
 
