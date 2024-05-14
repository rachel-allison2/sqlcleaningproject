/*
In this project I will show how I use SQL to clean data.
The dataset I will be using can be found here: https://archive.ics.uci.edu/dataset/10/automobile
The data contains historical sales data on car prices and their features.
According to the data's description, the fuel_type column should only have two unique string values: diesel and gas. To check and make sure that's true I will use the DISTINCT statement to pull up all of the values in the fuel_type column.
*/

SELECT
  DISTINCT fuel_type
FROM
  `treeproject-415820.vehicles.cars_info`

/*
After running the query with the DISTINCT statement the results show confirm that the values in the fuel_type column are: gas and diesel.

Now I will inspect a column with numerical data. The length column should contain numeric measurements of the cars. I will check that the minimum and maximum lengths in the dataset align with the data description which states that the lengths in this column should range from 141.1 to 208.1.
*/

SELECT
  MIN(length) AS min_length,
  MAX(length) AS max_length
FROM
  `treeproject-415820.vehicles.cars_info`

/*
After running the query using MIN and MAX functions I confirm that the lengths match the data description.

Now I will check the data for null or missing values. I will run the WHERE statement to check if the num_of_doors column contains null or missing values.
*/

SELECT
  *
FROM
  `treeproject-415820.vehicles.cars_info`
WHERE
  num_of_doors IS NULL;

/*
After running the query the results show two rows that contain null values for the num_of_doors column, one Mazda and one Dodge.
In order to fill these missing values I check with the sales manager, who states that all Dodge gas sedans and all Mazda diesel sedans sold had four doors.
After updating the missing values with the correct values I will check for potential errors. I will use SELECT DISTINCT to check what values exist in the num_of_cylinders.
*/

SELECT
  DISTINCT num_of_cylinders
FROM
  `treeproject-415820.vehicles.cars_info`;

/*
After running this I notice that there are one too many rows. There are two entries for two cylinders but one of the "two" is misspelled.
After updating the table to fix the spelling error I can now check the compression_ratio column. According to the data description the compress_ratio column values should range from 7 to 23.
*/

SELECT
  MIN(compression_ratio) AS min_compression_ratio,
  MAX(compression_ratio) AS max_compression_ratio
FROM
  `treeproject-415820.vehicles.cars_info`;

/*
This returns a maximum of 70, this is an error because the maximum value in this column should be 23 not 70. The 70 is most likely a 7.0, to make sure the rest of the values fall within the expected range I will run the query again without the row with 70.
*/

SELECT
  MIN(compression_ratio) AS min_compression_ratio,
  MAX(compression_ratio) AS max_compression_ratio
FROM
  `treeproject-415820.vehicles.cars_info`
WHERE
  compression_ratio <> 70;

/*
Now the highest value is 23 which aligns with the data description. I check with the sales manager again, who says that this row was made in error and should be removed. Before I delete anything I will check to see how many rows contain this value as a precaution so that I don't end up deleting 50% of the data.
*/

SELECT
   COUNT(*) AS num_of_rows_to_delete
FROM
  `treeproject-415820.vehicles.cars_info`
WHERE
   compression_ratio = 70;

/*
The results show that only one row containts the error which can be deleted.
Finally I will check the drive_wheels column for any inconsistencies that might cause errors.
*/

SELECT
  DISTINCT drive_wheels
FROM
  `treeproject-415820.vehicles.cars_info`;

/*
It appears that 4wd appears twice in the results. Because I used the SELECT DISTINCT statement to return unique values this means likely means there's an extra space in one of the 4wd entries that makes it different from the other 4wd.
To check if this is the case I will use a LENGTH statement to determine the length of how long each of the string variables.
*/

SELECT
  DISTINCT drive_wheels,
  LENGTH(drive_wheels) AS string_length
FROM
  `treeproject-415820.vehicles.cars_info`;

/*
According to these results, some instances of the 4wd string have four characters instead of the expected three. I can use the TRIM function to remove the extra spaces in the drive_wheels column.
*/