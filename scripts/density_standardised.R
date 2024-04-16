library(ggplot2)
library(mgcv)
library(dplyr)
# Density calculations - standardised

std_dat_summary <- survey_dat %>% 
  group_by(grid_position, age_years) %>% 
  summarise(abundance_per_subsample = n()/max(as.numeric(replicate_number)),
            std_area_test = first(stdz_fct_area),
            density_std = abundance_per_subsample/first(subsample_area)*first(stdz_fct_area),#to make it per meter square
            mean_shell_length = mean(shell_length, na.rm = TRUE),
            mean_weight = mean(weight_g, na.rm = TRUE))

print(std_dat_summary)


# simplifoed standardised summary
std_dat_summary %>% 
  ungroup() %>% 
  #group_by() %>% 
  summarise(mean_density = mean(density_std, na.rm = TRUE),
            mean_shell_length_overall = mean(mean_shell_length, na.rm = TRUE), # this does not recognize density but rather averages per year class per grid and then averaged again - so not good representation.
            mean_weight_overall = mean(mean_weight, na.rm = TRUE) # this does not recognize density but rather averages per year class per grid and then averaged again - so not good representation.
            )


# Assuming std_dat_summary is already calculated

# Plot density per mean shell length
density_plot_shell_length <- ggplot(std_dat_summary, aes(x = mean_shell_length, y = density_std)) +
  geom_point() +
  #geom_smooth(method = "lm", se = FALSE) +  # Add a linear regression line
  labs(x = "Mean Shell Length", y = "Density") +
  ggtitle("Density per Mean Shell Length") +
  theme_bw()

# Print the plot
print(density_plot_shell_length)


#------------------
# With fitted GAM

# Fit a GAM with a Gaussian distribution
gam_model <- gam(density_std ~ s(mean_shell_length), data = std_dat_summary, family = gaussian())

# Generate predicted values from the GAM model
std_dat_summary$predicted_density <- predict(gam_model, newdata = std_dat_summary)

# Plot the data and the fitted curve
density_plot_shell_length_gam <- ggplot(std_dat_summary, aes(x = mean_shell_length, y = density_std)) +
  geom_point(aes(),pch = 21, cex = 2.5, col = "goldenrod2", fill = "goldenrod2", alpha = 0.65) +
  geom_line(aes(y = predicted_density), color = "cornflowerblue", linewidth = 0.63) +
  labs(x = "Shell Length (mm)", y = "Density N animals/square meter") +
  ggtitle("Density per Mean Shell Length (GAM with Gaussian Distribution)") +
  theme_bw()

# Print the plot
print(density_plot_shell_length_gam)

# Save the plot
ggsave("./outputs/density_shell_length_gam_plot.png", density_plot_shell_length_gam, width = 16.5, height = 16.5, units = "cm")

## Otuliers need removing:
# Calculate mean and standard deviation of density_std
mean_density_std <- mean(std_dat_summary$density_std, na.rm = TRUE)
sd_density_std <- sd(std_dat_summary$density_std, na.rm = TRUE)

# Define threshold for outliers (e.g., 3 standard deviations away from the mean)
threshold <- 3

# Filter out rows with density_std values beyond the threshold
std_dat_summary_filtered <- std_dat_summary %>%
  filter(density_std <= mean_density_std + threshold * sd_density_std,
         density_std >= mean_density_std - threshold * sd_density_std)

# Plot density per mean shell length with outliers removed
density_plot_shell_length_filtered <- ggplot(std_dat_summary_filtered, aes(x = mean_shell_length, y = density_std)) +
  geom_point() +
  labs(x = "Mean Shell Length", y = "Density") +
  ggtitle("Density per Mean Shell Length (Outliers Removed)") +
  theme_bw()

# Print the plot
print(density_plot_shell_length_filtered)


#------------------
# With fitted GAM

# Fit a GAM with a Gaussian distribution using the filtered data
gam_model <- gam(density_std ~ s(mean_shell_length), data = std_dat_summary_filtered, family = gaussian())

# Generate predicted values from the GAM model using the filtered data
std_dat_summary_filtered$predicted_density <- predict(gam_model, newdata = std_dat_summary_filtered)

# Plot the data and the fitted curve using the filtered data
density_plot_shell_length_gam <- ggplot(std_dat_summary_filtered, aes(x = mean_shell_length, y = density_std)) +
  geom_point(aes(),pch = 21, cex = 2.5, col = "goldenrod2", fill = "goldenrod2", alpha = 0.65) +
  geom_line(aes(y = predicted_density), color = "cornflowerblue", linewidth = 0.63) +
  labs(x = "Shell Length (mm)", y = "Density N animals/square meter") +
  #ggtitle("Density per Shell Length (GAM with Gaussian Distribution)") +
  theme_bw()

# Print the plot
print(density_plot_shell_length_gam)

# Save the plot
ggsave("./outputs/density_shell_length_gam_plot.png", density_plot_shell_length_gam, width = 16.5, height = 16.5, units = "cm")


# Fit a GAM with a Gaussian distribution using the filtered data
#gam_model <- gam(density_std ~ s(mean_shell_length), data = std_dat_summary_filtered, family = gaussian())

# Get model summary
summary_gam <- summary(gam_model)

# Extract AIC value
aic_value <- summary_gam$aic

# Print AIC value
print(aic_value)

# Get residual deviance (assuming summary_gam$deviance already represents residual deviance)
residual_deviance <- summary_gam$deviance

# Get number of parameters (including smoothing terms and parametric coefficients)
num_parameters <- summary_gam$edf

# Calculate AIC
aic_value <- -2 * logLik(gam_model) + 2 * num_parameters

# Print AIC value
print(aic_value)
