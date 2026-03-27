#include<stdio.h>
#include<stdlib.h>

int* allocate_scores(int n);
void read_scores(int *arr, int n);
int calculate_total(int *arr, int n);
void display_scores(int *arr, int n);
void delete_scores(int **arr);

int main()
{
    int n;
    int *scores=NULL;
    printf("enter number of players:");
    scanf("%d",&n);
    if (n<=0)
    {
        printf("Invalid number of players.\n");
        return 1;
    }
    scores=allocate_scores(n);
    if (scores==NULL)
    {
        printf("allocation failed\n");
        return 1;
    }
    read_scores(scores,n);
    display_scores(scores,n);
    printf("Total score:%d\n",calculate_total(scores,n));
    delete_scores(&scores);
    return 0;
}

int* allocate_scores(int n)
{
    int *arr;
    arr=(int*)malloc(n*sizeof(int));
    return arr;
}

void read_scores(int *arr, int n)
{
    printf("Enter scores:\n");
    for (int i=0;i<n;i++)
    {
        scanf("%d",&arr[i]);
    }
}

int calculate_total(int *arr, int n)
{
    int sum=0;
    for (int i=0;i<n;i++)
    {
        sum+=arr[i];
    }
    return sum;
}

void display_scores(int *arr, int n)
{
    printf("Scores:\n");
    for (int i=0;i<n;i++)
    {
        printf("%d\n",arr[i]);
    }
}

void delete_scores(int **arr)
{
    if (*arr!=NULL)
    {
        free(*arr);
        *arr=NULL;
    }
}