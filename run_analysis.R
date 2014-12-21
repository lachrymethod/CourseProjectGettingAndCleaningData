## This script will take raw files from the UCI HAR Dataset create a tidy data
## set in .txt format

## PART 1
        ## READ the test and train files so that they can be merged and
        ## maniupulated
                ## These files are the keys for the rows and columns for the data
                col.features <- read.table("./features.txt")
                        ## the col.features are the names for each column in
                        ## the data set
                activity.key <- read.table("./activity_labels.txt")
                        ## This file is the code to tell which activity is being
                        ## identified in all the .labels files below
                
                ## This is the data for all the tests that were run
                test.data <- read.table("./test/X_test.txt")
                train.data <- read.table("./train/X_train.txt")
                
                ##These are the labels for activities that were performed
                test.labels <- read.table("./test/y_test.txt")
                train.labels <- read.table("./train/y_train.txt")
        
                ## These are the subjects who were in the experiments
                test.subj <- read.table("./test/subject_test.txt")
                train.subj <- read.table("./train/subject_train.txt")
        ## At this point all of the files that we will need have been read into
        ## object
                
                
        ## MERGE like files so that they can be attached to each other via the
        ## rows. In all cases the train data comes before the test data in the
        ## *.all data sets
        data.all <- rbind(train.data, test.data)
        labels.all <- rbind(train.labels, test.labels)
        subj.all <- rbind(train.subj, test.subj)
                
        
## PART 4
        ## ADD the labels to the columns for data.all. It is much easier to add
        ## the data labels for the data set BEFORE you extract the columns that 
        ## 'mean' or 'std' in them. Additionally, it creates a point in the
        ## process that can be reference should additional variables be needed
        names(data.all) <- col.features[, 2]
                
## PART 2
        ## Pull out the mean and std figures before adding the subjects and 
        ## activities
        data.extract <- data.all[,grep("mean|std", col.features[,2])]
        
        
## PART 3        
        ## ADD labels to the activity performed so that the clean data set has
        ## has the activity being peformed as well as the code for that activity.
        ## additionally they will be added to the data set.
        labels.all$Activity <- activity.key[labels.all$V1, 2]
        data.wlabels <- cbind(labels.all, data.extract)
                ## Remove the Activity Code in the first column
                data.wlabels <- data.wlabels[,2:81]
        
## PART 1        
        ## ADD the subjects that performed the activites to the data set
        names(subj.all) <- "Subject"
        data.clean <-cbind(subj.all, data.wlabels)
                
## The data are now merged and clean and ready to be summarized into averages.

## PART 5        
        ## Get averages for all the permutations of Activity and Subject and
        ## assign them to an object
        data.tidy <- group_by(data.clean, Subject, Activity) %>% 
                        summarise_each(funs(mean))

        ## WRITE the tidy data to a .txt file
        write.table(data.tidy, file = "./tidydata.txt", row.name = FALSE)