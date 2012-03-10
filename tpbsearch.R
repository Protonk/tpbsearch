#!/usr/bin/Rscript --no-restore --no-save 

# Just pipe the arguments as you would for any script
# e.g. grep Zoolander ~/tpbsearch/complete | ./tpbsearch.R
# 


library(stringr)

tgrep <- function() {
  tg <- scan(pipe('cat /dev/stdin'), sep = "\n", what="character.raw", quiet = TRUE)
  tgm <- str_split_fixed(tg, "\\|", 6)[, -1]
  tgm <- data.frame(head(tgm[order(as.numeric(tgm[, 3]), decreasing=TRUE),]), stringsAsFactors= FALSE)
  tgm[ , 2] <- paste(format(as.numeric(tgm[, 2])/1024^2, digits = 3, scientific=FALSE), "Mb", sep = " ")
  tgm[ , 3] <- paste(tgm[ , 3], "/", tgm[ , 4], sep = "")
  magnet <- paste("magnet:?xt=urn:btih:", tgm[1, 5], sep = "")
  names(magnet) <- "Magnet URL of Top Result"
  tgm <- tgm[, -4]
  names(tgm) <- c("Title", "Size", "Seeds/Leechers", "Hash")
  closeAllConnections()
  print(tgm, justify = "left")
  print(magnet)
}

tgrep()

q()