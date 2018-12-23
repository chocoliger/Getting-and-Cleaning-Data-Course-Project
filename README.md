## README
The purpose of this repository is to convert raw accelerometry data collected from Samsung Galaxy S smartphones available here https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip into two tidy dataframes. For a full description of the initial raw data, see here http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. 

Included in this repository is the following:
* The R script "run_analysis.R"
* ReadMe document you are reading currently
* CodeBook describing the variables of the output of the script

The R script requires you to set the working directory as the parent directory of the extracted UCI HAR Dataset folder. It also requires that the 'dplyr' package to be installed beforehand. Do not change the position or names of any of the files in the UCI HAR Dataset folder. 

The output of the script will be two dataframes. The first dataframe will contain a tidyset with measurements that involve mean or standard deviations, called "hozCollapsedData". The second dataframe will contain a summarised version of the "hozCollapsedData" dataset, with the average of each variable for each activity and each subject.

The 'pseudocode' for the script is as follows:
**SCRIPT STEPS**
1. COLLATE
  - read text files and convert to dataframe
  - rbind and cbind separate dataframes into appropriate orientation
    - subject_train and y_train are own columns
    - make column names of columns 3: to be features.txt
  - tidy up names
    - convert activity numbers into descriptive labels
2. COLLAPSE_HORIZONTAL(MEANS/SD)
  - find column names with "mean" or "std" and convert to num/log vector
  - select dataframe for these columns
  - tidy remaining feature names with readable labels
3. COLLAPSE_VERTICAL(MEANS FOR EACH ACTIVITY)
  - apply mean for each activity for each person and collapse into one
