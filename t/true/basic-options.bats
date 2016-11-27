#!/usr/bin/env bats

load ../test_helper

@test "true" {
    _run true
    [ "$status" -eq 0 ]
}

@test "true --version" {
    _run true --version
    [ "$status" -eq 0 ]
}
