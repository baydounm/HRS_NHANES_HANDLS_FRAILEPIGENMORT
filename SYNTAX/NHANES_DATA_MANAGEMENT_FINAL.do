
capture log close

capture log using "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\OUTPUT\NHANES\NHANES_DATAMANAGEMENT.smcl", replace


//STEP 1: EPIGENETIC CLOCK DATA//

cd "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\RAW_DATA\NHANES_DATA\EPIGENETIC\"

clear 

import sas using "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\RAW_DATA\NHANES_DATA\EPIGENETIC\dnmepi.sas7bdat"

save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\RAW_DATA\NHANES_DATA\EPIGENETIC\EPIGENETIC_NHANES.dta",replace

codebook

tab XY_Estimation

su HorvathAge-PhenoAge GrimAgeMort GrimAge2Mort HorvathTelo YangCell ZhangAge LinAge WeidnerAge VidalBraloAge DunedinPoAm CD8TPP CD4TPP Nkcell Bcell MonoPP NeuPP WTDN4YR,det

foreach var of varlist HorvathAge-PhenoAge GrimAgeMort GrimAge2Mort HorvathTelo YangCell ZhangAge LinAge WeidnerAge VidalBraloAge DunedinPoAm CD8TPP CD4TPP Nkcell Bcell MonoPP NeuPP {
	histogram `var'
	graph save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FIGURES\NHANES_EPICLOCK\NHANES_EPICLOCK_HIST`var'", replace
}

use "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\RAW_DATA\NHANES_DATA\EPIGENETIC\EPIGENETIC_NHANES.dta",clear
save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\EPIGENETIC_NHANES.dta",replace



//STEP 2: DEMOGRAPHIC //


**1999-00**
cd "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\RAW_DATA\NHANES_DATA\DEMOGRAPHICS\1999_00"

clear 

import sasxport5 "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\RAW_DATA\NHANES_DATA\DEMOGRAPHICS\1999_00\DEMO.xpt"


capture drop year
gen year=1999.5

save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\RAW_DATA\NHANES_DATA\DEMOGRAPHICS\1999_00\DEMO.dta",replace


codebook

su sddsrvyr-year, det


**2001-2002**
cd "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\RAW_DATA\NHANES_DATA\DEMOGRAPHICS\2001_02"

clear 

import sasxport5 "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\RAW_DATA\NHANES_DATA\DEMOGRAPHICS\2001_02\DEMO_B.xpt"


capture drop year
gen year=2001.5

save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\RAW_DATA\NHANES_DATA\DEMOGRAPHICS\2001_02\DEMO_B.dta",replace


codebook

su sddsrvyr-year, det


**Append the two waves**

use "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\RAW_DATA\NHANES_DATA\DEMOGRAPHICS\1999_00\DEMO.dta",clear

save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\DEMO.dta",replace

use "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\RAW_DATA\NHANES_DATA\DEMOGRAPHICS\2001_02\DEMO_B.dta",clear

save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\DEMO_B.dta",replace

use "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\DEMO.dta",clear
append using "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\DEMO_B.dta"

save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\DEMO_AB.dta",replace

codebook

su 

keep seqn sddsrvyr ridstatr ridexmon riagendr ridageyr ridagemn ridageex ridreth1 ridreth2 dmdborn dmdcitzn dmdeduc2 dmdeduc indhhinc indfminc indfmpir dmdhrgnd dmdhrage dmdhrbrn dmdhredu dmdhrmar wtint2yr wtint4yr wtmec2yr wtmec4yr sdmvpsu sdmvstra year

save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\DEMO_ABfinal.dta",replace

su

codebook


//STEP 3: MORTALITY DATA //



***1999-2000***

cd "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\RAW_DATA\NHANES_DATA\MORTALITY_LINKAGE\1999_00"

global SURVEY NHANES_1999_2000     // REPLACE <SURVEY> WITH RELEVANT SURVEY NAME (IN ALL CAPS)

clear all


// DEFINE VALUE LABELS FOR REPORTS
label define premiss .z "Missing"
label define eligfmt 1 "Eligible" 2 "Under age 18, not available for public release" 3 "Ineligible" 
label define mortfmt 0 "Assumed alive" 1 "Assumed deceased" .z "Ineligible or under age 18"
label define flagfmt 0 "No - Condition not listed as a multiple cause of death" 1 "Yes - Condition listed as a multiple cause of death"	.z "Assumed alive, under age 18, ineligible for mortality follow-up, or MCOD not available"
label define qtrfmt 1 "January-March" 2 "April-June" 3 "July-September" 4 "October-December" .z "Ineligible, under age 18, or assumed alive"
label define dodyfmt .z "Ineligible, under age 18, or assumed alive"
label define ucodfmt 1 "Diseases of heart (I00-I09, I11, I13, I20-I51)"                           
label define ucodfmt 2 "Malignant neoplasms (C00-C97)"                                            , add
label define ucodfmt 3 "Chronic lower respiratory diseases (J40-J47)"                             , add
label define ucodfmt 4 "Accidents (unintentional injuries) (V01-X59, Y85-Y86)"                    , add
label define ucodfmt 5 "Cerebrovascular diseases (I60-I69)"                                       , add
label define ucodfmt 6 "Alzheimer's disease (G30)"                                                , add
label define ucodfmt 7 "Diabetes mellitus (E10-E14)"                                              , add
label define ucodfmt 8 "Influenza and pneumonia (J09-J18)"                                        , add
label define ucodfmt 9 "Nephritis, nephrotic syndrome and nephrosis (N00-N07, N17-N19, N25-N27)"  , add
label define ucodfmt 10 "All other causes (residual)"                                             , add
label define ucodfmt .z "Ineligible, under age 18, assumed alive, or no cause of death data"      , add

// READ IN THE FIXED-WIDTH FORMAT ASCII PUBLIC-USE LMF
infix seqn 1-6 eligstat 15 mortstat 16 ucod_leading 17-19 diabetes 20 hyperten 21 permth_int 43-45 permth_exm 46-48 using ${SURVEY}_MORT_2019_PUBLIC.dat	


// REPLACE MISSING VALUES TO .z FOR LABELING
replace mortstat = .z if mortstat >=.
replace ucod_leading = .z if ucod_leading >=.
replace diabetes = .z if diabetes >=.
replace hyperten = .z if hyperten >=.
replace permth_int = .z if permth_int >=.
replace permth_exm = .z if permth_exm >=.


// DEFINE VARIABLE LABELS 
label var seqn "NHANES Respondent Sequence Number"
label var eligstat "Eligibility Status for Mortality Follow-up"
label var mortstat "Final Mortality Status"
label var ucod_leading "Underlying Cause of Death: Recode"
label var diabetes "Diabetes flag from Multiple Cause of Death"
label var hyperten "Hypertension flag from Multiple Cause of Death"
label var permth_int "Person-Months of Follow-up from NHANES Interview date"
label var permth_exm "Person-Months of Follow-up from NHANES Mobile Examination Center (MEC) Date"


// ASSOCIATE VARIABLES WITH FORMAT VALUES 
label values eligstat eligfmt
label values mortstat mortfmt
label values ucod_leading ucodfmt
label values diabetes flagfmt
label values hyperten flagfmt
label value permth_int premiss
label value permth_exm premiss


// DISPLAY OVERALL DESCRIPTION OF FILE 
describe


// ONE-WAY FREQUENCIES (UNWEIGHTED)
tab1 eligstat mortstat ucod_leading diabetes hyperten, missing
tab permth_int if permth_int==.z, missing
tab permth_exm if permth_exm==.z, missing

// SAVE DATA FILE IN DIRECTORY DESIGNATED AT TOP OF PROGRAM AS **SURVEY**_PUF.DTA
// replace option allows Stata to overwrite an existing .dta file
save ${SURVEY}_PUF, replace


codebook

capture drop year
gen year=1999.5


save ${SURVEY}_PUF, replace


**2001-2002**
cd "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\RAW_DATA\NHANES_DATA\MORTALITY_LINKAGE\2001_02"

global SURVEY NHANES_2001_2002     // REPLACE <SURVEY> WITH RELEVANT SURVEY NAME (IN ALL CAPS)

clear all


// DEFINE VALUE LABELS FOR REPORTS
label define premiss .z "Missing"
label define eligfmt 1 "Eligible" 2 "Under age 18, not available for public release" 3 "Ineligible" 
label define mortfmt 0 "Assumed alive" 1 "Assumed deceased" .z "Ineligible or under age 18"
label define flagfmt 0 "No - Condition not listed as a multiple cause of death" 1 "Yes - Condition listed as a multiple cause of death"	.z "Assumed alive, under age 18, ineligible for mortality follow-up, or MCOD not available"
label define qtrfmt 1 "January-March" 2 "April-June" 3 "July-September" 4 "October-December" .z "Ineligible, under age 18, or assumed alive"
label define dodyfmt .z "Ineligible, under age 18, or assumed alive"
label define ucodfmt 1 "Diseases of heart (I00-I09, I11, I13, I20-I51)"                           
label define ucodfmt 2 "Malignant neoplasms (C00-C97)"                                            , add
label define ucodfmt 3 "Chronic lower respiratory diseases (J40-J47)"                             , add
label define ucodfmt 4 "Accidents (unintentional injuries) (V01-X59, Y85-Y86)"                    , add
label define ucodfmt 5 "Cerebrovascular diseases (I60-I69)"                                       , add
label define ucodfmt 6 "Alzheimer's disease (G30)"                                                , add
label define ucodfmt 7 "Diabetes mellitus (E10-E14)"                                              , add
label define ucodfmt 8 "Influenza and pneumonia (J09-J18)"                                        , add
label define ucodfmt 9 "Nephritis, nephrotic syndrome and nephrosis (N00-N07, N17-N19, N25-N27)"  , add
label define ucodfmt 10 "All other causes (residual)"                                             , add
label define ucodfmt .z "Ineligible, under age 18, assumed alive, or no cause of death data"      , add

// READ IN THE FIXED-WIDTH FORMAT ASCII PUBLIC-USE LMF
infix seqn 1-6 eligstat 15 mortstat 16 ucod_leading 17-19 diabetes 20 hyperten 21 permth_int 43-45 permth_exm 46-48 using ${SURVEY}_MORT_2019_PUBLIC.dat	


// REPLACE MISSING VALUES TO .z FOR LABELING
replace mortstat = .z if mortstat >=.
replace ucod_leading = .z if ucod_leading >=.
replace diabetes = .z if diabetes >=.
replace hyperten = .z if hyperten >=.
replace permth_int = .z if permth_int >=.
replace permth_exm = .z if permth_exm >=.


// DEFINE VARIABLE LABELS 
label var seqn "NHANES Respondent Sequence Number"
label var eligstat "Eligibility Status for Mortality Follow-up"
label var mortstat "Final Mortality Status"
label var ucod_leading "Underlying Cause of Death: Recode"
label var diabetes "Diabetes flag from Multiple Cause of Death"
label var hyperten "Hypertension flag from Multiple Cause of Death"
label var permth_int "Person-Months of Follow-up from NHANES Interview date"
label var permth_exm "Person-Months of Follow-up from NHANES Mobile Examination Center (MEC) Date"


