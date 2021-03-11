# DataLakeUsageReport
Code/Utility to recursively traverse an Azure Data Lake Gen2 Insatnce and find the size of various Containers and Folders

# Input
A CSV File listing all the Paths to be traversed. Depending on what you want to calculate and how your Data Lake is structured, you can provide a list of Root Level Folders Or go for Custom list of nested folders

Sample input file in in the code.

# Output

The code will take each entry in the Input file, recursively traverse the path and calculate the total size of each location. The Output will be written to a csv file with two columns; Path, Size

