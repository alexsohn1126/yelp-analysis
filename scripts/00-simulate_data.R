#### Preamble ####
# Purpose: Simulates the cleaned dataset that we will use to model rating by the cuisine
# Author: Moohaeng Sohn
# Date: 16 April 2024
# Contact: alex.sohn@mail.utoronto.ca
# License: MIT
# Pre-requisites: Download libraries used


#### Workspace setup ####
library(tidyverse)

#### Simulate data ####
set.seed(302)

# Number of restaurants
num_restaurants <- 10

restaurants <- tibble(
  # restaurant names will be "Restaurant 1", "Restaurant 2" and so on...
  restaurant_name = paste("Restaurant", seq(1:num_restaurants)),
  # Generating random float ratings between 1 and 5
  rating = runif(num_restaurants, min = 1, max = 5),
  # Sample from a selection of cuisines
  cuisine = sample(c("Italian", "Mexican", "Indian", "Chinese", "Other"), num_restaurants, replace = TRUE)
)

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
all(is.element(restaurants$cuisine, c("Italian", "Mexican", "Indian", "Chinese", "Other")))
