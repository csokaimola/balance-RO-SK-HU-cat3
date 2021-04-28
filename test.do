capture log close
log using "$output/report/test1_test2_results.log", replace text 
********************************************************************************
** Test 1 and Test 2 for orbis and national data comparison
********************************************************************************

/*
Cross section for 2015:

For each of ln_sales, ln_employment, ln_productivity.

For each of HU, RO, SK.

Count if !missing. You don't need to compute productivity, only `!missing(ln_sales, ln_employment, ln_assets, ln_material_costs).
*/

* create respondent list
import delimited "$input_firm/masterid2bvdid.csv", varnames(1) clear 
save "$temp/respondent_list", replace

********************************************************************************
* SK
********************************************************************************
use "$output/SK_balance_data", clear
rename BvDIDnumber bvdid
merge m:1 bvdid using "$temp/respondent_list", nogen
gen respondent = (!missing(masterid))
label variable respondent "1 if company is respondent, 0 if partner"
rename bvdid BvDIDnumber

merge 1:1 BvDIDnumber year using $input_orbis/balance_long, generate(test)

* Test 1

local SKtfp = "Turnover emp Totalassets Materialcosts"
rename sales Turnover_national
rename employees emp_national
rename fixed_assets Totalassets_national
rename material_cost Materialcosts_national
foreach balancevar in `SKtfp' {
  gen ln_`balancevar' = ln(`balancevar')
  gen ln_`balancevar'_national = ln(`balancevar'_national)
}

local testyears 2011 2015
foreach i in `testyears' {
  preserve
  keep if year == `i' & Country == "Slovakia"
  tab test
  tab respondent
  display "Year of analysis is `i'"
  foreach balancevar in `SKtfp' {
    display "`balancevar'"
    count if (ln_`balancevar' !=. | ln_`balancevar'_national !=. ) & respondent == 1 //union respondent 
	count if ln_`balancevar'_national !=. & respondent == 1 //national only
	count if ln_`balancevar' !=. & respondent == 1 // orbis only
    count if (ln_`balancevar' !=. | ln_`balancevar'_national !=.)  & respondent == 0 // union partner 
	count if ln_`balancevar'_national !=. & respondent == 0 //national only
	count if ln_`balancevar' !=. & respondent == 0 // orbis only
  }
  display "productivity"
  count if (!missing(ln_Turnover, ln_emp, ln_Totalassets, ln_Materialcosts) | !missing(ln_Turnover_national, ln_emp_national, ln_Totalassets_national, ln_Materialcosts_national)) & respondent == 1 //union respondent 
  count if !missing(ln_Turnover_national, ln_emp_national, ln_Totalassets_national, ln_Materialcosts_national) & respondent == 1 //national only
  count if !missing(ln_Turnover, ln_emp, ln_Totalassets, ln_Materialcosts) & respondent == 1 // orbis only
  count if (!missing(ln_Turnover, ln_emp, ln_Totalassets, ln_Materialcosts) | !missing(ln_Turnover_national, ln_emp_national, ln_Totalassets_national, ln_Materialcosts_national)) & respondent == 0 // union partner 
  count if !missing(ln_Turnover_national, ln_emp_national, ln_Totalassets_national, ln_Materialcosts_national) & respondent == 0 //national only
  count if !missing(ln_Turnover, ln_emp, ln_Totalassets, ln_Materialcosts) & respondent == 0 // orbis only
  restore
}


*Test 2 for growth
keep if (year == 2015 | year == 2018) & Country == "Slovakia"
tab test
tab respondent

********************************************************************************
* RO // no data on material costs, so no productivity
********************************************************************************
use "$output/RO_balance_data", clear
rename BvDIDnumber bvdid
merge m:1 bvdid using "$temp/respondent_list", nogen
gen respondent = (!missing(masterid))
label variable respondent "1 if company is respondent, 0 if partner"
rename bvdid BvDIDnumber

merge 1:1 BvDIDnumber year using $input_orbis/balance_long, generate(test)

