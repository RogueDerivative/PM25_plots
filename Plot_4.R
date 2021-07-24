#packages
library(readr)
library(dplyr)
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

# Q_4 changes in coal combustion-related sources
g_coal <- grep("[Cc]oal", SCC$Short.Name) #find all coal related emissions
coal <- subset(SCC[g_coal,]) #shrink SCC to only those containing coal
g_combustion <- grep("[Cc]omb", SCC$Short.Name) #find all combustion related coal emissions
comb <- subset(coal[g_combustion,]) #shrink the coal subset to those only with combustion
SCC_values <- comb$SCC # create a vector identifying those SCC codes
NEI_coal_comb <- subset(NEI, NEI$SCC %in% SCC_values) #subset NEI to find all relevant SCC codes

#group data
my_data <- group_by(NEI_coal_comb, year, SCC) %>%
        summarise(Emissions = mean(Emissions, na.rm = TRUE), .groups = "drop")

#plot data
png("plot4.png")
g <- ggplot(my_data, aes(log2(Emissions), color = factor(year)))
g + geom_histogram() + facet_grid(year ~.) +
        labs(title = "Change in Emissions from Coal Combustion-Related Sources")
dev.off()