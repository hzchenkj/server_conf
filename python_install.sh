#!/bin/bash

## Shell Opts ----------------------------------------------------------------
set -exuo pipefail
IFS=$'\n\t'


## Vars -----------------------------
VERSION=3.7
GITDIR=/root/github/python$VERSION


## Main ----------------------------------------------------------------------
# Check the version of current Python3
if [[ -n `python3 --version | grep -P "Python $VERSION"` ]]
then
echo "Python=$VERSION already satisfied"
    exit 0
fi


# Install -------------------------------------------------------------
yum groupinstall -y "Development tools"
yum install -y ncurses-devel ncurses-libs zlib-devel mysql-devel bzip2-devel \
               openssl-devel readline-devel tk-devel gdbm-devel\
               db4-devel libpcap-devel xz-devel openssl-devel sqlite-devel \
               uuid-devel libffi-devel libuuid-devel

if [[ ! -d $GITDIR ]]; then
    git clone -b $VERSION --depth 1 https://github.com/python/cpython.git $GITDIR
fi

cd $GITDIR 
./configure --prefix=/usr
make
make install
echo "Python$VERSION installed successfully!"
