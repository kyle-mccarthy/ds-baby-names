import pandas as pd

headers = ["location"]

for year in list(reversed(range(1984, 2015))):
    headers.append("median_" + str(year))
    headers.append("standard_error_" + str(year))

income = pd.read_csv('data/h08.csv', names=headers)

income.to_csv('data/StateIncome.csv', index=False)

high_income = []

for year in range(1984, 2015):
    # sort them by the median income for the year that we are looking at
    sorted_df = income.sort_values("median_" + str(year), ascending=False)
    # get the top 10 states for that year
    highest = sorted_df.head(10)
    highest = highest["location"].tolist()
    highest = [year] + highest
    # add the year + state combo to the list
    high_income.append(highest)

# generate the headers for the high incomes
high_income_headers = ["year"] + ["state_" + str(x) for x in range(1, 11)]

# export the data to a CSV
high_df = pd.DataFrame(high_income, columns=high_income_headers)
high_df.to_csv('data/TopMediaIncomeByYear.csv', index=False)
