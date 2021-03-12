# Data Lake Usage Report
Code/Utility to recursively traverse an Azure Data Lake Gen2 Insatnce and find the size of various Containers and Folders.

For Azure Data Lake Gen1, the Azure Storage Exlorer was able to tell the size of the folder by right-clicking and selecting the Folder Stats option. But with Azure Data Lake Gen2, this feature was taken away. While there might be solutions provided by the ADLS Product team in the future, this code can help solve any immediate requirements of finding sizes of Containers and folders.

# Prerequisites

Azure Subscription <br>
Azure Data Lake Gen2 Storage Account <br>
Powershell

# Input
A CSV File listing all the Paths to be traversed. Depending on what you want to calculate and how your Data Lake is structured, you can provide a list of Root Level Folders Or go for Custom list of nested folders

Sample input file in in the code.

# Output

The code will take each entry in the Input file, recursively traverse the path and calculate the total size of each location. The Output will be written to a csv file with two columns; Path, Size

# Usage

DataLakeUsageReportBuilder.ps1 contains the code. Run the script using the following format:

<I> DataLakeUsageReportBuilder.ps1 YourStorageAccountName ContainerName verbose (path...)\input.csv (path...)\output.csv </I>

Sample Input and Output files are included


