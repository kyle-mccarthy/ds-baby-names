import pandas as pd

names = pd.read_csv('data/StateNames.csv')
income = pd.read_excel('data/h08.xls', skiprows=[1, 2, 3, 4, 5])

print(income)
