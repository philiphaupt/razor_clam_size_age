# abundance

filtered_data %>% 
  group_by(grid_position) %>% 
  summarise(mean_abundance_per_5sects = n()/max(replicate_number),
            mean_weight_per_animal = mean(weight_g),
            )
  