// ASSOCIATE VARIABLES WITH FORMAT VALUES 
label values eligstat eligfmt
label values mortstat mortfmt
label values ucod_leading ucodfmt
label values diabetes flagfmt
label values hyperten flagfmt
label value permth_int premiss
label value permth_exm premiss


// DISPLAY OVERALL DESCRIPTION OF FILE 
describe


// ONE-WAY FREQUENCIES (UNWEIGHTED)
tab1 eligstat mortstat ucod_leading diabetes hyperten, missing
tab permth_int if permth_int==.z, missing
tab permth_exm if permth_exm==.z, missing

// SAVE DATA FILE IN DIRECTORY DESIGNATED AT TOP OF PROGRAM AS **SURVEY**_PUF.DTA
// replace option allows Stata to overwrite an existing .dta file
save ${SURVEY}_PUF, replace


codebook

capture drop year
gen year=2001.5


save ${SURVEY}_PUF, replace


**********Append the two waves*****************************


use "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\RAW_DATA\NHANES_DATA\MORTALITY_LINKAGE\1999_00\NHANES_1999_2000_PUF",clear
save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\NHANES_1999_0000_PUF",replace



use "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\RAW_DATA\NHANES_DATA\MORTALITY_LINKAGE\2001_02\NHANES_2001_2002_PUF",clear
save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\NHANES_2001_2002_PUF",replace


use "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\NHANES_1999_0000_PUF",clear
append using "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\NHANES_2001_2002_PUF"

save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\NHANES_1999_2002_PUF",replace

su

codebook

//STEP 4: MERGE DATASETS TOGETHER WITH DEMOGRAPHICS DATA//

use "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\DEMO_ABfinal",clear
sort seqn
capture drop _merge
save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\DEMO_ABfinal",replace

use "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\EPIGENETIC_NHANES",clear
capture rename SEQN seqn
sort seqn
capture drop _merge
save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\EPIGENETIC_NHANES",replace

use "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\NHANES_1999_2002_PUF",clear
sort seqn
capture drop _merge
save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\NHANES_1999_2002_PUF",replace


use "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\DEMO_ABfinal",clear
merge seqn using "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\EPIGENETIC_NHANES"
sort seqn
capture drop _merge
merge seqn using "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\NHANES_1999_2002_PUF"
sort seqn
capture drop _merge

save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\NHANES_MERGED_DATASET",replace

codebook
su


use "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\NHANES_MERGED_DATASET",clear


//STEP 5: GENERATE EPIGENETIC AGE ACCELERATION VARIABLES FROM HORVATH, HANNUM, PHENO, GRIMM, include POA, remove Outliers and z-score//
capture drop AGE
gen AGE=ridageyr

su AGE if HorvathAge~=.
histogram AGE if HorvathAge~=.

capture drop HorvathAgeEAA 
capture drop HannumAgeEAA 
capture drop PhenoAgeEAA 
capture drop GrimAgeMortEAA   


foreach var of varlist HorvathAge HannumAge PhenoAge GrimAgeMort {
	
	reg `var' AGE 
	predict `var'EAA, resid
	histogram `var'EAA
	graph save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FIGURES\NHANES_EPICLOCK\NHANES_HIST`var'EAA.gph", replace
	su `var'EAA
}

su DunedinPoAm
histogram DunedinPoAm
graph save  "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FIGURES\NHANES_EPICLOCK\NHANES_HISTDunedinPoAmEAA.gph", replace
 

save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\NHANES_MERGED_DATASET",replace


*******REMOVE OUTLIERS*************

local vars HorvathAgeEAA HannumAgeEAA PhenoAgeEAA GrimAgeMortEAA DunedinPoAm  // Replace with your actual variable names

foreach var of varlist `vars' {
    // Calculate IQR
    quietly summarize `var', detail
    local p25 = r(p25)
    local p75 = r(p75)
    local iqr = `p75' - `p25'

    // Define the upper and lower bounds for outliers
    local lower_bound = `p25' - 4 * `iqr'
    local upper_bound = `p75' + 4 * `iqr'

    // Generate a new variable excluding outliers
    gen `var'_no_outliers = `var'
    replace `var'_no_outliers = . if `var' < `lower_bound' | `var' > `upper_bound'
}




*******Z-SCORE*************

capture drop zHorvathAgeEAA zHannumAgeEAA zPhenoAgeEAA zGrimAgeMortEAA zDunedinPoAm
foreach var of varlist HorvathAgeEAA HannumAgeEAA PhenoAgeEAA GrimAgeMortEAA DunedinPoAm {
	
	egen z`var'=std(`var')
}

su z*

save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\NHANES_MERGED_DATASET",replace


foreach var of varlist zHorvathAgeEAA zHannumAgeEAA zPhenoAgeEAA zGrimAgeMortEAA zDunedinPoAm {
	histogram `var'
	graph save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FIGURES\NHANES_EPICLOCK\NHANES_HIST`var'.gph",replace
	
}

save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\NHANES_MERGED_DATASET",replace


use "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\NHANES_MERGED_DATASET",clear


use "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\NHANES_MERGED_DATASET",clear


//STEP 8: COVARIATES//


**RACE**

**ridreth1
**1: Mexican American
**2: Other Hispanic
**3: Non-Hispanic White
**4: Non-Hispanic Black
**5: Other Race - Including Multi-Racial

tab ridreth1

**Race/Ethnic |
**      ity - |
**     Recode |      Freq.     Percent        Cum.
**------------+-----------------------------------
**          1 |      6,169       29.37       29.37
**          2 |      1,106        5.27       34.64
**          3 |      7,973       37.96       72.60
**          4 |      4,909       23.37       95.97
**          5 |        847        4.03      100.00
**------------+-----------------------------------
**      Total |     21,004      100.00




capture drop RACE
gen RACE=.
replace RACE=0 if ridreth1==3
replace RACE=1 if ridreth1==4
replace RACE=2 if ridreth1==1 | ridreth1==2
replace RACE=3 if RACE==. & ridreth1~=.


tab RACE

**       RACE |      Freq.     Percent        Cum.
**------------+-----------------------------------
**          0 |      7,973       37.96       37.96
**          1 |      4,909       23.37       61.33
**          2 |      7,275       34.64       95.97
**          3 |        847        4.03      100.00
**------------+-----------------------------------
**     Total |     21,004      100.00


**RACE**
**0=Non-Hispanic White
**1=Non-Hispanic Black
**2=Hispanic
**3=Other


**SEX**
capture drop SEX

gen SEX=riagendr

tab SEX


**SEX
**1: Male
**2: Female


**COHORT VARIABLE**

capture drop COHORT
gen COHORT=1

tab COHORT


save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\NHANES_MERGED_DATASET",replace


use "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\NHANES_MERGED_DATASET",clear


//STEP 9: SET UP DATASET AS SURVIVAL DATA//

su permth_exm
tab mortstat

capture drop DIED
gen DIED=mortstat

capture drop TIMEyears
gen TIMEyears=permth_exm/12
su TIMEyears
histogram TIMEyears

graph save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FIGURES\NHANES_MORTALITY\HIST_TIMETOEVENT.gph",replace

stset TIMEyears [pweight=WTDN4YR] , id(seqn) failure(DIED==1)


save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\NHANES_MERGED_DATASET",replace


capture log close

capture log using "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\OUTPUT\NHANES\NHANES_DATAMANAGEMENT2.smcl", replace



*******1999-00 and 2001-2002 waves dietary data*************************

clear
import sasxport5 "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\RAW_DATA\NHANES_DATA\DIETARY_DATA\1999_00\DRXIFF.xpt",clear
save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\RAW_DATA\NHANES_DATA\DIETARY_DATA\1999_00\DRXIFF.dta",replace

clear
import sasxport5 "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\RAW_DATA\NHANES_DATA\DIETARY_DATA\1999_00\DRXTOT.xpt",clear
save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\RAW_DATA\NHANES_DATA\DIETARY_DATA\1999_00\DRXTOT.dta",replace


clear
import sasxport5 "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\RAW_DATA\NHANES_DATA\DIETARY_DATA\2001_02\DRXIFF_B.xpt",clear
save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\RAW_DATA\NHANES_DATA\DIETARY_DATA\2001_02\DRXIFF_B.dta",replace

clear
import sasxport5 "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\RAW_DATA\NHANES_DATA\DIETARY_DATA\2001_02\DRXTOT_B.xpt",clear
save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\RAW_DATA\NHANES_DATA\DIETARY_DATA\2001_02\DRXTOT_B.dta",replace

***********APPEND 1999-00 OVER 2001-2002 waves***********************

*************FOODS*****************

use "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\RAW_DATA\NHANES_DATA\DIETARY_DATA\1999_00\DRXIFF.dta",clear
gen WAVE=1
save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\RAW_DATA\NHANES_DATA\DIETARY_DATA\DRXIFF.dta", replace


use "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\RAW_DATA\NHANES_DATA\DIETARY_DATA\2001_02\DRXIFF_B.dta",clear
gen WAVE=2
save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\RAW_DATA\NHANES_DATA\DIETARY_DATA\DRXIFF_B.dta",replace


use "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\RAW_DATA\NHANES_DATA\DIETARY_DATA\DRXIFF.dta",clear
append using "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\RAW_DATA\NHANES_DATA\DIETARY_DATA\DRXIFF_B.dta"

save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\RAW_DATA\NHANES_DATA\DIETARY_DATA\DRXIFFA_B.dta",replace

********NUTRIENTS**************

use "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\RAW_DATA\NHANES_DATA\DIETARY_DATA\1999_00\DRXTOT.dta",clear
gen WAVE=1
save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\RAW_DATA\NHANES_DATA\DIETARY_DATA\DRXTOT.dta", replace


use "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\RAW_DATA\NHANES_DATA\DIETARY_DATA\2001_02\DRXTOT_B.dta",clear
gen WAVE=2
save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\RAW_DATA\NHANES_DATA\DIETARY_DATA\DRXTOT_B.dta",replace


use "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\RAW_DATA\NHANES_DATA\DIETARY_DATA\DRXTOT.dta",clear
append using "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\RAW_DATA\NHANES_DATA\DIETARY_DATA\DRXTOT_B.dta"

save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\RAW_DATA\NHANES_DATA\DIETARY_DATA\DRXTOTA_B.dta",replace


***************GET FOOD GROUPS/FOOD CODE DATA FROM THE HEI 2015 CALCULATION IN HANDLS AND PLACE IT IN THE DIETARY_DATA FOLDER; MODIFY VARIABLE NAMES; MERGE WITH DRXIFFA_B BY FOOD CODE VARIABLE******************

***fped0016_finalized is obtained from the LE8 code for HEI-2015 from HANDLS****
***drdifdcd***

