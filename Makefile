# the extensions name
EXTENSION     = lidan
DATA          = $(wildcard *--*.sql) 						# script files to install
TESTS         = $(wildcard test/sql/*.sql)      # use test/sql/*.sql as testfiles

# find the sql and expected directories under test
# load plpgsql into test db
# load lidan extension into test db
# dbname
REGRESS_OPTS  = --inputdir=test         \
                --load-extension=lidan \
                --load-language=plpgsql
REGRESS       = $(patsubst test/sql/%.sql,%,$(TESTS))
OBJS 					= $(patsubst %.c,%.o,$(wildcard src/*.c)) # object files
# final shared library to be build from multiple source files (OBJS)
MODULE_big    = $(EXTENSION)
#HEADERS = "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.13.sdk"
#isysroot = "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.13.sdk"
# postgres build stuff
PG_CONFIG = /usr/local/Cellar/postgresql/11.2/bin/pg_config
PGXS := $(shell $(PG_CONFIG) --pgxs)

include $(PGXS)

