#!/usr/bin/env bats

@test "true" {
    run true
    [ "$status" -eq 0 ]
}
