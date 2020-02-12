# Code book

## VARIABLES IN run_analysis.R

1. **activity.labels**: Links the class labels with their activity name.
2. **all.data**: Merged training and testing data.
3. **all.data.bc**: Backup of the above
4. **all.data.stat**: Subset of all.data with only mean measurements and standard deviation measurements.
5. **all.data.stat.tbl**: all.data.stat as a tibble.
6. **all.data.stat.tidy**: all.data.stat.tbl grouped by each activity and each subject and averaged w.r.t the grouping.
7. **feature.cols**: Links the feature labels (i.e. column indices) with their feature name.
8. **feature.cols.names**: List of all features.
9. **keycolnums**: Key columns of "Type" (Train/Test), ActivityLabel (one of activity.labels), and Subject (the subject who performed the activity for each window sample).
10. **list.data**: list of sub-files in the unzipped directory of the data.
11. **list.of.packages**: list of packages for installing (if not installed) and required loading.
12. **meancolnums**: column indices corresponding to mean measurements.
13. **new.packages**: list of list.of.packages that have not yet been installed.
14. **stdcolnums**: column indices corresponding to standard deviation measurements.
15. **temp**: temporary file holder for the zip data.
16. **testing.data**: Test set.
17. **testing.data.labels**: Test labels.
18. **testing.data.subjects**: Each row identifies the subject who performed the activity for each window sample in the test set. Its range is from 1 to 30.
19. **training.data**: Training set.
20. **training.data.labels**: Training labels.
21. **training.data.subjects**: Each row identifies the subject who performed the activity for each window sample in the training set. Its range is from 1 to 30.
22. **wantcolnums**: Combined list of keycolnums, meancolnums, and stdcolnums.

## VARIABLES in the data & their UNITS

From the zip file:
"The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation"

* Variables containing "Acc" and not "Jerk" and not the prefix "f" are acceleration in the units of m s<sup>-2</sup>.
* Variables containing "Gyro" and not "Jerk" and not the prefix "f" are angular velocity in the units of radians s<sup>-1</sup>.
* Variable containing "Acc" and "Jerk" and not the prefix "f"  are jerk in the units of m s<sup>-3</sup>.
* Variables containing "Gyro" and "Jerk" and not the prefix "f" are angular velocity in the units of radians s<sup>-2</sup>.
* Variables containing the prefix "f" are FFTs of the corresponding variable in the units of Hz.

## DATA

From http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones:
"The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain."

## TRANSFORMATIONS & DATA-CLEANING
1. Binding the test and training data.
2. Adding "Type" (Train/Test), "ActivityLabel" (Numeric label of activity), "Subject" (numeric Subject ID) to the above data set.
3. Subsetting above data set by selecting columns for "Type", "ActivityLabel", "Subject", the mean measurements, and the standard deviation measurements.
4. Converting "ActivityLabel" and "Subject" to factors in the data set.
5. Replacing numeric ActivityLabels with their corresponding Descriptive Labels.
6. Changing to descriptive column names in the data set.
7. Convertin data set into tibble for chaining operations.
8. Chaining operation of group_by(ActivityLabel, Subject) and summarise_all(mean) and renaming columns to have the prefix "MEAN_" to denote these are averaged values.
