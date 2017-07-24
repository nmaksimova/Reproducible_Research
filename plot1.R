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

