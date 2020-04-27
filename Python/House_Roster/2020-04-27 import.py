# Program to import data from a CSV spreadsheet
from cs50 import SQL
from csv import reader, DictReader
from sys import argv

# Create database
open(f"students.db", "w").close()
db = SQL("sqlite:///students.db")

# Create tables
db.execute("CREATE TABLE Students (first TEXT, middle TEXT, last TEXT, house TEXT, birth NUMERIC)")

# Check for arguments (import.py, character.csv)
if len(argv) != 2:
    print("Usage: python import.py character.csv")
    exit()

# Open CSV file by command line argument and read it
with open(argv[1]) as database:

    # Read it into memory as a list
    database_reader = reader(database)
    for row in database_reader:

        # Populate the house and birth year
        data = [None] * 5
        data[3] = row[1]
        data[4] = row[2]

        # For each row, parse name
        # Use split method to split name into first, middle, and last names
        # Insert each student into the student table in students.db
        # db.execute to insert a row into the table
        name = row[0].split()
        if len(name) == 3:
            data[0] = name[0]
            data[1] = name[1]
            data[2] = name[2]
            db.execute("INSERT INTO Students (first, middle, last, house, birth) VALUES(?, ?, ?, ?, ?)",
                       data[0], data[1], data[2], data[3], data[4])
        elif len(name) == 2:
            data[0] = name[0]
            data[2] = name[1]
            db.execute("INSERT INTO Students (first, last, house, birth) VALUES(?, ?, ?, ?)",
                       data[0], data[2], data[3], data[4])
