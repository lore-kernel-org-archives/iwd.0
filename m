Content-Type: multipart/mixed; boundary="===============8662679801746561763=="
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Subject: iwd 1.11 does not run on armv6
Date: Wed, 27 Jan 2021 00:54:19 -0600
Message-ID: <CAG17S_PFA04=YujYMtkpB1CzXB+tvjcqPuvtAhEqyMwqa8AfRQ@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8662679801746561763==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is on Arch Arm on an RPi. 1.10 ran fine. 1.11 was just pushed out and
now it does not run and we get this in the log:
iwd[1770]: /usr/lib/iwd/iwd: symbol lookup error: /usr/lib/iwd/iwd:
undefined symbol: l_acd_set_debug, version ELL_0.10
in the log. Any ideas on how we can fix it? Is it a kernel flag that is
somehow different between armv7 and armv6 versus aarch64?

Keith

--===============8662679801746561763==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+PGRpdj5UaGlzIGlzIG9uIEFyY2ggQXJtIG9uIGFuIFJQaS4gMS4xMCBy
YW4gZmluZS4gMS4xMSB3YXMganVzdCBwdXNoZWQgb3V0IGFuZCBub3cgaXQgZG9lcyBub3QgcnVu
IGFuZCB3ZSBnZXQgdGhpcyBpbiB0aGUgbG9nOjwvZGl2PjxkaXY+aXdkWzE3NzBdOiAvdXNyL2xp
Yi9pd2QvaXdkOiBzeW1ib2wgbG9va3VwIGVycm9yOiAvdXNyL2xpYi9pd2QvaXdkOiB1bmRlZmlu
ZWQgc3ltYm9sOiBsX2FjZF9zZXRfZGVidWcsIHZlcnNpb24gRUxMXzAuMTA8L2Rpdj48ZGl2Pmlu
IHRoZSBsb2cuIEFueSBpZGVhcyBvbiBob3cgd2UgY2FuIGZpeCBpdD8gSXMgaXQgYSBrZXJuZWwg
ZmxhZyB0aGF0IGlzIHNvbWVob3cgZGlmZmVyZW50IGJldHdlZW4gYXJtdjcgYW5kIGFybXY2IHZl
cnN1cyBhYXJjaDY0PzwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+S2VpdGg8YnI+PC9kaXY+PC9k
aXY+Cg==

--===============8662679801746561763==--

