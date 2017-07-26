setwd("C:/Nata Docs/Data Science/Course 5 - Reproducible Research/Week_1")
getwd()

# 1. Make a plot that answers the question: what is the relationship between mean covered charges 
# (Average.Covered.Charges) and mean total payments (Average.Total.Payments) in New York?

# Load data into R
#url <- "https://d3c33hcgiwev3.cloudfront.net/_e143dff6e844c7af8da2a4e71d7c054d_payments.csv?Expires=1474502400&Signature=TKwh1KviAAZ~8D6U96czcGr2qE63HkBeVmBW0s0sREEJ8nwwk~rl-W8ZFAHS423~eMV~q1eAII1f124wg-0Rpryevaz4NPBMpOXmGI~VfX5V1XypVDahXluA0grA217CMqVHG6ENzk0QWGYUPu7DwQVq3zuVotk0OFW6w-hXL0c_&Key-Pair-Id=APKAJLTNE6QMUY6HBC5A"

#download.file(url, destfile = "payment.csv", method = "wget")

data <- read.csv("payment.csv", header = TRUE, sep = ",")

head(data)

NYData <- data[data$Provider.State =="NY",]

#Plot in pdf
pdf("plot1.pdf")
plot(NYData$Average.Covered.Charges, NYData$Average.Total.Payments, 
     xlab = "Average Covered Charges (in $)",
     ylab ="Average Total Payments (in $)",
     main = "Relationship between Charges and Payments in New York",
     col = adjustcolor("blue", alpha = 0.5), pch = 16)
abline(lm(NYData$Average.Total.Payments ~ NYData$Average.Covered.Charges), col = "red", lwd = 1.5)
dev.off()

# 2. Make a plot (possibly multi-panel) that answers the question: 
# how does the relationship between mean covered charges (Average.Covered.Charges) and 
# mean total payments (Average.Total.Payments) vary by medical condition (DRG.Definition) and 
# the state in which care was received (Provider.State)?

states <- unique(data$Provider.State)

# Getting unique states in the dataset
levels(data$Provider.State)
# Getting unique medical conditions in the datasets
levels(data$DRG.Definition)
levels(data$DRG.Definition) <- c("194", "292", "392", "641", "690", "871")
conditions <- unique(data$DRG.Definition)


# There are 6 uniques states and 6 unique conditions in the giving dataset.
# I am creating a matrix of plots, 6x6.


pdf("plot2.pdf")

# Creating a multipanel plot for each state and each medical condition.
# Adjusting margins.

par(mfrow = c(6,6), oma = c(2,2,2,2), mar=c(2,2,2,2))

for (i in states) {
        for (j in conditions) {
        with(subset(data, Provider.State == i & DRG.Definition == j),
             plot(Average.Covered.Charges, Average.Total.Payments, 
                  main = paste(i, j),
                  ylim = range(data$Average.Total.Payments),
                  xlim = range(data$Average.Covered.Charges),
                  xlab = "Avg. Cov.$", ylab = "Avg. Tot.$",
                  col = adjustcolor("green", alpha = 0.5), pch = 16
                  )
        )

        abline(lm(Average.Total.Payments~Average.Covered.Charges,
                  subset(data, Provider.State == i & DRG.Definition == j)), 
               col = "blue")   
        }
}

dev.off()