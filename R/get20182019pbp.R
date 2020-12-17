#' Assemble 2018-2019 NHL Play-by-Play Data Function
#'
#' Returns a dataframe containing the period, teams, strength, time, active skaters and decription of each event from the 2018-2019 NHL season.
#'
#' @return a data frame containing all of the play-by-play data from the 2018-2019 NHL season
#' @export
#'
#' @examples
#' get20182019Season()
get20182019pbp <- function()
{
  #Looping through each game of the season
  for(i in 1:1271)
  {
    #Printing an update on the function's progress every 100 games
    if(i%%100 == 0)
    {
      print(sprintf("INDEX: %s", i))
    }

    #getting the temporary gameData
    tempData <- assembleGame1(sprintf("http://www.nhl.com/scores/htmlreports/20182019/PL0%s.HTM", 20000 + i))

    if(i == 1)
    {
      `18-19` <- tempData
    }
    else
    {
      `18-19` <- rbind(`18-19`, tempData)
    }
  }

  return(`18-19`)
}
