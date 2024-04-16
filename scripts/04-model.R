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
restaurants <- read_parquet("./data/analysis_data/restaurant_data.parquet")

### Model data ####
# Convert 5-star rating into Good/bad restaurant
threshold = median(restaurants$rating)

restaurants <- restaurants |>
  mutate(mostly_positive = case_when(
    rating <= threshold ~ 0,
    TRUE ~ 1
  ))

first_model <-
  stan_glm(
    formula = mostly_positive ~ cuisine + price,
    data = restaurants,
    family = binomial(link="logit"),
    prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
    prior_intercept = normal(location = 0, scale = 2.5, autoscale = TRUE),
    seed = 853
  )

#### Save model ####
saveRDS(
  first_model,
  file = "models/restaurant_rating_model_logit2.rds"
)


