# -*- python -*-

load(
    "@io_tweag_rules_nixpkgs//nixpkgs:nixpkgs.bzl",
    "nixpkgs_package",
)

def nix_zlib():
    nixpkgs_package(
        name = "nix-zlib_static",
        attribute_path = "zlib.static",
        repositories = {"nixpkgs": "@nixpkgs"},
    )
    nixpkgs_package(
        name = "nix-zlib",
        attribute_path = "zlib.dev",
        repositories = {"nixpkgs": "@nixpkgs"},
        build_file_content = """
package(default_visibility = ["//visibility:public"])
cc_library(
  name = "nix-zlib",
  hdrs = glob(["include/**/*.h"]),
  srcs = ["@nix-zlib_static//:lib"],
  includes = ["include/"],
  linkstatic = 1,
)
    """,
    )
