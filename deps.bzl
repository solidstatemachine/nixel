# -*- python -*-

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

def github_archive(name, org, repo, ref, sha256):
    """Declare an http_archive from github
    """
    if name not in native.existing_rules():
        http_archive(
            name = name,
            strip_prefix = repo + "-" + ref,
            urls = ["https://github.com/%s/%s/archive/%s.tar.gz" % (org, repo, ref)],
            sha256 = sha256,
        )

# https://github.com/stackb/rules_proto/tree/master
def build_stack_rules_proto():
    github_archive(
        "build_stack_rules_proto",
        "stackb",
        "rules_proto",
        ref = "78df709a394f395b1ddeb393dc63e1ca9b0b9288",
        sha256 = "4c5c12003d97b1d43b6223cabe7936b031ba3397f066a897e4b0c86e407e2a36",
    )

# https://github.com/grpc/grpc/tree/master
def com_github_grpc_grpc():
    github_archive(
        "com_github_grpc_grpc",
        "grpc",
        "grpc",
        ref = "8ba5922e8767e4c10ca38cb46b19d5878c310598",
        sha256 = "0ed3555fc405d6e7ad1aafec6d19db86343d4683583e4f48786d4ff28ca738ab",
    )

# https://github.com/tweag/rules_haskell/tree/master
def io_tweag_rules_haskell():
    github_archive(
        "io_tweag_rules_haskell",
        "tweag",
        "rules_haskell",
        ref = "e5a1e2a9dd3834d182574dbb0b5a854e0d82b008",
        sha256 = "167400114a4783fadb8046a1a0c3bc6c3efa03c5ffa4df3b725bff875ffbc250",
    )

# https://github.com/tweag/clodl/tree/master
def io_tweag_clodl():
    github_archive(
        "io_tweag_clodl",
        "tweag",
        "clodl",
        ref = "e8ec41730f885d4869b19bb5b171b480fcf32816",
        sha256 = "e6a13e5c1200337f369da6a37835ba051962550cc12477a5a104a86a60345b27",
    )

# https://github.com/tweag/rules_nixpkgs/tree/master
def io_tweag_rules_nixpkgs():
    github_archive(
        "io_tweag_rules_nixpkgs",
        "tweag",
        "rules_nixpkgs",
        ref = "674766086cda88976394fbd608620740857e2535",
        sha256 = "fe9a2b6b92df33dd159d22f9f3abc5cea2543b5da66edbbee128245c75504e41",
    )

# https://github.com/NixOS/nixpkgs/tree/release-18.09
def nixpkgs_version(nixpkgs_git_repository):
    nixpkgs_git_repository(
        name = "nixpkgs",
        remote = "https://github.com/NixOS/nixpkgs",
        revision = "cadb6ca5f663255ef41050ed0997c1a980415bc6",
        sha256 = "94d1a9ff87e6e25a1a7a19db54fc22adef660a44c65d6c8f9d0321e256c093f8",
    )

# https://github.com/abseil/abseil-cpp/tree/master
def com_google_absl():
    github_archive(
        "com_google_absl",
        "abseil",
        "abseil-cpp",
        ref = "7ffbe09f3d85504bd018783bbe1e2c12992fe47c",
        sha256 = "ffr3prqi0knmdd24nda7cz9hc83dzdhd23w46q2pwkkn0vqapzhp",
    )
