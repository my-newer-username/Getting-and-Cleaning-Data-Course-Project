library("reshape2")


# download data
FileName <- "data.zip"
if(!file.exists(FileName))
{
    FUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    download.file(FUrl,FileName)
}


# unzip data
if (!file.exists("UCI HAR Dataset"))
{ 
    unzip(FileName) 
}


# Load activity labels & features
Activity_Category <- read.table("UCI HAR Dataset/activity_labels.txt")
Activity_Category[,2] <- as.character(Activity_Category[,2])
Activity_Features <- read.table("UCI HAR Dataset/features.txt")
Activity_Features[,2] <- as.character(Activity_Features[,2])


# Extract RowIndex, Names of features with mean and standard deviation
Index_Features_Mean_SD <- grep("mean|std", Activity_Features[,2])
Names_Features_Mean_SD <- Activity_Features[Index_Features_Mean_SD,2]
# Clean feature names, killing unmeaningful parenthesis
Names_Features_Mean_SD <- gsub('[()]',"",Names_Features_Mean_SD)


# Load train datasets and bind.
Train <- read.table("UCI HAR Dataset/train/X_train.txt")[,Index_Features_Mean_SD]
Train_Category <- read.table("UCI HAR Dataset/train/Y_train.txt")
Trainee <- read.table("UCI HAR Dataset/train/subject_train.txt")
Train <- cbind(Trainee, Train_Category, Train)

# Load test datasets and bind.
Test <- read.table("UCI HAR Dataset/test/X_test.txt")[,Index_Features_Mean_SD]
Test_Category <- read.table("UCI HAR Dataset/test/Y_test.txt")
Testee <- read.table("UCI HAR Dataset/test/subject_test.txt")
Test <- cbind(Testee, Test_Category, Test)


# Merge train and test data
Data <- rbind(Train, Test)
colnames(Data) <- c("Subject_ID", "Activity_Category", Names_Features_Mean_SD)


#convert colum 1 and 2 into factors.
Data$Subject_ID <- as.factor(Data$Subject_ID)
Data$Activity_Category <- factor(Data$Activity_Category, levels = Activity_Category[,1], labels = Activity_Category[,2])


#creat a new dataframe
Melted_Data <- melt(Data, id = c("Subject_ID", "Activity_Category"))
New_Data <- dcast(Melted_Data, Subject_ID + Activity_Category ~ variable, mean)

write.table(New_Data, "tidy.txt", row.names = FALSE, quote = FALSE)