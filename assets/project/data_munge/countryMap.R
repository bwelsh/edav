source("countryData.R")

data <- loadCountryData("country_data_3.csv")

shapeWide <- function(data, round, subject) {
  sub_data <- data[data$Round == round & data$Subject == subject, ]
  reshaped <- reshape(sub_data, timevar="Test", idvar=c("Country", "Region", "Round", "Subject"), direction="wide")
}

standardizeScores <- function(data, round, subject) {
  reshaped <- shapeWide(data, round, subject)
  standard <- cbind(reshaped[,c(1:4)], scale(reshaped[, -c(1:4)]))
}

rounds <- c(1,2,3)
subjects <- c("Math", "Science")
scores <- data.frame()
for (i in rounds) {
  for (j in subjects) {
    scores <- rbind.data.frame(scores, standardizeScores(data, i, j))
  }
}

write.csv(scores, "one_round.csv")

shapeWideSub <- function(data, round, subject, countries) {
  sub_data <- data[data$Round == round & data$Subject == subject & data$Country %in% countries, ]
  reshaped <- reshape(sub_data, timevar="Test", idvar=c("Country", "Region", "Round", "Subject"), direction="wide")
}

standardizeScoresSub <- function(data, round, subject, countries) {
  reshaped <- shapeWideSub(data, round, subject, countries)
  standard <- cbind(reshaped[,c(1:4)], scale(reshaped[, -c(1:4)]))
}

getRoundCountries <- function(file, rounds, test) {
  data <- loadCountryData(file)
  countries <- subset(data, Round == rounds[1], select=c("Country"))
  countries <- levels(countries$Country)[countries$Country]
  for (i in rounds) {
    test_countries <- subset(data, Round == i & Test == test, select=c("Country"))
    test_countries <- levels(test_countries$Country)[test_countries$Country]
    countries <- intersect(test_countries, countries)
  }
  return (countries)
}

outputRoundTests <- function(test) {
  round_matches <- list(c(1,2,3), c(1,2), c(1,3), c(2,3))
  subjects <- c("Math", "Science")
  count <- 1
  for (rounds in round_matches) {
    matched <- getRoundCountries("country_data_3.csv", rounds, test)
    scores <- data.frame()
    for (i in rounds) {
      for (j in subjects) {
        scores <- rbind.data.frame(scores, standardizeScoresSub(data, i, j, matched))
      }
    }
    write.csv(scores, paste("round_match_", count, "_", test, ".csv", sep=""))
    count <- count + 1
  }
}

tests <- c("PISA", "TIMSS")
for (i in tests) {
  outputRoundTests(i)
}

shapeWideTest <- function(data, round, subject, test, countries) {
  sub_data <- data[data$Round == round & data$Subject == subject & data$Test == test & data$Country %in% countries, ]
  sub_data$Test <- "Test"
  reshaped <- reshape(sub_data, timevar="Test", idvar=c("Country", "Region", "Round", "Subject"), direction="wide")
}

standardizeScoresTest <- function(data, round, subject, test, countries) {
  reshaped <- shapeWideTest(data, round, subject, test, countries)
  standard <- cbind(reshaped[,c(1:4)], scale(reshaped[, -c(1:4)]))
}

round_matches <- list(c(1,2,3), c(1,2), c(1,3), c(2,3), c(1), c(2), c(3))
subjects <- c("Math", "Science")
count <- 1
for (rounds in round_matches) {
  matched <- getMatchedCountries("country_data_3.csv", rounds)
  pscores <- data.frame()
  tscores <- data.frame()
  for (i in rounds) {
    for (j in subjects) {
      pscores <- rbind.data.frame(pscores, standardizeScoresTest(data, i, j, "PISA", matched))
      tscores <- rbind.data.frame(tscores, standardizeScoresTest(data, i, j, "TIMSS", matched))
    }
  }
  scores <- cbind(pscores[,c(1:5)], (pscores - tscores)[,-c(1:5)])
  
  write.csv(scores, paste("round_match_", count, "_comparison.csv", sep=""))
  count <- count + 1
}
