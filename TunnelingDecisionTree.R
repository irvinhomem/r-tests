library("rjson")

# Testing scripts in R
dirname(getwd())

#Testing Concatenation
concat_str = paste("string 1", "string 2", sep="/")

# paste(dirname(getwd()), "Datasets/JSON-4-Classes", sep="/")
dataset_path = paste(dirname(getwd()), "Datasets/JSON-4-Classes", sep="/")

# paste(dataset_path, "HTTPovDNS-Static/All", sep="/")
http_ov_dns_path = paste(dataset_path, "HTTPovDNS-Static/All", sep="/")
ftp_ov_dns_path = paste(dataset_path, "FTPovDNS-DL/All", sep="/")
http_s_ov_dns_path = paste(dataset_path, "HTTP-S-ovDNS-Static/All", sep="/")
pop3_ov_dns_path = paste(dataset_path, "POP3ovDNS-DL-5txt-ATT/All", sep="/")

# Get all files in "HTTPovDNS-Static" directory
http_ov_dns_files <- list.files(path=http_ov_dns_path, pattern="*.json", full.names=TRUE, recursive=TRUE, include.dirs = TRUE )
ftp_ov_dns_files <- list.files(path=ftp_ov_dns_path, pattern="*.json", full.names=TRUE, recursive=TRUE, include.dirs = TRUE )
http_s_ov_dns_files <- list.files(path=http_s_ov_dns_path, pattern="*.json", full.names=TRUE, recursive=TRUE, include.dirs = TRUE )
pop3_ov_dns_files <- list.files(path=pop3_ov_dns_path, pattern="*.json", full.names=TRUE, recursive=TRUE, include.dirs = TRUE )

# Test collection of JSON data from a single file
json_data_single <- fromJSON(file=http_ov_dns_files[1])

# Convert json to data frame (may fail due to differing lengths of rows)
#json_single_data_frame <- as.data.frame(json_data_single)

typeof(json_data_single)

# Get values if a particular parameter from the json
json_data_single[[1]]
json_data_single$filename
typeof(json_data_single$filename)

json_data_single[[2]]
json_data_single$`pcap-Md5-hash`

json_data_single[[4]]
json_data_single$protocol

# Get list-item containing the 1st json property name -> DNS-Req-Lens
json_data_single[[3]][[1]]$feature_name
json_data_single$props[[1]]$feature_name

# Get list-item containing the 2nd json property name -> IP-Req-Lens
json_data_single[[3]][[2]]$feature_name
json_data_single$props[[2]]$feature_name

# Get list-item containing the 4th json property name -> DNS-Req-Qnames-Enc-Comp-Entropy
json_data_single[[3]][[4]]$feature_name
json_data_single$props[[4]]$feature_name

# Get average of entropy values for single pcap_json_object
entropy_avg = mean(json_data_single$props[[4]]$values)

# Get average IP-Req-Len for single pcap_json_object
ip_len_avg =  mean(json_data_single$props[[2]]$values)

f_name = vector()
proto_name = vector()
avg_entropy= vector()
avg_ip_req_len = vector()
avg_dns_req_len = vector()

###############################
# REPEATING CODE
###############################
# Extract features from all HTTPovDNS-Static json files in directory
for(i in 1:length(http_ov_dns_files)){
  json_file_data <- fromJSON(file=http_ov_dns_files[i])
  # Populate respective vectors
  f_name[i] <- json_file_data$filename
  proto_name[i] <- json_file_data$protocol
  avg_entropy[i] <- mean(json_file_data$props[[4]]$values)
  avg_ip_req_len[i] <- mean(json_file_data$props[[2]]$values)
  avg_dns_req_len[i] <- mean(json_file_data$props[[1]]$values)
}

http_ov_dns_pcap_features_df <- data.frame("filename"=f_name, "proto_label"=proto_name, "avg_entropy"=avg_entropy, "avg_ip_req_len"=avg_ip_req_len, "avg_dns_req_len"=avg_dns_req_len, check.rows = TRUE)

