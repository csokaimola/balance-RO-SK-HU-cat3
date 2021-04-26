********************************************************************************
** Append the original and 1000 EUR RO-SK-HU datasets to one cat3 dataset*******
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

* HU //material cost: ranyag, test: value label
use "$input_HU/balance_orbis_00_18", clear
merge m:1 bvdid using "$temp/respondent_list", nogen
gen respondent = 0
replace respondent =1 if masterid != ""
label variable respondent "1 if company is respondent, 0 if partner"
rename bvdid BvDIDnumber
rename emp employment

merge 1:1 BvDIDnumber year using $input_orbis/balance_long, generate(test)
keep if year == 2015 & Country == "Hungary"
tab test

  * sales, employment, productivity (fix assets & material costs)
  local HUtfp = "Turnover emp Totalassets"
  rename sales Turnover_balance
  rename employment emp_balance
  rename eszk Totalassets_balance
  
  foreach balancevar in `HUtfp' {
    gen ln_`balancevar' = ln(`balancevar')
	gen ln_`balancevar'_balance = ln(`balancevar'_balance)
    count if ln_`balancevar' !=. | ln_`balancevar'_balance !=.  & respondent == 1 //union respondent: 552
	count if ln_`balancevar' !=. & respondent == 1 & test == 1 //master only (balance): 
	count if ln_`balancevar' !=. & respondent == 1 & test == 2 // using only (orbis):
    count if ln_`balancevar' !=. & respondent == 0 // union partner: 733
    count if ln_`balancevar' !=. & respondent == 0 & test == 1 //master only (balance): 
	count if ln_`balancevar' !=. & respondent == 0 & test == 2 // using only (orbis):
  }

  
/*


* RO
use "$output/RO_balance_data", clear

* SK
use "$output/SK_balance_data", clear
