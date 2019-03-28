#!/usr/bin/env bash

out=$1
shift
cat "$@" > $out
