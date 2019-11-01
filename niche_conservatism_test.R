library(BIEN)
library(ape) #Package for working with phylogenies in R
library(maps) #Useful for making quick maps of occurrences
library(sp) #A package for spatial data
library(stringr)
 
test_data<-read.csv("C:/Users/Emil/Documents/Aarhus_University/Master's_project/Primary_data/csv-files/test_data.csv", header = T, sep = ";", na.string = "")

test_data_1 <- test_data[test_data$taxon_status_description != "Unplaced",] # Exclude "Unplaced" taxon_status_description
#test_data_2 <- test_data_1[test_data_1$species != "NA",] # Exclude NA species - ERROR: Doesn't actually remove row with species = NA. Why not?

#The following loop should be carried out with test_data_2...

target_species <- levels(test_data_1$accepted_name_id)

for(i in target_species){
  t <- test_data_1[test_data_1$accepted_name_id==i,]
  u <- paste(t$genus, t$species)
  occurrence_records <- dataframe() #create empty occurrence record file
  #occurrence_records <- data.frame(scrubbed_species_binomial = character(),
                                   #latitude = numeric(),
                                   #longitude = numeric(),
                                   #stringsAsFactors = F)  - Does the structure of the data.frame have to be assigned before hand?
  
  for(j in u){
    occurrence_records[[BIEN_occurrence_species(j, only.new.world = F)]] #download stuff from BIEN and add to empty file - How to insert data into empty data.frame?
  }
  # do stuff with occurrence records for this species before moving on to next
  occurrence_records = occurrence_records[!is.na(occurrence_records[,"latitude"]) $ !is.na(occurrence_records[,"longitude"]),] # excluding NA coordinates
  occurrence_records = occurrence_records[!dupliated(occurrence_records),] # excluding repeated occurrences
  # convert to spatial points?
}
all_occurrence_records <- data.frame(occurrence_records$scrubbed_species_binomial, occurrence_records$latitude, occurrence_records$longitude)
#print(all_occurrence_records)


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
