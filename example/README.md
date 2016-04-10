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

