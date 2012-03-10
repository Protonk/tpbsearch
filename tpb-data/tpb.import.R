library(stringr)

tpb.loc <- "your file path here"

tpbPrep <- function(location = tpb.loc) {
  tpb.df <- read.table(location, header = FALSE, sep = "|",
                         nrows = 1641228, quote = "", row.names = NULL, 
                         comment.char = "", colClasses = "character",
                         col.names = c("id", "title", "size", "seed", "leech", "hash"),
                         encoding = "UTF-8")[, 2:5]
  # about 20-30 mangled lines per 50,000. Working on a simpler way to exclude them.
  tpb.df <- tpb.df[!(!str_detect(tpb.df[ , 2], pattern =  "^[0-9]+$") | !str_detect(tpb.df[ , 3], pattern =  "^[0-9]+$") | !str_detect(tpb.df[ , 4], pattern =  "^[0-9]+$")), ]
  tpb.df[, 2:4] <- sapply(tpb.df[, 2:4], as.numeric)
  tpb.df
}

tpb.0 <- tpbPrep(location)
tpb.1 <- tpb.0[which(tpb.0[, "seed"] != 0 & tpb.0[, "leech"] != 0), ]
tab.seed <- tabulate(tpb.1[, "seed"])