GACDCourseProject
=================

(Getting and cleaning Data Course Project)

The data used in this project represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: 
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

In the project there is only one R script called "run_analysis.R".

The script reads 8 files:
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.
- 'train/subject_test.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.

Aftet reading the txt files, the script performs the following activities:
 
1.- Merges the training and the test sets to create one data set. (using cbind and rbind)

2.- Extracts only the measurements on the mean and standard deviation for each measurement. (using grep)

3.- Uses descriptive activity names to name the activities in the data set. (using join (plyr package))

4.- Appropriately labels the data set with descriptive variable names. (using sub and gsub)

5.- Creates a second, independent tidy data set with the average of each variable for each activity and each subject. (using aggregate and write.table)

The tidy data set is written to a file called "average_data.txt".

Finally, also a code book ("Code Book.pdf) is included to explain the final tidy data set: names of variables, a short explanation and the type of the variable.

