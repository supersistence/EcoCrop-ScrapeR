#### Beginning of script to scrape the use table from FAO EcoCrop crop pages


### Check for packages, install if necessary
list.of.packages <- c("rvest", "magrittr", "dplyr" "tidyverse")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

#Call package libraries
library(rvest)
library(magrittr)
library(dplyr)
library(tidyverse)


### Grab URL set
# Read entire list of crop datasheet urls into a variable
urls <- read_lines("/Users/hunterheaivilin/GitHub/Data-Operations/datasheeturl.csv")

# Remove header line from url list
urls <- urls[-1]

# Create a data frame
yust <- data_frame()

# for loop to move through through the url list
for(i in (urls[])) {
  html <- read_html(i)
  
  # take url string 'i' split along character '='
  brkr <- strsplit(i, "=") 
  cropcode <- brkr[[1]][2]  #Crop code


  # Create empty list to add table data into
  uses_ls <- list()
  
  # Specify which table(s) from html you want to grab & name them something useful (e.g., Ecology, ... , Uses)
  uses_ls$Uses <- html %>%
    html_nodes("table") %>% 
    .[6] %>%
    html_table(fill = TRUE) %>%
    .[[1]]
  
  
  #Clean up list tables into a better format
  
  # Rename columns with variables in first row
  colnames(uses_ls$Uses) <- uses_ls$Uses[1,]
  
  #Remove first row
  uses_ls$Uses <- uses_ls$Uses[-1,]
  
  # Adds new column with crop code
  uses_ls$Uses$crop_code <- cropcode
  
  # Add scraped use table to master use 'yuse' table
  yust <- bind_rows(yust, uses_ls$Uses)
  
}

View(yust)
View(uses_ls$Uses)




#### Receviing error for blank tables
# Error in `$<-.data.frame`(`*tmp*`, "crop_code", value = "299") : 
# replacement has 1 row, data has 0

