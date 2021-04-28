stateName <- "Maharashtra"
getConfirmedStates <- function()
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
  total_c$days <- 0
  for(i in 1:length(total_c$cases)){
    total_c[i,]$days <- i
  }
  total_c$days
  total_c <- total_c[,-1]
  plot(total_c$days,total_c$cases,main="Cases VS Days",xlab="Days",ylab ="Cases",type="l")
  d <- data.frame(y = total_c$cases,t=total_c$days)
  assign("d",d,envir = .GlobalEnv)
  return(d)
}
getOrigy<- function()
{
  return (d$y)
}
getOrigx <- function()
{
  return(d$t)
}