library(readr)
#load in dependancies to parse through csv files

fram = read_csv('pruned_data.csv')
taxa = read_csv('taxon-ids.csv')
#Read in all the data from two csvs, the one containing observation data the other containing taxon id numbers mapped to scientific names

months_names = c('January','February','March','April','May','June','July','August','September','October','November','December')
months = c('01','02','03','04','05','06','07','08','09','10','11','12')
#Just two lists for numerical representations of months like the ones used in the data set and the other just plain english

final_table = data.frame(taxa$scientificName)
#This is the where we set up the dataframe for the table, the following code "appends" whole columns at a time month by month

for(i in months){
  month_spec_set = subset(fram, substr(observations.dateIdentified,6,7) == i);
  #Makes a subset of fram containing data for only one month
  
  idd_list = c()
  for(j in taxa$taxonID){
    idd_list = c(idd_list, sum(month_spec_set$observations.taxonID == j))
    #After idd_list is initialized we then "append" the number of times a specific taxon id, j, appears
    #in the list month_spec_set$observations.taxonID
  }
  final_table[i] = idd_list
  #At this point the idd_list should be full of numbers each representing how many times an ID occurs in one month
  #So now we just "append" the entire list to final_table
}
colnames(final_table) = c("Taxa", months_names)
#The column names at this point are all just numbers so to make it look a little prettier I changeded them to english

write.csv(final_table, 'counts_table.csv')
#Here I just write the table to a csv to not have to go through this everytime