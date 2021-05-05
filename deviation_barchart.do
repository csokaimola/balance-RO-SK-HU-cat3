capture log close
log using "$output/report/deviations_logfile.log", replace text 
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
merge 1:1 BvDIDnumber year using $input_orbis/balance_long, generate(check)
keep if year == 2015
putpdf clear
putpdf begin

* report on extreme deviations in data enrichement (count and mean of ratio bins)
  local HUorbis "Turnover emp Tangible Exportrevenue Costsofemployees Totalassets Materialcosts"
  local HUvars "sales_EUR employment tanass_EUR export_EUR persexp_EUR eszk_EUR ranyag_EUR"
  local n : word count `HUorbis'

  putpdf paragraph, font(,20) halign(center)
  putpdf text ("Report on HU extreme deviations in data enrichement"), linebreak(2)
  putpdf paragraph
  putpdf text ("Bar graph of ratio by bins, count within a given bin is written on the top"), linebreak
  putpdf paragraph

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
	
	graph bar (count) `a'_ratio, yla(, ang(v)) over(`a'_bin) blabel(total)
	graph export HU`a'.png, replace
	putpdf paragraph, halign(center)
    putpdf image HU`a'.png, linebreak width(3.5)
	
	summarize `a'_ratio if `a'_bin == "<0.5", detail
    return list
    putpdf text ("mean in bin<0.5 = ")
    putpdf text (r(mean)), nformat("%4.3f") bold linebreak	
	
	summarize `a'_ratio if `a'_bin == "<0.5", detail
    return list
    putpdf text ("mean in bin<0.5 = ")
    putpdf text (r(mean)), nformat("%4.3f") bold linebreak
	
	summarize `a'_ratio if `a'_bin == ">2", detail
    return list
    putpdf text ("mean in bin>2 = ")
    putpdf text (r(mean)), nformat("%4.3f") bold linebreak
	
	* bins written vertically
	tabstat `a'_ratio, stat(count) by(`a'_bin)
	tabstat `a'_ratio, stat(mean) by(`a'_bin)
	


    }

putpdf save $output/report/HU_deviation.pdf, replace

* delete unneccessary png-s
foreach x in `HUorbis' {
    erase "HU`x'.png"
	} 
	
*/
log close