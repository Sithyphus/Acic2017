# R program to extract the necessary data from the Observations.csv
#This program should return an SDM readable file

library(readr)
#Here we create the initial data frame from the csv containing everything in it
#observations = read_csv("observations.csv")

#Aferwards we then load in a csv that contains all the taxon IDs, graciously given by Jeff
list_of_taxa = read_csv("taxon-ids.csv")

#Next we do some pruning to make the dataset somewhat smaller since the sdm doesn't require a lot of the data found therein
#pruned_frame = data.frame(observations$taxonID,observations$decimalLatitude,observations$decimalLongitude, observations$dateIdentified,observations$scientificName)
#colnames(pruned_frame)[2:3]= c('latitude','longitude')
#write.csv(pruned_frame, 'pruned_data.csv')
#I needed to change the column names of these columns to what the sdm was expecting

pruned_frame = read_csv('pruned_data.csv')

#This will create 760 different csv files each one containing a subset of the data set that only contains information for one taxon id and output them into a file, refered to as years sets
for(h in list_of_taxa$taxonID){
  taxon_spec_set = subset(pruned_frame, pruned_frame$observations.taxonID == h);
  write.csv(taxon_spec_set, paste('sets/years_sets/', h,'.csv', sep = ''))
}

#So now comes the fun part, here we now need to create 12 subsets from the pruned set for each individual month, from a string column label mind you
#I'm going to make a quick list of months
months = c('01','02','03','04','05','06','07','08','09','10','11','12')
#Probably an easier way to do that but it wouldn't have been worth the trouble
#So finally this is a thing of beauty right here m8, just watch
#This first loop creates subsets based on months, one for each

for(i in months){
  month_spec_set = subset(pruned_frame, substr(observations.dateIdentified,6,7) == i);
  #Then this right here does what I did earlier and creates a csv out of that month for only on taxon ID and spits it out into it's own file,
  for(j in list_of_taxa$taxonID){
    taxon_month_spec = subset(month_spec_set,observations.taxonID == j)
    write.csv(taxon_month_spec, paste('sets/',i,'/',j,'.csv',sep = ''))
  }
}
#Just fantastic, now we have all the csv files (9800) ready and able to be fed into the sdm, theoretically anyway

