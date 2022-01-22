
<!-- README.md is generated from README.Rmd. Please edit that file -->

# simplerfit

<!-- badges: start -->
<!-- badges: end -->

A R package that cleans the data, does basic EDA and returns scores for basic classification and regression models.
This package helps data scientists to clean the data, perform basic EDA, visualize graphical interpretations and analyse performance of the baseline model and basic Classification or Regression models, namely Logistic Regression, Ridge on their data.


## Functions
---
| Function Name | Input                                                                                      | Output                        | Description                                                                                                                          |
|---------------|--------------------------------------------------------------------------------------------|-------------------------------|--------------------------------------------------------------------------------------------------------------------------------------|
| clean_data       | `dataframe`                                                                                | list of 3 dataframes          | Loads and cleans the dataset, removes NA rows, strip extra white spaces, etc  and returns clean dataframe along with `data.info()` , `data.describe()` as dataframes                                                     |
| plot_distributions       | `dataframe`, `bins`, `dist_cols`, `class_label`              | Altair histogram plot object  | creates numerical distribution plots on either all the numeric columns or the ones provided to it  |
| plot_corr       | `dataframe`, `corr`              | Altair correlation plot object  | creates creates correlation plot for all the columns in the dataframe |
| plot_splom       | `dataframe`, `pair_cols`              | Altair SPLOM plot object  | creates SPLOM plot for all the numeric columns in the dataframe or the ones passed by the user |
| fit_regressor     | `train_df`, `target_col`, `numeric_feats`, `categorical_feats`, `text_col`, `cv`           | `dataframe`                   | Preprocesses the data, fits baseline model(`Dummy Regressor`) and `Ridge` with default setup and returns model scores in the form of a dataframe               |
| fit_classifier    | `train_df` ,  `target_col` ,  `numeric_feats` ,  `categorical_feats` ,  `text_col` ,  `cv` | `dataframe`                   | Preprocesses the data, fits baseline model(`Dummy Classifier`) and `Logistic Regression` with default setup and returns model scores in the form of a dataframe|



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

- TODO

## Contributors

This python package was developed by the following Master of Data Science program candidates at the University of the British Columbia:

- Mohammadreza Mirzazadeh [@rezam747](https://github.com/rezam747)
- Zihan Zhou              [@zzhzoe](https://github.com/zzhzoe)
- Navya Dahiya            [@nd265](https://github.com/nd265)
- Sanchit Singh           [@Sanchit120496](https://github.com/Sanchit120496)

## License

`simplefit` was created by Reza Zoe Navya Sanchit. It is licensed under the terms of the MIT license.


