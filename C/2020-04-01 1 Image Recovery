#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

int main(int argc, char *argv[])
{
    // Check usage
    if (argc != 2)
    {
        printf("Usage: ./recover file\n");
        return 1;
    }

    // Open file
    FILE *file = fopen(argv[1], "r");
    if (!file)
    {
        return 2;
    }

    // Create the 512 bytes buffer, jpeg counter, and image file
    // unsigned char has 8 bytes so no need to use uint8_t
    unsigned char *buffer = malloc(512);
    int jpeg_counter = 0;
    FILE *img = NULL;
    
    // Allocate 8 spaces (incl the null terminator) to create the img file name
    // Write it here so need to reiterate this everytime
    char filename[8];

    // Repeat until end of card
    while (fread(buffer, 512, 1, file))
    {

        // Read the first four bytes to check if start of a JPEG file or not
        if (buffer[0] == 0xff && buffer[1] == 0xd8 && buffer[2] == 0xff && (buffer[3] & 0xf0) == 0xe0)
        {

            // If not first JPEG, close image file
            if (jpeg_counter > 0)
            {
                fclose(img);
            }

            // Start writing the image file
            sprintf(filename, "%03i.jpg", jpeg_counter);
            img = fopen(filename, "w");

            // Check if jpg file is successfully created
            if (!img)
            {
                fclose(file);
                free(buffer);
                fprintf(stderr, "Could not create output JPG %s", filename);
                return 3;
            }

            // Iterate image count
            jpeg_counter++;
        }

        // If not the first image file, skip
        if (!jpeg_counter)
        {
            continue;
        }

        // Continue writing the data into the img file
        fwrite(buffer, 512, 1, img);
    }

    // Close last image file, card.raw file, and free buffer
    fclose(img);
    fclose(file);
    free(buffer);
    return 0;
}
