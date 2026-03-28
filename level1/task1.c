#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main()
{
    char *name;           
    int size = 50;        

    while (1)
    {
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
            free(name);   
            break;
        }

        printf("Student entered: %s\n", name);

        free(name);       
    }

    printf("Exited.\n");
    return 0;
}
