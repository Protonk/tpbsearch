library(stringr)

tgrep <- function() {
  tg <- scan("~/pbsearch/searchtext", sep = "\n", what="character.raw", quiet = TRUE)
  tgm <- str_split_fixed(tg, "\\|", 6)[, -1]
  tgm <- data.frame(head(tgm[order(tgm[, 3], decreasing=TRUE),]), stringsAsFactors= FALSE)
  tgm[ , 2] <- paste(format(as.numeric(tgm[, 2])/1024^2, digits = 3, scientific=FALSE), "Mb", sep = " ")
  tgm[ , 3] <- paste(tgm[ , 3], "/", tgm[ , 4], sep = "")
  tgm <- tgm[, -4]
  names(tgm) <- c("Title", "Size", "Seeds/Leechers", "Hash")
  magnet <- paste("magnet:?xt=urn:btih:", tgm[1, "Hash"], sep = "")
  print(tgm)
  flush.console()
  print(magnet)
}

tgrep()
q()