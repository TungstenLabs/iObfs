#!/bin/bash

cd "`dirname \"$0\"`"

REPOROOT=$(pwd)
GOPATH=$REPOROOT/obfs4build
PATH=$GOPATH/bin:$PATH

mkdir -p $GOPATH

set -v

# clean up previous build
rm -fr Iobfs4proxy.framework/

##### if first build: #####
#go get golang.org/x/mobile/cmd/gomobile
#gomobile init

go get -u github.com/mtigas/obfs4/obfs4proxy

gomobile bind -target ios -a -x -v github.com/mtigas/obfs4/obfs4proxy
