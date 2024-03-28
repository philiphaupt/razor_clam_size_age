#Aim: plot a size distribution plot of razor clams

library(tidyverse)

mcrs = 100

# Calculate the mean shell length
mean_shell_length <- size_age_data %>%
  filter(shell_length > 0) %>%
  summarise(mean_length = mean(shell_length, na.rm = TRUE),
            #modal_length = mode(shell_length, na.rm = TRUE)
            ) %>%
  pull(mean_length)

# Create the histogram plot
size_dist_plot <- ggplot(data = size_age_data %>% filter(shell_length> 0), 
                         aes(x = shell_length)) +
  geom_density(col = "black") +
  geom_histogram(
    binwidth = 5,
    col = "black",
    fill = "cornflowerblue",
    alpha = 0.9
  ) +
  theme_bw() +
  ylab("Number of razor clams") + #"Density")+#
  xlab("Shell length length (mm)") +
  # geom_vline(aes(xintercept = 70),color = "#FC4E07",
  #            linetype = "dashed",
  #            linewidth = 1)+
   geom_vline(
     aes(
       xintercept = mean_shell_length),
       color = "black",
       linetype = "dashed",
       size = 1
     ) +
  geom_vline(
    aes(
      xintercept = mcrs),
    color = "#FC4E07",
    #linetype = "dashed",
    size = 1
  ) +
  theme(text = element_text(size = 10))+
  facet_wrap(~age_years)
size_dist_plot

ggsave("./outputs/razor_survey_size_distribution_by_age.png", size_dist_plot, width = 16.5, height = 11, units = "cm")

# oyster_size %>% dplyr::filter(common_name == "native oyster", year_surveyed %in% c(2022, 2023)) %>% arrange(desc(length_mm))
