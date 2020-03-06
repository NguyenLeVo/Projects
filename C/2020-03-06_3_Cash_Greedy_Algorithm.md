// Convert dollar amount to number of coins
// Using Greedy Algorithm

// Libraries
#include <cs50.h>
#include <stdio.h>
#include <math.h>

// Main function
int main(void)
{
    // Positive Integer Prompt
    float dollars;
    do
    {
        dollars = get_float("Owed money: $");
    }
    while (dollars < 0);

    // Convert dollar amounts to cents
    long coins = round(dollars * 100);

    // Greedy algorithm
    // 25c first
    int first;
    first = coins / 25;

    // 10c second
    int second;
    second = (coins % 25) / 10;

    // 5c third
    int third;
    third = ((coins % 25) % 10) / 5;

    // 1c fourth
    int fourth;
    fourth = (((coins % 25) % 10) % 5) / 1;

    // Tally
    int totalnumberofcoins;
    totalnumberofcoins = first + second + third + fourth;
    printf("Number of coins: %i\n", totalnumberofcoins);
}
