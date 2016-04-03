#!/bin/bash

cd "`dirname \"$0\"`"

REPOROOT=$(pwd)
GOPATH=$REPOROOT/obfs4build
PATH=$GOPATH/bin:$PATH

set -v

#rm -fr $GOPATH
#mkdir $GOPATH
rm -fr Iobfs4proxy.framework/

go get golang.org/x/mobile/cmd/gomobile
gomobile init

go get -u github.com/mtigas/goptlib
go get -u github.com/mtigas/obfs4/obfs4proxy

# If, for some reason you want to build a non-working "Obfs4proxy.app"
# built for iOS:
#gomobile build -target ios -a -x -v -work  git.torproject.org/pluggable-transports/obfs4.git/obfs4proxy


# After the go get, we have to patch the executable obfs4proxy
# to be a fake library:
# in src/git.torproject.org/pluggable-transports/obfs4.git/obfs4proxy
# for each file, replace "package main" with "package iobfs4proxy".
# in obfs4proxy.go, replace "func main" with "func Main"

# Then we build this as a library:
gomobile bind -target ios -a -x -v github.com/mtigas/obfs4/obfs4proxy
