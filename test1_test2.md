# Test 1
- **respondent** meaning here: firms who were in survey (some of them are also partners, ca 5%)
- **partner** meaning here: firms who were not is the survey (just partners)
- "Orbis only" does not mean only in Orbis. It is the data as it comes from only Orbis, without checking whether the obs is there in the other data. So, in merge codes:
  - **Orbis only** = 1+3
  - **National only** = 2+3
  - **Union** = 1+2+3
## Test results for  Hungary 2015
------------
!missing(ln_sales)
Sample| Orbis only | National only | Union
-- | -- | -- | --
Respondent |  548 | 552 | 552
Partner | 726 | 733 | 737
----------
!missing(ln_employment)
Sample| Orbis only | National only | Union
-- | -- | -- | --
Respondent | 547 | 552 | 552
Partner | 695 | 709 | 710
---------------
!missing(ln_sales, ln_employment, ln_assets, ln_material_costs)
Sample| Orbis only | National only | Union
-- | -- | -- | --
Respondent |    |  |  
Partner |  |  |  

## Test results for Romania 2015
------------
!missing(ln_sales)
Sample| Orbis only | National only | Union
-- | -- | -- | --
Respondent |  580  | 570 |  581
Partner | 1105 | 1085 | 1109
----------
!missing(ln_employment)
Sample| Orbis only | National only | Union
-- | -- | -- | --
Respondent |  571  | 562 |  575
Partner | 1073 | 1060 | 1082
---------------
!missing(ln_sales, ln_employment, ln_assets, ln_material_costs): No data on material costs
Sample| Orbis only | National only | Union
-- | -- | -- | --
Respondent | - | - | -
Partner | - | - | -

## Test results for Slovakia 2015
------------
!missing(ln_sales)
Sample| Orbis only | National only | Union
-- | -- | -- | --
Respondent |   251 | 254 |  254
Partner | 313 | 328 | 331
----------
!missing(ln_employment)
Sample| Orbis only | National only | Union
-- | -- | -- | --
Respondent |  232 | 221 |  237
Partner | 284 | 245 | 306
---------------
!missing(ln_sales, ln_employment, ln_assets, ln_material_costs)
Sample| Orbis only | National only | Union
-- | -- | -- | --
Respondent |  231  | 219 | 237
Partner | 282 | 245 | 306

## Test results for  Hungary 2011
------------
!missing(ln_sales)
Sample| Orbis only | National only | Union
-- | -- | -- | --
Respondent |    |  |  
Partner |  |  |
----------
!missing(ln_employment)
Sample| Orbis only | National only | Union
-- | -- | -- | --
Respondent |  |  |  
Partner |  |  |
---------------
!missing(ln_sales, ln_employment, ln_assets, ln_material_costs)
Sample| Orbis only | National only | Union
-- | -- | -- | --
Respondent |    |  |  
Partner |  |  |  

## Test results for  Romania 2011
------------
!missing(ln_sales)
Sample| Orbis only | National only | Union
-- | -- | -- | --
Respondent |    |  |  
Partner |  |  |
----------
!missing(ln_employment)
Sample| Orbis only | National only | Union
-- | -- | -- | --
Respondent |  |  |  
Partner |  |  |
----------
!missing(ln_sales, ln_employment, ln_assets, ln_material_costs): No data on material costs
Sample| Orbis only | National only | Union
-- | -- | -- | --
Respondent | - | - | -
Partner | - | - | -

## Test results for Slovakia 2011
------------
!missing(ln_sales)
Sample| Orbis only | National only | Union
-- | -- | -- | --
Respondent | 197 | 203 |  203
Partner | 222 | 241 | 241
----------
!missing(ln_employment)
Sample| Orbis only | National only | Union
-- | -- | -- | --
Respondent | 197 | 203 | 203
Partner | 219 | 241 | 241
---------------
!missing(ln_sales, ln_employment, ln_assets, ln_material_costs)
Sample| Orbis only | National only | Union
-- | -- | -- | --
Respondent |  196  | 161 | 202
Partner | 217 | 211 |  240
