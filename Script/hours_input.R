

library(tidyverse)
library(here)
library(glue)
library(fs)

user <- "JJcrumpler"

if dir_exists(glue("Output/{user}")){
  
  if !file_exists(glue(here("Output", "{user}", "{user}_volunteer_hrs.csv"))){
    
    tibble(Date = col_date(),
           )
  }
}



