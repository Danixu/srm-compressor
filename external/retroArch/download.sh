#!/bin/bash

echo "Downloading required files..."
mkdir -p "source"
wget "https://github.com/libretro/RetroArch/raw/master/libretro-common/streams/rzip_stream.c" -O "source/rzip_stream.c"
wget "https://github.com/libretro/RetroArch/raw/master/libretro-common/streams/file_stream.c" -O "source/file_stream.c"
wget "https://github.com/libretro/RetroArch/raw/master/libretro-common/vfs/vfs_implementation.c" -O "source/vfs_implementation.c"
wget "https://github.com/libretro/RetroArch/raw/master/libretro-common/file/file_path.c" -O "source/file_path.c"
wget "https://github.com/libretro/RetroArch/raw/master/libretro-common/string/stdstring.c" -O "source/stdstring.c"
wget "https://github.com/libretro/RetroArch/raw/master/libretro-common/file/file_path_io.c" -O "source/file_path_io.c"
wget "https://github.com/libretro/RetroArch/raw/master/libretro-common/compat/compat_strl.c" -O "source/compat_strl.c"
wget "https://github.com/libretro/RetroArch/raw/master/libretro-common/streams/trans_stream.c" -O "source/trans_stream.c"
wget "https://github.com/libretro/RetroArch/raw/master/libretro-common/time/rtime.c" -O "source/rtime.c"
wget "https://github.com/libretro/RetroArch/raw/master/libretro-common/string/stdstring.c" -O "source/stdstring.c"
wget "https://github.com/libretro/RetroArch/raw/master/libretro-common/encodings/encoding_utf.c" -O "source/encoding_utf.c"
wget "https://github.com/libretro/RetroArch/raw/master/libretro-common/streams/trans_stream.c" -O "source/trans_stream.c"

mkdir -p "include/"
wget "https://github.com/libretro/RetroArch/raw/master/libretro-common/include/libretro.h" -O "include/libretro.h"
wget "https://github.com/libretro/RetroArch/raw/master/libretro-common/include/boolean.h" -O "include/boolean.h"
wget "https://github.com/libretro/RetroArch/raw/master/libretro-common/include/retro_common_api.h" -O "include/retro_common_api.h"
wget "https://github.com/libretro/RetroArch/raw/master/libretro-common/include/retro_inline.h" -O "include/retro_inline.h"
wget "https://github.com/libretro/RetroArch/raw/master/libretro-common/include/retro_environment.h" -O "include/retro_environment.h"
wget "https://github.com/libretro/RetroArch/raw/master/libretro-common/include/retro_miscellaneous.h" -O "include/retro_miscellaneous.h"
wget "https://github.com/libretro/RetroArch/raw/master/libretro-common/include/retro_assert.h" -O "include/retro_assert.h"

mkdir -p "include/string"
wget "https://github.com/libretro/RetroArch/raw/master/libretro-common/include/string/stdstring.h" -O "include/string/stdstring.h"

mkdir -p "include/compat"
wget "https://github.com/libretro/RetroArch/raw/master/libretro-common/include/compat/strl.h" -O "include/compat/strl.h"
wget "https://github.com/libretro/RetroArch/raw/master/libretro-common/include/compat/posix_string.h" -O "include/compat/posix_string.h"
wget "https://github.com/libretro/RetroArch/raw/master/libretro-common/include/compat/strcasestr.h" -O "include/compat/strcasestr.h"
wget "https://github.com/libretro/RetroArch/raw/master/libretro-common/include/compat/fopen_utf8.h" -O "include/compat/fopen_utf8.h"

mkdir -p "include/encodings"
wget "https://github.com/libretro/RetroArch/raw/master/libretro-common/include/encodings/utf.h" -O "include/encodings/utf.h"

mkdir -p "include/file"
wget "https://github.com/libretro/RetroArch/raw/master/libretro-common/include/file/file_path.h" -O "include/file/file_path.h"

mkdir -p "include/streams"
wget "https://github.com/libretro/RetroArch/raw/master/libretro-common/include/streams/file_stream.h" -O "include/streams/file_stream.h"
wget "https://github.com/libretro/RetroArch/raw/master/libretro-common/include/streams/trans_stream.h" -O "include/streams/trans_stream.h"
wget "https://github.com/libretro/RetroArch/raw/master/libretro-common/include/streams/rzip_stream.h" -O "include/streams/rzip_stream.h"

mkdir -p "include/time"
wget "https://github.com/libretro/RetroArch/raw/master/libretro-common/include/time/rtime.h" -O "include/time/rtime.h"

mkdir -p "include/vfs"
wget "https://github.com/libretro/RetroArch/raw/master/libretro-common/include/vfs/vfs_implementation.h" -O "include/vfs/vfs_implementation.h"
wget "https://github.com/libretro/RetroArch/raw/master/libretro-common/include/vfs/vfs.h" -O "include/vfs/vfs.h"

echo "Download finished."

echo "Compiling..."


gcc -c -o compat_strl.o source/compat_strl.c -I include/
gcc -c -o encoding_utf.o source/encoding_utf.c -I include/
gcc -c -o file_path.o source/file_path.c -I include/
gcc -c -o file_path_io.o source/file_path_io.c -I include/
gcc -c -o file_stream.o source/file_stream.c -I include/
gcc -c -o rtime.o source/rtime.c -I include/
gcc -c -o stdstring.o source/stdstring.c -I include/
gcc -c -o trans_stream.o source/trans_stream.c -I include/
gcc -c -o vfs_implementation.o source/vfs_implementation.c -I include/
gcc -c -o rzip_stream.o source/rzip_stream.c -I include/

#gcc -fPIC -o rzip_stream.o source/rzip_stream.c compat_strl.o encoding_utf.o file_path.o file_path_io.o file_stream.o rtime.o stdstring.o vfs_implementation.o trans_stream.o -I include/
ar rc lib.a rzip_stream.o compat_strl.o encoding_utf.o file_path.o file_path_io.o file_stream.o rtime.o stdstring.o vfs_implementation.o trans_stream.o