********************************************************************************
** Append the original and 1000 EUR RO-SK-HU datasets to one cat3 dataset*******
********************************************************************************

use "$output/RO_balance_data", clear
merge 1:1 BvDIDnumber year using "$output/RO_balance_data_EUR", nogen

append using "$output/SK_balance_data"

//something not ok with HU
preserve
use "$input_HU/balance_orbis_00_18", clear
merge 1:1 bvdid year using "$output/balance_orbis_00_18_EUR"
keep if _merge != 3 // not matched companies have no data
drop _merge
save "$temp/HU_balance_data", replace
restore
append using "$temp/HU_balance_data"

save "$output/balance_RO_SK_HU_cat3", replace
