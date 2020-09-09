Content-Type: multipart/mixed; boundary="===============4347223579861121601=="
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Subject: question on failed tests
Date: Wed, 09 Sep 2020 09:10:16 -0500
Message-ID: <CAG17S_OcQNrcOXfxOidK7wst=+UAUztYxX-kND2UNKy-VR+gnA@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4347223579861121601==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I just built the iwd 1.9 for arch arm on armv6h, armv7h, and aarch64. The
aarch 64 builds and fails 0 tests. The armv6 fails the crypto and eapol
tests and the armv7 fails the eapol test.
Which kernel configs do I need to enable so that iwd fails 0 tests on all 3
architectures?
I searched the kernel configs for 'eapol' and found nothing. The 'crypto'
search revealed a lot of settings, but all looked to be either 'm'  or 'y'.
I am a bit out of my depth, here but i'm capable of building kernels for
all 3 architectures. Thanks for any guidance.

Regards,

Keith

--===============4347223579861121601==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+PGRpdj5JIGp1c3QgYnVpbHQgdGhlIGl3ZCAxLjkgZm9yIGFyY2ggYXJt
IG9uIGFybXY2aCwgYXJtdjdoLCBhbmQgYWFyY2g2NC4gVGhlIGFhcmNoIDY0IGJ1aWxkcyBhbmQg
ZmFpbHMgMCB0ZXN0cy4gVGhlIGFybXY2IGZhaWxzIHRoZSBjcnlwdG8gYW5kIGVhcG9sIHRlc3Rz
IGFuZCB0aGUgYXJtdjcgZmFpbHMgdGhlIGVhcG9sIHRlc3QuIDxicj48L2Rpdj48ZGl2PldoaWNo
IGtlcm5lbCBjb25maWdzIGRvIEkgbmVlZCB0byBlbmFibGUgc28gdGhhdCBpd2QgZmFpbHMgMCB0
ZXN0cyBvbiBhbGwgMyBhcmNoaXRlY3R1cmVzPyA8YnI+PC9kaXY+PGRpdj5JIHNlYXJjaGVkIHRo
ZSBrZXJuZWwgY29uZmlncyBmb3IgJiMzOTtlYXBvbCYjMzk7IGFuZCBmb3VuZCBub3RoaW5nLiBU
aGUgJiMzOTtjcnlwdG8mIzM5OyBzZWFyY2ggcmV2ZWFsZWQgYSBsb3Qgb2Ygc2V0dGluZ3MsIGJ1
dCBhbGwgbG9va2VkIHRvIGJlIGVpdGhlciAmIzM5O20mIzM5O8KgIG9yICYjMzk7eSYjMzk7LiBJ
IGFtIGEgYml0IG91dCBvZiBteSBkZXB0aCwgaGVyZSBidXQgaSYjMzk7bSBjYXBhYmxlIG9mIGJ1
aWxkaW5nIGtlcm5lbHMgZm9yIGFsbCAzIGFyY2hpdGVjdHVyZXMuIFRoYW5rcyBmb3IgYW55IGd1
aWRhbmNlLiA8YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5SZWdhcmRzLDwvZGl2PjxkaXY+
PGJyPjwvZGl2PjxkaXY+S2VpdGg8YnI+IDwvZGl2PjwvZGl2Pgo=

--===============4347223579861121601==--

