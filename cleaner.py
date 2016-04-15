import pandas as pd

headers = ["location"]

for year in list(reversed(range(1984, 2015))):
    headers.append("median_" + str(year))
    headers.append("standard_error_" + str(year))

income = pd.read_csv('data/h08.csv', names=headers)

income.to_csv('data/StateIncome.csv', names = pd.read_csv('data/StateNames.csv'))

