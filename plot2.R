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

# Parse the dates to DateTime objects and Select only the appropriate rows
hpc <- hpc %>%
        mutate(DateTime = dmy_hms(paste(Date, Time))) %>%
        select(DateTime, GlobalActivePower)

# Open a PNG device where we will draw the plot
png(file = "plot2.png", height = 480, width = 480)

# Reference images included in repository have transparent bg
par(bg = "transparent")

plot(GlobalActivePower ~ DateTime, data = hpc, type = "n", xlab = "", ylab = "Global Active Power (Kilowatts)")
lines(GlobalActivePower ~ DateTime, data = hpc)

# Close the PNG device and save to disk
dev.off()
