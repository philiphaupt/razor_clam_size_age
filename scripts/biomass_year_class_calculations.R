# Biomass - Year class analysis

biomass_dat <- survey_dat %>% 
  group_by(grid_position, age_years, shell_length_category) %>% 
  summarise(mean_weight = mean(weight_g, na.rm = TRUE),
            abundance_per_subsample = n()/max(as.numeric(replicate_number)),
            subsample_area = first(subsample_area),
            std_fct_area = first(stdz_fct_area),
            density_std = abundance_per_subsample/first(subsample_area)*first(stdz_fct_area))#to make it per meter square)

# 500 cap for density outliers
biomass_dat_outlier_adapted <- biomass_dat %>%
  ungroup() %>% 
  mutate(density_std_oa = ifelse(density_std > 500, 500, density_std),
         abundance_grid_cell = (density_std_oa*250000)/1000000, # millions
         biomass_square_meter = density_std*mean_weight, #grams per square meter
         biomass_per_grid_cell = (biomass_square_meter*250000)/1000000) # biomass per 500 * 500 m grid cell.

#plot

grid_cell_biomass_abundance_plot <- ggplot(biomass_dat_outlier_adapted, aes(x = biomass_per_grid_cell, y = abundance_grid_cell)) +
  geom_point(aes(fill = as.factor(shell_length_category), col = as.factor(shell_length_category)), pch = 21, cex = 3.5) +
  scale_fill_manual(values = c("skyblue", "salmon" )) +
  scale_color_manual(values = c("skyblue", "salmon")) +
  labs(x = "Biomass (tonnes) per grid cell", y = "Abundance in grid cell (Millions)", fill = "Shell Length with reference to MCRS", col = "Shell Length with reference to MCRS") +
  ggtitle("Biomass and Abundance in 28 grid cells for over and under 100 mm razor clams") +
  theme_bw() +
  guides(fill = guide_legend(title = "Shell Length with\nreference to MCRS"), col = guide_legend(title = "Shell Length with\nreference to MCRS"))

print(grid_cell_biomass_abundance_plot)


# Save the plot
ggsave("./outputs/grid_cell_biomass_abundance_plot.png", grid_cell_biomass_abundance_plot, width = 16.5, height = 16.5, units = "cm")

# violin plots
biomass_violin_plot <- ggplot(biomass_dat_outlier_adapted, aes(x = biomass_per_grid_cell, y = shell_length_category)) +
  geom_violin(aes(fill = shell_length_category)) +
  scale_fill_manual(values = c("skyblue", "salmon")) +
  labs(x = "Biomass (tonnes) per grid cell", y = "Shell Length with reference to MCRS", fill = "Shell Length with reference to MCRS") +
  theme_bw()+
  xlim(0, 500)

biomass_violin_plot
# save
ggsave("./outputs/grid_cell_biomass_violin_plot.png", biomass_violin_plot, width = 16.5, height = 16.5, units = "cm")

biomass_dat_outlier_adapted %>% ungroup() %>% group_by(shell_length_category) %>% summarise(sum(biomass_per_grid_cell))
# area plots
biomass_area_plot <- ggplot(biomass_dat_outlier_adapted, aes(x = biomass_per_grid_cell, y = shell_length_category)) +
  geom_area(aes(fill = shell_length_category)) +
  scale_fill_manual(values = c("skyblue", "salmon")) +
  labs(x = "Biomass (tonnes) per grid cell", y = "Shell Length with reference to MCRS", fill = "Shell Length with reference to MCRS") +
  theme_bw()
biomass_area_plot
