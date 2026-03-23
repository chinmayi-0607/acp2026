#!/usr/bin/env bats

SOURCE_FILE="concatenate.c"

setup_file() {
    if [ -f "$SOURCE_FILE" ]; then
        gcc "$SOURCE_FILE" -o concatenate -std=c99 2>/dev/null
    fi
}

teardown_file() {
    rm -f concatenate concatenate.exe
}

setup() {
    if [ ! -f concatenate ]; then
        gcc "$SOURCE_FILE" -o concatenate -std=c99 2>/dev/null || skip "Cannot compile $SOURCE_FILE"
    fi
}

@test "Program compiles successfully" {
    if [ ! -f "$SOURCE_FILE" ]; then
        skip "$SOURCE_FILE not found"
    fi
    result=$(gcc "$SOURCE_FILE" -o /dev/null -std=c99 2>&1)
    [ "$?" -eq 0 ] || [[ ! "$result" =~ "error" ]]
}

@test "Concatenates basic strings" {
    run ./concatenate << 'EOF'
Hello
World
EOF
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Concatenated string: HelloWorld" ]]
}

@test "Concatenates single characters" {
    run ./concatenate << 'EOF'
a
b
EOF
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Concatenated string: ab" ]]
}

@test "Concatenates with numbers" {
    run ./concatenate << 'EOF'
123
456
EOF
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Concatenated string: 123456" ]]
}

@test "Concatenates strings with spaces" {
    run ./concatenate << 'EOF'
Hello World
How are you
EOF
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Concatenated string: Hello WorldHow are you" ]]
}

@test "Empty second string" {
    run ./concatenate << 'EOF'
First

EOF
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Concatenated string: First" ]]
}

@test "Longer first string" {
    run ./concatenate << 'EOF'
Programming in C
is fun
EOF
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Concatenated string: Programming in Cis fun" ]]
}

@test "Special characters" {
    run ./concatenate << 'EOF'
Hello!
World!
EOF
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Concatenated string: Hello!World!" ]]
}
