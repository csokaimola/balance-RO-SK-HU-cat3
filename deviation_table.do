********************************************************************************
** Checking extreme deviations in data enrichement
********************************************************************************

/*Take variable x, say, sales from both sources, for 2015

xs= sales(orbis)/ sales(national), non missing, non zero. No logs.

Create disjunct bins for xs, and a table, with two columns:
1. Count of obs in bin
2. Mean of xs in the bin. 

Bins
=1
0.952-1.05 but not 1
0.8-0.952
1.05-1.25
0.5-0.8
1.25-2
<0.5
>2

(Aztan lehet bar chart, ha sok olyan, ami nem=1. Ha 90% =1, akkor  esetben nincs ertelme. )
*/

********************************************************************************
* HU
use "$output/balance_orbis_00_18_EUR.dta", clear
rename bvdid BvDIDnumber
rename emp employment
keep if year == 2015
merge 1:1 BvDIDnumber year using $input_orbis/balance_long, generate(check)
keep if check == 3


* report on extreme deviations in data enrichement (count and mean of ratio bins)
  local HUorbis "Turnover emp Totalassets Materialcosts"
  local HUvars "sales_EUR employment eszk_EUR ranyag01_EUR"
  local n : word count `HUorbis'

  forvalues i = 1/`n' {
    local a : word `i' of `HUorbis'
    local b : word `i' of `HUvars'

    gen `a'_ratio = `b'/`a'
	gen `a'_bin = "1" if  `a'_ratio == 1
	
	* create cathegorical var of belonging to a `a'_bin
	replace `a'_bin = "0.952-1.05 but not 1" if `a'_ratio >=0.952 &  `a'_ratio < 1.05 & `a'_ratio !=1
    replace `a'_bin = "0.8-0.952" if `a'_ratio >=0.8 &  `a'_ratio < 0.952
    replace `a'_bin = "1.05-1.25" if `a'_ratio >=1.05 &  `a'_ratio < 1.25
    replace `a'_bin = "0.5-0.8" if `a'_ratio >=0.5 &  `a'_ratio < 0.8
    replace `a'_bin = "1.25-2" if `a'_ratio >=1.25 &  `a'_ratio < 2
    replace `a'_bin = "<0.5" if `a'_ratio < 0.5
    replace `a'_bin = ">2" if `a'_ratio >=2 & `a'_ratio !=.
    replace `a'_bin = "" if `a'_ratio ==.
    }
	
capture log close
log using "$output/report/deviations_logfile_HU.log", replace text 

* write out in table
local HUorbis "Turnover emp Totalassets Materialcosts"
foreach a in `HUorbis' {
    preserve
	collapse (count) Count=`a'_ratio (mean) Mean=`a'_ratio,  by(`a'_bin)
	list
	restore
	}
log close

order originalid BvDIDnumber name_settlement name sales sales_EUR Turnover Turnover_ratio employment emp eszk eszk_EUR Totalassets ranyag ranyag01 ranyag_EUR ranyag01_EUR Materialcosts
*bro name sales_EUR Turnover Turnover_ratio if Turnover_bin == "<0.5" | Turnover_bin == "0.5-0.8" | Turnover_bin == "1.25-2"| Turnover_bin == ">2"
* national/orbis ratio < 0.8 
  * orbis: konszolidált, national: jó (MOL, FMV, Alteo, Nitrokemia, Univer ellenőrizve)
  * Eagle ottawa (12715093): magyar adatban rossz (csak 1 havi eredmény volt, András javítja)
  * firm name rosszul match-elt? pl Unilever, Nitrokémia
bro originalid BvDIDnumber name_settlement name sales sales_EUR Turnover Turnover_ratio employment emp eszk eszk_EUR Totalassets ranyag ranyag01 ranyag_EUR ranyag01_EUR Materialcosts if Turnover_bin == "<0.5" | Turnover_bin == "0.5-0.8"  // 54 ilyen cég

* national/orbis ratio > 1.25
* Egis (10686506): eltérő üzleti éves, a nationalban 128 mrd huf 2014-ben van 2015 helyett, tehát "el van tolva" 1 évvel. Valószínű másoknál is ez lehet
* Küpper (12812389): csak ő volt nagyon nagy 185 ratio. nem az eltérő üzleti év okozza az eltérést, a magyar adat jó, az Orbisos adat aránytalanul kicsi
* Émász (10737743): jó a nemzeti adat, csak rosszul nyújtotta be cég a bevallást és utólag korrigálta (az e-beszámolóban a konszolidált kisebb, mint a nem konszolidált)
bro originalid BvDIDnumber name_settlement name sales sales_EUR Turnover Turnover_ratio employment emp eszk eszk_EUR Totalassets ranyag ranyag01 ranyag_EUR ranyag01_EUR Materialcosts if Turnover_bin == "1.25-2" | Turnover_bin == ">2"  // 9



********************************************************************************
* RO
use "$output/RO_balance_data_EUR.dta", clear
keep if year == 2015
merge 1:1 BvDIDnumber year using $input_orbis/balance_long, generate(check)
keep if check == 3

* report on extreme deviations in data enrichement (count and mean of ratio bins)

  local ROorbis "Turnover emp Totalassets Materialcosts"
  local ROvars "Sales_EUR Employment Fix_assets_EUR Expenses_EUR"
  local n : word count `ROorbis'

  forvalues i = 1/`n' {
    local a : word `i' of `ROorbis'
    local b : word `i' of `ROvars'

    gen `a'_ratio = `b'/`a'
	gen `a'_bin = "1" if  `a'_ratio == 1
	
	* create cathegorical var of belonging to a `a'_bin
	replace `a'_bin = "0.952-1.05 but not 1" if `a'_ratio >=0.952 &  `a'_ratio < 1.05 & `a'_ratio !=1
    replace `a'_bin = "0.8-0.952" if `a'_ratio >=0.8 &  `a'_ratio < 0.952
    replace `a'_bin = "1.05-1.25" if `a'_ratio >=1.05 &  `a'_ratio < 1.25
    replace `a'_bin = "0.5-0.8" if `a'_ratio >=0.5 &  `a'_ratio < 0.8
    replace `a'_bin = "1.25-2" if `a'_ratio >=1.25 &  `a'_ratio < 2
    replace `a'_bin = "<0.5" if `a'_ratio < 0.5
    replace `a'_bin = ">2" if `a'_ratio >=2 & `a'_ratio !=.
    replace `a'_bin = "" if `a'_ratio ==.
    }
	
