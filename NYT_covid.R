#####COVID-19 NYT data upload (by Cody Arlie Reed)

##clearing environment
    rm(list=ls())
    gc()

##install or load package for csv
    #install.packages("readr")
    library(readr)

##download covid csv file from NYT github
    temp <- tempfile()
    download.file("https://github.com/nytimes/covid-19-data/archive/master.zip",temp)
    NYT_covid <- read_csv(unz(temp, "covid-19-data-master/us-counties.csv"))
    unlink(temp)

##create variable for state abbreviations
    NYT_covid$stateabb <- state.abb[match(NYT_covid$state,state.name)]
    
##label district of columbia
    NYT_covid$stateabb <- ifelse(NYT_covid$state == "District of Columbia", "DC", NYT_covid$stateabb)
    
##exclude territories
    NYT_covid <- subset(NYT_covid, !is.na(NYT_covid$stateabb))