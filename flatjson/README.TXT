PYTHON Programming Test
=======================

JSON to CSV

Converting JSON into CSV is a common task in Data Science.

Write a function in python which flatten JSON to CSV similar to json_normalize function from pandas.io.json package which converts json to a data frame. Each path in JSON tree results in a column, and arrays are strings representing JSON lists (see example_output.csv).

Input: data/ directory with JSON files in subfolders (i.e. each JSON file is associated with a transaction)
Output: CSV file where the first column contains transaction ids (see example_output.csv)

