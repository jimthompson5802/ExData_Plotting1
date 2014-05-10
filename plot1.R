###
# Plot 1
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
hist(hpc$Global_active_power,col="red",
     main="Global Active Power",
     xlab="Global Active Power (kilowatts)")

## copy to png file
dev.copy(png,file="plot1.png")
dev.off()
                            