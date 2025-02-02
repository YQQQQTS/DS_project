#import files

library(rvest)
library(tidyverse)
library(dplyr)
library(ggplot2)
library(datasets)
library(reshape2)


#set working directory and load files 
setwd("~/DS105_Project")
table_main2_file <- read.csv("processedplayers.txt")

#creating different dataframes
table_mmr_race_league <- table_main2_file[, c("mmr","race", "league")]
table_mmr_race_region <- table_main2_file[, c("mmr","race", "region")]
table_race_league <- table_main2_file[, c("race", "league")]


#editing the format of the variables and creating a dataframe with the percentages

table_race_league$league <- as.factor(table_race_league$league)
table_race_league$race <- as.factor(table_race_league$race)
view(table_race_league)

main_table <- table_race_league %>% group_by(race, league) %>%
  tally()

main_final_table <- transform(main_table, percent = ave(n, league, FUN = prop.table))

#creating the Proportional Stacked Area Graph

main_final_table2 <- main_final_table[!(main_final_table$race=="Unknown" |main_final_table$race=="unknown"),]

main_final_table2$league <- factor(main_final_table2$league , levels=c("Bronze 3", "Bronze 2", "Bronze 1", "Silver 3", "Silver 2", "Silve 1", "Gold 3", "Gold 2", "Gold 1", "Diamond 3", "Diamond 2", "Diamond 1", "Masters 3", "Masters 2", "Masters 1", "Grandmaster 1"))
main_final_table2$race <- factor(main_final_table2$race , levels=c("RANDOM", "ZERG", "PROTOSS", "TERRAN"))

final_graph_1 <- ggplot(main_final_table2, (aes(x = league,  y = percent, fill = race, group = race))) +
  geom_area(alpha=0.6 , linewidth=0.3, colour="black") +   scale_fill_manual(values=c('grey', '#5519BD', '#FFFF40', '#244CB9'))

#to view the graph
final_graph_1


