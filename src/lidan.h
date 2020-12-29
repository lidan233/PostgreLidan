#ifndef lidan_H
#define lidan_H

#include "postgres.h"
#include "utils/builtins.h"
#include "utils/int8.h"
#include "libpq/pqformat.h"
#include <limits.h>

extern const char lidan_digits[36];

#define LIDANOUTOFRANGE_ERROR(_str, _typ)                      \
  do {                                                          \
    ereport(ERROR,                                              \
      (errcode(ERRCODE_NUMERIC_VALUE_OUT_OF_RANGE),             \
        errmsg("value \"%s\" is out of range for type %s",      \
          _str, _typ)));                                        \
  } while(0)                                                    \

#define LIDANSYNTAX_ERROR(_str, _typ)                          \
  do {                                                          \
    ereport(ERROR,                                              \
      (errcode(ERRCODE_SYNTAX_ERROR),                           \
      errmsg("invalid input syntax for %s: \"%s\"",             \
             _typ, _str)));                                     \
  } while(0)                                                    \


#endif // lidan_H
