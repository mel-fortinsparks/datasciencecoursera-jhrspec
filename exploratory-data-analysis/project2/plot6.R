#Exploratory Data
#Project 2
#Q6
# Compare emissions from motor vehicle sources in Baltimore City with emissions from 
# motor vehicle sources in Los Angeles County, California (fips == "06037"). Which city 
# has seen greater changes over time in motor vehicle emissions?

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

#Format data
NEI.tbl[, Emissions := lapply(.SD, as.numeric), .SDcols = c("Emissions")]
baltALL <- NEI.tbl[fips==24510]
vehiclesSCC <- SCC.tbl[grepl("vehicle", SCC.tbl$SCC.Level.Two, ignore.case=TRUE), SCC]
vehiclesBalt <- baltALL[baltALL[, SCC] %in% vehiclesSCC,]
vehiclesBalt <- vehiclesBalt[, lapply(.SD, sum, na.rm = TRUE), .SDcols = c("Emissions"), by = year]

vehiclesSCC <- SCC.tbl[grepl("vehicle", SCC.tbl$SCC.Level.Two, ignore.case=TRUE), SCC]
vehiclesNEI <- NEI.tbl[NEI.tbl[, SCC] %in% vehiclesSCC,]
vehiclesLA <- vehiclesNEI[fips=="06037"]
vehiclesLA <- vehiclesLA[, lapply(.SD, sum, na.rm = TRUE), .SDcols = c("Emissions"), by = year]


#Plot
png("plot6.png", width=480, height=480)

par(mfrow = c(1,2))
barplot(vehiclesBalt$Emissions,names=vehiclesBalt$year, col="tomato",
        xlab="Year",ylab="Emissions (PM2.5)", ylim=c(0,7300),
        main="Vehicle Emissions (PM2.5)\nin Baltimore, MD 1999-2008")
barplot(vehiclesLA$Emissions,names=vehiclesLA$year, col="tomato4",
        xlab="Year",ylab="Emissions (PM2.5)", ylim=c(0,7300),
        main="Vehicle Emissions (PM2.5)\nin LA County, CA 1999-2008")

dev.off()

#Answer
#LA County has seen larger changes over time (in terms of unit). However, Baltimore
#has seen more change proportionally in that they saw a 50% decrease between 1999-2008