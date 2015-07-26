# Course Project - Getting and Cleaning Data

## Script overview

The script can be found in `run_analysis.R`. If you source this file, via

```[R]
source("run_analysis.R")
```

it will immediately run and generate, in the project directory, the file `tidy_data.txt`.

The tidy data consists of 180 rows of data with 68 columns, one row for each of the 30 subjects 6 distinct activities (30*6=180) with the 2 columns describing the subject and activity and 66 columns with the sample data.

### Running the script in the current working directory

The project instructions say *The code should have a file run_analysis.R in the main directory that can be run as long as the Samsung data is in your working directory.* This script meets this requrement by interpreting "in your working directory" to mean "in your working directory in a sub directory named projectData".

## Codebook

### Source Data

This data is a summary of data avaliable at [http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

There are 68 columns in the output data. The first two columns describe the experiment context (who and what), the other 66 columns are the averages of the many samples of data in those categories. Details of the meaning of the samples can be found in the original data, with the file imported here in [features_info.txt](features_info.txt)

Given that, the 68 columns are described as follows:

Column Name | Value | Meaning
============|=======|========
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
