import pandas as pd
import rpy2.robjects as ro
from rpy2.robjects import pandas2ri
from rpy2.robjects.conversion import localconverter

# Defining the R script and loading the instance in Python
r = ro.r
r['source']('rpy_try.R')
# Loading the function we have defined in R.
train_function_r = ro.globalenv['rpy_try']
x_tactic = ro.vectors.StrVector(['consumer_crm', 'consumer_website'])
x_confounder = ro.vectors.StrVector(['trend'])

result_r = train_function_r(KEY_ID = 'minio', ACCESS_KEY = 'minio123', object = '/dataset_groups/18/Vizuro_data.csv', 
                            bucket = 'client', time_stamp = 'time_stamp', segment_value = 'state', y_var = 'total_rx',
                            x_tactic = x_tactic, x_confounder = x_confounder,
                            price_object = ro.r("NULL"), grouping_object = ro.r("NULL"))
print(result_r)

