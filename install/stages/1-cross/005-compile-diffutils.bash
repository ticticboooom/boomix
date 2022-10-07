. lib/clean-extract.bash diffutils-3.8

/configure --prefix=/usr --host=$LFS_TGT

make -j12

make DESTDIR=$LFS install
