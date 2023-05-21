#Exploratory Data
#Project 2
#Q1
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission from 
# all sources for each of the years 1999, 2002, 2005, and 2008.

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
totalNEI <- NEI.tbl[, lapply(.SD, sum, na.rm = TRUE), .SDcols = c("Emissions"), by = year]

#Plot
png("plot1.png", width=480, height=480)

barplot(totalNEI$Emissions, main="Total Emissions (PM2.5) in the US 1999-2008",
        names=totalNEI$year, xlab="Year", ylab="Emissions (PM2.5)", col="lavender",
        yaxt="n")
axis(2, at=c(0,1000000,2000000,3000000,4000000,5000000,6000000,7000000), 
     labels=format(c(0,"1M","2M","3M","4M","5M","6M","7M")))

dev.off()

#Answer:
#Total emissions in the US are at their lowest in 2008. This indicates that, overall,
#emissions are declining over time.