use "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\RAW_DATA\NHANES_DATA\DIETARY_DATA\DRXIFFA_B.dta",clear
capture drop foodcode
gen foodcode=drdifdcd
sort foodcode
capture drop _merge
save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\RAW_DATA\NHANES_DATA\DIETARY_DATA\DRXIFFA_B.dta",replace



use "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\RAW_DATA\NHANES_DATA\DIETARY_DATA\fped0016_finalized.dta",clear
sort foodcode
capture drop _merge
save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\RAW_DATA\NHANES_DATA\DIETARY_DATA\fped0016_finalized.dta",replace

use "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\RAW_DATA\NHANES_DATA\DIETARY_DATA\fped0016_finalized.dta",clear
merge foodcode using "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\RAW_DATA\NHANES_DATA\DIETARY_DATA\DRXIFFA_B.dta"

save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\RAW_DATA\NHANES_DATA\DIETARY_DATA\DRXIFFA_B_fped0016.dta",replace

su drxigrms


foreach x of varlist G_TOTAL G_WHL G_NWHL V_TOTAL V_DRKGR V_ORANGE V_POTATO V_STARCY V_TOMATO V_OTHER F_TOTAL F_CITMLB F_OTHER D_TOTAL D_MILK D_YOGURT D_CHEESE M_MPF M_MEAT M_ORGAN M_FRANK M_POULT M_FISH_HI M_FISH_LO M_EGG M_SOY M_NUTSD LEGUMES DISCFAT_OIL DISCFAT_SOL ADD_SUG A_BEV F_JUICE F_WHOLE {
	gen `x'grams=`x'*drxigrms/100
	
}


collapse (sum) G_TOTALgrams-A_BEVgrams F_JUICEgrams F_WHOLEgrams, by(seqn)  



save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\RAW_DATA\NHANES_DATA\DIETARY_DATA\DRXIFFA_B_fped0016_collapse.dta",replace
sort seqn 
capture drop _merge
save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\RAW_DATA\NHANES_DATA\DIETARY_DATA\DRXIFFA_B_fped0016_collapse.dta",replace


use  "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\RAW_DATA\NHANES_DATA\DIETARY_DATA\DRXTOTA_B.dta",clear
sort seqn 
capture drop _merge
save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\RAW_DATA\NHANES_DATA\DIETARY_DATA\DRXTOTA_B.dta",replace


merge seqn using "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\RAW_DATA\NHANES_DATA\DIETARY_DATA\DRXIFFA_B_fped0016_collapse.dta"

save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\RAW_DATA\NHANES_DATA\DIETARY_DATA\HEI2015.dta", replace

save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\HEI2015.dta", replace



//STEP 10: HEI-2015 //



use "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\HEI2015", clear

capture drop monofat 
capture drop polyfat 
capture drop add_sug 
capture drop discfat_sol 
capture drop alcohol 
capture drop f_total 
capture drop frtjuice 
capture drop wholefrt 
capture drop g_whl 
capture drop d_total 
capture drop Satfat 
capture drop sodi 
capture drop g_nwhl 
capture drop sfat 
capture drop kcal
capture drop m_mpf
capture drop m_egg
capture drop m_nutsd
capture drop m_soy
capture drop m_fish_hi
capture drop m_fish_lo
capture drop legumes
capture drop v_total
capture drop v_drkgr

gen monofat=drxtmfat
gen polyfat=drxtpfat
gen add_sug=ADD_SUGgrams 
gen discfat_sol=DISCFAT_SOLgrams
gen alcohol=A_BEVgrams
gen f_total=F_TOTALgrams  
gen frtjuice=F_JUICEgrams
gen wholefrt=F_WHOLEgrams
gen g_whl=G_WHLgrams 
gen d_total=D_TOTALgrams
gen Satfat=drxtsfat 
gen sodi=drdtsodi
gen g_nwhl=G_NWHLgrams
gen SatFat=drxtsfat
gen kcal=drxtkcal 
gen m_mpf=M_MPFgrams
gen m_egg=M_EGGgrams
gen m_nutsd=M_NUTSDgrams
gen m_soy=M_SOYgrams
gen m_fish_hi=M_FISH_HIgrams
gen m_fish_lo=M_FISH_LOgrams 
gen legumes=LEGUMESgrams
gen v_total=V_TOTALgrams
gen v_drkgr=V_DRKGRgrams

 
***********LEGUME PART OF THE CODE**************

capture drop allmeat 
capture drop seaplant
capture drop mbmax
capture drop meatleg
capture drop legume_added_*
capture drop meatveg
capture drop extrmeat
capture drop extrleg
capture drop needmeat
capture drop allmeat
capture drop all2meat
capture drop all2veg


gen allmeat=m_mpf+m_egg+m_nutsd+m_soy
gen seaplant=m_fish_hi+m_fish_lo+m_nutsd + m_soy
gen mbmax=2.5*(kcal/1000)
gen needmeat=mbmax-allmeat if allmeat<mbmax
gen meatleg=4*legumes
/*Needs more meat, and all beans go to meat*/
gen all2meat=1 if meatleg<=needmeat /*folks who don't meet meat max and the amount
of legumes they consume is less than the amount they need to reach mbmax*/
foreach var in allmeat seaplant {
gen legume_added_`var'=`var'+meatleg if all2meat==1
}
foreach var in v_total v_drkgr {
gen legume_added_`var'=`var' if all2meat==1
}
/*Needs more meat, and some beans go to meat, some go to veggies*/
gen meatveg=1 if meatleg>needmeat
gen extrmeat=meatleg-needmeat
gen extrleg=extrmeat/4
foreach var in allmeat seaplant {
replace legume_added_`var'=`var'+needmeat if meatveg==1 /*folks who don't meet
meat max and the amount of legumes they consume is more than the amount they need
to reach mbmax--rest go to veggies*/
}
foreach var in v_total v_drkgr {
replace legume_added_`var'=`var'+extrleg if meatveg==1
}
gen all2veg=1 if allmeat>=mbmax /*Folks who meet the meat requirement so all
legumes count as veggies*/
foreach var in allmeat seaplant {
replace legume_added_`var'=`var' if all2veg==1
}
foreach var in v_total v_drkgr {
replace legume_added_`var'=`var'+legumes if all2veg==1
}

save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\HEI2015", replace

capture drop monopoly
capture drop addsugc
capture drop solfatc
capture drop maxalcgr
capture drop ethcal
capture drop exalccal
capture drop emptycal10
capture drop vegden
capture drop hei*
capture drop grbnden
capture drop frtden
capture drop wholefrt
capture drop whfrden
capture drop wgrnden
capture drop monopoly
capture drop farmin
capture drop farmax
capture drop sodden
capture drop sodmin
capture drop sodmax
capture drop rgden
capture drop rgmin
capture drop rgmax
capture drop sofa*
capture drop addedsugar_perc 
capture drop addsugmin 
capture dorp addsugmax 
capture drop heix12_addedsugar
capture drop saturatedfat_perc 
capture drop saturatedfatmin 
capture drop saturatedfatmax 
capture drop heix13_saturatedfat



/*This do file creates HEI-2015 component densities and scores*/
gen monopoly=monofat+polyfat
gen addsugc=16*add_sug
gen solfatc=9*discfat_sol
gen maxalcgr=13*(kcal/1000)
gen ethcal=7*alcohol
gen exalccal=7*(alcohol-maxalcgr)
replace exalccal=0 if alcohol<=maxalcgr
gen emptycal10=addsugc+solfatc+exalccal
gen vegden=legume_added_v_total/(kcal/1000)
gen heix1_totalveg=5*(vegden/1.1)
replace heix1_totalveg=5 if heix1_totalveg>5
replace heix1_totalveg=0 if heix1_totalveg<0
gen grbnden=legume_added_v_drkgr/(kcal/1000)
gen heix2_greens_and_bean=5*(grbnden/.2)
replace heix2_greens_and_bean=5 if heix2_greens_and_bean>5
replace heix2_greens_and_bean=0 if heix2_greens_and_bean<0
gen frtden=f_total/(kcal/1000)
gen heix3_totalfruit=5*(frtden/.8)
replace heix3_totalfruit=5 if heix3_totalfruit>5
replace heix3_totalfruit=0 if heix3_totalfruit<0
gen wholefrt=f_total-frtjuice
gen whfrden=wholefrt/(kcal/1000)
gen heix4_wholefruit=5*(whfrden/.4)
replace heix4_wholefruit=5 if heix4_wholefruit>5
replace heix4_wholefruit=0 if heix4_wholefruit<0
gen wgrnden=g_whl/(kcal/1000)
gen heix5_wholegrain=10*(wgrnden/1.5)
replace heix5_wholegrain=10 if heix5_wholegrain>10
replace heix5_wholegrain=0 if heix5_wholegrain<0
gen dairyden=d_total/(kcal/1000)
gen heix6_totaldairy=10*(dairyden/1.3)
replace heix6_totaldairy=10 if heix6_totaldairy>10
replace heix6_totaldairy=0 if heix6_totaldairy<0
gen meatden=legume_added_allmeat/(kcal/1000)
gen heix7_totprot=5*(meatden/2.5)
replace heix7_totprot=5 if heix7_totprot>5
replace heix7_totprot=0 if heix7_totprot<0
gen seaplden=legume_added_seaplant/(kcal/1000)
gen heix8_seaplant_prot=5*(seaplden/.8)
replace heix8_seaplant_prot=5 if heix8_seaplant_prot>5
replace heix8_seaplant_prot=0 if heix8_seaplant_prot<0
gen faratio=monopoly/SatFat if SatFat>0




gen farmin=1.2
gen farmax=2.5
gen heix9_fattyacid=0 if SatFat==0 & monopoly==0
replace heix9_fattyacid=10 if SatFat==0 & monopoly>0
replace heix9_fattyacid=10 if faratio>=farmax & faratio !=.
replace heix9_fattyacid=0 if faratio<=farmin & faratio !=.
replace heix9_fattyacid=10*((faratio-farmin)/(farmax-farmin)) if faratio !=.
gen sodden=sodi/kcal
gen sodmin=1.1
gen sodmax=2
gen heix10_sodium=10
replace heix10_sodium=0 if sodden>=sodmax
replace heix10_sodium=10-(10*(sodden-sodmin)/(sodmax-sodmin))
gen rgden=g_nwhl/(kcal/1000)
gen rgmin=1.8
gen rgmax=4.3
gen heix11_refinedgrain=10
replace heix11_refinedgrain=0 if rgden>=rgmax
replace heix11_refinedgrain=10-(10*(rgden-rgmin)/(rgmax-rgmin))


gen addedsugar_perc=100*add_sug*16/kcal
gen addsugmin=6.5
gen addsugmax=26
gen heix12_addedsugar=0 if addedsugar_perc>=addsugmax
replace heix12_addedsugar=10 if addedsugar_perc<=addsugmin
replace heix12_addedsugar=10-(10*(addedsugar_perc-addsugmin)/(addsugmax-addsugmin))



