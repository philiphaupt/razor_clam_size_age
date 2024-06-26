library(tidyverse)

# Shell Length - AGE
scatter_plot <- ggplot(data = survey_dat, aes(x = shell_length, y = age_years)) +
  geom_point(color = "blue") +  # Customize the points
  theme_bw() +  # Apply a black and white theme
  xlab("Shell length (mm)") +  # Label x-axis
  ylab("Age (years)") +  # Label y-axis
  ggtitle("Age vs Shell Length") + theme(text = element_text(size = 10)) # Add a title to the plot

# Print the scatter plot
print(scatter_plot)
#


# Fit a log-link GLM
glm_model <- glm(age_years ~ log(shell_length), data = survey_dat, family = gaussian(link = "log"))

# Predicted values from the model
predicted_values <- predict(glm_model, type = "response")

# Add predicted values to the original data frame
survey_dat$predicted_age <- predicted_values

# Scatter plot with fitted line
scatter_plot_with_fit <- ggplot(survey_dat, aes(x = shell_length, y = age_years)) +
  geom_point(color = "skyblue3") +  # Add points
  geom_line(aes(y = predicted_age), color = "red4", linetype = "dashed") +  # Add fitted line
  theme_bw() +  # Apply a black and white theme
  xlab("Shell length (mm)") +  # Label x-axis
  ylab("Age (years)") +  # Label y-axis
  ggtitle("Age vs Shell Length with Log-Link GLM Fit")  # Add a title

# Print the scatter plot with fitted line
print(scatter_plot_with_fit)

# Save the plot
ggsave("./outputs/age_vs_shell_length_with_glm_fit.png", scatter_plot_with_fit, width = 16, height = 16, units = "cm")

