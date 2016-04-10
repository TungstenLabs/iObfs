#!/bin/bash

cd "`dirname \"$0\"`"

REPOROOT=$(pwd)
GOPATH=$REPOROOT/obfs4build
PATH=$GOPATH/bin:$PATH

mkdir -p $GOPATH

set -v

# clean up previous build
rm -fr Iobfs4proxy.framework/

# Set up gomobile.
# Unfortunately, "go bind" currently skips compiling for i386
# so use fork that trivially adds that.
go get -d golang.org/x/mobile/cmd/gomobile
cd $GOPATH/src/golang.org/x/mobile
git remote add mtigas https://github.com/mtigas/gomobile.git
git fetch mtigas
git checkout ios-also-build-i386
cd $REPOROOT
go get -f -u golang.org/x/mobile/cmd/gomobile
gomobile init

go get -u github.com/mtigas/obfs4/obfs4proxy

gomobile bind -target ios -v github.com/mtigas/obfs4/obfs4proxy

