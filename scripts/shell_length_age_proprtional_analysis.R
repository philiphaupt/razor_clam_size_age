# Shelllength and age relationship

# calculate the proportion of calms with a smaller than 100 mm shell length when aged 5 - 6 year 

(survey_dat) %>% select(age_years)


# Subset the data
age_subset_data <- subset(survey_dat, age_years >=  5.5 & shell_length < 100)

# Calculate the proportion of records in the subset
proportion <- nrow(age_subset_data) / nrow(survey_dat)

# Print the proportion
print(proportion)

# Subset the data
age_subset_data <- subset(survey_dat, age_years >=  6.5)
# Calculate the proportion of records in the subset
proportion <- nrow(age_subset_data) / nrow(survey_dat)

# Print the proportion
print(proportion)
