# Download python 3 from python.org
# There's a shell and if click on file->open new file-> new file editor
# Write scripts->save->F5 to run scripts

# Name
print('Name?')
name = input()
print(f'My name is {name} and the length of my name is {len(name)}')

# Age
print('Age?')
age = input()
# Output of statement is a string. Age input is string, convert to int,
# add 1 is still int, convert the new number to string again.
print(f'My age is {age} and next year I will be {str(int(age) + 1)}')

# continue causes the execution to immediately jump back to the start of the loop and re-check the condition
# break causes the execution to immediately leave the loop, without re-checking the condition
spam = 0
while spam < 5:
    spam = spam + 1 
    if spam == 3:
        continue
    print(f'spam is {spam}')
    
# try and except
def div42by(divideBy):
    try:
        return 42 / divideBy
    except ZeroDivisionError:
        print('Dumbass')

print(div42by(2))
print(div42by(12))
print(div42by(0))
print(div42by(1))

while True:
    print("How many cars do you have?")
    num = input()
    try:
        if int(num) >= 3:
            print('That is a lot')
            break
        else:
            print('ok')
            break
    except ValueError:
        print('Put a number in')
        continue
