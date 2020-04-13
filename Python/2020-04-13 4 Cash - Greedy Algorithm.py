# Convert dollar amount to number of coins
# Using Greedy Algorithm
from cs50 import get_float

# Prompt for owed change
while True:
    dollars = get_float("Change owed: ")
    if dollars > 0:
        break

# Convert dollars to cent
coins = round(dollars * 100)

# Greedy algorithm with floor division
# 25c first
first = coins // 25

# 10c second
second = (coins % 25) // 10

# 5c third
third = ((coins % 25) % 10) // 5

# 1c fourth
fourth = (((coins % 25) % 10) % 5) // 1

# Tally
sum = first + second + third + fourth
print(f"{sum}")
