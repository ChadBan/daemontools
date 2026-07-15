#!/bin/bash
CUR=`dirname "$BASH_SOURCE"`
abs_path=`cd "$CUR"; pwd`
cd $abs_path

#EXECUTOR=`whoami`
#if [ ! "$EXECUTOR"x = "root"x ]; then
#    echo please execute this script with sudo or root
#    exit 1
#fi
#
SRC="daemontools-0.76"
SRCDIR="admin/daemontools-0.76"

if test ! -f ${SRC}.tar.gz; then  
    wget http://ksc.vloud.release.kss-internal.ksyun.com/compile_dependencies/${SRC}.tar.gz
    if test $? -ne 0; then
        echo "download ${SRC}.tar.gz FAIL!"
        exit 10
    fi
fi

if test ! -d $SRCDIR; then
    tar -xzf ${SRC}.tar.gz
    if test $? -ne 0; then
        echo "unzip ${SRC}.tar.gz FAIL!"
        exit 11
    fi
fi

# 配置与编译
cp conf-cc $SRCDIR/src/conf-cc
cd $SRCDIR
./package/compile
if [ $? -ne 0 ]; then
  echo "package compile failed!"
  exit 1
fi
cd -

rm -rf output
mkdir -p output/bin/
cp -r $SRCDIR/command output/bin/



