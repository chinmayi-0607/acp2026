#!/usr/bin/env bats

setup_file() {
    # Compile once for all tests
    if [ ! -f swap_array.c ]; then
        skip "swap_array.c not found"
        return
    fi
    gcc -o swap_array swap_array.c -std=c99 2>/dev/null || {
        echo "Compilation failed" >&2
    }
}

teardown_file() {
    rm -f swap_array swap_array.exe
}

setup() {
    rm -f swap_array swap_array.exe 2>/dev/null
    gcc -o swap_array swap_array.c -std=c99 2>/dev/null || true
}

@test "Program compiles successfully" {
    if [ ! -f swap_array.c ]; then
        skip "swap_array.c not found"
    fi
    result=$(gcc -o /dev/null swap_array.c -std=c99 2>&1)
    [ "$?" -eq 0 ] || [[ ! "$result" =~ "error" ]]
}

@test "Swap empty arrays (n=0)" {
    run ./swap_array << 'EOF'
0
EOF
    [ "$status" -eq 0 ]
}

@test "Swap single element arrays" {
    run ./swap_array << 'EOF'
1
10
20
EOF

    [ "$status" -eq 0 ]
    [[ "$output" =~ "Array 1: 20" ]]
    [[ "$output" =~ "Array 2: 10" ]]
}

@test "Swap arrays with equal values" {
    run ./swap_array << 'EOF'
3
1
2
3
1
2
3
EOF

    [ "$status" -eq 0 ]
    [[ "$output" =~ "Array 1: 1 2 3" ]]
    [[ "$output" =~ "Array 2: 1 2 3" ]]
}

@test "Swap arrays with different values" {
    run ./swap_array << 'EOF'
4
10
20
30
40
50
60
70
80
EOF

    [ "$status" -eq 0 ]
    [[ "$output" =~ "Array 1: 50 60 70 80" ]]
    [[ "$output" =~ "Array 2: 10 20 30 40" ]]
}

@test "Swap large arrays (n=5)" {
    run ./swap_array << 'EOF'
5
1
2
3
4
5
10
20
30
40
50
EOF

    [ "$status" -eq 0 ]
    [[ "$output" =~ "Array 1: 10 20 30 40 50" ]]
    [[ "$output" =~ "Array 2: 1 2 3 4 5" ]]
}

@test "Handles negative numbers correctly" {
    run ./swap_array << 'EOF'
3
-1
0
1
-10
-20
-30
EOF

    [ "$status" -eq 0 ]
    [[ "$output" =~ "Array 1: -10 -20 -30" ]]
    [[ "$output" =~ "Array 2: -1 0 1" ]]
}
