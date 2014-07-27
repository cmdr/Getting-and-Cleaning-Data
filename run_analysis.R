## Course Project, Getting and Cleaning Data 
## This script contains code for steps 1-5

## Load training data
X_train <- read.table("X_train.txt")                 # X_train: 'data.frame': 7352 obs. of  561 variables
subject_train <- read.table("subject_train.txt")     # subject_train: 7352 obs. of 1 variable (subjects' number)
y_train <- read.table("y_train.txt")                 # y_train: 7352 obs. of 1 variable (training labels)

## Load test data
X_test <- read.table("X_test.txt")                   # X_test: 'data.frame': 2947 obs. of  561 variables
subject_test <- read.table("subject_test.txt")       # subject_test: 2947 obs. of 1 variable (subjects' number)
y_test <- read.table("y_test.txt")                   # y_test: 2947 obs. of  1 variable (test labels)

## Merge training & test data
X_merged <- rbind(X_train, X_test)
## Create a vector of the positions of -mean() and -std() variables 
mean_std_vars <- c(c(1:6), c(41:46), c(81:86), c(121:126), c(161:166), c(201:202),
                  c(214:215), c(227:228), c(240:241), c(253:254), c(266:271),
                  c(345:350), c(424:429), c(503:504), c(516:517), c(529:530),
                  c(542:543) )

## Extract the measurements of the mean and standard deviation for each measurement
X_merged_mean_std <- X_merged[, mean_std_vars]
## Add descriptive columns' names
features <- read.table("features.txt", sep=" ")                       ## Load the features' descriptions from features.txt
features_relevant <- as.character(features$V2)[mean_std_vars]         ## Extract the relevant names (for extracted measurements)
new_features_relevant <- gsub("[[:punct:]]", "", features_relevant)   ## Remove dashes and parentheses from the names 
colnames(X_merged_mean_std) <- new_features_relevant                  ## Add descriptive columns' names

## Merge columns showing activities (first 'train' then 'test', as for X_merged)
y_merged <- rbind(y_train, y_test)
## Rename the only column of y_merged; colnames(y_merged) <- c("Activity")
descriptive_act_name = function(x) {
      if (x == 1) {return("Walking")
      }else if (x == 2) {return("Walking_upstairs")
      }else if (x == 3) {return("Walking_downstairs")
      }else if (x == 4) {return("Sitting")
      }else if (x == 5) {return("Standing")
      }else if (x == 6) {return("Laying") }
}

## Apply the above function to activities' numeric codes in y_merged
y_merged_descriptive <- sapply(y_merged$V1, descriptive_act_name)

## Merge columns showing subjects (first 'train' then 'test', as for X_merged)
subject_merged <- rbind(subject_train, subject_test)
## Rename the only column of subject_merged
colnames(subject_merged) <- c("Subject")

## Add to X_merged_mean_std columns showing activity and subject
Merged_all_cols <- cbind(subject_merged, cbind(y_merged_descriptive, X_merged_mean_std) )
## Renaming the second column
colnames(Merged_all_cols)[2] <- "Activity" 

########## Final result of points 1-4 ##########
Merged_all_cols
################################################


########## 5. Tidy data set
## Aggregate Merged_all_cols by Activity and Subject
Tidy_mean_data <- aggregate(. ~ Activity + Subject, Merged_all_cols, mean)

## Write the tidy data set to "tidy_data_set.txt" file
write.table(Tidy_mean_data, "tidy_data_set.txt")

## For the sake of a visual inspection of the tidy data set I also write csv-file
## Write the tidy data set to "tidy_data_set.csv" file
write.csv(Tidy_mean_data, "tidy_data_set.csv")
## Read and check the tidy data
test_tidy_data <- read.csv("tidy_data_set.csv")















