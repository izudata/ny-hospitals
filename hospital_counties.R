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


# Load the survival package
library(survival)

# Get Average age by ph.karno for time between 500 and 1000
sqldf("SELECT AVG(age), `ph.karno`
      FROM lung
      WHERE time < 1000 AND time > 500
      GROUP BY `ph.karno`
      ORDER BY `ph.karno`
      ")

# Assign the lung dataset to a variable
lung2 <- sqldf("SELECT * FROM lung")

# lung3 <- sqldf("UPDATE lung2
#            SET Age = 70 WHERE Age < 80")


# Update the record where patient's age is between 70 and 80 in a new column Age2
lung3 <- sqldf("SELECT *, CASE WHEN (age>=70 and age<80) THEN 70 END AS Age2
                FROM lung2")

# View the first 10 rows of the updated dataset
sqldf("SELECT * FROM lung3
      WHERE Age >= 70 LIMIT 10")





