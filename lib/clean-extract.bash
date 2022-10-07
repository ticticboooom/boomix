cd $LFS/sources/
DIR_NAME=$1
TAR_NAME=$DIR_NAME.tra.xz
if [[ -d ${DIR_NAME} ]]; then 
  rm -rfd ./$DIR_NAME
fi
tar -xf $TAR_NAME
cd $DIR_NAME

unset DIR_NAME TAR_NAME
