library("dplyr")

setwd("~/code/GCD/UCI HAR Dataset")

# Read in feature (variable) names
feat = read.delim("features.txt", sep=" ", header=F, stringsAsFactors=F)
feature_names = feat$V2

# Find variables that provide mean values, assign to data frame
# For the purposes of this assignment, I am assuming that any feature with "mean" or "std"
# in the name is a feature of interest. 

has_mean = grepl("mean", feature_names)
means = feat[has_mean,]

# Find variables that provide stddev values, assign to data frame
has_std = grepl("std", feature_names)
stds = feat[has_std,]

# Merge the two filtered data frames for a complete list of columns to be included in 
# analysis.  This is the "keepers" data frame that will be used to filter out only the 
# columns of interest and apply the appropriate descriptive names.
keep_cols = rbind(means, stds)

# Read in the activity descriptions so they can be added to the dataset in a future step
act_labels = read.delim("activity_labels.txt", sep=" ", header=F)

# Process the data in the test set.
test = read.csv("test/X_test.txt", sep="", header=F)
# Filter the columns in the test set by our list of "keeper" columns
test = test[,keep_cols[,1]]
# Read the activity data for the test set, and join it to the activity descriptions
test_act = read.csv("test/y_test.txt", header=F)
test_act = inner_join(test_act, act_labels)
# Read in the subject data for the test set
test_subs = read.csv("test/subject_test.txt", header=F)
# Combine the activity, subject, and variables for the test set and add the variable
# names for the activity and subject variables we merged in.  The other variable names
# will be added in a later step from our "keepers" data frame.
test = cbind(test_act[,2], test_subs, test)
names(test)[1:2] = c("Activity", "Subject")

# Process the data in the train set.
train = read.csv("train/X_train.txt", sep="", header=F)
# Filter the columns in the train set by our list of "keeper" columns
train = train[,keep_cols[,1]]
# Read the activity data for the train set, and join it to the activity descriptions
train_act = read.csv("train/y_train.txt", header=F)
train_act = inner_join(train_act, act_labels)
# Read in the subject data for the train set
train_subs = read.csv("train/subject_train.txt", header=F)
# Combine the activity, subject, and variables for the train set and add the variable
# names for the activity and subject variables we merged in.  The other variable names
# will be added in a later step from our "keepers" data frame.
train = cbind(train_act[,2], train_subs, train)
names(train)[1:2] = c("Activity", "Subject")

# Now that all the data has been shaped appropriately, merge the test and train data sets
# together.
all = rbind(test, train)

# Apply the variable names to all of the quantitative variables from our "keeper" data frame
names(all)[-(1:2)] = keep_cols[,2]

# Use dplyr to summarize the completed data set by Activity and Subject as required
summary = all %>% 
  group_by(Activity, Subject) %>%
  summarise_each(funs(mean))

# Write the summary file to disk
write.csv(summary, file="summary.csv", row.names=F)
