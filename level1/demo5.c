#include <stdio.h>

void read_array(int n, int arr[]);
void print_array(int n, int arr[]);
void swap_array(int n, int a[], int b[]);

int main() {
    int n;
    printf("Enter size of arrays: ");
    scanf("%d", &n);
    
    int arr1[n], arr2[n];
    
    printf("Enter elements for first array:\n");
    read_array(n, arr1);
    
    printf("Enter elements for second array:\n");
    read_array(n, arr2);
    
    printf("\nOriginal arrays:\n");
    printf("Array 1: ");
    print_array(n, arr1);
    printf("Array 2: ");
    print_array(n, arr2);
    
    swap_array(n, arr1, arr2);
    
    printf("\nAfter swapping:\n");
    printf("Array 1: ");
    print_array(n, arr1);
    printf("Array 2: ");
    print_array(n, arr2);
    
    return 0;
}

void read_array(int n, int arr[]) {
    for (int i = 0; i < n; i++) {
        printf("Element %d: ", i + 1);
        scanf("%d", &arr[i]);
    }
}

void print_array(int n, int arr[]) {
    for (int i = 0; i < n; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n");
}

void swap_array(int n, int a[], int b[]) {
    int temp[n];
    
    for (int i = 0; i < n; i++) {
        temp[i] = a[i];
    }
    
    for (int i = 0; i < n; i++) {
        a[i] = b[i];
    }
    
    for (int i = 0; i < n; i++) {
        b[i] = temp[i];
    }
}
