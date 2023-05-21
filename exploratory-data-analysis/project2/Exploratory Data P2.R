#Exploratory Data
#Project 2

#Download data files
library("data.table")
path <- getwd()
URL.p2 <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url = URL.p2, destfile = paste(path, "dataFiles.zip", sep = "/"))
unzip(zipfile = "dataFiles.zip")

#Import Data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#Preview Data
head(NEI)
head(SCC)
NEI.tbl <- data.table::as.data.table(NEI)
#Criteria for each question/plot
# Does the plot appear to address the question being asked?
# Is the submitted R code appropriate for construction of the submitted plot?

#Q1
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from 
# all sources for each of the years 1999, 2002, 2005, and 2008.
NEI.tbl[, Emissions := lapply(.SD, as.numeric), .SDcols = c("Emissions")]

totalNEI <- NEI.tbl[, lapply(.SD, sum, na.rm = TRUE), .SDcols = c("Emissions"), by = year]

barplot(totalNEI$Emissions, main="Total Emissions (PM2.5) in the US 1999-2008",
        names=totalNEI$year, xlab="Year", ylab="Emissions (PM2.5)", col="lavender",
        yaxt="n")
axis(2, at=c(0,1000000,2000000,3000000,4000000,5000000,6000000,7000000), 
     labels=format(c(0,"1M","2M","3M","4M","5M","6M","7M")))


#Q2
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
# (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot 
# answering this question.
balt <- NEI.tbl[fips==24510, lapply(.SD, sum, na.rm=TRUE), .SDcols=c("Emissions"), by=year]
barplot(balt$Emissions,names=balt$year,xlab="Year",ylab="Emissions (PM2.5)",
        col="lavenderblush", main="Total Emissions (PM2.5) in Baltimore, MD 1990-2008")


#Q3
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
# variable, which of these four sources have seen decreases in emissions from 1999–2008 
# for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the 
# ggplot2 plotting system to make a plot answer this question.
baltALL <- NEI.tbl[fips==24510]

library(ggplot2)
ggplot(baltALL,aes(factor(year),Emissions,fill=type)) +
  geom_bar(stat="identity") +
  theme_bw() + 
  guides(fill=FALSE)+
  facet_grid(.~type,scales = "free",space="free") + 
  labs(x="Year", y="Emissions (PM2.5)") + 
  labs(title="Total Emissions (PM2.5) by Source, Baltimore, MD 1999-2008")


#Q4
# Across the United States, how have emissions from coal combustion-related sources 
# changed from 1999–2008?
combustionRelated <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
coalRelated <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
SCC.tbl <- data.table::as.data.table(SCC)
coalcombSCC <- SCC.tbl[combustionRelated & coalRelated,SCC]
coalcombNEI <- NEI.tbl[NEI.tbl[,SCC] %in% coalcombSCC]
coalcombNEI <- coalcombNEI[, lapply(.SD, sum, na.rm = TRUE), .SDcols = c("Emissions"), by = year]

barplot(coalcombNEI$Emissions,names=coalcombNEI$year, col="azure3",
        xlab="Year",ylab="Emissions (PM2.5)",yaxt="n",
        main="Total Coal Combustion Emissions (PM2.5) in the US 1999-2008")
axis(2, at=c(0,100000,200000,300000,400000,500000), 
     labels=format(c(0,"100k","200k","300k","400k","500k")))


#Q5
# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
vehiclesSCC <- SCC.tbl[grepl("vehicle", SCC.tbl$SCC.Level.Two, ignore.case=TRUE), SCC]
vehiclesBalt <- baltALL[baltALL[, SCC] %in% vehiclesSCC,]
vehiclesBalt <- vehiclesBalt[, lapply(.SD, sum, na.rm = TRUE), .SDcols = c("Emissions"), by = year]

barplot(vehiclesBalt$Emissions,names=vehiclesBalt$year, col="tomato",
        xlab="Year",ylab="Emissions (PM2.5)",
        main="Vehicle Emissions (PM2.5) in Baltimore, MD 1999-2008")


#Q6
# Compare emissions from motor vehicle sources in Baltimore City with emissions from 
# motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city 
# has seen greater changes over time in motor vehicle emissions?
vehiclesSCC <- SCC.tbl[grepl("vehicle", SCC.tbl$SCC.Level.Two, ignore.case=TRUE), SCC]
vehiclesNEI <- NEI.tbl[NEI.tbl[, SCC] %in% vehiclesSCC,]
vehiclesLA <- vehiclesNEI[fips=="06037"]
vehiclesLA <- vehiclesLA[, lapply(.SD, sum, na.rm = TRUE), .SDcols = c("Emissions"), by = year]

par(mfrow = c(1,2))
barplot(vehiclesBalt$Emissions,names=vehiclesBalt$year, col="tomato",
        xlab="Year",ylab="Emissions (PM2.5)", ylim=c(0,7300),
        main="Vehicle Emissions (PM2.5)\nin Baltimore, MD 1999-2008")
barplot(vehiclesLA$Emissions,names=vehiclesLA$year, col="tomato4",
        xlab="Year",ylab="Emissions (PM2.5)", ylim=c(0,7300),
        main="Vehicle Emissions (PM2.5)\nin LA County, CA 1999-2008")
