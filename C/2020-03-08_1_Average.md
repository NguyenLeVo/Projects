// Libraries
#include <cs50.h>
#include <stdio.h>

// Dummy function placement
float average(int length, int array[]);

// Main function
int main(void)
{
    // Set length
    int n = get_int("Number of scores: ");

    //Set array
    int scores[n];

    // Set up score asking loop
    for (int i = 0; i < n; i++)
    {
        // i + 1 to show Score 1 instead of Score 0
        scores[i] = get_int("Score %i: ", i + 1);
    }

    // Use average function instead of hardcoding the average here
    printf("Average: %.1f\n", average(n, scores));
}

// Return float and needs array length and inputs
float average(int length, int array[])
{
    // Sum counter
    int sum = 0;
    for (int i = 0; i < length; i++)
    {
        sum += array[i]; // sum = sum + array[i]
    }

    // Needs to return
    // int sum and int length to save memory but output is float now
    return (float) sum / (float) length;
}
