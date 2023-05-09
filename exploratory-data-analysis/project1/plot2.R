library(lubridate)
library(dplyr)
# Plot 2

#import data
plot.data <- fread(file.path(path, "household_power_consumption.txt"))
plot.data[plot.data == "?"] <- NA

#transform Global_active_power to numeric and Date to date
plot.data$Global_active_power <- as.numeric(plot.data$Global_active_power)
plot.data$Date <- as.Date(plot.data$Date, "%d/%m/%Y")

#filter to just Feb 1-2, 2007
plot.data <- plot.data[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

plot.data$dateTime <- as.POSIXct(paste(plot.data$Date,plot.data$Time, format="%d/%m/%Y %H:%M:%S"))

png("plot2.png", width=480, height=480)

#plot
plot(x = plot.data[, dateTime], 
     y = plot.data[, Global_active_power], 
     type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()
