#!/usr/bin/env bats

load ../test_helper

@test "uname -r" {
   skip "uname not impemented yet"
   _run uname -r
   [ "$status" -eq 0 ]
   [ "$output" = "$(uname -r)"]
}
