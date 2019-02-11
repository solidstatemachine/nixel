#include <gflags/gflags.h>
#include <glog/logging.h>

int main(int argc, char** argv) {
  static const bool kRemoveFlags = true;
  google::ParseCommandLineFlags(&argc, &argv, kRemoveFlags);

  google::InitGoogleLogging(argv[0]);
  google::InstallFailureSignalHandler();

  LOG(INFO) << "This is an INFO";
  LOG(WARNING) << "This is a WARNING";
  LOG(ERROR) << "This is an ERROR";
  LOG(FATAL) << "This is a FATAL";
}
