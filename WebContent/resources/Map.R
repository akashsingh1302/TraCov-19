library(rgdal)
library(ggplot2)
library(tidyverse)
library(gpclib)
library(readr)
library(broom)
date <- "18-05-2020"
setByDate <- function()
{
  ds <- read_csv("C:/Users/College/Downloads/covid_19_india (1).csv")
  ds <- ds[ds$Date == as.Date(date),]
  assign("ds", ds, envir = .GlobalEnv)
}
setShp <- function()
{
  india_cases <- read_csv("C:/Users/College/Downloads/covid_19_india (1).csv")
  days<- as.data.frame(table(india_cases$`State/UnionTerritory`))
  cases <- ds[c(4,9)]
  cases <- cases %>% rename(NAME_1 = `State/UnionTerritory`  )
  shp <-  readOGR(dsn = "C:/Users/College/Downloads/IND_adm/IND_adm1.shp", stringsAsFactors = F)
  cases_info <- shp@data["NAME_1"]
  cases_info<- left_join(cases_info,cases)
  cases_info[is.na(cases_info)] <- 0
  cases_info <- cases_info %>% rename(cases = Confirmed  )
  cases_info$days <- 0
  for(row in 1:nrow(cases_info))
  {
    state <- cases_info[row,"NAME_1"]
    if(state %in% days$Var1)
    {
      cases_info$days[cases_info$NAME_1 == state] <- days[as.character(days$Var1) == state,"Freq"]
    }else{
      cases_info$days[cases_info$NAME_1 == state] <- 0
    }
    
  }  
  set.seed(25)
  trainData <- cases_info[2:3]
  trainData <- data.frame(scale(trainData))
  k <- 4
  if(sum(cases_info$cases)<1000)
  {
    k <- 2
  }else if(sum(cases_info$cases)<20000)
  {
    k <- 3
  }
  result <- kmeans(trainData,k)
  result$cluster
  trainData$cluster <- as.factor(result$cluster)
  cases_info$cluster <- 1
  for(row in 1:nrow(cases_info))
  {
    state <- cases_info[row,"NAME_1"]
    cases_info$cluster[cases_info$NAME_1 == state] <- trainData[row,"cluster"]
    #print(paste(days[as.character(days$Var1) == state,"Freq"],state))
  }
  shp@data$cases = cases_info$cases
  shp@data$cluster = cases_info$cluster
  cases_info
  assign("shp",shp,envir = .GlobalEnv)
}
getStates <- function()
{
  return (shp@data$NAME_1)
}
getClusters <- function()
{
  return(shp@data$cluster)
}
getCases <- function()
{
  return(shp@data$cases)
}

 