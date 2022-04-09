library(tidyverse) 
library(dplyr)
library(ggplot2)

#load all data files in
logs <- read_csv("logs.csv",guess_max=2106600) 
player1 <- read_csv("player-6607011.csv")
player2 <- read.csv("player-6486029.csv")
player3 <- read.csv("player-6427031 .csv")



# make a histogram representing the actions taken by the three players provided

histo <- ggplot(player1, aes(x=event_id, col="lightblue")) + geom_histogram(colour = rainbow(11), bins = 10, binwidth = 100, boundary = 0) + labs(title = "Player 6607011 Actions", x= "Event id", y= "Number of Actions Taken")


#select the columns of interest from logs

plot_with_stuff = select(logs, player_id, event_id, event_time_dbl)

#select all rows that have an event id = to an action interest
       
subset_plot_with_stuff = subset(plot_with_stuff, event_id == "803")

#remove all other data points associated with each player besides the first recorded action of interest

try_getting_the_first_values_for_every_player <- subset_plot_with_stuff[!duplicated(subset_plot_with_stuff$player_id),]

#plot a scatter plot of each of the players along with their first action of interest

scatter <- ggplot(try_getting_the_first_values_for_every_player, aes(x = event_time_dbl, y = player_id, color = rainbow(157))) + geom_point() + ylim(6250000, 6750000) + scale_x_continuous(trans = 'log2') + labs(x="Time in Seconds", y = "Player id", title = "Time Taken for Players to First Look at a Stop and Think Card")


#select columns of interest for the box and whisker plot

box_and_whisker_attempt <- select(logs, player_id, event_time_dbl)

#remove all other data points besides the last point in time for each player id

box_new <- box_and_whisker_attempt[!duplicated(box_and_whisker_attempt$player_id, fromLast = TRUE),]

#plot the box and whisker plot

boxplot <- ggplot(box_new, aes(x=event_time_dbl)) + geom_boxplot() + scale_x_continuous(trans = 'log2')


