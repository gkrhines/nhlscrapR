#' Assemble 2015-2016 NHL Play-by-Play Data Function
#'
#' Returns a dataframe containing the period, teams, strength, time, active skaters and decription of each event from the 2015-2016 NHL season.
#'
#' @return a data frame containing all of the play-by-play data from the 2015-2016 NHL season
#' @export
#'
#' @examples
#' get20152016pbp()
get20152016pbp <- function()
{
  #Looping through each game of the season
  for(i in 1:1230)
  {
    #Printing an update on the function's progress every 100 games
    if(i%%100 == 0)
    {
      print(sprintf("INDEX: %s", i))
    }

    #getting the temporary gameData
    tempData <- assembleGame1(sprintf("http://www.nhl.com/scores/htmlreports/20152016/PL0%s.HTM", 20000 + i))

    if(i == 1)
    {
      `15-16` <- tempData
    }
    else
    {
      `15-16` <- rbind(`15-16`, tempData)
    }
  }

  return(`15-16`)
}
