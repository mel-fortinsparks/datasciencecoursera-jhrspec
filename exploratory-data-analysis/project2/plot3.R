#Exploratory Data
#Project 2
#Q3
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
# variable, which of these four sources have seen decreases in emissions from 1999–2008 
# for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the 
# ggplot2 plotting system to make a plot answer this question.

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

#Plot
library(ggplot2)
png("plot3.png", width=480, height=480)

ggplot(baltALL,aes(factor(year),Emissions,fill=type)) +
  geom_bar(stat="identity") +
  theme_bw() + 
  guides(fill=FALSE)+
  facet_grid(.~type,scales = "free",space="free") + 
  labs(x="Year", y="Emissions (PM2.5)") + 
  labs(title="Total Emissions (PM2.5) by Source, Baltimore, MD 1999-2008")

dev.off()

#Answer
#In Baltimore, MD the type of source "point" saw an increase in emissions between 
#1999 and 2005, but has dropped off significantly in 2008.