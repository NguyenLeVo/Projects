// Advanced encryption program
// Using a 26-character substitution key

// Libraries
#include <cs50.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <math.h>
#include <ctype.h>

// Main function
int main(int argc, string argv[])
{
    // Check for if there's a key
    if (argc == 2)
    {
        // Check if there's 26 characters
        int n = strlen(argv[1]);
        if (n == 26)
        {
            // Check if there's any non-characters
            int q = 0;
            for (int i = 0; i < n; i++)
            {
                if (isalpha(argv[1][i]) != 0)
                {
                    q += 0;
                }
                else
                {
                    q++;
                }
            }
            // If there's no non-characters
            if (q == 0)
            {
                // Check if there's any repeating characters
                int r = 0;
                for (int i = 0; i < n ; i++)
                {
                    // j has to be one letter after i, and needs not to go from beginning cause loop
                    for (int j = i + 1; j < n; j++)
                    {
                        if (argv[1][j] == argv[1][i])
                        {
                            r++;
                        }
                        else
                        {
                            r += 0;
                        }
                    }
                }
                // If there's no repeated characters
                if (r == 0)
                {
                    // Start encryption program
                    // Prompt user for original text
                    string plain = get_string("plaintext: ");
                    // Encryption algorithm
                    // Convert key to all uppercase for ease of calculation
                    int k[26];
                    for (int i = 0; i < n; i++)
                    {
                        if (islower(argv[1][i]) != 0)
                        {
                            k[i] = argv[1][i] - 32;
                        }
                        else
                        {
                            k[i] = argv[1][i];
                        }
                    }
                    //Encryption and show the result
                    printf("ciphertext: ");
                    
                    // convert the ith letter to ascii number
                    // locate the position of the ith letter in relation to a or A if lowercase or uppercase
                    // go to the position in the key relative to the first letter in key
                    // replace the ith letter in plain with respective letter in key
                    for (int i = 0, s = strlen(plain); i < s; i++)
                    {
                        if (isalpha(plain[i]) != 0)
                        {
                            if (isupper(plain[i]) != 0)
                            {
                                printf("%c", k[plain[i] - 'A']);
                            }
                            else if (islower(plain[i]) != 0)
                            {
                                printf("%c", k[plain[i] - 'a'] + 32);
                            }
                        }
                        else
                        {
                            printf("%c", plain[i]);
                        }
                    }
                    printf("\n");
                    return (0);
                }
                // If there's any repeated characters, return (1)
                else
                {
                    printf("Key must not contain repeated characters.\n");
                    return (1);
                }
            }
            // If there's any non-characters, return (1)
            else
            {
                printf("Key must only contain alphabetic characters.\n");
                return (1);
            }
        }
        // If there's not exactly 26 characters, return (1)
        else
        {
            printf("Key must contain 26 characters.\n");
            return (1);
        }
    }
    // If there's no key or too many arguments, return (1)
    else
    {
        printf("Usage: ./substitution key\n");
        return (1);
    }
}
