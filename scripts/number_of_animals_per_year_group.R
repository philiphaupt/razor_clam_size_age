# count the number of animals in each year class.
total_records <- nrow(survey_dat)
survey_dat %>% 
  group_by(age_years) %>% 
  summarise((number_in_age_class = n()/total_records)*100)




survey_dat %>% summarise(mean_shell_length = mean(shell_length, na.rm = TRUE), sd_shell_length = sd(shell_length))
