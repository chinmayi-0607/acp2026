#!/usr/bin/env bats

setup() {
    gcc -o students demo10.c
}

@test "compile student binary" {
    [ -x students ]
}

@test "run with 2 students and check file exists" {
    run bash -c 'printf "2\n1\nAlice\n90.5\n2\nBob\n85.0\n" | ./students'
    [ "$status" -eq 0 ]
    [ -f "students.dat" ]
}

@test "file size reasonable for 2 students" {
    run bash -c 'printf "2\n1\nAlice\n90.5\n2\nBob\n85.0\n" | ./students'
    run stat -c%s "students.dat"
    [ "$output" -gt 50 ]
}

@test "reading from students.dat prints 2 students" {
    printf "2\n1\nAlice\n90.5\n2\nBob\n85.0\n" | ./students >/dev/null

    run ./students
    [ "$status" -eq 0 ]
    [[ "$output" =~ "Students read from file:" ]]
    [[ "$output" =~ "Student 1" ]]
    [[ "$output" =~ "Student 2" ]]
}