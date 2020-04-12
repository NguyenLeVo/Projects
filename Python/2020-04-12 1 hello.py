# No printf
# No semicolon at the end
# No new line \n
# No stdio.h header
# No need to initialize the data type in the beginning

print("hello, world")
print("HELLO, WORLD")

# Compile by using command line python program.py

from cs50 import get_string

answer = get_string("What's your name?\n")
print("My name is " + answer)
print("Toi ten la", answer)
print(f"hello, {answer}")

# counter++ does not exist
counter = 0
counter += 1

# There's a colon
# No brackers
# No curly braces
# Must be indented (convention is 4 spaces)
# Else if turns into elif

from cs50 import get_int

x = get_int("x: ")
y = get_int("y: ")

if x < y:
    print("x is less than y")
elif x > y:
    print("x is more than y")
else:
    print("x is equal to y")

# True and False are capitalized
# while True:
#    print("Hello, World")

i = 3
while i > 0:
    print("cough")
    i -= 1

for j in [0, 1, 2]:
    print("sneeze")

for k in range(5):
    print("achoo")

# range: sequence of values
# list: an array with varying size and values
# tuple: sequence of immutable values
# dict: collection of key/value pairs a.k.a hash table
# set: collection of unique values

age = get_int("What's your age?\n")
print(f"You're at least {age * 365} days old.")

from cs50 import get_string

s = get_string("Do you agree?")

if s == "Y" or s == "y":
# if s in ["Y", "y", "Yes", "yes"]:
# if s.lower() in ["y", "yes"]
    print("Agreed.")
elif s == "N" or s == "n":
    print("Not agreed.")

# No pointers, no seg fault, no null pointers
# No main function, just write

