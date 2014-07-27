Coursera_GCD
============

My project files for the Getting and Cleaning Data course on Coursera

The "run_analysis.R" script assumes that the UCI HAR datasets have been downloaded and unzipped already.  These files are accessible at the following URL:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The R script sets the working directory assuming the working files are extracted into a "code/GCD" directory - if you extract into a different location then make sure to update this info at the top of the script.  The working directory of the script is at the top level of the extracted files (within the "UCI HAR Dataset" folder).

The r script is commented extensively to walk you through the logic step by step, but I'll summarize a few assumptions and key points below:

- I use R's grepl function to apply string search capabilities across a list (the list in this case is all of the feature names taken from the "features.txt" file).  My assumption is that the columns of interest include anything with "mean" or "std" in the column name.
- The order of the detailed data set was not specified, and is not relevant for the summary output accuracy, but the r script merges the test and train sets after they have been completely assembled.  As such, the test data comes first and is followed by the train data.  
- I use the dplyr package to quickly group and summarise the data for output.
- The output tidy data set is written to a "summary.csv" file in the working directory.
