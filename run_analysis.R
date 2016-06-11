library(downloader)
library(data.table)
library(plyr)
library(dplyr)

setwd("C:\\Eday\\Doc\\R\\download")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#download(fileUrl, dest="UCI HAR dataset.zip",mode = "wb")
download.file(fileUrl, dest="UCI HAR dataset.zip",mode = "wb",method="curl") 

#download()
unzip ("UCI HAR dataset.zip")

activitylabels <- read.table("UCI HAR Dataset/activity_labels.txt",sep="",na.strings=TRUE,stringsAsFactors=FALSE,col.names = c('activity_label','activity'),header = FALSE)

testsubject <- read.table("UCI HAR Dataset/test/subject_test.txt",sep=" ",col.names =c('subject'),na.strings=TRUE,stringsAsFactors=FALSE,header = FALSE)
testlables <- read.table("UCI HAR Dataset/test/y_test.txt",sep=" ",col.names=c('activity_label'),na.strings=TRUE,stringsAsFactors=FALSE,header = FALSE)
testactivity <- merge(testlables,activitylabels,by.x="activity_label",sort = FALSE)

trainingsubject <- read.table("UCI HAR Dataset/train/subject_train.txt",sep=" ",col.names =c('subject'),na.strings=TRUE,stringsAsFactors=FALSE,header = FALSE)
traininglables <- read.table("UCI HAR Dataset/train/y_train.txt",sep=" ",col.names=c('activity_label'),na.strings=TRUE,stringsAsFactors=FALSE,header = FALSE)
trainingactivity <- merge(traininglables,activitylabels,by.x="activity_label",sort = FALSE)

readlabels <- read.table("UCI HAR Dataset/features.txt",sep=" ",na.strings=TRUE,stringsAsFactors=FALSE,header = FALSE)
testset <- read.csv("UCI HAR Dataset/test/X_test.txt",sep="",na.strings=TRUE,stringsAsFactors=FALSE,header = FALSE,col.names = readlabels[,2])
trainingset <- read.csv("UCI HAR Dataset/train/X_train.txt",sep="",na.strings=TRUE,stringsAsFactors=FALSE,header = FALSE,col.names = readlabels[,2])


testdataset <- cbind(testsubject,testlables,testset)

trainingdataset <- cbind(trainingsubject,traininglables,trainingset)


trainingtest <- rbind(trainingdataset,testdataset)
measurementdata <-  trainingtest[,grep("\\.[Ss][Tt][Dd]\\.|\\.[Mm][Ee][Aa][Nn]\\.",names(trainingtest))]
traintestcombine <-   cbind(trainingtest$subject,trainingtest$activity_label,measurementdata)

names(traintestcombine)[names(traintestcombine)=="trainingtest$subject"] <- "subject"
names(traintestcombine)[names(traintestcombine)=="trainingtest$activity_label"] <- "activity_label"

traintest <- merge(activitylabels,traintestcombine,by.x="activity_label",by.y="activity_label",all.y = TRUE )


testtrainfinal <- select(traintest,-(activity_label))

DT <- as.data.table(testtrainfinal)
resultset <- DT[ , lapply(.SD, mean), by = list(subject,activity)]
finalresult <- as.data.frame(arrange(resultset,subject,activity))
write.table(finalresult,file="run_analysis_results.txt",sep=",",row.names = FALSE,col.names = FALSE)
class(finalresult)
head(finalresult,5)