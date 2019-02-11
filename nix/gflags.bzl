# -*- python -*-

load(
    "@io_tweag_rules_nixpkgs//nixpkgs:nixpkgs.bzl",
    "nixpkgs_package",
)

def nix_gflags():
    nixpkgs_package(
        name = "nix-gflags",
        attribute_path = "gflags",
        repositories = {"nixpkgs": "@nixpkgs"},
        build_file_content = """
package(default_visibility = ["//visibility:public"])
cc_library(
  name = "nix-gflags",
  hdrs = glob(["include/**/*.h"]),
  #srcs = ["lib/libgflags.a"],
  srcs = glob(["lib/libgflags.so*"]),
  includes = ["include/"],
  linkopts = ["-lpthread"],
)
    """,
    )
