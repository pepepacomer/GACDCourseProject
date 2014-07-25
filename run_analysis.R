
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

#----------------------------------------------------
# 2.- Extracts only the measurements on the mean and 
# standard deviation for each measurement. 
#-----------------------------------------------------

c_mean <- grep("mean()", features[,2])
c_std <- grep("std()", features[,2])
columns <- c(c_mean, c_std)
data_mean_std <- data[,columns]

#----------------------------------------------------
# 3.- Uses descriptive activity names to name the 
#activities in the data set
#-----------------------------------------------------

colnames(data)[562]<-"activity_num"
colnames(activity_labels)[1]<-"activity_num"
install.packages("plyr")
library(plyr)
data_merged <- join(data, activity_labels,by="activity_num")

#----------------------------------------------------
# 4.- Appropriately labels the data set with 
# descriptive variable names. 
#-----------------------------------------------------

colnames(data_merged)[c(1:561)]<- as.character(features[,2])
colnames(data_merged)[562] <- "Activity_ID"
colnames(data_merged)[563] <- "Subject"
colnames(data_merged)[564] <- "Activity"
colnames_orig <- colnames(data_merged)
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


sum_DF <-aggregate(data_merged, by=list(data_merged$Subject,data_merged$Activity),FUN=mean, na.rm=TRUE)
colnames(sum_DF)[1] <- "Subject"
colnames(sum_DF)[2] <- "Activity"
sum_DF <- sum_DF[ -c(564:566) ]

#Write tidy data set to file
write.table(sum_DF, file="sum_DF.txt", row.names = FALSE, sep = ",")


