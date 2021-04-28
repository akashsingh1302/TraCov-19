library(rgdal)
library(ggplot2)
library(tidyverse)
library(gpclib)
library(readr)
library(broom)
library(minpack.lm)
stateName <- "Maharashtra"
getConfirmed <- function()
{
  ds <- read_csv("C:/Users/College/Downloads/covid.csv")
  ds_fact <- levels(ordered(ds$Date))
  ds<- ds[ds$`State/UnionTerritory` == stateName,]
  total_c <- data.frame(date = as.character(ds_fact))
  total_c$cases <- 0
  for( i in 1:length(ds_fact))
  {
    column <- ds[ds$Date == ds_fact[i],]
    if(length(column)>1)
    {total_c[total_c$date == ds_fact[i],]$cases <- sum(column$Confirmed)}
    else{
      total_c[total_c$date == ds_fact[i],]$cases <- 0
    }
  }
  total_c
  total_c <- total_c[order(as.Date(total_c$date, format="%d/%m/%Y")),]
  total_c <- total_c[order(total_c$cases),]
  total_c$days <- 0
  for(i in 1:length(total_c$cases)){
    total_c[i,]$days <- i
  }
  total_c$days
  total_c <- total_c[,-1]
  d <- data.frame(y = total_c$cases,t=total_c$days)
  return (d)
}
getActive <- function()
{
  ds <- read_csv("C:/Users/College/Downloads/covid_19_india (1).csv")
  ds_fact <- levels(ordered(ds$Date))
  total_c <- data.frame(date = as.character(ds_fact))
  total_c$cases <- 0
  for( i in 1:length(ds_fact))
  {
    column <- ds[ds$Date == ds_fact[i],]
    total_c[total_c$date == ds_fact[i],]$cases <- sum(column$Confirmed) - sum(column$Cured)
  }
  total_c
  total_c <- total_c[order(as.Date(total_c$date, format="%d/%m/%Y")),]
  total_c <- total_c[order(total_c$cases),]
  total_c$days <- 0
  for(i in 1:length(total_c$cases)){
    total_c[i,]$days <- i
  }
  total_c$days
  total_c <- total_c[,-1]
  d <- data.frame(y = total_c$cases,t=total_c$days)
  return (d)
}
set.seed(50)
gompertz <-function()
{
  d <-getConfirmed()
  starting.values <- c(a = 10000, 
                       b=1, 
                       c=1)
  formula <- "y~a*exp(-b*exp(-c*t))"
  result <- nlsLM(formula, data = d, starting.values,control = list(maxiter = 500))
  print(predict(result,data.frame(t=120)))
  t1 <- 1:400
  t1 <- data.frame(t = t1)
  Y<-predict(result,t1)
  orig <- data.frame(x=1:nrow(d),y=d$y)
  res <- data.frame(x=t1,y=Y)
  assign("orig",orig,envir = .GlobalEnv)
  assign("res",res,envir = .GlobalEnv)
  
}
logistic <-function()
{
  d <-getConfirmed()
  starting.values <- c(a = 10000, 
                       b=1, 
                       c=1)
  formula <- "y~(a/(1+exp(b - (c*t))))"
  result <- nlsLM(formula, data = d, starting.values,control = list(maxiter = 500))
  print(predict(result,data.frame(t=120)))
  t1 <- 1:400
  t1 <- data.frame(t = t1)
  Y<-predict(result,t1)
  orig <- data.frame(x=1:nrow(d),y=d$y)
  res <- data.frame(x=t1,y=Y)
  assign("orig",orig,envir = .GlobalEnv)
  assign("res",res,envir = .GlobalEnv)
  
}
bertalanffy <-function()
{
  d <-getConfirmed()
  starting.values <- c(a = 10000, 
                       b=1, 
                       c=1)
  formula <- "y~a*((1-(exp(-b*t)))^c)"
  result <- nlsLM(formula, data = d, starting.values,control = list(maxiter = 500))
  print(predict(result,data.frame(t=120)))
  t1 <- 1:400
  t1 <- data.frame(t = t1)
  Y<-predict(result,t1)
  result
  orig <- data.frame(x=1:nrow(d),y=d$y)
  res <- data.frame(x=t1,y=Y)
  assign("orig",orig,envir = .GlobalEnv)
  assign("res",res,envir = .GlobalEnv)
}
getOrigX <- function(){
  return(orig$x)
}

getOrigY <- function(){
  return(orig$y)
}

getResX <- function()
{
  return(res$t)
}
getResY <- function()
{
  return(res$y)
}
