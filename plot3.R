load.epc <- function(){
  fp <- "data/household_power_consumption.txt"
  tmp <- read.table(fp, header = TRUE, nrows = 5, sep=";")
  classes <- sapply(tmp, class)
  
  
  df <- read.table(fp, sep=";", header=TRUE, na.strings="?", colClasses = classes, nrows = 2080000)
  df <- df[df$Date == "1/2/2007" | df$Date == "2/2/2007",]
  df$TimeStamp <- strptime(paste(df$Date, df$Time), format="%d/%m/%Y %H:%M:%S")
  df$Date <- as.Date(df$Date, format="%d/%m/%Y")
  return(df)
}

df <- load.epc()

png("plot3.png", width=480, height=480)
plot(df$TimeStamp, df$Sub_metering_1, type="n", ylab="Energy sub metering", xlab="")
lines(df$TimeStamp, df$Sub_metering_1, lwd=1, col="black")
lines(df$TimeStamp, df$Sub_metering_2, lwd=1, col="red")
lines(df$TimeStamp, df$Sub_metering_3, lwd=1, col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lwd=1)
dev.off()
