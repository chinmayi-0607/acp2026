#!/usr/bin/env bats

# Compile the program before tests
setup() {
    gcc act4.c -o act4
}

@test "Average calculation test (known values)" {
    run ./act4 <<EOF
Virat Kohli
18
50
Rohit Sharma
45
60
KL Rahul
1
40
Hardik Pandya
33
30
MS Dhoni
7
20
Shubman Gill
77
70
Surya Kumar
63
80
Ravindra Jadeja
8
25
Bumrah
93
10
Shami
11
15
Siraj
13
5
EOF

    # Total runs = 50+60+...+5 = 405
    # 405 / 11 ≈ 36.82 (with %.2f)
    [[ "$output" == *"average score:36.82"* ]]
}

@test "Program runs successfully (no crash)" {
    run ./act4 <<EOF
A
1
10
B
2
20
C
3
30
D
4
40
E
5
50
F
6
60
G
7
70
H
8
80
I
9
90
J
10
100
K
11
110
EOF

    [ "$status" -eq 0 ]
}

@test "Check correct handling of zero runs" {
    run ./act4 <<EOF
A
1
0
B
2
0
C
3
0
D
4
0
E
5
0
F
6
0
G
7
0
H
8
0
I
9
0
J
10
0
K
11
0
EOF

    # Expected: average score:0.00
    [[ "$output" == *"average score:0.00"* ]]
}
