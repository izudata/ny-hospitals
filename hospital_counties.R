# Import the Hospital_Inpatient_Discharges__SPARCS_De-Identified___2023_20250706.csv dataset
hospitals <- read.csv("data/hospitals.csv")

# View subset of the dataset
View(hospitals)

# Install "sqldf" package
install.packages("sqldf")
library(sqldf)

# Select the first 5 rows from the hospitals dataset
sqldf("SELECT * FROM hospitals LIMIT 5")


sqldf("SELECT [Patient.Disposition] FROM hospitals  LIMIT 1000")

# Names of columns in table using sqldf
colnames(hospitals)

# Categorize patients as 'Expired' or 'Not Expired' using 'Patient Disposition' 
# grouped by 'Hospital County' and 'Age Group'
sqldf("SELECT [Hospital.County],
      [Age.Group],
      COUNT(CASE WHEN [Patient.Disposition] = 'Expired' THEN 1 ELSE NULL END) AS expired,
      COUNT(CASE WHEN [Patient.Disposition] <> 'Expired' THEN 1 ELSE NULL END) AS NotExpired,
      AVG(CASE WHEN [Patient.Disposition] = 'Expired' THEN [Length.of.Stay] END) AS Avg_Stay_Expired,
      AVG(CASE WHEN [Patient.Disposition] <> 'Expired' THEN [Length.of.Stay] END) AS Avg_Stay_NotExpired,
      AVG(CASE WHEN [Patient.Disposition] = 'Expired' THEN [Total.Charges] END) AS Avg_Charges_Expired,
      AVG(CASE WHEN [Patient.Disposition] <> 'Expired' THEN [Total.Charges] END) AS Avg_Charges_NotExpired
      FROM hospitals
      GROUP BY [Hospital.County], [Age.Group]
      ORDER BY [Hospital.County], [Age.Group]
      ")


# Categorize patients as 'Expired' or 'Not Expired' using 'Patient Disposition' 
# grouped by 'Hospital County' and 'Age Group'
# Only include groups where the total number of hospital records is more than 10,000
sqldf("SELECT [Hospital.County],
      [Age.Group],
      COUNT(CASE WHEN [Patient.Disposition] = 'Expired' THEN 1 ELSE NULL END) AS expired,
      COUNT(CASE WHEN [Patient.Disposition] <> 'Expired' THEN 1 ELSE NULL END) AS NotExpired,
      AVG(CASE WHEN [Patient.Disposition] = 'Expired' THEN [Length.of.Stay] END) AS Avg_Stay_Expired,
      AVG(CASE WHEN [Patient.Disposition] <> 'Expired' THEN [Length.of.Stay] END) AS Avg_Stay_NotExpired,
      AVG(CASE WHEN [Patient.Disposition] = 'Expired' THEN [Total.Charges] END) AS Avg_Charges_Expired,
      AVG(CASE WHEN [Patient.Disposition] <> 'Expired' THEN [Total.Charges] END) AS Avg_Charges_NotExpired
      FROM hospitals
      GROUP BY [Hospital.County], [Age.Group]
      HAVING COUNT(*) > 10000
      ORDER BY [Hospital.County], [Age.Group]
      ")







