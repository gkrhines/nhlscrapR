#' Assemble 2019-2020 NHL Play-by-Play Data Function
#'
#' Returns a dataframe containing the period, teams, strength, time, active skaters and decription of each event from the 2019-2020 NHL season.
#'
#' @return a data frame containing all of the play-by-play data from the 2019-2020 NHL season
#' @export
#'
#' @examples
#' get20192020Season()
get20192020pbp <- function()
{
  #Looping through each game of the season
  for(i in 1:1082)
  {
    #Printing an update on the function's progress every 100 games
    if(i%%100 == 0)
    {
      print(sprintf("INDEX: %s", i))
    }

    #getting the temporary gameData
    tempData <- assembleGame(sprintf("http://www.nhl.com/scores/htmlreports/20192020/PL0%s.HTM", 20000 + i))

    if(i == 1)
    {
      `19-20` <- tempData
    }
    else
    {
      `19-20` <- rbind(`19-20`, tempData)
    }
  }

  return(`19-20`)
}
