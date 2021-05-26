********************************************************************************
** Append the original and 1000 EUR, HU and RO datasets to one cat3 dataset*****
********************************************************************************

* RO
use "$output/RO_balance_data", clear
merge 1:1 BvDIDnumber year using "$output/RO_balance_data_EUR"
keep if _merge == 3 // 2 not matched companies have no data
drop _merge
drop hungarianforintaverage hungarianforintendofperiod romanianleuaverage romanianleuendofperiod

* HU
//something not ok with HU
preserve
use "$input_HU/balance_orbis_00_18", clear
merge 1:1 bvdid year using "$output/balance_orbis_00_18_EUR"
keep if _merge == 3 // 3 not matched companies have no data
drop _merge
rename bvdid BvDIDnumber
save "$temp/HU_balance_data", replace
restore
append using "$temp/HU_balance_data"

save "$output/balance_HU_RO_cat3", replace
