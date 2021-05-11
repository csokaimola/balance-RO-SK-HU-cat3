* HU
use "$output/balance_orbis_00_18_EUR.dta", clear
rename bvdid BvDIDnumber
rename emp employment
merge 1:1 BvDIDnumber year using $input_orbis/balance_long, generate(check)
keep if year == 2015
putpdf clear
putpdf begin

  * create a report about comparison (correl, mean and median of ratio, log scatter plot) 
  local HUorbis "Materialcosts Materialcosts"
  local HUvars "ranyag_EUR ranyag01_EUR"
  local n : word count `HUorbis'

  forvalues i = 1/`n' {
    local a : word `i' of `HUorbis'
    local b : word `i' of `HUvars'
    correl `a' `b'
    return list
    putpdf paragraph
    putpdf text ("Correlation of `a' variables in the 2 datasets is the following (obs=`r(N)'): "), linebreak
    putpdf text ("r = ")
    putpdf text (r(rho)), nformat("%4.3f") bold linebreak
    gen `b'_ratio = `b'/`a' if `b' !=0
    summarize `b'_ratio, detail
    return list
    putpdf text ("Ratio of `a' variables in the 2 datasets: if mean and median is close to 1, then unit is the same."), linebreak
    putpdf text ("mean = ")
    putpdf text (r(mean)), nformat("%4.3f") bold linebreak
    putpdf text ("median = ")
    putpdf text (r(p50)), nformat("%4.3f") bold linebreak
    gen l`a' = ln(`a')
    gen l`b' = ln(`b')
    scatter l`a' l`b', mcolor(%10) title("`a': logarithmic comparison") ylabel(minmax) ylabel(,format(%9.2fc)) ytitle(`a' (Orbis)) xlabel(minmax)  xlabel(,format(%9.2fc)) xtitle(`b' (HU balance))
    graph export HU`a'.png, replace
    putpdf paragraph, halign(center)
    putpdf image HU`a'.png, linebreak width(2.5)
	
	drop l`a'
    }
  
putpdf save $output/report/HU_compare_ranyag_2015_if_ranyagnemnulla.pdf, replace

* delete unneccessary png-s
foreach x in `HUorbis' {
    erase "HU`x'.png"
	} 
	