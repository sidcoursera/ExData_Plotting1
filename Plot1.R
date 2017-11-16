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
data$Global_active_power=as.numeric(data$Global_active_power)
library(lubridate)
data$Date=dmy(data$Date)
reqd_data=subset(data,Date=="2007-02-01" | Date=="2007-02-02")
hist(reqd_data$Global_active_power/1000,col="red",main="Global Active Power",xlab="Global Active Power(kilowatts)",ylab="Frequency")
