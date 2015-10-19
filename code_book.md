# Code Book
The data used for this course project was downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip , which in turn was obtained from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
## Features
The features in the raw data are described in the features_info.txt file that is part of the source data. Please refer to that document for a description on how the raw data was derived.

From the testing and training data sets, features whose name is suffixed with -mean() or -std() were merged together into one data set. These features were renamed to make them more readable. Features suffixed with "-std()" are suffixed with "StdDev" and features suffixed with "-mean()" are suffixed with "Mean". 

That data set was then aggregated to calculate the average (mean) of each feature grouped by activity and participating subject. That cleaned data set is returned in a file named tidy_data.txt

## Activities
There were six activities returned as part of the data:
- Walking
- Walking Upstairs
- Walking Downstairs
- Sitting
- Standing
- Laying
