#include<stdio.h>

typedef struct {
    	int consumerID;
    	float unitsConsumed;
    	float billAmount;
} Bill;

void input(int n, Bill bills[n]);
void calculate_Bills(int n, Bill bills[n]);
int findHighestBillIndex(int n, Bill bills[n]);
void displayHighestBill(int index, Bill bills[]);

int main()
{
    int n;
    printf("enter number of customers:");
    scanf("%d",&n);
    Bill bills[n];
    input(n,bills);
    calculate_Bills(n,bills);
    int index=findHighestBillIndex(n,bills);
    displayHighestBill(index,bills);
    return 0;
}

void input(int n, Bill bills[n])
{
    for (int i=0;i<n;i++)
    {
        printf("enter consumer ID:");
        scanf("%d",&bills[i].consumerID);
        printf("enter units consumed:");
        scanf("%f",&bills[i].unitsConsumed);
    }
}

void calculate_Bills(int n, Bill bills[n])
{
    printf("Rate=5\n");
    for (int i=0;i<n;i++)
    {
        bills[i].billAmount=5*bills[i].unitsConsumed;
    }    
}

int findHighestBillIndex(int n, Bill bills[n])
{
    int high=0;
    for (int i=0;i<n;i++)
    {
        if (bills[high].billAmount<bills[i].billAmount)
        {
            high=i;
        }
    }
    return high;
}

void displayHighestBill(int index, Bill bills[])
{
    printf("Highest Bill\nCustomer ID:%d\nUnits Consumed:%f\nBill Amount:%f",bills[index].consumerID,bills[index].unitsConsumed,bills[index].billAmount);
}
