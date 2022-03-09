Content-Type: multipart/mixed; boundary="===============6822625554453119990=="
MIME-Version: 1.0
From: wen zhang <zhw2101024 at gmail.com>
To: iwd at lists.01.org
Subject: Unable to build ELL with OpenSSL 3
Date: Wed, 09 Mar 2022 18:36:17 +0800
Message-ID: <CAKjfnjpsLZ+amJ4ywTP=bpKt-YmoBLqV4cppNJcSrQXmNGQ5Bg@mail.gmail.com>

--===============6822625554453119990==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I tried to build ELL library on my system built following LFS 11.1
<https://www.linuxfromscratch.org/lfs/view/stable-systemd/>, but the make
command failed. Adding V=3D1 to the make command show one openssl command
failed to finish.

> openssl pkcs8 -in unit/cert-client-key-pkcs8.pem -out
> unit/cert-client-key-pkcs8-v2-des.pem -topk8 -v2 des-cbc -v2prf
> hmacWithSHA1 -passout pass:abc
>
Maybe something need to migrate from OpenSSL 1 to OpenSSL 3?

--===============6822625554453119990==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+PGRpdj5JIHRyaWVkIHRvIGJ1aWxkIEVMTCBsaWJyYXJ5IG9uIG15IHN5
c3RlbSBidWlsdCBmb2xsb3dpbmcgPGEgaHJlZj0iaHR0cHM6Ly93d3cubGludXhmcm9tc2NyYXRj
aC5vcmcvbGZzL3ZpZXcvc3RhYmxlLXN5c3RlbWQvIj5MRlMgMTEuMTwvYT4sIGJ1dCB0aGUgbWFr
ZSBjb21tYW5kIGZhaWxlZC4gQWRkaW5nIFY9MSB0byB0aGUgbWFrZSBjb21tYW5kIHNob3cgb25l
IG9wZW5zc2wgY29tbWFuZCBmYWlsZWQgdG8gZmluaXNoLjwvZGl2PjxibG9ja3F1b3RlIGNsYXNz
PSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVm
dDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij48ZGl2Pm9wZW5z
c2wgcGtjczggLWluIHVuaXQvY2VydC1jbGllbnQta2V5LXBrY3M4LnBlbSAtb3V0IHVuaXQvY2Vy
dC1jbGllbnQta2V5LXBrY3M4LXYyLWRlcy5wZW0gLXRvcGs4IC12MiBkZXMtY2JjIC12MnByZiBo
bWFjV2l0aFNIQTEgLXBhc3NvdXQgcGFzczphYmM8L2Rpdj48L2Jsb2NrcXVvdGU+PGRpdj5NYXli
ZSBzb21ldGhpbmcgbmVlZCB0byBtaWdyYXRlIGZyb20gT3BlblNTTCAxIHRvIE9wZW5TU0wgMz8g
PGJyPjwvZGl2PjwvZGl2Pgo=

--===============6822625554453119990==--

