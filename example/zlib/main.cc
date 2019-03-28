#include <iostream>
#include <sstream>
#include <stdio.h>
#include <string.h>
#include <zlib.h>

#define COMPRESSION_LEVEL 9

void exit_if_zerr(int ret) {
  if (ret == Z_OK) return;

  fputs("zerr: ", stderr);
  switch (ret) {
    case Z_STREAM_ERROR:
      fputs("invalid compression level\n", stderr);
      exit(ret);
    case Z_DATA_ERROR:
      fputs("invalid or incomplete deflate data\n", stderr);
      exit(ret);
    case Z_MEM_ERROR:
      fputs("out of memory\n", stderr);
      exit(ret);
    case Z_VERSION_ERROR:
      fputs("zlib version mismatch!\n", stderr);
      exit(ret);
    default:
      fputs("unknown zlib error!\n", stderr);
      exit(ret);
  }
}

int main() {
  std::cout << "Initializing zlib\n";
  z_stream strm;
  strm.zalloc = Z_NULL;
  strm.zfree = Z_NULL;
  strm.opaque = Z_NULL;
  exit_if_zerr(deflateInit(&strm, COMPRESSION_LEVEL));

  std::stringstream ss;
  ss << "Hello from " << zlibVersion()
     << " 012345678901234567890123456789012345678901234567890";
  const auto& input = ss.str();

  std::cout << "Compressing \"" << input << "\" which is "
            << input.size() << " bytes.\n";
  strm.avail_in = input.size();
  strm.next_in = (Bytef*) input.data();

  std::string zip(1 << 10, '\0');
  strm.avail_out = zip.size();
  strm.next_out = (Bytef*) zip.data();
  exit_if_zerr(deflate(&strm, Z_SYNC_FLUSH));
  zip.resize(zip.size() - strm.avail_out);
  (void) deflateEnd(&strm);
  std::cout << "Compressed to " << zip.size() << " bytes.\n";

  std::cout << "Uncompressing...\n";
  strm.zalloc = Z_NULL;
  strm.zfree = Z_NULL;
  strm.opaque = Z_NULL;
  strm.avail_in = 0;
  strm.next_in = Z_NULL;
  exit_if_zerr(inflateInit(&strm));

  std::string unzip(1 << 10, '\0');
  strm.avail_in = zip.size();
  strm.next_in = (Bytef*) zip.data();
  strm.avail_out = unzip.size();
  strm.next_out = (Bytef*) unzip.data();
  exit_if_zerr(inflate(&strm, Z_NO_FLUSH));
  unzip.resize(unzip.size() - strm.avail_out);
  (void) inflateEnd(&strm);

  std::cout << "Uncompressed to " << unzip.size()
            << " bytes as \"" << unzip << "\"\n";
}
