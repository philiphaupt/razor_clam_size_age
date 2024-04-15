# Main script
# Aim: Allometric analysis of razor clams - DEFRA project

# Read in data
source("./scripts/read_data.r")

# Join Records
source("./scripts/join_event_to_measurement_records.R", echo = TRUE)

# Plot histograms
source("./scripts/plot_size_frequency.R", echo = TRUE)

# plot size weight relationship
file.edit("./scripts/plot_shell_length_weight.R", echo = TRUE)
