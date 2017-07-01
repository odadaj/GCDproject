# R script called run_analysis.R that does the following.
##  1.Merges the training and the test sets to create one data set.
##  2.Extracts only the measurements on the mean and standard deviation for each measurement.
##  3.Uses descriptive activity names to name the activities in the data set
##  4.Appropriately labels the data set with descriptive variable names.
##  5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(data.table)
library(dplyr)

# The unzipnload function is used to download, extract the files.
unzipnload <- function() {
  zipurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  destfile <- "dataset.zip"
  if(!file.exists(destfile)){
    dwnload <- tryCatch(download.file(zipurl, destfile = destfile), error=function(e) 1) #Download zipped data sets. This function is called within MacOSX Sierra 10.12.5 (16F73). No need to define method type.
    if(dwnload ==1) return(print("File does not exist and could not be downloaded. Please check the URL or Connectivity"))
  }
  if(!file.exists("dataset")) unzip (destfile, overwrite = T, junkpaths = T, exdir = "dataset")
}

# The loadncombine function is used to read the files as data table.Function option used to determine whether test or training data
loadncombine <- function(x) {
  xfile <- paste("dataset/X_",x,".txt", sep = "")
  yfile <- paste("dataset/y_",x,".txt", sep = "")
  userfile <- paste("dataset/subject_",x,".txt", sep = "")
  xdata <- fread(xfile) # Read and load data into environment
  ydata <- fread(yfile) # Read and load the activity ID into environment
  userdata <- fread(userfile) # Read and load user ID into environment
  xtable <- cbind(userdata ,ydata, xdata) # combined output is returned
}

unzipnload()
traindata <- loadncombine("train") # Read and load training data
testdata <- loadncombine("test") # Read and load test data

alldata <- rbind(traindata, testdata) # The training and test data are merged row wise into an alldata object.

featurelist <- read.table("dataset/features.txt") # Reads the features text file to extract variable names
colnames(alldata) <- c("userid", "activityid", t(featurelist[2])) # Assign each column a variable name starting with Subject and Activity columns previously added

alldata <- subset(alldata, select = grep("id|mean|std", names(alldata))) #New table containing mean and standard deviation values

activitydata = fread('dataset/activity_labels.txt')
colnames(activitydata) <- c('activityid','activity')
alldata <- merge(activitydata, alldata, by='activityid') #merge tables to replace activity id with activity description from the activity labels file.

# Read column names and remove special characters
alldatacols <- colnames(alldata)
alldatacols <- gsub("[\\(\\)-]", "", alldatacols)
colnames(alldata) <- alldatacols

# Create a second, independent tidy data set with the average of each variable for each activity and each subject.
tidydata <- alldata %>% group_by(userid, activity) %>% summarise_each(funs(mean))
fwrite(tidydata, file = "tidydata.txt", row.names = F)
