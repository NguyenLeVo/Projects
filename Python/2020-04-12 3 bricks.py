for i in range(4):
    print("?")

for i in range(4):
    print("?", end="")
print()

print("#\n" * 3, end="")

# 4 columns
for i in range(4):
    # 3 rows
    for j in range(3):
        print("#", end="")
    # New line for each row
    print()
