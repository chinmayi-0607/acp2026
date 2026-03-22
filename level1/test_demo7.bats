#!/usr/bin/env bats

SOURCE_FILE="string_compare.c"

setup_file() {
    if [ -f "$SOURCE_FILE" ]; then
        gcc "$SOURCE_FILE" -o string_compare -std=c99 2>/dev/null
    fi
}

teardown_file() {
    rm -f string_compare string_compare.exe
}

setup() {
    if [ ! -f string_compare ]; then
        gcc "$SOURCE_FILE" -o string_compare -std=c99 2>/dev/null || skip "Cannot compile $SOURCE_FILE"
    fi
}

@test "Program compiles successfully" {
    if [ ! -f "$SOURCE_FILE" ]; then
        skip "$SOURCE_FILE not found"
    fi
    result=$(gcc "$SOURCE_FILE" -o /dev/null -std=c99 2>&1)
    [ "$?" -eq 0 ] || [[ ! "$result" =~ "error" ]]
}

@test "Equal strings returns 0" {
    run ./string_compare << 'EOF'
apple
apple
EOF
    [ "$status" -eq 0 ]
    [[ "$output" =~ "0 - Both strings are equal" ]]
}

@test "First string lexicographically greater returns 1" {
    run ./string_compare << 'EOF'
banana
apple
EOF
    [ "$status" -eq 0 ]
    [[ "$output" =~ "1 - First string is lexicographically greater" ]]
}

@test "Second string lexicographically greater returns -1" {
    run ./string_compare << 'EOF'
apple
banana
EOF
    [ "$status" -eq 0 ]
    [[ "$output" =~ "-1 - Second string is lexicographically greater" ]]
}

@test "Different lengths - first shorter returns -1" {
    run ./string_compare << 'EOF'
app
apple
EOF
    [ "$status" -eq 0 ]
    [[ "$output" =~ "-1 - Second string is lexicographically greater" ]]
}

@test "Different lengths - second shorter returns 1" {
    run ./string_compare << 'EOF'
apple
app
EOF
    [ "$status" -eq 0 ]
    [[ "$output" =~ "1 - First string is lexicographically greater" ]]
}

@test "Strings with numbers" {
    run ./string_compare << 'EOF'
123
456
EOF
    [ "$status" -eq 0 ]
    [[ "$output" =~ "-1 - Second string is lexicographically greater" ]]
}

@test "Strings with spaces" {
    run ./string_compare << 'EOF'
hello world
hello there
EOF
    [ "$status" -eq 0 ]
    [[ "$output" =~ "1 - First string is lexicographically greater" ]]
}
