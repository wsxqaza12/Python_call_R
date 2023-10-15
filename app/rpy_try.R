rpy_try <- function(KEY_ID,
                    ACCESS_KEY, 
                    object, 
                    bucket,
                    price_object,
                    grouping_object,
                    time_stamp,
                    segment_value,
                    y_var,
                    x_tactic,
                    x_confounder,
                    # group_id,
                    # ...,
                    n_tree = 500,
                    algorithm = "rF") {
  
  library(dplyr)
  library(data.table)
  library(randomForest)
  library(lubridate)
  source("minio.R")

  minIOenv(KEY_ID, ACCESS_KEY, bucket)
  

  #--- 1.1 data ------------------------------
  data_csv <- get_data(object = object)
  list(results = data_csv)
}
