#!/usr/bin/env bash

nix-shell --pure --run "bazel test //..." shell.nix
