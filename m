Content-Type: multipart/mixed; boundary="===============8031883147307419818=="
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Subject: Re: broadcom fmac ap mode testing - how to set iwd as dhcp server?
Date: Sat, 30 Jan 2021 14:25:09 -0600
Message-ID: <CAG17S_OG84KADM-HVK12DHYf2o_pGqeZa-iGY1Y-feHFTCMgCQ@mail.gmail.com>
In-Reply-To: <00ac4f92-db56-32ee-66db-27697823ef5d@molgen.mpg.de>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8031883147307419818==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

it lives! This is the latest git built as
iwd-git-r5142.065f19b-1-aarch64.pkg.tar.xz on Arch running  on a RPiB3+

I have not tried using the iwd network management, but when I use connman,
I can create a 'tether' interface and connect to it.
This starts it on 192.168.0.1
connmanctl tether wifi on myssid password
this stops it.
connmanctl tether wlan0 off

I'll try iwd alone next, but this is a great development for the
RaspberryPi community, IMO.

Thanks!

On Sat, Jan 30, 2021 at 5:47 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:

>
> Dear James, Dear Keith,
>
>
> Am 29.01.21 um 02:37 schrieb James Prestwood:
>
> > <snip>
> >> When I restart the AP from iwctl, I can connect again.
> >> What I do not yet know how to do, though, is assign an ip address to
> >> the ap and then have it be a dhcp server to serve out a dhcp address
> >> to the connecting computer. I found this online and took a stab, but
> >> it did not assign an address, though the computer did 'attach'.
> >
> > Yes this is exactly the behavior we are seeing as well. I do have a
> > patch which fixes the disconnect issue and allows the same client to
> > connect again but we've actually got more problems than this. My recent
> > patches 'fixing' AP mode is somewhat of a hack in all honesty. It
> > allows the 4-way handshake to happen but not the GTK handshake. This
> > means no group traffic which breaks DHCP.
> >
> > I won't bore you with details but it boils down to brcmfmac being (as
> > far as we can tell) broken when used this way.
>
> Are the Linux kernel subsystem maintainers (BROADCOM BRCM80211
> IEEE802.11n WIRELESS DRIVER) aware of this issue?
>
> > We are going to investigate handshake offloading which might fix it,
> > but we just don't know yet. I am expecting offloading to work  but if
> > not we need to talk with linux-wireless/broadcom about why its broken
> > or how it supposed to work. Anyways, we hope to have this sorted
> > soon.
> [=E2=80=A6]
>
>
> Kind regards,
>
> Paul
>

