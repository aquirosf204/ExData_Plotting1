
library(readr)
house_pc <- read.csv("C:/Users/andre/Downloads/R/Coursera/data_p_comp/household_power_consumption.txt", sep=";")

house_pc$Global_active_power <- as.numeric(house_pc$Global_active_power)
house_pc <- house_pc[!is.na(house_pc$Global_active_power), ]

house_pc$Date <- as.Date(house_pc$Date, format="%d/%m/%Y")

# Subset data for 01/02/2007 to 02/02/2007
house_pc_subset <- house_pc[house_pc$Date >= "2007-02-01" & house_pc$Date <= "2007-02-02", ]

df <- transform(house_pc_subset, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

par(mfrow = c(1,1))
plot(df$timestamp, df$Global_active_power,type="l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
dev.copy(png, file="plot2 AQF.png", width=480, height=480)
dev.off()