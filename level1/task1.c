#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main()
{
    char *name;           // pointer to dynamically allocated memory
    int size = 50;        // assume max 49 characters per name

    while (1)
    {
        // dynamically allocate memory for one name
        name = (char*) malloc(size * sizeof(char));
        if (name == NULL)
        {
            printf("Memory allocation failed.\n");
            return 1;
        }

        printf("enter student names\n");
        scanf("%s", name);

        if (strcmp(name, "exit") == 0)
        {
            free(name);   // free memory before exiting loop
            break;
        }

        printf("Student entered: %s\n", name);

        free(name);       // free memory after each name
    }

    printf("Exited.\n");
    return 0;
}
