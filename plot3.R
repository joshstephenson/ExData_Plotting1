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
        select(DateTime, SubMetering1, SubMetering2, SubMetering3)

# Open a PNG device where we will draw the plot
png(file = "plot3.png", height = 480, width = 480)

# Reference images included in repository have transparent bg
par(bg = "transparent")
with(hpc, plot(SubMetering1 ~ DateTime, col = c("black", "red", "blue"), type="n", xlab = "", ylab = "Energy sub metering"))
with(hpc, lines(SubMetering1 ~ DateTime, col = "black"))
with(hpc, lines(SubMetering2 ~ DateTime, col = "red"))
with(hpc, lines(SubMetering3 ~ DateTime, col = "blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Close the PNG device and save to disk
dev.off()
