#!/usr/bin/env bash

nix-shell --pure --run "bazel build --keep_going -c opt //..." shell.nix
