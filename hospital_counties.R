hospitals <- read.csv("data/hospitals.csv")

# Install "sqldf" package
install.packages("sqldf")
library(sqldf)

# Select the first 5 rows from the hospitals dataset
sqldf("SELECT * FROM hospitals LIMIT 5")


# Names of columns in table using sqldf
colnames(hospitals)

sqldf("SELECT [Hospital.County],
      [Age.Group],
      COUNT(CASE WHEN [Type.of.Admission] = 'expired' THEN 1 ELSE NULL END) AS expired,
      COUNT(CASE WHEN [Type.of.Admission] <> 'expired' THEN 1 ELSE NULL END) AS NotExpired,
      AVG(CASE WHEN [Type.of.Admission] = 'expired' THEN [Length.of.Stay] END) AS Avg_Stay_Expired,
      AVG(CASE WHEN [Type.of.Admission] <> 'expired' THEN [Length.of.Stay] END) AS Avg_Stay_NotExpired,
      AVG(CASE WHEN [Type.of.Admission] = 'expired' THEN [Total.Charges] END) AS Avg_Charges_Expired,
      AVG(CASE WHEN [Type.of.Admission] <> 'expired' THEN [Total.Charges] END) AS Avg_Charges_NotExpired
      FROM hospitals
      GROUP BY [Hospital.County], [Age.Group]
      ORDER BY [Hospital.County], [Age.Group]
      ")




