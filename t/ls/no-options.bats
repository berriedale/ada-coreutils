#!/usr/bin/env bats

# This test ensures that the "piped" behavior of our ls(1)
# matches that of /bin/ls
@test "List the current directory" {
    run ls
    [ "$status" -eq 0 ]
    [ "$output" = "$(/bin/ls)" ]
}
