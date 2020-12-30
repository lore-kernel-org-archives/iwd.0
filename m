Content-Type: multipart/mixed; boundary="===============1578440243569342040=="
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Subject: Re: [PATCH] doc: move EnableIPv6 under Network
Date: Wed, 30 Dec 2020 12:25:32 -0600
Message-ID: <CAG17S_MDtKWxmWaN0SO7ELS8X7ammR4M6kcDqUbinrzvBBvW+A@mail.gmail.com>
In-Reply-To: <2bcc7986-92ab-752a-9e5c-0e698ed44e9d@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1578440243569342040==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 30, 2020 at 11:56 AM Denis Kenzior <denkenz@gmail.com> wrote:

> Hi,
>
> On 12/27/20 7:34 AM, flokli(a)flokli.de wrote:
> > Last time I checked, IPv6 RA weren't supported yet. Is this still the
> case? Also, why does it default to `false`?
>
> Correct, IPV6 RAs are not yet supported.  And this is  the reason why IPV6
> is
> disabled by default.
>
> In iwd versions prior to 1.10 you could let iwd setup IPv4 aspects (using
> DHCPv4) and let the kernel handle RAs.  But, really, such a setup was
> broken
> because:
>    - kernel didn't know anything about route metrics to be used by iwd
>    - details obtained from RAs, like DNS, host names, etc were not
> configured
>    - Stateful (DHCPv6) configurations didn't work
>
> Certain setups may have appeared to work, but it was just pure luck.
> Given the
> above, and the fact that iwd's IPv6 support is not yet complete, the
> safest
> option was to disable it by default.
>
> Regards,
> -Denis
>
This is interesting to me. I am using connman and iwd (1.10) and have ipv6
enabled on my home network. On my RPi, the ipv6 addresses are listed:
The /etc/iwd/main.conf lists only:
[General]
UseDefaultInterface=3Dtrue
NameResolvingService=3Dresolvconf

There is nothing referencing ipv6 in connman's main.conf nor in the psk for
the AP I am using.  Yet, I get these addresses when iwd negotiates the
connection:

wlan0: flags=3D4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.2.41  netmask 255.255.255.0  broadcast 192.168.2.255
        inet6 fd21:98c8:1d28:0:ba27:xxff:fexx:xxxx  prefixlen 64  scopeid
