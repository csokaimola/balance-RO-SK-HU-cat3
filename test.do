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
keep if year == 2015 & Country == "Slovakia"
tab test
tab respondent

  * sales, employment, productivity (fix assets & material costs)
  local SKtfp = "Turnover emp Totalassets Materialcosts Productivity"
  rename sales Turnover_national
  rename employees emp_national
  rename fixed_assets Totalassets_national
  rename material_cost Materialcosts_national
  gen Productivity = Totalassets/Materialcosts // missing if any of the 2 is missing
  gen Productivity_national = Totalassets_national/Materialcosts_national
  
  foreach balancevar in `SKtfp' {
    gen ln_`balancevar' = ln(`balancevar')
	gen ln_`balancevar'_national = ln(`balancevar'_national)
    count if (ln_`balancevar' !=. | ln_`balancevar'_national !=. ) & respondent == 1 //union respondent 
	count if (ln_`balancevar' ==. & ln_`balancevar'_national !=.) & respondent == 1 //national only
	count if (ln_`balancevar' !=. & ln_`balancevar'_national ==.) & respondent == 1 // orbis only
    count if (ln_`balancevar' !=. | ln_`balancevar'_national !=.)  & respondent == 0 // union partner 
    count if (ln_`balancevar' ==. & ln_`balancevar'_national !=.) & respondent == 0 //national only
	count if (ln_`balancevar' !=. & ln_`balancevar'_national ==.) & respondent == 0 // orbis only
  }

********************************************************************************
* RO // Expenses ~ material costs?
********************************************************************************
use "$output/RO_balance_data", clear
rename BvDIDnumber bvdid
merge m:1 bvdid using "$temp/respondent_list", nogen
gen respondent = (!missing(masterid))
label variable respondent "1 if company is respondent, 0 if partner"
rename bvdid BvDIDnumber

merge 1:1 BvDIDnumber year using $input_orbis/balance_long, generate(test)
keep if year == 2015 & Country == "Romania"
tab test
tab respondent

  * sales, employment, productivity (fix assets & material costs)
  local ROtfp = "Turnover emp Totalassets Materialcosts Productivity"
  rename Sales Turnover_national
  rename Employment emp_national
  rename Fix_assets Totalassets_national
  rename Expenses Materialcosts_national
  gen Productivity = Totalassets/Materialcosts // missing if any of the 2 is missing
  gen Productivity_national = Totalassets_national/Materialcosts_national
  
  foreach balancevar in `ROtfp' {
    gen ln_`balancevar' = ln(`balancevar')
	gen ln_`balancevar'_national = ln(`balancevar'_national)
    count if (ln_`balancevar' !=. | ln_`balancevar'_national !=. ) & respondent == 1 //union respondent 
	count if (ln_`balancevar' ==. & ln_`balancevar'_national !=.) & respondent == 1 //national only
	count if (ln_`balancevar' !=. & ln_`balancevar'_national ==.) & respondent == 1 // orbis only
    count if (ln_`balancevar' !=. | ln_`balancevar'_national !=.)  & respondent == 0 // union partner 
    count if (ln_`balancevar' ==. & ln_`balancevar'_national !=.) & respondent == 0 //national only
	count if (ln_`balancevar' !=. & ln_`balancevar'_national ==.) & respondent == 0 // orbis only
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
keep if year == 2015 & Country == "Hungary"
tab test
tab respondent

  * sales, employment, productivity (fix assets & material costs)
  local HUtfp = "Turnover emp Totalassets"
  rename sales Turnover_national
  rename employment emp_national
  rename eszk Totalassets_national
  
  foreach balancevar in `HUtfp' {
    gen ln_`balancevar' = ln(`balancevar')
	gen ln_`balancevar'_national = ln(`balancevar'_national)
    count if (ln_`balancevar' !=. | ln_`balancevar'_national !=.)  & respondent == 1 //union respondent 
	count if (ln_`balancevar' ==. & ln_`balancevar'_national !=.) & respondent == 1 //national only 
	count if (ln_`balancevar' !=. & ln_`balancevar'_national ==.) & respondent == 1 // orbis only
    count if (ln_`balancevar' !=. | ln_`balancevar'_national !=.)  & respondent == 0 // union partner
    count if (ln_`balancevar' ==. & ln_`balancevar'_national !=.) & respondent == 0 //national only
	count if (ln_`balancevar' !=. & ln_`balancevar'_national ==.) & respondent == 0 // orbis only
  }
  
