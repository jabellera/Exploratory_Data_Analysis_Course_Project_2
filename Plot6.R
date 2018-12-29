# QUESTION 6: Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, California (fips == "06037").
# Which city has seen greater changes over time in motor vehicle emissions?

# Read and prepare data
NEI <- readRDS("summarySCC_PM25.rds")
library(dplyr)
NEIdp <- tbl_df(NEI)

# Table with Motor Vehicle emissions per year of Baltimore
BaltimoraEmissionsVehicle = summarize(group_by(filter(NEIdp, fips=='24510', type=='ON-ROAD'), year), sum(Emissions)) 
BaltimoraEmissionsVehicle = mutate(BaltimoraEmissionsVehicle, Place = 'Baltimore City')

# Table with Motor Vehicle emissions per year of LA County
LAEmissionsVehicle = summarize(group_by(filter(NEIdp, fips=='06037', type=='ON-ROAD'), year), sum(Emissions))
LAEmissionsVehicle = mutate(LAEmissionsVehicle, Place = 'Los Angeles County')

# Merge tables
BaltimoreLA <- rbind(BaltimoraEmissionsVehicle,LAEmissionsVehicle)

#Renamed columns
colnames(BaltimoreLA) <- c('Year', 'Emissions', 'Place')

# Year converted to string
BaltimoreLA$Year <- as.character(BaltimoreLA$Year)

# Plot
png('plot6.png')
qplot(Year,data=BaltimoreLA, geom="bar", weight=Emissions, facets=.~Place, fill=Year, main='Baltimore City/Los Angeles County: Emissions of motor vehicle', xlab='', ylab = 'Emissions (PM 2.5)')
dev.off()
