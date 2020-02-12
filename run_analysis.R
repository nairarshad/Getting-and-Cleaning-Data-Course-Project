### 1. Merges the training and the test sets to create one data set. 

## Data source: Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
## Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. 
## International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

## Load Libraries
list.of.packages <- c("data.table","plyr","dplyr","tibble")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)
lapply(list.of.packages, require, character.only = TRUE)

# DATA DOWNLOAD
# Create temporary file
temp <- tempfile()

# Download zip into temporary file
download.file(url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
              destfile = temp)

# Unzip the zip file
list.data <- unzip(temp)

# Unlink the temporary file
unlink(temp)

# DATA READ
# Read as datatable the tri-axial measurement data
list.data.table <- sapply(list.data[grep("Inertial Signals", list.data)], simplify = FALSE, fread)
names(list.data.table) <- gsub(".*\\Signals/(.*)\\..*","\\11",names(list.data.table))

# Read the training and testing data
training.data <- fread(list.data[grep("train/X_train", list.data)])
testing.data <- fread(list.data[grep("test/X_test", list.data)])

# Read the activity labels
training.data.labels <- scan(list.data[grep("train/y_train", list.data)])
testing.data.labels <- scan(list.data[grep("test/y_test", list.data)])

# Read the subject labels
training.data.subjects <- scan(list.data[grep("train/subject_", list.data)])
testing.data.subjects <- scan(list.data[grep("test/subject_", list.data)])

# Read the feature list
feature.cols <- fread(list.data[grep("features.txt", list.data)])
feature.cols.names <- feature.cols[[2]]

# Retain information about data type (train/test)
training.data$Type <- "Train"
testing.data$Type <- "Test"

# Add activity labels
training.data$ActivityLabel <- training.data.labels
testing.data$ActivityLabel <- testing.data.labels

# Add subject labels
training.data$Subject <- training.data.subjects
testing.data$Subject <- testing.data.subjects

# Row bind the test and train data
all.data <- bind_rows(training.data,testing.data)
colnames(all.data) <- c(feature.cols[[2]], "Type", "ActivityLabel", "Subject")

### 2. Extracts only the measurements on the mean and standard deviation for each measurement.

# Backup data
all.data.bc <- all.data

# Find column indices for mean measurements, standard deviation measurements, "Type", "ActivityLabel", and "Subject"
meancolnums <- grep("mean\\(\\)", names(all.data))
stdcolnums <- grep("std\\(\\)", names(all.data))
keycolnums <- grep("Type|ActivityLabel|Subject", names(all.data))
wantcolnums <- c(keycolnums,c(rbind(meancolnums, stdcolnums)))

# Subset data based on above conditions
all.data.stat <- all.data[, wantcolnums, with=FALSE]

### 3. Uses descriptive activity names to name the activities in the data set

# Factors for Activity Label and Subject
all.data.stat$ActivityLabel <- as.factor(all.data.stat$ActivityLabel)
all.data.stat$Subject <- as.factor(all.data.stat$Subject)

# Read and set the descriptive activity labels
activity.labels <- fread(list.data[grep("activity_labels", list.data)])
all.data.stat$ActivityLabel <- plyr::revalue(all.data.stat$ActivityLabel, tibble::deframe(activity.labels))

### 4. Appropriately labels the data set with descriptive variable names.

# Change to descriptive column names
colnames(all.data.stat) <- gsub("-mean\\(\\)","_Mean",colnames(all.data.stat))
colnames(all.data.stat) <- gsub("-std\\(\\)","_StandardDeviation",colnames(all.data.stat))
colnames(all.data.stat) <- gsub("Type","DataType",colnames(all.data.stat))

### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each 
### variable for each activity and each subject.

# Convert to tibble
all.data.stat.tbl <- tbl_df(all.data.stat[,-"DataType"])

# Group by each activity and each subject and take the means. Add prefix "MEAN_" to denote the same.
all.data.stat.tidy <- all.data.stat.tbl %>%
  group_by(ActivityLabel, Subject) %>%
  summarise_all(mean) %>%
  rename_at(vars(-c("ActivityLabel", "Subject")),function(x) paste0("MEAN_",x))

# Export the tidy table for upload
write.csv(all.data.stat.tidy, "tidy_data.txt", row.names=FALSE)
