rpy_try <- function(UID,
                    time_stamp,
                    segment_value,
                    y_var,
                    x_tactic,
                    x_confounder,
                    group_id,
                    n_tree = 500,
                    algorithm = "rF",
                    model_type,
                    model_name) {

  library(dplyr)
  library(data.table)
  library(randomForest)
  library(lubridate)
  library(jsonlite)
  library(ids)

  #--- 2.1 Pre-processing  ---------------------
  data_csv <- data_preprocess(data_csv = data_csv,
                              y_var = y_var,
                              x_var = x_var,
                              time_stamp = time_stamp,
                              segment_value = segment_value)


  # #--- 2.2 Fit model  --------------------------
  mmm_fit <- mmm_model(dt_data = data_csv,
                       y_var = y_var,
                       x_vars = x_var,
                       algorithm = algorithm,
                       n_tree = n_tree)

  dt_forecast <- mmm_forecast(fit_rf = mmm_fit,
                              dt_data = data_csv,
                              y_var = y_var,
                              x_vars = x_var,
                              x_metrics = x_var_num,
                              col_seg = segment_value)

  impact <- mmm_impact(fit_rf = mmm_fit,
                       dt_data = data_csv,
                       x_vars = x_var,
                       x_metric_groups = x_var_num)


  #--- 2.3 Weighted average attribution  --------------------------
  # Correlation matrix
  corr <- generate_corr(dt_data = data_csv,
                        seg = segment_value,
                        y_var = y_var,
                        x_metric_groups = x_var_num,
                        analytic_period = analytic_period)

  corr_analytic <- generate_corr_analytic(corr = corr,
                                          y_var = y_var,
                                          seg = segment_value)

  costs_analytic <- generate_costs_analytic(dt_data = data_csv,
                                            x_var_num = x_var_num,
                                            analytic_period = analytic_period)

  # WA
  dt_attr_ratio <- wa_attr_ratio(impact = impact,
                                 corr_analytic = corr_analytic,
                                 costs_analytic = costs_analytic)






  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  #### 4. Response   ##########################
  #~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  return(dt_attr_ratio)
}
