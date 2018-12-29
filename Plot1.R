# QUESTION 1: Have total emissions from PM2.5 decreased in the United States from 1999 to 2008?
# Using the base plotting system, make a plot showing the total PM2.5 emission from all sources for each of the
# years 1999, 2002, 2005, and 2008.

# Read and prepare data
NEI <- readRDS("summarySCC_PM25.rds")
# Using dplyr
library(dplyr)
NEIdp <- tbl_df(NEI)
# Table with emissions per year
EmissionsForYear = summarize(group_by(NEIdp, year), sum(Emissions))
# Renaming columns
colnames(EmissionsForYear) <- c("Year", "Emissions")
# New column with emissions in million (for the y axis)
EmissionsForYear$EmissionsInMillions = EmissionsForYear$Emissions / 1000000

# Plot (png file)
png('plot1.png')
barplot(EmissionsForYear$EmissionsInMillions, names.arg=EmissionsForYear$Year, col="blue", xlab='Years', ylab='Emissions (PM 2.5) in millions', main =  'Emissions (PM 2.5) per year')
dev.off()
