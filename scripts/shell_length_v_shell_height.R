# Aim: Assess the relationship between shell length and width

library(tidyverse)


#

survey_dat %>% 
  ungroup() %>% 
  select(shell_length, shell_height, shell_length_category) %>% 
  filter(shell_height != 0, !is.na(shell_height)) %>% 
  ggplot(aes(x = shell_length, y = shell_height, col = shell_length_category))+
  geom_point()+
  scale_color_manual(values = c("skyblue", "salmon"))+
  theme_bw()+
  labs(col = "Shell Length Category")  # Modify legend title
  
#=========
# Plot with GLM fit
survey_dat %>% 
  ungroup() %>% 
  select(shell_length, shell_height, shell_length_category) %>% 
  filter(shell_height != 0, !is.na(shell_height)) %>% 
  ggplot(aes(x = shell_height, y = shell_length, col = shell_length_category)) +
  geom_point() +
  #geom_line(aes(y = fitted_height), linetype = "dashed", linewidth = 1.3) +
  scale_color_manual(values = c( "salmon", "skyblue")) +
  theme_bw()

# NOw fit a line to establish relationship
# Fit a GLM
glm_model <- glm(shell_length ~ shell_height, data = survey_dat, family = gaussian())

# Extract predicted values from the GLM model
predicted_values <- predict(glm_model, newdata = survey_dat)

# Add fitted values to the dataset
survey_dat$fitted_height <- predicted_values

#obtain slope
# Get the coefficients of the glm model
coefficients <- coef(glm_model)

# Extract the slope
slope <- coefficients["shell_height"]

# Print the slope
print(slope)

# Extract standard errors
se <- summary(glm_model)$coefficients[, "Std. Error"]

# Create a data frame with coefficients and standard errors
coefficients_df <- data.frame(coef = coefficients, se = se, row.names = NULL)

# Add standard error bars to the plot
# Plot with GLM fit
shell_length_v_height <- survey_dat %>% 
  ungroup() %>% 
  select(shell_length, shell_height, shell_length_category,fitted_height) %>% 
  filter(shell_height >= 12, !is.na(shell_height)) %>% 
  ggplot(aes(y = shell_length, x = shell_height))+
  geom_smooth(method = "glm", method.args = list(family = gaussian),col = "grey53", se = TRUE, size = 1.5, alpha = 0.5) +
  geom_point(aes(col = shell_length_category), size =1.75, alpha = 0.6) +
  scale_color_manual(values = c("skyblue3", "salmon"), name = "Shell Length with\nreference to MCRS") +
  theme_bw()+
  labs(y = "Shell length (mm)", x = "Shell height (mm)")
  #ggtitle("Shell Length relationship with shell width (GLM with Gaussian Distribution)")
  
print(shell_length_v_height)

# Save the plot
ggsave("./outputs/shell_length_v_height_plot.png", shell_length_v_height, width = 16.5, height = 16.5, units = "cm")


# Calculate AIC
AIC_value <- AIC(glm_model)

# Print AIC
print(AIC_value)

# To assess the goodness of fit, you can also check the summary of the model
summary(glm_model)


#-------------------
#Find 100 m mshell length from predicted values.
# Fit a GLM
glm_model <- glm(shell_height ~ shell_length, data = survey_dat, family = gaussian())

# Extract predicted values from the GLM model
#predicted_values <- predict(glm_model, newdata = survey_dat)

# Predict shell height for a given shell length (e.g., 100 mm)
predicted_height <- predict(glm_model, newdata = data.frame(shell_length = 100))

# Print predicted height
print(predicted_height)


# what proportion of records (razor clams) would have a shell dimension with a shell_height <17 mm and at the same time a shell_length > 100mm?
# Subset the data
subset_data <- subset(survey_dat, shell_height < 17 & shell_length > 100)

# Calculate the proportion of records in the subset
proportion <- nrow(subset_data) / nrow(survey_dat)

# Print the proportion
print(proportion)
