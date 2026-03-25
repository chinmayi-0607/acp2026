#!/usr/bin/env bash
# test_act2.bats - Fixed heredoc syntax

@test "Free units (40 units @ 5.5) = 0.00 bill" {
    cat > bill.c << 'EOF'
#include <stdio.h>

typedef struct 
{
    int units;
    float rate;
    float total_bill;
} ElectricityBill;

ElectricityBill input(){
    ElectricityBill e;
    scanf("%d",&e.units);
    scanf("%f",&e.rate);
    return e;
}

ElectricityBill calculate_bill(ElectricityBill bill){
    if (bill.units<50)
        bill.total_bill=0;
    else if (bill.units>100){
        int extra=bill.units-100;
        bill.total_bill=(100*bill.rate)+(extra*(bill.rate+5));
    }
    else
        bill.total_bill=bill.rate*bill.units;
    return bill;
}

void output(ElectricityBill bill){
    if (bill.units<50)
        printf("elegible for free unit consumption");
    else
        printf("High consumption alert! Extra charge applied");
    printf("total bill:%f",bill.total_bill);
}

int main(){
    ElectricityBill bill;
    bill=input();
    bill=calculate_bill(bill);
    output(bill);
    return 0;
}
EOF

    gcc -o bill bill.c 2>/dev/null || skip "gcc not available"
    
    run bash -c 'echo -e "40\n5.5\n" | ./bill'
    [[ $status -eq 0 ]]
    [[ "$output" =~ "elegible for free unit consumptiontotal bill:0" ]]
}

@test "Normal usage (75 units @ 5.5) = 412.50" {
    gcc -o bill bill.c 2>/dev/null || skip "gcc not available"
    run bash -c 'echo -e "75\n5.5\n" | ./bill'
    [[ $status -eq 0 ]]
    [[ "$output" =~ "total bill:412.500000" ]]
}

@test "High usage (150 units @ 5.5) = 1075.00" {
    gcc -o bill bill.c 2>/dev/null || skip "gcc not available"
    run bash -c 'echo -e "150\n5.5\n" | ./bill'
    [[ $status -eq 0 ]]
    [[ "$output" =~ "total bill:1075" ]]
}

teardown() {
    rm -f bill.c bill
}
