
capture log close
capture log using "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\OUTPUT\COMBINED\DATA_MANAGEMENT_COMBINED_DATA.smcl",replace

**STEP 1: COMBINE THE COHORT PRIOR TO DISCRETIZATION**

**NHANES**

use "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\NHANES_MERGED_DATASETfin.dta",clear

capture drop zses
egen zses=std(ses) if sample_final==1

keep seqn COHORT _st _d _t _t0 TIMEyears DIED sample_final invmillsfin AGE HorvathAgeEAA_no_outliers HannumAgeEAA_no_outliers PhenoAgeEAA_no_outliers GrimAgeMortEAA_no_outliers DunedinPoAm_no_outliers zHorvathAgeEAA zHannumAgeEAA zPhenoAgeEAA zGrimAgeMortEAA zDunedinPoAm ses  zses hei2015_total_score RACE SEX AGE WTDN4YR sdmvpsu sdmvstra  frail*

save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\NHANES_MERGED_DATASET_SMALL",replace


capture drop ID
gen ID=seqn

capture drop seqn 

tab SEX

replace SEX=0 if SEX==1
replace SEX=1 if SEX==2


capture rename WTDN4YR sampling_weight
capture rename sdmvpsu PSU
capture rename sdmvstra STRATUM

tab RACE 


svyset PSU [pweight=sampling_weight], strata(STRATUM) vce(linearized) singleunit(missing)


stset TIMEyears [pweight=sampling_weight], id(ID) failure(DIED==1)


save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\NHANES_MERGED_DATASET_SMALLfin",replace


**HRS**
clear
clear matrix
clear mata
set maxvar 30000

use "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\HRS\HRS_TLHEIFRAILEPIGENMORTfin",clear

capture drop COHORT
gen COHORT=2


capture drop zses
egen zses=std(ses) if sample_final==1

keep HHIDPN _st _d _t _t0 COHORT sample_final AGE SEX RACE_ETHN invmillsfin time_event ageenter ageevent doexit died zHorvathAgeEAA zHannumAgeEAA zPhenoAgeEAA zGrimAgeMortEAA zDunedinPoAm  HORVATH_DNAMAGE_no_outliersEAA HANNUM_DNAMAGE_no_outliersEAA LEVINE_DNAMAGE_no_outliersEAA DNAMGRIMAGE_no_outliersEAA MPOA_no_outliers HORVATH_DNAMAGE_no_outliers HANNUM_DNAMAGE_no_outliers LEVINE_DNAMAGE_no_outliers DNAMGRIMAGE_no_outliers MPOA_no_outliers vbsi16wgtra  ses  zses hei2015_total_score  stratum secu *tert fried* frail*

capture drop frailty_status
gen frailty_status=fried_status
replace frailty_status=0 if fried_status==1
replace frailty_status=1 if fried_status==2


save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\HRS\HRS_TLHEIFRAILEPIGENMORTfin_SMALL",replace

capture drop ID
gen ID=HHIDPN


capture rename died DIED

capture rename HORVATH_DNAMAGE_no_outliersEAA HorvathAgeEAA_no_outliers
capture rename HANNUM_DNAMAGE_no_outliersEAA HannumAgeEAA_no_outliers
capture rename LEVINE_DNAMAGE_no_outliersEAA PhenoAgeEAA_no_outliers
capture rename DNAMGRIMAGE_no_outliersEAA GrimAgeMortEAA_no_outliers
capture rename MPOA_no_outliers DunedinPoAm_no_outliers

capture drop HORVATH_DNAMAGE_no_outliers DNAMGRIMAGE_no_outliers HANNUM_DNAMAGE_no_outliers LEVINE_DNAMAGE_no_outliers

capture rename secu PSU
capture rename stratum STRATUM


capture drop ageenter ageevent doexit 

capture rename time_event TIMEyears


capture rename vbsi16wgtra sampling_weight

capture drop HHIDPN
 
tab RACE_ETHN

