#!/usr/bin/env Rscript

# Data URL:
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip

# There has been a lot of discussion on the forum about whether or not
# to make the plot backgrounds white or transparent. The reference
# plots do in fact have a transparent background, but appear white
# when rendered in the README which is the first thing people see.
# That said, I've chosen to produce both backgrounds, but to use
# the white bg images as the primary files (plot[1-4].png). The
# transparent images can be found in transparent/plot[1-4]-trans.png.
#
# My rationale:
#
# a) Peers who are not familiar with transparency may be confused by
#    the checkerboard background rendered by github (and most image
#    viewing software) that transparency brings
# b) People that care about transparency can see that I realize the
#    issue and know how to treat it.
# c) In reality, I believe a white background to be more approprite
#    for these plots.


bg.color <- "white"
# bg.color <- "transparent"


# Load and filter household power consumption dataset
load.power.data <- function(filepath) {
    # Just read the whole thing
    x <- read.table(filepath, sep=";", header=TRUE, na.strings="?")

    # Create a new "datetime" column with type POSIXlt by combining
    # the existing Date and Time columns
    x$datetime <- strptime(paste(x$Date, x$Time), "%d/%m/%Y %H:%M:%S")

    # Return only the subset of dates we are interested in as given
    # in the assignment description
    dates <- c(as.Date("2007-02-01"), as.Date("2007-02-02"))
    x[as.Date(x$datetime) %in% dates,]
}


# Red histogram of global active power with explicit x-label and title,
# default y-label, and no legend
do.plot1 <- function(x) {
    hist(x$Global_active_power, col="red",
            main="Global Active Power",
            xlab="Global Active Power (kilowatts)")

}

x <- load.power.data("./household_power_consumption.txt")

png("plot1.png", width=480, height=480, bg=bg.color)
do.plot1(x)
dev.off()
