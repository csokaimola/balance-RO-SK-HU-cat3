# Comparison of Orbis & National data coverage
- **respondent** meaning here: firms who were in survey (some of them are also partners, ca 5%)
- **partner** meaning here: firms who were not is the survey (just partners)
- "Orbis only" does not mean only in Orbis. It is the data as it comes from only Orbis, without checking whether the obs is there in the other data. So, in merge codes:
  - **Orbis only** = 1+3
  - **National only** = 2+3
  - **Union** = 1+2+3
# Test 1
Coverage of TFP variables, cross section in 2011 and 2015

## Slovakia - TFP variables
### 2011

!missing(ln_sales)
Sample| Orbis only | National only | Union
-- | -- | -- | --
Respondent | 345 | 203 |  351
Partner | 499 | 241 | 518

!missing(ln_employment)
Sample| Orbis only | National only | Union
-- | -- | -- | --
Respondent | 328 | 203 | 334
Partner | 447 | 241 | 469

!missing(ln_sales, ln_employment, ln_assets, ln_material_costs)
Sample| Orbis only | National only | Union
-- | -- | -- | --
Respondent |  323  | 161 | 329
Partner | 422 | 211 |  445

### 2015

!missing(ln_sales)
Sample| Orbis only | National only | Union
-- | -- | -- | --
Respondent | 361 | 254 |  364
Partner | 531 | 328 | 549

!missing(ln_employment)
Sample| Orbis only | National only | Union
-- | -- | -- | --
Respondent |  334 | 221 |  339
Partner | 503 | 245 | 525

!missing(ln_sales, ln_employment, ln_assets, ln_material_costs)
Sample| Orbis only | National only | Union
-- | -- | -- | --
Respondent |  333  | 219 | 339
Partner | 477 | 245 | 501

## Romania - TFP variables
### 2011

!missing(ln_sales)
Sample| Orbis only | National only | Union
-- | -- | -- | --
Respondent | 538 | 561 | 566
Partner | 1028 | 1053 | 1063

!missing(ln_employment)
Sample| Orbis only | National only | Union
-- | -- | -- | --
Respondent | 531 | 554 | 559
Partner |996  | 1027 | 1035

!missing(ln_sales, ln_employment, ln_assets, ln_material_costs): No data on material costs in National
Sample| Orbis only | National only | Union
-- | -- | -- | --
Respondent | 528 | - | 528
Partner | 981 | - | 981

### 2015

!missing(ln_sales)
Sample| Orbis only | National only | Union
-- | -- | -- | --
Respondent |  580  | 571 |  582
Partner | 1108 | 1085 | 1112

!missing(ln_employment)
Sample| Orbis only | National only | Union
-- | -- | -- | --
Respondent |  571  | 563 |  576
Partner | 1076 | 1060 | 1085

!missing(ln_sales, ln_employment, ln_assets, ln_material_costs): No data on material costs in National
Sample| Orbis only | National only | Union
-- | -- | -- | --
Respondent | 560 | - | 560
Partner | 1054 | - | 1054

## Hungary - TFP variables
### 2011

!missing(ln_sales)
Sample| Orbis only | National only | Union
-- | -- | -- | --
Respondent | 529 | 548 | 552
Partner | 738 | 711 | 778

!missing(ln_employment)
Sample| Orbis only | National only | Union
-- | -- | -- | --
Respondent | 519 | 543 | 550
Partner | 657 | 692 | 747

!missing(ln_sales, ln_employment, ln_assets, ln_material_costs)
Sample| Orbis only | National only | Union
-- | -- | -- | --
Respondent | 237 | 543 | 548
Partner | 430 | 687 | 726

### 2015
!missing(ln_sales)
Sample| Orbis only | National only | Union
-- | -- | -- | --
Respondent |  552 | 552 | 556
Partner | 787 | 735 | 800

!missing(ln_employment)
Sample| Orbis only | National only | Union
-- | -- | -- | --
Respondent | 551 | 552 | 556
Partner | 753 | 711 | 770

!missing(ln_sales, ln_employment, ln_assets, ln_material_costs)
Sample| Orbis only | National only | Union
-- | -- | -- | --
Respondent |  250  | 543 | 546
Partner | 476 | 696 | 746

-----------------------------------------------


# Test 2
Coverage of sales growth, 2018/2015 and 2015/2011

## Slovakia - sales growth

### 2015/2011
Sample| Orbis only | National only | Union
-- | -- | -- | --
Respondent | 338 | 189 | 344
Partner | 467 | 221 | 488

### 2018/2015
Sample| Orbis only | National only | Union
-- | -- | -- | --
Respondent |  336 | 28 | 336
Partner | 500 | 67 | 501

## Romania- sales growth

### 2015/2011
Sample| Orbis only | National only | Union
-- | -- | -- | --
Respondent | 532 | 544 | 559
Partner | 1005 | 1007 | 1036

### 2018/2015
Sample| Orbis only | National only | Union
-- | -- | -- | --
Respondent | 551 | 539 | 553
Partner | 1065 | 1044 | 1070

## Hungary - sales growth

### 2015/2011
Sample| Orbis only | National only | Union
-- | -- | -- | --
Respondent | 522 | 545 | 549
Partner | 719 | 688 | 757

### 2018/2015
Sample| Orbis only | National only | Union
-- | -- | -- | --
Respondent |  530 | 529 | 541
Partner | 763 | 696 | 782

# Test 3
For respondents (sum:1543), in national only. By country, variable: share of non missing in 2006, same for 2001.
## Slovakia - respondent (sum:395), national
### 2001
!missing(ln_sales): 86
!missing(ln_employment): 86
!missing(ln_sales, ln_employment, ln_assets, ln_material_costs): 53
### 2006
!missing(ln_sales): 130
!missing(ln_employment): 130
!missing(ln_sales, ln_employment, ln_assets, ln_material_costs): 113
## Romania - respondent (sum: 589), national
### 2001
!missing(ln_sales): 320
!missing(ln_employment): 300
!missing(ln_sales, ln_employment, ln_assets, ln_material_costs): -
### 2006
!missing(ln_sales): 476
!missing(ln_employment): 473
!missing(ln_sales, ln_employment, ln_assets, ln_material_costs): -

## Hungary - respondent (sum: 559), national
### 2001
!missing(ln_sales): 399
!missing(ln_employment): 390
!missing(ln_sales, ln_employment, ln_assets, ln_material_costs): 386
### 2006
!missing(ln_sales): 477
!missing(ln_employment): 470
!missing(ln_sales, ln_employment, ln_assets, ln_material_costs): 470
