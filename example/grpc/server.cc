#include <iostream>
#include <memory>
#include <string>

#include <grpcpp/grpcpp.h>

#include "example/grpc/echo_service.grpc.pb.h"

class EchoServiceImpl final : public example::Echo::Service {
  grpc::Status Echo(grpc::ServerContext* context,
                    const example::EchoRequest* req,
                    example::EchoResponse* resp) override {
    resp->set_message(req->message() + " to you as well");
    return grpc::Status::OK;
  }
};

int main(int argc, char** argv) {
  EchoServiceImpl service;

  grpc::ServerBuilder builder;
  std::string server_address("0.0.0.0:50051");
  builder.AddListeningPort(server_address,
                           grpc::InsecureServerCredentials());
  builder.RegisterService(&service);

  std::unique_ptr<grpc::Server> server(builder.BuildAndStart());
  std::cout << "Server listening on " << server_address << std::endl;

  server->Wait();
}
