## GCDproject
### Getting and Cleaning Data Course Project
The purpose of this project is to demonstrate ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 
The script is used to transform the data downloaded from [here]
(https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

#### Data set information
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.  
For each record provided:
1. Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
2. Triaxial Angular velocity from the gyroscope. 
3. A 561-feature vector with time and frequency domain variables. 
4. Its activity label. 
5. An identifier of the subject who carried out the experiment.

### Steps. 
1. The unzipnload function is used to download, extract and load the files into the R environment. 
  zipurl points to the data set url  
  destfile is the name which the downloaded zip file will be saved as.
2. The loadncombine function is used to read the files as data table. Function option used to determine whether test or training data  
The following files are read and combined to form a single table
  * X_train.txt
  * y_train.txt
  * subject_train.txt
  * X_test.txt
  * y_test.txt
  * subject_test.txt  
  The following variables are defined in this step:
  * xfile used to set name for either X test or train files
  * yfile used to set name for either y test or train files
  * userfile used to set name for either subject test or train files
  * xdata table data set for X values of test or train file reads
  * ydata table data set for y values of test or train file reads
  * userdata table data set of subject values for test or train file reads
  * xtable combined table data set for either the test or train reads above
  * alldata The combined table data set for both test and train values

3. The features.txt file is read and used to assign column names to the merged data set.
  * featurelist table dataset of reads from the features text file used as variable names

4. Subset of data set is extracted to create new data set with mean and standard deviation values.
  * alldata table data sub set containing mean and standard deviation values

5. activity_labels.txt is read and values used to merge with data set in order to provide a clearer description for each activity.
  * activitydata = table data set of activity file reads

6. Special characters are removed from column names to make sure the variables are in a tidy format.
  * alldatacols data set of column names used to remove special characters

7.  A new tidy data set with the average of each variable for each activity and each subject is extracted and saved as tidydata.txt
  * tidydata data set of mean of each activity grouped by userid and activity.
