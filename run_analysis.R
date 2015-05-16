library(dplyr)

# Reading in the data
## training data sets
data_train <- read.table("UCI HAR Dataset/train/X_train.txt")
activity_labels_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subjects_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

## test data sets
data_test <- read.table("UCI HAR Dataset/test/X_test.txt")
activity_labels_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subjects_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

# combine the training and test data sets
data <- rbind(data_train, data_test)
activity_labels <- rbind(activity_labels_train, activity_labels_test)
subjects <- rbind(subjects_train, subjects_test)

# Add the subject ID's and activity labels to the data
data <- cbind(subjects, activity_labels, data)

# get the names of the data features
features <-  read.table("UCI HAR Dataset/features.txt")
names(features) <- c("Index", "Name")

# assign the correct names to the columns of the data
names(data) <- c("Subject","Activity",as.character(features$Name))

# Extract the data for the mean and std values
mean_or_std_logical <- grepl("mean()",names(data), fixed = TRUE) | grepl("std()",names(data), fixed = TRUE)
data <- subset(data,select = c("Subject","Activity",names(data)[mean_or_std_logical]))

# Replace the activity numeric codes with plain text labels
activity_labels_key <- read.table("UCI HAR Dataset/activity_labels.txt")
data$Activity <- apply(data,1, function(x) x[2] <- activity_labels_key$V2[x[2]])
# clean up column names
names(data) <- gsub("-",".",names(data))
names(data) <- gsub("[()]","",names(data))
# order data in increasing order of Subject ID and Activity labels
data_ordered <- data[order(data$Subject,data$Activity),]

# Split the data according to Subject and Activity
data_split <- split(data_ordered[,3:length(names(data_ordered))],list(data_ordered$Subject,data_ordered$Activity))
# Calculatethe mean values for each combination of Subject and Activity
data_split_mean <- lapply(data_split,colMeans,na.rm = TRUE)

# Collapse the list back to a data frame
data_means <- do.call(rbind, data_split_mean)
data_means <- data.frame(data_means)

# Recreate the Subject and Activity columns
data_means <- mutate(data_means,Subject = rep(1:30,times = 6), Activity = rep(c("LAYING","SITTING","STANDING","WALKING","WALKING_DOWNSTAIRS","WALKING_UPSTAIRS"), each = 30))
# Move the Subject and Activity colums to the front of the data frame
data_means <- subset(data_means,select = c(Subject,Activity,tBodyAcc.mean.X:fBodyBodyGyroJerkMag.std))


write.table(data_means, file = "tidy_data.txt", row.names = FALSE)