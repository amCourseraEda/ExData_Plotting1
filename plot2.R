#WORKDIR<-"set working directory here"
#setwd(WORKDIR)

# Assuming that the input data file is already in the working directory. Or set the working directory above

household_data<-read.table("household_power_consumption.txt", header=T, na.strings="?", stringsAsFactors= F, sep=";")
Date<-as.Date(household_data$Date, "%d/%m/%Y")

#Subset the data
plot_data<-household_data[(Date >= as.Date("2007-02-01", "%Y-%m-%d")) & (Date <= as.Date("2007-02-02", "%Y-%m-%d")), ]

# Concatenate date and time
datetime<-NULL
for (i in 1:nrow(plot_data)){
  cTime<-paste(plot_data$Date[i], plot_data$Time[i], sep=" ")
  datetime<-c(datetime, cTime)
}

datetime<-strptime(datetime, "%d/%m/%Y %H:%M:%S") #Convert to PosixCt class

png("plot2.png", width=480, height=480)
plot(datetime, plot_data$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
