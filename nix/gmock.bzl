# -*- python -*-

load(
    "@io_tweag_rules_nixpkgs//nixpkgs:nixpkgs.bzl",
    "nixpkgs_package",
)

def nix_gmock():
    nixpkgs_package(
        name = "nix-gmock",
        attribute_path = "gmock",
        repositories = {"nixpkgs": "@nixpkgs"},
        build_file_content = """
package(default_visibility = ["//visibility:public"])
cc_library(
  name = "nix-gmock",
  hdrs = glob(["include/**/*.h"]),
  srcs = ["lib/libgmock.a", "lib/libgtest.a"],
  includes = ["include/"],
  linkopts = ["-lpthread"],
)
cc_library(
  name = "main",
  srcs = ["lib/libgmock_main.a"],
  deps = [":nix-gmock"],
)
    """,
    )
