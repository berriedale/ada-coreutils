#!/usr/bin/env bats

FIXTURE=Fixturefile.$(date "+%Y%m%d-%H:%M")

setup() {
    touch $FIXTURE
}

teardown() {
    rm -f $FIXTURE
}

@test "List a file" {
    run ls $FIXTURE
    [ "$status" -eq 0 ]
    [ "$output" = "$(/bin/ls $FIXTURE)" ]
}
