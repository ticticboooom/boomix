
echo 'Building linux kernel headers'

. lib/clean-extract.bash linux-5.19.2

make mrproper

make headers
find usr/include -type f ! -name '*.h' -delete
cp -rv usr/include $LFS/usr
