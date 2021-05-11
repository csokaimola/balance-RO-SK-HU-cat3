********************************************************************************
** Convert 1000 HUF to 1000 EUR*************************************************
********************************************************************************

use "$input_HU/balance_orbis_00_18.dta", clear

preserve
import delimited "RON_HUF.csv", varnames(3) rowrange(6) numericcols(_all) clear
rename v1 year
save "$temp/RON_HUF.dta", replace
restore

merge m:1 year using "$temp/RON_HUF.dta", nogen

* use different exchange rates for stock and flow variables
* stock: end of the year, eg. Tang assets, Fix assets
* flow:year avg, eg. Sales, Export 

local HU_stock_vars " tanass eszk immat"
foreach balancevar of local HU_stock_vars {

	generate double `balancevar'_EUR = `balancevar' / hungarianforintendofperiod
	label variable `balancevar'_EUR "value converted to 1000 EUR"
}

local HU_flow_vars "sales export ranyag ranyag01 persexp pretax"
foreach balancevar of local HU_flow_vars {

	generate double `balancevar'_EUR = `balancevar' / hungarianforintaverage 
	label variable `balancevar'_EUR "value converted to 1000 EUR"
}

save "$output/balance_orbis_00_18_EUR", replace


********************************************************************************
** Convert 1 ROU to 1000 EUR****************************************************
********************************************************************************
*(from 2005.07.01: RON, before: ROL. Exchange: 10000 ROL = 1 RON)

use "$output/RO_balance_data.dta", clear
merge m:1 year using "$temp/RON_HUF.dta", nogen

* use different exchange rates for stock and flow variables
local RO_stock_vars "Tang_assets Fix_assets"
foreach balancevar of local RO_stock_vars {

	generate double `balancevar'_EUR = `balancevar' / romanianleuendofperiod / 1000
	label variable `balancevar'_EUR "value converted to 1000 EUR"
}

local RO_flow_vars "Sales Expenses"
foreach balancevar of local RO_flow_vars {

	generate double `balancevar'_EUR = `balancevar' / romanianleuaverage / 1000
	label variable `balancevar'_EUR "value converted to 1000 EUR"
}

save "$output/RO_balance_data_EUR", replace
