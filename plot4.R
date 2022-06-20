library(dplyr)
library(lubridate)

## Dowload the data if the unzipped file does not exist yet
if(!file.exists("data/household_power_consumption.txt")){
  download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "household_power_consumption.zip")
  unzip(zipfile = "household_power_consumption.zip", exdir = "./data")
}

## Set up the data frame for plotting 
if(!exists('test')){
  test <- read.table("data/household_power_consumption.txt", sep = ";", header = TRUE)
  test$Date <- as.Date(x = test$Date, "%d/%m/%Y") 
  test <- test[test$Date >= "2007-02-01" & test$Date <= "2007-02-02",]
  test$Time <- as.POSIXct(strptime(paste(test$Date, test$Time), format = "%Y-%m-%d %H:%M:%S", tz = "Europe/Paris"))
  test[3:9] <- as.numeric(unlist(test[3:9])) ##Need to change type to numeric for later plotting
}

## Create the storage folder
if(!dir.exists("./figure")){
  dir.create("./figure")
}

##Set the dimensions for plots
flngth = 480
flhght = 480

png(filename = "./figure/plot4.png", width = flngth, height = flngth)
par(mfrow = c(2,2)) ## set up the raster for the plots to show up in; 2 row, 2 lines
plot(test$Time, test$Global_active_power, 
     type = "n", 
     xlab = "", 
     ylab = "Global Active Power (kilowatts)"
)
lines(test$Time, test$Global_active_power)

plot(test$Time, test$Voltage, ylab = "Voltage", xlab = "datetime", type = "n")
lines(test$Time, test$Voltage)

plot(test$Time, test$Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = "") ##set up the canvas without plotting it and add the lines 1 by 1
lines(test$Time, test$Sub_metering_1, col = "black")
lines(test$Time, test$Sub_metering_2, col = "red")
lines(test$Time, test$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black", "red", "blue"), lty = c(1,1,1))

plot(test$Time, test$Global_reactive_power, ylab = "Global_reactive_power", xlab = "datetime", type = "n")
lines(test$Time, test$Global_reactive_power)
dev.off()