capture log close
log using "$output/report/deviations_logfile_RO.log", replace text 

* write out in table
local ROorbis "Turnover emp Totalassets Materialcosts"
foreach a in `ROorbis' {
    preserve
	collapse (count) Count=`a'_ratio (mean) Mean=`a'_ratio,  by(`a'_bin)
	list
	restore
	}
log close

bro name BvDIDnumber Sales Sales_EUR Turnover Turnover_ratio BvDIDnumber if Turnover_bin == "<0.5" | Turnover_bin == "0.5-0.8"  // 54 ilyen cég


********************************************************************************
* SK
use "$output/SK_balance_data.dta", clear
keep if year == 2015
merge 1:1 BvDIDnumber year using $input_orbis/balance_long, generate(check)
keep if check == 3

* report on extreme deviations in data enrichement (count and mean of ratio bins)

  local SKorbis "Turnover emp Totalassets Materialcosts"
  local SKvars "sales employees fixed_assets material_cost"
  local n : word count `SKorbis'

  forvalues i = 1/`n' {
    local a : word `i' of `SKorbis'
    local b : word `i' of `SKvars'

    gen `a'_ratio = `b'/`a'
	gen `a'_bin = "1" if  `a'_ratio == 1
	
	* create cathegorical var of belonging to a `a'_bin
	replace `a'_bin = "0.952-1.05 but not 1" if `a'_ratio >=0.952 &  `a'_ratio < 1.05 & `a'_ratio !=1
    replace `a'_bin = "0.8-0.952" if `a'_ratio >=0.8 &  `a'_ratio < 0.952
    replace `a'_bin = "1.05-1.25" if `a'_ratio >=1.05 &  `a'_ratio < 1.25
    replace `a'_bin = "0.5-0.8" if `a'_ratio >=0.5 &  `a'_ratio < 0.8
    replace `a'_bin = "1.25-2" if `a'_ratio >=1.25 &  `a'_ratio < 2
    replace `a'_bin = "<0.5" if `a'_ratio < 0.5
    replace `a'_bin = ">2" if `a'_ratio >=2 & `a'_ratio !=.
    replace `a'_bin = "" if `a'_ratio ==.
    }
	
capture log close
log using "$output/report/deviations_logfile_SK.log", replace text 

* write out in table
local SKorbis "Turnover emp Totalassets Materialcosts"
foreach a in `SKorbis' {
    preserve
	collapse (count) Count=`a'_ratio (mean) Mean=`a'_ratio,  by(`a'_bin)
	list
	restore
	}
log close