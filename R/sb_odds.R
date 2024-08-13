library(dplyr)
library(oddsapiR)
library(lubridate)

# Saved to GitHub here: 
# https://github.com/Josephhero/Super-Bowl-Odds/tree/main

api_key = Sys.getenv("ODDS_API_KEY")
api_key2 = Sys.getenv("odds_api_secret_input_env")

print("Next line should be API Key")

print(api_key)
print(api_key2)


