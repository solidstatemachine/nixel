# -*- python -*-

load("@io_tweag_clodl//clodl:clodl.bzl", "binary_closure")

cc_binary(
    name = "example",
    srcs = ["main.cc"],
    linkstatic = 1,
    deps = ["@nix-zlib"],
)

cc_binary(
    name = "libexample.so",
    srcs = ["main.cc"],
    linkshared = 1,
    linkstatic = 0,
    deps = ["@nix-zlib"],
)

binary_closure(
    name = "example-bin",
    src = "libexample.so",
)
