#### Preamble ####
# Purpose: Models whether the review is positive based on multiple variables
# Author: Moohaeng Sohn
# Date: 16 April 2024
# Contact: alex.sohn@mail.utoronto.ca
# License: MIT
# Pre-requisites: Run 02-data_cleaning.R


#### Workspace setup ####
library(tidyverse)
library(rstanarm)
library(arrow)

#### Read data ####
data <- read_parquet("./data/analysis_data/restaurant_data.parquet")

### Model data ####

# Rough model
# Don't import the whole MASS library as it interferes with select() from tidyverse
#rough_model <-
#  MASS::polr(factor(rating) ~ cuisine + factor(price), data = data)

# uses 6 cores, reduce if necessary
model <-
  stan_polr(
    formula = factor(rating) ~ cuisine + factor(price),
    cores = 6,
    data = data,
    prior = R2(0.3, "mean"),
    seed = 302
  )

#### Save model ####
saveRDS(
  model,
  file = "models/restaurant_rating_model_ord_logit.rds"
)


