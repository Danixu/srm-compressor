CC=gcc
CFLAGS=-fPIC -DHAVE_ZLIB

AR=ar
ARFLAGS=rc

WGET=wget

INCLUDE_FOLDERS = include/string include/compat include/encodings include/file include/streams include/time include/vfs 
INCLUDE_ROOT = include/libretro.h include/boolean.h include/retro_common_api.h include/retro_inline.h include/retro_environment.h include/retro_miscellaneous.h include/retro_assert.h
INCLUDE_STRING = include/string/stdstring.h
INCLUDE_COMPAT = include/compat/strl.h include/compat/posix_string.h include/compat/strcasestr.h include/compat/fopen_utf8.h
INCLUDE_ENCODINGS = include/encodings/utf.h
INCLUDE_FILE = include/file/file_path.h
INCLUDE_STREAMS = include/streams/file_stream.h include/streams/trans_stream.h include/streams/rzip_stream.h
INCLUDE_TIME = include/time/rtime.h
INCLUDE_VFS = include/vfs/vfs_implementation.h include/vfs/vfs.h

OBJECTS_FOLDERS = source/vfs source/file source/compat source/time source/string source/encodings source/streams
OBJECTS_SRC = source/streams/rzip_stream.c source/streams/file_stream.c source/vfs/vfs_implementation.c source/file/file_path.c source/file/file_path_io.c source/compat/compat_strl.c source/time/rtime.c source/string/stdstring.c source/encodings/encoding_utf.c source/streams/trans_stream.c source/streams/trans_stream_pipe.c source/streams/trans_stream_zlib.c
OBJECTS = source/streams/rzip_stream.o source/streams/file_stream.o source/vfs/vfs_implementation.o source/file/file_path.o source/file/file_path_io.o source/compat/compat_strl.o source/time/rtime.o source/string/stdstring.o source/encodings/encoding_utf.o source/streams/trans_stream.o source/streams/trans_stream_pipe.o source/streams/trans_stream_zlib.o

LIBRARY = libsrm.a

all: $(LIBRARY)

$(INCLUDE_FOLDERS) $(OBJECTS_FOLDERS):
	mkdir -p $@

$(INCLUDE_ROOT) $(INCLUDE_STRING) $(INCLUDE_COMPAT) $(INCLUDE_ENCODINGS) $(INCLUDE_FILE) $(INCLUDE_STREAMS) $(INCLUDE_TIME) $(INCLUDE_VFS) : $(INCLUDE_FOLDERS)
	$(WGET) "https://github.com/libretro/RetroArch/raw/master/libretro-common/$@" -O "$@"

$(OBJECTS_SRC):
	$(WGET) "https://github.com/libretro/RetroArch/raw/master/libretro-common/$(subst source/,,$@)" -O "$@"

$(OBJECTS) : $(OBJECTS_SRC) $(INCLUDE_ROOT) $(INCLUDE_STRING) $(INCLUDE_COMPAT) $(INCLUDE_ENCODINGS) $(INCLUDE_FILE) $(INCLUDE_STREAMS) $(INCLUDE_TIME) $(INCLUDE_VFS) $(OBJECTS_FOLDERS)
	$(CC) $(CFLAGS) -c -o $@ $(subst .o,.c,$@) -I include/

$(LIBRARY) : $(OBJECTS)
	$(AR) $(ARFLAGS) $@ $?


clean:
	rm -f $(OBJECTS) $(LIBRARY)

clean_full : clean
	rm -Rf include source