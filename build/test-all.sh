#!/usr/bin/env bash

nix-shell --pure --run "bazel test --keep_going //..." shell.nix
