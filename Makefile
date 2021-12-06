CPP=g++
CPPFLAGS=

ZLIB_MAKEFILE=Makefile.linux

srm-compressor: srm-compressor.cpp external/retroArch/libsrm.a external/zlib/libzlinux.a
	$(CPP) $(CPPFLAGS) -o $@ $? -I external/retroArch/include/

external/zlib/libzlinux.a:
	cd external/zlib && make -f ../../data/makefile_zlib/Makefile.linux -j$(nproc)

external/retroArch/libsrm.a:
	cd external/retroArch && make -f Makefile.linux -j$(nproc)

clean:
	rm srm-compressor

clean_full: clean
	cd external/zlib && make -f ../../data/makefile_zlib/Makefile.linux clean
	cd external/retroArch && make -f Makefile.linux clean
