#Combine published and unpublished list 
test_data<-testdokument

#Excluding insignificant words from taxon_name
taxon_name<-c(test_data$taxon_name)
relevant_taxon_name<-word(taxon_name, 1,2, sep=" ")
relevant_data<-data.frame(test_data$species, relevant_taxon_name, test_data$taxon_status_description, test_data$accepted_name_id)
relevant_data_clean<-na.omit(relevant_data) #exclude rows with NA values (species=NA=non-species)


################ Occurance extraction of species from BIEN R (published+unpublished)

#Occurance extraction script
species <- c(relevant_data_clean$relevant_taxon_name)

for(s in species){
  print(s)
  BIEN_occurrence_species(s, only.new.world = F)
}

occurrence_only<-data.frame(occurrence_data$scrubbed_species_binomial, occurrence_data$latitude, occurrence_data$longitude)
occurrence_only

BIEN_occurrence_species("Acalypha accedens")
