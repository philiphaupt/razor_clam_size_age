# shell length versus shell width across bivalves

# Aim: Assess the relationship between shell length and width

library(tidyverse)


# test plot

survey_dat %>% 
  ungroup() %>% 
  select(shell_length, shell_width, shell_length_category) %>% 
  filter(shell_width != 0, !is.na(shell_width)) %>% 
  ggplot(aes(x = shell_length, y = shell_width, col = shell_length_category))+
  geom_point()+
  scale_color_manual(values = c("skyblue", "salmon"))+
  theme_bw()

#=========
# Plot with GLM fit
survey_dat %>% 
  ungroup() %>% 
  select(shell_length, shell_width, shell_length_category) %>% 
  filter(shell_width != 0, !is.na(shell_width)) %>% 
  ggplot(aes(x = shell_length, y = shell_width, col = shell_length_category)) +
  geom_point() +
  #geom_line(aes(y = fitted_height), linetype = "dashed", linewidth = 1.3) +
  scale_color_manual(values = c("skyblue", "salmon")) +
  theme_bw()

# NOw fit a line to establish relationship
# Fit a GLM
glm_model <- glm(shell_length ~ shell_width, data = survey_dat, family = gaussian())

# Extract predicted values from the GLM model
predicted_values <- predict(glm_model, newdata = survey_dat)

# Add fitted values to the dataset
survey_dat$fitted_width <- predicted_values

#obtain slope
# Get the coefficients of the glm model
coefficients <- coef(glm_model)

# Extract the slope
slope <- coefficients["shell_width"]

# Print the slope
print(slope)

# Extract standard errors
se <- summary(glm_model)$coefficients[, "Std. Error"]

# Create a data frame with coefficients and standard errors
coefficients_df <- data.frame(coef = coefficients, se = se, row.names = NULL)

# Add standard error bars to the plot
# Plot with GLM fit
shell_length_v_width <- survey_dat %>% 
  ungroup() %>% 
  select(shell_length, shell_width, shell_length_category,fitted_height) %>% 
  filter(shell_width >= 12, !is.na(shell_width)) %>% 
  ggplot(aes(y = shell_length, x = shell_width))+
  geom_smooth(method = "glm", method.args = list(family = gaussian),col = "grey53", se = TRUE, size = 1.5, alpha = 0.5) +
  geom_point(aes(col = shell_length_category), size =1.75, alpha = 0.6) +
  scale_color_manual(values = c( "skyblue3", "salmon"), name = "Shell Length with\nreference to MCRS") +
  theme_bw()+
  labs(y = "Shell length (mm)", x = "Shell width (mm)")
#ggtitle("Shell Length relationship with shell width (GLM with Gaussian Distribution)")

print(shell_length_v_width)

# Save the plot
ggsave("./outputs/shell_length_v_width_plot.png", shell_length_v_width, width = 16.5, height = 16.5, units = "cm")

# Calculate AIC
AIC_value <- AIC(glm_model)

# Print AIC
print(AIC_value)

# To assess the goodness of fit, you can also check the summary of the model
summary(glm_model)
