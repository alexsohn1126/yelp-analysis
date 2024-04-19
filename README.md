# Modelling the Yelp Rating of Restaurants: Disparity of Rating Between Different Restaurant Cuisines and Prices

## Overview

This repo contains code and data used in the writing of the paper.

We use the Yelp dataset to explore and model how different attributes of a restaurant play a factor in the review ratings. We found there are some variables which are promising predictors for the rating of a restaurant. Cuisines such as Chinese or Mexican tended to have lower ratings, and lower priced cuisines performed worse.

## File Structure

The repo is structured as:

-   `data/analysis_data` contains the cleaned dataset that was constructed from Yelp Dataset.
-   `models` contains fitted models.
-   `other` contains the map we've created from the dataset, details about LLM chat interactions, and sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper.
-   `scripts` contains the R scripts used to simulate, download and clean data. As well as creating the interactive map.

## Statement on LLM usage

LLM such as ChatGPT was used to assist writing scripts. Further details on the usage is documented in `other/llm/usage.txt`. No other LLM usage was made.

## Downloading dataset

The original dataset was too big to include in this repo. Visit <https://www.yelp.com/dataset> (Last accessed: 2024 April 15), then click "Download Dataset", fill out the personal information, and download the JSON (NOT the photos). Extract and place the files in `data/raw_data` folder (there should be `PLACE_EXTRACTED_YELP_DATASET_HERE` file there).

## Interactive Map

Interactive map for the raw data can be access here: <https://alexsohn1126.github.io/yelp-analysis/other/map/rawmap.html>.

And the map for the cleaned data can be accessed here: <https://alexsohn1126.github.io/yelp-analysis/other/map/map.html>. Try clicking on datapoints, it shows which restaurant it is, and its rating, cuisine, and price range!
