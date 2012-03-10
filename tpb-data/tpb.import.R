library(stringr)
library(ggplot2)

tpb.loc <- "your file path here"
tpb.loc.ex <- file.path(getwd(), "tpb.clean.txt")

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

tpb.0 <- tpbPrep(location = tpb.loc.ex)
tpb.1 <- tpb.0[which(tpb.0[, "seed"] != 0 & tpb.0[, "leech"] != 0), ]
tab.seed <- tabulate(tpb.1[, "seed"])

qplot(log(tab.seed), log(1:length(tab.seed)), geom = "point") + coord_flip() +
  scale_x_continuous(name = "Log Peers Seeding") + scale_y_continuous(name = "Log Rank")+
  opts(title = expression("Rank vs. Absolute number of peers per torrent"))

# Magic http://finzi.psych.upenn.edu/R/Rhelp02a/archive/33097.html
peaks<-function(series,span=3) { 
  z <- embed(series, span) 
  s <- span%/%2 
  v<- max.col(z) == 1 + s 
  result <- c(rep(FALSE,s),v) 
  result <- result[1:(length(result)-s)] 
  result 
}

densize <- density(log(tpb.0[which(tpb.0[, 2] >= 400000), 2], 2))
densize <- data.frame(cbind(as.numeric(densize$x), as.numeric(densize$y)))
names(densize) <- c("Size", "Density")
peakmat <- data.frame(cbind(densize$Size[peaks(densize$Density)], densize$Density[peaks(densize$Density)]))
names(peakmat) <- c("x", "y")
peakmat <- peakmat[c(2,4,5,6,8),]
peakmat$Format <- factor(c("Half Hour TV", "Half Hour TV (HD)/Hour TV", "Movie", "Movie (HD)", "BluRay Rip"), ordered = TRUE)


ggplot(data = densize, aes(Size, Density)) + geom_line() + geom_point(data=peakmat, aes(x,y,colour = Format), size = 3) +
  scale_x_continuous(breaks = c(26,28,30,32), labels = paste(2^c(26,28,30,32)/1024^2, "Mb", sep = " "), limits = c(25, 35)) +
  opts(title = expression("Popular File Sizes Roughly Correspond to Ripped TV/Movie Sizes"))