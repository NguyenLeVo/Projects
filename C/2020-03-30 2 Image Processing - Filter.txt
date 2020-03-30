// Create a grayscale, sepia, reflect, blur, and edge detection filter for image processing
// Because of passing by value by nature of int, no need to use pointers thus far

#include "helpers.h"
#include <math.h>
#include <stdio.h>

// Convert image to grayscale
void grayscale(int height, int width, RGBTRIPLE image[height][width])
{
    int gray = 0;
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            gray = round(((float)image[i][j].rgbtBlue + (float)image[i][j].rgbtGreen + (float)image[i][j].rgbtRed) / 3);
            image[i][j].rgbtBlue = gray;
            image[i][j].rgbtGreen = gray;
            image[i][j].rgbtRed = gray;
        }
    }
    return;
}

// Convert image to sepia
void sepia(int height, int width, RGBTRIPLE image[height][width])
{
    int sepiaRed = 0, sepiaGreen = 0, sepiaBlue = 0;
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            sepiaRed = round(.393 * (float)image[i][j].rgbtRed + .769 * (float)image[i][j].rgbtGreen + .189 * (float)image[i][j].rgbtBlue);
            sepiaGreen = round(.349 * (float)image[i][j].rgbtRed + .686 * (float)image[i][j].rgbtGreen + .168 * (float)image[i][j].rgbtBlue);
            sepiaBlue = round(.272 * (float)image[i][j].rgbtRed + .534 * (float)image[i][j].rgbtGreen + .131 * (float)image[i][j].rgbtBlue);

            if (sepiaRed > 255)
            {
                image[i][j].rgbtRed = 255;
            }
            else
            {
                image[i][j].rgbtRed = sepiaRed;
            }

            if (sepiaGreen > 255)
            {
                image[i][j].rgbtGreen = 255;
            }
            else
            {
                image[i][j].rgbtGreen = sepiaGreen;
            }

            if (sepiaBlue > 255)
            {
                image[i][j].rgbtBlue = 255;
            }
            else
            {
                image[i][j].rgbtBlue = sepiaBlue;
            }
        }
    }
    return;
}

// Reflect image horizontally
void reflect(int height, int width, RGBTRIPLE image[height][width])
{
    int tempRed = 0, tempGreen = 0, tempBlue = 0;
    for (int i = 0; i < height; i++)
    {
        if (width % 2 == 0)
        {
            for (int j = 0; j < .5 * (width - 1); j++)
            {
                tempBlue = image[i][j].rgbtBlue;
                tempGreen = image[i][j].rgbtGreen;
                tempRed = image[i][j].rgbtRed;

                image[i][j].rgbtBlue = image[i][width - 1 - j].rgbtBlue;
                image[i][j].rgbtGreen = image[i][width - 1 - j].rgbtGreen;
                image[i][j].rgbtRed = image[i][width - 1 - j].rgbtRed;

                image[i][width - 1 - j].rgbtBlue = tempBlue;
                image[i][width - 1 - j].rgbtGreen = tempGreen;
                image[i][width - 1 - j].rgbtRed = tempRed;
            }
        }
        else
        {
            for (int j = 0; j < .5 * (width - 2); j++)
            {
                tempBlue = image[i][j].rgbtBlue;
                tempGreen = image[i][j].rgbtGreen;
                tempRed = image[i][j].rgbtRed;

                image[i][j].rgbtBlue = image[i][width - 1 - j].rgbtBlue;
                image[i][j].rgbtGreen = image[i][width - 1 - j].rgbtGreen;
                image[i][j].rgbtRed = image[i][width - 1 - j].rgbtRed;

                image[i][width - 1 - j].rgbtBlue = tempBlue;
                image[i][width - 1 - j].rgbtGreen = tempGreen;
                image[i][width - 1 - j].rgbtRed = tempRed;
            }
        }
    }
    return;
}

