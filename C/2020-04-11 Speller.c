// This program is created to run a spell-checker for any text
// The main goal is to apply hash tables with closed addressing
// Meaning to use chaining via linked lists

// Implements a dictionary's functionality
#include <stdio.h>
#include <stdbool.h>
#include <ctype.h>
#include <stdlib.h>
#include <string.h>

#include "dictionary.h"

// Represents a node in a hash table
typedef struct node
{
    char word[LENGTH + 1];
    struct node *next;
}
node;

// Number of buckets in hash table
// 2^14 = 16384 buckets
const unsigned int N = 16384;

// Hash table
node *table[N];

// Keeping track of words in dictionary
unsigned long words = 0;

// Hash function prototype
unsigned int hash(const char *word);

// Returns true if word is in dictionary else false
bool check(const char *word)
{
    // Convert strings to lower case
    char copy[strlen(word) + 1];
    strcpy(copy, word);
    char *p = copy;
    for (; *p; ++p)
    {
        *p = tolower(*p);
    }

    // Assign hash value from hashed word into the hash table
    /*
    * Hash the value as hash_value
    * Set the hash_value into the corresponding array value
    * Check if there's collision, if so, replace into first one
    * Be careful of the order, check first then move cursor
    * If there's no place, return false
    */
    unsigned long hash_value = hash(copy) % N;
    node *cursor = table[hash_value];
    while (cursor != NULL)
    {
        if (strcmp(cursor->word, copy) == 0)
        {
            return true;
        }
        cursor = cursor->next;
    }
    return false;
}

// Hashes word to a number
// Credit: djb2 hash function
unsigned int hash(const char *word)
{
    unsigned long hash = 5381;
    int c;
    while ((c = *word++))
    {
        // hash * 33 + c
        hash = ((hash << 5) + hash) + c;
    }
    return hash;
}

// Loads dictionary into memory, returning true if successful else false
bool load(const char *dictionary)
{

    // Open dictionary file
    FILE *file = fopen(dictionary, "r");
    if (!file)
    {
        printf("Error in opening file\n");
        return false;
    }

    // Create an all-null hash table
    for (int i = 0; i < N; i++)
    {
        table[i] = NULL;
    }

    // Read strings from file one at a time
    char buffer[LENGTH + 1];
    while (fscanf(file, "%s", buffer) != EOF)
    {

        // Create a new node for each word
        node *n = malloc(sizeof(node));
        if (!n)
        {
            printf("Error in making node\n");
            return false;
        }
        strcpy(n->word, buffer);
        n->next = NULL;

        // Hash word to obtain a hash value
        unsigned long hash_value = hash(buffer) % N;

        // Check collision then hash word into hash table
        if (table[hash_value] != NULL)
        {
            n->next = table[hash_value];
        }

        table[hash_value] = n;
        words++;
    }

    fclose(file);
    return true;
}

// Returns number of words in dictionary if loaded else 0 if not yet loaded
unsigned int size(void)
{
    return words;
}

// Unloads dictionary from memory, returning true if successful else false
bool unload(void)
{
    // Loop the whole hash table
    for (int i = 0; i < N; i++)
    {
        node *cursor = table[i];
        while (cursor != NULL)
        {
            node *tmp = cursor;
            cursor = cursor->next;
            free(tmp);
        }
    }
    return true;
}
