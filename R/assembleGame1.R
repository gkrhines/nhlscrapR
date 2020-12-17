#' Assemble Play-by-Play Data Function
#'
#' A function to scrape all of the event level data from a www.nhl.com/scores/htmlreports website.
#'
#' @param url a url of the following form: http://www.nhl.com/scores/htmlreports/year/PL02gamenumber.HTM
#'
#' @return a data frame containing all of the play-by-play data from a specific NHL game
#' @export
#'
#' @examples
#' assembleGame("http://www.nhl.com/scores/htmlreports/20192020/PL020001.HTM")
assembleGame1 <- function(url)
{
  #Loading the necessary packages to perform scraping
  library(RCurl)
  library(rvest)
  library(rlist)
  library(XML)

  #Scraping the inputed website
  theurl <- getURL(url = url,.opts = list(ssl.verifypeer = FALSE) )
  tables <- readHTMLTable(theurl)
  tables <- list.clean(tables, fun = is.null, recursive = FALSE)
  n.rows <- unlist(lapply(tables, function(t) dim(t)[1]))

  #Declaring the vectors that we will fill up
  period <- c()
  homes <- c()
  aways <- c()
  strength <- c()
  timeElapsedTime <- c()
  event <- c()
  players1 <- c()
  players2 <- c()
  description <- c()

  #Renaming the elements of the list so they are easily accessible
  tables2 <- list()

  for(i in 1:length(tables))
  {
    tables2[[sprintf("%s",i)]] <- tables[[i]]
  }

  #Getting the home and away team abbreviations of the inputed game
  home <- substr(as.character(tables2[[1]]$V8[20]), 1, 3)
  away <- substr(as.character(tables2[[1]]$V7[20]), 1, 3)

  #Looping through every table of data we scraped
  for(i in 1:length(tables2))
  {
    if(length(as.character(tables2[[sprintf("%s",i)]]$V6[1])) > 0)
    {
      #If we see that a dataframe has at least 6 columns, then we know its got the data we want
      for(j in 1:length(tables2[[sprintf("%s",i)]]$V6))
      {
        #Looking at if a row has data to extract
        if(grepl(":", as.character(tables2[[sprintf("%s",i)]]$V4[j])) & (as.character(tables2[[sprintf("%s",i)]]$V6[j]) != "") &
           as.character(tables2[[sprintf("%s",i)]]$V4[j]) != "Time:ElapsedGame")
        {
          period <- append(period, as.character(tables2[[sprintf("%s",i)]]$V2[j]))
          homes <- append(homes, home)
          aways <- append(aways, away)
          strength <- append(strength, as.character(tables2[[sprintf("%s",i)]]$V3[j]))
          timeElapsedTime <- append(timeElapsedTime, as.character(tables2[[sprintf("%s",i)]]$V4[j]))
          event <- append(event, as.character(tables2[[sprintf("%s",i)]]$V5[j]))
          players1 <- append(players1, as.character(tables2[[sprintf("%s",i)]]$V7[j]))
          players2 <- append(players2, as.character(tables2[[sprintf("%s",i)]]$V8[j]))
          description <- append(description, as.character(tables2[[sprintf("%s",i)]]$V6[j]))
        }
      }
    }
  }

  #Creating a dataframe from the vectors we have filled so far
  output <- data.frame("Period" = period, "Home" = homes, "Away" = aways,  "Str" = strength, "Time:ElapsedTime" = timeElapsedTime,
                       "Event" = event,"Away Skaters" = players1, "Home Skaters" = players2, "Description" = description)

  return(output)
}
