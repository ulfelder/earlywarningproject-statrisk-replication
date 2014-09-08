# -------------------------------------------------- #
# HumanRightsProtectionScores_Version2_README.txt
# -------------------------------------------------- #

 File Date: 2014-03-07

 Author: Christopher Fariss

 Title: "Respect for Human Rights has Improved Over Time: Modeling the Changing Standard of Accountability"

 Contact: Chris Fariss: cjf0006@gmail.com
 All inquires about the models and code should be sent to Chris Fariss 

 Copyright (c) 2014, under the Creative Commons Attribution-Noncommercial-Share Alike 3.0 United States License.
 For more information see: http://creativecommons.org/licenses/by-nc-sa/3.0/us/
 All rights reserved. 


# -------------------------------------------------- #

This README file provides a information about the data contained in the following file:

CYLatentRepressionDynamicStandardDynamicX_v2.03.csv


# -------------------------------------------------- #
# CITATION INFORMATION: 
# -------------------------------------------------- #

The latent variable is discussed at length in:

Fariss, Christopher J. 2014. "Respect for Human Rights has Improved Over Time: Modeling the Changing Standard of Accountability". American Political Science Review 108(2):TBD 


An un-gated version of the paper is available here:

http://ssrn.com/abstract=2358014

An online appendix is available here:

http://cfariss.com/documents/FarissForthcomingAPSR_SupplementaryAppendix.pdf


# -------------------------------------------------- #
# VARIABLE INFORMATION:
# -------------------------------------------------- #

Brief descriptionss of the variables contained in the file (see section 3 in the aricle and the online appendix for much more detailed information about these variables). Full citation information for each variable is contained in both of these documents.


YEAR --- year identifier  

CIRI --- CIRI country identifier 

COW --- correlates of war country identifier

DISAP --- 3 category, ordered variable for disappearances from the CIRI dataset

KILL --- 3 category, ordered variable from extra-judical killing the CIRI dataset

POLPRIS --- 3 category, ordered variable for political imprisonment from the CIRI dataset

TORT --- 3 category, ordered variable for torture from the CIRI dataset

Amnesty --- 5 category, 

State --- 5 category, 

hathaway --- 5 category, ordered variable for torture from the Hathaway (2002) article.

ITT --- 6 category, ordered variable for torture from the ITT dataset

genocide --- a binary variable for genocide from Harff's 2003 APSR article

rummel --- a binary variable for politicide/genocide based on data from Rummel

massive_repression --- a binary variable for massive repressive events taken from Harff and Gurr's 1988 ISQ article

executions --- a binary variable taken from the World Handbook of political indicators

killing --- binary version based on the UCDP one sided violence count data

additive --- the CIRI Physint scale

latentmean --- the posterior mean of the new latent variable described in the paper.

latentsd --- the standard deviation of the posterior estimates

NAME --- country name from the correlates of war dataset for each country


# -------------------------------------------------- #
# ADDITIONAL NOTES: 
# -------------------------------------------------- #

The latent variable is the posterior mean so you can use that as the DV. You can just use a standard OLS with this DV since it is continuous. You also don't need to worry about the uncertainty of the estimates (captured by the standard deviation) because the error term in the OLS will capture this uncertainty. However, if you used a lagged DV you should try and incorporate this uncertainty. This can be done using simulations. I discuss this procedure in the paper.

One final note, 666.001, 666.002, 666.003 are listed as cow codes because of extra reports produced from some years in the state department reports and coded by the PTS team. 
666 --- Israel
666.001 --- Israel, pre-1967 borders
666.002 --- Israel, occupied territories only
666.003 --- Palestinian Authority

# -------------------------------------------------- #
# End of file 
# -------------------------------------------------- #
