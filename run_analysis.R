# Course Project
# Getting & Cleaning Data
#
#
#Procedure
#Download ZIP files from site listed in 
#Unzip compressed files
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
#Read TXT files into dataframes
Features <- read.table("features.txt", col.names = c ("n", "functions"))
Activity <- read.table("activity_labels.txt", col.names = c ("Code", "Activity"))
SubjectsTrain  <- read.table("subject_test.txt")
SubjectsTest   <- read.table("subject_train.txt")
XTrain <- read.table("X_train.txt")
YTrain <- read.table("Y_train.txt")
XTest <- read.table("X_test.txt")
YTest <- read.table("Y_test.txt")
#
#
#Assign meaningful names to columns
colnames(XTrain) <- Features[,2]
colnames(XTest) <- Features[,2]
colnames(YTrain) <- "ActivityID"
colnames(YTest) <- "ActivityID"
colnames (SubjectsTrain)  <- "SubjectID"
colnames(SubjectsTest) <- "SubjectID"
colnames(Activity) <- c ("ActivityID", "ActivityType")
#
#
# Combine Train and Test Data
TotalTrainData <- cbind(XTrain, YTrain)
TotalTestData <- cbind(XTest, YTest)
#
#Combine Train and Test Data
TotalData <- c(TotalTestData, TotalTrainData)
#
#
#Combine Subjects Data
AllSubjects <- c (SubjectsTest, SubjectsTrain)
#
#
#Combine All Dataframes
AllData <- cbind(AllSubjects, TotalData)
#
#
#Extract Means and STD
MeanSTDData <- AllData %>% select (Subject, Code, contains ("Mean"), contains("STD"))
#
#
# Rename variables to enhance understanding
names(MeanSTData)  <- gsub("Acc", "Accelerometer", names (MeanSTDData))
names(MeanSTDData) <- gsub("Gyro", "Gyroscope", names (MeanSTDData))
names(MeanSTDData) <- gsub("Mag", "Magnitude", names (MeanSTDData))
names(MeanSTDData) <- gsub("-mean()", "Mean", names (MeanSTDData))
names(MeanSTDData) <- gsub("-std()", "StandardDeviation", names (MeanSTDData))
names(MeanSTDData) <- gsub("-freq()", "Frequency", names (MeanSTDData))
names(MeanSTDData) <- gsub("gravity", "Gravity", names (MeanSTDData))
#
#
#Display results
names(MeanSTDData)
str(MeanSTDData)
head(MeanSTDData)
tail(MeanSTDData)
