# QRISK-Based Statin Allocation: An RDD Approach

![RDD Visualization](https://example.com/rdd_plot.png) *← Add a plot image later*

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
