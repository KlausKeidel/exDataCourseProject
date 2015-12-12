# load the dataset
basedata <-read.csv("./data/household_power_consumption.txt", header=TRUE, sep=";", na.strings="?")

# converting date string to date
basedata$Date <-as.Date(basedata$Date, "%d/%m/%Y")

# datasubset an removing the basedata

datapart <- subset(basedata, Date >= '2007-02-01' & Date <= '2007-02-02')
rm(basedata)

# generate datetime
datetime <- strptime(paste(datapart$Date, datapart$Time, sep=" "), "%Y-%m-%d %H:%M:%S")
datapart$datetime <- as.POSIXct(datetime)

# generate plot

with(datapart, {
plot(Sub_metering_1~datetime, type="l",
     ylab="Energy sub metering", xlab="")
     lines(Sub_metering_2~datetime,col='Red')
     lines(Sub_metering_3~datetime,col='Blue')
}
)
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2.5,
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# generate png file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()