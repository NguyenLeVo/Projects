# String input
s = input("What's your name? ")
print("My name is:", s)

# Number input
num = int(input("What's your age? "))
print(f"My age is: {num * 365} days.")

# Printing letter by letter
a = input("Input: ")
print("Output: ")
for c in a:
    print(c, end="")
print()
# Uppercase conversion
print("After: ", end="")
print(a.upper())
