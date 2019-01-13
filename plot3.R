
## Uncomment to set your working directory to the directory 
## containing the txt - file with the data if necessary
# wd <- 'Your working directory'
# setwd(wd)

## Load the txt-file using the read.table function
mydf <- read.table('household_power_consumption.txt', header = TRUE,
                   sep = ";", na.strings = "?", stringsAsFactors = FALSE)

## Load lubridate package
library('lubridate')

## Convert character to date object
dates <- dmy(mydf$Date)

## Convert character to time object
times <- hms(mydf$Time)

## Use lubridate function ymd to create the date objects that will used
## to constrain the plotting to two specific days
date1 <- ymd('2007-02-01')
date2 <- ymd('2007-02-02')
## Boolean statement that creates vector with ones for only the specified 
## dates and zeros otherwise 
truth <- (dates == date1 | dates == date2)

## Open the graphics device for creating a png with a width = 480 pixels
## and height = 480 pixels
png(file = 'plot3.png', width = 480, height = 480, units = 'px')

## Set the plotting parameters
par(mfrow = c(1,1), mar = c(2,4,1,4), oma = c(1, 1, 1, 1))
## Plot 3 lines, for x combine the date and time object, y different Sub_metering
## Add a legend to the plot as well
with(mydf, {
        plot((dates[truth] + times[truth]), Sub_metering_1[truth], type = 'l', col = 'black',
             xlab = '', ylab = 'Energy sub metering')
        points((dates[truth] + times[truth]), Sub_metering_2[truth], type = 'l', col = 'red')
        points((dates[truth] + times[truth]), Sub_metering_3[truth], type = 'l', col = 'blue')
        legend(x = 'topright', legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
               col=c("black","red","blue"),lty=c(1,1,1), ncol=1)
})


## Close the png graphics device
dev.off()
