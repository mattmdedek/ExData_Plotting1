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

png("plot2.png", width=480, height=480)
plot(df$TimeStamp, df$Global_active_power, type="n", ylab="Global Active Power (kilowatts)", xlab="")
lines(df$TimeStamp, df$Global_active_power, lwd=1)
dev.off()
