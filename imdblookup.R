#Use the OMDB API to search movie titles and find their IMDB IDs.

library(jsonlite)

apikey <- "YOUR API KEY HERE"
api.URL <- paste0("http://www.omdbapi.com/?apikey=", apikey, "&i=")

#Example movie list
movielist <- c("the+social+network", "black+swan")

results <- data.frame()

for (i in 1:length(movielist)) {
  url <- paste0("http://www.omdbapi.com/?apikey=", apikey, "=", movielist[i])
  moviedata <- fromJSON(url)
  ID <- moviedata$imdbID
  results[i,1] <- movielist[i]
  results[i,2] <- ID
}

#Adding a column for movie title names that is correctly formatted

simpleCap <- function(x) {
  s <- strsplit(x, " ")[[1]]
  paste(toupper(substring(s, 1,1)), substring(s, 2),
        sep="", collapse=" ")
}

results[,3] <- gsub("\\+", " ", results$V1)
results$V3 <- lapply(results$V3, simpleCap)
