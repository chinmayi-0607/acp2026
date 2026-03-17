#include <stdio.h>
#include <string.h>

typedef struct {
    char name[50];
    float length;
    float width;
    float area;
} Rectangle;

// Function prototypes
Rectangle input();
float calculate_area(Rectangle rect);
void compare_areas(Rectangle r1, Rectangle r2, Rectangle r3);

int main() {
    Rectangle rect1, rect2, rect3;
    
    printf("Enter details for three rectangles:\n");
    
    // Input rectangles
    rect1 = input();
    rect1.area = calculate_area(rect1);
    
    rect2 = input();
    rect2.area = calculate_area(rect2);
    
    rect3 = input();
    rect3.area = calculate_area(rect3);
    
    // Compare areas
    compare_areas(rect1, rect2, rect3);
    
    return 0;
}

Rectangle input() {
    Rectangle r;
    printf("Enter name: ");
    fgets(r.name, 50, stdin);
    r.name[strcspn(r.name, "\n")] = 0;  // Remove newline
    
    printf("Enter length: ");
    scanf("%f", &r.length);
    printf("Enter width: ");
    scanf("%f", &r.width);
    while (getchar() != '\n');  // Clear input buffer
    
    return r;
}

float calculate_area(Rectangle rect) {
    return rect.length * rect.width;
}

void compare_areas(Rectangle r1, Rectangle r2, Rectangle r3) {
    printf("\nAreas:\n");
    printf("%s: %.2f sq units\n", r1.name, r1.area);
    printf("%s: %.2f sq units\n", r2.name, r2.area);
    printf("%s: %.2f sq units\n", r3.name, r3.area);
    
    printf("\nComparing areas using else-if ladder:\n");
    
    if (r1.area > r2.area && r1.area > r3.area) {
        printf("%s has the largest area: %.2f sq units\n", r1.name, r1.area);
    }
    else if (r2.area > r1.area && r2.area > r3.area) {
        printf("%s has the largest area: %.2f sq units\n", r2.name, r2.area);
    }
    else if (r3.area > r1.area && r3.area > r2.area) {
        printf("%s has the largest area: %.2f sq units\n", r3.name, r3.area);
    }
    else {
        printf("All rectangles have equal areas!\n");
    }
}
