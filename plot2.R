# Q2: Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
# (fips == 24510) from 1999 to 2008? Use the base plotting system to make a plot 
# answering this question.

setwd("~/Desktop/coursera/EDAProject2ParticulateMatter/")

# create data directory if it doesn't exist
if (!file.exists("NEIdata")){
    dir.create("NEIdata")
}

# create figure directory if it doesn't exist
if (!file.exists("figure")){
    dir.create("figure")
}



# EPA data file location
url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

# Download file and unzip it
tdir = tempdir()

tfile = tempfile(tmpdir=tdir, fileext=".zip")

download.file(url, tfile, method="curl")


datapath = paste(file.path(getwd()),"/NEIdata",sep="")

unzip(tfile, exdir=datapath, overwrite=TRUE)



# Check if both data exist. If not, load the data.
if (!"neiData" %in% ls()) {
    neiData <- readRDS("./NEIdata/summarySCC_PM25.rds")
}
if (!"sccData" %in% ls()) {
    sccData <- readRDS("./NEIdata/Source_Classification_Code.rds")
}

# look at first few rows of data
head(neiData)
head(sccData)


dim(neiData) 
dim(sccData) 



subset <- neiData[neiData$fips == "24510", ] 
par("mar"=c(5.1, 4.5, 4.1, 2.1))
png(filename = "./figure/plot2.png", 
    width = 480, height = 480, 
    units = "px")
totalEmissions <- aggregate(subset$Emissions, list(subset$year), FUN = "sum")
plot(totalEmissions, type = "l", xlab = "Year", 
     main = "Total Emissions in Baltimore City from 1999 to 2008", 
     ylab = expression('Total PM'[2.5]*" Emission"))

dev.off()