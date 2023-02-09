#!/bin/bash

args=($@)
num_of_args=${#args[@]}
half_point=$((num_of_args / 2))

for ((i = 0; i < half_point; i++)); do
  sleep 3 # Mimic the delay
  input="${args[i]}"
  output="${args[i + half_point]}"

  tr a-z A-Z <"$input" >"$output"
done