0x0<global>
        inet6 fd21:98c8:1d28::41  prefixlen 64  scopeid 0x0<global>
        inet6 2600:1700:4320:6caf:ba27:xxff:fexx:xxxx  prefixlen 64
 scopeid 0x0<global>
        inet6 fe80::ba27:xxff:fexx:xxxx  prefixlen 64  scopeid 0x20<link>
        ether b8:27:xx:xx:xx:xx  txqueuelen 1000  (Ethernet)
        RX packets 11056898  bytes 8907204479 (8.2 GiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 3810279  bytes 415445265 (396.1 MiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

How should I disable it? Should I?

Keith

--===============1578440243569342040==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPk9uIFdlZCwg
RGVjIDMwLCAyMDIwIGF0IDExOjU2IEFNIERlbmlzIEtlbnppb3IgJmx0OzxhIGhyZWY9Im1haWx0
bzpkZW5rZW56QGdtYWlsLmNvbSI+ZGVua2VuekBnbWFpbC5jb208L2E+Jmd0OyB3cm90ZTo8YnI+
PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxibG9ja3F1b3RlIGNsYXNzPSJnbWFpbF9x
dW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoxcHggc29s
aWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij5IaSw8YnI+Cjxicj4KT24gMTIv
MjcvMjAgNzozNCBBTSwgPGEgaHJlZj0ibWFpbHRvOmZsb2tsaUBmbG9rbGkuZGUiIHRhcmdldD0i
X2JsYW5rIj5mbG9rbGlAZmxva2xpLmRlPC9hPiB3cm90ZTo8YnI+CiZndDsgTGFzdCB0aW1lIEkg
Y2hlY2tlZCwgSVB2NiBSQSB3ZXJlbiYjMzk7dCBzdXBwb3J0ZWQgeWV0LiBJcyB0aGlzIHN0aWxs
IHRoZSBjYXNlPyBBbHNvLCB3aHkgZG9lcyBpdCBkZWZhdWx0IHRvIGBmYWxzZWA/PGJyPgo8YnI+
CkNvcnJlY3QsIElQVjYgUkFzIGFyZSBub3QgeWV0IHN1cHBvcnRlZC7CoCBBbmQgdGhpcyBpc8Kg
IHRoZSByZWFzb24gd2h5IElQVjYgaXMgPGJyPgpkaXNhYmxlZCBieSBkZWZhdWx0Ljxicj4KPGJy
PgpJbiBpd2QgdmVyc2lvbnMgcHJpb3IgdG8gMS4xMCB5b3UgY291bGQgbGV0IGl3ZCBzZXR1cCBJ
UHY0IGFzcGVjdHMgKHVzaW5nIDxicj4KREhDUHY0KSBhbmQgbGV0IHRoZSBrZXJuZWwgaGFuZGxl
IFJBcy7CoCBCdXQsIHJlYWxseSwgc3VjaCBhIHNldHVwIHdhcyBicm9rZW4gPGJyPgpiZWNhdXNl
Ojxicj4KwqAgwqAtIGtlcm5lbCBkaWRuJiMzOTt0IGtub3cgYW55dGhpbmcgYWJvdXQgcm91dGUg
bWV0cmljcyB0byBiZSB1c2VkIGJ5IGl3ZDxicj4KwqAgwqAtIGRldGFpbHMgb2J0YWluZWQgZnJv
bSBSQXMsIGxpa2UgRE5TLCBob3N0IG5hbWVzLCBldGMgd2VyZSBub3QgY29uZmlndXJlZDxicj4K
wqAgwqAtIFN0YXRlZnVsIChESENQdjYpIGNvbmZpZ3VyYXRpb25zIGRpZG4mIzM5O3Qgd29yazxi
cj4KPGJyPgpDZXJ0YWluIHNldHVwcyBtYXkgaGF2ZSBhcHBlYXJlZCB0byB3b3JrLCBidXQgaXQg
d2FzIGp1c3QgcHVyZSBsdWNrLsKgIEdpdmVuIHRoZSA8YnI+CmFib3ZlLCBhbmQgdGhlIGZhY3Qg
dGhhdCBpd2QmIzM5O3MgSVB2NiBzdXBwb3J0IGlzIG5vdCB5ZXQgY29tcGxldGUsIHRoZSBzYWZl
c3QgPGJyPgpvcHRpb24gd2FzIHRvIGRpc2FibGUgaXQgYnkgZGVmYXVsdC48YnI+Cjxicj4KUmVn
YXJkcyw8YnI+Ci1EZW5pczxicj48L2Jsb2NrcXVvdGU+PGRpdj5UaGlzIGlzIGludGVyZXN0aW5n
IHRvIG1lLiBJIGFtIHVzaW5nIGNvbm5tYW4gYW5kIGl3ZCAoMS4xMCkgYW5kIGhhdmUgaXB2NiBl
bmFibGVkIG9uIG15IGhvbWUgbmV0d29yay4gT24gbXkgUlBpLCB0aGUgaXB2NiBhZGRyZXNzZXMg
YXJlIGxpc3RlZDo8L2Rpdj48ZGl2PlRoZSAvZXRjL2l3ZC9tYWluLmNvbmYgbGlzdHMgb25seTo8
L2Rpdj48ZGl2PltHZW5lcmFsXTxicj5Vc2VEZWZhdWx0SW50ZXJmYWNlPXRydWU8YnI+TmFtZVJl
c29sdmluZ1NlcnZpY2U9cmVzb2x2Y29uZjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+VGhlcmUg
aXMgbm90aGluZyByZWZlcmVuY2luZyBpcHY2IGluIGNvbm5tYW4mIzM5O3MgbWFpbi5jb25mIG5v
ciBpbiB0aGUgcHNrIGZvciB0aGUgQVAgSSBhbSB1c2luZy7CoCBZZXQsIEkgZ2V0IHRoZXNlIGFk
ZHJlc3NlcyB3aGVuIGl3ZCBuZWdvdGlhdGVzIHRoZSBjb25uZWN0aW9uOjwvZGl2PjxkaXY+PGJy
PjwvZGl2PjxkaXY+d2xhbjA6IGZsYWdzPTQxNjMmbHQ7VVAsQlJPQURDQVNULFJVTk5JTkcsTVVM
VElDQVNUJmd0OyDCoG10dSAxNTAwPGJyPsKgIMKgIMKgIMKgIGluZXQgMTkyLjE2OC4yLjQxIMKg
bmV0bWFzayAyNTUuMjU1LjI1NS4wIMKgYnJvYWRjYXN0IDE5Mi4xNjguMi4yNTU8YnI+wqAgwqAg
wqAgwqAgaW5ldDYgZmQyMTo5OGM4OjFkMjg6MDpiYTI3Onh4ZmY6ZmV4eDp4eHh4wqAgcHJlZml4
bGVuIDY0IMKgc2NvcGVpZCAweDAmbHQ7Z2xvYmFsJmd0Ozxicj7CoCDCoCDCoCDCoCBpbmV0NiBm
ZDIxOjk4Yzg6MWQyODo6NDEgwqBwcmVmaXhsZW4gNjQgwqBzY29wZWlkIDB4MCZsdDtnbG9iYWwm
Z3Q7PGJyPsKgIMKgIMKgIMKgIGluZXQ2IDI2MDA6MTcwMDo0MzIwOjZjYWY6YmEyNzp4eGZmOmZl
eHg6eHh4eMKgIHByZWZpeGxlbiA2NCDCoHNjb3BlaWQgMHgwJmx0O2dsb2JhbCZndDs8YnI+wqAg
wqAgwqAgwqAgaW5ldDYgZmU4MDo6YmEyNzp4eGZmOmZleHg6eHh4eMKgIHByZWZpeGxlbiA2NCDC
oHNjb3BlaWQgMHgyMCZsdDtsaW5rJmd0Ozxicj7CoCDCoCDCoCDCoCBldGhlciBiODoyNzp4eDp4
eDp4eDp4eMKgIHR4cXVldWVsZW4gMTAwMCDCoChFdGhlcm5ldCk8YnI+wqAgwqAgwqAgwqAgUlgg
cGFja2V0cyAxMTA1Njg5OCDCoGJ5dGVzIDg5MDcyMDQ0NzkgKDguMiBHaUIpPGJyPsKgIMKgIMKg
IMKgIFJYIGVycm9ycyAwIMKgZHJvcHBlZCAwIMKgb3ZlcnJ1bnMgMCDCoGZyYW1lIDA8YnI+wqAg
wqAgwqAgwqAgVFggcGFja2V0cyAzODEwMjc5IMKgYnl0ZXMgNDE1NDQ1MjY1ICgzOTYuMSBNaUIp
PGJyPsKgIMKgIMKgIMKgIFRYIGVycm9ycyAwIMKgZHJvcHBlZCAwIG92ZXJydW5zIDAgwqBjYXJy
aWVyIDAgwqBjb2xsaXNpb25zIDA8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkhvdyBzaG91bGQg
SSBkaXNhYmxlIGl0PyBTaG91bGQgST88L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PktlaXRoPGJy
PjwvZGl2PjxkaXY+PGJyPjwvZGl2PjwvZGl2PjwvZGl2Pgo=

--===============1578440243569342040==--

