#!/usr/bin/env bats

load ../test_helper

setup() {
    touch $FIXTURE
}

teardown() {
    rm -f $FIXTURE
}

@test "List a file" {
    _run ls $FIXTURE
    [ "$status" -eq 0 ]
    [ "$output" = "$(/bin/ls $FIXTURE)" ]
}
