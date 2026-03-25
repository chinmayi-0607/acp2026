#!/usr/bin/env bash
# test_act3.bats

@test "2 customers - finds highest bill correctly" {
    cat > bills.c << 'EOF'
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
        scanf("%d",&bills[i].consumerID);
        scanf("%f",&bills[i].unitsConsumed);
    }
}

void calculate_Bills(int n, Bill bills[n])
{
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
EOF

    gcc -o bills bills.c 2>/dev/null || skip "gcc not available"
    
    # 2 customers: ID1=100units($500), ID2=200units($1000) -> highest is ID2
    run bash -c 'echo -e "2\n1\n100\n2\n200" | ./bills'
    
    [[ $status -eq 0 ]]
    [[ "$output" =~ "Customer ID:2" ]]
    [[ "$output" =~ "Units Consumed:200" ]]
    [[ "$output" =~ "Bill Amount:1000" ]]
}

@test "3 customers - customer 2 has highest bill" {
    gcc -o bills bills.c 2>/dev/null || skip "gcc not available"
    
    # Customer1: ID=1, 50units($250) | Customer2: ID=2, 300units($1500) | Customer3: ID=3, 100units($500)
    run bash -c 'echo -e "3\n1\n50\n2\n300\n3\n100" | ./bills'
    
    [[ $status -eq 0 ]]
    [[ "$output" =~ "Customer ID:2" ]]
    [[ "$output" =~ "Units Consumed:300" ]]
    [[ "$output" =~ "Bill Amount:1500" ]]
}

@test "Single customer case" {
    gcc -o bills bills.c 2>/dev/null || skip "gcc not available"
    
    run bash -c 'echo -e "1\n99\n75" | ./bills'
    
    [[ $status -eq 0 ]]
    [[ "$output" =~ "Customer ID:99" ]]
    [[ "$output" =~ "Bill Amount:375" ]]
}

teardown() {
    rm -f bills.c bills
}
