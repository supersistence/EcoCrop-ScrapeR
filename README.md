# Data-Operations
Scraping the FAO EcoCrop database <br />
![FAO](http://ecocrop.fao.org/ecocrop/images/ecocrop-logo.jpg)


The [Food and Agriculture Organization of the United Nations](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&cad=rja&uact=8&ved=0ahUKEwjV0rvhoJrYAhVK02MKHWDUBp8QFggnMAA&url=http%3A%2F%2Fwww.fao.org%2F&usg=AOvVaw0Xte9SsP8ULWKRBs-qjsPg) (FAO) produced a Crop Ecological Requirements Database (EcoCrop) ([explanation here](http://www.fao.org/land-water/land/land-governance/land-resources-planning-toolbox/category/details/en/c/1027491/)) ([database here](http://ecocrop.fao.org/ecocrop/srv/en/home)) with myriad data about over 2500 crop species.

These data have proven useuful for a variety of projects ([1](http://www.sciencedirect.com/science/article/pii/S0168192311002814),[2](http://journals.plos.org/plosone/article?id=10.1371/journal.pone.0183737), [3..](https://scholar.google.com/scholar?q=FAO+ecocrop+database&hl=en&as_sdt=0,5)) but the website offers no download options and query options are limited certain types actions.

To gain better access to the dataset three scripts are used to output .csv files that scrape certain portions of the data for a given crop. 

The [EcoCrop_Scraper.R](https://github.com/supersistence/Data-Operations/blob/master/EcoCrop_Scraper.R) script scrapes the 'Data sheet' page ([example for Okra](http://ecocrop.fao.org/ecocrop/srv/en/dataSheet?id=289)), which contains climatic (rainfall, temperature), soil (pH, depth, etc), and other data for each crop and outputs to [cropbasics_scrape.csv](https://github.com/supersistence/Data-Operations/blob/master/cropbasics_scrape.csv).
To function it requires the [datasheeturl.csv](https://github.com/supersistence/Data-Operations/blob/master/datasheeturl.csv) which is a preproduced list of all the crop urls created by appending the crop codes, found by pulling the full species list by selecting 'all' plants on the [search page](http://ecocrop.fao.org/ecocrop/srv/en/cropSearchForm), to the datasheet url prefix.

The [Usery.R](https://github.com/supersistence/Data-Operations/blob/master/usery.R) script scrapes listed uses for the crop and outputs the listing for all crops into [crop_uses.csv](https://github.com/supersistence/Data-Operations/blob/master/crop_uses.csv), and also requires the prepdocuced [datasheeturl.csv](https://github.com/supersistence/Data-Operations/blob/master/datasheeturl.csv) to function. 

The [Viewcrop.R](https://github.com/supersistence/Data-Operations/blob/master/Viewcrop.R) script scrapes additional data (common names, data sources, etc) from the 'View crop' page ([example for Okra](http://ecocrop.fao.org/ecocrop/srv/en/cropView?id=289)) for each crop and outputs to [crop_view_data.csv](https://github.com/supersistence/Data-Operations/blob/master/crop_view_data.csv). To function it requires the [viewcropurl.csv](https://github.com/supersistence/Data-Operations/blob/master/viewcropurl.csv) which is a preproduced list of 'View crop' page urls for all crops created by appending the crop codes, found by pulling the full species list by selecting 'all' plants on the [search page](http://ecocrop.fao.org/ecocrop/srv/en/cropSearchForm), to the viewcrop url prefix.

