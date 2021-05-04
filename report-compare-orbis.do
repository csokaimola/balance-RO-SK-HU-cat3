********************************************************************************
**Create report on RO, SK, HU balance and orbis comparison**********************
********************************************************************************
* observations by country by year, coverage of individual variables
* correlation, unit, discrepancies (ln scatterplot for outliers)

********************************************************************************
* RO
use "$output/RO_balance_data_EUR.dta", clear
merge 1:1 BvDIDnumber year using $input_orbis/balance_long, generate(check)
putpdf clear
putpdf begin

* report on variable coverage (FIXME, ugly)
  putpdf paragraph, font(,20) halign(center)
  putpdf text ("Report on RO national variable coverage by year"), linebreak(2)
  putpdf paragraph
  putpdf text ("Tabstat where columns are variables, respectively: Sales Fix_assets Tang_assets Employment Expenses, rows are years (Stat2: 2000,...Stat22: 2020)."), linebreak
  tabstat Sales_EUR Fix_assets_EUR Tang_assets_EUR Employment Expenses_EUR, stat(count) by(year) save
  putpdf table ROcoverage = rmatrices
  putpdf pagebreak

* create a report about comparison (correl, mean and median of ratio, log scatter plot)
  local ROorbis "emp Turnover Tangible Totalassets"
  local ROvars "Employment Sales_EUR Tang_assets_EUR Fix_assets_EUR"
  local n : word count `ROorbis'

  putpdf paragraph, font(,20) halign(center)
  putpdf text ("Report on RO national and Orbis comparison"), linebreak(2)
  putpdf paragraph
  putpdf text ("Variables from Orbis: emp Turnover Tangible"), linebreak
  putpdf paragraph
  putpdf text ("Variables from RO balance: Employment Sales Tang_assets (original data converted to 1000 EUR, end of the year exchange rate)"), linebreak
  putpdf paragraph
  putpdf text ("Variables in RO balance with no comparable Orbis data: Expenses, Fix_assets"), linebreak(2)

  forvalues i = 1/`n' {
    local a : word `i' of `ROorbis'
    local b : word `i' of `ROvars'
    correl `a' `b'
    return list
    putpdf paragraph
    putpdf text ("Correlation of `a' variables in the 2 datasets is the following (obs=`r(N)'): "), linebreak
    putpdf text ("r = ")
    putpdf text (r(rho)), nformat("%4.3f") bold linebreak
    gen `a'_ratio = `b'/`a'
    summarize `a'_ratio, detail
    return list
    putpdf text ("Ratio of `a' variables in the 2 datasets: if mean and median is close to 1, then unit is the same."), linebreak
    putpdf text ("mean = ")
    putpdf text (r(mean)), nformat("%4.3f") bold linebreak
    putpdf text ("median = ")
    putpdf text (r(p50)), nformat("%4.3f") bold linebreak
    gen l`a' = ln(`a')
    gen l`b' = ln(`b')
    scatter l`a' l`b', mcolor(%10) title("`a': logarithmic comparison") ylabel(minmax) ylabel(,format(%9.2fc)) ytitle(`a' (Orbis)) xlabel(minmax)  xlabel(,format(%9.2fc)) xtitle(`b' (RO balance))
    graph export RO`a'.png, replace
    putpdf paragraph, halign(center)
    putpdf image RO`a'.png, linebreak width(2.5)
    }

putpdf save $output/report/RO_report.pdf, replace

* delete unneccessary png-s
foreach x in `ROorbis' {
    erase "RO`x'.png"
	} 

********************************************************************************
* SK
use "$output/SK_balance_data.dta", clear
merge 1:1 BvDIDnumber year using $input_orbis/balance_long, generate(check)
putpdf clear
putpdf begin

* report on variable coverage (FIXME, ugly)
  putpdf paragraph, font(,20) halign(center)
  putpdf text ("Report on SK national variable coverage by year"), linebreak(2)
  putpdf paragraph
  putpdf text ("Tabstat where columns are variables, respectively: employees sales sales_abroad tang_assets fixed_assets material_costs, rows are years (Stat1: 2000,...Stat21: 2020)."), linebreak
  tabstat employees sales sales_abroad tang_assets fixed_assets material_costs, stat(count) by(year) save
  putpdf table SKcoverage = rmatrices
  putpdf pagebreak
  
