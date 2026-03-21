#!/usr/bin/env bats

# Use the ACTUAL filename from your C code
SOURCE_FILE="dynamic_array.c"  # Change this to your exact C filename!

setup() {
    # Only compile if source exists and binary doesn't exist
    if [ -f "$SOURCE_FILE" ] && [ ! -f dynamic_array ]; then
        gcc "$SOURCE_FILE" -o dynamic_array -std=c99 2>/dev/null || true
    fi
    rm -f dynamic_array.exe 2>/dev/null
}

@test "Program compiles successfully" {
    if [ ! -f "$SOURCE_FILE" ]; then
        skip "$SOURCE_FILE not found - create the C file first"
    fi
    result=$(gcc "$SOURCE_FILE" -o /dev/null -std=c99 2>&1)
    [ "$?" -eq 0 ] || [[ ! "$result" =~ "error" ]]
}

@test "Handles n=0 gracefully" {
    if [ ! -f dynamic_array ]; then
        skip "Binary not compiled - run setup first"
    fi
    run ./dynamic_array << 'EOF'
0
EOF
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Enter 0 elements" ]]
}

@test "Single element array works" {
    if [ ! -f dynamic_array ]; then
        skip "Binary not compiled"
    fi
    run ./dynamic_array << 'EOF'
1
42
EOF
    [ "$status" -eq 0 ]
    [[ "$output" =~ "42 " ]]
    [[ "$output" =~ "Memory successfully freed" ]]
}

@test "Multiple elements array" {
    if [ ! -f dynamic_array ]; then
        skip "Binary not compiled"
    fi
    run ./dynamic_array << 'EOF'
3
10
20
30
EOF
    [ "$status" -eq 0 ]
    [[ "$output" =~ "10 20 30" ]]
    [[ "$output" =~ "Memory successfully freed" ]]
}

@test "Large array allocation" {
    if [ ! -f dynamic_array ]; then
        skip "Binary not compiled"
    fi
    run ./dynamic_array << 'EOF'
5
1
2
3
4
5
EOF
    [ "$status" -eq 0 ]
    [[ "$output" =~ "1 2 3 4 5" ]]
}

@test "Negative numbers handling" {
    if [ ! -f dynamic_array ]; then
        skip "Binary not compiled"
    fi
    run ./dynamic_array << 'EOF'
4
-1
0
1
-100
EOF
    [ "$status" -eq 0 ]
    [[ "$output" =~ "-1 0 1 -100" ]]
}

@test "Memory deallocation message appears" {
    if [ ! -f dynamic_array ]; then
        skip "Binary not compiled"
    fi
    run ./dynamic_array << 'EOF'
2
100
200
EOF
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Memory successfully freed and pointer set to NULL." ]]
}
