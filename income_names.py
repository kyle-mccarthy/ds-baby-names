import pandas as pd

income = pd.read_csv('data/TopMedianIncomeByYear.csv')
income_low = pd.read_csv('data/LowMedianIncomeByYear.csv')
names = pd.read_csv('data/StateNames.csv')

top_names = pd.DataFrame(columns=names.columns)
top_low_names = pd.DataFrame(columns=names.columns)

# we are essentially going to iterate over the top income states by year, for each state in the year we are then
# going to look at the most popular names and export a segment of them
for index, row in income.iterrows():
    year = row['year']
    for i in range(1,11):
        state = row['state_' + str(i)]
        # select the subset of names for the year and state and get the most popular ones
        popular = names[(names.Year == year) & (names.State == state)]
        popular = popular.sort_values('Count', ascending=False)
        top_names = top_names.append(popular.head(10))

top_names = top_names.drop('Id', axis=1)
top_names.to_csv('data/TopNamesHighIncome.csv', index=False)

# same thing as above but for the low income
for index, row in income_low.iterrows():
    year = row['year']
    for i in range(1,11):
        state = row['state_' + str(i)]
        # select the subset of names for the year and state and get the most popular ones
        popular = names[(names.Year == year) & (names.State == state)]
        popular = popular.sort_values('Count', ascending=False)
        top_low_names = top_low_names.append(popular.head(10))

top_low_names = top_low_names.drop('Id', axis=1)
top_low_names.to_csv('data/TopNamesLowIncome.csv', index=False)
