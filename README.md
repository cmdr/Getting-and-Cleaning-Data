Description of a solution to the Course Project
========================================================

The script perfoming the required tasks is given in "run_analysis.R" file.

Short help on the code
----------------------------

In the first part of the script, the relevant training and testing data is loaded into 
data frames. Below I present some short examples of the code.

```{r}
## Load training data
X_train <- read.table("X_train.txt")                 # X_train: 'data.frame': 7352 obs. of  561 variables
subject_train <- read.table("subject_train.txt")     # subject_train: 7352 obs. of 1 variable (subjects' number)
y_train <- read.table("y_train.txt")                 # y_train: 7352 obs. of 1 variable (training labels)
```

In the next step, the data regarding measurements, i.e., "X" features, is merged by rows.

```{r}
## Merge training & test data
X_merged <- rbind(X_train, X_test)
```

Then from data frame X_merged I only extract the measurements of the mean and standard deviation for each measurement: 

```{r}
## Extract the measurements of the mean and standard deviation for each measurement
X_merged_mean_std <- X_merged[, mean_std_vars]
```

where vector mean_std_vars points out the positions of measurements related to mean() and std(). Namely,

```{r}
## Create a vector of the positions of -mean() and -std() variables 
mean_std_vars <- c(c(1:6), c(41:46), c(81:86), c(121:126), c(161:166), c(201:202),
                  c(214:215), c(227:228), c(240:241), c(253:254), c(266:271),
                  c(345:350), c(424:429), c(503:504), c(516:517), c(529:530),
                  c(542:543) )
```

With the next similar steps, which can be investigated in "run_analysis.R" file
I created the variable "Merged_all_cols" that is the answer to points 1-4. 
That is, a data frame containing only the measurements on the mean and standard 
deviation for each measurement with descriptive names of the columns.

Tidy data set
----------------------------
The tidy data set was created with the help of the "aggregate" function.

```{r}
Tidy_mean_data <- aggregate(. ~ Activity + Subject, Merged_all_cols, mean)
```

Specifically, "Merged_all_cols" was aggregated with respect to "Activity" and "Subject" columns
and the "mean" function was applied to other columns.
The result, that is "Tidy_mean_data" data frame, was written to "tidy_data_set.txt" file.

In order to enable an easy visual inspection of the tidy data set I also produced a csv-file
"tidy_data_set.csv".


Codebook
----------------------------
* All physical data are dimensionless as the provided variables were already normalized.
* Variables names in "Merged_all_cols" data frame and in the tidy data set are a simple
transformation of the data provided with the original codebook. Concretely, the original
names were stripped off the dashes and parentheses characters so that the tidy data set
could have been written to a txt file. For example, the orignal variable "tBodyAcc-mean()-X"
was converted to "tBodyAccmeanX".




