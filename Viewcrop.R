#### Starting script to grab information from View Crop pages of FAO's EcoCrop database

### Check for packages, install if necessary
list.of.packages <- c("rvest", "magrittr", "dplyr", "tidyverse", "httr")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

#Call package libraries
library(rvest)
library(magrittr)
library(dplyr)
library(tidyverse)
library(httr)

urls2 <- read_lines('/Users/hunterheaivilin/GitHub/Data-Operations/viewcropurl.csv')
urls2 <- urls2[-1]
vws <- list()

# Create dataframe, that will be the final master list, with desired column names
vewr <- data_frame("Ecocrop_code", "Authority", "Family", "Synonyms", "Common_names", "Editor", "Notes", "Sources")

# Create another dataframe, that will store scraped tables as the come in, with exact same names
names(vewcrop) <- names(vewr) 

# View output table for no reason
View(vewr)

  # For loop to run through lust of urls 
  for(i in (urls2)) {
    r = GET(i)
    status = status_code(r)
    if(status != 500){

  # Read the html from url i
    html2 <- read_html(i)

  # Scrape the html data from "table" [2] and stash it as a table in sublist vws$gnrl
    vws$gnrl <- html2 %>%
      html_nodes("table") %>% 
      .[2] %>%
      html_table(fill = TRUE) %>%
      .[[1]]

  # Scrape the html data from "table" [3] and stash it as a table in sublist vws$Notes  
    vws$Notes <- html2 %>%
      html_nodes("table") %>% 
      .[3] %>%
      html_table(fill = TRUE) %>%
      .[[1]]

  # Create variables for the speicfic items scraped form the sublists
    Authority <- vws$gnrl[1,2]
    Family <- vws$gnrl[2,2]
    Synonyms <- vws$gnrl[3,2]
    Common_names <- vws$gnrl[4,2]
    Editor <- vws$gnrl[5,2]
    Ecocrop_code <- vws$gnrl[6,2]
    Notes <- vws$Notes[1,]
    Sources <- vws$Notes[2,]
  
  # Make a new list of the desired scraped item variables
    vewcrop <- list (Ecocrop_code, Authority, Family, Synonyms, Common_names, Editor, Notes, Sources)
  
  # Add crop data from crop i into dataframe with hardcoded column titles
    vewr <- rbind(vewr, vewcrop)
    
    }
    else{
      next # jump to next iteration
    }
  
}

# View output and smile
View(vewr)

# Rename columns with variables in first row
colnames(vewr) <- vewr[1,]

# Remove first row 
vewr <-vewr[-1,]

# export to csv
write.csv(vewr,"crop_view_data.csv", row.names=F)