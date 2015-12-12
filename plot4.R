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
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(datapart, {
  plot(Global_active_power~datetime, type ="l",
      ylab="Global Active Power", xlab="")
  plot(Voltage~datetime, type="l",
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~datetime, type="l",
     ylab="Energy sub metering", xlab="")
     lines(Sub_metering_2~datetime,col='Red')
     lines(Sub_metering_3~datetime,col='Blue')
    legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~datetime, type="l", 
       ylab="Global Rective Power",xlab="")
  
})


# generate png file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()