rm(list=ls(all=T))
filename<-"consumption.zip"

if(!file.exists(filename)){
    fileURL<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileURL,filename,method="curl")
}
if(file.exists(filename)){
    unzip(filename)
}


data<-read.table("household_power_consumption.txt",sep = ";",header = T)

library(lubridate)
data$Date=dmy(data$Date)
reqd_data=subset(data,Date=="2007-02-01" | Date=="2007-02-02")
reqd_data[,c("Sub_metering_1","Sub_metering_2","Sub_metering_3")]=lapply(reqd_data[,c("Sub_metering_1","Sub_metering_2","Sub_metering_3")],
                                                                        as.numeric)
reqd_data$Global_active_power=as.numeric(reqd_data$Global_active_power)
reqd_data$Voltage=as.numeric(reqd_data$Voltage)
reqd_data$Global_reactive_power=as.numeric(reqd_data$Global_reactive_power)
par(mfrow=c(2,2))

#Plot 1
plot(reqd_data$Global_active_power/1000,pch=NA_integer_,
     ylab="Global Active Power (kilowatts)",xlab="",xaxt='n')
lines(reqd_data$Global_active_power/1000)
axis(side = 1 ,at = c(0,1500,2500),labels=c("Thu","Fri","Sat"))

#Plot 2
plot(reqd_data$Voltage,pch=NA_integer_,
     ylab="Voltage",xlab="datetime",xaxt='n')
lines(reqd_data$Voltage)
axis(side = 1 ,at = c(0,1500,2500),labels=c("Thu","Fri","Sat"))

#Plot 3

plot(reqd_data$Sub_metering_1,pch=NA_integer_,ylab="Energy sub metering",
     xlab="",xaxt="n")
lines(reqd_data$Sub_metering_1)
lines(reqd_data$Sub_metering_2,col="red")
lines(reqd_data$Sub_metering_3,col="blue")
axis(side = 1 ,at = c(0,1500,2500),labels=c("Thu","Fri","Sat"))
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("black","red","blue"),lty=1,cex=0.4)
#Plot 4
plot(reqd_data$Global_reactive_power/100,pch=NA_integer_,
     ylab="Global_reactive_power",xlab="datetime",xaxt='n')
lines(reqd_data$Global_reactive_power/100)
axis(side = 1 ,at = c(0,1500,2500),labels=c("Thu","Fri","Sat"))
