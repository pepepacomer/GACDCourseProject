
#read training data
x_train <- read.table ("X_train.txt")
y_train <- read.table ("y_train.txt")
subject_train <- read.table ("subject_train.txt", sep=" ")

#read test data
x_test <- read.table ("X_test.txt")
y_test <- read.table ("y_test.txt", sep=" ")
subject_test <- read.table ("subject_test.txt", sep=" ")

#read features
features <- read.table ("features.txt", sep=" ")

#read activity labels
activity_labels <- read.table ("activity_labels.txt", sep=" ")

#----------------------------------------------------
# 1.- Merges the training and the test sets to create
#one data set.
#-----------------------------------------------------

#merge training data
train <- cbind(x_train, y_train, subject_train)

#merge test data
test <- cbind(x_test, y_test, subject_test)

#merge train and test data
data <- rbind (train, test)

colnames(data)[c(1:561)]<- as.character(features[,2])
colnames(data)[562] <- "Activity_ID"
colnames(data)[563] <- "Subject"

#----------------------------------------------------
# 2.- Extracts only the measurements on the mean and 
# standard deviation for each measurement. 
#-----------------------------------------------------

c_mean <- grep("mean()", features[,2])
c_std <- grep("std()", features[,2])
columns <- c(c_mean, c_std)
data_mean_std <- data[,c(columns, 562,563)]

#----------------------------------------------------
# 3.- Uses descriptive activity names to name the 
#activities in the data set
#-----------------------------------------------------

colnames(activity_labels)[1]<-"Activity_ID"
install.packages("plyr")
library(plyr)
data_merged <- join(data_mean_std, activity_labels,by="Activity_ID")

#----------------------------------------------------
# 4.- Appropriately labels the data set with 
# descriptive variable names. 
#-----------------------------------------------------

colnames(data_merged)[82] <- "Activity"
colnames_new <- sub("^f", "Freq", colnames(data_merged))
colnames_new <- sub("^t", "Time", colnames_new)
colnames_new <- gsub(",", "", colnames_new)
colnames_new <- gsub("-", "", colnames_new)
colnames_new <- gsub("()", "", colnames_new)
colnames_new <- gsub("\\(", "", colnames_new)
colnames_new <- gsub("\\)", "", colnames_new)
colnames_new <- gsub("Acc", "Acceleration", colnames_new)
colnames_new <- gsub("mean", "Mean", colnames_new)
colnames_new <- gsub("Acc", "Acceleration", colnames_new)
colnames_new <- gsub("energy", "Energy", colnames_new)
colnames_new <- gsub("mad", "MedianAbsDev", colnames_new)
colnames_new <- gsub("max", "Max", colnames_new)
colnames_new <- gsub("min", "Min", colnames_new)
colnames_new <- gsub("sma", "SignalMagArea", colnames_new)
colnames_new <- gsub("iqr", "InterQRange", colnames_new)
colnames_new <- gsub("entropy", "Entropy", colnames_new)
colnames_new <- gsub("arCoeff", "AutoregCoeff", colnames_new)
colnames_new <- gsub("correlation", "Correlation", colnames_new)
colnames(data_merged) <- colnames_new

#----------------------------------------------------
# 5.- Creates a second, independent tidy data set 
# with the average of each variable for each activity
# and each subject. 
#-----------------------------------------------------


average_data <-aggregate(data_merged, by=list(data_merged$Subject,data_merged$Activity),FUN=mean, na.rm=TRUE)
colnames(average_data)[1] <- "Subject"
colnames(average_data)[2] <- "Activity"
average_data <- average_data[ -c(564:566) ]

#Write tidy data set to file
write.table(average_data, file="average_data.txt", row.names = FALSE, sep = ",")


