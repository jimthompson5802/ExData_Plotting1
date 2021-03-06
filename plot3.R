###
# Plot 3
###

###
# Data retrieved from
#  https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#
# Description of the data can be found at
#   https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption
#
# The data is downloaded and unzipped into the current working direcory to create
# file household_power_consumption.txt.
###

## Download the file
file.url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip" 
my.file <- "./exdata_data_housefold_power.consumption.zip" 

setInternet2(TRUE) 
download.file(file.url,my.file) 
unzip(my.file)


## read in power consumption data file
hpc <- read.csv("./household_power_consumption.txt",sep=";",
                 colClasses=c("character","character",rep("numeric",7)),
                na.strings="?")

## quick overview of data
cat("number of rows & columns:\n",dim(hpc))
cat("column names:\n",names(hpc))
cat("Overall structure:\n",str(hpc))

## extract only data for 2/1/2007 and 2/2/2007
hpc <- hpc[as.Date(hpc$Date,"%d/%m/%Y") == as.Date("2007-2-1") |
           as.Date(hpc$Date,"%d/%m/%Y") == as.Date("2007-2-2"),]


## create vector of date/time stamps for selecting required date range
hpc$date.time <- strptime(paste(hpc$Date,hpc$Time,sep=" "),"%d/%m/%Y %H:%M:%S")
str(hpc)

## generate Plot

## open png file graphic device
png(file="plot3.png")
## establish general plot area
plot(hpc$date.time,hpc$Sub_metering_1,type="n",
     ylab="Energy sub metering",xlab="")

## add line for each sub metering attribute
lines(hpc$date.time,hpc$Sub_metering_1,col="black")
lines(hpc$date.time,hpc$Sub_metering_2,col="red")
lines(hpc$date.time,hpc$Sub_metering_3,col="blue")

## add legend for the graph
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=1,col=c("black","red","blue"),
       xjust=1)

## close graphic device
dev.off()
                            