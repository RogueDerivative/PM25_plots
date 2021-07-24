#packages
library(readr)
library(ggplot2)
library(dplyr)

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

#find indices for the relevant data
vehicles <- grepl("Vehicles", SCC$EI.Sector)

#Subset SCC with the set intersection
my_data <- subset(SCC[vehicles,])

#Vector to subset NEI by SCC codes
SCC_Codes <- my_data$SCC

#Subset NEI for Baltimore and LA (fips == "24510" & "06037)
NEI_Baltimore_LA <- filter(NEI, fips == "24510" | fips == "06037")

#rename fips to city names
my_sub <- as.character(NEI_Baltimore_LA$fips)
my_sub <- gsub("24510", "Baltimore", my_sub)
my_sub <- gsub("06037", "LA", my_sub)
NEI_Baltimore_LA$fips <- my_sub

#group the data
my_data <- group_by(NEI_Baltimore_LA, fips, year)
my_data <- select(NEI_Baltimore_LA, fips, Emissions, year)

#plot 6
png("plot6.png")
plot_6 <- ggplot(my_data, aes(x = fips, y = log(Emissions), fill = fips))+
        geom_boxplot(outlier.shape = NULL, position = position_dodge())+
        facet_wrap(.~year) + 
        labs(
                title = "Emissions Comparison of Baltimore and LA",
                x = NULL, 
                y = " Emissions (in log10(tons))")
dev.off()
