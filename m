Content-Type: multipart/mixed; boundary="===============8641067317264400632=="
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Subject: Re: broadcom fmac ap mode testing - how to set iwd as dhcp server?
Date: Mon, 01 Feb 2021 11:27:28 -0600
Message-ID: <CAG17S_OZLnzU3rc91kZ3EYQjGiXDOmZMfAR2x2r37WPwUs9y=g@mail.gmail.com>
In-Reply-To: <CAOq732JsARfDP1u5r-bQJB2YW_2JUqAzDBrba9n2JaJyorkadA@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8641067317264400632==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 1, 2021 at 6:42 AM Andrew Zaborowski <
andrew.zaborowski@intel.com> wrote:

> Hi Keith,
>
> On Sun, 31 Jan 2021 at 16:44, KeithG <ys3al35l@gmail.com> wrote:
> > So, I finally tried running iwd in 'standalone' ap mode (no connman). It
> still connects but even though I have this for my main.conf:
> > [General]
> > UseDefaultInterface=3Dtrue
> > EnableNetworkConfiguration=3Dtrue
>
> If I'm not mistaken you're missing the APRanges=3D setting for server-side
> DHCP.
>
> Best regards
>
Andrew,
I got a pointer from James and posed this to him as well. He asked that I
pose this to the greater group.
If I change my /etc/iwd/main.conf to

[General]
UseDefaultInterface=3Dtrue
EnableNetworkConfiguration=3Dtrue
APRanges=3D192.168.5.0/24

I now get an IP address and can connect. Is there a way to make iwd scan
for SSIDs when connected this way? We are trying to set up an RPi so that
when powered, if it gets no IP address, it turns into an AP and allows a
connection to select an SSID to connect to. Currently, we are using connman
and dnsmasq/hostapd and that works. I have tried connman with its 'tether'
mode and though it creates a 'tether' interface, it does connect and
appears to scan at startup before it turns over the tether mode, but I have
no control over the IP address it advertised on and our current
instructions specify 192.168.5.1. I'd like to not change that. If I used
hostapd and dnsmasq, it does scan and I can see SSIDs as they appear.

Looking for a transparent way to move to iwd and/or connman from
hostapd/dnsmasq yet not change the instructions.

Thanks for the help!

Keith

