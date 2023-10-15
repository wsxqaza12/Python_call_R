library(minio.s3)

minIOenv <- function(KEY_ID, ACCESS_KEY, bucket) {
  Sys.setenv("AWS_ACCESS_KEY_ID" = KEY_ID,
             "AWS_SECRET_ACCESS_KEY" = ACCESS_KEY,
             "AWS_DEFAULT_REGION" = "us-east-1",
             "AWS_S3_ENDPOINT" = "192.168.50.3:39000")
  Sys.setenv("minIO_bucket" = bucket)
}


minIOread <- function(object) {
  s3read_using(FUN = read.csv,
               object = object,
               bucket = Sys.getenv("minIO_bucket"),
               opts = list(use_https = F))
}

get_data <- function(object = object,
                     y_var = parent.frame()$y_var, 
                     x_tactic = parent.frame()$x_tactic,
                     env = parent.frame()) {
  
  if (!is.null(object)){
    minIOread(object)
  }
  else {
    object_name <- deparse(substitute(object))
    switch(object_name,
           "object" = stop(),
           "price_object" = fake_price(y_var, x_tactic),
           "grouping_object" = fake_grouping(x_tactic))
  }
}

object_is_exists <- function(x, env = parent.frame()$env) {
  exists(x, envir = env, inherits = FALSE)
}


fake_price <- function(y_var, x_tactic) {
  data.frame("name" = c(y_var, x_tactic),
             "type" = "other",
             "price" = 1)
}

fake_grouping <- function(x_tactic) {
  data.table("group_level" = "tactic",
             "tactic_group_name" = x_tactic,
             "tactic_name" = x_tactic,
             "tactic_group_category" = "Consumer")
}


