#include <stdio.h>
#include <string.h>
void read_string(char str[], int size);
void print_string(char str[]);
void swap_strings(char str1[], char str2[]);

int main()
{
    char str1[50],str2[50];
    int size=50;
    read_string(str1,size);
    read_string(str2,size);
    print_string(str1);
    print_string(str2);
    swap_strings(str1,str2);
    printf("swapped string\n");
    print_string(str1);
    print_string(str2);
    return 0;
}

void read_string(char str[], int size)
{
    printf("Enter a string:");
    fgets(str,size,stdin);
    str[strcspn(str, "\n")] = '\0';
}

void print_string(char str[])
{
    printf("%s\n",str);
}

void swap_strings(char str1[], char str2[])
{
    char temp[50];
    strcpy(temp,str1);
    strcpy(str1,str2);
    strcpy(str2,temp);
}