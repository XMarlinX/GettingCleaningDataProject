# Course Project
# Getting & Cleaning Data
#
#
#Procedure
#Download ZIP files from site listed in assignment
#Read TXT files into dataframes
#Combine related data frames to single dataframes
#Merge all dataframes into one dataframe holding all data
#Assign meaningful identifiers to variables
#Extract variables with mean and STD in identifier
#Create a tidy dataset
#Display data
#
#
# ZIP files were downloaded from:
#
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR
# %20Dataset.zip
## The zip files were unzipped into .TXT files.
#
#load library dplyr
library(dplyr)
#Read TXT files into dataframes
Features <- read.table("features.txt")
Activity <- read.table("activity_labels.txt")
SubjectsTest  <- read.table("subject_test.txt")
SubjectsTrain   <- read.table("subject_train.txt")
XTrain <- read.table("X_train.txt")
YTrain <- read.table("Y_train.txt")
XTest <- read.table("X_test.txt")
YTest <- read.table("Y_test.txt")
#
#
#Assign meaningful names to columns
colnames(Features) <- c ("FeatureID", "Feature")
colnames(XTrain) <- Features$Feature
colnames(XTest) <- Features$Feature
colnames(YTrain) <- "ActivityID"
colnames(YTest) <- "ActivityID"
colnames (SubjectsTrain)  <- "SubjectID"
colnames(SubjectsTest) <- "SubjectID"
colnames(Activity) <- c ("ActivityID", "ActivityType")
#
#
# Combine Train and Test Data into separate data frames
TotalTrainingData<- cbind(YTrain, SubjectsTrain, XTrain)
TotalTestData <- cbind(YTest, SubjectsTest, XTest)
#
#
#Combine Training and Test Dataframes
AllData <- rbind(TotalTrainingData, TotalTestData)
#
#
#Extract Variables with Means and STD
MeanSTDData <- (grepl("ActivityID", Measurements) | grepl("SubjectID", Measurements) | grepl("mean", Measurements) | grepl("STD", Measurements))
MeanSTDData <- AllData [,MeanSTDData == TRUE]
#
#
# Rename variables to enhance understanding
names(MeanSTDData) <- gsub("Acc", "Accelerometer", names (MeanSTDData))
names(MeanSTDData) <- gsub("Gyro", "Gyroscope", names (MeanSTDData))
names(MeanSTDData) <- gsub("Mag", "Magnitude", names (MeanSTDData))
names(MeanSTDData) <- gsub("-mean()", "Mean", names (MeanSTDData))
names(MeanSTDData) <- gsub("-std()", "StandardDeviation", names (MeanSTDData))
names(MeanSTDData) <- gsub("-freq()", "Frequency", names (MeanSTDData))
names(MeanSTDData) <- gsub("gravity", "Gravity", names (MeanSTDData))


#
#Display results
names(MeanSTDData)
str(MeanSTDData)
head(MeanSTDData)
tail(MeanSTDData)
#
#
#Print data to file
write.csv (MeanSTDData, "TidyData.csv")

