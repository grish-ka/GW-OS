# This script sets up the hand compile tools
#!/bin/sh

# Change these paths if your tools are installed elsewhere
echo "Setting up environment for binutils and gcc installation..."
# Export paths to specific compiler and linker versions
export CC=/usr/local/bin/gcc
export LD=/usr/local/bin/gcc

# Exports for other things
export PREFIX="/usr/local/i386elfgcc"
export TARGET=i386-elf
export PATH="$PREFIX/bin:$PATH"

# Install
echo "Installing binutils and gcc for target $TARGET to prefix: $PREFIX"

echo "Installing binutils..."
# Install binutils
mkdir /tmp/src
cd /tmp/src
curl -O http://ftp.gnu.org/gnu/binutils/binutils-2.24.tar.gz # If the link 404's, look for a more recent version
tar xf binutils-2.24.tar.gz
mkdir binutils-build
cd binutils-build
../binutils-2.24/configure --target=$TARGET --enable-interwork --enable-multilib --disable-nls --disable-werror --prefix=$PREFIX 2>&1 | tee configure.log
sudo make all install 2>&1 | tee make.log
echo "Install of binutils complete."

echo "Installing gcc..."
# Install gcc
cd /tmp/src
curl -O https://ftp.gnu.org/gnu/gcc/gcc-4.9.1/gcc-4.9.1.tar.bz2
tar xf gcc-4.9.1.tar.bz2
mkdir gcc-build
cd gcc-build
../gcc-4.9.1/configure --target=$TARGET --prefix="$PREFIX" --disable-nls --disable-libssp --enable-languages=c --without-headers
make all-gcc 
make all-target-libgcc 
make install-gcc 
make install-target-libgcc 
echo "Install of gcc complete."

echo "Installation complete!"