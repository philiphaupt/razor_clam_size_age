# Explore and print relationship between shell length and weight using a GAM
library(tidyverse)

# Fit a log-link GLM
glm_model <- glm(weight_g ~ log(shell_length), data = survey_dat, family = gaussian(link = "log"))

# Predicted values from the model
predicted_values <- predict(glm_model, type = "response")

# Add predicted values to the original data frame
survey_dat$predicted_weight <- predicted_values

# Scatter plot with fitted line
scatter_plot_with_fit <- ggplot(survey_dat, aes(x = shell_length, y = weight_g)) +
  geom_point(color = "goldenrod1") +  # Add points
  geom_line(aes(y = predicted_weight), color = "grey44", linetype = "dashed") +  # Add fitted line
  theme_bw() +  # Apply a black and white theme
  xlab("Shell length (mm)") +  # Label x-axis
  ylab("Weight (g)") +  # Label y-axis
  ggtitle("Weight vs Shell Length with Log-Link GLM Fit")  # Add a title

# Print the scatter plot with fitted line
print(scatter_plot_with_fit)

# 
# Save the plot
ggsave("./outputs/weight_vs_shell_length_with_glm_fit.png", scatter_plot_with_fit, width = 16, height = 16, units = "cm")

#--------------------------------
# TEsts weight v shell length
# Assumption 1: Linearity in the Log-Link Function: Check if the relationship between the predictor (logarithm of shell length) and the response (weight) is approximately linear on the log scale.
# 
# Assumption 2: Homoscedasticity: Check if the variance of the residuals is approximately constant across different levels of the predictor.
# 
# Assumption 3: Independence of Residuals: Check if the residuals are independent of each other.
# 
# Goodness of Fit: Evaluate how well the model fits the data using diagnostic plots such as residual plots.
# Load required libraries
library(ggplot2)
library(dplyr)
library(broom)
library(cowplot)  # Load cowplot for plot arrangement
# Fit the GLM
glm_model <- glm(weight_g ~ log(shell_length), data = survey_dat, family = gaussian(link = "log"))

# Get model summary
summary(glm_model)

# Diagnostic checks
# 1. Check linearity assumption
# Scatter plot of residuals vs. fitted values
residuals_vs_fitted <- augment(glm_model) %>%
  ggplot(aes(x = .fitted, y = .resid)) +
  geom_point(color = "darkorange3", alpha = 0.7) +
  geom_hline(yintercept = 0, linetype = "dashed") +
  labs(x = "Fitted values", y = "Residuals") +
  ggtitle("Residuals vs. Fitted Values")

# 2. Check homoscedasticity
# Plot of residuals vs. predictor (log(shell_length))
residuals_vs_predictor <- augment(glm_model) %>%
  ggplot(aes(x = `log(shell_length)`, y = .resid)) +
  geom_point(color = "darkorange3", alpha = 0.7) +
  geom_hline(yintercept = 0, linetype = "dashed") +
  labs(x = "Log(shell_length)", y = "Residuals") +
  ggtitle("Residuals vs. Log(Shell Length)")

# Combine diagnostic plots
diagnostic_plots <- plot_grid(residuals_vs_fitted, residuals_vs_predictor, ncol = 2)

# Print diagnostic plots
print(diagnostic_plots)




