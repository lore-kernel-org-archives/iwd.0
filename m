Content-Type: multipart/mixed; boundary="===============2986760677929753574=="
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Subject: iwd problems on Arch Linux
Date: Wed, 14 Oct 2020 18:52:34 -0500
Message-ID: <CAG17S_O-2pk_b9sDt2-MNdeH4mrbhpzhurGybaYA=NBfVf9U6w@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2986760677929753574==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I have been struggling with this problem for a while and *think* I have
narrowed it down to an Arch Linux problem. My main focus is to get
iwd/connman to work on my RPis as iwd connects so much faster when it
works. Current versions on Arch Linux are Connman =3D 1.38 and iwd =3D 1.9.=
 The
kernel I'm running is 5.4.70.

It does not behave absolutely consistently but there are themes. If I have
connman managing the connections, when the SSID goes away, iwd stops
scanning. This is very consistent. It does it first time every time. SSID
goes down, it disconnects and sits there. On Arch Linux, it does not seem
to be dependent on card (broadcom/intel) or hardware
(x86_64,armv6/armv7/aarch64). iwd quits scanning when the SSID goes away.
The monitor-iwd script shows 'Scanning =3D False' and it never rescans.
When I use systemd-networkd with iwd, I get better behavior, but it can
also get to a point where it quits scanning. This happens after a few times
of turning off then on the AP on the router. When it quits scanning,
monitor-iwd says "Scanning =3D False" and it never rescans. The last time I
ran it, the monitor-iwd script says Scanning =3D True then immediately
Scanning =3D False but nothing was scanned. It did this 13 times but never
'saw' anything nor connected. If I down then up the interface (ifconfig
wlan0 down; ifconfig wlan0 up), it immediately connects. I now have a
script that runs when the interface goes down to do this (down/up), but
shouldn't iwd eventually reconnect?

This contrasts with the same computer running RasPiOS. It is running the
same kernel and the same broadcom firmware (I updated both to be identical)
connman is 1.36 and iwd is 0.14, but it works every time all the time. I
cannot get it to not reconnect. In fact it connects faster than the web
page for the router registers it.

I built iwd 0.14 and connman 1.36 for the Arch install and it behaves the
same as iwd 1.9 or the iwd git master build. It just quits.

What underlying OS issues could cause this? I have built the kernel with
the same config options for both installations with the same computer doing
the building. Both installations are using the same kernel, firmware and
driver version (built with the kernel).

Keith

