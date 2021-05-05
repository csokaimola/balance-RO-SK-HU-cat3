* data coverage
use "$output/SK_balance_data", clear
count if year == 2011
count if year == 2011 | year ==.
count if year == 2015
count if year == 2015 | year ==.
count if year == . | year ==2011 | year == 2015

* filter SK data from orbis
preserve
use $input_orbis/balance_long, clear
keep if Country == "Slovakia"
count if year == 2011
count if year == 2015
save $temp/balance_long_SK, replace
restore
merge 1:1 BvDIDnumber year using $temp/balance_long_SK, generate(test)

***********************************************************
* merge long datasets with year=. vars included

* create wide SK_balance for merge
use "$output/SK_balance_data.dta", clear
replace year = 99 if year ==. //316  obs belonging to 316 different companies
reshape wide name-fid registered-material_costs, i(BvDIDnumber) j(year)
save "SK_balance_data_wide.dta", replace

* long to wide, to correct "year differences" in the 2 datasets
use "$input_orbis/balance_long.dta", clear
drop _merge
keep if Country =="Slovakia"
reshape wide CompanynameLatinalphabet - type , i(BvDIDnumber) j(year)

merge 1:1 BvDIDnumber using SK_balance_data_wide, generate(check)


* it seems that except for these 15 companies, all "not matched" was because not same year
* python script didn't run on "not_matched_SK.csv", so we created a not_matched_orbis_SK_fordito by typing

/*
preserve
keep if check == 1 
keep CompanynameLatinalphabet2015 BvDIDnumber
rename CompanynameLatinalphabet2015 name
export delimited using "not_matched_orbis.csv", replace
restore

keep if check == 2
keep name BvDIDnumber
export delimited using "not_matched_SK.csv", replace

python script name-generaliser.py, args(-in "not_matched_orbis.csv" -out "not_matched_orbis_gen.csv")
python script name-generaliser.py, args(-in "not_matched_SK.csv" -out "not_matched_SK_gen.csv")

*/
*************************************************
*only for year=2011,2015, .
* data coverage
use "$output/SK_balance_data", clear
count if year == 2011
count if year == 2011 | year ==.
count if year == 2015
count if year == 2015 | year ==.
keep if year == . | year ==2011 | year == 2015

* filter SK data from orbis
preserve
use $input_orbis/balance_long, clear
keep if Country == "Slovakia"
count if year == 2011
count if year == 2015
keep if year == . | year ==2011 | year == 2015
save $temp/balance_long_SK, replace
restore
merge 1:1 BvDIDnumber year using $temp/balance_long_SK, generate(test)

***********************************************************
* merge long datasets with year=. vars included

* create wide SK_balance for merge
use "$output/SK_balance_data.dta", clear
keep if year == . | year ==2011 | year == 2015
replace year = 99 if year ==. //316  obs belonging to 316 different companies
reshape wide name-fid registered-material_costs, i(BvDIDnumber) j(year)
save "SK_balance_data_wide.dta", replace

* long to wide, to correct "year differences" in the 2 datasets
use "$input_orbis/balance_long.dta", clear
drop _merge
keep if Country =="Slovakia"
keep if year == . | year ==2011 | year == 2015
reshape wide CompanynameLatinalphabet - type , i(BvDIDnumber) j(year)

merge 1:1 BvDIDnumber using SK_balance_data_wide, generate(check)


