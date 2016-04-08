# Fork this script and update the babyName here (and in the script title) to your name / a friend's name.
# And then see how popular the name was in each state for every decade.
babyName <- "Melissa"

# First, we'll load in the libraries that we need to use
library(dplyr) # data munging and manipulation
library(ggplot2)  # visualize data
library(RSQLite)  # connect to SQLite database
library(tidyr)    # tidy data
library(maps)     # get map data
library(ggthemes) # display data

# The data is saved in a SQLite datbase. This enables us to connect to the database
db <- dbConnect(dbDriver("SQLite"), "../input/database.sqlite")

# This queries the StateNames database and pulls out the state-by-state information for all babies
nameByStateOverTime <- dbGetQuery(db, paste0("
                                             SELECT *
                                             FROM StateNames
                                             ORDER BY YEAR"))

# Add the state names for the mapping package
stateAbbr <- unique(nameByStateOverTime$State)
stateName = c("alaska", "alabama", "arkansas", "arizona", "california",
              "colorado", "connecticut", "district of columbia", "delaware",
              "florida", "georgia", "hawaii", "iowa", "idaho",
              "illinois", "indiana", "kansas", "kentucky", "louisiana",
              "massachusetts", "maryland", "maine", "michigan", "minnesota",
              "missouri", "mississippi", "montana", "north carolina", "north dakota",
              "nebraska", "new hampshire", "new jersey", "new mexico", "nevada",
              "new york", "ohio", "oklahoma", "oregon", "pennsylvania", "rhode island", 
              "south carolina", "south dakota", "tennessee", "texas", "utah",
              "virginia", "vermont", "washington", "wisconsin", "west virginia",
              "wyoming")
stateList = data.frame(State = stateAbbr, region = stateName)

decadeState <- expand.grid(Decade = seq(from = 1910, to = 2010, by = 10), State = stateAbbr)
decadeState$Decade = paste0(decadeState$Decade,"s")
nameByStateOverTime$Decade <- nameByStateOverTime$Year - nameByStateOverTime$Year %% 10
nameByStateOverTime$Decade = paste0(nameByStateOverTime$Decade,"s")

# calculate the total number of babies for the naming rate
totNamesCount <- nameByStateOverTime %>%
  group_by(Decade, State) %>%
  summarize(totNames = sum(Count))

# calculate the number of babies of the selected name (ignoring gender)
babyNameCount <- nameByStateOverTime %>%
  filter(Name == babyName) %>%
  group_by(Decade, State) %>%
  summarize(babyNames = sum(Count))

decadeState <- left_join(decadeState, stateList, by = c("State"))
decadeState <- left_join(decadeState, totNamesCount, by = c("Decade", "State"))
decadeState <- left_join(decadeState, babyNameCount, by = c("Decade", "State"))
decadeState$value <- decadeState$babyNames / decadeState$totNames * 1000
decadeState$value <- ifelse(is.na(decadeState$value),0,decadeState$value)

states_map <- map_data("state")
p <- ggplot(decadeState, aes(map_id = region)) +
  geom_map(aes(fill = value), map = states_map, color = "black") +
  expand_limits(x = states_map$long, y = states_map$lat) +
  theme_few() +
  theme(axis.ticks = element_blank(),
        axis.title = element_blank(),
        axis.text = element_blank()) +
  scale_fill_gradient(low="white", high="blue") +
  facet_wrap(~Decade, ncol = 3)  +
  theme(strip.text.x = element_text(size = 14)) +
  ggtitle(paste("Popularity of Baby Name", babyName, "by Decade")) +
  theme(plot.title = element_text(size = 20)) +
  guides(fill = guide_legend(title="Per 1000 \nBirths", size = 16)) + 
  theme(legend.text=element_text(size = 12)) +
  coord_fixed()
ggsave("BabyOverTime.png", p, width = 16, height = 9, dpi = 300)


