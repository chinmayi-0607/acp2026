#include<stdio.h>

void input(int n, float arr[n])
{
    int i;
    printf("Enter %d elements:\n",n);
    for(i=0;i<n;i++)
    {
        scanf("%f",&arr[i]);
    }
}

int find_max_index(int n,float arr[])
{
    int i,max_index=0;
    for(i=0;i<n;i++)
    {
        if(arr[i]>arr[max_index])
        {
            max_index=i;
        }
    }
    return max_index;
}

void output(float arr[],int max_index)
{
    printf("The maximum element is: %.2f\n",arr[max_index]);
    printf("Index of the maximum element: %d\n",max_index);
}
int main()
{
    int n;
    printf("Enter the number of elements:\n");
    scanf("%d",&n);
    if(n<=0)
    {
        printf("Invalid array size."); 
        return 1;
    }
    float arr[n];

    input(n,arr);
    int max_index = find_max_index(n,arr);
    output(arr,max_index);

    return 0;
}