// Blur image
void blur(int height, int width, RGBTRIPLE image[height][width])
{
    // To avoid averaging new values from changed past squares, we have to copy to image matrix into a fresh matrix
    RGBTRIPLE image1[height][width];
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            image1[i][j] = image[i][j];
        }
    }

    // Setup temp blur variables
    int blurRed, blurGreen, blurBlue;
    float counter;

    // Calculate the average while skipping non-existing surrounding nodes
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            // Reset values and counter for every node everytime 
            blurRed = 0; 
            blurGreen = 0; 
            blurBlue = 0;
            counter = 0;
            
            // Setup loop for surrounding nodes and self node
            for (int k = -1; k < 2; k++)
            {
                if (i + k < 0 || i + k > height - 1)
                {
                    continue;
                }
                for (int h = - 1; h < 2; h++)
                {
                    if (h + j < 0 || h + j > width - 1)
                    {
                        continue;
                    }
                    
                    // Calculate the average using the fresh temp matrix
                    blurBlue += image1[i + k][j + h].rgbtBlue;
                    blurGreen += image1[i + k][j + h].rgbtGreen;
                    blurRed += image1[i + k][j + h].rgbtRed;
                    counter++;
                }
            }
            
            // Paste the value into the desired matrix
            image[i][j].rgbtBlue = round(blurBlue / counter);
            image[i][j].rgbtGreen = round(blurGreen / counter);
            image[i][j].rgbtRed = round(blurRed / counter);
        }
    }
    return;
}

// Detect edges
void edges(int height, int width, RGBTRIPLE image[height][width])
{
    // To avoid averaging new values from changed past squares, we have to copy to image matrix into a fresh matrix
    RGBTRIPLE image1[height][width];
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            image1[i][j] = image[i][j];
        }
    }
    
    // Setup Sobel convolutional matrices
    int Gx[3][3] = 
    {
        {-1, 0, 1}, 
        {-2, 0, 2}, 
        {-1, 0, 1}
    };
    
    int Gy[3][3] = 
    {
        {-1, -2, -1},
        {0, 0, 0},
        {1, 2, 1}
    };
    
    // Setup temp edge variables
    float edgeRed, edgeGreen, edgeBlue; 
    float edgeRedx, edgeGreenx, edgeBluex, edgeRedy, edgeGreeny, edgeBluey;
    float nodeRed, nodeGreen, nodeBlue;

    // Calculate the average while skipping non-existing surrounding nodes
    for (int i = 0; i < height; i++)
    {
        for (int j = 0; j < width; j++)
        {
            // Reset values and counter for every node everytime 
            edgeRed = 0; 
            edgeGreen = 0; 
            edgeBlue = 0;
            
            edgeRedx = 0; 
            edgeGreenx = 0; 
            edgeBluex = 0;
            
            edgeRedy = 0; 
            edgeGreeny = 0; 
            edgeBluey = 0;
            
            // Setup loop for surrounding nodes and self node
            for (int k = -1; k < 2; k++)
            {
                
                for (int h = - 1; h < 2; h++)
                {
                    
                    // If out of bound, then the oob node is all black (0x000000)
                    if (h + j < 0 || h + j > width - 1 || i + k < 0 || i + k > height - 1)
                    {
                        nodeBlue = 0;
                        nodeGreen = 0;
                        nodeRed = 0;                 
                    }
                    else
                    {
                        nodeBlue = image1[i + k][j + h].rgbtBlue;
                        nodeGreen = image1[i + k][j + h].rgbtGreen;
                        nodeRed = image1[i + k][j + h].rgbtRed; 
                    }
                    
                    // Calculate the average using the fresh temp matrix
                    edgeBluex += Gx[k + 1][h + 1] * nodeBlue;
                    edgeGreenx += Gx[k + 1][h + 1] * nodeGreen;
                    edgeRedx += Gx[k + 1][h + 1] * nodeRed;
                    
                    edgeBluey += Gy[k + 1][h + 1] * nodeBlue;
                    edgeGreeny += Gy[k + 1][h + 1] * nodeGreen;
                    edgeRedy += Gy[k + 1][h + 1] * nodeRed;
                    
                    edgeBlue = sqrt((edgeBluex * edgeBluex) + (edgeBluey * edgeBluey));
                    edgeGreen = sqrt((edgeGreenx) * (edgeGreenx) + (edgeGreeny * edgeGreeny));
                    edgeRed = sqrt((edgeRedx * edgeRedx) + (edgeRedy * edgeRedy));
                }
            }
            
            // Paste the value into the desired matrix
            if (edgeBlue > 255)
            {
                image[i][j].rgbtBlue = 255;
            }
            else
            {
                image[i][j].rgbtBlue = round(edgeBlue);
            }
            if (edgeGreen > 255)
            {
                image[i][j].rgbtGreen = 255;
            }
            else
            {
                image[i][j].rgbtGreen = round(edgeGreen);
            }
            if (edgeRed > 255)
            {
                image[i][j].rgbtRed = 255;
            }
            else
            {
                image[i][j].rgbtRed = round(edgeRed);
            }
        }
    }
    return;
}
