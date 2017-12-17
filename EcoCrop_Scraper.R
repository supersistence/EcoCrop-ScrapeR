#### Beginning of script to scrape crop data from FAO's EcoCrop database



### Check for packages, install if necessary
list.of.packages <- c("rvest", "magrittr", "tidyverse")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)

#Call package libraries
library(rvest)
library(magrittr)
library(tidyverse)


### Grab and read entire list of crop datasheet urls into a variable
urls <- read_lines("/Users/hunterheaivilin/GitHub/Data-Operations/datasheeturl.csv")

# Remove header row from url list
urls <- urls[-1]

# Create dataframe with precreated hardcoded column names
myDataFrame <- read.csv("/Users/hunterheaivilin/GitHub/Tables-All-The-Way-Down/ecocrop_colnames.csv", header=TRUE, stringsAsFactors=FALSE)


# for loop to move through through the url list. [1:50]
for(i in (urls)) {
  html <- read_html(i)
  species <- html_text(html_nodes(html, "h2"))
  
  # print(cat("Grabbing", species, "data from", i)) ## use this if you want a read out 
  
  # Create empty list to add table data into
  tbls2_ls <- list()
  
  # Specify which table(s) from html you want to grab & name them something useful (e.g., Ecology, ... , Uses)
  tbls2_ls$Description <- html %>%
    html_nodes("table") %>% 
    .[1] %>%
    html_table(fill = TRUE) %>%
    .[[1]]
  
  tbls2_ls$Ecology <- html %>%
    html_nodes("table") %>% 
    .[2] %>%
    html_table(fill = TRUE) %>%
    .[[1]]
  
  tbls2_ls$ClimaticZone <- html %>%
    html_nodes("table") %>% 
    .[3] %>%
    html_table(fill = TRUE) %>%
    .[[1]]
  
  tbls2_ls$Cultivation <- html %>%
    html_nodes("table") %>% 
    .[4] %>%
    html_table(fill = TRUE) %>%
    .[[1]]
  
  tbls2_ls$Uses <- html %>%
    html_nodes("table") %>% 
    .[6] %>%
    html_table(fill = TRUE) %>%
    .[[1]]
  
  
  #Clean up list tables into a better format
  
  # Rename columns with variables in first row
  colnames(tbls2_ls$Uses) <- tbls2_ls$Uses[1,]
  
  #Remove first row
  tbls2_ls$Uses <- tbls2_ls$Uses[-1,]
  
  # take url string 'i' split along character '='
  brkr <- strsplit(i, "=")
  
  ## Assign variables from table data
  # Creates variables that concide with item_list 
  
  c1 <- brkr[[1]][2]  #Crop code
  c2 <- species # Species name
  c3 <- tbls2_ls$Description[1, 2] # Life form
  c4 <- tbls2_ls$Description[2, 2] # Habit
  c5 <- tbls2_ls$Description[3, 2] # Life span
  c6 <- tbls2_ls$Description[1, 4] # Physiology
  c7 <- tbls2_ls$Description[2, 4] # Category
  c8 <- tbls2_ls$Description[3, 4] # Plant attributes
  c9 <- tbls2_ls$Ecology[3,2] # Temperature optimal min
  c10 <- tbls2_ls$Ecology[3,3] # Temperature optimal max
  c11 <- tbls2_ls$Ecology[3,4] # Temperature absolute min
  c12 <- tbls2_ls$Ecology[3,5] # Temperature absolute min
  c13 <- tbls2_ls$Ecology[4,2] # Rainfall optimal min
  c14 <- tbls2_ls$Ecology[4,3] # Rainfall optimal max
  c15 <- tbls2_ls$Ecology[4,4] # Rainfall absolute min
  c16 <- tbls2_ls$Ecology[4,5] # Rainfall absolute max
  c17 <- tbls2_ls$Ecology[5,2]
  c18 <- tbls2_ls$Ecology[5,3]
  c19 <- tbls2_ls$Ecology[5,4]
  c20 <- tbls2_ls$Ecology[5,5]
  c21 <- tbls2_ls$Ecology[6,2]
  c22 <- tbls2_ls$Ecology[6,3]
  c23 <- tbls2_ls$Ecology[6,4]
  c24 <- tbls2_ls$Ecology[6,5]
  c25 <- tbls2_ls$Ecology[7,2]
  c26 <- tbls2_ls$Ecology[7,3]
  c27 <- tbls2_ls$Ecology[7,4]
  c28 <- tbls2_ls$Ecology[7,5]
  c29 <- tbls2_ls$Ecology[8,2]
  c30 <- tbls2_ls$Ecology[8,3]
  c31 <- tbls2_ls$Ecology[8,4]
  c32 <- tbls2_ls$Ecology[8,5]
  c33 <- tbls2_ls$Ecology[2,7]
  c34 <- tbls2_ls$Ecology[2,8]
  c35 <- tbls2_ls$Ecology[3,7]
  c36 <- tbls2_ls$Ecology[3,8]
  c37 <- tbls2_ls$Ecology[4,7]
  c38 <- tbls2_ls$Ecology[4,8]
  c39 <- tbls2_ls$Ecology[5,7]
  c40 <- tbls2_ls$Ecology[5,8]
  c41 <- tbls2_ls$Ecology[6,7]
  c42 <- tbls2_ls$Ecology[6,8]
  c43 <- tbls2_ls$Ecology[7,7]
  c44 <- tbls2_ls$Ecology[7,8]
  c45 <- tbls2_ls$ClimaticZone[1,2]
  c46 <- tbls2_ls$ClimaticZone[1,4]
  c47 <- tbls2_ls$ClimaticZone[2,2]
  c48 <- tbls2_ls$ClimaticZone[2,4]
  c49 <- tbls2_ls$ClimaticZone[3,2]
  c50 <- tbls2_ls$ClimaticZone[3,4]
  c51 <- tbls2_ls$ClimaticZone[4,2]
  c52 <- tbls2_ls$Cultivation[2,2]
  c53 <- tbls2_ls$Cultivation[3,1]
  c54 <- tbls2_ls$Cultivation[3,2]
  c55 <- tbls2_ls$Cultivation[3,3]
  c56 <- tbls2_ls$Cultivation[3,4]
  c57 <- tbls2_ls$Cultivation[3,5]
  c58 <- tbls2_ls$Cultivation[2,4]
  c59 <- tbls2_ls$Cultivation[2,5]
  c60 <- c(tbls2_ls$Uses [1,1])
  c61 <- c(tbls2_ls$Uses[1,2])
  c62 <- c(tbls2_ls$Uses[1,3])
  c63 <- i # datasheet url
  
  # Make a big 'ol list
  crop_data <- list (c1, c2, c3, c4 ,c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15, c16, c17, c18, c19, c20, c21, c22, c23, c24, c25, c26, c27, c28, c29, c30, c31, c32, c33, c34, c35, c36, c37, c38, c39, c40, c41, c42, c43, c44, c45, c46, c47, c48, c49, c50, c51, c52, c53, c54, c55, c56, c57, c58, c59, c60, c61, c62, c63)
  
  # Add crop data from crop i into dataframe with hardcoded column titles
  myDataFrame <- rbind(myDataFrame, crop_data)
  
}

# View output in Rstudio
View(myDataFrame)

# Delete 1st row (duplicate title row) and save to csv
write.csv(myDataFrame[-1,],"cropbasics.csv", row.names=F)


