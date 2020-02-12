# README: Getting-and-Cleaning-Data-Course-Project
Readme for the Course Project for Getting and Cleaning Data

There are three files in this repository:
1. This README
2. Codebook.md: explaining the variables in 3.
3. run_analysis.R: the R script for the goal of this course project

# run_analysis.R: A description

This script does the following:
* Lines 07:11 install and loads the required packages.
* Lines 13:25 download the required data and unzips it.
* Lines 27:62 merge the training and the test sets to create one data set.
* Lines 64:76 extract only the measurements on the mean and standard deviation for each measurement.
* Lines 78:86 name the activities in the data set using descriptive activity names. 
* Lines 88:93 appropriately label the data set with descriptive variable names.
* Lines 93:105 create a second, independent tidy data set with the average of each variable for each activity and each subject.
* Line 108: exports the tidy data set as a .txt file for upload.
