# Myelin + GFAP Confocal Quantification Analysis

This repository contains the R code used to perform the confocal image quantification and linear mixed-effects model (LMM) analyses reported in *Späte et al., Nature (2026), under review*.

## System requirements

* R ≥ 4.2
* RStudio (recommended)

## Required R packages

The analysis requires the following R packages:

* tidyverse
* xml2
* here
* lme4
* lmerTest

All required packages are installed automatically in the first code chunk of the R Markdown document if they are not already available.

## Instructions

1. Open the `.Rproj` file in RStudio.
2. Open the main `.Rmd` file.
3. Run the code chunks sequentially to reproduce the data processing and statistical analyses.

The script:

* extracts cell counts from ImageJ/Fiji Cell Counter XML files,
* processes particle quantification data,
* summarizes measurements per animal and condition,
* fits a linear mixed-effects model using `lme4`.

## Data

The analysis expects the input data files (CSV files and XML cell counter outputs) to be present in the project directory as is in the repository. Data are part of the Astrocyte analysis of the publication.

## Output

Running the script generates the results of the LMM as well as summary datasets.
