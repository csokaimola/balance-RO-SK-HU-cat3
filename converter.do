********************************************************************************
** Convert 1000 HUF to 1000 EUR*************************************************
********************************************************************************

use "$input_HU/balance_orbis_00_18.dta", clear

* long to wide because of different exchange rates each year
drop if year == .
keep bvdid year sales-immat
reshape wide sales - immat , i(bvdid) j(year)

* exchange rates (end of the year): https://www.mnb.hu/arfolyam-lekerdezes

local HUbalancevars "sales tanass eszk export persexp pretax immat"
scalar EUR2000 = 264.94 
scalar EUR2001 = 246.33
scalar EUR2002 = 235.90
scalar EUR2003 = 262.23
scalar EUR2004 = 245.93
scalar EUR2005 = 252.73
scalar EUR2006 = 252.30
scalar EUR2007 = 253.35
scalar EUR2008 = 264.78
scalar EUR2009 = 270.84
scalar EUR2010 = 278.75
scalar EUR2011 = 311.13
scalar EUR2012 = 291.29
scalar EUR2013 = 296.91
scalar EUR2014 = 314.89
scalar EUR2015 = 313.12 
scalar EUR2016 = 311.02
scalar EUR2017 = 310.14
scalar EUR2018 = 321.51

foreach balancevar of local HUbalancevars {
forvalues year = 2000/2018 {

	generate `balancevar'_EUR`year' = `balancevar'`year' / EUR`year'
}
}

* back to long
keep bvdid emp* *_EUR*
reshape long emp sales_EUR tanass_EUR eszk_EUR export_EUR persexp_EUR pretax_EUR immat_EUR , i(bvdid) j(year)
foreach balancevar of local HUbalancevars {
label variable `balancevar'_EUR "value converted to 1000 EUR"
}
save "$output/balance_orbis_00_18_EUR", replace

********************************************************************************
** Convert 1 ROU to 1000 EUR****************************************************
********************************************************************************
*(from 2005.07.01: RON, before: ROL. Exchange: 10000 ROL = 1 RON)

use "$output/RO_balance_data.dta", clear

* try to check whether anything happened in 2005 with the currencies
//bar chart of random 1% of sample. There was growth in Sales 2004-2006, but nothing unusual, like 1/10000, so I guess 2000-2004 values are in 2005 RON
preserve
reshape wide name-BvDIDnumber, i(company_id) j(year)
generate u1 = runiform(0,100)
graph bar Sales2004 Sales2005 Sales2006 if u1 <1, over(company_id) stack
restore

*No comparable Orbis data on RO expenses, fix assets. Create histograms to check whether same unit: Exp/Sales <1, Tang ass/ Fix <1. Tang is same magnitude, and ratios (meaning percentages) seem rational, but Expenses is weird.
gen expcheck = Expenses/Sales
gen tangcheck = Tang_assets/Fix_assets
summarize expcheck tangcheck, detail
hist expcheck 
hist tangcheck
drop expcheck tangcheck

* long to wide because of different exchange rates each year
reshape wide company_id name - country , i(BvDIDnumber) j(year)

*RON EUR data from 2005 (end of the year): https://www.ecb.europa.eu/stats/policy_and_exchange_rates/euro_reference_exchange_rates/html/eurofxref-graph-ron.en.html

local RObalancevars "Sales Tang_assets Expenses Fix_assets"
scalar EUR2000 = 3.6802 
scalar EUR2001 = 3.6802
scalar EUR2002 = 3.6802
scalar EUR2003 = 3.6802
scalar EUR2004 = 3.6802
scalar EUR2005 = 3.6802
scalar EUR2006 = 3.3835
scalar EUR2007 = 3.6077
scalar EUR2008 = 4.0225
scalar EUR2009 = 4.2363
scalar EUR2010 = 4.262
scalar EUR2011 = 4.3233
scalar EUR2012 = 4.4445
scalar EUR2013 = 4.471
scalar EUR2014 = 4.4828
scalar EUR2015 = 4.524 
scalar EUR2016 = 4.539
scalar EUR2017 = 4.6585
scalar EUR2018 = 4.6635
scalar EUR2019 = 4.783

foreach balancevar of local RObalancevars {
forvalues year = 2000/2019 {

	generate `balancevar'_EUR`year' = `balancevar'`year' / EUR`year'/1000
}
}

* back to long
keep BvDIDnumber Employment* *_EUR*
reshape long Employment Sales_EUR Tang_assets_EUR Expenses_EUR Fix_assets_EUR , i(BvDIDnumber) j(year)
foreach balancevar of local RObalancevars {
label variable `balancevar'_EUR "value converted to 1000 EUR"
}
save "$output/RO_balance_data_EUR", replace

********************************************************************************

* Convert koruna to 1000 EUR? (from 2009.01.01: EUR, before: SKS. Exchange: 30 SKK = 1 EUR)
use "$output/SK_balance_data.dta", clear
* try to check whether anything happened in 2009 (1 January) with the currencies
//bar chart of random 1% of sample. There was growth in tang_assets and material_costs 2008-2009, but nothing unusual, like 1/30, so I guess before-2009 values already in EUR.
preserve
drop if year ==.
reshape wide name-fid registered-material_costs, i(BvDIDnumber) j(year)
generate u1 = runiform(0,100)
graph bar tang_assets2008 tang_assets2009 tang_assets2010 if u1 <1, over(BvDIDnumber) stack
graph export "$output/figure/tang_check1to30.png", replace
graph bar material_costs2008 material_costs2009 material_costs2010 if u1 <1, over(BvDIDnumber) stack
graph export "$output/figure/material_check1to30.png", replace

restore
* unit of sales seems to be ok (1000EUR same as orbis). Check mat_cost/sales<1?
forvalues i = 2008/2010 {
gen matcheck`i' = material_costs/sales if year==`i'
summarize matcheck`i', detail
hist matcheck`i'
graph export $output/figure/mat_per_sales`i'.png, replace
drop matcheck`i'
}