#! nix-shell

with import <nixpkgs> {};

mkShell rec {
  buildInputs = [
    ## Try to keep this set as small as possible.
    bazel  # To build code
    git    # To fetch code
    nix    # To self-host and get access to these buildInputs

    ## Needed by Clodl
    pax-utils
    zip
  ];
}