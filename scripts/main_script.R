# Main script
# Aim: Allometric analysis of razor clams - DEFRA project

# Read in data
source("./scripts/read_data.r")

# Join Records
source("./scripts/join_event_to_measurement_records.R", echo = TRUE)

# Survey standardization - surface area
source("./scripts/standardise_subsample_time.R", echo = FALSE)

# Plot histograms
source("./scripts/plot_size_frequency.R", echo = TRUE)

# plot size weight relationship
file.edit("./scripts/plot_shell_length_weight.R", echo = TRUE)

# Density shell length
source("./scripts/density_standardised.R", echo = TRUE)

# Biomass calculations per grid cell grouped within age class, and over and under 100mm . Like cockle biomass calculations
file.edit("./scripts/biomass_year_class_calculations.R", echo = TRUE)

# spatial data read
source("scripts/read_spatial_data.R", echo = FALSE)

# join survey results to spatial data
file.edit("./scripts/join_survey_to_spatial.R")
