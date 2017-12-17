#### Starting script to grab information from View Crop pages of FAO's EcoCrop database




urls2 <- read_lines('/Users/hunterheaivilin/GitHub/Data-Operations/viewcropurl.csv')
urls2 <- urls2[-1]
vws <- list()
vewr <- data_frame(Ecocrop_code, Authority, Family, Synonyms, Common_names, Editor, Notes, Sources)
  
View(vewr)
  for(i in (urls2[1:4])) {
  html2 <- read_html(i)

  vws$gnrl <- html2 %>%
    html_nodes("table") %>% 
    .[2] %>%
    html_table(fill = TRUE) %>%
    .[[1]]
  
  vws$Notes <- html2 %>%
    html_nodes("table") %>% 
    .[3] %>%
    html_table(fill = TRUE) %>%
    .[[1]]

  Authority <- vws$gnrl[1,2]
  Family <- vws$gnrl[2,2]
  Synonyms <- vws$gnrl[3,2]
  Common_names <- vws$gnrl[4,2]
  Editor <- vws$gnrl[5,2]
  Ecocrop_code <- vws$gnrl[6,2]
  Notes <- vws$Notes[1,]
  Sources <- vws$Notes[2,]
  
  vewcrop <- c(Ecocrop_code, Authority, Family, Synonyms, Common_names, Editor, Notes, Sources)
  vewcrop <- t(vewcrop)
  
  # Add crop data from crop i into dataframe with hardcoded column titles
  vewr <- rbind(vewr, vewcrop, colNames = FALSE)
  
}
  
View(vewcrop)

## Error in match.names(clabs, names(xi)) : 
#  names do not match previous names
  