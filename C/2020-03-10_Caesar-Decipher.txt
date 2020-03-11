// Writing a encrypting program
// Using Caesar's method

// Libraries
#include <cs50.h> // get_string
#include <stdio.h>
#include <string.h> // string
#include <math.h> // %
#include <stdlib.h> // atoi
#include <stdbool.h> // != 0
#include <ctype.h> // isalpha()

// Main function
int main(int argc, string argv[])
{
    // Key check function
    if (argc == 2)
    {
        int q = 0;
        for (int i = 0, n = strlen(argv[1]); i < n; i++)
        {
            // Make sure each character is only a number
            if (argv[1][i] >= 48 && argv[1][i] <= 57)
            {
                q += 0;   
            }
            else
            {
                q++;   
            }
        }
        if (q == 0)
        {
            // Turn the string argv[1] into k
            int k = atoi(argv[1]);   
            // Prompt user for plain original text
            string plain = get_string("plaintext: ");
    
            //Encryption and show the result
            printf("ciphertext: ");
            for (int i = 0, n = strlen(plain); i < n; i++)
            {
                if (isalpha(plain[i]) != 0)
                {
                    if (isupper(plain[i]) != 0)
                    {
                        printf("%c", (plain[i] - 'A' + atoi(argv[1])) % 26 + 'A');
                    }
                    else if (islower(plain[i]) != 0)
                    {
                        printf("%c", (plain[i] - 'a' + atoi(argv[1])) % 26 + 'a');
                    }
                }
                else 
                {
                    printf("%c", plain[i]);
                }
            }
            printf("\n");
        }
        else
        {
            printf("Usage: ./caesar key\n");
            return (1);
        }
    }
    else
    {
        printf("Usage: ./caesar key\n");
        return (1);
    }
}
