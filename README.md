# Course Project - Getting and Cleaning Data

## Script overview

The script can be found in `run_analysis.R`. If you source this file, via

```[R]
source("run_analysis.R")
```

it will immediately run and generate, in the project directory, the file `tidy_data.txt`.

The tidy data consists of 180 rows of data with 68 columns, one row for each of the 30 subjects 6 distinct activities (30*6=180) with the 2 columns describing the subject and activity and 66 columns with the sample data.

## What the script does

The script runs in phases that manipulate the data in clear steps; the code and comments in the code match these phases.

### 0 - Acquire the data

The script begins by ensure that we have a project directory to work in AND that the raw data is available.

This phase is on lines 21-61, and at the end of this phase all of the raw data files are available in the working directory.

### 1 - Merge the training and test data

Now that the data is available, the script loads the data and creates a merged version of the raw data. Data tables (via the `data.table` package) are used, and the `rbindlist()` function does the merging for us. Because the loading and merge operation is repeated, a helper function or two are defined for this purpose (`readAndMerge()`, lines 68-84).

This phase is on lines 63-87, and at the end of this phase all of the raw data is available in the `allData` data table.

### 2 - Extract only the mean and standard deviation columns

The data in the `allData` table is rather anonymous at the moment - the column names are V1, V2, ... V561. Later we'll give them better names; this phase will set all of that up.

We load the feature names from the `features.txt` file in the raw data, and restrict it to the columns that represent the mean and standard deviations. These are those columns with "mean()" or "std()" in the names. `grepl()` is used to return a logical that we can union to get the joined list in the same order as in the raw data.

This phase is on lines 89-94, and at the end the data frame features has all of the feature names and `ourFeatures` has the features we care about. This table has 2 columns - a number and a name. We'll use this later to assign useful names to the allData table.

### 3 - Descriptive activity names

This is a quick phase that reads in the activity labels. We'll use this later to map between the activity data and the name of the activity.

This is on lines 96-99, and at the end the activityLabels data frame contains the activity names associated with the activity values that we'll load in during phase 5.

### 4 - Label the data with descriptive names

This phase replaces the V1, ..., V561 currently as the column names of allData with the useful names we loaded in phase 2. The `setnames()` function is used because it's a little more efficient than just setting the names (via `names(allData)<-`); see line 105.

This phase is on lines 101-108, and at the end of this phase we have both useful names for the columns and we have subsetted allData with the columns we want via:

```[R]
ourData <- subset(allData,select=ourFeatures$V2)
```

### 5 - Create the tidy data set

This phase involves 2 things:

1. Add in the subject and activity columns
1. Summarize the samples into their means

#### Adding in the subject and activity columns

The data for both of these columns are hiding in the test and training directories in the raw data, in the files "test/subject_test.txt" and "test/y_test.txt" respectively (and similarly in the training data). We load these files using our helper function `readAndMerge()` that we defined earlier.

The subjects are numbers in both the raw data and our tidy data, but the activity column is converted from a number (in the raw data) into a string from the activityLabels (from phase 3) in this step. This is done using the `match()` function.

#### Summarize the samples into their means

The process of summarizing this data is straight-forward through the magic of `melt()` and `dcast()`. The ourData is melted into data where the `id` variables are `Subject` and `Activity`, and the remaining 66 data samples are used as the variables. This makes a long skinny data table (4 columns and 679,734 rows!). This data table is fed into `dcast` to summarize the data into the final result, a data table named tidy, which is 180 rows and 68 columns.

This phase is on lines 110-135, and at the end the tidy data is in the data table `tidy`.

### 6 - Output the tidy data

The final steps of the script are to output the file (via `write.table()`) and hop back to the working directory where we started.

This phase is on lines 137-149, and at the end we have our tidy data and it's also saved to a file.

### Running the script in the current working directory

The project instructions say *The code should have a file run_analysis.R in the main directory that can be run as long as the Samsung data is in your working directory.* This script meets this requrement by interpreting "in your working directory" to mean "in your working directory in a sub directory named projectData".

## Codebook

### Source Data

