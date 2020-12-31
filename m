Content-Type: multipart/mixed; boundary="===============0242168185796724510=="
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Subject: Re: [PATCH] doc: move EnableIPv6 under Network
Date: Wed, 30 Dec 2020 19:17:28 -0600
Message-ID: <CAG17S_OOqVbDXtLd_vhYVDrY-yYXaKZbfHHNwtVS7B929mMUUw@mail.gmail.com>
In-Reply-To: <bf3d6182-2e56-786a-fbea-1dde4ec4d1e7@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0242168185796724510==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 30, 2020 at 12:35 PM Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Keith,
>
> > This is interesting to me. I am using connman and iwd (1.10) and have
> ipv6
>
> If you're using connman, then this discussion isn't really relevant for
> you.
> You should let connman manage IPv4/IPv6 details.
>
> > enabled on my home network. On my RPi, the ipv6 addresses are listed:
> > The /etc/iwd/main.conf lists only:
> > [General]
> > UseDefaultInterface=3Dtrue
> > NameResolvingService=3Dresolvconf
>
> In fact, this setting is useless without EnableNetworkConfiguration=3DTru=
e.
> And
> you should NOT set it if you're using connman.  EnableNetworkConfiguration
> and
> NameResolvingService are only needed if you're running iwd standalone or
> do not
> want to use an external network manager, like NM/connman/networkd, for
> managing
> wifi connections.
>
> >
> > There is nothing referencing ipv6 in connman's main.conf nor in the psk
> for the
> > AP I am using.  Yet, I get these addresses when iwd negotiates the
> connection:
> >
> > wlan0: flags=3D4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
> >          inet 192.168.2.41  netmask 255.255.255.0  broadcast
> 192.168.2.255
> >          inet6 fd21:98c8:1d28:0:ba27:xxff:fexx:xxxx  prefixlen 64
>  scopeid
> > 0x0<global>
> >          inet6 fd21:98c8:1d28::41  prefixlen 64  scopeid 0x0<global>
> >          inet6 2600:1700:4320:6caf:ba27:xxff:fexx:xxxx  prefixlen 64
>  scopeid
> > 0x0<global>
> >          inet6 fe80::ba27:xxff:fexx:xxxx  prefixlen 64  scopeid
> 0x20<link>
> >          ether b8:27:xx:xx:xx:xx  txqueuelen 1000  (Ethernet)
> >          RX packets 11056898  bytes 8907204479 (8.2 GiB)
> >          RX errors 0  dropped 0  overruns 0  frame 0
> >          TX packets 3810279  bytes 415445265 (396.1 MiB)
> >          TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
> >
> > How should I disable it? Should I?
>
> That is a question for the connman mailing list.  iwd isn't doing any
> network
> configuration in your case.
>
> Regards,
> -Denis
>

Denis,

Got it! Thanks for the clarification.

