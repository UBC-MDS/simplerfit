
<!-- README.md is generated from README.Rmd. Please edit that file -->

# simplerfit

<!-- badges: start -->
<!-- badges: end -->

A R package that cleans the data, does basic EDA and returns scores for basic classification and regression models.
This package helps data scientists to clean the data, perform basic EDA, visualize graphical interpretations and analyse performance of the baseline model and basic Classification or Regression models, namely Logistic Regression, Ridge on their data.


## Functions
1. `clean_data`: Loads and cleans the dataset, removes NA rows, strip extra white spaces, etc and returns clean data
2. `get_eda`: Creates common exploratory analysis visualizations on numeric and categorical columns in the dataset which are provided to it and returns a list of plots requested by the user
3. `fit_regressor`: Preprocesses the data, fits baseline model(Dummy Regressor) and Ridge with default setup and returns model scores in the form of a dataframe
4. `fit_classifier`:Preprocesses the data, fits baseline model(Dummy Classifier) and Logistic Regression with default setup and returns model scores in the form of a dataframe


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


