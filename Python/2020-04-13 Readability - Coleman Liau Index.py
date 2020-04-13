# Devise a program to show the readability of a user given text
# Using Coleman-Liau index

# Prompt text from user
text = input("Text: ")

# Letter, Word, Sentence count
letter_sum = 0
word_sum = 1
sentence_sum = 0

for i in range(0, len(text), 1):
    
    # Set up conditions to count
    if (text[i] >= 'a' and text[i] <= 'z') or (text[i] >= 'A' and text[i] <= 'Z'):
        letter_sum += 1
    elif text[i] == ' ':
        word_sum += 1
    elif text[i] == '.' or text[i] == '?' or text[i] == '!':
        sentence_sum += 1
    
# Set up the equation
# 0.0588 * L - 0.296 * S - 15.8
L = (letter_sum / word_sum) * 100
S = (sentence_sum / word_sum) * 100
clindex = 0.0588 * L - 0.296 * S - 15.8

# Grade level
if (clindex < 1):
    print("Before Grade 1")
elif clindex >= 1 and clindex <= 16:
    print(f"Grade {round(clindex)}")
else:
    print("Grade 16+")
