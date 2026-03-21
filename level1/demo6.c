#include <stdio.h>
#include <stdlib.h>

/* Function prototypes */
int* create_array(int n);
void initialize_array(int *arr, int n);
void print_array(int *arr, int n);
void delete_array(int **arr);

int main() {
    int n;
    int *arr = NULL;

    printf("Enter number of elements: ");
    scanf("%d", &n);

    // Allocate memory
    arr = create_array(n);
    if (arr == NULL) {
        printf("Memory allocation failed!\n");
        return 1;
    }

    // Initialize array
    initialize_array(arr, n);

    // Display array
    printf("Array elements are:\n");
    print_array(arr, n);

    // Free memory safely
    delete_array(&arr);

    // Check dangling pointer
    if (arr == NULL) {
        printf("Memory successfully freed and pointer set to NULL.\n");
    }

    return 0;
}

/* Allocate memory */
int* create_array(int n) {
    int *arr = (int*) malloc(n * sizeof(int));
    return arr;
}

/* Initialize array */
void initialize_array(int *arr, int n) {
    printf("Enter %d elements:\n", n);
    for (int i = 0; i < n; i++) {
        scanf("%d", &arr[i]);
    }
}

/* Print array */
void print_array(int *arr, int n) {
    for (int i = 0; i < n; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n");
}

/* Free memory safely */
void delete_array(int **arr) {
    if (*arr != NULL) {
        free(*arr);
        *arr = NULL;  // avoid dangling pointer
    }
}