gen saturatedfat_perc=100*SatFat*9/kcal
gen saturatedfatmin=7
gen saturatedfatmax=15
gen heix13_saturatedfat=0 if saturatedfat_perc>=saturatedfatmax
replace heix13_saturatedfat=10 if saturatedfat_perc<=saturatedfatmin
replace heix13_saturatedfat=10-(10*(saturatedfat_perc-saturatedfatmin)/(saturatedfatmax-saturatedfatmin))


foreach var in vegden grbnden frtden whfrden wgrnden dairyden meatden seaplden faratio sodden rgden {
replace `var'=0 if `var'==.
}




foreach var in 1_totalveg 2_greens_and_bean 3_totalfruit 4_wholefruit 5_wholegrain 6_totaldairy 7_totprot 8_seaplant 9_fattyacid 10_sodium 11_refinedgrain 12_addedsugar 13_saturatedfat {
replace heix`var'=0 if kcal==0
}
foreach var in 1_totalveg 2_greens_and_bean 3_totalfruit 4_wholefruit 5_wholegrain 6_totaldairy 7_totprot 8_seaplant 9_fattyacid 10_sodium 11_refinedgrain 12_addedsugar 13_saturatedfat {
replace heix`var'=0 if heix`var'<0 & heix`var'!=.
}
foreach var in 9_fattyacid 10_sodium 11_refinedgrain {
replace heix`var'=10 if heix`var'>10 & heix`var'!=.
}
replace heix12_addedsugar=10 if heix12_addedsugar>10 & heix12_addedsugar!=.
replace heix13_saturatedfat=10 if heix13_saturatedfat>10 & heix13_saturatedfat!=.


gen hei2015_total_score=heix1_totalveg+heix2_greens_and_bean+heix3_totalfruit+ ///
heix4_wholefruit+heix5_wholegrain+heix6_totaldairy+heix7_totprot+heix8_seaplant ///
+heix9_fattyacid+heix10_sodium+heix11_refinedgrain+heix12_addedsugar+heix13_saturatedfat



label var hei2015_total_score "total hei-2015 score"
label var heix1_totalveg "hei-2015 component 1 total vegetables"
label var heix2_greens_and_bean "hei-2015 component 2 greens and beans"
label var heix3_totalfruit "hei-2015 component 3 total fruit"
label var heix4_wholefruit "hei-2015 component 4 whole fruit"
label var heix5_wholegrain "hei-2015 component 5 whole grains"
label var heix6_totaldairy "hei-2015 component 6 dairy"
label var heix7_totprot "hei-2015 component 7 total protein foods"

label var heix8_seaplant_prot "hei-2015 component 8 seafood and plant protein"
label var heix9_fattyacid "hei-2015 component 9 fatty acid ratio"
label var heix10_sodium "hei-2015 component 10 sodium"
label var heix11_refinedgrain "hei-2015 component 11 refined grains"
label var heix12_addedsugar "hei-2015 component 12 added sugar"
label var heix13_saturatedfat "hei-2015 component 13 saturated fat"

label var vegden "density of mped total vegetables per 1000 kcal"
label var grbnden "density of mped of dark green veg and beans per 1000 kcal"
label var frtden "density of mped total fruit per 1000 kcal"
label var whfrden "density of mped whole fruit per 1000 kcal"
label var wgrnden "density of mped of whole grain per 1000 kcal"
label var dairyden "density of mped of dairy per 1000 kcal"
label var meatden "density of mped total meat/protein per 1000 kcal"
label var seaplden "denstiy of mped of seafood and plant protein per 1000 kcal"
label var faratio "fatty acid ratio"
label var sodden "density of sodium per 1000 kcal"
label var rgden "density of mped of refined grains per 1000 kcal"
label var addedsugar_perc "percent of calories from added sugar"
label var saturatedfat_perc "percent of calories from saturated fat"

save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\HEI2015", replace

keep seqn hei* vegden grbnden frtden whfrden dairyden meatden seaplden faratio sodden rgden addedsugar_perc saturatedfat_perc-saturatedfat_perc 

su hei*

save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\HEI2015", replace
capture drop _merge
sort seqn
save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\HEI2015", replace


//STEP 11: MERGE THIS FILE WITH THE MAIN FILE AND CREATE SES variable//

use "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\HEI2015", clear
sort seqn
save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\HEI2015",replace


use "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\NHANES_MERGED_DATASET",clear
sort seqn
save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\NHANES_MERGED_DATASET",replace

merge seqn using "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\HEI2015"
save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\NHANES_MERGED_DATASET",replace


use "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\NHANES_MERGED_DATASET",clear

su indfmpir dmdeduc2


**DMDEDUC2 (Adults, 20+ years) is usually coded as:
**1: Less than 9th grade
**2: 9–11th grade (includes 12th grade with no diploma)
**3: High school graduate or equivalent (GED)
**4: Some college or AA degree
**5: College graduate or above


**INDFMPIR (Family PIR - Poverty Income Ratio)
**The PIR (Poverty Income Ratio) is calculated as the ratio of family income to the poverty threshold.
**It is a continuous variable, often ranging from 0 to 5 (capped at 5 for high-income participants).

capture drop pir
gen pir=.
replace pir=indfmpir if indfmpir~=7 & indfmpir~=9
su pir
histogram pir

capture drop education
gen education=.
replace education=dmdeduc2

capture drop ses
pca pir education,factors(1)
predict ses

su ses
histogram ses

save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\NHANES_MERGED_DATASET",replace
capture drop _merge
sort seqn 
save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\NHANES_MERGED_DATASET",replace


capture log close
capture log using "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\OUTPUT\NHANES_FRAILTY_SCORE.smcl",replace



******CONTINUE FROM HERE*****************

*******STEP 12: GENERATE FRAILTY SCORE AND STATUS***********************




*****************BMX***********************************************
clear
import sasxport5 "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\BMX.xpt"
save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\BMX.dta",replace
capture drop cycle
gen cycle=1
save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\BMX.dta",replace

clear
import sasxport5 "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\BMX_B.xpt"
save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\BMX_B.dta",replace
capture drop cycle
gen cycle=2
save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\BMX_B.dta",replace

use "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\BMX.dta",clear
append using "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\BMX_B.dta" 
sort seqn
save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\BMX_AB.dta",replace


*************PAQ************************************************
clear
import sasxport5 "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\PAQ.xpt"
save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\PAQ.dta",replace
capture drop cycle
gen cycle=1
save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\PAQ.dta",replace

clear
import sasxport5 "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\PAQ_B.xpt"
save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\PAQ_B.dta",replace
capture drop cycle
gen cycle=2
save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\PAQ_B.dta",replace

use "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\PAQ.dta",clear
append using "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\PAQ_B.dta" 
sort seqn
save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\PAQ_AB.dta",replace

****************PFQ************************
clear
import sasxport5 "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\PFQ.xpt"
save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\PFQ.dta",replace
capture drop cycle
gen cycle=1
save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\PFQ.dta",replace

clear
import sasxport5 "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\PFQ_B.xpt"
save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\PFQ_B.dta",replace
capture drop cycle
gen cycle=2
save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\PFQ_B.dta",replace

use "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\PFQ.dta",clear
append using "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\PFQ_B.dta"
sort seqn 
save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\PFQ_AB.dta",replace

**************************MERGE DEMO_AB with BMX_AB, PAQ_AB and PFQ_AB***************

use "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\DEMO_AB",clear
sort seqn
capture drop _merge
save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\DEMO_AB",replace
merge seqn using "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\BMX_AB.dta"
tab _merge
capture drop _merge
sort seqn
merge seqn using "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\PAQ_AB.dta" 
tab _merge
capture drop _merge
sort seqn
merge seqn using "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\PFQ_AB.dta"
capture drop _merge
sort seqn
save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\FRAILTY_NHANES.dta", replace




*********************************************
* 1. Shrinking (Low BMI proxy for unintentional weight loss)
capture drop frail_shrinking
gen frail_shrinking = .
replace frail_shrinking = 1 if bmxbmi < 18.5 & bmxbmi~=.
replace frail_shrinking = 0 if bmxbmi >= 18.5 & bmxbmi~=. 


* 2. Weakness (Lifting carrying difficulty)


**1999-00**
**Variable Name:PFQ060eSAS Label:Lifting or carrying difficultyEnglish Text:By {yourself/himself/herself} and without using any special equipment, how much difficulty {do you/does SP} have . **. .lifting or carrying something as heavy as 10 pounds [like a sack of potatoes or rice]?Target:Both males and females 20 YEARS - 120 YEARS
**Code or Value	Value Description	Count	Cumulative	Skip to Item
**1	No difficulty	1510	1510	
**2	Some difficulty	362	1872	
**3	Much difficulty	143	2015	
**4	Unable to do	244	2259	
**7	Refused	0	2259	
**9	Don't know	4	2263	
**.	Missing	7230	9493	

**Combined waves**

tab pfq060e, miss


** Lifting or |
**   carrying |
** difficulty |      Freq.     Percent        Cum.
**------------+-----------------------------------
**          1 |      3,117       14.84       14.84
**          2 |        773        3.68       18.52
**          3 |        307        1.46       19.98
**          4 |        494        2.35       22.33
**          9 |         12        0.06       22.39
**          . |     16,301       77.61      100.00
**------------+-----------------------------------
**     Total |     21,004      100.00

capture drop frail_weakness
gen frail_weakness=.
replace frail_weakness=0 if pfq060e==1
replace frail_weakness=1 if pfq060e==2 | pfq060e==3 | pfq060e==4 
replace frail_weakness=. if pfq060e==7 | pfq060e==9 

tab frail_weakness

* 3. Slowness (Difficulty walking ¼ mile)


**Variable Name:PFQ060bSAS Label:Walking for a quarter mile difficultyEnglish Text:By {yourself/himself/herself} and without using any special equipment, how much difficulty {do you/does SP} **have . . .walking for a quarter of a mile [that is about 2 or 3 blocks]?English Instructions:HAND CARD PFQ1. DO NOT INCLUDE TEMPORARY CONDITIONS LIKE PREGNANCY OR BROKEN LIMBS. CAPI **INSTRUCTION: IF PFQ.055 = '1' (YES), DO NOT DISPLAY 'B' OR 'C'. IF SP FEMALE, DISPLAY 'NOT INCLUDING PREGNANCY'.Target:Both males and females 20 YEARS - 120 YEARS
**Code or Value	Value Description	Count	Cumulative	Skip to Item
**1	No difficulty	1347	1347	
**2	Some difficulty	367	1714	
**3	Much difficulty	155	1869	
**4	Unable to do	155	2024	
**7	Refused	0	2024	
**9	Don't know	5	2029	
**.	Missing	7464	9493	

tab pfq060b, miss


**Walking for |
**  a quarter |
**       mile |
** difficulty |      Freq.     Percent        Cum.
**------------+-----------------------------------
**          1 |      2,780       13.24       13.24
**          2 |        751        3.58       16.81
**          3 |        302        1.44       18.25
**          4 |        337        1.60       19.85
**          9 |          9        0.04       19.90
**          . |     16,825       80.10      100.00
**------------+-----------------------------------
**      Total |     21,004      100.00



capture drop frail_slowness
gen frail_slowness = .
replace frail_slowness = 0 if pfq060b == 1  // No
replace frail_slowness = 1 if pfq060b == 2  | pfq060b == 3 | pfq060b == 4 // Yes
replace frail_slowness = . if pfq060b == 7  | pfq060b == 9

tab  frail_slowness


* 4. Low physical activity (PAD200: vigorous activity over the past 30 days; PAD320: moderate activity over the past 30 days)


****Low physical activity: vigorous or moderate activity (0=higher activity, 1=lower activity)**


***Vigorous activity****

**Variable Name:PAD200SAS Label:Vigorous activity over past 30 daysEnglish Text:The next questions are about physical activities including exercise, sports, and physically active hobbies **that {you/SP} may have done in {your/his/her} leisure time or at school over the past 30 days. First I will ask you about vigorous activities that cause heavy sweating or large increases in breathing or heart rate. Then I will ask you about moderate activities that cause only light sweating or a slight to moderate increase in breathing or heart rate. Over the past 30 days, did {you/SP} do any vigorous activities for at least 10 minutes that caused heavy sweating, or large increases in breathing or heart rate? Some examples are running, lap swimming, aerobics **classes or fast bicycling.English Instructions:CODE 'UNABLE TO DO' ONLY IF RESPONDENT VOLUNTEERS.Target:Both males and females 12 YEARS - 150 YEARS
**Code or Value	Value Description	Count	Cumulative	Skip to Item
**1	Yes	2654	2654	
**2	No	4244	6898	
**3	Unable to do activity	293	7191	
**7	Refused	5	7196	
**9	Don't know	2	7198	
**.	Missing	1990	9188	



tab pad200


**   Vigorous |
**   activity |
**  over past |
**    30 days |      Freq.     Percent        Cum.
**------------+-----------------------------------
**          1 |      5,841       38.98       38.98
**          2 |      8,524       56.89       95.87
**          3 |        606        4.04       99.91
**          7 |          9        0.06       99.97
**          9 |          4        0.03      100.00
**------------+-----------------------------------
**      Total |     14,984      100.00


tab pad200, miss


**   Vigorous |
**   activity |
**  over past |
**    30 days |      Freq.     Percent        Cum.
**------------+-----------------------------------
**          1 |      5,841       27.81       27.81
**          2 |      8,524       40.58       68.39
**          3 |        606        2.89       71.28
**          7 |          9        0.04       71.32
**          9 |          4        0.02       71.34
**          . |      6,020       28.66      100.00
**------------+-----------------------------------
**      Total |     21,004      100.00




capture drop pad200r
gen pad200r=.
replace pad200r=0 if pad200==1
replace pad200r=1 if pad200==2 | pad200==3 
replace pad200r=. if pad200r~=0 & pad200r~=1 

tab pad200r

***********Moderate activity*********
**Variable Name:PAD320SAS Label:Moderate activity over past 30 daysEnglish Text:[Over the past 30 days], did {you/SP} do moderate activities for at least 10 minutes that cause only light **sweating or a slight to moderate increase in breathing or heart rate? Some examples are brisk walking, bicycling for pleasure, golf, and dancing .English Instructions:CODE 'UNABLE TO DO' **ONLY IF RESPONDENT VOLUNTEERS.Target:Both males and females 12 YEARS - 150 YEARS
**Code or Value	Value Description	Count	Cumulative	Skip to Item
**1	Yes	2908	2908	
**2	No	4031	6939	
**3	Unable to do activity	250	7189	
**7	Refused	6	7195	
**9	Don't know	3	7198	
**.	Missing	1990	9188	

tab pad320


**   Moderate |
**   activity |
**  over past |
**    30 days |      Freq.     Percent        Cum.
**------------+-----------------------------------
**          1 |      6,646       44.36       44.36
**          2 |      7,832       52.28       96.64
**          3 |        487        3.25       99.89
**          7 |         11        0.07       99.96
**          9 |          6        0.04      100.00
**------------+-----------------------------------
**      Total |     14,982      100.00

tab pad320,miss


**   Moderate |
**   activity |
**  over past |
**    30 days |      Freq.     Percent        Cum.
**------------+-----------------------------------
**          1 |      6,646       31.64       31.64
**          2 |      7,832       37.29       68.93
**          3 |        487        2.32       71.25
**          7 |         11        0.05       71.30
**          9 |          6        0.03       71.33
**          . |      6,022       28.67      100.00
**------------+-----------------------------------
**      Total |     21,004      100.00




capture drop pad320r
gen pad320r=.
replace pad320r=0 if pad320==1
replace pad320r=1 if pad320==2 |  pad320==3
replace pad320r=. if pad320r~=0 & pad320r~=1


capture drop frail_activity
gen frail_activity = .
replace frail_activity = 1 if pad200r == 1 | pad320r == 1 
replace frail_activity = 0 if frail_activity~=1 & pad200r~=. & pad320r~=.

tab frail_activity


* 5. Fatigue (proxy using difficulty climbing stairs)

**Variable Name:PFQ060cSAS Label:Walking up ten steps difficultyEnglish Text:By {yourself/himself/herself} and without using any special equipment, how much difficulty {do you/does SP} have **. . .walking up 10 steps without resting?English Instructions:HAND CARD PFQ1. DO NOT INCLUDE TEMPORARY CONDITIONS LIKE PREGNANCY OR BROKEN LIMBS. CAPI INSTRUCTION: IF PFQ.055 = '1' (YES), **DO NOT DISPLAY 'B' OR 'C'. IF SP FEMALE, DISPLAY 'NOT INCLUDING PREGNANCY'.Target:Both males and females 20 YEARS - 120 YEARS
**Code or Value	Value Description	Count	Cumulative	Skip to Item
**1	No difficulty	1449	1449	
**2	Some difficulty	367	1816	
**3	Much difficulty	112	1928	
**4	Unable to do	93	2021	
**7	Refused	0	2021	
**9	Don't know	8	2029	
**.	Missing	7464	9493	

tab pfq060c, miss

** Walking up |
**  ten steps |
** difficulty |      Freq.     Percent        Cum.
**------------+-----------------------------------
**          1 |      3,020       14.38       14.38
**          2 |        703        3.35       17.73
**          3 |        241        1.15       18.87
**          4 |        197        0.94       19.81
**          9 |         18        0.09       19.90
**          . |     16,825       80.10      100.00
**------------+-----------------------------------
**      Total |     21,004      100.00

tab pfq060c


** Walking up |
**  ten steps |
** difficulty |      Freq.     Percent        Cum.
**------------+-----------------------------------
**          1 |      3,020       72.27       72.27
**          2 |        703       16.82       89.09
**          3 |        241        5.77       94.86
**          4 |        197        4.71       99.57
**          9 |         18        0.43      100.00
**------------+-----------------------------------
**      Total |      4,179      100.00


capture drop pfq060cr
gen pfq060cr=.
replace pfq060cr=0 if pfq060c==1
replace pfq060cr=1 if pfq060c==2 | pfq060c==3 | pfq060c==4

tab pfq060cr
 

capture drop frail_fatigue
gen frail_fatigue = .
replace frail_fatigue = 1 if pfq060cr == 1   // Yes
replace frail_fatigue = 0 if frail_fatigue~=1 & pfq060cr~=.   // No

tab  frail_fatigue


* Total frailty score: 0 to 5
capture drop frailty_score
gen frailty_score = frail_shrinking+frail_weakness+frail_slowness+frail_activity+frail_fatigue

tab frailty_score


* Categorical frailty classification
capture drop frailty_status
gen frailty_status = .
replace frailty_status = 0 if frailty_score == 0      // Robust
replace frailty_status = 0 if frailty_score == 1 | frailty_score == 2   // Pre-frail
replace frailty_status = 1 if frailty_score >= 3  & frailty_score~=.    // Frail


tab frailty_status

save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\FRAILTY_NHANES.dta", replace

capture log close
capture log using "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\OUTPUT\NHANES_FIGURES1_PARTICIPANT_FLOWCHART.smcl",replace



//STEP 13: MERGE FRAILTY DATA WITH OTHER VARIABLES IN NHANES//

use "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\FRAILTY_NHANES.dta",clear
capture drop _merge
sort seqn
save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\FRAILTY_NHANES.dta",replace

merge seqn using "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\NHANES_MERGED_DATASET"
tab _merge
sort seqn
capture drop _merge
save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\NHANES_MERGED_DATASETfin",replace



//STEP 14: STUDY SAMPLE SELECTION STEP, INVERSE MILLS RATIO, USING AGE>=50Y RESTRICTION//

**AGE 50+ Y**

capture drop sample1
gen sample1=.
replace sample1=1 if AGE>=50 & AGE~=.
replace sample1=0 if sample1~=1

tab sample1   


**HEI-2015 and SES DATA AVAILABLE**

capture drop sample2
gen sample2=.
replace sample2=1 if frailty_score~=.   & ses~=.
replace sample2=0 if sample2~=1

tab sample2  



**EPIGENETIC CLOCK DATA AVAILABLE**

capture drop sample3
gen sample3=.
replace sample3=1 if zHorvathAgeEAA~=. & zHannumAgeEAA~=. & zPhenoAgeEAA~=. & zGrimAgeMortEAA~=. & zDunedinPoAm~=.
replace sample3=0 if sample3~=1

tab sample3  


**HEI DATA AVAILABLE AND 50+Y**

capture drop sample4
gen sample4=.
replace sample4=1 if sample1==1 & sample2==1
replace sample4=0 if sample4~=1

tab sample4


**HEI and EPIGENETIC CLOCK DATA AVAILABLE AND 50+Y**


capture drop sample5
gen sample5=.
replace sample5=1 if sample4==1 & sample3==1
replace sample5=0 if sample5~=1

tab sample5


capture drop sample_final
gen sample_final=sample5


tab sample_final

**Inverse mills ratio**

capture drop sample_final_age50plus
gen sample_final_age50plus=.
replace sample_final_age50plus=1 if sample_final==1
replace sample_final_age50plus=0 if sample_final==0 & AGE>=50 & AGE~=.

tab sample_final_age50plus


xi:probit sample_final_age50plus AGE SEX i.RACE

capture drop p1fin
predict p1fin, xb

capture drop phifin
capture drop caphifin
capture drop invmillsfin

gen phifin=(1/sqrt(2*_pi))*exp(-(p1fin^2/2))

egen caphifin=std(p1fin)

capture drop invmillsfin
gen invmillsfin=phifin/caphifin


su invmillsfin
histogram invmillsfin



save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\NHANES_MERGED_DATASETfin",replace



capture log close
capture log using "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\OUTPUT\NHANES_KAPLANMEIERCURVES.smcl",replace


use "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\NHANES_MERGED_DATASETfin",clear


//STEP 11: KAPLAN MEIER SURVIVAL CURVES BY TERTILES OF EACH EPIGENETIC CLOCK, EPIGENETIC EAA AND TL VARIABLES//

capture drop zfrailty_score zses
foreach x of varlist frailty_score ses {
	egen z`x'=std(`x') if sample_final==1
} 

