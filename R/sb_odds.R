library(dplyr)
library(oddsapiR)
library(lubridate)

super_bowl_lines <- toa_sports_odds(
  sport_key = 'americanfootball_nfl_super_bowl_winner',  
  regions = 'us', 
  markets = 'outrights',
  odds_format = 'american',
  date_format = 'iso'
) |> 
  mutate(week_of_year = lubridate::week(Sys.Date())) |> 
  mutate(pull_date = date(Sys.Date())) |> 
  filter(bookmaker == "DraftKings") |> 
  select(week_of_year, pull_date, sport_title, bookmaker_last_update, 
         bookmaker, outcomes_name, outcomes_price)

write_csv(super_bowl_lines, "Data/super_bowl_odds.csv")
