#WORKDIR<-"set working directory here"
#setwd(WORKDIR)

household_data<-read.table("household_power_consumption.txt", header=T, na.strings="?", stringsAsFactors= F, sep=";")
Date<-as.Date(household_data$Date, "%d/%m/%Y")

plot_data<-household_data[(Date >= as.Date("2007-02-01", "%Y-%m-%d")) & (Date <= as.Date("2007-02-02", "%Y-%m-%d")), ]

# Concatenate date and time
datetime<-NULL
for (i in 1:nrow(plot_data)){
  cTime<-paste(plot_data$Date[i], plot_data$Time[i], sep=" ")
  datetime<-c(datetime, cTime)
}

datetime<-strptime(datetime, "%d/%m/%Y %H:%M:%S") #Convert to PosixCt class


png("plot4.png", width=480, height=480)

par(mfrow=c(2,2)) #Set a 2,2 plot matrix

#First plot
plot(datetime, plot_data$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")

#Second plot
plot(datetime, plot_data$Voltage, type="l", ylab="Voltage", lwd=0.50)


#Third plot
plot(datetime, plot_data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(datetime, plot_data$Sub_metering_2, col="red")
lines(datetime, plot_data$Sub_metering_3, col="blue")
# bty ='n' will print legend without border and cex affects the character expansion relative to current par.
# we want the legend to be slightly smaller.
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"), bty="n", cex=0.90)

#Fourth plot. Played with line width to achieve plot required. 
plot(datetime, plot_data$Global_reactive_power, type='l', ylab="Global_reactive_power", lwd=0.2, col="black")
dev.off()

