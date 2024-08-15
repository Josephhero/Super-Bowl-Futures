library(dplyr)
library(oddsapiR)
library(lubridate)
library(readr)

sb_futures <- toa_sports_odds(
  sport_key = 'americanfootball_nfl_super_bowl_winner',  
  regions = 'us', 
  markets = 'outrights',
  odds_format = 'american',
  date_format = 'iso'
) |> 
  mutate(week_of_year = lubridate::week(Sys.Date())) |> 
  mutate(pull_date = date(Sys.Date())) |> 
  mutate(super_bowl_year = year(commence_time) - 1) |> 
  mutate(super_bowl_date = as_datetime(commence_time)) |> 
  mutate(bookmaker_last_update = as_datetime(bookmaker_last_update)) |> 
  filter(bookmaker == "DraftKings") |> 
  select(week_of_year, pull_date, sport_title, 
         super_bowl_year, 
         super_bowl_date, 
         bookmaker_last_update, bookmaker, 
         outcomes_name, outcomes_price)

sb_year <- sb_futures$super_bowl_year[1]

file_path <- 
  paste0("https://github.com/Josephhero/Super-Bowl-Futures/raw/main/Data/", 
         sb_year, 
         "_super_bowl_futures.csv")

if (RCurl::url.exists (file_path)) {
  sb_futures_gh <- read_csv(
    paste0("https://github.com/Josephhero/Super-Bowl-Futures/raw/main/Data/", 
           sb_year, 
           "_super_bowl_futures.csv"))
  
  combined_sb_futures <- bind_rows(sb_futures_gh, sb_futures)
  
} else {
  combined_sb_futures <- sb_futures
}

write_csv(combined_sb_futures, 
          paste0("Data/", 
                 sb_year, 
                 "_super_bowl_futures.csv"))
