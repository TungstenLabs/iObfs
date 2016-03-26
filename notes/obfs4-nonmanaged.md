## obfs4proxy in unmanaged mode

```
[ERROR]: obfs4proxy - must be run as a managed transport
```

Yeah? Let's pick apart the [pluggable transport spec][pt-spec] and the
[control port spec][control-spec] and fake it.

[pt-spec]: https://gitweb.torproject.org/torspec.git/tree/pt-spec.txt
[control-spec]: https://gitweb.torproject.org/torspec.git/tree/control-spec.txt

This is a little scratchpad for how we might handle obfs4proxy _in-process_
inside an iOS app. We need to do this because

1. iOS doesn’t allow forking subprocesses
2. "managed mode" means that tor launches your pluggable transport as a subprocess

Luckily, the main parts of the spec are simple and it turns out we _don't_ need to
manually build circuits or anything crazy like that.

### tor

Assume that Tor runs with the following basic torrc, containing the
[default Tor Browser Bundle bridges](https://gitweb.torproject.org/builders/tor-browser-bundle.git/tree/Bundle-Data/PTConfigs/bridge_prefs.js)
and with networking disabled to start:

```
DisableNetwork 1
UseBridges 1
Bridge obfs4 154.35.22.10:41835 8FB9F4319E89E5C6223052AA525A192AFBC85D55 cert=GGGS1TX4R81m3r0HBl79wKy1OtPPNR2CZUIrHjkRg65Vc2VR8fOyo64f9kmT1UAFG7j0HQ iat-mode=0
Bridge obfs4 198.245.60.50:443 752CF7825B3B9EA6A98C83AC41F7099D67007EA5 cert=xpmQtKUqQ/6v5X7ijgYE/f03+l2/EuQ1dexjyUhh16wQlu/cpXUGalmhDIlhuiQPNEKmKw iat-mode=0
Bridge obfs4 192.99.11.54:443 7B126FAB960E5AC6A629C729434FF84FB5074EC2 cert=VW5f8+IBUWpPFxF+rsiVy2wXkyTQG7vEd+rHeN2jV5LIDNu8wMNEOqZXPwHdwMVEBdqXEw iat-mode=0
Bridge obfs4 109.105.109.165:10527 8DFCD8FB3285E855F5A55EDDA35696C743ABFC4E cert=Bvg/itxeL4TWKLP6N1MaQzSOC6tcRIBv6q57DYAZc3b2AzuM+/TfB7mqTFEfXILCjEwzVA iat-mode=0
Bridge obfs4 83.212.101.3:41213 A09D536DD1752D542E1FBB3C9CE4449D51298239 cert=lPRQ/MXdD1t5SRZ9MquYQNT9m5DV757jtdXdlePmRCudUU9CFUOX1Tm7/meFSyPOsud7Cw iat-mode=0
Bridge obfs4 104.131.108.182:56880 EF577C30B9F788B0E1801CF7E433B3B77792B77A cert=0SFhfDQrKjUJP8Qq6wrwSICEPf3Vl/nJRsYxWbg3QRoSqhl2EB78MPS2lQxbXY4EW1wwXA iat-mode=0
Bridge obfs4 109.105.109.147:13764 BBB28DF0F201E706BE564EFE690FE9577DD8386D cert=KfMQN/tNMFdda61hMgpiMI7pbwU1T+wxjTulYnfw+4sgvG0zSH7N7fwT10BI8MUdAD7iJA iat-mode=0
Bridge obfs4 154.35.22.11:49868 A832D176ECD5C7C6B58825AE22FC4C90FA249637 cert=YPbQqXPiqTUBfjGFLpm9JYEFTBvnzEJDKJxXG5Sxzrr/v2qrhGU4Jls9lHjLAhqpXaEfZw iat-mode=0
Bridge obfs4 154.35.22.12:80 00DC6C4FA49A65BD1472993CF6730D54F11E0DBB cert=N86E9hKXXXVz6G7w2z8wFfhIDztDAzZ/3poxVePHEYjbKDWzjkRDccFMAnhK75fc65pYSg iat-mode=0
Bridge obfs4 154.35.22.13:443 FE7840FE1E21FE0A0639ED176EDA00A3ECA1E34D cert=fKnzxr+m+jWXXQGCaXe4f2gGoPXMzbL+bTBbXMYXuK0tMotd+nXyS33y2mONZWU29l81CA iat-mode=0
Bridge obfs4 154.35.22.10:80 8FB9F4319E89E5C6223052AA525A192AFBC85D55 cert=GGGS1TX4R81m3r0HBl79wKy1OtPPNR2CZUIrHjkRg65Vc2VR8fOyo64f9kmT1UAFG7j0HQ iat-mode=0
Bridge obfs4 154.35.22.10:443 8FB9F4319E89E5C6223052AA525A192AFBC85D55 cert=GGGS1TX4R81m3r0HBl79wKy1OtPPNR2CZUIrHjkRg65Vc2VR8fOyo64f9kmT1UAFG7j0HQ iat-mode=0
Bridge obfs4 154.35.22.11:443 A832D176ECD5C7C6B58825AE22FC4C90FA249637 cert=YPbQqXPiqTUBfjGFLpm9JYEFTBvnzEJDKJxXG5Sxzrr/v2qrhGU4Jls9lHjLAhqpXaEfZw iat-mode=0
Bridge obfs4 154.35.22.11:80 A832D176ECD5C7C6B58825AE22FC4C90FA249637 cert=YPbQqXPiqTUBfjGFLpm9JYEFTBvnzEJDKJxXG5Sxzrr/v2qrhGU4Jls9lHjLAhqpXaEfZw iat-mode=0
```

### Start obfs4 manually

After tor has started, we launch obfs4proxy separately, faking the managed environment
portions of the [pluggable transport spec][pt-spec].

```
TOR_PT_MANAGED_TRANSPORT_VER=1 \
TOR_PT_STATE_LOCATION=$HOME/.tor/pt_state \
TOR_PT_EXIT_ON_STDIN_CLOSE=1 \
TOR_PT_CLIENT_TRANSPORTS=obfs4 \
obfs4proxy
```

We then receive some lines in `STDOUT` like the following, which basically gives you `ClientTransportPlugin`
lines:

```
CMETHOD obfs4 socks5 127.0.0.1:61876
```

In an iOS app, obfs4proxy will likely run
in the same process as the app _and_ tor (see [Onion Browser][onion-browser-impl]),
and we’ll have to find some way to catch `STDOUT`.

[onion-browser-impl]: https://github.com/OnionBrowser/iOS-OnionBrowser#implementation-notes

### Configure the bridges, using the control port

Connecting to the control port, via something like:

```
telnet -u $TORDIR/control
```

We perform a session like this:

```
authenticate ""
250 OK
setconf ClientTransportPlugin="obfs4 socks5 127.0.0.1:61876"
250 OK
setconf disablenetwork=0
250 OK
```

And given some `getinfo status/bootstrap-phase` commands (or by watching tor’s
`STDOUT`), we see that we’re now connecting to Tor, via our obfs4 bridges,
without having to rely on managed mode.
