#include <stdio.h>
#include <string.h>

#define MAX_LEN 100

// Function prototypes
void inputStrings(char str1[], char str2[]);
int compareStrings(char str1[], char str2[]);
void output(int result);

int main() {
    char str1[MAX_LEN], str2[MAX_LEN];
    
    // Get input strings
    inputStrings(str1, str2);
    
    // Compare strings
    int result = compareStrings(str1, str2);
    
    // Display result
    output(result);
    
    return 0;
}

void inputStrings(char str1[], char str2[]) {
    printf("Enter first string: ");
    fgets(str1, MAX_LEN, stdin);
    str1[strcspn(str1, "\n")] = 0; // Remove newline
    
    printf("Enter second string: ");
    fgets(str2, MAX_LEN, stdin);
    str2[strcspn(str2, "\n")] = 0; // Remove newline
}

int compareStrings(char str1[], char str2[]) {
    int i = 0;
    
    // Compare character by character
    while (str1[i] != '\0' && str2[i] != '\0') {
        if (str1[i] > str2[i]) {
            return 1;  // str1 is lexicographically greater
        }
        else if (str1[i] < str2[i]) {
            return -1; // str2 is lexicographically greater
        }
        i++;
    }
    
    // Check if one string is prefix of other
    if (str1[i] == '\0' && str2[i] == '\0') {
        return 0;  // Equal strings
    }
    else if (str1[i] == '\0') {
        return -1; // str1 is shorter
    }
    else {
        return 1;  // str2 is shorter
    }
}

void output(int result) {
    if (result == 0) {
        printf("0 - Both strings are equal\n");
    }
    else if (result == 1) {
        printf("1 - First string is lexicographically greater\n");
    }
    else {
        printf("-1 - Second string is lexicographically greater\n");
    }
}
