import pandas as pd

income = pd.read_csv('data/TopMedianIncomeByYear.csv')
names = pd.read_csv('data/StateNames.csv')

top_names = []

# we are essentially going to iterate over the top income states by year, for each state in the year we are then
# going to look at the most popular names and export a segment of them
for index, row in income.iterrows():
    year = row['year']
    for i in range(1,11):
        state = row['state_' + str(i)]
        # select the subset of names for the year and state and get the most popular ones
        popular = names[(names.Year == year) & (names.State == state)]
        popular = popular.sort_values('Count', ascending=False)
        print(popular)
        break
    break
