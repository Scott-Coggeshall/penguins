clean_data <- function(penguins_data_raw){
  
  penguins_data <- penguins_data_raw %>% mutate(body_mass_kg = body_mass_g/1000)
  
  penguins_data <- penguins_data %>% mutate(across(c(species, island, sex), factor))
  
  penguins_data %>% filter(species != "Adelie")
}