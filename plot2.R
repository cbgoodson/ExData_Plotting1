##
## This script reads in a data set around household power consumption and 
## creates a line graph based on part of that data set, saving it to a png file
##
## Notes:
## 1) the data file is assumed to be in your working directory
## 2) we only care about Feb 1 and Feb 2 2007
##

## read in the data
df <- read.table("household_power_consumption.txt", header=T, 
                  sep=";", na.strings="?", 
                  colClasses=c('character','character',rep('numeric',times=7))
                )

## subset for just the dates that we care about 
plotData <- subset(df, Date=='1/2/2007' | Date=='2/2/2007')

## add a datetime field that will ultimately serve as the x-axis for the chart
plotData$datetime <- strptime(paste(plotData$Date, plotData$Time), '%d/%m/%Y %H:%M:%S')

## create the line graph and save it to a png file
png("plot2.png", height=480, width=480)
plot(plotData$datetime, 
     plotData$Global_active_power, 
     type="l", 
     ylab="Global Active Power (kilowatts)", 
     xlab = ""
    )
dev.off()