capture drop zHorvathAgeEAAtert zHannumAgeEAAtert zPhenoAgeEAAtert zGrimAgeMortEAAtert zDunedinPoAmtert zsestert

foreach var of varlist zHorvathAgeEAA zHannumAgeEAA zPhenoAgeEAA zGrimAgeMortEAA zDunedinPoAm zses  {
	xtile `var'tert=`var' if sample_final==1,nq(3)

}

save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\NHANES_MERGED_DATASETfin",replace


tab1 *tert 


foreach var of varlist *tert frailty_status {
	sts test `var'
}


foreach var of varlist *tert frailty_status {
	sts graph, by(`var')
graph save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FIGURES\NHANES_FIGURE1_KM\FIGURE1`var'.gph",replace
} 

graph combine "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FIGURES\NHANES_FIGURE1_KM\FIGURE1zHorvathAgeEAAtert.gph" ///
"E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FIGURES\NHANES_FIGURE1_KM\FIGURE1zDunedinPoAmtert.gph" ////
"E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FIGURES\NHANES_FIGURE1_KM\FIGURE1zGrimAgeMortEAAtert.gph"  ///
"E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FIGURES\NHANES_FIGURE1_KM\FIGURE1zHannumAgeEAAtert.gph"  ///
"E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FIGURES\NHANES_FIGURE1_KM\FIGURE1zPhenoAgeEAAtert.gph"  ///
"E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FIGURES\NHANES_FIGURE1_KM\FIGURE1frailty_status.gph"  ///
"E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FIGURES\NHANES_FIGURE1_KM\FIGURE1zsestert.gph"  ///


graph save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FIGURES\NHANES_FIGURE1_KM\FIGURE1combined.gph",replace

save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\NHANES_MERGED_DATASETfin",replace




capture log close
capture log using "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\OUTPUT\NHANES_CORRELATIONS_EPIGENEITC_TELO.smcl",replace


//STEP 12: CORRELATION MATRIX BETWEEN EPIGENTIC AGE ACCELERATION, EPIGENETIC CLOCKS AND TL VARIABLES//

use "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\NHANES_MERGED_DATASETfin",clear


// Step 1: Run the correlation command and save the matrix
corr zHorvathAgeEAA zHannumAgeEAA zPhenoAgeEAA zGrimAgeMortEAA zDunedinPoAm ses frailty_score  if sample_final==1
matrix C = r(C)

// Step 2: Clear the current dataset (optional if you don't need it)
clear

// Step 3: Convert the matrix to a dataset with unique variable names
svmat C, names(col)

// Step 4: Save the dataset as a CSV file
capture export delimited using "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\OUTPUT\NHANES\NHANES_correlation_matrix.csv", replace

**Add a column in excel sheet and re-type labels mannually. Change labels as needed. 


// Step 5: Reload your original dataset if needed

use "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\NHANES_MERGED_DATASETfin",clear

capture log close



//STEP 13: RStudio code for heatmap: Run IN RStudio//

## ============================================================
## NHANES (Windows):
##   Top  = Kernel-smoothed frailty_score distribution
##   Bottom = Correlation heatmap from external CSV
## ============================================================

library(haven)
library(dplyr)
library(tidyr)
library(ggplot2)
library(patchwork)

## ------------------------------------------------------------
## 1) Paths (Windows-safe)
## ------------------------------------------------------------
nhanes_data_path <- "E://16GBBACKUPUSB//BACKUP_USB_SEPTEMBER2014//SUMMER_STUDENT_2025//HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT//FINAL_DATA/NHANES//"

nhanes_corr_file <- "E://16GBBACKUPUSB//BACKUP_USB_SEPTEMBER2014//SUMMER_STUDENT_2025//HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT//OUTPUT//NHANES//NHANES_correlation_matrix_final.csv"

## ------------------------------------------------------------
## 2) Load NHANES analytic dataset (for density plot)
## ------------------------------------------------------------
## CHANGE the filename below to match your actual file in FINAL_DATA/NHANES
df <- read_dta(file.path(nhanes_data_path, "NHANES_MERGED_DATASET_SMALLfin.dta"))

plot_df <- df %>%
  transmute(frailty_score = as.numeric(frailty_score)) %>%
  filter(is.finite(frailty_score))

p_density <- ggplot(plot_df, aes(x = frailty_score)) +
  geom_density(kernel = "gaussian", linewidth = 1.1, adjust = 1) +
  geom_rug(alpha = 0.25) +
  labs(
    x = "Frailty score",
    y = "Kernel-smoothed density",
    title = "Kernel-smoothed distribution of frailty score (NHANES)"
  ) +
  theme_classic()

## ------------------------------------------------------------
## 3) Load correlation matrix CSV (for heatmap)
## ------------------------------------------------------------
## Assumes first column is row names and headers are column names
corr_mat <- read.csv(
  nhanes_corr_file,
  row.names = 1,
  check.names = FALSE
)

## Ensure it is numeric matrix
corr_mat <- as.matrix(corr_mat)
mode(corr_mat) <- "numeric"

## Convert to long format for ggplot
corr_long <- as.data.frame(as.table(corr_mat)) %>%
  rename(var1 = Var1, var2 = Var2, r = Freq) %>%
  mutate(
    var1 = factor(var1, levels = colnames(corr_mat)),
    var2 = factor(var2, levels = rev(colnames(corr_mat)))
  )

p_heat <- ggplot(corr_long, aes(x = var1, y = var2, fill = r)) +
  geom_tile() +
  geom_text(aes(label = sprintf("%.2f", r)), size = 3) +
  coord_fixed() +
  scale_fill_gradient2(
    low = "#2166AC",
    mid = "white",
    high = "#B2182B",
    midpoint = 0,
    limits = c(-1, 1),
    name = "r"
  ) +
  labs(
    x = NULL,
    y = NULL,
    title = "Pearson correlation heatmap (NHANES)"
  ) +
  theme_minimal(base_size = 11) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1),
    panel.grid = element_blank()
  )

## ------------------------------------------------------------
## 4) Stack them vertically
## ------------------------------------------------------------
combined_plot <- p_density / p_heat + plot_layout(heights = c(1, 2))
combined_plot

## ------------------------------------------------------------
## 5) Optional: save output (Windows-safe)
## ------------------------------------------------------------
# ggsave(
#   filename = "E://16GBBACKUPUSB//BACKUP_USB_SEPTEMBER2014//SUMMER_STUDENT_2025//HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT//OUTPUT//NHANES//NHANES_density_plus_heatmap.png",
#   plot = combined_plot,
#   width = 11,
#   height = 13,
#   dpi = 300
# )


capture log close

capture log using "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\OUTPUT\NHANES_HEATMAPCOX.txt", text replace

//STEP 15: HEATMAP FOR HEI-2010, EPIGENETIC CLOCKS VS. MORTALITY RISK, ADJUSTING AGE, SEX AND RACE: COX MODEL///

use "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\NHANES_MERGED_DATASETfin",clear

stset TIMEyears [pweight=WTDN4YR] , id(seqn) failure(DIED==1)

capture drop AGESQ
gen AGESQ=AGE*AGE


save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\NHANES_MERGED_DATASETfin",replace


* Install estout if not already installed
ssc install estout, replace

* Clear any previous estimates
est clear

* Start the loop
foreach x of varlist zHorvathAgeEAA zHannumAgeEAA zPhenoAgeEAA zGrimAgeMortEAA zDunedinPoAm  frailty_status  zses { 
    
        * Run the stcox command
        stcox `x' AGE SEX i.RACE if sample_final==1
        
        * Store the estimates
        eststo output`x'
    }



* Export the results to a dataset
esttab using "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\results_TABLE5.csv", replace se ar2

capture import delimited "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\results_TABLE5.csv", clear

use "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\NHANES_MERGED_DATASETfin",clear



* Start the loop
foreach x of varlist zHorvathAgeEAA zHannumAgeEAA zPhenoAgeEAA zGrimAgeMortEAA zDunedinPoAm  frailty_status  zses { 
    
        * Run the stcox command
        stcox `x' AGE SEX i.RACE  AGESQ if sample_final==1
        
        * Store the estimates
        eststo output`x'
    }



* Export the results to a dataset
esttab using "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\results_TABLE5_SENS.csv", replace se ar2

capture import delimited "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\results_TABLE5_SENS.csv", clear



* Convert the CSV file to a Stata dataset (if needed)
save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\results_TABLE5_SENS.dta",replace



**Fix the dataset so it is simpler. This is saved as : cleaned_results_TABLE5_final.csv in the same folder**

use "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\NHANES_MERGED_DATASETfin",clear

save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\NHANES_MERGED_DATASETfin",replace



**STEP 17: FIGURE 3: ERROR BARS FOR COX MODELS**

**# Load necessary library
**library(ggplot2)

**# Read the dataset
**data <- read.csv("E:/16GBBACKUPUSB/BACKUP_USB_SEPTEMBER2014/SUMMER_STUDENT_2025/HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT/FINAL_DATA/NHANES/cleaned_results_TABLE5_MODEL1.csv")

**# Rename columns for clarity
**colnames(data) <- c("Variable", "LnHR", "SE")

**# Calculate upper and lower bounds for error bars
**data$Upper <- data$LnHR + 1.96 * data$SE
**data$Lower <- data$LnHR - 1.96 * data$SE

**# Plot with error bars
**ggplot(data, aes(x = Variable, y = LnHR)) +
**  geom_point(size = 3, color = "blue") +
**  geom_errorbar(aes(ymin = Lower, ymax = Upper), width = 0.2, color = "red") +
**  theme_minimal() +
**  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
**  labs(title = "Log Hazard Ratios with Error Bars",
**       x = "Variable",
**       y = "Log Hazard Ratio (LnHR)")




capture log close

capture log using "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\OUTPUT\NHANES_VARDISCRETIZATION.smcl",replace




//STEP 16: DISCRETIZE VARIABLES FOR ABN ANALYSIS AND GENERATE DATASET FOR R; CREATE A VARIABLE COHORT=1 (NHANES)//

use "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\NHANES_MERGED_DATASETfin",clear

keep if sample_final==1

keep seqn  AGE SEX RACE zHorvathAgeEAA zHannumAgeEAA zPhenoAgeEAA zGrimAgeMortEAA zDunedinPoAm frailty_status ses _st _d _t _t0 

save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\NHANES_MERGED_DATASET_ABN",replace



**AGE**
capture drop AGEbr
xtile AGEbr = AGE, nq(100)
bysort AGEbr: egen AGE_median = median(AGE)
replace AGE_median = round(AGE_median, 0.01)
replace AGE = AGE_median
histogram AGE
tab AGE

**SEX***
tab SEX
recode SEX (1=0) (2=1)

tab SEX


**NonWhite RACES**

**Non-Hispanic Black**

capture drop NHB
gen NHB=.
replace NHB=1 if RACE==1
replace NHB=0 if RACE~=. & NHB~=1

tab NHB

**Hispanic**
capture drop HISP
gen HISP=.
replace HISP=1 if RACE==2
replace HISP=0 if RACE~=. & HISP~=1

tab HISP

**Other**
capture drop OTHER
gen OTHER=.
replace OTHER=1 if RACE==3
replace OTHER=0 if RACE~=. & OTHER~=1

tab OTHER



*EPIGENETIC CLOCKS,SES AND HEI*

capture drop zz*
foreach x of varlist zHorvathAgeEAA zHannumAgeEAA zPhenoAgeEAA zGrimAgeMortEAA zDunedinPoAm  ses    {
	egen z`x'=std(`x')
}

