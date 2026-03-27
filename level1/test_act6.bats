#!/usr/bin/env bats

setup() {
  rm -f scores
  if ! gcc -o scores scores.c -Wall -std=c99 -g 2>/dev/null; then
    skip "Cannot compile scores.c (check source file exists)"
  fi
}

teardown() {
  rm -f scores
}

@test "Invalid n <= 0 prints error and exits 1" {
  run ./scores <<< "0"
  [ "$status" -eq 127 ] || [ "$status" -eq 1 ]
  [[ "$output" =~ "enter number of players:" ]]
  [[ "$output" =~ "Invalid number of players." ]]
}

@test "n=3 scores 10 20 30: correct display and total" {
  run ./scores <<< $'3\n10\n20\n30\n'
  [ "$status" -eq 0 ]
  [[ "$output" =~ "enter number of players:" ]]
  [[ "$output" =~ "Enter scores:" ]]
  [[ "$output" =~ "Scores:" ]]
  [[ "$output" =~ "10" ]]
  [[ "$output" =~ "20" ]]
  [[ "$output" =~ "30" ]]
  [[ "$output" =~ "Total score:60" ]]
}

@test "n=1 score 100: total 100" {
  run ./scores <<< $'1\n100\n'
  [ "$status" -eq 0 ]
  [[ "$output" =~ "Total score:100" ]]
  [[ "$output" =~ "100" ]]
}

@test "n=4 scores 1 2 3 4: total 10" {
  run ./scores <<< $'4\n1\n2\n3\n4\n'
  [ "$status" -eq 0 ]
  [[ "$output" =~ "Total score:10" ]]
  [[ "$output" =~ "1" && "$output" =~ "2" && "$output" =~ "3" && "$output" =~ "4" ]]
}

@test "n=2 scores 5 10: completes successfully" {
  run ./scores <<< $'2\n5\n10\n'
  [ "$status" -eq 0 ]
  [[ "$output" =~ "Total score:15" ]]
}

@test "Handles negative scores" {
  run ./scores <<< $'2\n-5\n10\n'
  [ "$status" -eq 0 ]
  [[ "$output" =~ "Total score:5" ]]
}