# abundance
library(plotrix)


mean_per_cell_dat <- filtered_data %>% left_join(survey_data_meta %>% 
                                                   filter(grid_size == "500*500") %>% 
                                                   rename(grid_position = `grid_pos (site id)`),
                                                 #transmute(replicate_number = as.numeric(replicate_number)),
                                                 by = c("grid_position", "replicate_number")) %>% 
  group_by(grid_position) %>%
  summarise(
    n_razors = n(),
    replicates = max(as.numeric(replicate_number)),
    mean_abundance_per_5sects = n() / max(as.numeric(replicate_number)),
    mean_weight_per_animal = mean(weight_g, na.rm = TRUE),
    mean_shell_length_per_5sects = mean(shell_length, na.rm = TRUE),
    sd_shell_length_pr_5sects = sd(shell_length, na.rm = TRUE),
    mean_speed = mean(speed_knots, na.rm = TRUE)
    
  )
