library(dplyr)
library(lubridate)

if(!file.exists("data/household_power_consumption.txt")){
  download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile = "household_power_consumption.zip")
  unzip(zipfile = "household_power_consumption.zip", exdir = "./data")
}

if(!exists('test')){
  test <- read.table("data/household_power_consumption.txt", sep = ";", header = TRUE)
  test$Date <- as.Date(x = test$Date, "%d/%m/%Y")
  test <- test[test$Date >= "2007-02-01" & test$Date <= "2007-02-02",]
  test$Time <- as.POSIXct(strptime(paste(test$Date, test$Time), format = "%Y-%m-%d %H:%M:%S", tz = "Europe/Paris"))
  test[3:9] <- as.numeric(unlist(test[3:9]))
}

if(!dir.exists("./figure")){
  dir.create("./figure")
}

flngth = 480
flhght = 480


png(filename = "./figure/plot2.png", width = flngth, height = flngth)
plot(test$Time, test$Global_active_power, 
     type = "n", 
     xlab = "", 
     ylab = "Global Active Power (kilowatts)"
)

lines(test$Time, test$Global_active_power)
dev.off()
