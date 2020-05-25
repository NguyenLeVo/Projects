# This is a guess the number game
import random

print('Name?')
name = input()


print(f'{name} Choose a number between 1 and 20')
secretnum = random.randint(1, 20)

for guess in range(1, 7):
    print('Take a guess')
    num = int(input())

    if num < secretnum:
        print('Too low, guess again.')
    elif num > secretnum:
        print('Too high, guess again.')
    else:
        break

#If you use f-string, you can skip shifting the int to str with {str(guess)}
# and {str(secretnum)}. But if you keep them, that's fine.
if num == secretnum:
    print(f'Correct {name}. ', end='')
    print(f'You guessed it in {str(guess)} guesses.')
elif num != secretnum:
    print(f'Wrong. Secret number was {secretnum}.')      
