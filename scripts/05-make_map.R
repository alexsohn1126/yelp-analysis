#### Preamble ####
# Purpose: Makes a Leaflet map which will show all the restaurants in the database
# Author: Moohaeng Sohn
# Date: 19 April 2024
# Contact: alex.sohn@mail.utoronto.ca
# License: MIT
# Pre-requisites: Download libraries used, download Yelp Dataset (look at 01-download_data.R)

#### Workspace setup ####
library(tidyverse)
library(jsonlite)
library(leaflet)
library(htmlwidgets)

#### Clean data ####
# Same steps as in 02-data_cleaning.R, except we keep longitude/latitudes
# Load in data
business <- stream_in(file("./data/raw_data/yelp_academic_dataset_business.json", "r"))

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
  mutate(
    cuisine = case_when(
      # If any of the cuisines in the category, categorize them as that cuisine
      str_detect(categories, regex(paste(cuisines, collapse = "|"), ignore_case = TRUE)) ~
        str_extract(categories, regex(paste(cuisines, collapse = "|"), ignore_case = TRUE)),
      # If not, put them as Other
      TRUE ~ "Other"
    ),
    price = as.numeric(attributes.RestaurantsPriceRange2)
  ) |>
  select(name, latitude, longitude, stars, cuisine, price)

#### Make map ####
# Code from https://www.earthdatascience.org/courses/earth-analytics/get-data-using-apis/leaflet-r/
# optimization option specified in:
# https://forum.posit.co/t/plotting-thousands-of-points-in-leaflet-a-way-to-improve-the-speed/8196/2
map <- leaflet(cuisines_business, options = leafletOptions(preferCanvas = TRUE)) |>
  addProviderTiles(providers$CartoDB.DarkMatter) |>
  addCircles(
    lng = ~longitude,
    lat = ~latitude,
    popup = ~ paste0(
      name,
      "<br> Rating: ", stars,
      "<br> Cuisine: ", cuisine,
      "<br> Price: ", strrep("$", price)
    ),
    # Color the circles based on price
    color = ~ case_when(
      price == 1 ~ "#32CD32",
      price == 2 ~ "#FFFF00",
      price == 3 ~ "#FFA500",
      price == 4 ~ "#FF0000"
    )
  ) |>
  addLegend(
    position = "topright",
    colors = c("#32CD32", "#FFFF00", "#FFA500", "#FF0000"),
    labels = c("$: Under $10", "$$: $11-$30", "$$$: $31-$60", "$$$$: Over $61")
  )

rawmap <- leaflet(business, options = leafletOptions(preferCanvas = TRUE)) |>
  addProviderTiles(providers$CartoDB.DarkMatter) |>
  addCircles(
    lng = ~longitude,
    lat = ~latitude
  )

#### Save Map ####
saveWidget(
  widget = map,
  file = "other/map/map.html",
  selfcontained = FALSE
)

saveWidget(
  widget = rawmap,
  file = "other/map/rawmap.html",
  selfcontained = FALSE
)