save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\HRS\HRS_TLHEIFRAILEPIGENMORTfin_SMALL",replace


gen RACE=.
replace RACE=0 if RACE_ETHN==1
replace RACE=1 if RACE_ETHN==2
replace RACE=2 if RACE_ETHN==3
replace RACE=3 if RACE_ETHN==4


tab RACE



svyset PSU [pweight=sampling_weight], strata(STRATUM) vce(linearized) singleunit(missing)


stset TIMEyears [pweight=sampling_weight], id(ID) failure(DIED==1)


 
save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\HRS\HRS_TLHEIFRAILEPIGENMORTfin_SMALL",replace





**STEP 2: APPEND THE 2 COHORTS TOGETHER**


use "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\NHANES_MERGED_DATASET_SMALLfin",clear

append using "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\HRS\HRS_TLHEIFRAILEPIGENMORTfin_SMALL"


save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\COMBINED\NHANES_HRS_DATACOMBINEDfin", replace


capture log close
capture log using "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\OUTPUT\TABLE1.smcl",replace

*****************TABLE 1: DESCRIPTIVES ACROSS SELECTED COHORTS*********************

use  "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\COMBINED\NHANES_HRS_DATACOMBINEDfin", clear

**NHANES**

capture drop COHORT1
gen COHORT1=.
replace COHORT1=1 if COHORT==1 & sample_final==1
replace COHORT1=0 if COHORT1~=1

tab COHORT1

svy, subpop(COHORT1): mean AGE
svy, subpop(COHORT1): prop SEX
svy, subpop(COHORT1): prop i.RACE
svy, subpop(COHORT1): prop frailty_status



foreach x of varlist HorvathAgeEAA_no_outliers HannumAgeEAA_no_outliers PhenoAgeEAA_no_outliers GrimAgeMortEAA_no_outliers DunedinPoAm_no_outliers zHorvathAgeEAA zHannumAgeEAA zPhenoAgeEAA zGrimAgeMortEAA zDunedinPoAm  zses  {
	svy, subpop(COHORT1): mean `x'

	
}

stdescribe if COHORT1==1
stsum if COHORT1==1
strate if COHORT1==1

**HRS**

capture drop COHORT2
gen COHORT2=.
replace COHORT2=1 if COHORT==2 & sample_final==1
replace COHORT2=0 if COHORT2~=1

tab COHORT2

svy, subpop(COHORT2): mean AGE
svy, subpop(COHORT2): prop SEX
svy, subpop(COHORT2): prop i.RACE
svy, subpop(COHORT2): prop frailty_status


foreach x of varlist HorvathAgeEAA_no_outliers HannumAgeEAA_no_outliers PhenoAgeEAA_no_outliers GrimAgeMortEAA_no_outliers DunedinPoAm_no_outliers  zHorvathAgeEAA zHannumAgeEAA zPhenoAgeEAA zGrimAgeMortEAA zDunedinPoAm  zses  {
	svy, subpop(COHORT2): mean `x'

}	


stdescribe if COHORT2==1
stsum if COHORT2==1
strate if COHORT2==1


**COMPARISONS BETWEEN 2 COHORTS*********************


capture drop COHORT_COMP
gen COHORT_COMP=.
replace COHORT_COMP=1 if COHORT1==1
replace COHORT_COMP=2 if COHORT2==1


tab COHORT_COMP


svy, subpop(COHORT_COMP): reg AGE i.COHORT_COMP
svy, subpop(COHORT_COMP): mlogit SEX i.COHORT_COMP
svy, subpop(COHORT_COMP): mlogit RACE i.COHORT_COMP
svy, subpop(COHORT_COMP): mlogit frailty_status i.COHORT_COMP


