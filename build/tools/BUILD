# -*- python -*-

load(":concat.bzl", "concat")
load(":debug.bzl", "debug")
load(":size.bzl", "size")

# This target is used by concat.bzl.
sh_binary(
    name = "concat",
    srcs = ["concat.sh"],
)

# Demo
concat(
    name = "page_html",
    out = "page.html",
    chunks = [
        "testfiles/header.html",
        "testfiles/body.html",
        "testfiles/footer.html",
    ],
)

debug(name = "other")

debug(
    name = "some_target",
    deps = [
        "BUILD",
        ":other",
    ],
)

size(
    name = "BUILD_size",
    file = ":BUILD",
)
