Content-Type: multipart/mixed; boundary="===============5530277270547119634=="
MIME-Version: 1.0
From: Nicolas Prochazka <nicolas.prochazka at gmail.com>
To: iwd at lists.01.org
Subject: Re: iwd / wireless direct / P2P documentation
Date: Tue, 23 Nov 2021 10:04:22 +0100
Message-ID: <CADdae-hp3ckaAoPfWnjEt3Ug7DwXt_LNhEF70AJt+gxnDmAVrg@mail.gmail.com>
In-Reply-To: CAOq732KEN8HVDXEksH_DArx8wNwveFvDXLKMw_kx9G8=63jiKQ@mail.gmail.com

--===============5530277270547119634==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Ok,
thanks for your explanation.
Regards,
Nicolas.

Le lun. 22 nov. 2021 =C3=A0 15:58, Andrew Zaborowski <andrew.zaborowski(a)i=
ntel.com>
a =C3=A9crit :

> Hi Nicolas,
>
> On Mon, 22 Nov 2021 at 15:46, Nicolas Prochazka
> <nicolas.prochazka(a)gmail.com> wrote:
> > Hello,
> > Is there a tutorial or example for configuring two linux boxes in P2P
> mode with iwctl ?
>
> There isn't one and no P2P commands are available in iwctl at this
> time.  P2P is still work-in-progress in IWD but generally you need a
> program that implements a P2P service (similar to bluetooth profile)
> and that program can talk to IWD directly, so iwctl commands would not
> be useful.  Wi-Fi Display is the main service that is targeted.
>
> Technically you should be able to run the test/connect-p2p script on
> one machine without passing any peer name, and run:
>
> test/connect-p2p <first-machine's-name>
>
> on the other and that should give you an IP connection if successful.
> Both IWD instances need to have EnableNetworkConfiguration=3D1 in their
> main.conf.
>
> Best regards
>

--===============5530277270547119634==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+T2sswqA8ZGl2PnRoYW5rcyBmb3IgeW91ciBleHBsYW5hdGlvbi48L2Rp
dj48ZGl2PlJlZ2FyZHMswqA8L2Rpdj48ZGl2Pk5pY29sYXMuPC9kaXY+PC9kaXY+PGJyPjxkaXYg
Y2xhc3M9ImdtYWlsX3F1b3RlIj48ZGl2IGRpcj0ibHRyIiBjbGFzcz0iZ21haWxfYXR0ciI+TGXC
oGx1bi4gMjIgbm92LiAyMDIxIMOgwqAxNTo1OCwgQW5kcmV3IFphYm9yb3dza2kgJmx0OzxhIGhy
ZWY9Im1haWx0bzphbmRyZXcuemFib3Jvd3NraUBpbnRlbC5jb20iPmFuZHJldy56YWJvcm93c2tp
QGludGVsLmNvbTwvYT4mZ3Q7IGEgw6ljcml0wqA6PGJyPjwvZGl2PjxibG9ja3F1b3RlIGNsYXNz
PSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVm
dDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij5IaSBOaWNvbGFz
LDxicj4KPGJyPgpPbiBNb24sIDIyIE5vdiAyMDIxIGF0IDE1OjQ2LCBOaWNvbGFzIFByb2NoYXpr
YTxicj4KJmx0OzxhIGhyZWY9Im1haWx0bzpuaWNvbGFzLnByb2NoYXprYUBnbWFpbC5jb20iIHRh
cmdldD0iX2JsYW5rIj5uaWNvbGFzLnByb2NoYXprYUBnbWFpbC5jb208L2E+Jmd0OyB3cm90ZTo8
YnI+CiZndDsgSGVsbG8sPGJyPgomZ3Q7IElzIHRoZXJlIGEgdHV0b3JpYWwgb3IgZXhhbXBsZSBm
b3IgY29uZmlndXJpbmcgdHdvIGxpbnV4IGJveGVzIGluIFAyUCBtb2RlIHdpdGggaXdjdGwgPzxi
cj4KPGJyPgpUaGVyZSBpc24mIzM5O3Qgb25lIGFuZCBubyBQMlAgY29tbWFuZHMgYXJlIGF2YWls
YWJsZSBpbiBpd2N0bCBhdCB0aGlzPGJyPgp0aW1lLsKgIFAyUCBpcyBzdGlsbCB3b3JrLWluLXBy
b2dyZXNzIGluIElXRCBidXQgZ2VuZXJhbGx5IHlvdSBuZWVkIGE8YnI+CnByb2dyYW0gdGhhdCBp
bXBsZW1lbnRzIGEgUDJQIHNlcnZpY2UgKHNpbWlsYXIgdG8gYmx1ZXRvb3RoIHByb2ZpbGUpPGJy
PgphbmQgdGhhdCBwcm9ncmFtIGNhbiB0YWxrIHRvIElXRCBkaXJlY3RseSwgc28gaXdjdGwgY29t
bWFuZHMgd291bGQgbm90PGJyPgpiZSB1c2VmdWwuwqAgV2ktRmkgRGlzcGxheSBpcyB0aGUgbWFp
biBzZXJ2aWNlIHRoYXQgaXMgdGFyZ2V0ZWQuPGJyPgo8YnI+ClRlY2huaWNhbGx5IHlvdSBzaG91
bGQgYmUgYWJsZSB0byBydW4gdGhlIHRlc3QvY29ubmVjdC1wMnAgc2NyaXB0IG9uPGJyPgpvbmUg
bWFjaGluZSB3aXRob3V0IHBhc3NpbmcgYW55IHBlZXIgbmFtZSwgYW5kIHJ1bjo8YnI+Cjxicj4K
dGVzdC9jb25uZWN0LXAycCAmbHQ7Zmlyc3QtbWFjaGluZSYjMzk7cy1uYW1lJmd0Ozxicj4KPGJy
PgpvbiB0aGUgb3RoZXIgYW5kIHRoYXQgc2hvdWxkIGdpdmUgeW91IGFuIElQIGNvbm5lY3Rpb24g
aWYgc3VjY2Vzc2Z1bC48YnI+CkJvdGggSVdEIGluc3RhbmNlcyBuZWVkIHRvIGhhdmUgRW5hYmxl
TmV0d29ya0NvbmZpZ3VyYXRpb249MSBpbiB0aGVpcjxicj4KbWFpbi5jb25mLjxicj4KPGJyPgpC
ZXN0IHJlZ2FyZHM8YnI+CjwvYmxvY2txdW90ZT48L2Rpdj4K

--===============5530277270547119634==--

