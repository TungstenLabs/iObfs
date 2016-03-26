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
[license]: https://github.com/OnionBrowser/iOS-OnionBrowser/blob/master/LICENSE
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

### High-level tasks

* The first problem is building the `obfs4proxy` for iOS. There appears to be some (limited) support for cross-compiling Go into iOS, using [gomobile][gomobile] and [gobind][gobind]. (**TODO**)

[gomobile]: https://golang.org/x/mobile/cmd/gomobile
[gobind]: https://godoc.org/golang.org/x/mobile/cmd/gobind

* The second hurdle is taking those techniques and linking `obfs4proxy` into a "normal" iOS app and running it (in a thread, much as [Onion Browser][onion-browser] runs tor in the app’s main process due to iOS’ single-process limitation). (**TODO**)

* Finally, because `obfs4proxy` must be run as a "managed mode" pluggable transport (which requires it to be run as a subprocess of Tor), a workaround is needed to allow `obfs4proxy` to work without being forked as a subprocess, to allow it to work in iOS. (**[Solved](https://github.com/mtigas/iObfs/blob/master/notes/obfs4-nonmanaged.md).**)
