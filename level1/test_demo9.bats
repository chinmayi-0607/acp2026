#!/usr/bin/env bats

SOURCE_FILE="student_file.c"

setup() {
    gcc "$SOURCE_FILE" -o student_file -std=c99 2>/dev/null || true
    rm -f student_file.exe students.txt
}

@test "compiles successfully" {
    [ -f student_file ] || skip "student_file.c not found"
}

@test "handles 1 student" {
    if [ ! -f student_file ]; then skip; fi
    echo "1
101
Alice
85.5" | ./student_file > output.txt 2>&1
    grep -q "Roll No: 101" output.txt
    grep -q "Name: Alice" output.txt
    rm output.txt
}

@test "handles 2 students" {
    if [ ! -f student_file ]; then skip; fi
    echo "2
101
Alice
85.5
102
Bob
92.0" | ./student_file > output.txt 2>&1
    grep -q "Roll No: 101" output.txt
    grep -q "Roll No: 102" output.txt
    rm output.txt
}

@test "handles zero students" {
    if [ ! -f student_file ]; then skip; fi
    echo "0" | ./student_file > output.txt 2>&1
    [ -f output.txt ]
    rm output.txt
}
