install.packages("remotes")
remotes::install_github("kdgorospe/fishstatr")
library(fishstatr)

read_xlsx("https://keifca-my.sharepoint.com/personal/philip_haupt_kentandessex-ifca_gov_uk/Documents/data_analysis/razor_clam_allometry/fao_data")

fao_raw <- read_csv("https://keifca-my.sharepoint.com/personal/philip_haupt_kentandessex-ifca_gov_uk/Documents/data_analysis/razor_clam_allometry/fao_data/FOA_FishStatJ_Irish_razor_clam_data-2.csv")
