

library(tidyverse)
library(here)
library(glue)
library(fs)

user_input <- "JJcrumpler"
volunteer_hrs_path <- glue(here("Output", "{user_input}", "{user_input}_volunteer_hrs.csv"))

if(dir_exists(glue(here("Output/{user_input}")))){
  message(glue("{user_input} has already logged volunteer hours"))
} else {
  dir_create(glue(here("Output/{user_input}")))
  message(glue("New {user_input} directory created"))
}

day <- today()
s_time <- "4:00"
e_time <- "8:00"
meridiem <- "pm"
s_time <- parse_date_time(glue("{s_time}{meridiem}"), "I:M p") |> format("%H:%M:%S") |> hms()
e_time <- parse_date_time(glue("{e_time}{meridiem}"), "I:M p") |> format("%H:%M:%S") |> hms()
entity_name <- "CGAC"

if(file_exists(volunteer_hrs_path)){
    
  new_data_entry <- tibble(
    "Entity" = entity_name,
    "Date" = day,
    "start_time" = s_time,
    "end_time" = e_time,
    "total_time" = end_time - start_time
  ) |> 
    mutate(across(everything(), as.character))

  new_data_entry |> 
    write_csv(volunteer_hrs_path, append = TRUE)

} else {
  new_data_entry <- tibble(
    "Entity" = entity_name,
    "Date" = day,
    "start_time" = s_time,
    "end_time" = e_time,
    "total_time" = end_time - start_time
  ) |> 
    mutate(across(everything(), as.character))

  new_data_entry |> 
    write_csv(volunteer_hrs_path, col_names = TRUE)
}

current_vlt_hrs <- read_csv(volunteer_hrs_path) |> 
  mutate(
        Date = if_else(str_detect(Date, "\\d{2}\\/\\d{2}\\/\\d{2}"),
                       mdy(Date), 
                       ymd(Date)),
        start_time = hms(start_time),
        end_time = hms(end_time),
        total_time = hms(total_time),
        hours = hour(total_time),
        cumulative_time = cumsum(hours)
      )
