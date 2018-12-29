# QUESTION 3: Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable,
# which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City?
# Which have seen increases in emissions from 1999-2008?
# Use the ggplot2 plotting system to make a plot answer this question.

# 1. Read and prepare data
NEI <- readRDS("summarySCC_PM25.rds")

baltimorenei <- (NEI[NEI$fips == "24510",])
#aggdatabaltimore <- aggregate(Emissions~year,data = baltimorenei,FUN = sum)

## Load the Libraries
library(ggplot2)

## Create BarPlot and Export as PNG file

png(filename = "plot3.png",width = 750, height = 602,units = "px",)

g <- ggplot(data = baltimorenei, aes(factor(year), Emissions, fill = type)) +
        geom_bar(stat = "identity") +
        facet_grid(facets = .~type,scales = "free",space = "free") +
        labs(x="Year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
        labs(title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type"))

print(g)
dev.off()
