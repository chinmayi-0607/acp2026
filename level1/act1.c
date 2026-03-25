#include <stdio.h>

void inputTemperatures(int n, float temps[n]);
float findHighest(int n, float temps[n]);
float findLowest(int n, float temps[n]);
void output(float max, float min);

int main()
{
    int n=7;
    float temps[7];
    inputTemperatures(n,temps);
    float max=findHighest(n,temps);
    float min=findLowest(n,temps);
    output(max,min);
    return 0;
}

void inputTemperatures(int n, float temps[n])
{
    for (int i=0;i<n;i++)
    {
        printf("Enter temperature:");
        scanf("%f",&temps[i]);
    }
}

float findHighest(int n, float temps[n])
{
    int high=0;
    for (int i=1;i<n;i++)
    {
        if (temps[high]<temps[i])
        {
            high=i;
        }
    }
    return temps[high];
}

float findLowest(int n, float temps[n])
{
    int low=0;
    for (int i=1;i<n;i++)
    {
        if (temps[low]>temps[i])
        {
            low=i;
        }
    }
    return temps[low];
}

void output(float max, float min)
{
    printf("The minimum temperature is %f and the maximum temperature is %f",min,max);
}