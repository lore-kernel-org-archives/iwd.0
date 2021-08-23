Content-Type: multipart/mixed; boundary="===============7553305813699328214=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: Failed to connect to WPA3 network after update to iwd 1.16
Date: Mon, 23 Aug 2021 13:02:33 -0700
Message-ID: <1fb184f06d36da9b70c73c0bc4283f94076e8e16.camel@gmail.com>
In-Reply-To: <CAJtNWJg_sp_kM_Ag0PHibv2tqjN5zMCrKJ-0aO1gfXDqU9pOtg@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7553305813699328214==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alex,

> =

> On Mon, 23 Aug 2021 at 18:21, James Prestwood <prestwoj@gmail.com>
> wrote:
> > Hi Alex,
> > =

> > On Sun, 2021-08-22 at 04:47 +0100, Alex Cepoi wrote:
> > > Hi everyone,
> > > =

> > > I'm having trouble connecting to a WPA3 network after updating
> > > from 1.15 to 1.16. Can reproduce consistently (100% success rate
> > > on 1.15, 0% success rate on 1.16).
> > > =

> > > You can see debug logs before and after in
> > >
> > https://gist.github.com/alexcepoi/eef301a56e5e40826a8a416cbfb684e6
> > > =

> > > Diff shows some new "SAE Hunting and Pecking" algorithm used and
> > > a "AP did not include group number in response!" info, though not
> > > sure if related.

In your case the effective difference between IWD 1.16 and 1.15 is that
we now try SAE groups in decending order. This is because higher group
numbers are more secure. BUT the only group that is required for a
device to support is group 19, which it seems your AP falls under. So
we have this situation where we try group 20, fail, then try 19, but
something else goes wrong.

We don't think IWD is behaving out of what the spec requries in this
situation (and we even test for this rejected group scenario) but there
are several red flag commits in hostapd from 2018/2019 which describe
fixing some behavior that sounds similar to this. Its difficult to know
because we don't have your AP's hostapd or kernel version to try out
ourselves.

tl;dr

We think we can 'fix' this by simply using group 19 by default (or a
config option) but thats not optimal since you really want to use the
most secure group if it is available. What we can do to verify that
your AP is to blame is try wpa_supplicant and include this option:

sae_groups=3D20 19

This *should* try group 20 first and behave similarly to IWD. If this
also results in the same issue we know the AP is to blame. Knowing this
will at least give us some justification for adding a config option as
a fix.

Thanks,
James