foreach x of varlist zHorvathAgeEAA zHannumAgeEAA zPhenoAgeEAA zGrimAgeMortEAA zDunedinPoAm zses  {
	svy, subpop(COHORT_COMP): reg `x' i.COHORT_COMP

}

stcox i.COHORT_COMP 


save  "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\COMBINED\NHANES_HRS_DATACOMBINEDfin", replace



capture log close
capture log using "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\OUTPUT\FIGURE1_TERTILES.smcl",replace


use  "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\COMBINED\NHANES_HRS_DATACOMBINEDfin", clear


su HorvathAgeEAA_no_outliers HannumAgeEAA_no_outliers PhenoAgeEAA_no_outliers GrimAgeMortEAA_no_outliers DunedinPoAm_no_outliers zses 
tab1 zHorvathAgeEAAtert zHannumAgeEAAtert zPhenoAgeEAAtert zGrimAgeMortEAAtert zDunedinPoAmtert zsestert 

forval x=1(1)2{
bysort zHorvathAgeEAAtert: su HorvathAgeEAA_no_outliers if COHORT==`x',det	
}
 
forval x=1(1)2{
bysort zHannumAgeEAAtert: su HannumAgeEAA_no_outliers if COHORT==`x',det	
}


forval x=1(1)2{
bysort zDunedinPoAmtert: su DunedinPoAm_no_outliers if COHORT==`x',det	
}


forval x=1(1)2{
bysort zPhenoAgeEAAtert: su PhenoAgeEAA_no_outliers if COHORT==`x',det	
}


forval x=1(1)2{
bysort zGrimAgeMortEAAtert: su GrimAgeMortEAA_no_outliers if COHORT==`x',det	
}


forval x=1(1)2{
bysort zDunedinPoAmtert: su DunedinPoAm_no_outliers if COHORT==`x',det	
}


forval x=1(1)2{
bysort zsestert: su zses if COHORT==`x',det	
}


save  "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\COMBINED\NHANES_HRS_DATACOMBINEDfin", replace


capture log close

capture log using "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\OUTPUT\TABLE2.smcl",replace



****************TABLE 2: GSEM MODELS***********************

use  "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\COMBINED\NHANES_HRS_DATACOMBINEDfin", clear

capture drop zAGE_NHANES
egen zAGE_NHANES=std(AGE) if COHORT_COMP==1

capture drop zAGE_HRS
egen zAGE_HRS=std(AGE) if COHORT_COMP==2

capture drop NHB
gen NHB=.
replace NHB=1 if RACE==1
replace NHB=0 if NHB~=1

capture drop HISP
gen HISP=.
replace HISP=1 if RACE==2
replace HISP=0 if HISP~=1

capture drop OTHER
gen OTHER=.
replace OTHER=1 if RACE==3
replace OTHER=0 if OTHER~=1


**NHANES, MODEL 1, NO SVY**

gsem (_t <- zAGE_NHANES zGrimAgeMortEAA, family(weibull, failure(_d) ) link(log) nocapslatent) ///
(frailty_status <-SEX zses HISP, family(binomial) link(logit)) ///
(zses <- zAGE_NHANES HISP NHB, family(gaussian) link(identity)) ///
(zHorvathAgeEAA <- SEX frailty_status HISP, family(gaussian) link(identity)) ///
(zHannumAgeEAA <- zDunedinPoAm zHorvathAgeEAA NHB, family(gaussian) link(identity)) ///
(zDunedinPoAm <- zses zHorvathAgeEAA SEX , family(gaussian) link(identity)) ///
(zPhenoAgeEAA <- zDunedinPoAm zHannumAgeEAA zHorvathAgeEAA , family(gaussian) link(identity)) ///
(zGrimAgeMortEAA <- zDunedinPoAm zPhenoAgeEAA SEX , family(gaussian) link(identity)) ///
if COHORT_COMP==1, nocapslatent method(ml) 



**NHANES, MODEL 2, WITH SVY**

