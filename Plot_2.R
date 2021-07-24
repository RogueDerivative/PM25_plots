#packages
library(readr)


# #Open the files
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


# have total emissions decreased in Baltimore City (fips == "24510")
NEI_Baltimore <- subset(NEI, fips == "24510")

# boxplot
png("plot2.png")
plot_2 <- boxplot(log2(Emissions) ~ year, NEI_Baltimore,
                  ylab = "Emissions (log2(tons))", 
                  main = "Baltimore Total Emissions PM2.5 Comparison by Year",
                  col = 2:5)
dev.off()