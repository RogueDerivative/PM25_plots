#packages
library(readr)
library(ggplot2)

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

#find indices for the relevant data
vehicles <- grepl("Vehicles", SCC$EI.Sector)

#Subset SCC with the set intersection
my_data <- subset(SCC[vehicles,])

#Vector to subset NEI by SCC codes
SCC_Codes <- my_data$SCC

#Subset NEI for Baltimore City (fips == "24510")
NEI_Baltimore <- subset(NEI, fips == "24510")

#Subset NEI_Baltimore with SCC_Codes
NEI_onroad_mobile <- subset(NEI_Baltimore, NEI_Baltimore$SCC %in% SCC_Codes)

#plot
png("plot5.png")
plot_5 <- ggplot(NEI_onroad_mobile, aes(factor(year), log(Emissions)))
plot_5 + geom_boxplot(outlier.shape = NULL, show.legend = FALSE, aes(color = year)) +
        labs(title = "Changes in Vehicle Related Emissions in Baltimore",
             x = "year", y = " Emissions (in log10(tons))")
dev.off()
