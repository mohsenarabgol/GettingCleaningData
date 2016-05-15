##Reading the features and activity labels

features<-readLines("features.txt")
activity<-readLines("activity_labels.txt")

for (i in 1:length(features)){
	features[i]<-unlist(strsplit(features[i], " "))[2]
}

##Reading and organizing the train data

X_train<-readLines("train/X_train.txt")
y_train<-readLines("train/y_train.txt")
subject_train<-readLines("train/subject_train.txt")

for (i in 1:length(X_train)){
	X_train[[i]]<-gsub("  "," ",X_train[[i]])
	X_train[[i]]<-substring(X_train[[i]], 2, nchar(X_train[[i]]))
	X_train[i]<-strsplit(X_train[[i]], " ")
}
train_data<-do.call(rbind.data.frame, X_train)

colnames(train_data)<-features
train_data<-cbind(subject = subject_train, train_data)
train_data<-cbind(activity = y_train, train_data)

##Reading and organizing the test data

X_test<-readLines("test/X_test.txt")
y_test<-readLines("test/y_test.txt")
subject_test<-readLines("test/subject_test.txt")

for (i in 1:length(X_test)){
	X_test[[i]]<-gsub("  "," ",X_test[[i]])
	X_test[[i]]<-substring(X_test[[i]], 2, nchar(X_test[[i]]))
	X_test[i]<-strsplit(X_test[[i]], " ")
}
test_data<-do.call(rbind.data.frame, X_test)

colnames(test_data)<-features
test_data<-cbind(subject = subject_test, test_data)
test_data<-cbind(activity = y_test, test_data)

##Merging the train and test data and selecting relevant columns

data<-rbind(train_data, test_data)
colselect<-features[grepl("mean\\(\\)|std\\(\\)", features)]
data<-data[,c("subject", "activity", colselect)]

##Cleaning the activity names

data$activity<-as.character(data$activity)
for (i in 1:dim(data)[1]){
	data[i,2]<-activity[as.numeric(data[i,2])]
	data[i,2]<-substring(data[i,2], 3, nchar(data[i,2]))
}

##Aggregating the data based on subject and activity, sorting and writing the output file

final_data<-aggregate(.~subject+activity,data=data, FUN=mean)
final_data<-final_data[order(as.numeric(as.character(final_data$subject))),]

write.table(final_data, "output.txt", row.name=FALSE)





