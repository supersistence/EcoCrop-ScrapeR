#### Starting script to grab information from View Crop pages of FAO's EcoCrop database

## need to add for looping 

### Functioning  
  urls2 <- read_lines('/Users/hunterheaivilin/GitHub/Data-Operations/viewcropurl.csv')
  urls2 <- urls[-1]
  
  html2 <- read_html(urls[2])
  
  vws <- list()
  
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
  
  View(vws)
  
  
  Authority <- vws$gnrl[1,2]
  Family <- vws$gnrl[2,2]
  Synonyms <- vws$gnrl[3,2]
  Common_names <- vws$gnrl[4,2]
  Editor <- vws$gnrl[5,2]
  Ecocrop_code <- vws$gnrl[6,2]
  Notes <- vws$Notes[1,]
  Sources <- vws$Notes[2,]
  
  vewcrop <- list()
  vewcrop <- c( Authority, Family, Synonym, Common_names, Editor, Ecocrop_code, Notes, Sources)

  View(vws$Notes)
  