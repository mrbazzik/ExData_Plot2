##reading data

dfSum<-readRDS("summarySCC_PM25.rds")
dfSCC<-readRDS("Source_Classification_Code.rds")

library(dplyr)
library(ggplot2)

dfSCC$SCC<-as.character(dfSCC$SCC)
dfSum$year<-factor(dfSum$year)

##filtering, grouping by SCC and year in order to decrease data size before merging
dfSCCByYear<-dfSum%>%group_by(SCC, year)%>%summarise(Sum=sum(Emissions))

## merging, filtering and final grouping
dfFull<-merge(dfSCCByYear, dfSCC, by="SCC")
dfByYear<-dfFull%>%filter(grepl(".*Coal.*",dfFull$EI.Sector))%>%group_by(year)%>%summarise(Sum=sum(Sum))

##plotting
barplot(dfByYear$Sum, names.arg=dfByYear$year, xlab="Year", ylab="Emissions", main="Total emissions from coal combustion-related sources")

dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()

