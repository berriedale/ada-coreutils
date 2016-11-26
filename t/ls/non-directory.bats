#!/usr/bin/env bats

load ../test_helper

FIXTURE=Fixturefile.$(date "+%Y%m%d-%H:%M")

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
