#!/usr/bin/env bats

@test "Swap Hello and World" {
  run ./act5 <<EOF
Hello
World
EOF
  [[ "$output" == *"Hello"* ]]
  [[ "$output" == *"World"* ]]
  [[ "$output" == *"swapped string"* ]]
  [[ "$output" == *"World"* ]]
  [[ "$output" == *"Hello"* ]]
}

@test "Swap Apple and Banana" {
  run ./act5 <<EOF
Apple
Banana
EOF
  [[ "$output" == *"Apple"* ]]
  [[ "$output" == *"Banana"* ]]
  [[ "$output" == *"swapped string"* ]]
  [[ "$output" == *"Banana"* ]]
  [[ "$output" == *"Apple"* ]]
}
