# QRISK-Based Statin Allocation: An RDD Approach

![RDD Visualization](<img width="1152" height="1152" alt="image" src="https://github.com/user-attachments/assets/90be9ade-11fd-40dd-9ab7-0d95124fab8a" />
) 

## 📌 Overview
Regression discontinuity design analysis evaluating statin treatment effects at QRISK ≥ 10% threshold using simulated clinical data.

## 🔍 Key Features
- Sharp RDD implementation with `rdrobust`
- Comprehensive robustness checks:
  - Bandwidth sensitivity
  - Placebo tests
  - Covariate balance
- Clinical policy implications

## 🛠️ How to Run
```r
# Install dependencies
install.packages(c("rdrobust", "tidyverse", "rddensity"))

# Run analysis
rmarkdown::render("RDD_Analysis.Rmd")
```

## 📂 Files
| File | Description |
|------|-------------|
| `RDD_Analysis.Rmd` | Main analysis code |
| `RDD_DATA.csv` | Simulated dataset |

## 📜 License
MIT License
