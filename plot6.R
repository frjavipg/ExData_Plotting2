## Compare emissions from motor vehicle sources in Baltimore City with emissions 
## from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
## Which city has seen greater changes over time in motor vehicle emissions?

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

## Select emissions from motor vehicle sources in Meryland an California.

emission_comb1 <- NEI[(NEI$fips=="24510"|NEI$fips=="06037") & NEI$type=="ON-ROAD",  ]

## We sum the emmissions per year.
PM25ByYearTot6 <- aggregate(Emissions ~ year + fips, emission_comb1, sum)

## recode the variable fips.
PM25ByYearTot6$fips[PM25ByYearTot6 $fips=="24510"] <- "Baltimore, MD"
PM25ByYearTot6$fips[PM25ByYearTot6 $fips=="06037"] <- "Los Angeles, CA"

## Graph the values of the sum of emissions per year and fips.

## Save the graphic in a png file.
png('plot6.png', width=480, height=480)

year1<-as.factor(PM25ByYearTot6$year)

p <- ggplot(PM25ByYearTot6, aes(year1, Emissions)) + geom_bar(stat="identity",fill=(c("green","red", "blue","orange"))) +
  xlab("Year") +
  ylab("Baltimore - Total PM2.5 (in thousands)") +
  ggtitle("Emission from motor vehicle source in Meryland and California") + facet_wrap(~ fips)

print(p)

dev.off()
