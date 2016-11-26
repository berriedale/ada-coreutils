#!/usr/bin/env bats

load ../test_helper

@test "ls -a in the current directory" {
    _run ls -a
    [ "$status" -eq 0 ]
    [ "$output" = "$(/bin/ls -a)" ]
}
@test "ls --all" {
    _run ls --all
    [ "$status" -eq 0 ]
    [ "$output" = "$(/bin/ls --all)" ]
}

@test "ls -r in the current directory" {
    _run ls -r
    [ "$status" -eq 0 ]
    [ "$output" = "$(/bin/ls -r)" ]
}

@test "ls --reverse" {
    _run ls --reverse
    [ "$status" -eq 0 ]
    [ "$output" = "$(/bin/ls --reverse)" ]
}
