#!/usr/bin/env bats

load ../test_helper

SYMBOLIC_LINK="${FIXTURE}-symbolic-link"

setup() {
    touch $FIXTURE
    ln -s $FIXTURE $SYMBOLIC_LINK
}

teardown() {
    rm -f $FIXTURE $SYMBOLIC_LINK
}

@test "readlink with no argument" {
   _run readlink
   [ "$status" -eq 1 ]
   [ "$output" = "readlink: missing operand" ]
}

@test "readlink with just a file" {
   _run readlink $FIXTURE
   [ "$status" -eq 1 ]
}

@test "readlink with a symbolic link" {
   _run readlink $SYMBOLIC_LINK
   [ "$status" -eq 0 ]
   [ "$output" = "$(/bin/readlink $SYMBOLIC_LINK)" ]
}
