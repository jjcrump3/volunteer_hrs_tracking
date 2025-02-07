

library(tidyverse)
library(here)
library(glue)
library(fs)

user_input <- "JJcrumpler"

volunteer_hrs_path <- glue(here("Output", "{user_input}", "{user_input}_volunteer_hrs.csv"))

day <- today()
s_time <- "4:00"
e_time <- "8:00"
meridiem <- "pm"
s_time <- parse_date_time(glue("{s_time}{meridiem}"), "I:M p") |> format("%H:%M:%S") |> hms()
e_time <- parse_date_time(glue("{e_time}{meridiem}"), "I:M p") |> format("%H:%M:%S") |> hms()

if(dir_exists(glue(here("Output/{user_input}")))){
  message(glue("{user_input} has logged volunteer hours"))
} else {
  dir_create(glue(here("Output/{user_input}")))
}

current_vlt_hrs <- read_csv(volunteer_hrs_path) |> 
  mutate(
        Date = mdy(Date),
        start_time = hms(start_time),
        end_time = hms(end_time),
        total_time = hms(total_time)
      )

if(file_exists(volunteer_hrs_path)){
    
  new_data_entry <- tibble(
    Date = today(),
    start_time = s_time,
    end_time = e_time,
    total_time = end_time - start_time
  )

  new_data_entry |> write_csv(volunteer_hrs_path, append = TRUE)

} else {
  tibble(
    Date = character(),
    start_time = character(),
    end_time = character(),
    total_time = character()
  ) |> 
    write_csv(volunteer_hrs_path)
}




new_data_entry |> write_csv(volunteer_hrs_path, append = TRUE, col_names = FALSE)
