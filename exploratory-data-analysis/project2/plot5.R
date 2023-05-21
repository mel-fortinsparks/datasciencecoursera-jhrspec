#Exploratory Data
#Project 2
#Q5
# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

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

png("plot5.png", width=480, height=480)

barplot(vehiclesBalt$Emissions,names=vehiclesBalt$year, col="tomato",
        xlab="Year",ylab="Emissions (PM2.5)",
        main="Vehicle Emissions (PM2.5) in Baltimore, MD 1999-2008")

dev.off()

#Answer
#Vehicle emissions in Baltimore, MD have decreased between 1999-2008