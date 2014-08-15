// Copyright (c) 2014, Emmanuel Goossaert. All rights reserved.
// Use of this source code is governed by the BSD 3-Clause License,
// that can be found in the LICENSE file.

#ifndef KINGDB_HASH_H_
#define KINGDB_HASH_H_

#include <string>

#include "logger.h"
#include "options.h"
#include "murmurhash3.h"
#include "xxhash.h"

namespace kdb {

class Hash {
 public:
  Hash() {}
  virtual ~Hash() {}
  virtual uint64_t HashFunction(const char *data, uint32_t len) = 0;
};

class MurmurHash3: public Hash {
 public:
  MurmurHash3() {}
  virtual ~MurmurHash3() {}
  virtual uint64_t HashFunction(const char *data, uint32_t len);
};

class xxHash: public Hash {
 public:
  xxHash() {}
  virtual ~xxHash() {}
  virtual uint64_t HashFunction(const char *data, uint32_t len);
 private:
};

Hash* MakeHash(HashType ht);

}

#endif // KINGDB_HASH_H_