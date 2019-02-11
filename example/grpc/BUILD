# -*- python -*-

load(
    "@com_github_grpc_grpc//bazel:cc_grpc_library.bzl",
    "cc_grpc_library",
)
load(
    "@com_github_grpc_grpc//bazel:grpc_build_system.bzl",
    "grpc_proto_library",
)

grpc_proto_library(
    name = "echo_service_proto",
    srcs = ["echo_service.proto"],
)

cc_binary(
    name = "client",
    srcs = ["client.cc"],
    deps = [
        ":echo_service_proto",
        "@com_github_grpc_grpc//:grpc++",
    ],
)

cc_binary(
    name = "server",
    srcs = ["server.cc"],
    deps = [
        ":echo_service_proto",
        "@com_github_grpc_grpc//:grpc++",
    ],
)
