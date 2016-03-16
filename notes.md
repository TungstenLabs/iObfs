have [gomobile](https://godoc.org/golang.org/x/mobile/cmd/gomobile)
```
$ go get golang.org/x/mobile/cmd/gomobile
$ gomobile init
```

ok then

```
gomobile bind -target ios git.torproject.org/pluggable-transports/obfs4.git/obfs4proxy
GOOS=darwin GOARCH=x86_64 gomobile bind -target ios git.torproject.org/pluggable-transports/obfs4.git/obfs4proxy

lipo -create
-output "${OUTPUTDIR}/lib/${OUTPUT_LIB}"

```


https://godoc.org/golang.org/x/mobile/cmd/gobind



gotta figure out how to build pkg_darwin_amd64 in addition to pkg_darwin_arm64