capture rename zz* z*


foreach x of varlist zHorvathAgeEAA zHannumAgeEAA zPhenoAgeEAA zGrimAgeMortEAA zDunedinPoAm  zses    {
capture drop `x'br
xtile `x'br = `x', nq(100)
bysort `x'br: egen `x'_median = median(`x')
replace `x'_median = round(`x'_median, 0.01)
replace `x' = `x'_median
histogram `x' 
tab `x'

}

*MORTALITY*
tab _d


save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\NHANES_MERGED_DATASET_ABN",replace

capture drop COHORT
gen COHORT=1

keep seqn AGE SEX NHB HISP OTHER zHorvathAgeEAA zHannumAgeEAA zPhenoAgeEAA zGrimAgeMortEAA zDunedinPoAm frailty_status zses  _d _st _d _t _t0 COHORT


save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\NHANES_MERGED_DATASET_ABN_SMALL",replace



capture log close
capture log using "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\OUTPUT\NHANES_DISCRETE_TIME_HAZARD_ABN.smcl",replace


//STEP 17: GENERATE DATASET WITH DISCRETE TIME HAZARDS: 2 YR INTERVALS: FRIDAY PLUS CORRECT FIGURES USING SAMPLING WEIGHTS (K-M and Error bar) //

use "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\NHANES_MERGED_DATASET_ABN_SMALL",clear

