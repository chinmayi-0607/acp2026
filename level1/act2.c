#include <stdio.h>

typedef struct 
{
    int units;
    float rate;
	float total_bill;
} ElectricityBill;

ElectricityBill input();
ElectricityBill calculate_bill(ElectricityBill bill);
void output(ElectricityBill bill);

int main()
{
    ElectricityBill bill;
    bill=input();
    bill=calculate_bill(bill);
    output(bill);
    return 0;
}

ElectricityBill input()
{
    ElectricityBill e;
    printf("Enter units:");
    scanf("%d",&e.units);
    printf("Enter rate:");
    scanf("%f",&e.rate);
    return e;
}

ElectricityBill calculate_bill(ElectricityBill bill)
{
    if (bill.units>100)
    {
        int extra=bill.units-100;
        bill.total_bill=(100*bill.rate)+(extra*(bill.rate+5));
    }
    else
        bill.total_bill=bill.rate*bill.units;
    return bill;
}

void output(ElectricityBill bill)
{
    if (bill.units>100)
    {
        printf("High consumption alert! Extra charge applied");
    }
    printf("total bill:%f",bill.total_bill);
}