#!/usr/bin/env bash

# _run() is just a wrapped version of run() which makes sure we're using the
# right files
_run() {
    run ./build/obj/$@
}
