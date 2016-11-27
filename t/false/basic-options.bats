#!/usr/bin/env bats

load ../test_helper

@test "false" {
    _run false
    [ "$status" -eq 1 ]
}

@test "false --version" {
    _run false --version
    [ "$status" -eq 1 ]
    [ "$output" =  "false (Ada coreutils) 0.1" ];
}
