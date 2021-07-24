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

#packages
library(ggplot2)

#Q_3 source variation by year in Baltimore City (fips == "24510")
NEI_Baltimore <- as.data.frame(subset(NEI, fips == "24510"))
png("plot3.png")
g <- ggplot(NEI_Baltimore, aes(factor(year), fill = type))
g + geom_bar() + 
        facet_grid(.~ type) + 
        labs(x = "year", y = "PM2.5 Emissions (in tons)", 
             title = "Total Yearly Emissions by Type")
dev.off()