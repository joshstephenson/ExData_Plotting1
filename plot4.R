library(lubridate)
library(dplyr)
filename <- "./household_power_consumption.txt"
start <- 66636
end <- 69516
# Only read in lines that correspond to dates: 01/02/2020 - 02/02/2020 (format: DD/MM/YYYY)
hpc <- read.table(filename, sep = ";", header = TRUE, skip = start, nrows = (end - start), na.strings = "?")
names(hpc) <- c("Date", 
                "Time", 
                "GlobalActivePower", 
                "GlobalReactivePower", 
                "Voltage",
                "GlobalIntensity",
                "SubMetering1",
                "SubMetering2",
                "SubMetering3"
)
hpc <- hpc %>%
        mutate(DateTime = dmy_hms(paste(Date, Time))) %>%
        select(DateTime, GlobalActivePower, Voltage, GlobalReactivePower, SubMetering1, SubMetering2, SubMetering3)

# Open a PNG device where we will draw the plot
png(file = "plot4.png")

## Setup some plot-wide settings including margins matching the examples
par(bg = "white", mfrow = c(2,2), mar = c(5,4,3,1), oma = c(0,1,0,2)) # Reference images included in repository have transparent bg

## Plot 1 Upper Left
plot(GlobalActivePower ~ DateTime, data = hpc, type = "n", xlab = "", ylab = "Global Active Power")
lines(GlobalActivePower ~ DateTime, data = hpc)

## Plot 2 Upper Right
plot(Voltage ~ DateTime, data = hpc, type = "n", xlab = "datetime", ylab = "Voltage")
lines(Voltage ~ DateTime, data = hpc)

## Plot 3 Lower Left
with(hpc, plot(SubMetering1 ~ DateTime, col = c("black", "red", "blue"), type="n", xlab = "", ylab = "Energy sub metering"))
with(hpc, lines(SubMetering1 ~ DateTime, col = "black"))
with(hpc, lines(SubMetering2 ~ DateTime, col = "red"))
with(hpc, lines(SubMetering3 ~ DateTime, col = "blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Plot 4 Lower Right
plot(GlobalReactivePower ~ DateTime, data = hpc, type = "n", xlab = "datetime", ylab = "Global_reactive_power")
lines(GlobalReactivePower ~ DateTime, data = hpc)

# Close the PNG device and save file to disk
dev.off()
