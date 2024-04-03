# Aim: read allometric data into R

library(tidyverse)
library(readxl)
library(Microsoft365R)
# dat <- readxl::read_xlsx("https://keifca-my.sharepoint.com/:x:/r/personal/philip_haupt_kentandessex-ifca_gov_uk/_layouts/15/Doc.aspx?sourcedoc=%7Baa4ac5b9-eff7-43a9-af60-3a09d6ea2db8%7D&action=edit&wdinitialsession=2862a3b3-32cd-3a49-58fb-617fce9ab3dd&wdrldsc=3&wdrldc=1&wdrldr=ContinueInExcel", sheet = "Survey_data_entry")
# od <- get_personal_onedrive()
od <- get_business_onedrive()
# od$list_items("Documents/SUSTAINABLE FISHERIES/razor_clams/survey_trip_forms_and_data")
# dat_raw <- od$load_dataframe("Documents/SUSTAINABLE FISHERIES/razor_clams/survey_trip_forms_and_data/razor_clam_survey_sheet.xlsx")
list_sharepoint_sites()

survey_data_meta <- read_xlsx("C:/Users/philip.haupt/OneDrive - Kent & Essex Inshore Fisheries and Conservation Authority/Documents/SUSTAINABLE FISHERIES/razor_clams/survey_trip_forms_and_data/razor_clam_survey_sheet.xlsx", sheet = "Survey_data_entry")
size_age_data <- read_xlsx("C:/Users/philip.haupt/OneDrive - Kent & Essex Inshore Fisheries and Conservation Authority/Documents/SUSTAINABLE FISHERIES/razor_clams/survey_trip_forms_and_data/razor_clam_survey_sheet.xlsx", sheet = "Lab_subsample_data_entry",
                           skip = 2)   %>% 
  filter(`type survey or fishing` == "survey")

size_age_data$weight_g <- as.double(size_age_data$weight_g)


# Filter out rows with NA or 0 values in age_years or shell_length
filtered_data <- size_age_data %>%
  filter(!is.na(age_years), age_years != 0,
         !is.na(shell_length), shell_length != 0,
         !is.na(weight_g), weight_g != 0)


