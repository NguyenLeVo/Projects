# This program was created to have a dna database of people and criteria, and an unknown dna string
# Using this, we would be able to find out who is this person, or whether we don't have sufficient data to find out

# Import csv features and sys command line promptss
from csv import reader, DictReader
from sys import argv

# Check for arguments (dna.py, *.csv, & *.txt)
if len(argv) != 3:
    print("Usage: python dna.py data.csv sequence.txt")
    exit()

# sys.argv[0] is the dna.py or the first argument
# sys.argv[1] is the .csv file or the second argument
# sys.argv[2] is the .txt file or the third argument

# Open the .csv file
with open(argv[1]) as database:

    # Read it into memory as a list
    database_reader = reader(database)
    for row in database_reader:
        database_list = row

        # Pop the first row (name) out
        database_list.pop(0)

        # Only the genes' names remain
        break

# Open the DNA sequence .txt file
with open(argv[2]) as sequence:

    # Read the database as a string
    sequence_reader = reader(sequence)
    for row in sequence_reader:
        sequence_string = row
        # Note that there's only one row for the entire file, so the whole file is stored in one loop

# Load the read sequence into an array/string for manipulation
dna = sequence_string[0]

# Prepare the genes' key sequence manipulator dictionary
key_sequences = {}

# Copy the genes' list keys into the dictionary and set them as 1 to start counting and comparing later
for gene_key in database_list:
    key_sequences[gene_key] = 1

# Iterate over each key in the dna string, when found consecutive repeated substrings, count
for key in key_sequences:
    l = len(key)
    tempMax = 0
    temp = 0
    for i in range(len(dna)):

        # After counting a sequence from the ith position, reset the temp counter
        while temp > 0:
            temp -= 1
            continue

        # If the segment of dna corresponds to the key and there is a repetition of it we start counting
        # Note: dna[i: i + l] includes i, i + 1, i + 2, ..., i + l - 1
        if dna[i: i + l] == key:
            while dna[i - l: i] == dna[i: i + l]:
                temp += 1
                i += l

            # Compares the value to the previous longest sequence and if it is longer it overrides it
            if temp > tempMax:
                tempMax = temp

    # Store the highest count of the key for this specific person in the gene's key string dictionary
    key_sequences[key] += tempMax

# Open the database as a dictionary, compare, then print out either no one or the one that matches
with open(argv[1], newline='') as database:
    database_reader = DictReader(database)

    # Individual match check
    for person in database_reader:
        key_match = 0

        # Compares the genes' key count from the person in the .txt to each person in the database
        # If true, add to total count
        # I.e. if AATG of given person is 18, person 5 is 18, key_match += 1
        for key_gene in key_sequences:
            if key_sequences[key_gene] == int(person[key_gene]):
                key_match += 1

        # Check the total tally key_match with the sum of key_sequences count
        # I.e there are 10 keys, person 5 matches all 10 keys with given person, key_match = len(key_sequences) = 10
        if key_match == len(key_sequences):

            # Stops at the one with the right match
            # If matched, print name
            print(person['name'])
            exit()

    # If no one has been found, there's no match
    print("No match")
