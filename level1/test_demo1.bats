#!/usr/bin/env bats

@test "Maximum element in normal array" {
  run bash -c "printf '5\n1\n4\n2\n7\n3\n' | ./demo1"
  [[ "$output" == *"The maximum element is: 7.00"* ]]
  [[ "$output" == *"Index of the maximum element: 3"* ]]
}

@test "Maximum at first index" {
  run bash -c "printf '4\n9\n3\n2\n1\n' | ./demo1"
  [[ "$output" == *"The maximum element is: 9.00"* ]]
  [[ "$output" == *"Index of the maximum element: 0"* ]]
}

@test "Maximum at last index" {
  run bash -c "printf '4\n1\n2\n3\n8\n' | ./demo1"
  [[ "$output" == *"The maximum element is: 8.00"* ]]
  [[ "$output" == *"Index of the maximum element: 3"* ]]
}

@test "Negative numbers test" {
  run bash -c "printf '3\n-5\n-2\n-9\n' | ./demo1"
  [[ "$output" == *"The maximum element is: -2.00"* ]]
  [[ "$output" == *"Index of the maximum element: 1"* ]]
}

@test "Single element array" {
  run bash -c "printf '1\n10\n' | ./demo1"
  [[ "$output" == *"The maximum element is: 10.00"* ]]
  [[ "$output" == *"Index of the maximum element: 0"* ]]
}

@test "Invalid array size" {
  run bash -c "printf '0\n' | ./demo1"
  [[ "$output" == *"Invalid array size."* ]]
}