sort seqn

save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\NHANES_MERGED_DATASET_ABN_SMALL",replace


* Step 1: Expand the dataset
capture drop period
gen period = floor(_t / 2) + 1  // Create time periods based on 2-year intervals
expand period  // Expand the dataset for each time period

* Step 2: Create time variables for analysis
capture drop start_time
capture drop end_time

bysort seqn: gen start_time = (_n - 1) * 2  // Start of each 2-year period
bysort seqn: gen end_time = start_time + 2  // End of each 2-year period

* Step 3: Indicate event occurrence in each period
capture drop event

gen event = (_d == 1 & _t <= end_time & _t > start_time)

* Step 4: Create dummy variables for each 2-year interval
gen interval = floor(start_time / 2) + 1  // Create interval number
tabulate interval, generate(dummy)  // Generate dummy variables for each interval


logistic _d dummy1-dummy10 AGE SEX NHB HISP OTHER zHorvathAgeEAA zHannumAgeEAA zPhenoAgeEAA zGrimAgeMortEAA zDunedinPoAm frailty_status zses  

sort seqn 

save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\NHANES_MERGED_DATASET_ABN_DISCRETE",replace


use "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\NHANES_MERGED_DATASET_ABN_DISCRETE",clear

capture rename _d d_var

keep AGE SEX NHB HISP OTHER d_var dummy* zHorvathAgeEAA zHannumAgeEAA zPhenoAgeEAA zGrimAgeMortEAA zDunedinPoAm frailty_status zses

order AGE  zHorvathAgeEAA zHannumAgeEAA zPhenoAgeEAA zGrimAgeMortEAA zDunedinPoAm frailty_status SEX d_var NHB HISP OTHER dummy1 dummy2 dummy3 dummy4 dummy5 dummy6 dummy7 dummy8 dummy9 dummy9 dummy10 dummy11 zses


save "E:\16GBBACKUPUSB\BACKUP_USB_SEPTEMBER2014\SUMMER_STUDENT_2025\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\FINAL_DATA\NHANES\NHANES_MERGED_DATASET_ABN_DISCRETEfin",replace

capture log close 


//STEP 18: RSTUDIO CODE FOR ABN//



##Step 0: install abn and other related packages on newer version of R, install JAGS manually**

##Install R version 4.4 or higher**

install.packages("INLA",repos=c(getOption("repos"),INLA="https://inla.r-inla-download.org/R/stable"), dep=TRUE)

