# Dictionary (key - value pair)

# order does not matter
cat = {'size': 'big', 'color': 'gray', 'location': 'home'}
print(cat)
print(cat['size'])

print()

print(list(cat))    # ['size', 'color', 'location']
print(list(cat.keys()))     # ['size', 'color', 'location']
print(list(cat.values()))   # ['big', 'gray', 'home']
print(list(cat.items()))    # [('size', 'big'), ('color', 'gray'), ('location', 'home')]

print()

for i in cat.keys():
    print(i)

print()

for i in cat.items():
    print(i)

print()

for k, v in cat.items():
    print(k, v)

print()

# Get method
print(cat.get('color', 0))  # if color key exists, return color value. else returns 0
print(cat.get('pow', 0))

print()

picnicItems = {'Lysol': 5, 'Napkins': 8}
print('I am bringing '+ str(picnicItems.get('Lysol', 0)) + ' bottles of Lysol and ' +\
        str(picnicItems.get('powder', 0)) + ' packs of baby powders.')

print()