for(i in 1:length(ftp_ov_dns_files)){
  json_file_data <- fromJSON(file=ftp_ov_dns_files[i])
  # Populate respective vectors
  f_name[i] <- json_file_data$filename
  proto_name[i] <- json_file_data$protocol
  avg_entropy[i] <- mean(json_file_data$props[[4]]$values)
  avg_ip_req_len[i] <- mean(json_file_data$props[[2]]$values)
  avg_dns_req_len[i] <- mean(json_file_data$props[[1]]$values)
}

ftp_ov_dns_pcap_features_df <- data.frame("filename"=f_name, "proto_label"=proto_name, "avg_entropy"=avg_entropy, "avg_ip_req_len"=avg_ip_req_len, "avg_dns_req_len"=avg_dns_req_len, check.rows = TRUE)

for(i in 1:length(http_s_ov_dns_files)){
  json_file_data <- fromJSON(file=http_s_ov_dns_files[i])
  # Populate respective vectors
  f_name[i] <- json_file_data$filename
  proto_name[i] <- json_file_data$protocol
  avg_entropy[i] <- mean(json_file_data$props[[4]]$values)
  avg_ip_req_len[i] <- mean(json_file_data$props[[2]]$values)
  avg_dns_req_len[i] <- mean(json_file_data$props[[1]]$values)
}

http_s_ov_dns_pcap_features_df <- data.frame("filename"=f_name, "proto_label"=proto_name, "avg_entropy"=avg_entropy, "avg_ip_req_len"=avg_ip_req_len, "avg_dns_req_len"=avg_dns_req_len, check.rows = TRUE)

for(i in 1:length(pop3_ov_dns_files)){
  json_file_data <- fromJSON(file=pop3_ov_dns_files[i])
  # Populate respective vectors
  f_name[i] <- json_file_data$filename
  proto_name[i] <- json_file_data$protocol
  avg_entropy[i] <- mean(json_file_data$props[[4]]$values)
  avg_ip_req_len[i] <- mean(json_file_data$props[[2]]$values)
  avg_dns_req_len[i] <- mean(json_file_data$props[[1]]$values)
}

pop3_ov_dns_pcap_features_df <- data.frame("filename"=f_name, "proto_label"=proto_name, "avg_entropy"=avg_entropy, "avg_ip_req_len"=avg_ip_req_len, "avg_dns_req_len"=avg_dns_req_len, check.rows = TRUE)

typeof(f_name)

# Merge multiple using "rbind" function (All column names must be the same)
json_features_all_pcaps_df <- rbind(http_ov_dns_pcap_features_df, ftp_ov_dns_pcap_features_df, http_s_ov_dns_pcap_features_df, pop3_ov_dns_pcap_features_df)

#print(pcap_features_df)
print(http_ov_dns_pcap_features_df)
print(ftp_ov_dns_pcap_features_df)
print(http_s_ov_dns_pcap_features_df)
print(pop3_ov_dns_pcap_features_df)

print(json_features_all_pcaps_df)
#str(pcap_features_df)

################################################
##  Partition the dataset into k-folds i.e. 10-folds in this case
################################################
library("caret")
library("rpart")

#http_flds <- createFolds(http_ov_dns_pcap_features_df, k = 10, list = FALSE, times = 10)

#frmla = as.formula(proto_label ~ avg_entropy + avg_ip_req_len + avg_dns_req_len)  # With 3 features
frmla = as.formula(proto_label ~ avg_entropy + avg_ip_req_len)                   # With 2 features
#frmla = as.formula(proto_label ~ avg_entropy)                   # With 1 feature


