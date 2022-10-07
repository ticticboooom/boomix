. install/sys-vars.bash
cd $LFS
# 3.1 Init sources directory
mkdir -v $LFS/sources
chmod -v a+wt $LFS/sources

# 3.1 - Download source tarballs
wget https://www.linuxfromscratch.org/lfs/view/11.2-systemd/wget-list-systemd

echo 'Starting download of source tarballs - this may take some time'
wget --input-file=wget-list-systemd --continue --directory-prefix=$LFS/sources

# 4.2 - Create limited directory structure
mkdir -pv $LFS/{etc,var} $LFS/usr/{bin,lib,sbin}

for i in bin lib sbin; do
  ln -sv usr/$i $LFS/$i
done

case $(uname -m) in
  x86_64) mkdir -pv $LFS/lib64 ;;
esac

mkdir -pv $LFS/tools

# 4.3 LFS user ownership
chown -v lfs $LFS/{usr{,/*},lib,var,etc,bin,sbin,tools}
case $(uname -m) in
  x86_64) chown -v lfs $LFS/lib64 ;;
esac

su - lfs

# 4.4 LFS user env setup
cat > ~/.bash_profile << "EOF"
exec env -i HOME=$HOME TERM=$TERM PS1='\u:\w\$ ' /bin/bash
EOF

cat > ~/.bashrc << "EOF"
set +h
umask 022
LFS=/mnt/lfs
LC_ALL=POSIX
LFS_TGT=$(uname -m)-lfs-linux-gnu
PATH=/usr/bin
if [ ! -L /bin ]; then PATH=/bin:$PATH; fi
PATH=$LFS/tools/bin:$PATH
CONFIG_SITE=$LFS/usr/share/config.site
export LFS LC_ALL LFS_TGT PATH CONFIG_SITE
EOF

source ~/.bash_profile

# 5 cross compile toolchain
cd $LFS/sources

0_CROSS=install/stages/0-cross/
# 5.2 binutils pass 1
. $0_CROSS/001-compile-binutils.bash
# 5.3 GCC pass 1
. $0_CROSS/002-compile-gcc.bash
# 5.4 linux kernel headers
. $0_CROSS/003-compile-linux-headers.bash
# 5.5 glibc
. $0_CROSS/004-compile-glibc.bash
# 5.6 libstdc++
. $0_CROSS/compile-libstdcxx.bash
# 6 cross compile temp tools

su - lfs
1_CROSS=install/stages/1-cross/

# 6.2 m4
. $1_CROSS/001-compile-m4.bash

#6.3 ncurses
. $1_CROSS/002-compile-ncurses.bash