--===============7553305813699328214==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGh0bWw+PGhlYWQ+PC9oZWFkPjxib2R5PjxkaXY+SGkgQWxleCw8L2Rpdj48ZGl2Pjxicj48L2Rp
dj48YmxvY2txdW90ZSB0eXBlPSJjaXRlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7IGJvcmRl
ci1sZWZ0OjJweCAjNzI5ZmNmIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPjxkaXY+PGJyPjxkaXYg
Y2xhc3M9ImdtYWlsX3F1b3RlIj48ZGl2IGRpcj0ibHRyIiBjbGFzcz0iZ21haWxfYXR0ciI+T24g
TW9uLCAyMyBBdWcgMjAyMSBhdCAxODoyMSwgSmFtZXMgUHJlc3R3b29kICZsdDs8YSBocmVmPSJt
YWlsdG86cHJlc3R3b2pAZ21haWwuY29tIiB0YXJnZXQ9Il9ibGFuayI+cHJlc3R3b2pAZ21haWwu
Y29tPC9hPiZndDsgd3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1b3RlIHR5cGU9ImNpdGUiIHN0eWxl
PSJtYXJnaW46MCAwIDAgLjhleDsgYm9yZGVyLWxlZnQ6MnB4ICM3MjlmY2Ygc29saWQ7cGFkZGlu
Zy1sZWZ0OjFleCI+PGRpdj48ZGl2PkhpIEFsZXgsPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5P
biBTdW4sIDIwMjEtMDgtMjIgYXQgMDQ6NDcgKzAxMDAsIEFsZXggQ2Vwb2kgd3JvdGU6PC9kaXY+
PGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4OyBib3JkZXIt
bGVmdDoycHggIzcyOWZjZiBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij48ZGl2IGRpcj0ibHRyIj5I
aSBldmVyeW9uZSw8YnI+PGJyPkknbSBoYXZpbmcgdHJvdWJsZSBjb25uZWN0aW5nIHRvIGEgV1BB
MyBuZXR3b3JrIGFmdGVyIHVwZGF0aW5nIGZyb20gMS4xNSB0byAxLjE2LiBDYW4gcmVwcm9kdWNl
IGNvbnNpc3RlbnRseSAoMTAwJSBzdWNjZXNzIHJhdGUgb24gMS4xNSwgMCUgc3VjY2VzcyByYXRl
IG9uIDEuMTYpLjxicj48YnI+WW91IGNhbiBzZWUgZGVidWcgbG9ncyBiZWZvcmUgYW5kIGFmdGVy
IGluIDxhIGhyZWY9Imh0dHBzOi8vZ2lzdC5naXRodWIuY29tL2FsZXhjZXBvaS9lZWYzMDFhNTZl
NWU0MDgyNmE4YTQxNmNiZmI2ODRlNiIgdGFyZ2V0PSJfYmxhbmsiPmh0dHBzOi8vZ2lzdC5naXRo
dWIuY29tL2FsZXhjZXBvaS9lZWYzMDFhNTZlNWU0MDgyNmE4YTQxNmNiZmI2ODRlNjwvYT48YnI+
PGJyPkRpZmYgc2hvd3Mgc29tZSBuZXcgIlNBRSBIdW50aW5nIGFuZCBQZWNraW5nIiBhbGdvcml0
aG0gdXNlZCBhbmQgYSAiQVAgZGlkIG5vdCBpbmNsdWRlIGdyb3VwIG51bWJlciBpbiByZXNwb25z
ZSEiIGluZm8sIHRob3VnaCBub3Qgc3VyZSBpZiByZWxhdGVkLjwvZGl2PjwvYmxvY2txdW90ZT48
L2Rpdj48L2Jsb2NrcXVvdGU+PC9kaXY+PC9kaXY+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2
PjxkaXY+SW4geW91ciBjYXNlIHRoZSBlZmZlY3RpdmUgZGlmZmVyZW5jZSBiZXR3ZWVuIElXRCAx
LjE2IGFuZCAxLjE1IGlzIHRoYXQgd2Ugbm93IHRyeSBTQUUgZ3JvdXBzIGluIGRlY2VuZGluZyBv
cmRlci4gVGhpcyBpcyBiZWNhdXNlIGhpZ2hlciBncm91cCBudW1iZXJzIGFyZSBtb3JlIHNlY3Vy
ZS4gQlVUIHRoZSBvbmx5IGdyb3VwIHRoYXQgaXMgcmVxdWlyZWQgZm9yIGEgZGV2aWNlIHRvIHN1
cHBvcnQgaXMgZ3JvdXAgMTksIHdoaWNoIGl0IHNlZW1zIHlvdXIgQVAgZmFsbHMgdW5kZXIuIFNv
IHdlIGhhdmUgdGhpcyBzaXR1YXRpb24gd2hlcmUgd2UgdHJ5IGdyb3VwIDIwLCBmYWlsLCB0aGVu
IHRyeSAxOSwgYnV0IHNvbWV0aGluZyBlbHNlIGdvZXMgd3JvbmcuPC9kaXY+PGRpdj48YnI+PC9k
aXY+PGRpdj5XZSBkb24ndCB0aGluayBJV0QgaXMgYmVoYXZpbmcgb3V0IG9mIHdoYXQgdGhlIHNw
ZWMgcmVxdXJpZXMgaW4gdGhpcyBzaXR1YXRpb24gKGFuZCB3ZSBldmVuIHRlc3QgZm9yIHRoaXMg
cmVqZWN0ZWQgZ3JvdXAgc2NlbmFyaW8pIGJ1dCB0aGVyZSBhcmUgc2V2ZXJhbCByZWQgZmxhZyBj
b21taXRzIGluIGhvc3RhcGQgZnJvbSAyMDE4LzIwMTkgd2hpY2ggZGVzY3JpYmUgZml4aW5nIHNv
bWUgYmVoYXZpb3IgdGhhdCBzb3VuZHMgc2ltaWxhciB0byB0aGlzLiBJdHMgZGlmZmljdWx0IHRv
IGtub3cgYmVjYXVzZSB3ZSBkb24ndCBoYXZlIHlvdXIgQVAncyBob3N0YXBkIG9yIGtlcm5lbCB2
ZXJzaW9uIHRvIHRyeSBvdXQgb3Vyc2VsdmVzLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+dGw7
ZHI8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PldlIHRoaW5rIHdlIGNhbiAnZml4JyB0aGlzIGJ5
IHNpbXBseSB1c2luZyBncm91cCAxOSBieSBkZWZhdWx0IChvciBhIGNvbmZpZyBvcHRpb24pIGJ1
dCB0aGF0cyBub3Qgb3B0aW1hbCBzaW5jZSB5b3UgcmVhbGx5IHdhbnQgdG8gdXNlIHRoZSBtb3N0
IHNlY3VyZSBncm91cCBpZiBpdCBpcyBhdmFpbGFibGUuIFdoYXQgd2UgY2FuIGRvIHRvIHZlcmlm
eSB0aGF0IHlvdXIgQVAgaXMgdG8gYmxhbWUgaXMgdHJ5IHdwYV9zdXBwbGljYW50IGFuZCBpbmNs
dWRlIHRoaXMgb3B0aW9uOjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+c2FlX2dyb3Vwcz0yMCAx
OTwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+VGhpcyAqc2hvdWxkKiB0cnkgZ3JvdXAgMjAgZmly
c3QgYW5kIGJlaGF2ZSBzaW1pbGFybHkgdG8gSVdELiBJZiB0aGlzIGFsc28gcmVzdWx0cyBpbiB0
aGUgc2FtZSBpc3N1ZSB3ZSBrbm93IHRoZSBBUCBpcyB0byBibGFtZS4gS25vd2luZyB0aGlzIHdp
bGwgYXQgbGVhc3QgZ2l2ZSB1cyBzb21lIGp1c3RpZmljYXRpb24gZm9yIGFkZGluZyBhIGNvbmZp
ZyBvcHRpb24gYXMgYSBmaXguPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5UaGFua3MsPC9kaXY+
PGRpdj5KYW1lczwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PHNwYW4+PC9zcGFuPjwvZGl2Pjwv
Ym9keT48L2h0bWw+Cg==

--===============7553305813699328214==--

