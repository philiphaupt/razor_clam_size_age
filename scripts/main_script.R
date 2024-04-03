# Main script
# Aim: Allometric analysis of razor clams - DEFRA project

# REad in data
file.edit("./scripts/read_data.r")

# Plot histograms
source("./scripts/plot_size_frequency.R", echo = TRUE)

# plot size weight relationship
file.edit("./scripts/plot_shell_length_weight.R", echo = TRUE)
