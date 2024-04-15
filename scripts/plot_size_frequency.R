#Aim: plot a size distribution plot of razor clams

library(tidyverse)

mcrs = 100

# Calculate mean shell length by age_group
mean_shell_length_by_group <- survey_dat %>%
  filter(shell_length > 0, !is.na(age_years)) %>% 
  group_by(age_group) %>%
  summarise(mean_shell_length = mean(shell_length, na.rm = TRUE))





# Create the SHELL LENGTH histogram plot by AGE CLASS with colored fill
size_dist_plot <- ggplot(data = survey_dat, 
                         aes(x = shell_length, fill = age_group)
                         ) +
  geom_histogram(
    binwidth = 5,
    col = "black",
    alpha = 0.9
  ) +
  scale_fill_discrete(name = "Age Year Class") +  # Customize legend title and fill colors
  theme_bw() +
  ylab("Number of razor clams") +
  xlab("Shell length (mm)") +
  geom_vline(
    data = mean_shell_length_by_group,
    aes(xintercept = mean_shell_length),
    
    color = "black",  # Set color of dashed lines
    linetype = "dashed",
    linewidth = 1
  ) +
  geom_vline(
    aes(xintercept = mcrs),
    color = "#FC4E07",
    linewidth = 1
  ) +
  #scale_color_manual(values = unique(size_age_data_filtered$age_group)) +  # Assign colors for dashed lines
  theme(text = element_text(size = 10)) +
  facet_wrap(~age_group, ncol = 1)  # Facet by modified age_group labels

# Print the plot
print(size_dist_plot)

# Save the plot
ggsave("./outputs/age_group_histogram_with_modified_labels.png", size_dist_plot, width = 16.5, height = 16.5, units = "cm")

#-----------------------------------
# SHELL LENGTH HISTOGRAM
shell_length_histo <- ggplot(data = survey_dat, 
                         aes(x = shell_length
                             )
) +
  geom_histogram(
    binwidth = 5,
    col = "black",
    fill = "cornflowerblue",
    alpha = 0.9
  ) +
  #scale_fill_discrete(name = "Age Year Class") +  # Customize legend title and fill colors
  theme_bw() +
  ylab("Number of razor clams") +
  xlab("Shell length (mm)") +
  # geom_vline(
  #   data = mean_shell_length_by_group,
  #   aes(xintercept = mean_shell_length),
  #   
  #   color = "black",  # Set color of dashed lines
  #   linetype = "dashed",
  #   size = 1
  # ) +
  geom_vline(
    aes(xintercept = mcrs),
    color = "#FC4E07",
    linewidth = 1
  ) +
  theme(text = element_text(size = 10))


shell_length_histo
# Save the plot
ggsave("./outputs/shell_length_histogram.png", size_dist_plot, width = 16.5, height = 16.5, units = "cm")



#------------------
# calculate percentage of animals smaller than 100 mm
# Calculate total number of animals
total_animals <- nrow(survey_dat)

# Calculate number of animals below 100mm
below_100mm <- survey_dat %>%
  filter(shell_length < 100) %>%
  nrow()

# Calculate percentage of animals below 100mm
percentage_below_100mm <- (below_100mm / total_animals) * 100

# Print the results
cat("Total number of animals:", total_animals, "\n")
cat("Number of animals below 100mm:", below_100mm, "\n")
cat("Percentage of animals below 100mm:", percentage_below_100mm, "%\n")
