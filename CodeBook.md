---
title: "CodeBook.md"
output: html_document
---

# Code book for the "Getting and cleaning data" course project by JGP
*****

## Original dataset

The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). The original dataset was downloaded from the following link:   
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

The structure of the source dataset is described in the README.txt file which is part of the above referred zip package. 

The aim of data processing is:  
1. to merge the training and the test datasets  
2. to extract only the measurements on the mean and standard deviation for each measurement  
3. to add descriptive activity names to name the activities in the data set  
4. to add descriptive variable names to name the relevant measurements in the data set  
5. to create a second, independent tidy data set with the average of each variable for each activity and each subject.  

*****
## Data processing steps

The source dataset must be saved to the R working directory and must be unzipped.
Once the source files have been unzipped, the run_analysis.R script should be initiated. This script executes the following data processing steps:

##### 1. Reads the following files into the following R data frames:  
   X_train.txt -> train_data (7352 observations of 561 variables, in "train subjects" performing different activities)  
   Y_train.txt -> train_labels (7352 observations of 1 variable, describing the activity codes along the 7352 "train" observations)  
   subject_train.txt -> train_subjects (7352 observations of 1 variable, describing the subject codes along the 7352 "train" observations)   
   X_test.txt -> test_data (2947 observations of 561 variables, in "test subjects" performing different activities)  
   Y_test.txt -> test_labels (2947 observations of 1 variable, describing the activity codes along the 2947 "test" observations)  
   subject_test.txt -> test_subjects (2947 observations of 1 variable, describing the subject codes along the 2947 "test" observations)   
      
      
##### 2. Pools the train and test datasets:   
   all_data = train_data and test_data in a common dataframe (10299 observations of 561 variables altogether)  
   all_labels = train_labels and test_labels in a common dataframe (activity codes for the 10299 observations altogether)    
   all_subjects = train_subjects and test_subjects in a common dataframe (subject codes for the 10299 observations altogether), column name set to "subjectID".    
           
##### 3. Extracts the 3-dimensional mean and standard deviation measurements from the 561 parameters per observation:

The features vector contains 561 values for each time point. In this step, it was assumed that the relevant measurements are vector elements 1 to 6 (mean and standard deviation vaues of linear acceleration) and vector elements 121:126 (mean and standard deviation vaues of angular velocity). Accordingly, all other "features" are considered to be of secondary relevance and discarded from the dataset in this step.The extracted subset of the dataframe "all_data" is saved to a new dataframe called "relevant_data".   
   
##### 4. Adds a second column to all_labels with descriptive activity names for all of the 10299 observations:

The descriptive activity names (the new column values) were matched to the numeric activity codes originally present in all_labels column 1? based on the information of activity_labels.txt (part of the original dataset)

##### 5. Adds descriptive column names to the 12 relevant measurements in all_data:

     measured value                         | original column name    | new, descriptive column name
     ---------------------------------------|-------------------------|-----------------------------
     
     linear acceleration, X dimension, mean | tBodyAcc-mean()-X       |AccXmean
     linear acceleration, Y dimension, mean | tBodyAcc-mean()-Y       |AccYmean
     linear acceleration, Z dimension, mean | tBodyAcc-mean()-Z       |AccZmean
     linear acceleration, X dimension, SD   | tBodyAcc-std()-X        |AccXstdev
     linear acceleration, Y dimension, SD   | tBodyAcc-std()-Y        |AccYstdev
     linear acceleration, Z dimension, SD   | tBodyAcc-std()-Z        |AccZstdev
     angular velocity, X dimension, mean    | tBodyGyro-mean()-X      |GyroXmean
     angular velocity, Y dimension, mean    | tBodyGyro-mean()-Y      |GyroYmean
     angular velocity, Z dimension, mean    | tBodyGyro-mean()-Z      |GyroZmean
     angular velocity, X dimension, SD      | tBodyGyro-std()-X       |GyroXstdev
     angular velocity, Y dimension, SD      | tBodyGyro-std()-Y       |GyroYstdev
     angular velocity, Z dimension, SD      | tBodyGyro-std()-Z       |GyroZstdev    
     
##### 6. Splits the full dataset of all_data to dataframes per activity per subject:  
     
The full dataset in all_data contains data on all subjects performing different activities. In this step, a list of 180 dataframes is created from all_data, each new data frame specific to a particular subject and a particular activity (30 subjects x 6 activities = 180 combinations). 

##### 7. Calculates the means of the 12 relevant parameters for all 180 subject x activity specific data frames

##### 8. Collects the 12 column means from all 180 subject x activity specific data frames into a final result dataframe called "cleandata"

cleandata is a data frame of 180 rows and 13 columns. Column 1 codes the subject ID and activity, with descriptive values e.g. "LAYING, subject ID 1", or "WALKING_UPSTAIRS, subject ID 13". Columns 2-13 contain the mean values of al observations of the 12 relevant parameters (listed in step 5, see also the column names of cleandata) for the particular subject x activity combination. 
   
##### 9. Writes cleandata to a txt file in the unzipped UCI HAR Ddataset folder. 


## Cleaned data

The cleaned data is saved to cleandata.txt into the unzipped UCI HAR Ddataset folder. 
For details of data structure and labels, please see Data processing step 8 above. 
                   
                    
                           
                           
This is an R Markdown document. Markdown is a simple formatting syntax for authoring HTML, PDF, and MS Word documents. For more details on using R Markdown see <http://rmarkdown.rstudio.com>.

