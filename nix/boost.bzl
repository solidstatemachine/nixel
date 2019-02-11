# -*- python -*-

load(
    "@io_tweag_rules_nixpkgs//nixpkgs:nixpkgs.bzl",
    "nixpkgs_package",
)

def nix_boost():
    nixpkgs_package(
        name = "nix-boost_lib",
        attribute_path = "boost",
        repositories = {"nixpkgs": "@nixpkgs"},
        build_file_content = """
package(default_visibility = ["//visibility:public"])
cc_library(
  name = "nix-boost_lib",
  srcs = glob([
      "lib/**/*.so*",
      "lib/**/*.a",
    ],
    exclude = ["lib/libboost_test_exec_monitor.a"]
  ),
)
    """,
    )
    nixpkgs_package(
        name = "nix-boost",
        attribute_path = "boost.dev",
        repositories = {"nixpkgs": "@nixpkgs"},
        build_file_content = """
package(default_visibility = ["//visibility:public"])
cc_library(
  name = "nix-boost",
  hdrs = glob(["include/**/*.h", "include/**/*.hpp"]),
  deps = ["@nix-boost_lib"],
  includes = ["include/"],
)
    """,
    )
