#Exploratory Data
#Project 2
#Q2
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
# (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot 
# answering this question.

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
balt <- NEI.tbl[fips==24510, lapply(.SD, sum, na.rm=TRUE), .SDcols=c("Emissions"), by=year]

#Plot
png("plot2.png", width=480, height=480)

barplot(balt$Emissions,names=balt$year,xlab="Year",ylab="Emissions (PM2.5)",
        col="lavenderblush", main="Total Emissions (PM2.5) in Baltimore, MD 1990-2008")

dev.off()

#Answer:
#Total emissions in Baltimore, MD for the year 2008 are lower than previous years.
#This indicates that emissions may be decreasing over time.