--===============2986760677929753574==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+PGRpdj5JIGhhdmUgYmVlbiBzdHJ1Z2dsaW5nIHdpdGggdGhpcyBwcm9i
bGVtIGZvciBhIHdoaWxlIGFuZCAqdGhpbmsqIEkgaGF2ZSBuYXJyb3dlZCBpdCBkb3duIHRvIGFu
IEFyY2ggTGludXggcHJvYmxlbS4gTXkgbWFpbiBmb2N1cyBpcyB0byBnZXQgaXdkL2Nvbm5tYW4g
dG8gd29yayBvbiBteSBSUGlzIGFzIGl3ZCBjb25uZWN0cyBzbyBtdWNoIGZhc3RlciB3aGVuIGl0
IHdvcmtzLiBDdXJyZW50IHZlcnNpb25zIG9uIEFyY2ggTGludXggYXJlIENvbm5tYW4gPSAxLjM4
IGFuZCBpd2QgPSAxLjkuIFRoZSBrZXJuZWwgSSYjMzk7bSBydW5uaW5nIGlzIDUuNC43MC48YnI+
PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5JdCBkb2VzIG5vdCBiZWhhdmUgYWJzb2x1dGVseSBj
b25zaXN0ZW50bHkgYnV0IHRoZXJlIGFyZSB0aGVtZXMuIElmIEkgaGF2ZSBjb25ubWFuIG1hbmFn
aW5nIHRoZSBjb25uZWN0aW9ucywgd2hlbiB0aGUgU1NJRCBnb2VzIGF3YXksIGl3ZCBzdG9wcyBz
Y2FubmluZy4gVGhpcyBpcyB2ZXJ5IGNvbnNpc3RlbnQuIEl0IGRvZXMgaXQgZmlyc3QgdGltZSBl
dmVyeSB0aW1lLiBTU0lEIGdvZXMgZG93biwgaXQgZGlzY29ubmVjdHMgYW5kIHNpdHMgdGhlcmUu
IE9uIEFyY2ggTGludXgsIGl0IGRvZXMgbm90IHNlZW0gdG8gYmUgZGVwZW5kZW50IG9uIGNhcmQg
KGJyb2FkY29tL2ludGVsKSBvciBoYXJkd2FyZSAoeDg2XzY0LGFybXY2L2FybXY3L2FhcmNoNjQp
LiBpd2QgcXVpdHMgc2Nhbm5pbmcgd2hlbiB0aGUgU1NJRCBnb2VzIGF3YXkuIFRoZSBtb25pdG9y
LWl3ZCBzY3JpcHQgc2hvd3MgJiMzOTtTY2FubmluZyA9IEZhbHNlJiMzOTsgYW5kIGl0IG5ldmVy
IHJlc2NhbnMuIDxicj48L2Rpdj48ZGl2PldoZW4gSSB1c2Ugc3lzdGVtZC1uZXR3b3JrZCB3aXRo
IGl3ZCwgSSBnZXQgYmV0dGVyIGJlaGF2aW9yLCBidXQgaXQgY2FuIGFsc28gZ2V0IHRvIGEgcG9p
bnQgd2hlcmUgaXQgcXVpdHMgc2Nhbm5pbmcuIFRoaXMgaGFwcGVucyBhZnRlciBhIGZldyB0aW1l
cyBvZiB0dXJuaW5nIG9mZiB0aGVuIG9uIHRoZSBBUCBvbiB0aGUgcm91dGVyLiBXaGVuIGl0IHF1
aXRzIHNjYW5uaW5nLCBtb25pdG9yLWl3ZCBzYXlzICZxdW90O1NjYW5uaW5nID0gRmFsc2UmcXVv
dDsgYW5kIGl0IG5ldmVyIHJlc2NhbnMuIFRoZSBsYXN0IHRpbWUgSSByYW4gaXQsIHRoZSBtb25p
dG9yLWl3ZCBzY3JpcHQgc2F5cyBTY2FubmluZyA9IFRydWUgdGhlbiBpbW1lZGlhdGVseSBTY2Fu
bmluZyA9IEZhbHNlIGJ1dCBub3RoaW5nIHdhcyBzY2FubmVkLiBJdCBkaWQgdGhpcyAxMyB0aW1l
cyBidXQgbmV2ZXIgJiMzOTtzYXcmIzM5OyBhbnl0aGluZyBub3IgY29ubmVjdGVkLiBJZiBJIGRv
d24gdGhlbiB1cCB0aGUgaW50ZXJmYWNlIChpZmNvbmZpZyB3bGFuMCBkb3duOyBpZmNvbmZpZyB3
bGFuMCB1cCksIGl0IGltbWVkaWF0ZWx5IGNvbm5lY3RzLiBJIG5vdyBoYXZlIGEgc2NyaXB0IHRo
YXQgcnVucyB3aGVuIHRoZSBpbnRlcmZhY2UgZ29lcyBkb3duIHRvIGRvIHRoaXMgKGRvd24vdXAp
LCBidXQgc2hvdWxkbiYjMzk7dCBpd2QgZXZlbnR1YWxseSByZWNvbm5lY3Q/PGJyPjwvZGl2Pjxk
aXY+PGJyPjwvZGl2PjxkaXY+VGhpcyBjb250cmFzdHMgd2l0aCB0aGUgc2FtZSBjb21wdXRlciBy
dW5uaW5nIFJhc1BpT1MuIEl0IGlzIHJ1bm5pbmcgdGhlIHNhbWUga2VybmVsIGFuZCB0aGUgc2Ft
ZSBicm9hZGNvbSBmaXJtd2FyZSAoSSB1cGRhdGVkIGJvdGggdG8gYmUgaWRlbnRpY2FsKSBjb25u
bWFuIGlzIDEuMzYgYW5kIGl3ZCBpcyAwLjE0LCBidXQgaXQgd29ya3MgZXZlcnkgdGltZSBhbGwg
dGhlIHRpbWUuIEkgY2Fubm90IGdldCBpdCB0byBub3QgcmVjb25uZWN0LiBJbiBmYWN0IGl0IGNv
bm5lY3RzIGZhc3RlciB0aGFuIHRoZSB3ZWIgcGFnZSBmb3IgdGhlIHJvdXRlciByZWdpc3RlcnMg
aXQuIDxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkkgYnVpbHQgaXdkIDAuMTQgYW5kIGNv
bm5tYW4gMS4zNiBmb3IgdGhlIEFyY2ggaW5zdGFsbCBhbmQgaXQgYmVoYXZlcyB0aGUgc2FtZSBh
cyBpd2QgMS45IG9yIHRoZSBpd2QgZ2l0IG1hc3RlciBidWlsZC4gSXQganVzdCBxdWl0cy48YnI+
PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5XaGF0IHVuZGVybHlpbmcgT1MgaXNzdWVzIGNvdWxk
IGNhdXNlIHRoaXM/IEkgaGF2ZSBidWlsdCB0aGUga2VybmVsIHdpdGggdGhlIHNhbWUgY29uZmln
IG9wdGlvbnMgZm9yIGJvdGggaW5zdGFsbGF0aW9ucyB3aXRoIHRoZSBzYW1lIGNvbXB1dGVyIGRv
aW5nIHRoZSBidWlsZGluZy4gQm90aCBpbnN0YWxsYXRpb25zIGFyZSB1c2luZyB0aGUgc2FtZSBr
ZXJuZWwsIGZpcm13YXJlIGFuZCBkcml2ZXIgdmVyc2lvbiAoYnVpbHQgd2l0aCB0aGUga2VybmVs
KS48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PktlaXRoPGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2
PjwvZGl2Pgo=

--===============2986760677929753574==--

