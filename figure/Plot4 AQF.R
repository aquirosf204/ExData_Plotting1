
library(readr)
house_pc <- read.csv("C:/Users/andre/Downloads/R/Coursera/data_p_comp/household_power_consumption.txt", sep=";")

house_pc$Global_active_power <- as.numeric(house_pc$Global_active_power)
house_pc <- house_pc[!is.na(house_pc$Global_active_power), ]

house_pc$Date <- as.Date(house_pc$Date, format="%d/%m/%Y")

# Subset data for 01/02/2007 to 02/02/2007
house_pc_subset <- house_pc[house_pc$Date >= "2007-02-01" & house_pc$Date <= "2007-02-02", ]

times <- transform(house_pc_subset, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

par(mfrow = c(2,2))
with(times, {plot(Global_active_power ~ timestamp, type = "l", 
       ylab = "Global Active Power", xlab = "")
  plot(Voltage ~ timestamp, type = "l", ylab = "Voltage", xlab = "datetime")
  plot(Sub_metering_1 ~ timestamp, type = "l", ylab = "Energy sub metering",
       xlab = "")
  lines(Sub_metering_2 ~ timestamp, col = 'Red')
  lines(Sub_metering_3 ~ timestamp, col = 'Blue')
  legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
         bty = "n",
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power ~ timestamp, type = "l", 
       ylab = "Global_reactive_power", xlab = "datetime")})
dev.off()
dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()