#!/usr/bin/env bats

load ../test_helper

@test "pwd" {
    _run pwd
    [ "$status" -eq 0 ]
    [ "$output" = "$(/bin/pwd)" ];
}

@test "pwd --version" {
    _run pwd --version
    [ "$status" -eq 0 ]
    [ "$output" =  "pwd (Ada coreutils) 0.1" ];
}
