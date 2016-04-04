## iObfs

&copy; 2016 [Mike Tigas][miketigas] ([@mtigas](https://twitter.com/mtigas))  
[BSD 2-clause License][license]

A project with the aim of (someday) compiling [obfs4proxy][obfs4]
([alternate repo link][obfs4-alt]) for use on iOS. Obfs4proxy is a
[pluggable transport][pt] for [Tor][tor], which can allow users to defeat
certain types of network censorship. (Read some great information about
pluggable transports — and how they work — [here][pt1] and [here][pt2].)

The end goal is to create support for obfs4proxy in
[Onion Browser][onion-browser], [iCepa][icepa], and other Tor-enabled iOS
projects.

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

[`buildobfs4.sh`](https://github.com/mtigas/iObfs/blob/master/buildobfs4.sh) builds an `Iobfs4proxy.framework`, by using the [gomobile][gomobile] [`bind`][gobind] tool. Currently using forks of [obfs4](https://github.com/mtigas/obfs4) and [goptlib](https://github.com/mtigas/goptlib) with modifications such that:

1. it can be built as a framework, with an externally-visible `main()`
2. some of the environment variables that obfs4proxy (and other pluggable transports) expect are hard-coded in, such that we "fake" managed mode, per [this](https://github.com/mtigas/iObfs/blob/master/notes/obfs4-nonmanaged.md). the `PT_STATE` uses the `$TMPDIR` environment variable, which on iOS contains the path to the app’s [designated (sandboxed) temporary directory](https://developer.apple.com/library/ios/documentation/FileManagement/Conceptual/FileSystemProgrammingGuide/FileSystemOverview/FileSystemOverview.html).
3. the socks5 ports for the Tor<->obfs4proxy connections are hard-coded so the iOS side knows what to connect to. (TODO: this will be removed once we have a better way to communicate this out from obfs4proxy into the iOS main thread.)

[gomobile]: https://golang.org/x/mobile/cmd/gomobile
[gobind]: https://godoc.org/golang.org/x/mobile/cmd/gobind

TODO: Building a Tor into this demo app to demonstrate that it works.
