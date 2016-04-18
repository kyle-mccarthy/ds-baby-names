library(ggplot2)
setwd("~/Desktop/ds-baby-names")
df = read.csv("data/TopNamesHighIncome.csv")  # read csv file

names_count = aggregate(Count ~ Name, df, sum)
names_count <- names_count[order(names_count$Count),]
qplot(names_count$Name, names_count$Count)

new_names_count <- subset(names_count, names_count[ , 2] > 10000)  
ggplot(data=new_names_count, aes(x=new_names_count$Name, y=new_names_count$Count)) +
  geom_bar(stat="identity") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5))

ggplot(data=names_count, aes(x=names_count$Name, y=names_count$Count)) +
  geom_bar(stat="identity") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5))

low_income_names_count <- read.csv("data/TopNamesLowIncome.csv")
low_income_names_count = aggregate(Count ~ Name, low_income_names_count, sum)

ggplot(data=low_income_names_count, aes(x=low_income_names_count$Name, y=low_income_names_count$Count)) +
  geom_bar(stat="identity") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5))

new_low_income_names_count <- subset(low_income_names_count, names_count[ , 2] > 10000)  
ggplot(data=new_low_income_names_count, aes(x=new_low_income_names_count$Name, y=new_low_income_names_count$Count)) +
  geom_bar(stat="identity") +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5))

### After those two questions, we now turn and look at unique names
# We want to find out if there are any unique names, or names that occur < 5 

library(dplyr) # data munging and manipulation
library(RSQLite)
db <- dbConnect(dbDriver("SQLite"), "./database.sqlite")
low_frequency_names <- dbGetQuery(db, paste0("
                                             SELECT *
                                             FROM NationalNames
                                             WHERE Count <= 5
                                             ORDER BY Count"))

# After running this query, we find that there are 254,615 names with a count of 5
# There are no names that have a count less than 5
