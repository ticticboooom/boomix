echo 'Building Ncurses'
. lib/clean-extract.bash ncurses-6.3

sed -i s/mawk// configure
mkdir build
pushd build
 ../configure
 make -C include
 make -C progs tic
popd

./configure --prefix=/usr \
 --host=$LFS_TGT \
 --build=$(./config.guess) \
 --mandir=/usr/share/man \
 --with-manpage-format=normal \
 --with-shared \
 --without-normal \
 --with-cxx-shared \
 --without-debug \
 --without-ada \
 --disable-stripping \
 --enable-widec

make -j12 

make DESTDIR=$LFS TIC_PATH=$(pwd)/build/progs/tic install
echo "INPUT(-lncursesw)" > $LFS/usr/lib/libncurses.so
