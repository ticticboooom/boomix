echo 'Building binutils - First Pass'
. lib/clean-extract.bash binutils-2.39

mkdir build
cd build

../configure --prefix=$LFS/tools \
             --with-sysroot=$LFS \
             --target=$LFS_TGT   \
             --disable-nls       \
             --enable-gprofng=no \
             --disable-werror

make -j12

make install

