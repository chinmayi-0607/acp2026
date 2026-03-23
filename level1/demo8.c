#include <stdio.h>

#define MAX_LEN 100

void input(char *str);
void concatenate_strings(char *str1, char *str2);
void display(char *str);

int main() {
    char str1[MAX_LEN], str2[MAX_LEN];
    
    printf("Enter first string: ");
    input(str1);
    
    printf("Enter second string: ");
    input(str2);
    
    concatenate_strings(str1, str2);
    
    printf("Concatenated string: ");
    display(str1);
    
    return 0;
}

void input(char *str) {
    int i = 0;
    char ch;
    
    while ((ch = getchar()) != '\n' && i < MAX_LEN - 1) {
        str[i] = ch;
        i++;
    }
    str[i] = '\0';
}

void concatenate_strings(char *str1, char *str2) {
    int i = 0;
    while (str1[i] != '\0') {
        i++;
    }
    
    int j = 0;
    do {
        str1[i] = str2[j];
        i++;
        j++;
    } while (str2[j-1] != '\0');
    
    str1[i] = '\0';
}

void display(char *str) {
    int i = 0;
    while (str[i] != '\0') {
        printf("%c", str[i]);
        i++;
    }
    printf("\n");
}
