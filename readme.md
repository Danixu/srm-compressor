# SRM Compressor & Decompressor

This is a simple program that will allow you to decompress and recompress the SRM files created by some emulators systems like RetroArch, used in Recalbox, Retropie... This will allow you to edit savegames like PSX memory cards, usefull for programs like Black Chocobo, Hyne and similar.

## How to use it

The command line to use this program is the following:

    ./srm-compressor <input-file> <output-file>

The program will detect if the file is compressed and must be decompressed, or otherwise is a decompressed file that must be compressed.

    Decompress a srm file
        ./srm-compressor ffvii.srm ffvii.mcr

    Compress a memory card file
        ./srm-compressor ffvii.mcr

This program was tested only with PSX memory cards, but must work with other saves types, and also with compressed savestates and similar.

## Compile from source

To compile from source you will need to clone this repository:

```
git clone https://github.com/Danixu/srm-compressor.git
```

Initialize the submodules:

```
git submodule init
```

Compile the srm-compressor program (only linux version for now):

```
make -f Makefile.linux -j$(nproc)
```

To clean all the folders just run:

```
make clean_full
```