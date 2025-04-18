library(dplyr)
library(redist)
library(sf)
aggregated_path <- "/scratch/network/gnovoa/Workshop Folder/"

block_path <-  "/scratch/network/gnovoa/Workshop Folder/"

agg_files <-   list.files(path = aggregated_path, pattern = ".shp", full.names = FALSE)

block_files<-  list.files(path = block_path, pattern = ".shp", full.names = FALSE)


  city_blocks<-st_read('chicago.shp')
  city_blocks<-city_blocks%>%dplyr::select(pop, GEOID, NAME, geometry)
  
  agg_dists<-st_read('chicago_districts_summary_2010_L2.shp')
  
  pop_tol<-max(agg_dists$pop/(sum(agg_dists$pop)/(n_distinct(agg_dists$distrct)))-1)
  
  ndists=n_distinct(agg_dists$distrct)
  
  city_map<- redist::redist_map(city_blocks, pop_tol=pop_tol, ndists=ndists, total_pop=pop)
  city_map$adj<-redist.adjacency(city_map)
  
  
  
  
  #rb_plans<-redist_smc(city_map, nsims=50000, ncores=64, runs=4, pop_temper=.01)
  
  rb_plans<-redist_smc(city_map, nsims=100, ncores=64, runs=4, pop_temper=.01)
  
  
  print("sim complete")
  setwd("/scratch/network/gnovoa/Workshop Folder")
  saveRDS(rb_plans, file=paste0(substr(block_files[i], 0, nchar(block_files[i])-7), "_plans.rds"))
