library(lubridate)
library(dplyr)
# Plot 4

#import data
plot.data <- fread(file.path(path, "household_power_consumption.txt"))
plot.data[plot.data == "?"] <- NA

#transform Global_active_power to numeric and Date to date
plot.data$Global_active_power <- as.numeric(plot.data$Global_active_power)
plot.data$Date <- as.Date(plot.data$Date, "%d/%m/%Y")

plot.data$Sub_metering_1 <- as.numeric(plot.data$Sub_metering_1)
plot.data$Sub_metering_2 <- as.numeric(plot.data$Sub_metering_2)
plot.data$Sub_metering_3 <- as.numeric(plot.data$Sub_metering_3)

plot.data$Voltage <- as.numeric(plot.data$Voltage)
plot.data$Global_reactive_power <- as.numeric(plot.data$Global_reactive_power)

#filter to just Feb 1-2, 2007
plot.data <- plot.data[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

plot.data$dateTime <- as.POSIXct(paste(plot.data$Date,plot.data$Time, format="%d/%m/%Y %H:%M:%S"))

png("plot4.png", width=480, height=480)

#plot
par(mfrow = c(2,2))
#plot2
plot(x = plot.data[, dateTime], 
     y = plot.data[, Global_active_power], 
     type="l", xlab="", ylab="Global Active Power (kilowatts)")
#voltage
plot(x = plot.data$dateTime, y = plot.data$Voltage, 
     type="l", xlab="datetime", ylab="Voltage")
#plot3
plot(x = plot.data$dateTime, y = plot.data$Sub_metering_1, 
     type="l", xlab="", ylab="Energy sub metering")
lines(x = plot.data$dateTime,y = plot.data$Sub_metering_2, col="red")
lines(x = plot.data$dateTime,y = plot.data$Sub_metering_3, col="blue")
legend("topright", col=c("black","red","blue"), 
       c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),
       lty=c(1,1), lwd=c(1,1),bty = "n")
#global reactive power
plot(x = plot.data$dateTime, y = plot.data$Global_reactive_power, 
     type="l", xlab="datetime", ylab="Global_reactive_power")


dev.off()
