#!/bin/bash
# bats_test.sh - Working Bats tests for Rectangle Array Program

# Test filename
TEST_PROG="rectangle_array"
EXPECTED_PROG="a.out"

setup() {
    # Compile before each test only if source exists
    if [[ -f "$TEST_PROG.c" ]]; then
        gcc -o "$EXPECTED_PROG" "$TEST_PROG.c" -Wall -Wextra 2>/dev/null
    fi
    # Clean test files
    rm -f test_input.txt test_output.txt
}

teardown() {
    # Clean up
    rm -f "$EXPECTED_PROG" test_input.txt test_output.txt
}

@test "Program compiles successfully" {
    if [[ ! -f "$TEST_PROG.c" ]]; then
        skip "Source file $TEST_PROG.c not found"
    fi
    run gcc -o "$EXPECTED_PROG" "$TEST_PROG.c" -Wall -Wextra 2>/dev/null
    [[ -f "$EXPECTED_PROG" ]]
    [ "$status" -eq 0 ]
}

@test "Test Case 1: Single rectangle n=1" {
    cat > test_input.txt << 'EOF'
1
10
5
EOF

    [[ ! -f "$EXPECTED_PROG" ]] && skip "Executable not built"
    run timeout 5 ./$EXPECTED_PROG < test_input.txt

    [ "$status" -eq 0 ]
    echo "$output" | grep -q "Rectangle 1:.*Area=50.00"
    echo "$output" | grep -q "Rectangle 1 has the LARGEST area: 50.00"
}

@test "Test Case 2: First rectangle largest (n=3)" {
    cat > test_input.txt << 'EOF'
3
10
5
8
6
7
7
EOF

    [[ ! -f "$EXPECTED_PROG" ]] && skip "Executable not built"
    run timeout 5 ./$EXPECTED_PROG < test_input.txt

    [ "$status" -eq 0 ]
    echo "$output" | grep -q "Rectangle 1 has the LARGEST area: 50.00"
    echo "$output" | grep -q "Area=50.00"
    echo "$output" | grep -q "Area=48.00"
}

@test "Test Case 3: Last rectangle largest (n=3)" {
    cat > test_input.txt << 'EOF'
3
5
4
6
5
10
6
EOF

    [[ ! -f "$EXPECTED_PROG" ]] && skip "Executable not built"
    run timeout 5 ./$EXPECTED_PROG < test_input.txt

    [ "$status" -eq 0 ]
    echo "$output" | grep -q "Rectangle 3 has the LARGEST area: 60.00"
}

@test "Test Case 4: Middle rectangle largest (n=4)" {
    cat > test_input.txt << 'EOF'
4
5
3
8
6
4
7
2
2
EOF

    [[ ! -f "$EXPECTED_PROG" ]] && skip "Executable not built"
    run timeout 5 ./$EXPECTED_PROG < test_input.txt

    [ "$status" -eq 0 ]
    echo "$output" | grep -q "Rectangle 2 has the LARGEST area: 48.00"
}

@test "Test Case 5: All equal areas - picks first" {
    cat > test_input.txt << 'EOF'
3
5
4
4
5
2
10
EOF

    [[ ! -f "$EXPECTED_PROG" ]] && skip "Executable not built"
    run timeout 5 ./$EXPECTED_PROG < test_input.txt

    [ "$status" -eq 0 ]
    echo "$output" | grep -q "Rectangle 1 has the LARGEST area: 20.00"
}

@test "Test Case 6: Decimal precision handling" {
    cat > test_input.txt << 'EOF'
2
3.14
2.71
2.5
2.5
EOF

    [[ ! -f "$EXPECTED_PROG" ]] && skip "Executable not built"
    run timeout 5 ./$EXPECTED_PROG < test_input.txt

    [ "$status" -eq 0 ]
    echo "$output" | grep -E "\d+\.\d{2}" | grep -q "sq units"
}

@test "Test Case 7: Zero area handling" {
    cat > test_input.txt << 'EOF'
3
10
0
1
1
5
3
EOF

    [[ ! -f "$EXPECTED_PROG" ]] && skip "Executable not built"
    run timeout 5 ./$EXPECTED_PROG < test_input.txt

    [ "$status" -eq 0 ]
    echo "$output" | grep -q "Rectangle 3 has the LARGEST area: 15.00"
}

@test "Test Case 8: Input validation n=0" {
    cat > test_input.txt << 'EOF'
0
EOF

    [[ ! -f "$EXPECTED_PROG" ]] && skip "Executable not built"
    run timeout 5 ./$EXPECTED_PROG < test_input.txt

    [ "$status" -ne 0 ]
    echo "$output" | grep -q "Invalid number"
}

@test "Test Case 9: Large input n=5" {
    cat > test_input.txt << 'EOF'
5
2
2
3
3
4
4
1
10
6
7
EOF

    [[ ! -f "$EXPECTED_PROG" ]] && skip "Executable not built"
    run timeout 5 ./$EXPECTED_PROG < test_input.txt

    [ "$status" -eq 0 ]
    echo "$output" | grep -q "Rectangle 5 has the LARGEST area: 42.00"
}

@test "Test Case 10: Negative dimensions" {
    cat > test_input.txt << 'EOF'
3
-5
4
3
4
2
2
EOF

    [[ ! -f "$EXPECTED_PROG" ]] && skip "Executable not built"
    run timeout 5 ./$EXPECTED_PROG < test_input.txt

    [ "$status" -eq 0 ]
    echo "$output" | grep -q "Rectangle 2 has the LARGEST area: 12.00"
}
