## Reading file
classes <- c("character", "character", "numeric", "numeric", "numeric",
               "numeric", "numeric", "numeric", "numeric")
household_power_consumption <- read.table("household_power_consumption.txt", 
        sep = ";", header = TRUE, na.strings = "?", colClasses = classes,
        row.names = NULL,
        nrows = 2075259)

## Transforming date, selecting rows and adding weekday
library(lubridate)
library(dplyr)
reduced_consumption <- household_power_consumption %>%
        mutate(Newdate = as.Date(dmy(Date))) %>%
        filter(Newdate >= "2007-02-01" & Newdate <= "2007-02-02")

## Plot 3
with(reduced_consumption, plot(Sub_metering_1,
        ann = FALSE, xaxt = "n", type = "n"))
points(reduced_consumption$Sub_metering_1, pch = ".")
lines(reduced_consumption$Sub_metering_1)
points(reduced_consumption$Sub_metering_2, pch = ".", col="red")
lines(reduced_consumption$Sub_metering_2, col="red")
points(reduced_consumption$Sub_metering_3, pch = ".", col="blue")
lines(reduced_consumption$Sub_metering_3, col="blue")
title(ylab = "Energy sub metering")
axis(1, at = c(0,1450,2900), labels = c("Thu", "Fri", "Sat"))
box(which = "plot", lty = "solid")
legend("topright", pch = "-", col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       cex = 0.8, text.width = 800)
dev.copy(png, file = "plot3.png", width = 480, height = 480, units = "px")
dev.off()
