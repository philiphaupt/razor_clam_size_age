# Join spatial data to the survey results
library(sf)
std_dat_sf <- left_join(std_dat_summary %>% ungroup(), survey_grid_pts, by = join_by(grid_position == name), keep = TRUE) %>% 
  st_as_sf()


ggplot(std_dat_sf)+
  geom_sf(aes(size = sqrt(sqrt(density_std)), col = age_years), position = "dodge")


sf::st_write(std_dat_sf, "C:/Users/philip.haupt/OneDrive - Kent & Essex Inshore Fisheries and Conservation Authority/GIS/gis_data/SUSTAINABLE FISHERIES/Prospecting/razors/razor_clam_survey_2024_resutls.gpkg", layer = "Density per meter square")


# density per cell under and over 100mm
density_under_over <- std_dat_sf %>% ungroup() %>% 
  group_by(shell_length_category, grid_position) %>% 
  summarise(density_std = sum(density_std))


ggplot(density_under_over)+
  geom_sf(aes(size = sqrt(sqrt(density_std)), col = shell_length_category), position = "dodge")


sf::st_write(density_under_over, "C:/Users/philip.haupt/OneDrive - Kent & Essex Inshore Fisheries and Conservation Authority/GIS/gis_data/SUSTAINABLE FISHERIES/Prospecting/razors/razor_clam_survey_2024_resutls.gpkg", layer = "Density under_over per meter square")
