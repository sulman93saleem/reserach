
use "https://docs.google.com/uc?id=1UdLfyfVVZ7KaojoufGIXEvljGsHnmcJP&export=download", clear

/*
In this paper, we are attempting to understand how corruption affects migration. 
The hypothesis is that the countries with the high level of corruption will lead 
to the high level of migration. This research will be limited to the year 2017 only. 
We will have 109 countries with migration rates.  It is pertinent to mention here 
that migration rate will be dependent variable derived from Index Munidi from: 
(https://www.indexmundi.com/g/r.aspx?v=27). Migration rate in this research are 
defined as the entry which includes the figure for the difference between the number 
of persons entering and leaving a country during the year per 1,000 persons 
(based on midyear population).
*/

/*
The Index of Public Integrity ipi-toolbar takes an approach. It assesses a society’s
capacity to control corruption and ensure that public resources are spent without 
corrupt practices.
 */
 
sum ipi
/*
There are 109 observations. The mean of score variable is 6.617. and the standard
deviation is 1.61.
*/
sum smr
/*
There are 109 observations. The mean of score variable is 2.35e-09, and the standard
deviation is 1.
*/
sum eci
/* The mean E-citizenship which captures the ability of citizens to use 
online tools and social media and thus exercise social accountability is 5.38 
with standard deviation of 2.52. So this means over 50% of the world has access 
to the internet.*/ 

tab ic,sum(ipi)
/* In this table we see that high income countries tend to have more user using the 
internet. For instance, in this chart high income countries has an average of 
8.03 with STD of 1.43. Low income countries have a lowest IPI of about 5.09. This
is suggesting income of a country has a positive impact on the presence 
of internet. */

tab rf,sum (gni)
/* In this table we see that European countries tend to have more GNI per capita
than other countries. The mean of GNI per capita for European countries is 35142.43
dollar and the standard deviation is 22595.13. Compare to other countries in the 
dataset, Sub-saharan Africa have lower GNI per capita. Their mean of GNI variable
is 14094.46 dollar and the standard deviation is 18002.35. There are 22 Sub-saharan 
Africa countries included in the dataset.
*/

scatter smr ipi || lfit smr ipi
/*
The graph shows us the relationship between migration rate and the index of public
integrity. Most of the dots are in the red line except three outliners.
*/

histogram ipi
/*In the graph, we can see that the lowest IPI value is around 2 and the highest
value is around 9. It is not normally distributed, it is slightly right skewed.*/

sum smr eci frp
reg smr eci frp
/*
On the eci variable, the 95% confidence interval is [0.0145102, 0.1943094].
One unite increase in E-citizenship level leads to a increase of 0.104 point in 
migration rate, controlling for freedom of the press variable. Also, one unite
increase in the freedom of the press will leads to a increase of 0.044 point in 
the migration rate, controlling for E-citizenship variable.
*/
//aok:ok, good! but do mention that the latter is not significant and interpret back to the initial hypotheses
//--what did we find, what does it mean
tw(scatter smr eci, mlabel(rf))(lfit smr eci)

reg smr eci frp jd 
reg smr eci frp jd admi 
reg smr eci frp jd admi tro 
reg smr eci frp jd admi tro bt

*quadratic
/* This regression says that the “marginal effect” of an additional  */

gen eci2= eci^2
reg smr eci eci2
tw(qfit smr eci)
/*
The graph shows us it is non-linear relationship between migration rate and E-citizenship.
It is a U-curve. before the threshold around 4, with more level of E-citizenship,
the migration rate will go down. But above the threshold around 4, with more 
level of E-citizenship, the migration rate will go up.
*/
gen admi2=admi^2
reg smr admi admi2

*//robust se
reg smr eci, robust
scatter smr gni,ml(rf)

pwcorr smr eci frp jd admi tro bt, star(0.05)

corr eci frp

** regression on dummy
label define rc 0 "black" 1 "white" 2 "other" 
label values race rc 


