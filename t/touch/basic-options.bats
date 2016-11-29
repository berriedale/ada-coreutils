#!/usr/bin/env bats

load ../test_helper

teardown() {
   rm -f $FIXTURE
}

@test "touch" {
   _run touch $FIXTURE
   [ "$status" -eq 0 ]
   [ -f $FIXTURE ]
}

@test "touch a file that exists" {
   touch $FIXTURE
   _run touch $FIXTURE
   [ "$status" -eq 0 ]
   [ -f $FIXTURE ]
}

@test "touch with no arguments" {
   _run touch
   [ "$status" -eq 1 ]
   [ "$output" = "touch: missing file operand" ]
}
