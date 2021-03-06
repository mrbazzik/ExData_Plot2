##reading data

dfSum<-readRDS("summarySCC_PM25.rds")
dfSCC<-readRDS("Source_Classification_Code.rds")

library(dplyr)
library(ggplot2)

dfSCC$SCC<-as.character(dfSCC$SCC)
dfSum$year<-factor(dfSum$year)

##filtering, grouping by SCC and year in order to decrease data size before merging
dfSCCByYear<-dfSum%>%filter(fips=="24510" | fips=="06037")%>%group_by(SCC, fips, year)%>%summarise(Sum=sum(Emissions))

## merging, filtering and final grouping
dfFull<-merge(dfSCCByYear, dfSCC, by="SCC")
dfByYear<-dfFull%>%filter(grepl(".*Vehicles.*",dfFull$EI.Sector))%>%group_by(fips, year)%>%summarise(Sum=sum(Sum))
dfByYear$fipsName<- ifelse(dfByYear$fips=="24510", "Baltimore City", "Los Angeles County")

##plotting
qplot(year, Sum, data=dfByYear, facets=.~fipsName, xlab="Year", ylab="Emissions", main="Total emissions from motor vehicle sources for two counties", stat="identity", geom="bar")

dev.copy(png, file="plot6.png", width=480, height=480)
dev.off()

