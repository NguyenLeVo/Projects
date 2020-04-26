# Credit card check 
# Using Luhn's Algorithm
from cs50 import get_int

while True:
    ccnum = get_int("Number: ")
    if ccnum > 0:
        break

# Luhn's Algorithm / Checksum
# The digits of every other numbers from 2nd last 

# Two - Second to last 1e1
two = (ccnum % 100) // 10
# Four - 1e3
four = (ccnum % 10000) // 1000
# Six - 1e5
six = (ccnum % 1000000) // 100000
# Eight - 1e7
eight = (ccnum % 100000000) // 10000000
# Ten - 1e9
ten = (ccnum % 10000000000) // 1000000000
# Twelve - 1e11
twelve = (ccnum % 1000000000000) // 100000000000
# Fourteen - 1e13
fourteen = (ccnum % 100000000000000) // 10000000000000
# Sixteen - 1e15
sixteen = (ccnum % 10000000000000000) // 1000000000000000

# Multiply these digits by 2
two2 = two * 2
four2 = four * 2
six2 = six * 2
eight2 = eight * 2
ten2 = ten * 2
twelve2 = twelve * 2
fourteen2 = fourteen * 2
sixteen2 = sixteen * 2

# Seperating the products into digits 
# First digits of the products
two21 = two2 % 10
four21 = four2 % 10
six21 = six2 % 10
eight21 = eight2 % 10
ten21 = ten2 % 10
twelve21 = twelve2 % 10
fourteen21 = fourteen2 % 10
sixteen21 = sixteen2 % 10
# Second digits of the products
two22 = (two2 % 100) // 10
four22 = (four2 % 100) // 10
six22 = (six2 % 100) // 10
eight22 = (eight2 % 100) // 10
ten22 = (ten2 % 100) // 10
twelve22 = (twelve2 % 100) // 10
fourteen22 = (fourteen2 % 100) // 10
sixteen22 = (sixteen2 % 100) // 10

# Adding the sum of these digits together
sum21 = two21 + four21 + six21 + eight21 + ten21 + twelve21 + fourteen21 + sixteen21
sum22 = two22 + four22 + six22 + eight22 + ten22 + twelve22 + fourteen22 + sixteen22
sum2 = sum21 + sum22

# The digits of every other numbers from last multiply by 1
# One - Last number 1e0
one = ccnum % 10
# Three - Third last number 1e2
three = (ccnum % 1000) // 100
# Five - 1e4
five = (ccnum % 100000) // 10000
# Seven - 1e6
seven = (ccnum % 10000000) // 1000000
# Nine - 1e8
nine = (ccnum % 1000000000) // 100000000
# Eleven - 1e10
eleven = (ccnum % 100000000000) // 10000000000
# Thirteen - 1e12
thirteen = (ccnum % 10000000000000) // 1000000000000
# Fifteen - 1e14
fifteen = (ccnum % 1000000000000000) // 100000000000000

# Add these
sum1 = one + three + five + seven + nine + eleven + thirteen + fifteen

# Add sum1 and sum2;
sumtotal = sum1 + sum2

# Check if sum ends with 0
if sumtotal % 10 == 0:
    check = 1
else: 
    check = 0

# AMEX Case (15-digit 34 or 37)
if (ccnum >= 34e13 and ccnum < 35e13) or (ccnum >= 37e13 and ccnum < 38e13) and check == 1:
    print("AMEX")

# MasterCard Case(16-digit 51-55)
elif (ccnum >= 51e14 and ccnum < 56e14) and check == 1:
    print("MASTERCARD")

# Visa Case (13- or 16-digit 4)
elif (ccnum >= 4e12 and ccnum < 5e12) or (ccnum >= 4e15 and ccnum < 5e15) and check == 1:
    print("VISA")

# Everything else is invalid
else:
    print("INVALID")