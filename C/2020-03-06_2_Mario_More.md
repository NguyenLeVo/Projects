// Harder versions of Mario with two stacks

// Libraries
#include <cs50.h>
#include <stdio.h>

// Main function
int main(void)
{
    // Prompt user for valid height
    int n;
    do
    {
        n = get_int("Height: ");
    }
    while (n < 1 || n > 8);
        
    // Construct the hash triangle
    int i, j, k, l;
    // Height
    // Outer loop (decreasing order)
    for (i = n - 1; i < n && 0 <= i; i--)
    {
        // Length 
        // Inner loop 1 (decreasing spacer)
        for (j = 0; j < i; j++)
        {
            printf(" ");
        }
        // Inner loop 2 (increasing left #)
        for (k = n - 1; k >= i; k--)
        {
            printf("#");
        }
        // Inner loop 3 (gap)
        printf("  ");
        //Inner loop 4 (increasing right #)
        for (l = n - 1; l >= i ; l--)
        {
            printf("#");
        }
        printf("\n");
    }   
}
