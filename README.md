
<!-- README.md is generated from README.Rmd. Please edit that file -->

# simplerfit

[![codecov](https://codecov.io/gh/UBC-MDS/simplerfit/branch/main/graph/badge.svg?token=4ExBXuJ9k5)](https://codecov.io/gh/UBC-MDS/simplerfit)
[![test-coverage](https://github.com/UBC-MDS/simplerfit/actions/workflows/test-coverage.yaml/badge.svg)](https://github.com/UBC-MDS/simplerfit/actions/workflows/test-coverage.yaml)
[![R-CMD-check](https://github.com/UBC-MDS/simplerfit/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/UBC-MDS/simplerfit/actions/workflows/R-CMD-check.yaml)
[![pkgdown](https://github.com/UBC-MDS/simplerfit/actions/workflows/pkgdown.yaml/badge.svg)](https://github.com/UBC-MDS/simplerfit/actions/workflows/pkgdown.yaml)


R package that cleans the data, does basic EDA and returns scores for basic classification and regression models.
This package helps data scientists clean the data, perform basic EDA, visualize graphical interpretations and analyse performance of the baseline model and basic Classification or Regression models, namely Logistic Regression, Ridge on their data.


## Functions

| Function Name | Input                                                                                      | Output                        | Description                                                                                                                          |
|---------------|--------------------------------------------------------------------------------------------|-------------------------------|--------------------------------------------------------------------------------------------------------------------------------------|
| clean_data       | `dataframe`                                                                                | list of 3 dataframes          | Loads and cleans the dataset, removes NA rows, strip extra white spaces, etc  and returns clean dataframe along with `data.info()` , `data.describe()` as dataframes                                                     |
| plot_distributions       | `dataframe`, `bins`, `hist_cols`, `class_label`              | Ggplot histogram plot object  | Creates numerical distribution plots on either all the numeric columns or the ones provided to it  |
| plot_corr       | `dataframe`, `corr`              | Ggplot correlation plot object  | Creates correlation plot for all the columns in the dataframe |
| fit_regressor     | `train_df`, `target_col`, `numeric_feats`, `categorical_feats`, `cv`           | `dataframe`                   | Preprocesses the data, fits baseline model(`Dummy Regressor`) and `Ridge` with default setup and returns model scores in the form of a dataframe               |
| fit_classifier    | `train_df` ,  `target_col` ,  `numeric_feats` ,  `categorical_feats`, `cv` | `dataframe`                   | Preprocesses the data, fits baseline model(`Dummy Classifier`) and `Logistic Regression` with default setup and returns model scores in the form of a dataframe|

### Our Package in R Ecosystem

There exists a subset of our package as standalone packages, namely [autoReg](https://cran.r-project.org/web/packages/autoReg/index.html), [brinton](https://cran.r-project.org/web/packages/brinton/index.html), [correlationfunnel](https://cran.r-project.org/web/packages/correlationfunnel/index.html), [clean](https://cran.r-project.org/web/packages/clean/index.html). But these packages only do the EDA or just making summary tables for descriptive statistics based on linear regression. But with our package, we aim to do all the basic steps of a ML pipeline and save the data scientist's time and effort by cleaning, preprocessing, returning grpahical visualisations from EDA and providing an insight about the basic model performances, after which the user can decide which other models to use.

## Installation

You can install the released version of simplerfit from
[CRAN](https://CRAN.R-project.org) with:

``` r
install.packages("simplerfit")
```

And the development version from [GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("UBC-MDS/simplerfit")
```

## Usage

- https://ubc-mds.github.io/simplerfit/

## Contributors

This R package was developed by the following Master of Data Science program candidates at the University of the British Columbia:

- Mohammadreza Mirzazadeh [@rezam747](https://github.com/rezam747)
- Zihan Zhou              [@zzhzoe](https://github.com/zzhzoe)
- Navya Dahiya            [@nd265](https://github.com/nd265)
- Sanchit Singh           [@Sanchit120496](https://github.com/Sanchit120496)

## License

`simplerfit` was created by Navya, Reza, Sanchit, Zoe. It is licensed under the terms of the MIT license.


