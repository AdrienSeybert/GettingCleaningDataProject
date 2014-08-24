##Script to Produce Data File For Getting, Cleaning Data Course Project

##Test Files

subject_test<-read.table("./UCI HAR Dataset/test/subject_test.txt", header=FALSE) 
X_test<-read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE)
y_test<-read.table("./UCI HAR Dataset/test/y_test.txt", header=FALSE) 

##Activity Labels/Variable Features

activity_labels<-read.table("./UCI HAR Dataset/activity_labels.txt", header=FALSE)
features<-read.table("./UCI HAR Dataset/features.txt", header=FALSE)

##Train Files

subject_train <-read.table("./UCI HAR Dataset/train/subject_train.txt", header=FALSE) 
X_train<-read.table("./UCI HAR Dataset/train/X_train.txt", header=FALSE)
y_train<-read.table("./UCI HAR Dataset/train/y_train.txt", header=FALSE)

##Fuse X_test with X_train

X_TestTrain<-rbind(X_test, X_train)

##Fuse y_test with y_train

Y_TestTrain<-rbind(y_test, y_train)

##Join subject_test with subject_train

Subject_TestTrain<-rbind(subject_test, subject_train)

#Change Y_TestTrain To activityID
#Change Subject_TestTrain to subjectID
activityID<-Y_TestTrain
subjectID<- Subject_TestTrain

## Subset Feature Names Out of Features Data.Frame

FeatureColNames<-features$V2

## Change X_TestTrain's Column Names To Features Variable Names

colnames(X_TestTrain)<-FeatureColNames
colnames(activityID)<-"ActivityID"
colnames(subjectID)<-"SubjectID"

## Extracting Mean/Standard Deviation Calculations
## Used the strict interpretation of Mean/Std of Values. Only variables with Mean() or Std()

SelectVariablesMean<-grep("*mean\\(\\)", names(X_TestTrain)) 
SelectVariablesStd<-grep("*std\\(\\)", names(X_TestTrain))


MeanTestTrain<-X_TestTrain[ , SelectVariablesMean]
StdTestTrain<-X_TestTrain[ , SelectVariablesStd]

## Combing MeanTestTrain With StdTestTrain, then add activityID, subjectID

MeanStdTestTrain<-cbind(MeanTestTrain, StdTestTrain)

## Putting Column Names For Variables Into New Variable For Latter

MeanStdVariables<-colnames(MeanStdTestTrain)

TotalMeanStdData<-cbind(subjectID, activityID, MeanStdTestTrain)
  
## Converting Activity IDs To Activity Names In activityID

##TotalMeanStdData[TotalMeanStdData$activityID == "1"]<-"WALKING(1)"
##TotalMeanStdData[TotalMeanStdData$activityID == "2"]<-"WALKING_UPSTAIRS(2)"
##TotalMeanStdData[TotalMeanStdData$activityID == "3"]<-"WALKING_DOWNSTAIRS(3)"
##TotalMeanStdData[TotalMeanStdData$activityID == "4"]<-"SITTING(4)"
##TotalMeanStdData[TotalMeanStdData$activityID == "5"]<-"STANDING(5)"
##TotalMeanStdData[TotalMeanStdData$activityID == "6"]<-"LAYING(6)"

## Cleaning Up Variable Names To Make Sense and Be Descriptive

## Melting Data To Find Average Of Variables, Followed By 

library(reshape2)
TotalData<-melt(TotalMeanStdData, id.vars = c("SubjectID", "ActivityID"), measure.vars=colnames(MeanStdTestTrain))
TotalMeanVarBySubID<-dcast(TotalData, SubjectID + ActivityID ~ variable, mean)

##Output Data

write.table(TotalMeanVarBySubID, file = "./DataCourseProject.txt", row.names = FALSE)
