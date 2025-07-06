hospitals <- read.csv("data/hospitals.csv")

# Install "sqldf" package
install.packages("sqldf")
library(sqldf)


sqldf("SELECT * FROM hospitals LIMIT 5")


