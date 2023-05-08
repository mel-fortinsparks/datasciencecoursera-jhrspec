# Getting and Cleaning Data Project
# The purpose of this project is to demonstrate your ability to collect, 
# work with, and clean a data set.

### Tasks
# 1. You create one R script called run_analysis.R that does the following.
# Complete, this is that R script.
# 2. Merges the training and the test sets to create one data set.
# 3. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 4. Uses descriptive activity names to name the activities in the data set
# 5. Appropriately labels the data set with descriptive variable names. 
# 6. From the data set in step 4, creates a second, independent tidy data set with 
# the average of each variable for each activity and each subject.


#Import zip file from url
packages <- c("data.table", "reshape2")
sapply(packages, require, character.only=TRUE, quietly=TRUE)
path <- getwd()
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", file.path(path, "dataFiles.zip"))
unzip(zipfile = "dataFiles.zip")

# --- Task #3; load activity labels + features
activityLabels <- fread(file.path(path, "UCI HAR Dataset/activity_labels.txt"), col.names = c("classLabels", "activityName"))
features <- fread(file.path(path, "UCI HAR Dataset/features.txt"), col.names = c("index", "featureNames"))
featuresWanted <- grep("(mean|std)\\(\\)", features[, featureNames])
measurements <- features[featuresWanted, featureNames]
measurements <- gsub('[()]', '', measurements)

# Load train data set
train <- fread(file.path(path, "UCI HAR Dataset/train/X_train.txt"))[, featuresWanted, with = FALSE]
# --- Task #4 (train data)
data.table::setnames(train, colnames(train), measurements)
trainActivities <- fread(file.path(path, "UCI HAR Dataset/train/Y_train.txt"), col.names = c("Activity"))
trainSubjects <- fread(file.path(path, "UCI HAR Dataset/train/subject_train.txt"), col.names = c("SubjectNum"))
# All together now
train <- cbind(trainSubjects, trainActivities, train)

# Load test data set
test <- fread(file.path(path, "UCI HAR Dataset/test/X_test.txt"))[, featuresWanted, with = FALSE]
# --- Task #4 (test data)
data.table::setnames(test, colnames(test), measurements)
testActivities <- fread(file.path(path, "UCI HAR Dataset/test/Y_test.txt"), col.names = c("Activity"))
testSubjects <- fread(file.path(path, "UCI HAR Dataset/test/subject_test.txt"), col.names = c("SubjectNum"))
# Combine
test <- cbind(testSubjects, testActivities, test)

# --- Task #2; finally, merge the two train and test data together
dataset.p <- rbind(train, test)

# --- Task #5; convert classLabels to activityName
dataset.p[["Activity"]] <- factor(dataset.p[, Activity], levels = activityLabels[["classLabels"]], labels = activityLabels[["activityName"]])
dataset.p[["SubjectNum"]] <- as.factor(dataset.p[, SubjectNum])
dataset.p <- reshape2::melt(data = dataset.p, id = c("SubjectNum", "Activity"))
dataset.p <- reshape2::dcast(data = dataset.p, SubjectNum + Activity ~ variable, fun.aggregate = mean)

# --- Task #6; create second data set (for submission)
data.table::fwrite(x = dataset.p, file = "tidyData.txt", quote = FALSE)
