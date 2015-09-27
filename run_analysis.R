## assign feature names to variables in test set and train set
colnames(test) <- features$V2
colnames(train) <- features$V2

## change var names
colnames(subjectTest) <- c("subject")
colnames(labelTest) <- c("label")
colnames(subjectTrain) <- c("subject")
colnames(labelTrain) <- c("label")

## merge test set with test subject, and test label
## merge train set with train subject, and train label
## merge test set and train set
mtest <- cbind(subjectTest, labelTest, test)
mtrain <- cbind(subjectTrain, labelTrain, train)
galaxy <- rbind(mtest, mtrain)

## Extract only the measurements on the mean 
## and standard deviation for each measurement. 
## Extract id and label
## Merge id, label, mean $ std
mgalaxy <- galaxy[,c(grep("mean", colnames(galaxy)), 
                     grep("std", colnames(galaxy)))]
lgalaxy <- galaxy[, c("subject", "label")]
igalaxy <- cbind(lgalaxy, mgalaxy)

## Recode Variable Label 
igalaxy$label <- as.character(igalaxy$label)
igalaxy$Dlabel <- revalue(igalaxy$label, c("1" = "walkiing", 
                                           "2" = "walking_upstairs", 
                                           "3" = "walking_downstairs", 
                                           "4" = "sitting", 
                                           "5" = "standing", 
                                           "6" = "laying"))
igalaxy$label <- NULL

## Switch columns of the "igalaxy" dataset
idgalaxy <- igalaxy[,c("subject", "Dlabel")]
igalaxy$subject <- NULL
igalaxy$Dlabel <- NULL
igalaxy <- cbind(idgalaxy, igalaxy)

## save "mgalaxy" with only measurement vars
write.table(mgalaxy, file = "tidy_data.txt", row.name = FALSE)
