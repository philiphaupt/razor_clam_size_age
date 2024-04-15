# Join data sets

survey_dat <- filtered_data %>% left_join(survey_data_meta %>% 
                              filter(grid_size == "500*500") %>% 
                              rename(grid_position = `grid_pos (site id)`),
                            #transmute(replicate_number = as.numeric(replicate_number)),
                            by = c("grid_position", "replicate_number"))


rm(filtered_data, mean_shell_length_by_group, size_age_data)
