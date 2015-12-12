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

hist(datapart$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

# generate png file
dev.copy(png, file = "plot1.png", height=480, width=480)
dev.off()
