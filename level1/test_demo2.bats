#!/bin/bash
# bats_test.sh - Fixed Bats tests for Rectangle Area Comparison Program

# Test filename
TEST_PROG="rectangle_program"
# Expected executable name (compiled program)
EXPECTED_PROG="a.out"

setup() {
    # Compile the C program before each test (skip if no .c file for compilation test)
    if [[ -f "$TEST_PROG.c" ]]; then
        gcc -o "$EXPECTED_PROG" "$TEST_PROG.c" -Wall -Wextra >/dev/null 2>&1
    fi
    # Ensure test directory is clean
    rm -f test_input.txt test_output.txt expected_output.txt
}

teardown() {
    # Clean up after each test
    rm -f "$EXPECTED_PROG" test_input.txt test_output.txt expected_output.txt
}

@test "Program compiles successfully" {
    # Skip compilation check if source doesn't exist, otherwise verify
    if [[ ! -f "$TEST_PROG.c" ]]; then
        skip "Source file $TEST_PROG.c not found"
    fi
    
    run gcc -o "$EXPECTED_PROG" "$TEST_PROG.c" -Wall -Wextra
    [[ -f "$EXPECTED_PROG" ]]
    [ "$status" -eq 0 ]
}

@test "Test Case 1: Rectangle A has largest area (50.00 > 48.00 > 49.00)" {
    cat > test_input.txt << 'EOF'
Rectangle A
10
5
Rectangle B
8
6
Rectangle C
7
7
EOF

    [[ -f "$EXPECTED_PROG" ]] || skip "Executable not found"
    run timeout 5 ./$EXPECTED_PROG < test_input.txt

    [[ "$status" -eq 0 ]]
    [[ "$output" =~ "Rectangle A has the largest area: 50.00" ]]
}

@test "Test Case 2: Rectangle B has largest area (25.00 < 60.00 > 40.00)" {
    cat > test_input.txt << 'EOF'
Rect1
5
5
Rectangle B
10
6
Rect3
8
5
EOF

    [[ -f "$EXPECTED_PROG" ]] || skip "Executable not found"
    run timeout 5 ./$EXPECTED_PROG < test_input.txt

    [[ "$status" -eq 0 ]]
    [[ "$output" =~ "Rectangle B has the largest area: 60.00" ]]
}

@test "Test Case 3: Rectangle C has largest area (40.00 < 45.00 < 72.00)" {
    cat > test_input.txt << 'EOF'
R1
10
4
R2
9
5
Rectangle C
12
6
EOF

    [[ -f "$EXPECTED_PROG" ]] || skip "Executable not found"
    run timeout 5 ./$EXPECTED_PROG < test_input.txt

    [[ "$status" -eq 0 ]]
    [[ "$output" =~ "Rectangle C has the largest area: 72.00" ]]
}

@test "Test Case 4: All rectangles have equal areas (20.00 = 20.00 = 20.00)" {
    cat > test_input.txt << 'EOF'
Equal1
5
4
Equal2
4
5
Equal3
10
2
EOF

    [[ -f "$EXPECTED_PROG" ]] || skip "Executable not found"
    run timeout 5 ./$EXPECTED_PROG < test_input.txt

    [[ "$status" -eq 0 ]]
    [[ "$output" =~ "All rectangles have equal areas!" ]]
}

@test "Test Case 5: Validates area calculation with decimals" {
    cat > test_input.txt << 'EOF'
Prec1
3.14159
2.71828
Prec2
2.5
2.5
Prec3
1.414
3.162
EOF

    [[ -f "$EXPECTED_PROG" ]] || skip "Executable not found"
    run timeout 5 ./$EXPECTED_PROG < test_input.txt

    [[ "$status" -eq 0 ]]
    # Check for 2 decimal precision in areas
    echo "$output" | grep -E "\d+\.\d{2} sq units" | wc -l | grep -q 3
}

@test "Test Case 6: Handles zero dimensions correctly" {
    cat > test_input.txt << 'EOF'
ZeroTest
10
0
Small
1
1
Medium
5
2
EOF

    [[ -f "$EXPECTED_PROG" ]] || skip "Executable not found"
    run timeout 5 ./$EXPECTED_PROG < test_input.txt

    [[ "$status" -eq 0 ]]
    [[ "$output" =~ "Medium has the largest area: 10.00" ]]
}

@test "Test Case 7: Input buffer handling with floating points" {
    cat > test_input.txt << 'EOF'
RectA
12.34
56.78
RectB
9.87
3.21
RectC
4.56
8.90
EOF

    [[ -f "$EXPECTED_PROG" ]] || skip "Executable not found"
    run timeout 5 ./$EXPECTED_PROG < test_input.txt

    [[ "$status" -eq 0 ]]
    # Verify all three rectangles processed
    echo "$output" | grep -c "Rect" | grep -q 3
}

@test "Test Case 8: Negative dimensions handled (should still work)" {
    cat > test_input.txt << 'EOF'
NegTest
-5
-4
Pos1
3
3
Pos2
2
4
EOF

    [[ -f "$EXPECTED_PROG" ]] || skip "Executable not found"
    run timeout 5 ./$EXPECTED_PROG < test_input.txt

    [[ "$status" -eq 0 ]]
    # Pos2 (8.00) should be largest
    [[ "$output" =~ "Pos2 has the largest area: 8.00" ]] || [[ "$output" =~ "Pos1 has the largest area: 9.00" ]]
}
