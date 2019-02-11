# -*- python -*-

load(
    "@io_tweag_rules_nixpkgs//nixpkgs:nixpkgs.bzl",
    "nixpkgs_package",
)

def nix_glog():
    nixpkgs_package(
        name = "nix-glog",
        repositories = {"nixpkgs": "@nixpkgs"},
        build_file_content = """
package(default_visibility = ["//visibility:public"])
cc_library(
  name = "nix-glog",
  hdrs = glob(["include/**/*.h"]),
  srcs = glob(["lib/**/*.so*", "lib/**/*.dylib", "lib/**/*.a"]),
  deps = ["@nix-gflags"],
  includes = ["include/"],
)
    """,
        nix_file_content = """
let pkgs = import <nixpkgs> {};

# Same as the upstream nixpkgs except that there is an additional dependency on gflags.
in pkgs.stdenv.mkDerivation rec {
  name = "glog-${version}";
  version = "0.3.5";

  src = pkgs.fetchFromGitHub {
    owner = "google";
    repo = "glog";
    rev = "v${version}";
    sha256 = "12v7j6xy0ghya6a0f6ciy4fnbdc486vml2g07j9zm8y5xc6vx3pq";
  };

  nativeBuildInputs = [ pkgs.autoreconfHook pkgs.gflags];

  checkInputs = [ pkgs.perl ];
  doCheck = false; # fails with "Mangled symbols (28 out of 380) found in demangle.dm"

  meta = with pkgs.stdenv.lib; {
    homepage = https://github.com/google/glog;
    license = licenses.bsd3;
    description = "Library for application-level logging";
    platforms = platforms.unix;
  };
}
    """,
    )
