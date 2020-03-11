// Devise a program to show the readability of a user given text
// Using Coleman-Liau index

// Libraries
#include <cs50.h>
#include <stdio.h>
#include <math.h>
#include <string.h>

// Main function
int main(void)
{
    // Prompt text from user
    string text = get_string("Text: ");

    // Letter, Word, Sentence count
    int letter_sum = 0, word_sum = 1, sentence_sum = 0;
    for (int i = 0, n = strlen(text); i < n; i++)
    {
        // Set up conditions to count
        if ((text[i] >= 'a' && text[i] <= 'z') || (text[i] >= 'A' && text[i] <= 'Z'))
        {
            letter_sum++;
        }
        else if (text[i] == ' ')
        {
            word_sum++;
        }
        else if (text[i] == '.' || text[i] == '?' || text[i] == '!')
        {
            sentence_sum++;
        }
    }
    
    // Set up the equation
    // 0.0588 * L - 0.296 * S - 15.8
    float L, S;
    L = ((float) letter_sum / (float) word_sum) * 100;
    S = ((float) sentence_sum / (float) word_sum) * 100;
    float clindex =  0.0588 * L - 0.296 * S - 15.8;

    // Grade level
    if (clindex < 1)
    {
        printf("Before Grade 1\n");
    }
    else if ((clindex >= 1) && (clindex <= 16))
    {
        printf("Grade %i\n", (int) round(clindex));
    }
    else
    {
        printf("Grade 16+\n");
    }
}