#train_ctrl <- trainControl(method = "cv", number = 10, p=0.9, savePredictions = TRUE, returnResamp = TRUE, classProbs = TRUE) # classProbs = TRUE # sampling = "none"
#train_ctrl <- trainControl(method = "cv", number = 10, p=0.9, savePredictions = "final", returnResamp = TRUE, classProbs = TRUE) # classProbs = TRUE # sampling = "none"
# Best so far, but results in different folds every time a new classifcation algorithm is tried (i.e. decision trees, knn, etc)
#train_ctrl <- trainControl(method = "cv", number = 10, p=0.9, savePredictions = "final", returnResamp = "final", returnData = TRUE) # classProbs = TRUE # sampling = "none"
#myFolds <- createFolds(json_features_all_pcaps_df$avg_entropy, k = 10, returnTrain = FALSE)
#myFolds <- createDataPartition(json_features_all_pcaps_df$avg_entropy, times = 10, p = 0.9, list = FALSE)
myFolds <- createDataPartition(json_features_all_pcaps_df$proto_label, times = 10, p = 0.9)
#myFolds
head(myFolds)
train_ctrl <- trainControl(method = "cv", index = myFolds, savePredictions = "final", returnResamp = "final", returnData = TRUE) # classProbs = TRUE # sampling = "none"
#train_ctrl <- trainControl(method = "loocv", index = myFolds, savePredictions = "final", returnResamp = "final", returnData = TRUE)

################################################
##  Run different Classifiers on the folds
################################################

#======
#  Decision Trees
#======
#tree_model <- train(frmla, data=json_features_all_pcaps_df, method = "rpart", cp=0.2405063, trControl = train_ctrl)
#tree_model <- train(frmla, data=json_features_all_pcaps_df, method = "rpart", cp = 0.002, trControl = train_ctrl)
#tree_model <- train(frmla, data=json_features_all_pcaps_df, method = "rpart", trControl = train_ctrl)   # 'rpart' with 2 features, HTTP-S is missing
tree_model <- train(frmla, data=json_features_all_pcaps_df, method = "rpart2", trControl = train_ctrl)  # 'rpart2' with 2 features does better classificaiton

#warnings()
#======
# k-NN (k-Nearest Neighbours)
#======
#"preProcess" in order to normalize with "center" and "scale" (something like z-score-normalization)
#“center“: subtract mean from values.
#“scale“: divide values by standard deviation.
#knnFit <- train(frmla, data=json_features_all_pcaps_df, method = "knn", trControl=train_ctrl, preProcess = c("center", "scale"), tuneLength = 10)
# 1-30 NN
knnFit <- train(frmla, data=json_features_all_pcaps_df, method = "knn", trControl=train_ctrl, preProcess = c("center", "scale"), tuneGrid = expand.grid(.k=1:30))
# only 1-NN
#knnFit <- train(frmla, data=json_features_all_pcaps_df, method = "knn", trControl=train_ctrl, preProcess = c("center", "scale"), tuneGrid = expand.grid(.k=1)) 1NN

plot(knnFit)
knnFit
knnFit$finalModel
knnFit$results
knnFit$bestTune
knnFit$pred[order(knnFit$pred$Resample, knnFit$pred$rowIndex),]
confusionMatrix(knnFit)



#########################
##  Decision Tree results
#########################
print(tree_model)
plot(tree_model)
summary(tree_model)

# Normal tree plots
plot(tree_model$finalModel)
text(tree_model$finalModel)

# Extra info
# Training Data
#print(tree_model$trainingData)   # <-- Works, but shows all the data used in totality

# Resampling parameters
#print(tree_model$resample)
tree_model$resample

# Predictions and Observations from the k-fold cross validation
#print(tree_model$pred)     # <-- Works but shows all the samples with different "cp" values (Complexity parameter) 
#### Fixed after setting the "savePredictions" and the "returnSamp" to "final" to save only the final predictions (corrects the error above and below)
tree_model$pred[order(tree_model$pred$Resample, tree_model$pred$rowIndex),]            # <-- Works but shows all the samples with different "cp" values (Complexity parameter)
tree_model$results
tree_model$bestTune
tree_model$finalModel$splits

tree_model$method
#print(tree_model$modelInfo)

# Confusion Matrix
print("Confusion Matrices for training model")
confusionMatrix(tree_model)
confusionMatrix(data=tree_model$pred$pred, reference = tree_model$pred$obs)

# Fancy Plot from "rattle" package
library("rattle")
library(rpart.plot)
fancyRpartPlot(tree_model$finalModel)
