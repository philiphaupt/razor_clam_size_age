# Calculations for standardsing results

survey_dat <- survey_dat %>% 
  mutate(speed_knots = if_else(is.na(speed_knots), 0.7, speed_knots)) %>% 
  mutate(stdz_fctr = `subsample_time (5s)`/5, #based on duration of sampling event: if 5 seconds then 5/5 = 1
         subsample_dist_std = (speed_knots*0.514444)/stdz_fctr,
         subsample_area_std = 0.76*subsample_dist_std,
         stdz_fct_area = 1.0/subsample_area_std # 1 meter square divided by the actual surface area sampled 
         ) %>% 
  mutate(shell_length_category = ifelse(shell_length < 100, "Under 100mm", "100mm and Over"))

#urvey_dat %>% select(subsample_area) %>% distinct()

