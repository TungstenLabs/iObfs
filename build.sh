#!/bin/bash

cd "`dirname \"$0\"`"

REPOROOT=$(pwd)
GOPATH=$REPOROOT/.build
PATH=$GOPATH/bin:$PATH

mkdir -p $GOPATH

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

# get our forked obfs4proxy source and build it as a framework
go get -u github.com/mtigas/obfs4/obfs4proxy
gomobile bind -target ios -v github.com/mtigas/obfs4/obfs4proxy
	
# clean up build, everything we need is in Iobfs4proxy.framework/
rm -fr $GOPATH