This data is a summary of data avaliable at [http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones). That raw data can also be found at [https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)

There are 68 columns in the output data. The first two columns describe the experiment context (who and what), the other 66 columns are the averages of the many samples of data in those categories. Details of the meaning of the samples can be found in the original data, with the file imported here in [features_info.txt](features_info.txt)

Given that, the 68 columns are described as follows:

Column Name | Value | Meaning
------------|-------|--------
Subject | Integer | Subject identifier (anonymous, but useful for distinguishing among subjects)
Activity | String | Kind of activity the subject was performing during data acquisiition
tBodyAcc-mean-X | Number | mean of the samples for mean body acceleration X dimension, time domain
tBodyAcc-mean-Y | Number | mean of the samples for mean body acceleration Y dimension, time domain
tBodyAcc-mean-Z | Number | mean of the samples for mean body acceleration Z dimension, time domain
tBodyAcc-std-X | Number | mean of the samples for body acceleration X dimension standard deviation, time domain
tBodyAcc-std-Y | Number | mean of the samples for body acceleration Y dimension standard deviation, time domain
tBodyAcc-std-Z | Number | mean of the samples for body acceleration Z dimension standard deviation, time domain
tGravityAcc-mean-X | Number | mean of the samples for mean gravity acceleration X dimension, time domain
tGravityAcc-mean-Y | Number | mean of the samples for mean gravity acceleration Y dimension, time domain
tGravityAcc-mean-Z | Number | mean of the samples for mean gravity acceleration Z dimension, time domain
tGravityAcc-std-X | Number | mean of the samples for gravity acceleration X dimension standard deviation, time domain
tGravityAcc-std-Y | Number | mean of the samples for gravity acceleration Y dimension standard deviation, time domain
tGravityAcc-std-Z | Number | mean of the samples for gravity acceleration z dimension standard deviation, time domain
tBodyAccJerk-mean-X | Number | mean of the samples for mean body acceleration jerx X dimension, time domain
tBodyAccJerk-mean-Y | Number | mean of the samples for mean body acceleration jerx Y dimension, time domain
tBodyAccJerk-mean-Z | Number | mean of the samples for mean body acceleration jerx Z dimension, time domain
tBodyAccJerk-std-X | Number | mean of the samples for body acceleration jerx X dimension standard deviation, time domain
tBodyAccJerk-std-Y | Number | mean of the samples for body acceleration jerx Y dimension standard deviation, time domain
tBodyAccJerk-std-Z | Number | mean of the samples for body acceleration jerx Z dimension standard deviation, time domain
tBodyGyro-mean-X | Number | mean of the samples for mean body gyro X dimension, time domain
tBodyGyro-mean-Y | Number | mean of the samples for mean body gyro Y dimension, time domain
tBodyGyro-mean-Z | Number | mean of the samples for mean body gyro Z dimension, time domain
tBodyGyro-std-X | Number | mean of the samples for body gyro X dimension standard deviation, time domain
tBodyGyro-std-Y | Number | mean of the samples for body gyro Y dimension standard deviation, time domain
tBodyGyro-std-Z | Number | mean of the samples for body gyro Z dimension standard deviation, time domain
tBodyGyroJerk-mean-X | Number | mean of the samples for mean body gyro jerk X dimension, time domain
tBodyGyroJerk-mean-Y | Number | mean of the samples for mean body gyro jerk Y dimension, time domain
tBodyGyroJerk-mean-Z | Number | mean of the samples for mean body gyro jerk Z dimension, time domain
tBodyGyroJerk-std-X | Number | mean of the samples for body gyro jerk X dimension standard deviation, time domain
tBodyGyroJerk-std-Y | Number | mean of the samples for body gyro jerk Y dimension standard deviation, time domain
tBodyGyroJerk-std-Z | Number | mean of the samples for body gyro jerk Z dimension standard deviation, time domain
tBodyAccMag-mean | Number | mean of the samples for mean body accelleration magnitude, time domain
tBodyAccMag-std | Number |
tGravityAccMag-mean | Number | mean of the samples for mean gravity accelleration magnitude, time domain
tGravityAccMag-std | Number | mean of the samples for gravity accelleration magnitude standard deviation, time domain
tBodyAccJerkMag-mean | Number | mean of the samples for mean body accelleration jerk magnitude, time domain
tBodyAccJerkMag-std | Number | mean of the samples for body accelleration jerk magnitude standard deviation, time domain
tBodyGyroMag-mean | Number | mean of the samples for mean gyro magnitude, time domain
tBodyGyroMag-std | Number | mean of the samples for gyro magnitude standard deviation, time domain
tBodyGyroJerkMag-mean | Number | mean of the samples for mean gyro jerk magnitude, time domain
tBodyGyroJerkMag-std | Number | mean of the samples for gyro jerk magnitude standard deviation, time domain
fBodyAcc-mean-X | Number | mean of the samples for mean body accelleration X dimension, frequency domain
fBodyAcc-mean-Y | Number | mean of the samples for mean body accelleration Y dimension, frequency domain
fBodyAcc-mean-Z | Number | mean of the samples for mean body accelleration Z dimension, frequency domain
fBodyAcc-std-X | Number | mean of the samples for body accelleration X dimension standard deviation, frequency domain
fBodyAcc-std-Y | Number | mean of the samples for body accelleration Y dimension standard deviation, frequency domain
fBodyAcc-std-Z | Number | mean of the samples for body accelleration Z dimension standard deviation, frequency domain
fBodyAccJerk-mean-X | Number | mean of the samples for mean body accelleration jerk X dimension, frequency domain
fBodyAccJerk-mean-Y | Number | mean of the samples for mean body accelleration jerk Y dimension, frequency domain
fBodyAccJerk-mean-Z | Number | mean of the samples for mean body accelleration jerk Z dimension, frequency domain
fBodyAccJerk-std-X | Number | mean of the samples for body accelleration jerk Z dimension standard deviation, frequency domain
fBodyAccJerk-std-Y | Number | mean of the samples for body accelleration jerk Z dimension standard deviation, frequency domain
fBodyAccJerk-std-Z | Number | mean of the samples for body accelleration jerk Z dimension standard deviation, frequency domain
fBodyGyro-mean-X | Number | mean of the samples for mean body gyro X dimension, frequency domain
fBodyGyro-mean-Y | Number | mean of the samples for mean body gyro Y dimension, frequency domain
fBodyGyro-mean-Z | Number | mean of the samples for mean body gyro Z dimension, frequency domain
fBodyGyro-std-X | Number | mean of the samples for body gyro X dimension standard deviation, frequency domain
fBodyGyro-std-Y | Number | mean of the samples for body gyro Y dimension standard deviation, frequency domain
fBodyGyro-std-Z | Number | mean of the samples for body gyro Z dimension standard deviation, frequency domain
fBodyAccMag-mean | Number | mean of the samples for mean body accelleration magnitude, frequency domain
fBodyAccMag-std | Number | mean of the samples for body accelleration magnitude standard deviation, frequency domain
fBodyBodyAccJerkMag-mean | Number | mean of the samples for mean body body accelleration jerk magnitude, frequency
fBodyBodyAccJerkMag-std | Number | mean of the samples for body body acceleration jerk magnitude standard deviation, frequency domain
fBodyBodyGyroMag-mean | Number | mean of the samples for mean body body body gyro magnitude, frequency
fBodyBodyGyroMag-std | Number | mean of the samples for body body gyro magnitude standard deviation, frequency domain
fBodyBodyGyroJerkMag-mean | Number | mean of the samples for mean body body gyro jerk magnitude, frequency
fBodyBodyGyroJerkMag-std | Number | mean of the samples for body body gyro jerk magnitude standard deviation, frequency domain

##References/Sources:

Most of the sources were from the course material. A few notable sources OUTSIDE of the course material

1) Mapping a number in a column to a value from a table - this was used in converting from the activity code to the activity as a name: http://stackoverflow.com/questions/10002536/how-do-i-replace-numeric-codes-with-value-labels-from-a-lookup-table
