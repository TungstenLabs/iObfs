An trivial example Tor iOS app, using [Tor.framework](https://github.com/iCepa/Tor.framework/) (currently using [a fork](https://github.com/mtigas/Tor.framework/tree/tor0.2.8.2-openssl1.0.2g)) and integrating iObfs to allow using obfuscated bridges.

First, make sure you've built `Iobfs4proxy.framework` in the repo root.

```bash
$ cd /path/to/iObfs
$ bash build.sh
```

Then, build `Tor.framework`

```bash
$ cd /path/to/iObfs/example
$ carthage update --platform iOS
```

---

1. Given a bare iOS app,

2. A UIWebView with Tor support is added by linking `Tor.framework`, [running a Tor thread in the app](https://github.com/mtigas/iObfs/commit/838fe6d926d643809cc8ea7e8a9b34a14c247ba3#diff-1), telling iOS to use Tor as a SOCKS proxy by registering a `NSURLProtocol` subclass ([`TorProxyURLProtocol`](https://github.com/mtigas/iObfs/commit/838fe6d926d643809cc8ea7e8a9b34a14c247ba3#diff-1)) which uses [`CKHTTPConnection`]((https://github.com/mtigas/iObfs/commit/838fe6d926d643809cc8ea7e8a9b34a14c247ba3#diff-3)) to configure SOCKS. (commit [838fe6d9](https://github.com/mtigas/iObfs/commit/838fe6d926d643809cc8ea7e8a9b34a14c247ba3))…
  * Launching this version of the app, you should see the UIWebView load `https://check.torproject.org/` successfully over Tor.

3. Obfuscated bridge support is added by linking `Iobfs4proxy.framework` and running `obfs4proxy` in a thread, per the instructions in the main repo README. (commit [00fac92d](https://github.com/mtigas/iObfs/commit/00fac92d620a6401de7b699720f3caa79b7a34c6))
  * Launching this version of the app should show the same successful `https://check.torproject.org` output; log output for the app should that Tor is using the `obfs4` bridges.


Some notes:

* This uses the [Tor Browser Bundle defaults](https://gitweb.torproject.org/builders/tor-browser-bundle.git/tree/Bundle-Data/PTConfigs/bridge_prefs.js) for obfs4 bridges.
* We configure Tor [using inline args](https://github.com/mtigas/iObfs/blob/00fac92d620a6401de7b699720f3caa79b7a34c6/example/ExampleObfs/AppDelegate.swift#L25-L53) rather than a torrc file.
* We're [not actually checking](https://github.com/mtigas/iObfs/blob/00fac92d620a6401de7b699720f3caa79b7a34c6/example/ExampleObfs/ViewController.swift#L15-L25) that Tor is ready when firing off the HTTP request to `check.torproject.org`. In the real world, you'd want to use `TORController` to connect to the Tor control port and check the connection status first.


