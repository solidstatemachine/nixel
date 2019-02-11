# -*- python -*-

load(
    "@io_tweag_rules_nixpkgs//nixpkgs:nixpkgs.bzl",
    "nixpkgs_package",
)

def nix_gbenchmark():
    nixpkgs_package(
        name = "nix-gbenchmark",
        attribute_path = "gbenchmark",
        repositories = {"nixpkgs": "@nixpkgs"},
        build_file_content = """
package(default_visibility = ["//visibility:public"])
cc_library(
  name = "nix-gbenchmark",
  hdrs = glob(["include/**/*.h"]),
  srcs = glob(["lib/**/*.so*", "lib/**/*.dylib", "lib/**/*.a"]),
  includes = ["include/"],
  linkopts = ["-lpthread"],
)
    """,
    )
