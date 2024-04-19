#### Preamble ####
# Purpose: Tests cleaned yelp restaurants data
# Author: Moohaeng Sohn
# Date: 16 April 2024
# Contact: alex.sohn@mail.utoronto.ca
# License: MIT
# Pre-requisites: Run 02-data_cleaning.R


#### Workspace setup ####
library(tidyverse)
library(arrow)

#### Load Data ####
restaurants <- read_parquet("./data/analysis_data/restaurant_data.parquet")

#### Test data ####
# Test column types
is.character(restaurants$restaurant_name)
is.numeric(restaurants$rating)
is.character(restaurants$cuisine)

# Test rating bounds
# All ratings must be between 1 to 5 (no 0 stars for a review, nor 6+ stars)
all(restaurants$rating >= 1)
all(restaurants$rating <= 5)

# Test that categories are types of cuisines that we specified
cuisines <- c("American", "Mexican", "Italian", "Chinese", "Japanese", "Mediterranean", "Thai", "Vietnamese", "Indian", "Caribbean", "Middle Eastern", "French", "Other")
all(is.element(restaurants$cuisine, cuisines))
