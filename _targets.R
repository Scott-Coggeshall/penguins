library(targets)
library(tarchetypes)
source("r/clean_data.r")
source("r/fit_model_year.r")
tar_option_set(packages = c("dplyr", "ggplot2", "gt", "gtsummary"))

list(
  tar_target(penguins_data_file, 'data/penguins.csv', format = "file"),
  tar_target(penguins_data_raw, read.csv(penguins_data_file)),
  tar_target(penguins_data_cleaned, clean_data(penguins_data_raw)),
  tar_target(penguins_plot, penguins_data_cleaned %>% 
               ggplot(aes(x = bill_length_mm, y = bill_depth_mm)) + 
               geom_point(aes(color = species)) ),
  tar_render(report, "report.rmd"),
  tar_target(bill_length_model, lm(bill_length_mm ~ bill_depth_mm, 
                                   data = penguins_data_cleaned)),
  tar_target(bill_length_model_2018, lm(bill_length_mm ~ bill_depth_mm,
                                        data = penguins_data_cleaned %>%
                                          filter(year == 2008))),
  tar_target(bill_length_model_summarytable, tbl_regression(bill_length_model)),
  tar_target(years, unique(penguins_data_cleaned$year)),
  tar_target(bill_length_models, fit_model_year(penguins_data_cleaned, years), 
             pattern = map(years), iteration = "list")
  
)
