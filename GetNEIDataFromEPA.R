
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