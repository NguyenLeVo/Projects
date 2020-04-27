# Program to print a list of students for a given house in alphabetical order
from cs50 import SQL
from csv import reader, DictReader
from sys import argv

# Open database
open(f"students.db", "r").close()
db = SQL("sqlite:///students.db")

# Check for arguments (roster.py, House)
if len(argv) != 2:
    print("Usage: python roster.py House_Name")
    exit()

# Return values will be a list of Python dicts, where each dict represents a row in the table
house_roster = []
house_name = argv[1]

# Query databases for all students in house
# Sorted alphabetically by last name then first name
house_roster = db.execute(
    "SELECT first, middle, last, birth FROM Students WHERE house = ? ORDER BY last, first", house_name)
    
# Print out each student full name and birth year
# Check for NULL in the middle name table
for row in house_roster:
    print(row["first"], end=' ')
    if row["middle"] != None: 
        print(row["middle"], end=' ')
    print(row["last"], end=',')
    print(f" birth", row["birth"])
