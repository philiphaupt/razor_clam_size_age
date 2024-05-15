# Weight v Shell Length
library(tidyverse)

# Take the natural logarithm of weight_g and shell_length
survey_dat$log_weight_g <- log(survey_dat$weight_g)
survey_dat$log_shell_length <- log(survey_dat$shell_length)

# Fit a linear regression model
linear_model <- lm(log_weight_g ~ log_shell_length, data = survey_dat)

# Get the coefficients
intercept <- coef(linear_model)[1]  # Intercept (log(a))
slope <- coef(linear_model)[2]      # Slope (b)

# Calculate 'a' by exponentiating the intercept
a <- exp(intercept)

# Print the values of a and b
print(a)   # Value of 'a'
print(slope)  # Value of 'b'
#-----------------------
# Fit a linear regression model to get the coefficients 'a' and 'b'
linear_model <- lm(log(weight_g) ~ log(shell_length), data = survey_dat)

# Extract coefficients
a <- exp(coef(linear_model)[1])
b <- coef(linear_model)[2]

# Generate predicted values using the equation W = aL^b
survey_dat$predicted_weight <- a * survey_dat$shell_length^b

# Scatter plot with the fitted line
scatter_plot_with_fit <- ggplot(survey_dat, aes(x = shell_length, y = weight_g, col = shell_length_category)) +
  geom_point(size =1.75, alpha = 0.6) +  # Add points
  geom_line(aes(y = predicted_weight), color = "grey44", linetype = "dashed", linewidth = 1.1, alpha = 0.5) +  # Add fitted line
  theme_bw() +  # Apply a black and white theme
  scale_color_manual(values = c("skyblue", "salmon"), name = "Shell Length with\nreference to MCRS")+
  xlab("Shell length (mm)") +  # Label x-axis
  ylab("Weight (g)") +  # Label y-axis
  #labs(col = "Shell Length Category")+  # Modify legend title
  ggtitle(paste0("Weight vs Shell Length with Fitted Line from W = ",round(a,5),"L^",round(b,2)))  # Add a title

# Print the scatter plot with fitted line
print(scatter_plot_with_fit)

# Save the plot
ggsave("./outputs/weight_vs_shell_length_with_vBertalanffy_fit.png", scatter_plot_with_fit, width = 16, height = 16, units = "cm")

  #
# Calculate the mean weight for each category of shell length
# Calculate mean weight by category
mean_weight_by_category <- survey_dat %>%
  group_by(shell_length_category) %>%
  summarise(
    mean_weight = mean(weight_g),
    sd_weight = sd(weight_g)  # Calculate standard deviation
  )

# Print the mean weight for each category
print(mean_weight_by_category)

