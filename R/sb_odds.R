library(dplyr)
library(oddsapiR)
library(lubridate)

# Saved to GitHub here: 
# https://github.com/Josephhero/Super-Bowl-Odds/tree/main

super_bowl_lines <- toa_sports_odds(
  sport_key = 'americanfootball_nfl_super_bowl_winner',  
  regions = 'us', 
  markets = 'outrights',
  odds_format = 'american',
  date_format = 'iso'
) |> 
  mutate(week_of_year = lubridate::week(Sys.Date())) |> 
  mutate(pull_date = date(Sys.Date())) |> 
  mutate(super_bowl_year = year(commence_time) - 1) |> 
  filter(bookmaker == "DraftKings") |> 
  select(week_of_year, pull_date, sport_title, 
         super_bowl_year, 
         super_bowl_date = commence_time, 
         bookmaker_last_update, bookmaker, 
         outcomes_name, outcomes_price)

write_csv(super_bowl_lines, 
          paste0("Data/", 
                 super_bowl_lines$super_bowl_year[1], 
                 "_super_bowl_odds.csv"))


