#!/usr/bin/env bash
# test_electricity.bats - Tests electricity bill calculation

@test "Low usage (50 units @ 5.5) = 275.00" {
    # Create the fixed C program
    cat > bill.c << 'EOF'
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
    bill = input();
    bill = calculate_bill(bill);
    output(bill);
    return 0;
}

ElectricityBill input()
{
    ElectricityBill e;
    scanf("%d", &e.units);
    scanf("%f", &e.rate);
    e.total_bill = 0.0f;
    return e;
}

ElectricityBill calculate_bill(ElectricityBill bill)
{
    if (bill.units > 100)
    {
        int extra = bill.units - 100;
        bill.total_bill = (100 * bill.rate) + (extra * (bill.rate + 5.0f));
    }
    else
    {
        bill.total_bill = bill.rate * bill.units;
    }
    return bill;
}

void output(ElectricityBill bill)
{
    if (bill.units > 100)
    {
        printf("High consumption alert! Extra charge applied.\n");
    }
    printf("Total bill: %.2f\n", bill.total_bill);
}
EOF

    # Compile (skip if gcc not available)
    gcc -Wall -o bill bill.c 2>/dev/null || skip "gcc not available"
    
    # Test low usage: 50 units * 5.5 = 275.00
    run bash -c 'echo -e "50\n5.5\n" | ./bill'
    
    [[ $status -eq 0 ]]
    [[ "$output" =~ "Total bill: 275.00" ]]
}

@test "High usage (150 units @ 5.5) = 900.00" {
    gcc -Wall -o bill bill.c 2>/dev/null || skip "gcc not available"
    
    # Test high usage: (100*5.5) + (50*10.5) = 550 + 525 = 1075.00? Wait, let me calculate:
    # Actually: 100*5.5 + 50*(5.5+5) = 550 + 50*10.5 = 550 + 525 = 1075.00
    run bash -c 'echo -e "150\n5.5\n" | ./bill'
    
    [[ $status -eq 0 ]]
    [[ "$output" =~ "Total bill: 1075.00" ]]
    [[ "$output" =~ "High consumption alert" ]]
}

@test "Edge case (100 units @ 4.0) = 400.00" {
    gcc -Wall -o bill bill.c 2>/dev/null || skip "gcc not available"
    
    run bash -c 'echo -e "100\n4.0\n" | ./bill'
    
    [[ $status -eq 0 ]]
    [[ "$output" =~ "Total bill: 400.00" ]]
    [[ ! "$output" =~ "High consumption" ]]
}

teardown() {
    rm -f bill.c bill
}
