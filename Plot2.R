## Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
## Use the base plotting system to make a plot answering this question.

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

PM25ByYearTot2  <- aggregate(Emissions ~ year, Merlyland_NEI, FUN="sum")

## Save the graphic in a png file.
png('plot2.png', width=480, height=480)

## Graph the values of the sum of emissions per year
barplot(PM25ByYearTot2$Emissions, names.arg=PM25ByYearTot2$year, xlab="years", ylab=expression('total PM'[2.5]*' emission'),main=expression('Total PM'[2.5]*' in the Baltimore City, MD emissions at various years'))

dev.off()
