##IMPORTANT: Before running, set working directory to parent directory of 
## "UCI HAR Dataset', and make sure dplyr packacge is installed

library(dplyr)

run_analysis<-function(){
        ##Step 1: Read files (train) into dataframes
        print("Reading files into dataframes...")
        featureLabels<-read.table("./UCI HAR Dataset/features.txt")[[2]]
        trainSubjectID<-read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = "SubjectID")
        testSubjectID<-read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = "SubjectID")
        trainActivity<-read.table("./UCI HAR Dataset/train/y_train.txt", col.names = "Activity")
        testActivity<-read.table("./UCI HAR Dataset/test/y_test.txt", col.names = "Activity")
        trainData<-read.table("./UCI HAR Dataset/train/X_train.txt", col.names = featureLabels)
        testData<-read.table("./UCI HAR Dataset/test/X_test.txt", col.names = featureLabels)
        print("Complete!")
        
        ##Step 2: Collate data together into one dataframe (test, train)
        print("Collating data into one dataframe...")
        allTrainData<-cbind(trainSubjectID,trainActivity,trainData)
        allTestData<-cbind(testSubjectID,testActivity,testData)
        collatedData<-merge(allTrainData,allTestData,all=TRUE)
        print("Complete!")

        ##Step 3: Change activity number into descriptive label
        print("Relabelling activity numbers as labels...")
        collatedData$Activity<-gsub("1","walking",collatedData$Activity)
        collatedData$Activity<-gsub("2","walking_upstairs",collatedData$Activity)
        collatedData$Activity<-gsub("3","walking_downstairs",collatedData$Activity)
        collatedData$Activity<-gsub("4","sitting",collatedData$Activity)
        collatedData$Activity<-gsub("5","standing",collatedData$Activity)
        collatedData$Activity<-gsub("6","laying",collatedData$Activity)
        print("Complete!")
        
        ##Step 4: Extract variables that are mean|std
        print("Extracting variables: mean or std...")
        pos<-grep("[Mm]ean|std|SubjectID|Activity",names(collatedData))
        hozCollapsedData<-collatedData[pos]
        print("Complete!")
        
        ##Step 5: Tidy up variable names
        print("Tidying up variable names...")
        names(hozCollapsedData)<-gsub("\\.*","",names(hozCollapsedData))
        print("Complete!")
        
        ##Step 6: Collapse for each activity per subject as mean
        print("Creating secondary data set...")
        vertCollapsedData<-aggregate(x=hozCollapsedData[names(hozCollapsedData)[3:88]],
                                     by=hozCollapsedData[c("SubjectID","Activity")],
                                     FUN=mean)
        vertCollapsedData<-arrange(vertCollapsedData,SubjectID,Activity)
        
        ##Step 7: Move dataframes into global environment
        hozCollapsedData<<-hozCollapsedData
        vertCollapsedData<<-vertCollapsedData
        print("All phases complete!")
}