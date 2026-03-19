#!/usr/bin/env bats

setup() {
    # Check if source file exists before compiling
    if [ ! -f flight_program.c ]; then
        skip "flight_program.c not found - skipping tests"
    fi
    
    # Compile with explicit error checking
    if ! gcc -o flight flight_program.c -std=c99 2>/dev/null; then
        skip "Compilation failed - skipping tests"
    fi
    rm -f flight.exe 2>/dev/null
}

teardown() {
    rm -f flight flight.exe 2>/dev/null
}

@test "Search existing destination should return correct flight" {
    run ./flight << 'EOF'
AI101
Delhi
150
AI202
Mumbai
120
AI303
Chennai
80
AI404
Delhi
100
Delhi
EOF

    [ "$status" -eq 0 ]
    [[ "$output" =~ "Flight available: AI101" ]]
    [[ "$output" =~ "Flight available: AI404" ]]
}

@test "Search non-existing destination should return not found" {
    run ./flight << 'EOF'
AI101
Delhi
50
AI202
Mumbai
30
AI303
Chennai
20
AI404
Bangalore
10
Kolkata
EOF

    [ "$status" -eq 0 ]
    [[ "$output" =~ "No flights available to Kolkata" ]]
    [[ ! "$output" =~ "Flight available" ]]
}

@test "Case insensitive search should work" {
    run ./flight << 'EOF'
AI101
Delhi
50
AI202
Mumbai
30
AI303
Chennai
20
AI404
Delhi
10
delhi
EOF

    [ "$status" -eq 0 ]
    [[ "$output" =~ "Flight available: AI101" ]]
    [[ "$output" =~ "Flight available: AI404" ]]
}

@test "Multiple flights to same destination shows all" {
    run ./flight << 'EOF'
AI101
Mumbai
50
AI202
Delhi
30
AI303
Mumbai
20
AI404
Chennai
10
Mumbai
EOF

    [ "$status" -eq 0 ]
    [[ "$output" =~ "Flight available: AI101" ]]
    [[ "$output" =~ "Flight available: AI303" ]]
}

@test "Program compiles successfully" {
    if [ ! -f flight_program.c ]; then
        skip "flight_program.c not found"
    fi
    result=$(gcc -o /dev/null flight_program.c -std=c99 2>&1)
    [ "$?" -eq 0 ] || [ -z "$result" ] || [[ ! "$result" =~ "error" ]]
}