--===============8641067317264400632==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+Cgo8L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9x
dW90ZSI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPk9uIE1vbiwgRmViIDEsIDIw
MjEgYXQgNjo0MiBBTSBBbmRyZXcgWmFib3Jvd3NraSAmbHQ7PGEgaHJlZj0ibWFpbHRvOmFuZHJl
dy56YWJvcm93c2tpQGludGVsLmNvbSI+YW5kcmV3LnphYm9yb3dza2lAaW50ZWwuY29tPC9hPiZn
dDsgd3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9
Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwy
MDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij5IaSBLZWl0aCw8YnI+Cjxicj4KT24gU3VuLCAzMSBK
YW4gMjAyMSBhdCAxNjo0NCwgS2VpdGhHICZsdDs8YSBocmVmPSJtYWlsdG86eXMzYWwzNWxAZ21h
aWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+eXMzYWwzNWxAZ21haWwuY29tPC9hPiZndDsgd3JvdGU6
PGJyPgomZ3Q7IFNvLCBJIGZpbmFsbHkgdHJpZWQgcnVubmluZyBpd2QgaW4gJiMzOTtzdGFuZGFs
b25lJiMzOTsgYXAgbW9kZSAobm8gY29ubm1hbikuIEl0IHN0aWxsIGNvbm5lY3RzIGJ1dCBldmVu
IHRob3VnaCBJIGhhdmUgdGhpcyBmb3IgbXkgbWFpbi5jb25mOjxicj4KJmd0OyBbR2VuZXJhbF08
YnI+CiZndDsgVXNlRGVmYXVsdEludGVyZmFjZT10cnVlPGJyPgomZ3Q7IEVuYWJsZU5ldHdvcmtD
b25maWd1cmF0aW9uPXRydWU8YnI+Cjxicj4KSWYgSSYjMzk7bSBub3QgbWlzdGFrZW4geW91JiMz
OTtyZSBtaXNzaW5nIHRoZSBBUFJhbmdlcz0gc2V0dGluZyBmb3Igc2VydmVyLXNpZGUgREhDUC48
YnI+Cjxicj4KQmVzdCByZWdhcmRzPGJyPjwvYmxvY2txdW90ZT48ZGl2PgpBbmRyZXcsIDxicj48
L2Rpdj48ZGl2PkkgZ290IGEgcG9pbnRlciBmcm9tIEphbWVzIGFuZCAKcG9zZWQgdGhpcyB0byBo
aW0gYXMgd2VsbC4gSGUgYXNrZWQgdGhhdCBJIHBvc2UgdGhpcyB0byB0aGUgZ3JlYXRlciBncm91
cC4gPHNwYW4gY2xhc3M9ImdtYWlsLWltIj48ZGl2PklmIEkgY2hhbmdlIG15IC9ldGMvaXdkL21h
aW4uY29uZiB0bzwvZGl2Pjwvc3Bhbj48c3BhbiBjbGFzcz0iZ21haWwtaW0iPjxkaXY+PGJyPjwv
ZGl2PjxkaXY+PHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5Om1vbm9zcGFjZSI+W0dlbmVyYWxdPGJy
PlVzZURlZmF1bHRJbnRlcmZhY2U9dHJ1ZTxicj5FbmFibGVOZXR3b3JrQ29uZmlndXJhdGlvbj10
cnVlPGJyPkFQUmFuZ2VzPTxhIGhyZWY9Imh0dHA6Ly8xOTIuMTY4LjUuMC8yNCIgdGFyZ2V0PSJf
YmxhbmsiPjE5Mi4xNjguNS4wLzI0PC9hPjxicj48L3NwYW4+PC9kaXY+PGRpdj48YnI+PC9kaXY+
PGRpdj5JCiBub3cgZ2V0IGFuIElQIGFkZHJlc3MgYW5kIGNhbiBjb25uZWN0LiBJcyB0aGVyZSBh
IHdheSB0byBtYWtlIGl3ZCBzY2FuIApmb3IgU1NJRHMgd2hlbiBjb25uZWN0ZWQgdGhpcyB3YXk/
IFdlIGFyZSB0cnlpbmcgdG8gc2V0IHVwIGFuIFJQaSBzbyAKdGhhdCB3aGVuIHBvd2VyZWQsIGlm
IGl0IGdldHMgbm8gSVAgYWRkcmVzcywgaXQgdHVybnMgaW50byBhbiBBUCBhbmQgCmFsbG93cyBh
IGNvbm5lY3Rpb24gdG8gc2VsZWN0IGFuIFNTSUQgdG8gY29ubmVjdCB0by4gQ3VycmVudGx5LCB3
ZSBhcmUgCnVzaW5nIGNvbm5tYW4gYW5kIGRuc21hc3EvaG9zdGFwZCBhbmQgdGhhdCB3b3Jrcy4g
SSBoYXZlIHRyaWVkIGNvbm5tYW4gCndpdGggaXRzICYjMzk7dGV0aGVyJiMzOTsgbW9kZSBhbmQg
dGhvdWdoIGl0IGNyZWF0ZXMgYSAmIzM5O3RldGhlciYjMzk7IGludGVyZmFjZSwgaXQgCmRvZXMg
Y29ubmVjdCBhbmQgYXBwZWFycyB0byBzY2FuIGF0IHN0YXJ0dXAgYmVmb3JlIGl0IHR1cm5zIG92
ZXIgdGhlIHRldGhlciBtb2RlLCBidXQgSSBoYXZlIG5vIGNvbnRyb2wgb3ZlciB0aGUgSVAgYWRk
cmVzcyAKaXQgYWR2ZXJ0aXNlZCBvbiBhbmQgb3VyIGN1cnJlbnQgaW5zdHJ1Y3Rpb25zIHNwZWNp
ZnkgMTkyLjE2OC41LjEuIEkmIzM5O2QgbGlrZSB0byBub3QgCmNoYW5nZSB0aGF0LiBJZiBJIHVz
ZWQgaG9zdGFwZCBhbmQgZG5zbWFzcSwgaXQgZG9lcyBzY2FuIGFuZCBJIGNhbiBzZWUgU1NJRHMg
YXMgdGhleSBhcHBlYXIuPGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+TG9va2luZyBmb3Ig
YSB0cmFuc3BhcmVudCB3YXkgdG8gbW92ZSB0byBpd2QgYW5kL29yIGNvbm5tYW4gZnJvbSBob3N0
YXBkL2Ruc21hc3EgeWV0IG5vdCBjaGFuZ2UgdGhlIGluc3RydWN0aW9ucy48L2Rpdj48ZGl2Pjxi
cj48L2Rpdj48ZGl2PlRoYW5rcyBmb3IgdGhlIGhlbHAhPGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2
PjxkaXY+S2VpdGg8L2Rpdj48L3NwYW4+wqAgPGJyPjwvZGl2PjwvZGl2PjwvZGl2Pgo=

--===============8641067317264400632==--

