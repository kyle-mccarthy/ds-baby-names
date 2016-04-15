import pandas as pd
import us

headers = ["location"]

for year in list(reversed(range(1984, 2015))):
    headers.append("median_" + str(year))
    headers.append("standard_error_" + str(year))

income = pd.read_csv('data/h08.csv', names=headers)

income.to_csv('data/StateIncome.csv', index=False)

# remove non-states from the dataframe
income = income[income.location != 'United States']
income = income[income.location != 'D.C.']

high_income = []

for year in range(1984, 2015):
    # sort them by the median income for the year that we are looking at
    sorted_df = income.sort_values("median_" + str(year), ascending=False)
    # get the top 10 states for that year
    highest = sorted_df.head(10)
    highest = highest["location"].tolist()
    # change the values from state names to state abbreviations to stay consistent with baby names data set
    highest = [us.states.lookup(x).abbr for x in highest]
    highest = [year] + highest
    # add the year + state combo to the list
    high_income.append(highest)

# generate the headers for the high incomes
high_income_headers = ["year"] + ["state_" + str(x) for x in range(1, 11)]

# export the data to a CSV
high_df = pd.DataFrame(high_income, columns=high_income_headers)
high_df.to_csv('data/TopMedianIncomeByYear.csv', index=False)
