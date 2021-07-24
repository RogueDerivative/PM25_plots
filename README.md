# PM25_plots
Exploratory Data Analysis

# plot 1
Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

This is a barplot showing the sum of total emissions for each of the four time periods

# plot 2 
Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (\color{red}{\verb|fips == "24510"|}fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot answering this question

This is four boxplots. Since the data has a majority of values between 0 and 2, and few values greater than 600 tons, I used a base 10 log to limit the variation of the data.

# plot 3 
Of the four types of sources indicated by the \color{red}{\verb|type|}type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question

This is a histogram comparing total emissions in Baltimore by emissions type and by year

# plot 4
Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

Comparison histograms using frequency to show the yearly comparison of coal-combusted sources scaled by log base 2

# plot 5
How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

Sorting the data into those that are linked to vehicular sources in Baltimore, these are comparison boxplots adjusted into log base 2 to collapse the variation, and extreme values not shown

# plot 6
Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (\color{red}{\verb|fips == "06037"|}fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions?

A sequence of boxplots showing the yearly comparison of pollution between Baltimore and LA scaled by log base 10
