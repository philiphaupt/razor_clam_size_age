library(ggplot2)



# Assuming your data frame is named size_age_data
# You can adjust aes() and other parameters as needed

scatter_plot <- ggplot(data = filtered_data, aes(x = shell_length, y = age_years)) +
  geom_point(color = "blue") +  # Customize the points
  theme_bw() +  # Apply a black and white theme
  xlab("Shell length (mm)") +  # Label x-axis
  ylab("Age (years)") +  # Label y-axis
  ggtitle("Age vs Shell Length") + theme(text = element_text(size = 10)) # Add a title to the plot

# Print the scatter plot
print(scatter_plot)
#
ggsave("./outputs/age_vs_shell_length_scatter.png", scatter_plot, width = 16.5, height = 11, units = "cm")



scatter_plot <- ggplot(data = filtered_data, aes(x = shell_length, y = weight_g)) +
  geom_point(color = "green") +  # Customize the points
  theme_bw() +  # Apply a black and white theme
  xlab("Shell length (mm)") +  # Label x-axis
  ylab("Weight (g)") +  # Label y-axis
  ggtitle("Weight vs Shell Length") +
 theme(text = element_text(size = 10)) # Add a title to the plot

# Print the scatter plot
print(scatter_plot)


# Save the scatter plot
ggsave("./outputs/age_vs_shell_length_scatter.png", scatter_plot, width = 16.5, height = 11, units = "cm")

# with glm


# Now you can proceed with fitting your model or creating plots using the filtered_data

# Fit a log-link GLM
glm_model <- glm(age_years ~ log(shell_length), data = filtered_data, family = gaussian(link = "log"))

# Predicted values from the model
predicted_values <- predict(glm_model, type = "response")

# Add predicted values to the original data frame
size_age_data$predicted_age <- predicted_values

# Scatter plot with fitted line
scatter_plot_with_fit <- ggplot(size_age_data, aes(x = shell_length, y = age_years)) +
  geom_point(color = "blue") +  # Add points
  geom_line(aes(y = predicted_age), color = "red", linetype = "dashed") +  # Add fitted line
  theme_bw() +  # Apply a black and white theme
  xlab("Shell length (mm)") +  # Label x-axis
  ylab("Age (years)") +  # Label y-axis
  ggtitle("Age vs Shell Length with Log-Link GLM Fit")  # Add a title

# Print the scatter plot with fitted line
print(scatter_plot_with_fit)

# Save the plot
ggsave("./outputs/age_vs_shell_length_with_glm_fit.png", scatter_plot_with_fit, width = 16.5, height = 11, units = "cm")
