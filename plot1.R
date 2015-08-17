##reading data

dfSum<-readRDS("summarySCC_PM25.rds")
dfSCC<-readRDS("Source_Classification_Code.rds")

library(dplyr)
dfSum$year<-factor(dfSum$year)

dfByYear<-dfSum%>%group_by(year)%>%summarise(Sum=sum(Emissions))
barplot(dfByYear$Sum, names.arg=dfByYear$year)
title(xlab="Year", ylab="Emissions", main="Total amounts of emissions by year")

dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()

