fit_model_year <- function(data, year_val){
  
  lm(bill_length_mm ~ bill_depth_mm, 
     data = data %>% filter(year == year_val))
  
  
}