svy: gsem (_t <- zAGE_NHANES zGrimAgeMortEAA, family(weibull, failure(_d) ) link(log) nocapslatent) ///
(frailty_status <-SEX zses HISP, family(binomial) link(logit)) ///
(zses <- zAGE_NHANES HISP NHB, family(gaussian) link(identity)) ///
(zHorvathAgeEAA <- SEX frailty_status HISP, family(gaussian) link(identity)) ///
(zHannumAgeEAA <- zDunedinPoAm zHorvathAgeEAA NHB, family(gaussian) link(identity)) ///
(zDunedinPoAm <- zses zHorvathAgeEAA SEX , family(gaussian) link(identity)) ///
(zPhenoAgeEAA <- zDunedinPoAm zHannumAgeEAA zHorvathAgeEAA , family(gaussian) link(identity)) ///
(zGrimAgeMortEAA <- zDunedinPoAm zPhenoAgeEAA SEX , family(gaussian) link(identity)) ///
if COHORT_COMP==1, nocapslatent method(ml) 
 
 


************************************


**HRS, MODEL 1, WITHOUT SVY**

gsem (_t <- zAGE_HRS zGrimAgeMortEAA, family(weibull, failure(_d) ) link(log) nocapslatent) ///
(frailty_status <-zAGE_HRS SEX zses, family(binomial) link(logit)) ///
(zses <- zAGE_HRS HISP NHB , family(gaussian) link(identity)) ///
(zHorvathAgeEAA <- SEX HISP, family(gaussian) link(identity)) ///
(zHannumAgeEAA <- zPhenoAgeEAA zHorvathAgeEAA NHB, family(gaussian) link(identity)) ///
(zDunedinPoAm <- zHorvathAgeEAA zses SEX , family(gaussian) link(identity)) ///
(zPhenoAgeEAA <- zDunedinPoAm zHorvathAgeEAA HISP , family(gaussian) link(identity)) ///
(zGrimAgeMortEAA <- zPhenoAgeEAA zDunedinPoAm SEX , family(gaussian) link(identity)) ///
if COHORT_COMP==2, nocapslatent method(ml)

**HRS, MODEL 1, WITH SVY**

svy: gsem (_t <- zAGE_HRS zGrimAgeMortEAA, family(weibull, failure(_d) ) link(log) nocapslatent) ///
(frailty_status <-zAGE_HRS SEX zses, family(binomial) link(logit)) ///
(zses <- zAGE_HRS HISP NHB , family(gaussian) link(identity)) ///
(zHorvathAgeEAA <- SEX HISP, family(gaussian) link(identity)) ///
(zHannumAgeEAA <- zPhenoAgeEAA zHorvathAgeEAA NHB, family(gaussian) link(identity)) ///
(zDunedinPoAm <- zHorvathAgeEAA zses SEX , family(gaussian) link(identity)) ///
(zPhenoAgeEAA <- zDunedinPoAm zHorvathAgeEAA HISP , family(gaussian) link(identity)) ///
(zGrimAgeMortEAA <- zPhenoAgeEAA zDunedinPoAm SEX , family(gaussian) link(identity)) ///
if COHORT_COMP==2, nocapslatent method(ml)

save  "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\COMBINED\NHANES_HRS_HANDLS_DATACOMBINEDfin", replace


capture log close
capture log using "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\OUTPUT\COMBINED\MED4WAY.smcl",replace

use  "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\COMBINED\NHANES_HRS_HANDLS_DATACOMBINEDfin", clear



foreach m of varlist zHorvathAgeEAA zHannumAgeEAA zDunedinPoAm zPhenoAgeEAA zGrimAgeMortEAA  {
med4way frailty_status `m' zAGE_NHANES SEX NHB HISP OTHER zses  if sample_final==1 & COHORT_COMP==1 , a0(0) a1(1) m(0) yreg(cox) mreg(linear) fulloutput
}


foreach m of varlist zHorvathAgeEAA zHannumAgeEAA zDunedinPoAm zPhenoAgeEAA zGrimAgeMortEAA  {
med4way frailty_status `m' zAGE_HRS SEX NHB HISP OTHER zses  if sample_final==1 & COHORT_COMP==2, a0(0) a1(1) m(0) yreg(cox) mreg(linear) fulloutput
}


capture log close



