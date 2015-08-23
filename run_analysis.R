# Getting and Cleaning Data Course Project

# You should create one R script called run_analysis.R that does the following. 

run_analysis <- function() {
    # 1. Merges the training and the test sets to create one data set. 
    # Note instructions: "[The code] can be run as long as the Samsung 
    # data is in your working directory."
    if (!file.exists("UCI HAR Dataset/")) 
        return("Error: Requires Samsung data in working directory.")
    trainingData <- cbind(
        read.table("./UCI HAR Dataset/train/X_train.txt"),
        read.table("./UCI HAR Dataset/train/y_train.txt"),
        read.table("./UCI HAR Dataset/train/subject_train.txt")
    ) 
    testData <- cbind(
        read.table("./UCI HAR Dataset/test/X_test.txt"),
        read.table("./UCI HAR Dataset/test/y_test.txt"),
        read.table("./UCI HAR Dataset/test/subject_test.txt")
    )
    # This imports our data, however the column name "V1" appears three times,
    # once from each read operations. We will rename them to avoid duplicates
    colnames(trainingData) <- seq(along=trainingData)
    colnames(testData) <- seq(along=testData)
    mergedData <- merge(trainingData, testData, all=TRUE)
    # This completes the requirement to merge the training and test data sets.
    # The merged data has 10299 observations, the sum of 2947 observations in
    # the test data and 7352 observations in the training data. 2947 + 7352 = 10299.

    
    # 2. Extracts only the measurements on the mean and standard deviation for 
    #    each measurement. 
    # Using the column names provided by the "features.txt" file in the data,
    # we will search for columns with "mean" or "std" in their name.
    featureList <- read.table("./UCI HAR Dataset/features.txt")
    meanList <- grep("mean", featureList$V2)
    stdList <- grep("std", featureList$V2)
    meanAndStdList <- append(meanlist, stdList)
    meanAndStandardDeviationData <- mergedData[,meanAndStdList]
    # This completes the requirement for extracting only the mean and standard
    # deviation for each measurement.
    

    # 3. Uses descriptive activity names to name the activities in the data set 
    # The activity names are defined in the file "activity_labels.txt". Each
    # activity is associated with a number represented in the "y" data files,
    # which appears as column 562. (We know this because X is made up of
    # 561 columns, y of 1 column and subject as the last column in the previous cbind)
    descriptiveActivity <- read.table("UCI HAR Dataset/activity_labels.txt")
    activityFactor <- factor(descriptiveActivity$V2)
    # This factor will be used to map activity numbers to their descriptions.
    mergedData[,562] <- as.character(activityFactor[mergedData[,562]])
    # This completes the requirement by replacing the activity number with
    # a descriptive name from the activity_labels.txt file.
    
    
    # 4. Appropriately labels the data set with descriptive variable names. 
    # We previously loaded in the descriptive column names for question 2.
    columnNames <- as.character(featureList[,2])
    # This creates descriptive names for the data from the "X" files.
    columnNames <- append(columnNames, "Activity")
    # This adds a descriptive name for the data from the "y" files.
    columnNames <- append(columnNames, "Subject")
    # This adds a descriptive name for the data from the "subject" files.
    colnames(mergedData) <- columnNames
    # This completes the requirement by replacing the numbered column names 
    # with descriptive names taken from the features.txt file
    
    # 5. From the data set in step 4, creates a second, independent tidy data set 
    #    with the average of each variable for each activity and each subject.
    library(reshape2)
    meltedMergedData <- melt(mergedData, id=c("Subject", "Activity"))
    # This prepares the merged, labeled data for dcasting
    tidyData <- dcast(meltedMergedData, Activity + Subject ~ variable, mean)
    # This creates a tidy data frame where each combination of activity + subject
    # is a row containing the mean of all other variables. The data is "tidy"
    # because each column contains a single measurement and each row contains
    # those measurements for unique activity and subject combinations.
}