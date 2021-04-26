********************************************************************************
** Balance Slovakia ***************************************************************
********************************************************************************

/*Instructions:
drop one firm duplicate
sort by company id
create a fake id with encode

Pay attention to ids that are not corporations (non-profit)
small firms (under 20 employees) come from business registry, they do not have time series, just the 2019 information
detailed info for firms above 20 */

* find duplicate
  use "$input_RO_SK/supplier_survey_SK.dta", clear
  duplicates list company_id //obs:249,250, company_id:35757442
  duplicates drop company_id, force

* prepare for merge
  sort company_id
  encode company_id, generate(fid)

* merge
  merge 1:m fid using "$input_RO_SK/SK_suppliers_data.dta", nogen
  sort company_id year
  gen BvDIDnumber = country + company_id
  label variable company_id "from firm.csv BVDid"
  label variable BvDIDnumber "Generated from country + company_id"
  save "$output/SK_balance_data.dta", replace
  

