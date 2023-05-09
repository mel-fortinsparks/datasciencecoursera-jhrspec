library(lubridate)
library(dplyr)
# Plot 1

#import data
plot.data <- fread(file.path(path, "household_power_consumption.txt"))
plot.data[plot.data == "?"] <- NA

#transform Global_active_power to numeric and Date to date
plot.data$Global_active_power <- as.numeric(plot.data$Global_active_power)
plot.data$Date <- as.Date(plot.data$Date, "%d/%m/%Y")

#filter to just Feb 1-2, 2007
plot.data <- plot.data[(Date >= "2007-02-01") & (Date <= "2007-02-02")]



png("plot1.png", width=480, height=480)

#plot
hist(plot.data$Global_active_power, col="red", main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", breaks=20)

dev.off()
