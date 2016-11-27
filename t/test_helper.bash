#!/usr/bin/env bash

# _run() is just a wrapped version of run() which makes sure we're using the
# right files
_run() {
    run ./build/obj/$@
}

export FIXTURE=Fixturefile.$(date "+%Y%m%d-%H:%M")
