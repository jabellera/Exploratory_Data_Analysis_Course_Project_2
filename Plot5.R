# QUESTION 5: How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

# Read and prepare data
NEI <- readRDS("summarySCC_PM25.rds")
library(dplyr)
NEIdp <- tbl_df(NEI)

# Table with Motor Vehicle emissions per year of Baltimore
BaltimoraEmissionsVehicle = summarize(group_by(filter(NEIdp, fips=="24510", type=='ON-ROAD'), year), sum(Emissions)) 

# Renamed columns
colnames(BaltimoraEmissionsVehicle) <- c("Year", "Emissions")

# Plot
png('plot5.png')
g <- ggplot(BaltimoraEmissionsVehicle, aes(Year,Emissions))+scale_x_continuous(breaks = c(1999,2002,2005,2008))
g+geom_point(size=4, color='orange')+geom_line(size=1.5,color='green')+labs(title="Baltimore City: Emissions of motor vehicle", x="Years",y="Emissions (PM 2.5)")
dev.off()
