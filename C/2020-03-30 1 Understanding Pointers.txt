#include <stdio.h>

int main(void)
{
    int a = 1;
    int b = 2;
    
    int *p = NULL;
    int *r = NULL;
    int *q = NULL;
    p = &a;
    r = &b;
    
    q = r; 
    
    printf("Value of a: %i \n", a);
    printf("Address of a: %p \n\n", &a); 
    
    printf("Value of b: %i \n", b); 
    printf("Address of b: %p \n\n", &b); 
    
    printf("Value of pointer 1: %p \n", p);
    printf("Value of the value from pointer 1: %i \n", *p);
    printf("Address of pointer 1: %p \n\n", &p);
    
    printf("Value of pointer 2: %p \n", r);
    printf("Value of the value from pointer 2: %i \n", *r);
    printf("Address of pointer 2: %p \n\n", &r);
    
    printf("Value of pointer 3: %p \n", r);
    printf("Value of the value from pointer 3: %i \n", *q);
    printf("Address of pointer 2: %p \n", &q);
    
    // Value of a: 1 
    // Address of a: 0x7ffc0092800c 

    // Value of b: 2 
    // Address of b: 0x7ffc00928008  

    // Value of pointer 1: 0x7ffc0092800c 
    // Value of the value from pointer 1: 1 
    // Address of pointer 1: 0x7ffc00928000 

    // Value of pointer 2: 0x7ffc00928008  
    // Value of the value from pointer 2: 2 
    // Address of pointer 2: 0x7ffc00927ff8 
    
    // Value of pointer 3: 0x7ffc00928008 
    // Value of the value from pointer 3: 2 
    // Address of pointer 2: 0x7ffc00927ff0 
    
    // Value of pointer 3 is now the value of pointer 2 which is the address of b
    // Likewise with the value within the value of pointer 3
    // Because q is assigned the value of r
}
