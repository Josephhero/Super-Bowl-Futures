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

sb_year <- super_bowl_lines$super_bowl_year[1]

sb_odds_gh <- read_csv(paste0(""))

combined_sb_odds <- bind_rows(sb_odds_gh, super_bowl_lines)

write_csv(combined_sb_odds, 
          paste0("Data/", 
                 sb_year, 
                 "_super_bowl_odds.csv"))


