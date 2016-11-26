#!/usr/bin/env bats

load ../test_helper

@test "true" {
    _run true
    [ "$status" -eq 0 ]
}

@test "true --version" {
    _run true --version
    [ "$status" -eq 0 ]
    [ "$output" =  "true (Ada coreutils) 0.1" ];
}

@test "true --help" {
    _run true --help
    [ "$status" -eq 0 ]
}
