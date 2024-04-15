# count the number of animals in each year class.
total_records <- nrow(filtered_data)
filtered_data %>% group_by(age_years) %>% 
  summarise((number_in_age_class = n()/total_records)*100)
