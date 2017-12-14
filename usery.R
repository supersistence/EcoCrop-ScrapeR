#### Beginning of script to scrape the use table from FAO EcoCrop crop pages


### Check for packages, install if necessary
list.of.packages <- c("rvest", "magrittr", "tidyverse")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

#Call package libraries
library(rvest)
library(magrittr)
library(tidyverse)


### Grab URL set
# Read entire list of crop datasheet urls into a variable
urls <- read_lines("/Users/hunterheaivilin/GitHub/Data-Operations/datasheeturl.csv")

yuse <- data_frame("MainUse", "DetailedUse", "UsedPart")

# for loop to move through through the url list
for(i in (urls[3])) {
  ##  url <- toString(urls[i])
  html <- read_html(i)
  species <- html_text(html_nodes(html, "h2"))

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
  
  # Add scraped use table to master use 'yuse' table
  yuse <- rbind(yuse, uses_ls$Uses)
  
}

View(yuse)
View(uses_ls$Uses)