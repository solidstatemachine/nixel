# -*- python -*-

load(
    "@build_stack_rules_proto//cpp:cpp_proto_library.bzl",
    "cpp_proto_library",
)

proto_library(
    name = "thing_proto",
    srcs = ["thing.proto"],
    deps = ["@com_google_protobuf//:any_proto"],
)

cpp_proto_library(
    name = "thing_proto_cpp",
    deps = [":thing_proto"],
)

cc_binary(
    name = "use_thing",
    srcs = ["use_thing.cc"],
    deps = [":thing_proto_cpp"],
)

cc_binary(
    name = "use_reflection",
    srcs = ["use_reflection.cc"],
    deps = [":thing_proto_cpp"],
)
