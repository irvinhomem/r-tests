# Testing scripts in R
dirname(getwd())

concat_str = paste("string 1", "string 2", sep="/")

#paste(dirname(getwd()), "Datasets/JSON-4-Classes", sep="/")
dataset_path = paste(dirname(getwd()), "Datasets/JSON-4-Classes", sep="/")

#paste(dataset_path, "HTTPovDNS-Static/All", sep="/")
http_ov_dns_path = paste(dataset_path, "HTTPovDNS-Static/All", sep="/")

http_ov_dns_files <- list.files(path=http_ov_dns_path, pattern="*.json", full.names=TRUE, recursive=TRUE, include.dirs = TRUE )
http_ov_dns_files[2]
