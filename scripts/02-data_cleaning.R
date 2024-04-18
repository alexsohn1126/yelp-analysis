#### Preamble ####
# Purpose: Cleans the raw restaurant review data
# Author: Moohaeng Sohn
# Date: 16 April 2024
# Contact: alex.sohn@mail.utoronto.ca
# License: MIT
# Pre-requisites: Must have Yelp datatset (json) downloaded and extracted into data/raw_data folder

#### Workspace setup ####
library(tidyverse)
library(jsonlite)
library(arrow)

#### Clean data ####
# Load in data
business <- stream_in(file("./data/raw_data/yelp_academic_dataset_business.json", 'r'))

# Filter out non-restaurant businesses
restaurant_categories <- c("Restaurants", "Bars", "Fast Food")

business <- business |>
  flatten(recursive = TRUE) |>
  filter(grepl(paste(restaurant_categories, collapse = "|"), categories)) # turn restaurant categories as regex and match

# Make a new column which indicate what cuisine type this restaurant is
# This list of cuisine is based on the Yelp dataset's categories 
cuisines <- c("American", "Mexican", "Italian", "Chinese", "Japanese", "Mediterranean", "Thai", "Vietnamese", "Indian", "Caribbean", "Middle Eastern", "French")
cuisines_business <- business |>
  # Filter out none category restaurants
  filter(!is.na(attributes.RestaurantsPriceRange2), attributes.RestaurantsPriceRange2 != "None") |>
  mutate(cuisine = case_when(
    # If any of the cuisines in the category, categorize them as that cuisine
    str_detect(categories, regex(paste(cuisines, collapse = "|"), ignore_case = TRUE)) ~ 
      str_extract(categories, regex(paste(cuisines, collapse = "|"), ignore_case = TRUE)),
    # If not, put them as Other
    TRUE ~ "Other"
  ),
  price = as.numeric(attributes.RestaurantsPriceRange2)) |>
  select(restaurant_name=name, rating=stars, cuisine, price)

#### Save data ####
write_parquet(cuisines_business, "./data/analysis_data/restaurant_data.parquet")

