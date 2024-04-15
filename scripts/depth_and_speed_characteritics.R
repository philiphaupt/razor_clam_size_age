speed_per_5sects <- survey_data_meta %>% 
  filter(grid_size == "500*500") %>% 
  # group_by(`grid_pos (site id)`) %>% # to get mean per grid
  summarise(mean_speed_kts = mean(as.numeric(speed_knots), na.rm = TRUE))# *0.514444 to convert to meter per second




# depth
sampled_depth_characteristics <-  summary(survey_data_meta$depth_ft)*0.3048 # to convert to meters *0.3048
