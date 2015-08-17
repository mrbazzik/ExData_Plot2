##reading data

dfSum<-readRDS("summarySCC_PM25.rds")
dfSCC<-readRDS("Source_Classification_Code.rds")

library(dplyr)
dfSum$year<-factor(dfSum$year)

dfByYearBalt<-dfSum%>%filter(fips=="24510")%>%group_by(year)%>%summarise(Sum=sum(Emissions))
barplot(dfByYearBalt$Sum, names.arg=dfByYearBalt$year)
title(xlab="Year", ylab="Emissions", main="Total emissions by year in Baltimore City")

dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()

