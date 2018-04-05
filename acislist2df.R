
# script for converting acis wide dataframe  into long dataframe ----------

element <- "PCPN" # user provides ACIS element e.g., pcpn or temp, avgt
lf <- list.files(pattern=element, path="data/", full.names = T)
temp <- data.frame()
for(i in lf[2]){
  tmp <- readRDS(i)
  tmp2 <- reshape2::melt(tmp, id.vars="year")
  temp <- rbind(temp, tmp2)
}
temp <- temp[!temp$variable=="NA.",]
grid <- strsplit(as.character(temp$variable), ",")
latff <- sapply(grid,"[",2)
temp$lat <- as.numeric(gsub(x=latff, replacement = "",pattern=" |)"))
lonff <- sapply(grid,"[",1)
temp$lon <- as.numeric(sub("\\D+","",lonff))*-1
temp$state <- substr(temp$variable,1,2)
library(qdapRegex)
temp$name <- unlist(rm_between(text.var =lonff, left = "_", right="_", extract=TRUE))
filePath <-"../../../../../Biol801Evrn420s720/Wk05to07_Modularity/Assignment/USAannualPcpn1950_2016.rds"
# user provides relative path
 
saveRDS(temp, filePath)

