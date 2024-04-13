#Aim: plot a size distribution plot of razor clams

library(tidyverse)

mcrs = 100

# Discretize age_years into groups
size_age_data_filtered <- size_age_data %>%
  filter(shell_length > 0, !is.na(age_years)) %>% 
  mutate(age_group = cut(age_years, breaks = 6))  # Adjust the number of breaks as needed

# Modify the levels of age_group
size_age_data_filtered$age_group <- factor(size_age_data_filtered$age_group,
                                  levels = c("(2.49,3.5]", "(3.5,4.5]", "(4.5,5.5]",
                                             "(5.5,6.5]", "(6.5,7.5]", "(7.5,8.51]"),
                                  labels = c("2 - 3 year class", "3 - 4 year class",
                                             "4 - 5 year class", "5 - 6 year class",
                                             "6 - 7 year class", "7 - 8 year class"))


# Calculate mean shell length by age_group
mean_shell_length_by_group <- size_age_data_filtered %>%
  filter(shell_length > 0, !is.na(age_years)) %>% 
  group_by(age_group) %>%
  summarise(mean_shell_length = mean(shell_length, na.rm = TRUE))





# Create the SHELL LENGTH histogram plot by AGE CLASS with colored fill
size_dist_plot <- ggplot(data = size_age_data_filtered, 
                         aes(x = shell_length, fill = age_group)
                         ) +
  geom_histogram(
    binwidth = 6,
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
    size = 1
  ) +
  geom_vline(
    aes(xintercept = mcrs),
    color = "#FC4E07",
    size = 1
  ) +
  #scale_color_manual(values = unique(size_age_data_filtered$age_group)) +  # Assign colors for dashed lines
  theme(text = element_text(size = 10)) +
  facet_wrap(~age_group, ncol = 1)  # Facet by modified age_group labels

# Print the plot
print(size_dist_plot)

# Save the plot
ggsave("./outputs/age_group_histogram_with_modified_labels.png", size_dist_plot, width = 16.5, height = 16.5, units = "cm")

#
# Create the histogram plot with colored fill
# size_dist_plot <- ggplot(data = size_age_data_filtered, 
#                          aes(x = shell_length, fill = age_group)
# ) +
#   geom_histogram(
#     binwidth = 6,
#     col = "black",
#     alpha = 0.9
#   ) +
#   scale_fill_discrete(name = "Age Year Class") +  # Customize legend title and fill colors
#   theme_bw() +
#   ylab("Number of razor clams") +
#   xlab("Shell length (mm)") +
#   geom_vline(
#     data = mean_shell_length_by_group,
#     aes(xintercept = mean_shell_length, color = "Mean Shell Length"),  # Define color aesthetic
#     linetype = "dashed",
#     size = 1
#   ) +
#   geom_vline(
#     aes(xintercept = mcrs, color = "Minimum landing size (100 mm)"),  # Define color aesthetic
#     linetype = "solid",
#     size = 1
#   ) +
#   scale_color_manual(name = "Legend", values = c("Mean Shell Length" = "black", "Minimum landing size (100 mm)" = "#FC4E07")) +  # Assign colors and legend labels
#   theme(text = element_text(size = 10)) +
#   facet_wrap(~age_group, ncol = 1)  # Facet by modified age_group labels
# print(size_dist_plot)


#-----------------------------------
# SHELL LENGTH HISTOGRAM
shell_length_histo <- ggplot(data = size_age_data_filtered, 
                         aes(x = shell_length
                             )
) +
  geom_histogram(
    binwidth = 6,
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
    size = 1
  ) +
  theme(text = element_text(size = 10))


shell_length_histo
# Save the plot
ggsave("./outputs/shell_length_histogram.png", size_dist_plot, width = 16.5, height = 16.5, units = "cm")
getwd()
