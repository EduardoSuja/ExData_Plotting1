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

## Plot 1
hist(reduced_consumption$Global_active_power, col="red",
     main="Global active Power", xlab = "Global Active Power (kilowatts)")
dev.copy(png, file = "plot1.png", width = 480, height = 480, units = "px")
dev.off()
