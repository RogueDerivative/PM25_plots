#packages
library(readr)
library(dplyr)


#Open the files
if(!file.exists("data")){
        dir.create("data")
}
url1 <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url1, destfile = "./data/df1.zip")
unzip(zipfile = "./data/df1.zip")

#confirm download date
dateDownloaded <- date()

#read in the files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# total emissions comparison by year
png("plot1.png")
plot_1 <- table(NEI$year) %>% barplot(
        main = "Total PM2.5 Emissions",
        ylab = "Emissions (tons)",
        xlab = "year",
        col = "blue")
dev.off()
