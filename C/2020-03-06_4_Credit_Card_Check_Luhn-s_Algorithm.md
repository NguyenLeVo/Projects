// Syntactically valid redit card check 
// Using Luhn's Algorithm

// Libraries
#include <cs50.h>
#include <stdio.h>
#include <math.h>

// Main function
int main(void)
{
    // Positive check
    long creditcardnumber;
    do 
    {
        creditcardnumber = get_long("What's your credit card number: ");
    }
    while (creditcardnumber < 1000000000000 || creditcardnumber > 1000000000000000);

    

}
