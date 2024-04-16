# Yelp reviews

## Overview

This repo contains code and data used in the writing of the paper. 


## File Structure

The repo is structured as:

-   `data/analysis_data` contains the cleaned dataset that was constructed.
-   `model` contains fitted models.
-   `other` contains relevant literature, details about LLM chat interactions, and sketches.
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography file, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate, download and clean data.


## Statement on LLM usage

LLM such as ChatGPT was used to assist writing scripts. Further details on the usage is documented in `other/llm/usage.txt`.

## Downloading dataset

The original dataset was too big to include in this repo. Visit https://www.yelp.com/dataset, then click "Download Dataset", fill out the personal information, and download the JSON (NOT the photos). Extract and place the files in `data/raw_data` folder (There should be `PLACE_EXTRACTED_YELP_DATASET_HERE` file there).
