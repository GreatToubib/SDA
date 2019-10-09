airPass <- read.table(file.path("~","Documents","SDA","donnees","SerieM Air Passengers.txt"), header=TRUE, sep="", na.strings="NA", dec=".", strip.white=TRUE)
airPass[1:5,]

#time series
seriem <- ts(airPass[,2], frequency=12, start=c(1949,1))
seriem

#visualiser normal et la log
plot.ts(seriem)

#Pour supprimer la non-stationnarité en variance, on prend le log de seriem:
#y(t) = log x(t)
logseriem <- log(seriem)
plot.ts(logseriem) # ∇y(t)

#Pour filtrer une tendance linéaire, on différencie et on représente la série
#filtrée:
logseriemd1 <- diff(logseriem, d=1)
plot.ts(logseriemd1)

#acf et pacf pour savoir si stationnaire ou pas ?
acf(logseriemd1, lag.max=30)
pacf(logseriemd1, lag.max=30)

#Sur l’ACF, on voit que les bâtonnets périodiques ne décroissent pas rapidement, 
#ce qui indique la nécessité d’une différentiation saisonnière.
logseriemd1D1 <- diff(logseriemd1, lag=12, d=1)
plot.ts(logseriemd1D1) # ∇∇12y(t)

#acf et pacf de la serie differenciee
acf(logseriemd1D1, lag.max=30)
pacf(logseriemd1D1, lag.max=30)
#toujours pas stationnaire du coup car ca sort de l'intervalle a plusieurs reprises 

# ca ressemble à un MA(q) ou un AR(q) ?  ou aucun? 




# estiamtion de la tendance par moyennes mobiles 
fit.decompose <- decompose(seriem)
plot(fit.decompose)
fit.decompose2 <- decompose(seriem,type='multiplicative')
plot(fit.decompose2)

# stl permet de réaliser les estimations pour un modèle additif, par maximum de vraisemblance.
fit.stl <- stl(seriem,s.window=12)
plot(fit.stl)
