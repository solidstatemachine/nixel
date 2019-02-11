# -*- python -*-

workspace(name = "nixel")

# Protocol buffer build rules.
load("//:deps.bzl", "build_stack_rules_proto")

build_stack_rules_proto()

load("@build_stack_rules_proto//cpp:deps.bzl", "cpp_proto_library")

cpp_proto_library()

# gRPC build rules.
load("//:deps.bzl", "com_github_grpc_grpc")

com_github_grpc_grpc()

load("@com_github_grpc_grpc//bazel:grpc_deps.bzl", "grpc_deps")

grpc_deps()

# haskell-lang rules, used by io_tweag_clodl.
load("//:deps.bzl", "io_tweag_rules_haskell")

io_tweag_rules_haskell()

load("@io_tweag_rules_haskell//haskell:repositories.bzl", "haskell_repositories")

haskell_repositories()

# Clodl - Turns dynamically linked ELF binaries and libraries into self-
# contained statically-linked closures.
load("//:deps.bzl", "io_tweag_clodl")

io_tweag_clodl()

# Nix package management integration.
load("//:deps.bzl", "io_tweag_rules_nixpkgs", "nixpkgs_version")

io_tweag_rules_nixpkgs()

load(
    "@io_tweag_rules_nixpkgs//nixpkgs:nixpkgs.bzl",
    "nixpkgs_cc_configure",
    "nixpkgs_git_repository",
    "nixpkgs_package",
)

nixpkgs_version(nixpkgs_git_repository)

nixpkgs_cc_configure(repository = "@nixpkgs")

# Third-party package dependencies.
load("//:deps.bzl", "com_google_absl")

com_google_absl()

load("//nix:boost.bzl", "nix_boost")

nix_boost()

load("//nix:gbenchmark.bzl", "nix_gbenchmark")

nix_gbenchmark()

load("//nix:gflags.bzl", "nix_gflags")

nix_gflags()

load("//nix:glog.bzl", "nix_glog")

nix_glog()

load("//nix:gmock.bzl", "nix_gmock")

nix_gmock()

load("//nix:zlib.bzl", "nix_zlib")

nix_zlib()
