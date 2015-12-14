## Across the United States, how have emissions 
## from coal combustion-related sources changed from 1999-2008?

## Download the file in the specidied directory.

if(!file.exists("./projet2")) {dir.create("./projet2")}

## We connect to the web.

fileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl,"./projet2/exdata-data-NEI_data.zip", mode="wb")
setwd("./projet2")

## Unzip the file.
unzip("exdata-data-NEI_data.zip")

## Load file to data frame
NEI = readRDS("summarySCC_PM25.rds")
SCC = readRDS("Source_Classification_Code.rds")

## Merge the two data sets 

NEISCC <- merge(NEI, SCC, by="SCC")

##  Select the NEIxSCC records with Short.Name (SCC) Coal
CoalPair  <- grepl("coal", NEISCC$Short.Name, ignore.case=TRUE)
subNEISCC <- NEISCC[CoalPair, ]

PM25ByYear4 <- aggregate(Emissions ~ year, subNEISCC, sum)


library(ggplot2)

## Save the graphic in a png file.
png('plot4.png', width=480, height=480)

## Graph the values of the sum of emissions per year and type.

year1<-as.factor(PM25ByYear4$year)

p <- ggplot(PM25ByYear4, aes(year1, Emissions)) + geom_bar(stat="identity") +
  xlab("Year") +
  ylab("Baltimore - Total PM2.5 (in thousands)") +
  ggtitle("Emission from coal combustion in U.S.A.")

print(p)

dev.off()
