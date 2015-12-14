## How have emissions from motor vehicle sources 
## changed from 1999-2008 in Baltimore City?

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


## Select emissions from motor vehicle sources in Meryland

emission_comb <- NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD",  ]

## We sum the emmissions per year

PM25ByYearTot5 <- aggregate(Emissions ~ year, emission_comb, sum)

## Save the graphic in a png file.
png('plot5.png', width=480, height=480)

## Graph the values of the sum of emissions per year
barplot(PM25ByYearTot5$Emissions, names.arg=PM25ByYearTot5$year, xlab="years", ylab=expression('total PM'[2.5]*' emission'),main=expression('Emission from motor vehicle source in Meryland'))

dev.off()



