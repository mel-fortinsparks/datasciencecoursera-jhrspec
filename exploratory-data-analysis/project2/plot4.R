#Exploratory Data
#Project 2
#Q4
# Across the United States, how have emissions from coal combustion-related sources 
# changed from 1999–2008?

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
combustionRelated <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
coalRelated <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
SCC.tbl <- data.table::as.data.table(SCC)
coalcombSCC <- SCC.tbl[combustionRelated & coalRelated,SCC]
coalcombNEI <- NEI.tbl[NEI.tbl[,SCC] %in% coalcombSCC]
coalcombNEI <- coalcombNEI[, lapply(.SD, sum, na.rm = TRUE), .SDcols = c("Emissions"), by = year]

png("plot4.png", width=480, height=480)

barplot(coalcombNEI$Emissions,names=coalcombNEI$year, col="azure3",
        xlab="Year",ylab="Emissions (PM2.5)",yaxt="n",
        main="Total Coal Combustion Emissions (PM2.5) in the US 1999-2008")
axis(2, at=c(0,100000,200000,300000,400000,500000), 
     labels=format(c(0,"100k","200k","300k","400k","500k")))

dev.off()

#Answer
#Overall, coal combustion emissions appear to have decreased between 1999 and 2008.