#include <stdio.h>

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

int main()
{
    Rectangle r1, r2, r3;

    printf("Enter details for Rectangle 1\n");
    r1 = input();
    r1.area = calculate_area(r1);

    printf("\nEnter details for Rectangle 2\n");
    r2 = input();
    r2.area = calculate_area(r2);

    printf("\nEnter details for Rectangle 3\n");
    r3 = input();
    r3.area = calculate_area(r3);

    compare_areas(r1, r2, r3);

    return 0;
}

Rectangle input()
{
    Rectangle rect;

    printf("Enter rectangle name: ");
    scanf("%s", rect.name);

    printf("Enter length: ");
    scanf("%f", &rect.length);

    printf("Enter width: ");
    scanf("%f", &rect.width);

    return rect;
}

float calculate_area(Rectangle rect)
{
    return rect.length * rect.width;
}

void compare_areas(Rectangle r1, Rectangle r2, Rectangle r3)
{
    if (r1.area > r2.area && r1.area > r3.area)
    {
        printf("\n%s has the largest area: %.2f\n", r1.name, r1.area);
    }
    else if (r2.area > r1.area && r2.area > r3.area)
    {
        printf("\n%s has the largest area: %.2f\n", r2.name, r2.area);
    }
    else
    {
        printf("\n%s has the largest area: %.2f\n", r3.name, r3.area);
    }
}