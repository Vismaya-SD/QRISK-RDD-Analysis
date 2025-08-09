# QRISK-Based Statin Allocation: An RDD Approach
[![Live Report](https://img.shields.io/badge/View_Live_Report-FF6B6B?style=for-the-badge&logo=github)](https://Vismaya-SD.github.io/QRISK-RDD-Analysis/)

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
