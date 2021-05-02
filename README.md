# Compare HU-RO-SK balance data to Orbis and Harmonize Balance Data for HU, RO, SK
This repo deals with balance data of HU,RO,SK: issues 78 & 76 in [ss-descriptives](https://github.com/ceumicrodata/ss-descriptives/issues)<br/>
Issue 76: Compare HU-RO-SK balance data to Orbis<br/>
- Convert values to EUR
- Ensure variables mean the same in all three
- Save CAT3 bead

Issue 78: Harmonize Balance Data for HU, RO, SK<br/>
- in the CAT2 data, report observations by country by year, coverage of individual variables.
- Correlate common variables in Orbis and HU-RO-SK, we expect rho > 0.99, explore if there are major discrepancies.

# Code
- `SK-database.do`: identifies the duplicate and merges the company names and id (supplier_survey_SK) to balance data (SK_suppliers_data), creating SK_balance_data
- `RO-database.do`: creates RO_balance_data.dta from Date_firme_MNB.xlsx
- `converter.do`: converts 1 RON to 1000 EUR, creates RO_balance_data_EUR.dta. Converts 1000 HUF to 1000 EUR, creates balance_orbis_00_18_EUR.
- `report-compare-orbis.do`: Uses data converted in EUR. Can be run on any further versions of data to check its quality. Creates a pdf report about:
  - observations by country by year, coverage of individual variables (ugly tabstat)
  - Correlate common variables in Orbis and HU-RO-SK
  - check unit (mean, median of ratio)
  - check outliers (log scatterplot)

(Preliminary codes, not needed for further use:
- `SK-match-correct`: helped us realise that except for 15 companies, all "not matched" was because year=.. Tried to run name-generaliser.py on names of the 15 companies not matched (based on BvDid), but didn't work because of character issues. So we created matches by looking at the names: not_matched_orbis_SK_fordito.csv.
- `compare-orbis`: preliminary compare balance&orbis, uses original data not converted in EUR.)

## Summary table of merge and correl

|  | RO | SK | HU |
| -- | -- | -- | -- |
|Obs in firm.csv | 2110 |  1228 | 1663 |
|Obs in Orbis | 1882 | 1060 | 1475 |
|Obs in balance | 1877  | 1060 | 1408 |
|Obs matched to orbis | 1857 |  708 | 1334 |
|Employment r | 0.980 | 0.979 | 0.905 |
|Sales | 0.981 | 0.998 | 0.924 |
|Tangible | 0.994 | 0.897(?) | 0.702(?) |
|Export | - | - | 0.999 |
|Materialcosts | - | 0.99 | - |
|Intangibles | - | - | 0.801(?) |
|Costsofemployees | - | - | 0.838(?) |
|Totalassets | - | - | 0.979 |

- RO correl seems fine

## Overall comments
- **Instructions for SK database** were the following: "drop one firm duplicate, sort by company id, create a fake id with encode. Pay attention to ids that are not corporations (non-profit). Small firms (under 20 employees) come from business registry, they do not have time series, just the 2019 information. Detailed info for firms above 20." Based on this info, **supposed duplicate: company_id:35757442** (obs:249,250).
- in **HU balance: outliers**(Turnover ratio mean=8.8, Intangibles data is weird), and some low correlation (Tangible, Intangibles, Costsofemployees) even after currency exchange
- in **SK balance there are just 744 companies**. 316 companies out of the 1060 with year ==. and also other vars (employees-material_costs) ==., no data on them, these companies all have 1 obs, all vars are missing and no time series data. Mostly because not_in_register or small&micro (small firms (under 20 employees) come from business registry, they do not have time series, just the 2019 information).
- in **SK balance emp var is employees**, not employment. Employment is from a different database (small firms (under 20 employees) come from business registry, they do not have time series, just the 2019 information.
- in **RO balance all missing was 0**. I decoded 0 to . in case of the 7819 records where all vars were 0 (ca 1000 zeros left by variable, out of 37540 size of dataset). Or should we decode 0 to . at all companies? Since I cannot decide which really means "0" and which "." and "." seems reasonable than 0 overall (in SK there was ca 10 zeros and 500 .-s by variable in 7500 obs, except sales_abroad where 1500 zeros and 1100 .-s. In HU similar number of zeros and .-s by variable). But best was if we knew which is real 0, it could matter eg at sales_abroad.
- **HU data was converted from 1000 HUF to 1000 EUR** on end of the year MNB rate (https://www.mnb.hu/arfolyam-lekerdezes) bacause comparable orbis data ratio was around 350.
- **RO data was converted from 1 RON to 1000 EUR** on end of the year ECB rate (https://www.ecb.europa.eu/stats/policy_and_exchange_rates/euro_reference_exchange_rates/html/eurofxref-graph-ron.en.html) because comparable orbis data ratio was around 4500, whereas 1000 EUR= ca 5000 RON. Data before 2005 was exchanged on 2005 rate: I checked whether anything happened in 2005 with the currencies: bar chart of random 1% of sample. There was growth in Sales 2004-2006, but nothing unusual, like 1/10000, so I guess **2000-2004 values are in 2005 RON**.
- There was **no comparable orbis data on RO Expenses, Fix_assets, but I exchanged them as well**. To check whether its ok to do so, I compared them to Sales and Tang ass (we know already that Sales and Tang ass was in 1000EUR because correl wit orbis data and ratio mean, median is nice in report). Created histograms to check whether same unit: Exp/Sales <1, Tang ass/ Fix <1. Tang is same magnitude, and ratios (meaning percentages) seems rational. (relating code in converter.do)
- In **SK tangible, material_costs ration mean ~ 9 -> Discrepancy probably due to outliers**. Discrepancy is not due to currency change koruna to EUR in 2009 (EUR replaced SKK in 2009 on a rate: 30 SKK = 1 EUR), because i checked whether anything happened in 2009 (1 January) with the currencies:bar chart of random 1% of sample. There was growth in tang_assets and material_costs 2008-2009, but nothing unusual, like 1/30, so I guess before-2009 values already in EUR. Also checked mat_cost/sales<1 in the three years (we know already that sales was in 1000EUR because correl wit orbis data and ratio mean, median is nice in report), and it was ok, around 70% which is rational. (relating code in converter.do)

## Observations by country by year, coverage of individual variables
- HU coverage 1000-1300 is quite good, ca 1000-1300 obs per year by variable. 2000-2018
- **SK coverage is poor**, ca 300-600 obs per year by variable. 2000-2018
- RO coverage is quite good, ca 1000-1600 obs per year by variable. 2000-2019

## Further to-do-s
Data prep must-have<br />
- Find ROL exchange rate 2000-2004? data on ECB from 2005, before: WDI in USD, should exchange twice USD->EUR->ROL. We should use just one data source (possibly WDI)<br />
- Use different rates for stock & flow data (stock: end of the year, eg. Tang assets, Fix assets / flow: year avg, eg. Sales, Export)<br />
- Correct some RO BvDIDnumber-s (eg. RO1.10013e+11)<br />
- check HU outliers (with Andris. HU balance is already corrected, "konszolidált eredmények" could be in orbis data)<br/>

Finalize dataset<br />
- merge anon ids (create cat2 data)<br />
- finalize beads
