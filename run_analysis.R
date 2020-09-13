# Script for Getting and Cleaning Data Week 4 Course Project

# Loading required packages

library(dplyr)

# Verifying if archive already exist inside environment and downloading it if it does not

if(!file.exists("dataset.zip")){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, "dataset.zip", method = "curl")
}

# Unzip dataset to environment

unzip(zipfile="dataset.zip")

# Reading features data

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))

# Reading activity labels data

activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

# Reading training tables

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

# Reading test tables

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")

# Merging the data in only one dataset

x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)
merged_data <- cbind(subject, y, x)

# Extracting the mean and stardard deviation for each measurement

tidydata <- merged_data %>% select(subject, code, contains("mean"), contains("std"))

# Using descriptive activity names to name activities

tidydata$code <- activities[tidydata$code, 2]

# Labeling the data set with descriptive variable names

names(tidydata)[2] = "activity"
names(tidydata)<-gsub("Acc", "accelerometer", names(tidydata))
names(tidydata)<-gsub("Gyro", "gyroscope", names(tidydata))
names(tidydata)<-gsub("BodyBody", "body", names(tidydata))
names(tidydata)<-gsub("Mag", "magnitude", names(tidydata))
names(tidydata)<-gsub("^t", "time", names(tidydata))
names(tidydata)<-gsub("^f", "frequency", names(tidydata))
names(tidydata)<-gsub("tBody", "timebody", names(tidydata))
names(tidydata)<-gsub("-mean()", "mean", names(tidydata), ignore.case = TRUE)
names(tidydata)<-gsub("-std()", "std", names(tidydata), ignore.case = TRUE)
names(tidydata)<-gsub("-freq()", "frequency", names(tidydata), ignore.case = TRUE)
names(tidydata)<-gsub("angle", "angle", names(tidydata))
names(tidydata)<-gsub("gravity", "gravity", names(tidydata))

# From the data set in step 6, a second independent and tidy data set with the average of each variable for each activity and each subject is created

finaldata <- tidydata %>% group_by(subject, activity) %>% summarise_all(funs(mean))
write.table(finaldata, "finaldata.txt", row.names = FALSE)
