echo 'Building Bash'
. lib/clean-extract.bash bash-5.1.16

./configure --prefix=/usr \
 --build=$(support/config.guess) \
 --host=$LFS_TGT \
 --without-bash-malloc

make -j12

make DESTDIR=$LFS install

ln -sv bash $LFS/bin/sh
