Coursera_GCD
============

My project files for the Getting and Cleaning Data course on Coursera

The "run_analysis.R" script assumes that the UCI HAR datasets have been downloaded and unzipped already.  These files are accessible at the following URL:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The R script sets the working directory assuming the working files are extracted into a "code/GCD" directory - if you extract into a different location then make sure to update this info at the top of the script (line 3).  The working directory of the script is at the top level of the extracted files (within the "UCI HAR Dataset" folder).

The r script is commented extensively to walk you through the logic step by step, but I'll map the project requirements to the script steps in the list below:

- To meet requirement 1 (merged data sets), I use the rbind() function in line 60 of the script.
- To meet requirement 2 (mean and std dev features only), I use R's grepl function to apply string search capabilities across a list (the list in this case is all of the feature names taken from the "features.txt" file).  My assumption is that the columns of interest include anything with "mean" or "std" in the column name.  Line 63 in the script handles this processing.
- To meet requirement 3 (descriptive activity names), I read in the activity descriptions from the "activity_labels.txt" file in the data set, and join this information to the activity codes in the "y_*.txt" data for each data set.  You can see this code in lines 32-34 for the test set, and 47-49 for the train set.
- To meet requirement 4 (descriptive variable names), I apply the feature names assigned to the variables in the study.  I am assuming these do not need to be renamed further, and are improvements over the V1, V2, V3 assigned in the basic file read steps...  Refer to lines 9-23 in the script for this processing.
- To meet requirement 5 (constructing and writing summary output), I use the dplyr package to quickly group and summarise the data for output.  The output tidy data set is written to a "summary.csv" file in the working directory.  Refer to lines 65-71 in the script for this processing.

