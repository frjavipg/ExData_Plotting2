## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
## Using the base plotting system, make a plot showing the total PM2.5 emission from all 
## sources for each of the years 1999, 2002, 2005, and 2008.


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

## Get sum by year
PM25ByYearTot  <- aggregate(Emissions ~ year, NEI, FUN="sum")

## Save the graphic in a png file.
png('plot1.png', width=480, height=480)

## Graph the values of the sum of emissions per year
barplot(PM25ByYearTot$Emissions, names.arg=PM25ByYearTot$year, xlab="years", ylab=expression('total PM'[2.5]*' emission'),main=expression('Total PM'[2.5]*' emissions at various years'))

dev.off()







