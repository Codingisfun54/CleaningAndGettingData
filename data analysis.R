#Test Data
x_test <- read.table("X_test.txt")
y_test <- read.table("y_test.txt")
sub_test <- read.table("subject_test.txt")
# Train Data
x_train <- read.table("x_train.txt")
y_train <- read.table("y_train.txt")
sub_train <- read.table("subject_train.txt")
# features
features <- read.table("features.txt")
#activity
activity_labels <- read.table("activity_labels.txt")
#combine Train and Test data together
x   <- rbind(x_train, x_test)
y   <- rbind(y_train, y_test)
sub <- rbind(sub_train, sub_test)
#  mean and standard deviation
sel_features <- features[grep(".*mean\\(\\)|std\\(\\)", features[,2], ignore.case = FALSE),]
x<- x[,sel_features[,1]]
# name columns
colnames(x)   <- sel_features[,2]
colnames(y)   <- "activity"
colnames(sub) <- "subject"
# merge final dataset
total <- cbind(sub, y, x)
# turn activities & subjects into factors
total$activity <- factor(total$activity, levels = activity_labels[,1], labels = activity_labels[,2])
total$subject  <- as.factor(total$subject)
# create a summary independent tidy dataset from final dataset
# with the average of each variable for each activity and each subject.
total_mean <- total %>% group_by(activity, subject) %>% summarize_all(funs(mean))
write.table(total_mean, file = "./tidydata.txt", row.names = FALSE, col.names = TRUE) 