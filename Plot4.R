# QUESTION 4: Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

# Read and prepare data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Merging the tables
NEISCC <- merge(NEI, SCC, by="SCC")
library(dplyr)
NEISCCdp <- tbl_df(NEISCC)

# Search for "coal" and create boolean column
NEISCCdp <- mutate(NEISCCdp, coal = grepl("coal", NEISCCdp$Short.Name, ignore.case=TRUE)) 

#Renaming columns
EmissionsCoalYear <- summarize(group_by(filter(NEISCCdp, coal==TRUE),year),sum(Emissions))
colnames(EmissionsCoalYear) <- c("Year", "Emissions") 

# Year converted to string
EmissionsCoalYear$Year <- as.character(EmissionsCoalYear$Year)

# New column with emissions in thousands (for the y axis)
EmissionsCoalYear$EmissionsInTousands = EmissionsCoalYear$Emissions/1000

# Plot 4
library(ggplot2)
png('plot4.png')
g <- ggplot(EmissionsCoalYear, aes(Year, EmissionsInTousands))
g+geom_bar(stat='identity')+labs(title="Emissions from coal combustion-related sources", x="Years",y="Emissions (PM 2.5) in thousands")
dev.off()
