#include <iostream>

#include <grpc/grpc.h>
#include <grpcpp/channel.h>
#include <grpcpp/client_context.h>
#include <grpcpp/create_channel.h>
#include <grpcpp/security/credentials.h>

#include "example/grpc/echo_service.grpc.pb.h"

int main(int argc, char** argv) {
  std::shared_ptr<grpc::Channel> channel(
      grpc::CreateChannel("localhost:50051",
                          grpc::InsecureChannelCredentials()));
  std::unique_ptr<example::Echo::Stub> stub(
      example::Echo::NewStub(channel));

  example::EchoRequest req;
  req.set_message("hello");
  std::cout << "Request: " << req.DebugString();

  grpc::ClientContext context;
  example::EchoResponse resp;
  grpc::Status status = stub->Echo(&context, req, &resp);
  if (!status.ok()) {
    std::cout << "rpc failed: " << status.error_code() << " " << status.error_message() << std::endl;
    return -1;
  }
  std::cout << "Response: " << resp.DebugString();
}
