#!/usr/bin/env bats

@test "ls -a in the current directory" {
    run ls -a
    [ "$status" -eq 0 ]
    [ "$output" = "$(/bin/ls -a)" ]
}
@test "ls --all" {
    run ls --all
    [ "$status" -eq 0 ]
    [ "$output" = "$(/bin/ls --all)" ]
}

@test "ls -r in the current directory" {
    run ls -r
    [ "$status" -eq 0 ]
    [ "$output" = "$(/bin/ls -r)" ]
}

@test "ls --reverse" {
    run ls --reverse
    [ "$status" -eq 0 ]
    [ "$output" = "$(/bin/ls --reverse)" ]
}