--===============8031883147307419818==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+PGRpdj5pdCBsaXZlcyEgVGhpcyBpcyB0aGUgbGF0ZXN0IGdpdCBidWls
dCBhcyBpd2QtZ2l0LXI1MTQyLjA2NWYxOWItMS1hYXJjaDY0LnBrZy50YXIueHogb24gQXJjaCBy
dW5uaW5nwqAgb24gYSBSUGlCMys8YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5JIGhhdmUg
bm90IHRyaWVkIHVzaW5nIHRoZSBpd2QgbmV0d29yayBtYW5hZ2VtZW50LCBidXQgd2hlbiBJIHVz
ZSBjb25ubWFuLCBJIGNhbiBjcmVhdGUgYSAmIzM5O3RldGhlciYjMzk7IGludGVyZmFjZSBhbmQg
Y29ubmVjdCB0byBpdC48L2Rpdj48ZGl2PlRoaXMgc3RhcnRzIGl0IG9uIDE5Mi4xNjguMC4xPGJy
PjwvZGl2PjxkaXY+Y29ubm1hbmN0bCB0ZXRoZXIgd2lmaSBvbiBteXNzaWQgcGFzc3dvcmQ8L2Rp
dj48ZGl2PnRoaXMgc3RvcHMgaXQuIDxicj48L2Rpdj48ZGl2PmNvbm5tYW5jdGwgdGV0aGVyIHds
YW4wIG9mZjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+SSYjMzk7bGwgdHJ5IGl3ZCBhbG9uZSBu
ZXh0LCBidXQgdGhpcyBpcyBhIGdyZWF0IGRldmVsb3BtZW50IGZvciB0aGUgUmFzcGJlcnJ5UGkg
Y29tbXVuaXR5LCBJTU8uPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5UaGFua3MhPGJyPjwvZGl2
PjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9
ImdtYWlsX2F0dHIiPk9uIFNhdCwgSmFuIDMwLCAyMDIxIGF0IDU6NDcgQU0gUGF1bCBNZW56ZWwg
Jmx0OzxhIGhyZWY9Im1haWx0bzpwbWVuemVsQG1vbGdlbi5tcGcuZGUiPnBtZW56ZWxAbW9sZ2Vu
Lm1wZy5kZTwvYT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxf
cXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNv
bGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+PGJyPgpEZWFyIEphbWVzLCBE
ZWFyIEtlaXRoLDxicj4KPGJyPgo8YnI+CkFtIDI5LjAxLjIxIHVtIDAyOjM3IHNjaHJpZWIgSmFt
ZXMgUHJlc3R3b29kOjxicj4KPGJyPgomZ3Q7ICZsdDtzbmlwJmd0Ozxicj4KJmd0OyZndDsgV2hl
biBJIHJlc3RhcnQgdGhlIEFQIGZyb20gaXdjdGwsIEkgY2FuIGNvbm5lY3QgYWdhaW4uPGJyPgom
Z3Q7Jmd0OyBXaGF0IEkgZG8gbm90IHlldCBrbm93IGhvdyB0byBkbywgdGhvdWdoLCBpcyBhc3Np
Z24gYW4gaXAgYWRkcmVzcyB0bzxicj4KJmd0OyZndDsgdGhlIGFwIGFuZCB0aGVuIGhhdmUgaXQg
YmUgYSBkaGNwIHNlcnZlciB0byBzZXJ2ZSBvdXQgYSBkaGNwIGFkZHJlc3M8YnI+CiZndDsmZ3Q7
IHRvIHRoZSBjb25uZWN0aW5nIGNvbXB1dGVyLiBJIGZvdW5kIHRoaXMgb25saW5lIGFuZCB0b29r
IGEgc3RhYiwgYnV0PGJyPgomZ3Q7Jmd0OyBpdCBkaWQgbm90IGFzc2lnbiBhbiBhZGRyZXNzLCB0
aG91Z2ggdGhlIGNvbXB1dGVyIGRpZCAmIzM5O2F0dGFjaCYjMzk7Ljxicj4KJmd0OyA8YnI+CiZn
dDsgWWVzIHRoaXMgaXMgZXhhY3RseSB0aGUgYmVoYXZpb3Igd2UgYXJlIHNlZWluZyBhcyB3ZWxs
LiBJIGRvIGhhdmUgYTxicj4KJmd0OyBwYXRjaCB3aGljaCBmaXhlcyB0aGUgZGlzY29ubmVjdCBp
c3N1ZSBhbmQgYWxsb3dzIHRoZSBzYW1lIGNsaWVudCB0bzxicj4KJmd0OyBjb25uZWN0IGFnYWlu
IGJ1dCB3ZSYjMzk7dmUgYWN0dWFsbHkgZ290IG1vcmUgcHJvYmxlbXMgdGhhbiB0aGlzLiBNeSBy
ZWNlbnQ8YnI+CiZndDsgcGF0Y2hlcyAmIzM5O2ZpeGluZyYjMzk7IEFQIG1vZGUgaXMgc29tZXdo
YXQgb2YgYSBoYWNrIGluIGFsbCBob25lc3R5LiBJdDxicj4KJmd0OyBhbGxvd3MgdGhlIDQtd2F5
IGhhbmRzaGFrZSB0byBoYXBwZW4gYnV0IG5vdCB0aGUgR1RLIGhhbmRzaGFrZS4gVGhpczxicj4K
Jmd0OyBtZWFucyBubyBncm91cCB0cmFmZmljIHdoaWNoIGJyZWFrcyBESENQLjxicj4KJmd0OyA8
YnI+CiZndDsgSSB3b24mIzM5O3QgYm9yZSB5b3Ugd2l0aCBkZXRhaWxzIGJ1dCBpdCBib2lscyBk
b3duIHRvIGJyY21mbWFjIGJlaW5nIChhczxicj4KJmd0OyBmYXIgYXMgd2UgY2FuIHRlbGwpIGJy
b2tlbiB3aGVuIHVzZWQgdGhpcyB3YXkuPGJyPgo8YnI+CkFyZSB0aGUgTGludXgga2VybmVsIHN1
YnN5c3RlbSBtYWludGFpbmVycyAoQlJPQURDT00gQlJDTTgwMjExIDxicj4KSUVFRTgwMi4xMW4g
V0lSRUxFU1MgRFJJVkVSKSBhd2FyZSBvZiB0aGlzIGlzc3VlPzxicj4KPGJyPgomZ3Q7IFdlIGFy
ZSBnb2luZyB0byBpbnZlc3RpZ2F0ZSBoYW5kc2hha2Ugb2ZmbG9hZGluZyB3aGljaCBtaWdodCBm
aXggaXQsPGJyPgomZ3Q7IGJ1dCB3ZSBqdXN0IGRvbiYjMzk7dCBrbm93IHlldC4gSSBhbSBleHBl
Y3Rpbmcgb2ZmbG9hZGluZyB0byB3b3JrwqAgYnV0IGlmPGJyPgomZ3Q7IG5vdCB3ZSBuZWVkIHRv
IHRhbGsgd2l0aCBsaW51eC13aXJlbGVzcy9icm9hZGNvbSBhYm91dCB3aHkgaXRzIGJyb2tlbjxi
cj4KJmd0OyBvciBob3cgaXQgc3VwcG9zZWQgdG8gd29yay4gQW55d2F5cywgd2UgaG9wZSB0byBo
YXZlIHRoaXMgc29ydGVkPGJyPgomZ3Q7IHNvb24uPGJyPgpb4oCmXTxicj4KPGJyPgo8YnI+Cktp
bmQgcmVnYXJkcyw8YnI+Cjxicj4KUGF1bDxicj4KPC9ibG9ja3F1b3RlPjwvZGl2Pgo=

--===============8031883147307419818==--

