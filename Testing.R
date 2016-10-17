library("rjson")

# Testing scripts in R
dirname(getwd())

concat_str = paste("string 1", "string 2", sep="/")

# paste(dirname(getwd()), "Datasets/JSON-4-Classes", sep="/")
dataset_path = paste(dirname(getwd()), "Datasets/JSON-4-Classes", sep="/")

# paste(dataset_path, "HTTPovDNS-Static/All", sep="/")
http_ov_dns_path = paste(dataset_path, "HTTPovDNS-Static/All", sep="/")

http_ov_dns_files <- list.files(path=http_ov_dns_path, pattern="*.json", full.names=TRUE, recursive=TRUE, include.dirs = TRUE )

# Test collection of JSON data from a single file
json_data_single <- fromJSON(file=http_ov_dns_files[1])

# Convert json to data frame (may fail due to differing lengths of rows)
#json_single_data_frame <- as.data.frame(json_data_single)

typeof(json_data_single)

# Get values if a particular parameter from the json
json_data_single[[1]]
json_data_single$filename

json_data_single[[2]]
json_data_single$`pcap-Md5-hash`

json_data_single[[3]][[1]]$feature_name
json_data_single$props[[1]]$feature_name
