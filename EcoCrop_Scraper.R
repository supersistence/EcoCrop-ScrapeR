### Check for packages, install if necessary
list.of.packages <- c("rvest", "magrittr", "dplyr", "tidyverse")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

#Call package libraries
library(rvest)
library(magrittr)
library(dplyr)
library(tidyverse)


### Grab URL set
# Read entire list of crop datasheet urls into a variable
urllists <- read.csv("/Users/hunterheaivilin/GitHub/Data-Operations/datasheeturl.csv")

#Create variable of a few of the urls (*remove [1:3,] to use entire list*)
webpages <- tibble(urllists[1:3,])

print(webpages)


# for loop to move through through the url list
for(i in 1:nrow(webpages)) {
  url <- toString(webpages[i,1])
  html <- read_html(url) # read URLs html into a 'html' variable
  
  # create empty list to add Description data into (*see if this can happen outside of loop*)
  DESC <- list()
  
  # then specify which table(s) you want to grab & name them something useful (e.g., Ecology, ... , Uses)
  DESC <- webpages %>%
    html_nodes("table") %>% 
    .[1] %>%
    html_table(fill = TRUE) %>%
    .[[1]]
  
  
  # Assign variables to all of the data points you want 
  c2 <- species
  c3 <- DESC[1, 2] 
  c4 <- DESC[2, 2]
  c5 <- DESC[3, 2]
  c6 <- DESC[1, 4]
  c7 <- DESC[2, 4]
  c8 <- DESC[3, 4]
  
  # Make a big 'ol list
  crop_data <- list (c1, c2, c3, c4 ,c5, c6, c7, c8)
  
  super <- matrix(crop_data)
  
  # Transpose
  crop_data <- t(crop_data)
  
  
  print(crop_data)
  
}


