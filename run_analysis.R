url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
path <- getwd()
download.file(url, file.path(path, "Dataset.zip"),method="auto")

unzip("Dataset.zip")

train<-read.table("UCI HAR Dataset/train/X_train.txt")
test<-read.table("UCI HAR Dataset/test/X_test.txt")
data<-rbind(train,test) #bind x data


train_labels<-read.table("UCI HAR Dataset/train/y_train.txt")
test_labels<-read.table("UCI HAR Dataset/test/y_test.txt")
labels<-rbind(train_labels,test_labels) # bind y data 


#giving names
names(labels)<-"Activity"
features <- read.table("UCI HAR Dataset/features.txt")
names(data)<-features[,2]

#merging overall 
data_all<-cbind(data,labels) 


data_filtered <- data_all[, grepl("mean\\(\\)|std\\(\\)|Activity", colnames(data_all))]


#changing activity values

data_filtered$Activity[data_filtered$Activity==1] <- "WALKING"
data_filtered$Activity[data_filtered$Activity==2] <- "WALKING_UPSTAIRS"
data_filtered$Activity[data_filtered$Activity==3] <- "WALKING_DOWNSTAIRS"
data_filtered$Activity[data_filtered$Activity==4] <- "SITTING"
data_filtered$Activity[data_filtered$Activity==5] <- "STANDING"
data_filtered$Activity[data_filtered$Activity==6] <- "LAYING"


write.table(data_filtered,"tidy.txt",sep="  ") # write tidy data
