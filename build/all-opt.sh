#!/usr/bin/env bash

nix-shell --pure --run "bazel build -c opt //..." shell.nix
