#
# Getting and Cleaning Data 
# Course Project
#
# Requirements:
#   Create one R script called run_analysis.R that does the following. 
#     1) Merges the training and the test sets to create one data set.
#     2) Extracts only the measurements on the mean and standard deviation for 
#        each measurement. 
#     3) Uses descriptive activity names to name the activities in the data set
#     4) Appropriately labels the data set with descriptive variable names. 
#     5) From the data set in step 4, creates a second, independent tidy data set 
#        with the average of each variable for each activity and each subject.

#****************
#* Run analysis *
#****************
library(data.table)
library(reshape2)

projDir <- "./projectData"

sourceDataURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
sourceDataZIP <- "UCI HAR Dataset.zip"
sourceDataDir <- "./UCI HAR Dataset"

#******************
# Get Source Data *
#******************
# 0) Download source data into a local directory to begin the process
# 0.a - If the directory doesn't exist, then the data's not there either.
if (! projDir %in% list.dirs(".")) {
  print ("Creating project directory...")
  dir.create(projDir)
}

# 0.b - go to the project directory
basedir <- getwd() # Remember for later
print ("Moving to project directory")
setwd(projDir)
projBaseDir <- getwd()

# 0.c - download the source data if it's not already here
if (! sourceDataZIP %in% list.files()) {
  print ("Downloading project data")
  download.file(sourceDataURL,destfile=sourceDataZIP,method="curl",quiet=TRUE)
} else {
  print (" -- zip file already available...")
}

# 0.d - extract zip file
if (! sourceDataDir %in% list.dirs()) {
  print ("Unzipping project data...")
  unzip(sourceDataZIP)#, unzip="unzip")
} else {
  print (" -- zip file already un-zipped...")
}

# 0.e - move to the actual data directory
print ("Moving to project data directory")
setwd(sourceDataDir)

#*******************************************
# 1 - Merge the training and the test sets *
#*******************************************

# These functions are a refactoring of the read and merge code
pathify <- function(kind,basename) {
  sprintf("%s/%s_%s.txt", kind, basename, kind)
}
readAndMerge <- function(basename) {
  print(sprintf("Loading %s data...", basename))

  print(" - loading training data...")
  trainPath = pathify("train", basename)
  trainingData <- data.table(read.table(trainPath))

  print(" - loading test data...")
  testPath = pathify("test", basename)
  testData <- data.table(read.table(testPath))

  print(" - combining into one data set...")
  rbindlist(list(trainingData,testData))
}
print("Loading ALL Sample Data")
allData <- readAndMerge("X")
# allData now includes ALL of the data

#*************************************************
# 2 - Extracts only mean and standard deviations *
#*************************************************
# Read all the labels now that we're in the correct directory
features <- read.table("features.txt")
ourFeatures <- features[grepl("std()",features$V2,fixed=TRUE)|grepl("mean()",features$V2,fixed=TRUE),]

#**************************************
# 3 - Uses descriptive activity names *
#**************************************
activityLabels <- read.table("activity_labels.txt")

#************************************************
# 4 - Label the data set with descriptive names * 
#************************************************
print("Labeling the data")
setnames(allData,as.character(features$V2))
# 4.b Now that we have the names that match our selected features, filter out the unwanted data.
print("... and selecting our subset")
ourData <- subset(allData,select=ourFeatures$V2)

#***************************************************
# 5 - Create a tidy data set with the average each *
#     variable for each activity and each subject. *
#***************************************************
print ("Finalizing the tidy data")

# 5.a - Get subjects for each sample and join that into the data
print("Adding in subject and activity")
print(" - adding subjects")
allSubjects <- readAndMerge("subject")
ourData$Subject <- allSubjects$V1

# 5.b - Get activities for each sample and join that into the data
print (" - adding activities")
allActivities <- readAndMerge("y")
ourData$Activity <- activityLabels$V2[match(allActivities$V1, activityLabels$V1)]

# 5.c - Melt the data
print (" - melting to get something to work with")
melted<-melt(ourData,id=c("Subject","Activity"))
print (" - casting to our final shape")
tidy <- dcast(melted, Subject + Activity ~ variable, mean)

# 5.d - Clean up the column names a little bit
print (" - cleaning up column names (get rid of those icky '()'s")
names(tidy) <- gsub("()","",names(tidy),fixed=TRUE)

#**********************************************
# 6 - Please upload the tidy data set created *
#     in step 5 of the instructions.          *
#**********************************************
print("!!! WRITING OUTPUT")
print (c(" - Moving to project base directory", projBaseDir))
setwd(projBaseDir)
print("!!! Writing output file to tidy_data.txt")
write.table(tidy,"tidy_data.txt",row.name=FALSE)

# LAST) Go back to original directory
setwd(basedir)
print ("Returning to original directory")

#
# From course project page
#
# The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.  
# 
# One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 
#   
#   http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
# 
# Here are the data for the project: 
#   
#   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# 
# You should create one R script called run_analysis.R that does the following. 
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement. 
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# 
# Good luck!