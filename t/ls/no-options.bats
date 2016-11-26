#!/usr/bin/env bats

@test "List the current directory" {
    run ls
    [ "$status" -eq 0 ]
    [ "$output" = "$(/bin/ls)" ]
}
