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

## Plot 4
par(mfcol = c(2,2))
with(reduced_consumption, {
## plotting Plot 2 in row 1, col 1
        plot(Global_active_power, pch = ".",
             ann = FALSE, xaxt = "n")
        lines(reduced_consumption$Global_active_power)
        title(ylab = "Global Active Power (kilowatts)")
        axis(1, at = c(0,1450,2900), labels = c("Thu", "Fri", "Sat"))
        box(which = "plot", lty = "solid")
## plotting Plot 3 in row 2, col 1        
        plot(Sub_metering_1,
             ann = FALSE, xaxt = "n", type = "n")
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
               cex = 0.8, text.width = 1100)
## plotting new plot in row 1, col 2
        plot(reduced_consumption$Voltage, pch = ".", ann = FALSE, xaxt = "n")
        lines(reduced_consumption$Voltage)
        title(ylab = "Voltage")
        axis(1, at = c(0,1450,2900), labels = c("Thu", "Fri", "Sat"))
        title(sub = "datetime")
        box(which = "plot", lty = "solid")
## plotting new plot in row 2, col 2
        plot(reduced_consumption$Global_reactive_power, pch = ".", ann = FALSE, xaxt = "n")
        lines(reduced_consumption$Global_reactive_power)
        title(ylab = "Global_reactive_power")
        axis(1, at = c(0,1450,2900), labels = c("Thu", "Fri", "Sat"))
        title(sub = "datetime")
        box(which = "plot", lty = "solid")
})
dev.copy(png, file = "plot4.png")
dev.off()
