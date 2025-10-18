#!/bin/sh

# Export paths to specific compiler and linker versions
export CC=/usr/local/bin/gcc
export LD=/usr/local/bin/gcc

# Exports for other tools
export PREFIX="/usr/local/i386elfgcc"
export TARGET=i386-elf
export PATH="$PREFIX/bin:$PATH"