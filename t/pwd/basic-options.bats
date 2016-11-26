#!/usr/bin/env bats

load ../test_helper

@test "pwd" {
    _run pwd
    [ "$status" -eq 0 ]
    [ "$output" = "$(/bin/pwd)" ];
}
