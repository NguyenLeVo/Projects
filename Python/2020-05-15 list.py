# List ismutable, string is immutable
# Pass by reference (pointers), not by value like a string

spam = ['1a', '2b', '3c', '4d']

print(spam[0])
print(spam[-1])     # last index or 4d
print(spam[-2])     # 2nd last index or 3c
print(spam[1:3])    # slice (list of values) from 2nd to 3rd value or 2b 3c

print()

for i in range(len(spam)):
    print(f'Index {i} is: {spam[i]}.')
# Index 0 is: 1a.
# Index 1 is: 2b.
# Index 2 is: 3c.
# Index 3 is: 4d.

print()

spam1= [
        ['a', 'b', 'c'],
        ['d', 'e', 'f', 'g']
       ]

print(spam1[0][1])      # b
print(spam1[1][3])      # g

print()

spam2=[0, 1, 2]
spam2[1:3] = [4, 5, 6]      # replace 2nd and 3rd values with 4 5 6 
print(spam2)    # 0 4 5 6
print(spam2[:2])     # first two indices (start at beginning) 0 4

print()

spam3=[0, 1, 2]
del spam3[1]
print(spam3)        # delete 2nd elements and shift everything 0 2

print()

spam4 = spam + spam1
print(spam4)        # ['1a', '2b', '3c', '4d', ['a', 'b', 'c'], ['d', 'e', 'f', 'g']]

print()

print(spam3 * 3)    # [0, 2, 0, 2, 0, 2]
print(list('Hello'))    # ['H', 'e', 'l', 'l', 'o']
print(list(range(5)))   # [0, 1, 2, 3, 4]
print(list(range(0, 20, 4)))    # [0, 4, 8, 12, 16]

print()

spam5 = [0, 1, 'a', 3, 4]
# Methods
print(spam5.index('a'))     # Index 2
spam5.append(5)
print(spam5)    # [0, 1, 'a', 3, 4, 5] | Append a value at the end
spam5.insert(1, 'chicken')
print(spam5)    # [0, 'chicken', 1, 'a', 3, 4, 5] | Insert a value in a position
spam5.remove(3)
print(spam5)    # [0, 'chicken', 1, 'a', 4, 5] | remove 3
# remove the value, del the index

print()

spam6 = [3, 7, 4, 1, 9]
spam6.sort()
print(spam6)
spam6.sort(reverse=True)
print(spam6)

