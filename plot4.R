##
## This script reads in a data set around household power consumption and 
## creates 4 charts based on parts of the data set, saving it to a png file
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

## open png graphic device
png("plot4.png", height=480, width=480)

## set the graphic device to be a 2X2 grid
par(mfcol=c(2,2))

## plot 1
plot(plotData$datetime, 
     plotData$Global_active_power, 
     type="l", 
     ylab="Global Active Power", 
     xlab = ""
)

## plot 2
plot(plotData$datetime, 
     plotData$Sub_metering_1, 
     type="l", 
     ylab="Energy sub metering", 
     xlab = ""
    )
lines(plotData$datetime, plotData$Sub_metering_2, type="l", col="red")
lines(plotData$datetime, plotData$Sub_metering_3, type="l", col="blue")
legend("topright",
       lty=c(1,1), 
       col=c("black","red","blue"), 
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       bty="n"
      )

## plot 3
plot(plotData$datetime,
     plotData$Voltage,
     type="l",
     ylab="Voltage",
     xlab = "datetime"
    )

## plot 4
plot(plotData$datetime,
     plotData$Global_reactive_power,
     type="l",
     ylab="Global_reactive_power",
     xlab = "datetime"
)

##close png graphic device
dev.off()
