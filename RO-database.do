********************************************************************************
** Balance Romania ***************************************************************
********************************************************************************

* packages needed
* ssc instal renvarlab

* Create panel from Sheet1 (names and ID in "cross-section")
  import excel using "$input_RO_SK/Date_firme_MNB_0511.xlsx", sheet("Sheet1") firstrow clear
  xtset company_id
  forvalues i = 2000/2019 {
    generate _`i' = `i'
    }
  reshape long _, i(company_id) j(year)
  drop _ //completely same values as year 
  save "$temp/Date_firme_MNB.dta", replace

* Create panel .dta from separate .xlsx sheets
  local ROvars Sales Fix_assets Tang_assets Employment Expenses
  foreach x in `ROvars' {
    import excel using "$input_RO_SK/Date_firme_MNB_0511.xlsx", sheet("`x'") firstrow clear 
    xtset CUIfirma
    renvarlab B-U, label
    reshape long _, i(CUIfirma) j(year) 
    rename _ `x'
    label variable `x' "`x'"
	rename CUIfirma company_id
    save "$temp/Date_firme_MNB_`x'.dta", replace
	} 
	
* merge
  use "$temp/Date_firme_MNB.dta", clear
  foreach x in `ROvars' {
    merge 1:1 company_id year using "$temp/Date_firme_MNB_`x'.dta", keep(match) nogen
    }
  sort company_id year
  label variable Sales "Sales = Cifra de afacceri (árbevétel)"
  label variable Fix_assets "Fixed assets = imobilizari corporale+ imobilizari necorporale + imobilizari financiare (tárgyi+immat+pénzügyi eszközök)"
  label variable Tang_assets "Tangible assets = imobilizari corporale (tárgyi eszközök)"
  label variable Employment "Employment = numar salariati. (állományi létszám)"
  label variable Expenses "Expenses =  Material cost"
  label variable company_id "from firm.csv BVDid"
  gen country = "RO"
  format company_id %11.0f
  tostring company_id, gen(company_id_str) force
  gen BvDIDnumber = country + company_id_str
  label variable BvDIDnumber "Generated from country + company_id"
  drop company_id
  rename company_id_str company_id
  
* correct missing values 0 to .
  mvdecode Sales Fix_assets Tang_assets Employment Expenses if Sales == 0 & Fix_assets == 0 & Tang_assets == 0 & Employment == 0 & Expenses== 0, mv(0 = .)
  save "$output/RO_balance_data", replace

* delete unnecessary files
  erase "$temp/Date_firme_MNB.dta"
  foreach x in `ROvars' {
    erase "$temp/Date_firme_MNB_`x'.dta"
	} 