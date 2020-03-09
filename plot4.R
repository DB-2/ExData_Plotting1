## This is the script to produce plot4.png file
## Author : DBarry
## The plot is a line plot in base R based on the energy power consumption file below
## with displaying 4 graphs in 4 quadrants using par(mfrow=c(2,2)) 

## Read the zip file

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp,mode="wb")

## Extract the semi colon delimited file
unzfile <- unz(temp,"household_power_consumption.txt")

##  Read to the 1/2/2007 and 2/2/2007 dates
epc<-read.table(file=unzfile, sep = ";",header = FALSE, na.strings ="?",stringsAsFactors= F,
                skip=66637,nrows=2880,
                col.names=c("Date", "Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity",
                            "Sub_metering_1","Sub_metering_2","Sub_metering_3"))

##  Create a dattime variable from date and time columns
epc$dateTime <- strptime(paste(epc$Date,epc$Time), format="%d/%m/%Y %H:%M:%S")

png(file="plot4.png", width=480, height=480)
par(mfrow = c(2, 2))
## Global Active Power
plot(x=epc$dateTime,y=epc$Global_active_power,type="n",xlab="", ylab="Global Active Power")
lines(x=epc$dateTime,y=epc$Global_active_power)

## Voltage
plot(x=epc$dateTime,y=epc$Voltage,type="n",xlab="datetime", ylab="Voltage")
lines(x=epc$dateTime,y=epc$Voltage)

## Sub Metering
plot(x=epc$dateTime,y=epc$Sub_metering_1,type="n",xlab="", ylab="Energy sub metering")
legend("topright", lty=1 , cex = 0.5, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),col=c("black", "red", "blue") )
lines(x=epc$dateTime,y=epc$Sub_metering_1,col="black")
lines(x=epc$dateTime,y=epc$Sub_metering_2,col="red")
lines(x=epc$dateTime,y=epc$Sub_metering_3,col="blue")

## Global Reactive Power
plot(x=epc$dateTime,y=epc$Global_reactive_power,type="n",xlab="datetime", ylab="Global_reactive_power")
lines(x=epc$dateTime,y=epc$Global_reactive_power)
dev.off()
