airPass <- read.table(file.path("~","Documents","SDA","donnees","SerieM Air Passengers.txt"), header=TRUE, sep="", na.strings="NA", dec=".", strip.white=TRUE)
airPass[1:5,]