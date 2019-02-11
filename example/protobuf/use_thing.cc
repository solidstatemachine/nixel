#include <iostream>

#include "example/protobuf/thing.pb.h"

int main(int argc, char** argv) {
  example::Thing thing;
  thing.set_name("kitten");
  thing.set_use("for petting");

  std::cout << thing.DebugString();
}
