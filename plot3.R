##reading data

dfSum<-readRDS("summarySCC_PM25.rds")
dfSCC<-readRDS("Source_Classification_Code.rds")

library(dplyr)
library(ggplot2)

dfSum$year<-factor(dfSum$year)

dfByYearBalt<-dfSum%>%filter(fips=="24510")%>%group_by(type, year)%>%summarise(Sum=sum(Emissions))
qplot(year, Sum, data=dfByYearBalt, facets=.~type, ylab="Emissions", main="Total emissions by type and by year in Baltimore City", geom="bar", stat="identity")

dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()

