#!/usr/bin/env bats

@test "ls -a in the current directory" {
    run ls -a
    [ "$status" -eq 0 ]
    [ "$output" = "$(/bin/ls -a)" ]
}