* Test 1
  local ROtfp = "Turnover emp Totalassets"
  rename Sales Turnover_national
  rename Employment emp_national
  rename Fix_assets Totalassets_national

foreach balancevar in `ROtfp' {
  gen ln_`balancevar' = ln(`balancevar')
  gen ln_`balancevar'_national = ln(`balancevar'_national)
}

local testyears 2011 2015
foreach i in `testyears' {
  preserve
  keep if year == `i' & Country == "Romania"
  tab test
  tab respondent
  display "Year of analysis is `i'"
  foreach balancevar in `ROtfp' {
    display "`balancevar'"
    count if (ln_`balancevar' !=. | ln_`balancevar'_national !=. ) & respondent == 1 //union respondent 
	count if ln_`balancevar'_national !=. & respondent == 1 //national only
	count if ln_`balancevar' !=. & respondent == 1 // orbis only
    count if (ln_`balancevar' !=. | ln_`balancevar'_national !=.)  & respondent == 0 // union partner 
	count if ln_`balancevar'_national !=. & respondent == 0 //national only
	count if ln_`balancevar' !=. & respondent == 0 // orbis only
  }
  
  restore
}

********************************************************************************
* HU //material cost: ranyag
********************************************************************************
use "$input_HU/balance_orbis_00_18", clear
merge m:1 bvdid using "$temp/respondent_list", nogen
gen respondent = (!missing(masterid)) // thanks Geri
label variable respondent "1 if company is respondent, 0 if partner"
rename bvdid BvDIDnumber
rename emp employment

merge 1:1 BvDIDnumber year using $input_orbis/balance_long, generate(test)

* Test 1
local HUtfp = "Turnover emp Totalassets"
rename sales Turnover_national
rename employment emp_national
rename eszk Totalassets_national
  
foreach balancevar in `HUtfp' {
  gen ln_`balancevar' = ln(`balancevar')
  gen ln_`balancevar'_national = ln(`balancevar'_national)
}

local testyears 2011 2015
foreach i in `testyears' {
  preserve
  keep if year == `i' & Country == "Hungary"
  tab test
  tab respondent
  display "Year of analysis is `i'"
  foreach balancevar in `HUtfp' {
    display "`balancevar'"
    count if (ln_`balancevar' !=. | ln_`balancevar'_national !=. ) & respondent == 1 //union respondent 
	count if ln_`balancevar'_national !=. & respondent == 1 //national only
	count if ln_`balancevar' !=. & respondent == 1 // orbis only
    count if (ln_`balancevar' !=. | ln_`balancevar'_national !=.)  & respondent == 0 // union partner 
	count if ln_`balancevar'_national !=. & respondent == 0 //national only
	count if ln_`balancevar' !=. & respondent == 0 // orbis only
  }
  display "productivity"
  count if (!missing(ln_Turnover, ln_emp, ln_Totalassets, ln_Materialcosts) | !missing(ln_Turnover_national, ln_emp_national, ln_Totalassets_national, ln_Materialcosts_national)) & respondent == 1 //union respondent 
  count if !missing(ln_Turnover_national, ln_emp_national, ln_Totalassets_national, ln_Materialcosts_national) & respondent == 1 //national only
  count if !missing(ln_Turnover, ln_emp, ln_Totalassets, ln_Materialcosts) & respondent == 1 // orbis only
  count if (!missing(ln_Turnover, ln_emp, ln_Totalassets, ln_Materialcosts) | !missing(ln_Turnover_national, ln_emp_national, ln_Totalassets_national, ln_Materialcosts_national)) & respondent == 0 // union partner 
  count if !missing(ln_Turnover_national, ln_emp_national, ln_Totalassets_national, ln_Materialcosts_national) & respondent == 0 //national only
  count if !missing(ln_Turnover, ln_emp, ln_Totalassets, ln_Materialcosts) & respondent == 0 // orbis only
  restore
}


 log close
 
