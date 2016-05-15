Here we explain the steps taken to clean up the data:  

1) To start the code we have to make sure that the working directory is set to the directory that contains the data.  
2) We first read the activity_labels and features files and make two character vectors called "activity" and "features".  
3) Then we do the following for the train data set  
	a) We read the "X_train" and "y_train" and "subject_train" files  
	b) We organize the data and make a data frame out of the data.  
	c) The data frame consists of 7352 rows (observations) and 563 columns. Two of them are "subject" and "activity" and the other 561 are features.  
	d) Note that at this point the "activity" column contains a number between 1 to 6. Each number corresponds to an activity.  
4) We repeat the same procedure for the test data set.  
5) We combine two data sets is a large data set called "data"  
6) In the data set we subset those columns (features) that contain the word "mean" or "std". These are the mean and standard deviation of the variables.  
7) We replace the numbers in the activity column with the corresponding activity from the activity_labels.  
8) Finally we aggregate the data based on subject and activity and calculate the mean of each variable grouped by subject and activity.   
8) Now we have a tidy data set called "final_data":  
	a) Consists of 180 rows (30 subjects each have 6 avtivities).   
	b) Consists of 68 Columns. 2 of them are "subject" and "activity". The other 66 column show the mean and standard deviation of different variables explained in the code book.  
9) We write the final into the "output.txt"  
Note that you can always read this file as a data.frame using the following command:  
> read.table("output.txt", header=TRUE, check.names=FALSE)  


Note: The code takes a few minutes to run (~2-3 minutes with a core i5 CPU and 4GB Ram)