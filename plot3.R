#WORKDIR<-"set working directory here "
#setwd(WORKDIR)


# Assuming that the input data file is already in the working directory. Or set the working directory above

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

png("plot3.png", width=480, height=480)
plot(datetime, plot_data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(datetime, plot_data$Sub_metering_2, col="red")
lines(datetime, plot_data$Sub_metering_3, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"))
dev.off()
