library(BIEN)
library(ape) #Package for working with phylogenies in R
library(maps) #Useful for making quick maps of occurrences
library(sp) # A package for spatial data



### Data sheet pre-treatment:
raw_data<-rbind(published_names_19_10_2018, unpublished_names_19_10_2018)

taxon_name<-c(raw_data$taxon_name)
relevant_taxon_name<-word(taxon_name, 1,2, sep=" ") # exclusion of irrelevant taxon_name information - NEEDS REVISION! Relevant synonym names vary on relevant number of words... 
relevant_data<-data.frame(raw_data$species, relevant_taxon_name, raw_data$taxon_status_description, raw_data$accepted_name_id, stringsAsFactors = FALSE) # dataframe of valuable variables
relevant_data_clean<-na.omit(relevant_data) # exclude rows with NA values (ex.: species = NA )


### Occurrence extraction:
species <- c(relevant_data_clean$relevant_taxon_name)

for(s in species){
  #print(s)
  BIEN_occurrence_species(s, only.new.world = F)
}
occurrence_data<-BIEN_occurrence_species(s, only.new.world = F)
occurrence_only<-data.frame(occurrence_data$scrubbed_species_binomial, occurrence_data$latitude, occurrence_data$longitude)# Isolate relevant information from BIEN-R
occurrence_only              


############### Occurrence plots on maps and niche assignment 

#download maps
#read maps
library(rgdal)
library(sp)

cont_map <- readOGR(shapefile directory) # Retrieve shapefiles from Wolf
#shapefiles for each of the 3 maps should be read, plotted and analyzed

coord <- occurrence_extraction[,c("latitude", "longitude")]
coordinates(coord) <- ~ lon + lat  # convert dataframe to spatial points object

proj4string(coord) <- proj4string(cont_map) # match projection attributes of both objects

cont_res <- over(coord, cont_map) # matches coordinates with shapefile polygons

# check results
plot(cont_map)
plot(coord, size=10, add=TRUE, col=c("blue", "red")[as.factor(species)])

### Niche assignment - Comming soon...

#Ratio of occurrence inside/outside biome to determine niche
#Division of tropical rainforest geographic regions (ex. Neotropics, Africa, Southeast-Asia)


############ Assignment of niche determined species on phylogenetic tree + analysis - Comming soon...
