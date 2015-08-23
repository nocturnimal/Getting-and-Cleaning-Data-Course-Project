# Getting-and-Cleaning-Data-Course-Project

This project involved creating the run_analysis.R script to answer
5 questions:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. ppropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

This script requires the dataset at the following URL be downloaded and
unzipped to the working direcctory:
<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

To run the script:

'''
source("run_analysis.R")
run_analysis()
'''

Comments in the script describe how each question is answered.
Comments also indicate where descriptive names for rows and 
activities come from, while the CodeBook.md file provides
additional detail on the data provided, how it relates, and how
it is processed in order to answer the project questions.

For this project the dataframe for question 5 is uplaoded. 
It is named tidyData and exported for upload as follows:

'''
write.table(tidyData, file="tidyData.txt", row.name=FALSE)
'''

The resulting data is "Tidy" because it meets the requirements of
a tidy data frame:

1. Each variable measured is given one column.
2. Each different obeservation of that variable is in a different row. For question 5 there is one row for each Subject + Activity combination.
3. There is only one table for this "kind" of data.

