An example Tor iOS app, using Tor.framework and integrating iObfs to allow using obfuscated bridges.

Make sure you've built the Iobfs4proxy.framework in the repo root.

```bash
$ cd /path/to/iObfs
$ bash build.sh
```

Build Tor.framework

```bash
$ cd /path/to/iObfs/example
$ carthage update --platform iOS
```

---

* Given a basic app with a UIWebView (commit [dd86152](https://github.com/mtigas/iObfs/tree/dd861524f2dddc8e316424636cc321a987ecf352/example))…
* You can add Tor support with the right Tor wrapper and `NSURLProtocol` subclass (commit [838fe6d9](https://github.com/mtigas/iObfs/commit/838fe6d926d643809cc8ea7e8a9b34a14c247ba3))…
  * (You should see the UIWebView load `https://check.torproject.org/` successfully over Tor.)
* And then add obfuscated bridges by linking in `Iobfs4proxy.framework` and running `obfs4proxy` in a thread, per the instructions in the main repo README. (commit [00fac92d](https://github.com/mtigas/iObfs/commit/00fac92d620a6401de7b699720f3caa79b7a34c6))
  * (You should see the same `https://check.torproject.org` output, but with Xcode log output showing that you're using `obfs4` bridges.)

