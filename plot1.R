#WORKDIR<-"set working directory here"
#setwd(WORKDIR)


# Assuming that the input data file is already in the working directory. Or set the working directory above

# Read data 
household_data<-read.table("household_power_consumption.txt", header=T, na.strings="?", stringsAsFactors= F, sep=";")

#Convert household_data$Date from character to R Date class
Date<-as.Date(household_data$Date, "%d/%m/%Y")

# Subset the data for dates 01/02/2007 to 02/02/2007
plot_data<-household_data[(Date >= as.Date("2007-02-01", "%Y-%m-%d")) & (Date <= as.Date("2007-02-02", "%Y-%m-%d")), ]

#plot
png("plot1.png", width=480, height = 480)
hist(plot_data$Global_active_power, col="red", xlab = "Global Active Power (kilowatts)", main="Global Active Power")
dev.off()