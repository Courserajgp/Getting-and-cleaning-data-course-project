run_analysis <- function() {
          
     # Step 1. Merge the training and test data sets to create one data set
     train_data <- read.table("~/Coursera R/Getting and cleaning data/2nd try/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/X_train.txt")
     train_labels <- read.table("~/Coursera R/Getting and cleaning data/2nd try/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/Y_train.txt")
     train_subjects <- read.table("~/Coursera R/Getting and cleaning data/2nd try/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train/subject_train.txt")
     test_data <- read.table("~/Coursera R/Getting and cleaning data/2nd try/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/X_test.txt")
     test_labels <- read.table("~/Coursera R/Getting and cleaning data/2nd try/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/Y_test.txt")
     test_subjects <- read.table("~/Coursera R/Getting and cleaning data/2nd try/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test/subject_test.txt")
     
     all_data <- rbind(train_data, test_data)
     all_labels <- rbind(train_labels, test_labels)
     all_subjects <- rbind(train_subjects, test_subjects)
     colnames(all_subjects) <- c("subjectID")
     
     # Step 2. Extract only the measurements on the mean and SD for each measurement
          # The features vector contains 561 values for each time point, 
          # of which vector elements 1 to 6 are measurements on acceleration (means and SDs)
          # and vector elements 121:126 are measurements on angular velocity (means and SDs). 
          # All other "features" are discarded from the clean data set.
     nevek <- read.table("~/Coursera R/Getting and cleaning data/2nd try/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt")
     relevant_features <- nevek[c(1:6, 121:126),2]
     relevant_data <- all_data[,c(1:6, 121:126)]
     colnames(relevant_data) <- relevant_features
     
     # Step 3. Use descriptive activity names for activities in the data set
     activities <- read.table("~/Coursera R/Getting and cleaning data/2nd try/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/activity_labels.txt")
     colnames(activities) <- c("activitycode", "activitylabel")
          
     actla <- activities[1,1:2]
     actlb <- activities[2,1:2]
     actlc <- activities[3,1:2]
     actld <- activities[4,1:2]     
     actle <- activities[5,1:2]     
     actlf <- activities[6,1:2]     
     all_labels2 <- all_labels
     
     for (i in 1:10299){
          if(all_labels2[i,1] == actla[1,1]){all_labels2[i,2] <- actla[1,2]}
          if(all_labels2[i,1] == actlb[1,1]){all_labels2[i,2] <- actlb[1,2]}   
          if(all_labels2[i,1] == actlc[1,1]){all_labels2[i,2] <- actlc[1,2]}   
          if(all_labels2[i,1] == actld[1,1]){all_labels2[i,2] <- actld[1,2]}
          if(all_labels2[i,1] == actle[1,1]){all_labels2[i,2] <- actle[1,2]}   
          if(all_labels2[i,1] == actlf[1,1]){all_labels2[i,2] <- actlf[1,2]}
     }
     #   The above loop merges activity labels with descriptive activity names. 
     #   Doing it this way is a bit mechanistic but I could not secure it with the "merge" command. 
     
     
     # Step 4. Use descriptive variable names (completed already in step 2)
     descfenames <- c("AccXmean", "AccYmean", "AccZmean", "AccXstdev", "AccYstdev",
                   "AccZstdev", "GyroXmean", "GyroYmean", "GyroZmean", "GyroXstdev",
                   "GyroYstdev", "GyroZstdev")
     colnames(relevant_data) <- descfenames
     
     # Step 5. Create a second, independent tidy data set with the average of each variable 
     # for each activity and each subject 

     activityfactor <- as.factor(all_labels2[,2])
     subjectfactor <- as.factor(all_subjects[,1])
     combofactor <- interaction(activityfactor, subjectfactor, drop = FALSE, sep=", subject ID ")     
     splitdata <- split(relevant_data, combofactor, drop = FALSE)
     meanlist <- lapply(splitdata, colMeans)
     # filenamepart1 <- c("~/Coursera R/Getting and cleaning data/2nd try/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/")
     cleandata <- data.frame(NULL)
     
     
     for (j in 1:180){
          transj <- as.data.frame(meanlist[j])
          cleandata[j,1] <- names(meanlist[j])
          cleandata[j,2] <- transj[1,1]
          cleandata[j,3] <- transj[2,1]
          cleandata[j,4] <- transj[3,1]
          cleandata[j,5] <- transj[4,1]
          cleandata[j,6] <- transj[5,1]
          cleandata[j,7] <- transj[6,1]
          cleandata[j,8] <- transj[7,1]
          cleandata[j,9] <- transj[8,1]
          cleandata[j,10] <- transj[9,1]
          cleandata[j,11] <- transj[10,1]
          cleandata[j,12] <- transj[11,1]
          cleandata[j,13] <- transj[12,1]
     }

     colnames(cleandata) <- c("activityxsubject", rownames(as.data.frame(meanlist[1])))
     write.table(cleandata, "~/Coursera R/Getting and cleaning data/2nd try/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/cleandata.txt" )
     
     print("Average of the mean and SD measurements on the relevant variables  
      has been calculated for each activity in each subject, and the results have been saved to cleandata.txt")
}
