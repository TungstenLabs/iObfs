#!/bin/bash

# THIS DOES NOT YET WORK. As-is, you’ll get an Obfs4proxy.app
# that you can put onto a device, but does not run (possibly
# since iOS needs a user interface defined for a real app).


cd "`dirname \"$0\"`"
REPOROOT=$(pwd)

GOPATH=$REPOROOT/obfs4build
PATH=$GOPATH/bin:$PATH

#rm -fr $GOPATH
#mkdir $GOPATH

go get golang.org/x/mobile/cmd/gomobile
gomobile init

go get -d -u git.torproject.org/pluggable-transports/obfs4.git/obfs4proxy
#go install -a -x -v -work -p 8 git.torproject.org/pluggable-transports/obfs4.git/obfs4proxy
gomobile build -target ios -a -x -v -work  git.torproject.org/pluggable-transports/obfs4.git/obfs4proxy

#GOOS=darwin GOARCH=arm64 CC=clang-iphoneos CXX=clang-iphoneos CGO_CFLAGS="-isysroot=iphoneos -arch arm64" CGO_LDFLAGS="-isysroot=iphoneos -arch arm64" CGO_ENABLED=1 go install -pkgdir=$HOME/Code/iObfs/obfs4build -v -x -work git.torproject.org/pluggable-transports/obfs4.git/obfs4proxy
