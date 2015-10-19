# set the working directory to the UCI HAR Dataset folder. Will be reverted at the end.
oldwd <- getwd()
setwd("UCI HAR Dataset")

# load and merge the data from the testing and training data sets
## load the test data, then append columns for the test labels and subject
testData <- read.table("test/X_test.txt") 
testData[,562] <- read.table("test/Y_test.txt") 
testData[,563] <- read.table("test/subject_test.txt") 

## load the training data, then append columns for the training labels and subject
trainData <- read.table("train/X_train.txt") 
trainData[,562] <- read.table("train/Y_train.txt") 
trainData[,563] <- read.table("train/subject_train.txt") 

## Merge two sets together by rows
mergedData <- rbind(testData, trainData) 

# Determine which columns (features) to retain
## Read the features and make the feature names better suited for R with some substitutions 
features <- read.table("features.txt") 

## Extracts only the measurements on the mean and standard deviation for each measurement
columns <- grep("\\Qmean()\\E.*|\\Qstd()\\E.*", features[,2])

## Reduce the features table to what we want 
features <- features[columns,] 

## Reduce the merged data to the columns we want, plus the activity and subject
mergedData <- mergedData[,c(columns, 562, 563)] 

## Add the activity and subject column names, with a bit of cleaning 
colnames(mergedData) <- c(gsub("\\Q()\\E", "", 
                               gsub("\\Qstd()\\E", "StdDev", 
                                    gsub("\\Qmean()\\E", "Mean", features$V2)))
                          , "activity"
                          , "subject")

## load the labels for the activities
activities <- read.table("activity_labels.txt") 

## set the activity names
mergedData$activity <- activities[mergedData$activity, 2]

# aggregate the data (ignoring activity and subject columns)
tidyData = aggregate(mergedData[,1:66], 
                 by=list(activity = mergedData$activity, 
                         subject=mergedData$subject), 
                 mean) 

# revert the working directory and write the file
setwd(oldwd)
write.table(tidyData, "tidy_data.txt", sep="\t", row.name=FALSE) 