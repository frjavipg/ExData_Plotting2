## Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which of these 
## four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
## Which have seen increases in emissions from 1999-2008? 
## Use the ggplot2 plotting system to make a plot answer this question.

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

## Select emision subset from Meryland
Merlyland_NEI <- NEI[NEI$fips=="24510", ]

## We sum the emmissions per year

PM25ByYearType  <- aggregate(Emissions ~ year + type, Merlyland_NEI, FUN="sum")

library(ggplot2)

## Save the graphic in a png file.
png('plot3.png', width=480, height=480)

## Graph the values of the sum of emissions per year and type.

year1<-as.factor(PM25ByYearType$year)

p <- ggplot(PM25ByYearType, aes(year1, Emissions)) + geom_bar(stat="identity",fill=(c("green","red", "blue","orange"))) +
  xlab("Year") +
  ylab("Baltimore - Total PM2.5 (in thousands)") +
  ggtitle("Baltimore - Total PM2.5 by Type") + facet_wrap(~ type)

print(p)

dev.off()