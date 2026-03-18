#include <stdio.h>

typedef struct {
    float length;
    float width;
    float area;
} Rectangle;

void input(int n, Rectangle rects[n]);
void calculate_area(int n, Rectangle rects[n]);
int findLargestArea(int n, Rectangle rects[n]);
void output(int largestIndex, Rectangle rects[]);

int main() {
    int n;
    
    printf("Enter the number of rectangles: ");
    scanf("%d", &n);
    
    if (n <= 0 || n > 100) {
        printf("Invalid number of rectangles! Please enter 1-100.\n");
        return 1;
    }
    
    Rectangle rects[n];
    
    input(n, rects);
    calculate_area(n, rects);
    int largestIndex = findLargestArea(n, rects);
    output(largestIndex, rects);
    
    return 0;
}

void input(int n, Rectangle rects[n]) {
    for (int i = 0; i < n; i++) {
        printf("\nRectangle %d:\n", i + 1);
        printf("Enter length: ");
        scanf("%f", &rects[i].length);
        printf("Enter width: ");
        scanf("%f", &rects[i].width);
    }
}

void calculate_area(int n, Rectangle rects[n]) {
    for (int i = 0; i < n; i++) {
        rects[i].area = rects[i].length * rects[i].width;
    }
}

int findLargestArea(int n, Rectangle rects[n]) {
    int maxIndex = 0;
    for (int i = 1; i < n; i++) {
        if (rects[i].area > rects[maxIndex].area) {
            maxIndex = i;
        }
    }
    return maxIndex;
}

int findLargestArea(int n, Rectangle rects[n]) {
    int maxIndex = 0;
    for (int i = 1; i < n; i++) {
        if (rects[i].area > rects[maxIndex].area) {
            maxIndex = i;
        }
    }
    return maxIndex;
}

void output(int largestIndex, Rectangle rects[]) {
    printf("\n=== Rectangle Areas ===\n");
    for (int i = 0; i < sizeof(rects)/sizeof(rects[0]); i++) {
        printf("Rectangle %d: Length=%.2f, Width=%.2f, Area=%.2f\n", 
               i+1, rects[i].length, rects[i].width, rects[i].area);
    }
    
    printf("\nRectangle %d has the LARGEST area: %.2f sq units\n", 
           largestIndex+1, rects[largestIndex].area);
}