--===============0242168185796724510==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPk9uIFdlZCwg
RGVjIDMwLCAyMDIwIGF0IDEyOjM1IFBNIERlbmlzIEtlbnppb3IgJmx0OzxhIGhyZWY9Im1haWx0
bzpkZW5rZW56QGdtYWlsLmNvbSI+ZGVua2VuekBnbWFpbC5jb208L2E+Jmd0OyB3cm90ZTo8YnI+
PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9x
dW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29s
aWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij5IaSBLZWl0aCw8YnI+Cjxicj4K
Jmd0OyBUaGlzIGlzIGludGVyZXN0aW5nIHRvIG1lLiBJIGFtIHVzaW5nIGNvbm5tYW4gYW5kIGl3
ZCAoMS4xMCkgYW5kIGhhdmUgaXB2NiA8YnI+Cjxicj4KSWYgeW91JiMzOTtyZSB1c2luZyBjb25u
bWFuLCB0aGVuIHRoaXMgZGlzY3Vzc2lvbiBpc24mIzM5O3QgcmVhbGx5IHJlbGV2YW50IGZvciB5
b3UuIDxicj4KWW91IHNob3VsZCBsZXQgY29ubm1hbiBtYW5hZ2UgSVB2NC9JUHY2IGRldGFpbHMu
PGJyPgo8YnI+CiZndDsgZW5hYmxlZCBvbiBteSBob21lIG5ldHdvcmsuIE9uIG15IFJQaSwgdGhl
IGlwdjYgYWRkcmVzc2VzIGFyZSBsaXN0ZWQ6PGJyPgomZ3Q7IFRoZSAvZXRjL2l3ZC9tYWluLmNv
bmYgbGlzdHMgb25seTo8YnI+CiZndDsgW0dlbmVyYWxdPGJyPgomZ3Q7IFVzZURlZmF1bHRJbnRl
cmZhY2U9dHJ1ZTxicj4KJmd0OyBOYW1lUmVzb2x2aW5nU2VydmljZT1yZXNvbHZjb25mPGJyPgo8
YnI+CkluIGZhY3QsIHRoaXMgc2V0dGluZyBpcyB1c2VsZXNzIHdpdGhvdXQgRW5hYmxlTmV0d29y
a0NvbmZpZ3VyYXRpb249VHJ1ZS7CoCBBbmQgPGJyPgp5b3Ugc2hvdWxkIE5PVCBzZXQgaXQgaWYg
eW91JiMzOTtyZSB1c2luZyBjb25ubWFuLsKgIEVuYWJsZU5ldHdvcmtDb25maWd1cmF0aW9uIGFu
ZCA8YnI+Ck5hbWVSZXNvbHZpbmdTZXJ2aWNlIGFyZSBvbmx5IG5lZWRlZCBpZiB5b3UmIzM5O3Jl
IHJ1bm5pbmcgaXdkIHN0YW5kYWxvbmUgb3IgZG8gbm90IDxicj4Kd2FudCB0byB1c2UgYW4gZXh0
ZXJuYWwgbmV0d29yayBtYW5hZ2VyLCBsaWtlIE5NL2Nvbm5tYW4vbmV0d29ya2QsIGZvciBtYW5h
Z2luZyA8YnI+CndpZmkgY29ubmVjdGlvbnMuPGJyPgo8YnI+CiZndDsgPGJyPgomZ3Q7IFRoZXJl
IGlzIG5vdGhpbmcgcmVmZXJlbmNpbmcgaXB2NiBpbiBjb25ubWFuJiMzOTtzIG1haW4uY29uZiBu
b3IgaW4gdGhlIHBzayBmb3IgdGhlIDxicj4KJmd0OyBBUCBJIGFtIHVzaW5nLsKgIFlldCwgSSBn
ZXQgdGhlc2UgYWRkcmVzc2VzIHdoZW4gaXdkIG5lZ290aWF0ZXMgdGhlIGNvbm5lY3Rpb246PGJy
PgomZ3Q7IDxicj4KJmd0OyB3bGFuMDogZmxhZ3M9NDE2MyZsdDtVUCxCUk9BRENBU1QsUlVOTklO
RyxNVUxUSUNBU1QmZ3Q7IMKgbXR1IDE1MDA8YnI+CiZndDvCoCDCoCDCoCDCoCDCoCBpbmV0IDE5
Mi4xNjguMi40MSDCoG5ldG1hc2sgMjU1LjI1NS4yNTUuMCDCoGJyb2FkY2FzdCAxOTIuMTY4LjIu
MjU1PGJyPgomZ3Q7wqAgwqAgwqAgwqAgwqAgaW5ldDYgZmQyMTo5OGM4OjFkMjg6MDpiYTI3Onh4
ZmY6ZmV4eDp4eHh4wqAgcHJlZml4bGVuIDY0IMKgc2NvcGVpZCA8YnI+CiZndDsgMHgwJmx0O2ds
b2JhbCZndDs8YnI+CiZndDvCoCDCoCDCoCDCoCDCoCBpbmV0NiBmZDIxOjk4Yzg6MWQyODo6NDEg
wqBwcmVmaXhsZW4gNjQgwqBzY29wZWlkIDB4MCZsdDtnbG9iYWwmZ3Q7PGJyPgomZ3Q7wqAgwqAg
wqAgwqAgwqAgaW5ldDYgMjYwMDoxNzAwOjQzMjA6NmNhZjpiYTI3Onh4ZmY6ZmV4eDp4eHh4wqAg
cHJlZml4bGVuIDY0IMKgc2NvcGVpZCA8YnI+CiZndDsgMHgwJmx0O2dsb2JhbCZndDs8YnI+CiZn
dDvCoCDCoCDCoCDCoCDCoCBpbmV0NiBmZTgwOjpiYTI3Onh4ZmY6ZmV4eDp4eHh4wqAgcHJlZml4
bGVuIDY0IMKgc2NvcGVpZCAweDIwJmx0O2xpbmsmZ3Q7PGJyPgomZ3Q7wqAgwqAgwqAgwqAgwqAg
ZXRoZXIgYjg6Mjc6eHg6eHg6eHg6eHjCoCB0eHF1ZXVlbGVuIDEwMDAgwqAoRXRoZXJuZXQpPGJy
PgomZ3Q7wqAgwqAgwqAgwqAgwqAgUlggcGFja2V0cyAxMTA1Njg5OCDCoGJ5dGVzIDg5MDcyMDQ0
NzkgKDguMiBHaUIpPGJyPgomZ3Q7wqAgwqAgwqAgwqAgwqAgUlggZXJyb3JzIDAgwqBkcm9wcGVk
IDAgwqBvdmVycnVucyAwIMKgZnJhbWUgMDxicj4KJmd0O8KgIMKgIMKgIMKgIMKgIFRYIHBhY2tl
dHMgMzgxMDI3OSDCoGJ5dGVzIDQxNTQ0NTI2NSAoMzk2LjEgTWlCKTxicj4KJmd0O8KgIMKgIMKg
IMKgIMKgIFRYIGVycm9ycyAwIMKgZHJvcHBlZCAwIG92ZXJydW5zIDAgwqBjYXJyaWVyIDAgwqBj
b2xsaXNpb25zIDA8YnI+CiZndDsgPGJyPgomZ3Q7IEhvdyBzaG91bGQgSSBkaXNhYmxlIGl0PyBT
aG91bGQgST88YnI+Cjxicj4KVGhhdCBpcyBhIHF1ZXN0aW9uIGZvciB0aGUgY29ubm1hbiBtYWls
aW5nIGxpc3QuwqAgaXdkIGlzbiYjMzk7dCBkb2luZyBhbnkgbmV0d29yayA8YnI+CmNvbmZpZ3Vy
YXRpb24gaW4geW91ciBjYXNlLjxicj4KPGJyPgpSZWdhcmRzLDxicj4KLURlbmlzPGJyPjwvYmxv
Y2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2PkRlbmlzLDwvZGl2PjxkaXY+IDxicj48L2Rpdj48
ZGl2PgpHb3QgaXQhIFRoYW5rcyBmb3IgdGhlIGNsYXJpZmljYXRpb24uwqAgPGJyPjwvZGl2Pjwv
ZGl2PjwvZGl2Pgo=

--===============0242168185796724510==--

