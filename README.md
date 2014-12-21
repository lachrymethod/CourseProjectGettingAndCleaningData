CourseProjectGettingAndCleaningData
===================================

This is the readMe file for the run_analysis.R script that is within this github repo.
You may also find reading the CodeBook.md file useful to get an explanation of all of the variables in the output file.
It is also necessary to download and library() the dplyr package in R to guarantee the script will run accurately.

This script will
-Read all of the relevant files from the UCI HAR Data Set
-Merge the files into forms that will allow for data manipulation
-Label the variables in a combined data set
-Extract from the merged object only the 'mean' and 'std' columns
-Combine a labeled and refined data set with Subject numbers and Activity names
-Summarize the data by each Subject and Activity by each of the variables in that are measured
-Write to a new .txt file a tidy data set.

Here is a more details explanation of what the script does in each step above
## PART 1 (These PART #'s relate to the assignment as a whole and not the order of operation of this script)
-Read all of the relevant files from the UCI HAR Data Set
	- Use the read.table function to read the following files to the associated objects
		- features.txt -- col.features (column names for the raw data)
		- activity_labels.txt -- activity.key (key that helps match the Activity with ActivityCode)
		- X_test.txt -- test.data (data used to test what was trained)
		- X_train.txt -- train.data (training data)
		- y_test.txt -- test.labels (Activity labels for the test data set)
		- y_train.txt -- train.labels (Activity labels for the train data set)
		- subject_test.txt -- test.subj (Subjects that performed each Activity in the data set)
		- subject_train.txt -- train.subj (Subjects that performed each Activity in the data set)
		
-Merge the files into forms that will allow for data manipulation
	- Use the rbind() function too put the test data set at the bottom of the train data set in 3 new objects
		- data.all (All of the data)
		- labels.all (All of the labels for Activities for each line of the data)
		- subj.all (All of the subjects that performed each Activity)

## PART 4		
-Label the variables in a combined data set
	- Uses the names() function to apply the 2nd column in col.features as names to the data.all object

## PART 2
-Extract from the merged object only the 'mean' and 'std' columns
	- Uses the grep() function to only grab the columns in data.all with 'mean' or 'std' in their names and creates a new data.extract object

## PART 3
-Combine a labeled and refined data set with Subject numbers and Activity names
	- First this will create a new variable in the labels.all object that corresponds to the Activity name that is correlated with the number in activity.key object
	- Then it adds both columns from the above step to the data.extract object
	- Then it removes the Activity numbers and leaves the Activity names since they are redundant
	- Then it adds the Subjects numbers that performed the Activities to the data.wlabels object to create a data.clean object

The data are now merged and clean and ready for analysis.

## PART 5
-Summarize the data by each Subject and Activity by each of the variables in that are measured
	- Using a combindation of the group_by() and summarise_each() functions the data.clean object is summarized by taking the mean of each Subject and Activity permutation and stored in a new data.tidy object
	
-Write to a new .txt file a tidy data set.
	- Using the write.table() function the data.tidy object is used to create a tidydata.txt file
	
	
	


