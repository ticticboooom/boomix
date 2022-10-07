echo 'Building M4'
. lib/clean-extract.bash m4-1.4.19

./configure --prefix=/usr \
 --host=$LFS_TGT \
 --build=$(build-aux/config.guess)

make -j12

make DESTDIR=$LFS install
