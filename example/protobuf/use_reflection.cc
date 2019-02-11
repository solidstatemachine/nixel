#include <iostream>
#include <google/protobuf/reflection.h>

#include "example/protobuf/thing.pb.h"

int main(int argc, char** argv) {
  const auto* desc = example::Thing::descriptor();
  const auto* name = desc->FindFieldByName("name");

  example::Thing thing;
  const auto* reflection = thing.GetReflection();
  reflection->SetString(&thing, name, "my_name");
  std::cout << thing.DebugString();
}
