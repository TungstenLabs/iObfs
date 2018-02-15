#!/bin/bash

cd "`dirname \"$0\"`"

export REPOROOT=$(pwd)
export GOPATH=$REPOROOT/.build
export PATH=$GOPATH/bin:$PATH
export CGO_CFLAGS_ALLOW='-fmodules|-fblocks'

set -v

rm -fr $GOPATH
mkdir -p $GOPATH

# clean up previous build
rm -fr Iobfs4proxy.framework

# Set up gomobile.
# Unfortunately, "go bind" currently skips compiling for i386
# so use fork that trivially adds that.
go get -d golang.org/x/mobile/cmd/gomobile
cd $GOPATH/src/golang.org/x/mobile
git remote add mtigas https://github.com/mtigas/gomobile.git
git fetch mtigas
git checkout iobfs-build
cd $REPOROOT
go get -f -u golang.org/x/mobile/cmd/gomobile
eval $GOPATH/bin/gomobile init

# get our forked obfs4proxy source and build it as a framework
go get -d git.torproject.org/pluggable-transports/obfs4.git
cd $GOPATH/src/git.torproject.org/pluggable-transports/obfs4.git
git remote add ynd https://github.com/ynd-consult-ug/obfs4.git
git fetch ynd
git checkout iObfs-201802
cd $REPOROOT
go get -f -u git.torproject.org/pluggable-transports/obfs4.git/obfs4proxy
eval $GOPATH/bin/gomobile bind -target ios -v git.torproject.org/pluggable-transports/obfs4.git/obfs4proxy
	
#clean up build, everything we need is in Iobfs4proxy.framework/
# rm -fr $GOPATH