if (!requireNamespace("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install(c("graph", "Rgraphviz"), dep=TRUE)


install.packages("memisc", repos = c("https://melff.r-universe.dev", "https://cloud.r-project.org"), dependencies=T)
library(memisc)


install.packages("abn", dependencies=T)
library(abn)

install.packages(c("nnet", "lme4", "Rgraphviz", "knitr", "R.rsp", "testthat", "entropy", "moments", "boot", "brglm", "dplyr"))

library(dplyr)
library(nnet)
library(lme4)
library(Rgraphviz)
library(knitr)
library(R.rsp)
library(testthat)
library(entropy)
library(moments)
library(boot)
library(brglm) 

install.packages("haven", dependencies=T)


## Step 1: Open file and do some data wrangling, create groups of variables

library(haven)
library(dplyr)

# Increase memory limit to 16 GB (adjust as needed)
memory.limit(size = 16000)

# Read the dataset
file_path <- "E:\\16GBBACKUPUSB\\BACKUP_USB_SEPTEMBER2014\\SUMMER_STUDENT_2025\\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\\FINAL_DATA\\NHANES\\NHANES_MERGED_DATASET_ABN_DISCRETEfin.dta"
data.df <- read_dta(file_path)

# Summary of data to inspect structure
summary(data.df)

# Convert variables to factors
factorvars <- c("SEX", "d_var", "NHB", "HISP", "OTHER", "dummy1", "dummy2", "dummy3", "dummy4", "dummy5", "dummy6", "dummy7", "dummy8", "dummy9", "dummy10", "dummy11", "frailty_status")
data.df[factorvars] <- lapply(data.df[factorvars], factor)

# Inspect structure of the data
str(data.df)

# Convert to data frame for further use
abndata <- as.data.frame(data.df)

# Define antecedent and outcome variables
antecedent_vars <- c("AGE", "SEX", "NHB", "HISP", "OTHER")
outcome_vars <- c("d_var")

# Step 2: Fit the additive Bayesian network using the abn package

# Define the data distributions
data.dists <- list(
  AGE = "gaussian",
  zHorvathAgeEAA = "gaussian",
  zHannumAgeEAA = "gaussian",
  zPhenoAgeEAA = "gaussian",
  zGrimAgeMortEAA = "gaussian",
  zDunedinPoAm = "gaussian",
  frailty_status = "binomial",
  SEX = "binomial",
  d_var = "binomial",
  NHB = "binomial",
  HISP = "binomial",
  OTHER = "binomial",
  dummy1 = "binomial",
  dummy2 = "binomial",
  dummy3 = "binomial",
  dummy4 = "binomial",
  dummy5 = "binomial",
  dummy6 = "binomial",
  dummy7 = "binomial",
  dummy8 = "binomial",
  dummy9 = "binomial",
  dummy10 = "binomial",
  dummy11 = "binomial",
  zses = "gaussian"
)

# Create an empty matrix for 'retain' and 'banned'
retain <- matrix(0, ncol(abndata), ncol(abndata))
colnames(retain) <- rownames(retain) <- names(abndata)

banned <- matrix(0, ncol(abndata), ncol(abndata))
colnames(banned) <- rownames(banned) <- names(abndata)

# Ban edges as needed from all variables into antecedent variables; and from final outcome into all other variables
# 1 (AGE), 8 (SEX), 10 (NHB), 11 (HISP), 12 (OTHER) Final outcome is #9, dummy times (13 to 16), epigenetic clocks 2 to 6; HEI is 7; zses is 17
banned[1, -1] <- 1
banned[8, -8] <- 1
banned[10, -10] <- 1
banned[11, -11] <- 1
banned[12, -12] <- 1
banned[-9, 9] <- 1
banned[7, 2] <- 1
banned[7, 3] <- 1
banned[7, 4] <- 1
banned[7, 5] <- 1
banned[7, 6] <- 1
banned[24, 2] <- 1
banned[24, 3] <- 1
banned[24, 4] <- 1
banned[24, 5] <- 1
banned[24, 6] <- 1
banned[24, 7] <- 1


# Ban future dummy times from predicting past dummy times
for (i in 13:22
) {
  for (j in (i+1):23) {
    banned[i, j] <- 1
  }
}

# Ensure all dummy variables directly predict d_var
dummy_vars <- paste0("dummy", 1:11)  # List of dummy variables
for (dummy in dummy_vars) {
  retain[dummy, "d_var"] <- 1
}


# Check the banned matrix
summary(banned)
View(banned)



# Check the retain matrix
summary(retain)
View(retain)

# Find overlapping edges between banned and retained
conflicts <- which(banned == 1 & retain == 1, arr.ind = TRUE)
print(conflicts)  # Should return an empty set if no conflicts exist

# Resolve conflicts by prioritizing bans (set to 0 in retained matrix)
retain[conflicts] <- 0


# Install the package if it's not already installed
if (!requireNamespace("abn", quietly = TRUE)) {
  install.packages("abn")
}

# Load the package
library(abn)


# Set max.parents
max.par <- 3

# Get the variable names from the dataset to ensure the order is correct
var_names <- colnames(abndata)

# Initialize the start.dag matrix with the correct dimensions (matching the number of variables)
start.dag <- matrix(0, nrow = length(var_names), ncol = length(var_names))
rownames(start.dag) <- colnames(start.dag) <- var_names

# Print the start.dag to check if it's correctly set up
print(start.dag)

# Build the score cache, with max.par = 3
mycache <- buildScoreCache(data.df = as.data.frame(abndata), data.dists = data.dists, 
                           dag.banned = banned, dag.retained=retain, max.parents = max.par)

# Perform the search for the DAG using Hill Climber, passing the start.dag as a matrix
mydag <- searchHillClimber(score.cache = mycache, start.dag = start.dag)

# If the search runs successfully, plot the DAG
plotAbn(dag = mydag)

fabn <- fitAbn(object = mydag)

summary(fabn)

plotAbn(dag = mydag, labels="TRUE")

fabn <- fitAbn(object = mydag)

plot(fabn)



##########Loop over max.parents 1 to 3########################

datadir <- tempdir()

for (i in 1:3) {
  
  max.par <- i
  
mycache <- buildScoreCache(data.df = as.data.frame(abndata), data.dists = data.dists, 
                             dag.banned = banned, dag.retained = retain, 
                             max.parents = max.par)


mydag <- searchHillClimber(score.cache = mycache, start.dag = NULL)
  
fabn <- fitAbn(object = mydag)

cat(paste("network score for", i, "parents =", fabn$mlik, "\n\n"))
  
save(mycache, mydag, fabn, file = paste(datadir,"mp_", max.par,".RData", sep=""))
  
}


# get network score for all parent limits
# ---------------------------------------
mp.mlik <- c()
for (i in 1:max.par) {
  load(paste(datadir,"mp_", i,".RData", sep=""))
  mp.mlik <- c(mp.mlik, fabn$mlik)
}



plot(1:max.par, mp.mlik, xlab = "Parent limit", ylab = "Log marginal likelihood", 
     type = "b", col="red", ylim=range(mp.mlik))
abline(v=which(mp.mlik==max(mp.mlik))[1], col="grey", lty=2)




### 1 parent/child

## Step 1: Open file and do some data wrangling, create groups of variables

library(haven)
library(dplyr)

# Increase memory limit to 16 GB (adjust as needed)
memory.limit(size = 16000)

# Read the dataset
file_path <- "E:\\16GBBACKUPUSB\\BACKUP_USB_SEPTEMBER2014\\SUMMER_STUDENT_2025\\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\\FINAL_DATA\\NHANES\\NHANES_MERGED_DATASET_ABN_DISCRETEfin.dta"
data.df <- read_dta(file_path)

# Summary of data to inspect structure
summary(data.df)

# Convert variables to factors
factorvars <- c("SEX", "d_var", "NHB", "HISP", "OTHER", "dummy1", "dummy2", "dummy3", "dummy4", "dummy5", "dummy6", "dummy7", "dummy8", "dummy9", "dummy10", "dummy11", "frailty_status")
data.df[factorvars] <- lapply(data.df[factorvars], factor)

# Inspect structure of the data
str(data.df)

# Convert to data frame for further use
abndata <- as.data.frame(data.df)

# Define antecedent and outcome variables
antecedent_vars <- c("AGE", "SEX", "NHB", "HISP", "OTHER")
outcome_vars <- c("d_var")

# Step 2: Fit the additive Bayesian network using the abn package

# Define the data distributions
data.dists <- list(
  AGE = "gaussian",
  zHorvathAgeEAA = "gaussian",
  zHannumAgeEAA = "gaussian",
  zPhenoAgeEAA = "gaussian",
  zGrimAgeMortEAA = "gaussian",
  zDunedinPoAm = "gaussian",
  frailty_status = "binomial",
  SEX = "binomial",
  d_var = "binomial",
  NHB = "binomial",
  HISP = "binomial",
  OTHER = "binomial",
  dummy1 = "binomial",
  dummy2 = "binomial",
  dummy3 = "binomial",
  dummy4 = "binomial",
  dummy5 = "binomial",
  dummy6 = "binomial",
  dummy7 = "binomial",
  dummy8 = "binomial",
  dummy9 = "binomial",
  dummy10 = "binomial",
  dummy11 = "binomial",
  zses = "gaussian"
)

# Create an empty matrix for 'retain' and 'banned'
retain <- matrix(0, ncol(abndata), ncol(abndata))
colnames(retain) <- rownames(retain) <- names(abndata)

banned <- matrix(0, ncol(abndata), ncol(abndata))
colnames(banned) <- rownames(banned) <- names(abndata)

# Ban edges as needed from all variables into antecedent variables; and from final outcome into all other variables
# 1 (AGE), 8 (SEX), 10 (NHB), 11 (HISP), 12 (OTHER) Final outcome is #9, dummy times (13 to 16), epigenetic clocks 2 to 6; HEI is 7; zses is 17
banned[1, -1] <- 1
banned[8, -8] <- 1
banned[10, -10] <- 1
banned[11, -11] <- 1
banned[12, -12] <- 1
banned[-9, 9] <- 1
banned[7, 2] <- 1
banned[7, 3] <- 1
banned[7, 4] <- 1
banned[7, 5] <- 1
banned[7, 6] <- 1
banned[24, 2] <- 1
banned[24, 3] <- 1
banned[24, 4] <- 1
banned[24, 5] <- 1
banned[24, 6] <- 1
banned[24, 7] <- 1


# Ban future dummy times from predicting past dummy times
for (i in 13:22
) {
  for (j in (i+1):23) {
    banned[i, j] <- 1
  }
}

# Ensure all dummy variables directly predict d_var
dummy_vars <- paste0("dummy", 1:11)  # List of dummy variables
for (dummy in dummy_vars) {
  retain[dummy, "d_var"] <- 1
}


# Check the banned matrix
summary(banned)
View(banned)



# Check the retain matrix
summary(retain)
View(retain)

# Find overlapping edges between banned and retained
conflicts <- which(banned == 1 & retain == 1, arr.ind = TRUE)
print(conflicts)  # Should return an empty set if no conflicts exist

# Resolve conflicts by prioritizing bans (set to 0 in retained matrix)
retain[conflicts] <- 0


# Install the package if it's not already installed
if (!requireNamespace("abn", quietly = TRUE)) {
  install.packages("abn")
}

# Load the package
library(abn)


# Set max.parents
max.par <- 1

# Get the variable names from the dataset to ensure the order is correct
var_names <- colnames(abndata)

# Initialize the start.dag matrix with the correct dimensions (matching the number of variables)
start.dag <- matrix(0, nrow = length(var_names), ncol = length(var_names))
rownames(start.dag) <- colnames(start.dag) <- var_names

# Print the start.dag to check if it's correctly set up
print(start.dag)

# Build the score cache, with max.par = 1
mycache <- buildScoreCache(data.df = as.data.frame(abndata), data.dists = data.dists, 
                           dag.banned = banned, dag.retained=retain, max.parents = max.par)

# Perform the search for the DAG using Hill Climber, passing the start.dag as a matrix
mydag <- searchHillClimber(score.cache = mycache, start.dag = start.dag)

# If the search runs successfully, plot the DAG
plotAbn(dag = mydag)

fabn <- fitAbn(object = mydag)

summary(fabn)

plotAbn(dag = mydag, labels="TRUE")

fabn <- fitAbn(object = mydag)

plot(fabn)



### 2 parents/child

## Step 1: Open file and do some data wrangling, create groups of variables

library(haven)
library(dplyr)

# Increase memory limit to 16 GB (adjust as needed)
memory.limit(size = 16000)

# Read the dataset
file_path <- "E:\\16GBBACKUPUSB\\BACKUP_USB_SEPTEMBER2014\\SUMMER_STUDENT_2025\\HRS_NHANES_HANDLS_FRAILTY_EPICLOCKS_MORT\\FINAL_DATA\\NHANES\\NHANES_MERGED_DATASET_ABN_DISCRETEfin.dta"
data.df <- read_dta(file_path)

# Summary of data to inspect structure
summary(data.df)

# Convert variables to factors
factorvars <- c("SEX", "d_var", "NHB", "HISP", "OTHER", "dummy1", "dummy2", "dummy3", "dummy4", "dummy5", "dummy6", "dummy7", "dummy8", "dummy9", "dummy10", "dummy11", "frailty_status")
data.df[factorvars] <- lapply(data.df[factorvars], factor)

# Inspect structure of the data
str(data.df)

# Convert to data frame for further use
abndata <- as.data.frame(data.df)

# Define antecedent and outcome variables
antecedent_vars <- c("AGE", "SEX", "NHB", "HISP", "OTHER")
outcome_vars <- c("d_var")

# Step 2: Fit the additive Bayesian network using the abn package

# Define the data distributions
data.dists <- list(
  AGE = "gaussian",
  zHorvathAgeEAA = "gaussian",
  zHannumAgeEAA = "gaussian",
  zPhenoAgeEAA = "gaussian",
  zGrimAgeMortEAA = "gaussian",
  zDunedinPoAm = "gaussian",
  frailty_status = "binomial",
  SEX = "binomial",
  d_var = "binomial",
  NHB = "binomial",
  HISP = "binomial",
  OTHER = "binomial",
  dummy1 = "binomial",
  dummy2 = "binomial",
  dummy3 = "binomial",
  dummy4 = "binomial",
  dummy5 = "binomial",
  dummy6 = "binomial",
  dummy7 = "binomial",
  dummy8 = "binomial",
  dummy9 = "binomial",
  dummy10 = "binomial",
  dummy11 = "binomial",
  zses = "gaussian"
)

# Create an empty matrix for 'retain' and 'banned'
retain <- matrix(0, ncol(abndata), ncol(abndata))
colnames(retain) <- rownames(retain) <- names(abndata)

banned <- matrix(0, ncol(abndata), ncol(abndata))
colnames(banned) <- rownames(banned) <- names(abndata)

# Ban edges as needed from all variables into antecedent variables; and from final outcome into all other variables
# 1 (AGE), 8 (SEX), 10 (NHB), 11 (HISP), 12 (OTHER) Final outcome is #9, dummy times (13 to 16), epigenetic clocks 2 to 6; HEI is 7; zses is 17
banned[1, -1] <- 1
banned[8, -8] <- 1
banned[10, -10] <- 1
banned[11, -11] <- 1
banned[12, -12] <- 1
banned[-9, 9] <- 1
banned[7, 2] <- 1
banned[7, 3] <- 1
banned[7, 4] <- 1
banned[7, 5] <- 1
banned[7, 6] <- 1
banned[24, 2] <- 1
banned[24, 3] <- 1
banned[24, 4] <- 1
banned[24, 5] <- 1
banned[24, 6] <- 1
banned[24, 7] <- 1


# Ban future dummy times from predicting past dummy times
for (i in 13:22
) {
  for (j in (i+1):23) {
    banned[i, j] <- 1
  }
}

# Ensure all dummy variables directly predict d_var
dummy_vars <- paste0("dummy", 1:11)  # List of dummy variables
for (dummy in dummy_vars) {
  retain[dummy, "d_var"] <- 1
}


# Check the banned matrix
summary(banned)
View(banned)



# Check the retain matrix
summary(retain)
View(retain)

# Find overlapping edges between banned and retained
conflicts <- which(banned == 1 & retain == 1, arr.ind = TRUE)
print(conflicts)  # Should return an empty set if no conflicts exist

# Resolve conflicts by prioritizing bans (set to 0 in retained matrix)
retain[conflicts] <- 0


# Install the package if it's not already installed
if (!requireNamespace("abn", quietly = TRUE)) {
  install.packages("abn")
}

# Load the package
library(abn)


# Set max.parents
max.par <- 2

# Get the variable names from the dataset to ensure the order is correct
var_names <- colnames(abndata)

# Initialize the start.dag matrix with the correct dimensions (matching the number of variables)
start.dag <- matrix(0, nrow = length(var_names), ncol = length(var_names))
rownames(start.dag) <- colnames(start.dag) <- var_names

# Print the start.dag to check if it's correctly set up
print(start.dag)

# Build the score cache, with max.par = 2
mycache <- buildScoreCache(data.df = as.data.frame(abndata), data.dists = data.dists, 
                           dag.banned = banned, dag.retained=retain, max.parents = max.par)

# Perform the search for the DAG using Hill Climber, passing the start.dag as a matrix
mydag <- searchHillClimber(score.cache = mycache, start.dag = start.dag)

# If the search runs successfully, plot the DAG
plotAbn(dag = mydag)

fabn <- fitAbn(object = mydag)

summary(fabn)

plotAbn(dag = mydag, labels="TRUE")

fabn <- fitAbn(object = mydag)

plot(fabn)











