# Getting-and-Cleaning-Data-Course-Project CodeBook

This codebook describes operations performed on the data to answer the
5 questions for this assignment.

This complements the codebook in the included data set which details
how the data was collected, the data files for training and test data,
and information on column names and definitions for subject activites.

1. Question 1 asks us to import and merge training and test data.
- For each folder we import files for X, y and subject oberservations.
- X contains 561 measurements per observation.
- y contains 1 measurement for the same operation.
- subject contains 1 measurement for the same operation.
- The number of operations for each set of three files is the same.
- A data frame for trainingDate is created by reading & binding columns from:
-   X_train.txt, y_train.txt, subject_train.txt
- A data frame for trainingDate is created by reading & binding columns from: 
-  X_test.txt, y_test.txt, subject_test.txt
- Because this creates duplicate columns named "V1" from each file, the columns are renamed as sequential numbers, a total of 561 + 1 + 1 = 563.
- These dataframes with renamed columns are then merged together.
- The resuting data frame is tidy because each column contains one type of data and each row contains the data points for a single oberservation.

2. Question 2 asks us to extract only the measurements on mean and standard deviation for each observation.
- The column names for each measurement are provided in the "features.txt" file.
- Using the grep() function, we create a list of columns containing the string "mean" and also columns containing the string "std".
- Appending these together provides our columns for mean and standard deviation.
- A new dataframe with just those columns is then created.

3. Question 3 asks us to use descriptive names for the activity in each oberservation, as represented in the "y" text file for testing and training data.
- Each item in the "y" files is a number from 1-6, corresponding to the table of 6 activities in the file "activity_labels.txt"
- A factor is created to map each of the descripte names to the numbers 1-6, the same as in the file. 
- This factor is used to replace the data in the y column (number 562, as described in question 1). This results in a merged dataset where descriptive activity names are used in place of their original numbers.

4. Question 4 asks us to replace the column names with descriptive variable names. 
- Using the variable names read in during question 2, a character vector is created from the second column of that table. 
- Since this only contains the names of the variables in the "X" files, two more names are appended. 
- For the "y" variable, "Activity" was chosen, and for the "subject" variable, "Subject.
- The column names are then replaced with this vector.

5. Question 5 asks us to create a second, independent tidy data set with the average of each variable for each activity and each subject.
- Using the melt and dcast functions from the reshape2 library, the previously created merged and labelled data is melted. 
- We identify Active and Subject as ID variables and the rest as measure variables.
- The dataset is then recast using dcast into a new dataframe showing Activity and Subject by the average of the other variables.
- We know this data is tidy because each variable forms a column, each observation forms a row, and the table is about one kind of obersavation (the accelerometer data for this project).
