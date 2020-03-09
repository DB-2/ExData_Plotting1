## This is the script to produce plot3.png file
## Author : DBarry
## The plot is a line plot in base R based on the energy power consumption file below
## with layering the 3 Energy Sub Metering readings 1,2,3 v dateTime of the readings 

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

##  Create a datetime variable from date and time columns
epc$dateTime <- strptime(paste(epc$Date,epc$Time), format="%d/%m/%Y %H:%M:%S")


png(file="plot3.png", width=480, height=480)
plot(x=epc$dateTime,y=epc$Sub_metering_1,type="n",xlab="", ylab="Energy sub metering")
lines(x=epc$dateTime,y=epc$Sub_metering_1,col="black")
lines(x=epc$dateTime,y=epc$Sub_metering_2,col="red")
lines(x=epc$dateTime,y=epc$Sub_metering_3,col="blue")
legend("topright", lty=1 , legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),col=c("black", "red", "blue") )
dev.off()
