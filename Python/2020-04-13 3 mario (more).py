# Create increasing blocks from length 1 to 8 inclusive
from cs50 import get_int

# Prompt the user for the size of the pyramid
while True:
    n = get_int("Height: ")
    if n > 0 and n < 9:
        break

# Construct the pyramind
# Outer loop (decreasing order starting from the value itself)
for i in range(n, 0, -1):

    # Inner loop 1 (decreasing spacer w/ 1st line having n - 1 spaces)
    for j in range(1, i, 1):
        print(" ", end="")
        
    # Inner loop 2 (increasing # w/ 1st line having n + 1 - n = 1(#))
    for k in range(n + 1, i, -1):
        print("#", end="")
        
    # Inner loop 3 (gap)
    print("  ", end="")
    
    # Inner loop 4 (increasing #)
    for l in range(n + 1, i, -1):
        print("#", end="")
    
    # Print new line
    print()
