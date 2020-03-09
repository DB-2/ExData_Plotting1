## This is the script to produce plot1.png file
## Author : DBarry
## The script is for a histogram in base R based on the energy power consumption file below
## plotting the frequency of Global Active Power in kilowatts values

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

png(file="plot1.png",
    width=480, height=480)
hist(epc$Global_active_power,main ="Global Active Power", col="Red", xlab = "Global Active Power (kilowatts)",ylim=c(0,1200))
dev.off()


