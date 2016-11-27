#!/usr/bin/env bats

load ../test_helper

@test "sync" {
    _run sync
    [ "$status" -eq 0 ]
}
