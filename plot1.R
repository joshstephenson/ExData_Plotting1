filename <- "./household_power_consumption.txt"
start <- 66636
end <- 69516
# Only read in lines that correspond to dates: 01/02/2020 - 02/02/2020 (format: DD/MM/YYYY)
hpc <- read.table(filename, sep = ";", header = TRUE, skip = start, nrows = (end - start), na.strings = "?")
names(hpc) <- c("Date", 
                "Time", 
                "Global Active Power", 
                "Global Reactive Power", 
                "Voltage",
                "Global Intensity",
                "Sub Metering 1",
                "Sub Metering 2",
                "Sub Metering 3"
                )

# Open a PNG device where we will draw the plot
png(file = "plot1.png", height = 480, width = 480)

# Reference images included in repository have transparent bg
par(bg = "transparent")

# Plot should be a basic histogram
hist(hpc$`Global Active Power`, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

# Close the PNG device and save to disk
dev.off()
