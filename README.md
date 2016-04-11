## iObfs

[![Build Status](https://travis-ci.org/mtigas/iObfs.svg?branch=master)](https://travis-ci.org/mtigas/iObfs)  
&copy; 2016 [Mike Tigas][miketigas] ([@mtigas](https://twitter.com/mtigas))  
[BSD 2-clause License][license]

*This is an experimental project currently in development. You should not rely on it for stability or safety at this time.*

iObfs is a project to create a build process, documentation,
and examples regarding building [obfs4proxy][obfs4]
([alternate repo link][obfs4-alt]) for use inside Tor-enabled iOS apps, like [Onion Browser][onion-browser] and [iCepa][icepa].

obfs4proxy is a [pluggable transport][pt] for [Tor][tor], which can allow users to defeat certain types of network censorship. (Read some great information about pluggable transports — and how they work — [here][pt1] and [here][pt2].)

This work is supported in part by [The Guardian Project][guardian].

[miketigas]: https://mike.tig.as/
[license]: https://github.com/mtigas/iObfs/blob/master/LICENSE
[obfs4]: https://github.com/Yawning/obfs4
[obfs4-alt]: https://gitweb.torproject.org/pluggable-transports/obfs4.git/
[pt]: https://www.torproject.org/docs/pluggable-transports.html.en
[pt1]: https://trac.torproject.org/projects/tor/wiki/doc/AChildsGardenOfPluggableTransports
[pt2]: https://trac.torproject.org/projects/tor/wiki/doc/PluggableTransports
[tor]: https://www.torproject.org/
[onion-browser]: https://mike.tig.as/onionbrowser/
[icepa]: https://github.com/iCepa
[guardian]: https://guardianproject.info/

---

### Notes

[`build.sh`](https://github.com/mtigas/iObfs/blob/master/build.sh) builds an `Iobfs4proxy.framework`, by using the [gomobile][gomobile] [`bind`][gobind] tool. The current build script uses [a fork of obfs4proxy](https://github.com/mtigas/obfs4) with modifications such that:

1. it can be built as a framework, with an externally-visible `main()`
2. some of the environment variables that obfs4proxy (and other pluggable transports) expect are hard-coded in, such that we "fake" managed mode, per [this](https://github.com/mtigas/iObfs/wiki/Unmanaged-obfs4proxy). the `PT_STATE` uses the `$TMPDIR` environment variable, which on iOS contains the path to the app’s [designated (sandboxed) temporary directory](https://developer.apple.com/library/ios/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/FileSystemOverview/FileSystemOverview.html).
3. the socks5 ports for the Tor<->obfs4proxy connections are hard-coded so the iOS side knows what to connect to. (TODO: this will be removed once we have a better way to communicate this out from obfs4proxy into the iOS main thread.)

[gomobile]: https://golang.org/x/mobile/cmd/gomobile
[gobind]: https://godoc.org/golang.org/x/mobile/cmd/gobind

The framework contains a header that exposes a `GoIobfs4proxyMain();` function (the original `main()` from obfs4proxy). Note that this function must be called inside an NSThread subclass, otherwise your iOS app will be blocked on that function call. You can use `ObfsThread.h` and `ObfsThread.m` from this repo to do this for you.

In the future, iObfs will wrap the build script, `Iobfs4proxy.framework`, and `ObfsThread` utilities in a framework using Carthage to improve reusability -- [see branch](https://github.com/mtigas/iObfs/tree/framework). A [go compilation issue](https://github.com/golang/go/issues/12896) prevents this from working at the moment.

Please see the [GitHub issues](https://github.com/mtigas/iObfs/issues) for known issues and caveats.

---

### Using obfs4proxy in your app

(Note: this framework and these instructions are very much in development, so your mileage may vary. Some comfortability with Tor configuration is assumed.)

Given that you already have an iOS app with integrated Tor. On your machine, you'll also need a recent version of [Go](https://golang.org/) to build obfs4proxy. (1.5 _should_ work, but this work has only been tested in Go 1.6.)

Run [`bash build.sh`](https://github.com/mtigas/iObfs/blob/master/build.sh) and wait a little while.

Copy `Iobfs4proxy.framework/`, `ObfsThread.h`, and `ObfsThread.m` into your existing Tor-powered iOS app.

Set the following lines in your app’s `torrc`:

```
ClientTransportPlugin obfs4 socks5 127.0.0.1:47351
ClientTransportPlugin meek_lite socks5 127.0.0.1:47352
ClientTransportPlugin obfs2 socks5 127.0.0.1:47353
ClientTransportPlugin obfs3 socks5 127.0.0.1:47354
ClientTransportPlugin scramblesuit socks5 127.0.0.1:47355
```

Instantiate Tor normally within your app, then run an `ObfsThread` instance in your app (you might want to check first that the user has `Bridge` lines that require the pluggable transport). Something like:

```objc
ObfsWrapper *obfsproxy = [[ObfsWrapper alloc] init];
[obfsproxy start];
```

Then, if a user has the appropriate `Bridge` lines using one of those tranpsports (and given that you've set `UseBridges 1` appropriately), your app’s Tor should successfully use obfuscated bridges.

You can see a short version of this in the `example/` directory. The README will guide you through a couple of the commits.
