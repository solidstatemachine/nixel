# nixel

A workspace template that combines the Bazel build system with the Nix package management system.

## bazel

[`bazel`](https://bazel.build/) is the build system used to generate libraries, tests, and executables in a hermetic and reproducible manner. Build targets are defined in `BUILD` files, which you'll find in each directory. They produce a hierarchy of targets that take the form of `//dir/dir:target`. Related scripts, cofiguration, etc. are located in the `//build` directory, and outputs can be found in the `//bazel-bin` and `//bazel-genfiles` directories.

The `WORKSPACE` file in the root directory defines the top of the target bierarchy, and also ties bazel to all third party packages.

## nix

[`nix`](https://nixos.org/nix/) is used for package management of common dependencies. It allows for hermetic/reproducable builds is a number of ways:

* It manages third party code handling source code, dependencies, and other package management tasks.
* It is version-controlled, so dependencies can easily be rolled forward or backwards.
* It manages the build tools themselves. (compiler, etc.) As a result, there are zero local platform dependencies and builds are 100% reproducible, as the same version of every compilation tool is version-controlled. You can be sure that two machines will compile bit-exact targets. 
* It can reference multiple versions of a single dependency, not just in `lib` but in `include` as well. This fine-grained dependency management can be used to, among other things, test an alpha-stage library, benchmark performance between library versions, or swap out compatible libraries such as `boringssl` for `openssl`.
* It enables you to modifying packages, patching changes into them, and change compilation options.
* It can also manage packages not already defined by NixOS.

Related scripts, configuration, etc. are located in the `//nix` directory.

`//nix:glog.bzl` has an example for how to write your own nix build script.

### nix: Quick Install

You can quickly install nix and begin using it by running the following command. Proper installation instructions are at [nixos.org/nix/manual](https://nixos.org/nix/manual/#chap-quick-start). 

    bash <(curl https://nixos.org/nix/install)

## clodl

[`clodl`](https://github.com/tweag/clodl) is a tool that produces a single, self-contained file packing all dependencies of a dynamically linked executable. The authors describe it as a poor man's container image so you can deploy to foreign machines without concerns about missing dependencies.

Use `binary_closure()` in your BUILD files. Beware of the security problems when distributing binaries that include their own dependencies, as common libraries that your operating system would normally keep up-to-date quickly become stale.

NOTE: You may have success getting a distributable binary out of the nix cross-compiler by changing the ELF interpreter: `patchelf --set-interpreter /lib64/ld-linux-x86-64.so.2 a.out`

    $ bazel build //example/zlib:example-bin
    ./bazel-genfiles/example/zlib/example-bin.sh

## Examples

### gbenchmark

    $ bazel run //example/gbenchmark
    --------------------------------------------------------------
    Benchmark                       Time           CPU Iterations
    --------------------------------------------------------------
    measure_thing/10                5 ns          5 ns  108936708
    measure_thing/100               6 ns          6 ns  107037148
    measure_thing/1000             18 ns         18 ns   38979044
    measure_thing/10000           106 ns        106 ns    6388275
    measure_thing/100000         2849 ns       2848 ns     248813
    measure_thing/1000000       36278 ns      36259 ns      19373
    measure_thing/10000000     704493 ns     704410 ns       1020
    measure_thing_BigO           0.07 N       0.07 N 
    measure_thing_RMS              12 %         12 % 

### glog

    $ bazel run //example/glog -- --logtostderr
    I0102 03:04:05.678901 183429 glog.cc:11] This is an INFO
    W0102 03:04:05.678901 183429 glog.cc:12] This is a WARNING
    E0102 03:04:05.678901 183429 glog.cc:13] This is an ERROR
    F0102 03:04:05.678901 183429 glog.cc:14] This is a FATAL

### gmock, gtest

    $ bazel test //example/gmock/...
    //example/gmock:gmock                     PASSED in 0.1s

### gRPC
    
    $ bazel build //example/grpc/...
    
    $ ./bazel-bin/example/grpc/client
    rpc failed: 14 Connect Failed
    
    $ ./bazel-bin/example/grpc/server &
    Server listening on 0.0.0.0:50051
    
    $ ./bazel-bin/example/grpc/client
    Request: message: "hello"
    Response: message: "hello to you as well"
    
    $ kill %1  # Stop the server

### protobuf

    $ bazel run //example/protobuf:use_thing
    name: "kitten"
    use: "for petting"

    $ bazel run //example/protobuf:use_reflection
    name: "my_name"

### zlib

    $ bazel run //example/zlib:example
    Initializing zlib
    Compressing "Hello from 1.2.11 012345678901234567890123456789012345678901234567890" which is 69 bytes.
    Compressed to 38 bytes.
    Uncompressing...
    Uncompressed to 69 bytes as "Hello from 1.2.11 012345678901234567890123456789012345678901234567890"