* create a report about comparison (correl, mean and median of ratio, log scatter plot) 
  local SKorbis "emp Turnover Tangible Exportrevenue Materialcosts"
  local SKvars "employees sales tang_assets sales_abroad material_cost"
  local n : word count `SKorbis'

  putpdf paragraph, font(,20) halign(center)
  putpdf text ("Report on SK national and Orbis comparison"), linebreak(2)
  putpdf paragraph
  putpdf text ("Variables from Orbis: emp Turnover Tangible Exportrevenue Materialcosts"), linebreak
  putpdf paragraph
  putpdf text ("Variables from SK balance: employees sales tang_assets sales_abroad material_cost"), linebreak
  putpdf paragraph
  putpdf text ("Variables in SK balance not compared to Orbis data: fixed_assets employment (for small companies, has no time series data), registered type NACE District foreign public sizecat"), linebreak(2)

  forvalues i = 1/`n' {
    local a : word `i' of `SKorbis'
    local b : word `i' of `SKvars'
    correl `a' `b'
    return list
    putpdf paragraph
    putpdf text ("Correlation of `a' variables in the 2 datasets is the following (obs=`r(N)'): "), linebreak
    putpdf text ("r = ")
    putpdf text (r(rho)), nformat("%4.3f") bold linebreak
    gen `a'_ratio = `b'/`a'
    summarize `a'_ratio, detail
    return list
    putpdf text ("Ratio of `a' variables in the 2 datasets: if mean and median is close to 1, then unit is the same."), linebreak
    putpdf text ("mean = ")
    putpdf text (r(mean)), nformat("%4.3f") bold linebreak
    putpdf text ("median = ")
    putpdf text (r(p50)), nformat("%4.3f") bold linebreak
    gen l`a' = ln(`a')
    gen l`b' = ln(`b')
    scatter l`a' l`b', mcolor(%10) title("`a': logarithmic comparison") ylabel(minmax) ylabel(,format(%9.2fc)) ytitle(`a' (Orbis)) xlabel(minmax)  xlabel(,format(%9.2fc)) xtitle(`b' (SK balance))
    graph export SK`a'.png, replace
    putpdf paragraph, halign(center)
    putpdf image SK`a'.png, linebreak width(2.5)
    }
  
putpdf save $output/report/SK_report.pdf, replace

* delete unneccessary png-s
foreach x in `SKorbis' {
    erase "SK`x'.png"
	} 
	
********************************************************************************
* HU
use "$output/balance_orbis_00_18_EUR.dta", clear
rename bvdid BvDIDnumber
rename emp employment
merge 1:1 BvDIDnumber year using $input_orbis/balance_long, generate(check)
putpdf clear
putpdf begin

* report on variable coverage (FIXME, ugly)
  putpdf paragraph, font(,20) halign(center)
  putpdf text ("Report on HU national variable coverage by year"), linebreak(2)
  putpdf paragraph
  putpdf text ("Tabstat where columns are variables, respectively: sales employment tanass eszk export persexp pretax immat, rows are years (Stat2: 2000,...Stat22: 2020)."), linebreak
  tabstat sales_EUR employment tanass_EUR eszk_EUR export_EUR persexp_EUR pretax_EUR immat_EUR, stat(count) by(year) save
  putpdf table HUcoverage = rmatrices
  putpdf pagebreak

  * create a report about comparison (correl, mean and median of ratio, log scatter plot) 
  local HUorbis "Turnover emp Tangible Exportrevenue Intangibles Costsofemployees Totalassets Materialcosts"
  local HUvars "sales_EUR employment tanass_EUR export_EUR immat_EUR persexp_EUR eszk_EUR ranyag_EUR"
  local n : word count `HUorbis'

  putpdf paragraph, font(,20) halign(center)
  putpdf text ("Report on HU national and Orbis comparison"), linebreak(2)
  putpdf paragraph
  putpdf text ("Variables from Orbis: Turnover emp Tangible Exportrevenue Intangibles Costsofemployees Totalassets Materialcosts"), linebreak
  putpdf paragraph
  putpdf text ("Variables from HU balance: sales employment tanass export immat persexp eszk ranyag (original data converted to 1000 EUR, end of the year exchange rate)"), linebreak
  putpdf paragraph
  putpdf text ("Variables in HU balance not compared to Orbis data: other LTS vars"), linebreak(2)

  forvalues i = 1/`n' {
    local a : word `i' of `HUorbis'
    local b : word `i' of `HUvars'
    correl `a' `b'
    return list
    putpdf paragraph
    putpdf text ("Correlation of `a' variables in the 2 datasets is the following (obs=`r(N)'): "), linebreak
    putpdf text ("r = ")
    putpdf text (r(rho)), nformat("%4.3f") bold linebreak
    gen `a'_ratio = `b'/`a'
    summarize `a'_ratio, detail
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
    }
  
putpdf save $output/report/HU_report.pdf, replace

* delete unneccessary png-s
foreach x in `HUorbis' {
    erase "HU`x'.png"
	} 
	