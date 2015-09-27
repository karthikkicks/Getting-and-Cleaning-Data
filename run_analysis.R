
library(dplyr)
#This sets up working directory
workDir <- 'C:\\Users\\LXA8793\\Desktop\\Learning\\Data Science\\R\\RStudio WD\\Solutions\\Course 3_Getting and Cleaning Data\\Project'
setwd(workDir)

#reading test data
body_acc_x_test <- read.table('.\\UCI HAR Dataset\\test\\Inertial Signals\\body_acc_x_test.txt')
body_acc_y_test <- read.table('.\\UCI HAR Dataset\\test\\Inertial Signals\\body_acc_y_test.txt')
body_acc_z_test <- read.table('.\\UCI HAR Dataset\\test\\Inertial Signals\\body_acc_z_test.txt')
body_gyro_x_test <- read.table('.\\UCI HAR Dataset\\test\\Inertial Signals\\body_gyro_x_test.txt')
body_gyro_y_test <- read.table('.\\UCI HAR Dataset\\test\\Inertial Signals\\body_gyro_y_test.txt')
body_gyro_z_test <- read.table('.\\UCI HAR Dataset\\test\\Inertial Signals\\body_gyro_z_test.txt')
total_acc_x_test <- read.table('.\\UCI HAR Dataset\\test\\Inertial Signals\\total_acc_x_test.txt')
total_acc_y_test <- read.table('.\\UCI HAR Dataset\\test\\Inertial Signals\\total_acc_y_test.txt')
total_acc_z_test <- read.table('.\\UCI HAR Dataset\\test\\Inertial Signals\\total_acc_z_test.txt')

subject_test <- read.table('.\\UCI HAR Dataset\\test\\subject_test.txt')
X_test <- read.table('.\\UCI HAR Dataset\\test\\X_test.txt')
y_test <- read.table('.\\UCI HAR Dataset\\test\\y_test.txt')

#reading train data
body_acc_x_train <- read.table('.\\UCI HAR Dataset\\train\\Inertial Signals\\body_acc_x_train.txt')
body_acc_y_train <- read.table('.\\UCI HAR Dataset\\train\\Inertial Signals\\body_acc_y_train.txt')
body_acc_z_train <- read.table('.\\UCI HAR Dataset\\train\\Inertial Signals\\body_acc_z_train.txt')
body_gyro_x_train <- read.table('.\\UCI HAR Dataset\\train\\Inertial Signals\\body_gyro_x_train.txt')
body_gyro_y_train <- read.table('.\\UCI HAR Dataset\\train\\Inertial Signals\\body_gyro_y_train.txt')
body_gyro_z_train <- read.table('.\\UCI HAR Dataset\\train\\Inertial Signals\\body_gyro_z_train.txt')
total_acc_x_train <- read.table('.\\UCI HAR Dataset\\train\\Inertial Signals\\total_acc_x_train.txt')
total_acc_y_train <- read.table('.\\UCI HAR Dataset\\train\\Inertial Signals\\total_acc_y_train.txt')
total_acc_z_train <- read.table('.\\UCI HAR Dataset\\train\\Inertial Signals\\total_acc_z_train.txt')

subject_train <- read.table('.\\UCI HAR Dataset\\train\\subject_train.txt')
X_train <- read.table('.\\UCI HAR Dataset\\train\\X_train.txt')
y_train <- read.table('.\\UCI HAR Dataset\\train\\y_train.txt')


#TASK1: Merges the training and the test sets to create one data set
body_acc_x <- bind_rows(body_acc_x_train, body_acc_x_test)
body_acc_y <- bind_rows(body_acc_y_train, body_acc_y_test)
body_acc_z <- bind_rows(body_acc_z_train, body_acc_z_test)
body_gyro_x <- bind_rows(body_gyro_x_train, body_gyro_x_test)
body_gyro_y <- bind_rows(body_gyro_y_train, body_gyro_y_test)
body_gyro_z <- bind_rows(body_gyro_z_train, body_gyro_z_test)
total_acc_x <- bind_rows(total_acc_x_train, total_acc_x_test)
total_acc_y <- bind_rows(total_acc_y_train, total_acc_y_test)
total_acc_z <- bind_rows(total_acc_z_train, total_acc_z_test)

subject <- bind_rows(subject_train, subject_test)
X <- bind_rows(X_train, X_test)
Y <- bind_rows(y_train, y_test)

#reading supporting info files
features <- read.table('.\\UCI HAR Dataset\\features.txt')
activity_labels <- read.table('.\\UCI HAR Dataset\\activity_labels.txt')

#TASK2: Extracts only the measurements on the mean and standard deviation for 
#       each measurement
features_MS <- filter(features, grepl("mean|std", V2))
features_MS <- filter(features_MS, !grepl("meanFreq", V2))
features_MS_V1 <- features_MS$V1
X_MS <- subset(X, select=features_MS_V1)

#TASK4: Appropriately labels the data set with descriptive variable names
colnames(X_MS) <- features_MS$V2


#TASK3: Uses descriptive activity names to name the activities in the data set

Y_descriptive <- inner_join(Y, activity_labels)
X_MS_descriptive <- cbind(activity=Y_descriptive$V2, X_MS)
X_MS_descriptive <- cbind(Subject=subject$V1, X_MS_descriptive)

#TASK5: From the data set in step 4, creates a second, independent tidy data set 
#       with the average of each variable for each activity and each subject

tidyData <- X_MS_descriptive %>%
                group_by(Subject, activity) %>%
                summarise_each(funs(mean))

write.table(tidyData, file='tidyData.txt', row.name=FALSE, col.names=TRUE)











