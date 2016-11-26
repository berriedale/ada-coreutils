#!/usr/bin/env bats

load ../test_helper

# This test ensures that the "piped" behavior of our ls(1)
# matches that of /bin/ls
@test "List the current directory" {
    _run ls
    [ "$status" -eq 0 ]
    [ "$output" = "$(/bin/ls)" ]
}
