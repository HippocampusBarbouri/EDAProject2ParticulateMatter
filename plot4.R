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

par("mar"=c(5.1, 4.5, 4.1, 2.1))
png(filename = "./figure/plot4.png", 
    width = 480, height = 480, 
    units = "px")
coal <- grep("coal", sccData$Short.Name, ignore.case = T)
coal <- sccData[coal, ]
coal <- neiData[neiData$SCC %in% coal$SCC, ]

coalEmissions <- aggregate(coal$Emissions, list(coal$year), FUN = "sum")

plot(coalEmissions, type = "l", xlab = "Year", 
     main = "Total Emissions From Coal Combustion-related\n Sources from 1999 to 2008", 
     ylab = expression('Total PM'[2.5]*" Emission"))

dev.off()