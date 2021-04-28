library(jsonlite)
add1 <- function(a,b){
  x <- c(1,2,3)
  y <- c("a","b","c")
  df <- data.frame(sr = x, name= y)
  df_json <- toJSON(df)
  return(df_json)
}
x <- c(1,2,3)
y <-c("a","b","c")
add <- function(){
  x <- c(1,2,3)
  y <- c("a","b","c")
  return (x,y)
  }
getX <- function()
{
return (x)
}
getY <- function()
{
return (y)
}