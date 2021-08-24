Content-Type: multipart/mixed; boundary="===============7815942203043167979=="
MIME-Version: 1.0
From: Alex Cepoi <alex.cepoi@gmail.com>
Subject: Re: Failed to connect to WPA3 network after update to iwd 1.16
Date: Tue, 24 Aug 2021 20:03:40 +0100
Message-ID: <CAJtNWJjeJELvqYTNDdB-ONmLQTeyh6e-1+Uozq2=df-vf6G6XA@mail.gmail.com>
In-Reply-To: <167030ac73b3954da3b1f2e3c4c3d7760e9534bf.camel@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7815942203043167979==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hey James,

Thanks for quick fix. I can confirm that the patches with a locally built
iwd work fine for me ("Forcing default SAE group 19").

I'm assuming these will end up in iwd 1.18 once merged?

Alex.

On Tue, 24 Aug 2021 at 19:39, James Prestwood <prestwoj@gmail.com> wrote:

> Hi Alex,
>
> There are 4 patches on the mailing list which hopefully fix this for you.
> I've also attached them as well.
>
> Thanks,
> James
>
> On Mon, 2021-08-23 at 22:30 +0100, Alex Cepoi wrote:
>
> Hey James,
>
> Your theory seems to be correct. Adding "sae_groups=3D20 19" seems to make
> authentication fail.
> Here's what I tried:
> https://gist.github.com/alexcepoi/71f1b1fb579b26e0abaa5b7f818923be
>
> Alex.
>
> On Mon, 23 Aug 2021 at 21:03, James Prestwood <prestwoj@gmail.com> wrot=
e:
>
> Hi Alex,
>
>
> On Mon, 23 Aug 2021 at 18:21, James Prestwood <prestwoj@gmail.com> wrot=
e:
>
> Hi Alex,
>
> On Sun, 2021-08-22 at 04:47 +0100, Alex Cepoi wrote:
>
> Hi everyone,
>
> I'm having trouble connecting to a WPA3 network after updating from 1.15
> to 1.16. Can reproduce consistently (100% success rate on 1.15, 0% success
> rate on 1.16).
>
> You can see debug logs before and after in
> https://gist.github.com/alexcepoi/eef301a56e5e40826a8a416cbfb684e6
>
> Diff shows some new "SAE Hunting and Pecking" algorithm used and a "AP did
> not include group number in response!" info, though not sure if related.
>
>
> In your case the effective difference between IWD 1.16 and 1.15 is that we
> now try SAE groups in decending order. This is because higher group numbe=
rs
> are more secure. BUT the only group that is required for a device to
> support is group 19, which it seems your AP falls under. So we have this
> situation where we try group 20, fail, then try 19, but something else go=
es
> wrong.
>
> We don't think IWD is behaving out of what the spec requries in this
> situation (and we even test for this rejected group scenario) but there a=
re
> several red flag commits in hostapd from 2018/2019 which describe fixing
> some behavior that sounds similar to this. Its difficult to know because =
we
> don't have your AP's hostapd or kernel version to try out ourselves.
>
> tl;dr
>
> We think we can 'fix' this by simply using group 19 by default (or a
> config option) but thats not optimal since you really want to use the most
> secure group if it is available. What we can do to verify that your AP is
> to blame is try wpa_supplicant and include this option:
>
> sae_groups=3D20 19
>
> This *should* try group 20 first and behave similarly to IWD. If this also
> results in the same issue we know the AP is to blame. Knowing this will at
> least give us some justification for adding a config option as a fix.
>
> Thanks,
> James
>
>
>

--===============7815942203043167979==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+SGV5IEphbWVzLDxkaXY+PGJyPjwvZGl2PjxkaXY+VGhhbmtzIGZvciBx
dWljayBmaXguIEkgY2FuIGNvbmZpcm0gdGhhdCB0aGUgcGF0Y2hlcyB3aXRoIGEgbG9jYWxseSBi
dWlsdCBpd2Qgd29yayBmaW5lIGZvciBtZSAoJnF1b3Q7Rm9yY2luZyBkZWZhdWx0IFNBRSBncm91
cCAxOSZxdW90OykuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5JJiMzOTttIGFzc3VtaW5nIHRo
ZXNlIHdpbGwgZW5kIHVwIGluIGl3ZCAxLjE4IG9uY2UgbWVyZ2VkPzwvZGl2PjxkaXY+PGJyPjwv
ZGl2PjxkaXY+QWxleC48L2Rpdj48L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxk
aXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9hdHRyIj5PbiBUdWUsIDI0IEF1ZyAyMDIxIGF0IDE5
OjM5LCBKYW1lcyBQcmVzdHdvb2QgJmx0OzxhIGhyZWY9Im1haWx0bzpwcmVzdHdvakBnbWFpbC5j
b20iPnByZXN0d29qQGdtYWlsLmNvbTwvYT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48YmxvY2txdW90
ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9y
ZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+PGRp
dj48ZGl2PkhpIEFsZXgsPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5UaGVyZSBhcmUgNCBwYXRj
aGVzIG9uIHRoZSBtYWlsaW5nIGxpc3Qgd2hpY2ggaG9wZWZ1bGx5IGZpeCB0aGlzIGZvciB5b3Uu
IEkmIzM5O3ZlIGFsc28gYXR0YWNoZWQgdGhlbSBhcyB3ZWxsLjwvZGl2PjxkaXY+PGJyPjwvZGl2
PjxkaXY+VGhhbmtzLDwvZGl2PjxkaXY+SmFtZXM8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pk9u
IE1vbiwgMjAyMS0wOC0yMyBhdCAyMjozMCArMDEwMCwgQWxleCBDZXBvaSB3cm90ZTo8L2Rpdj48
YmxvY2txdW90ZSB0eXBlPSJjaXRlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2Jv
cmRlci1sZWZ0OjJweCBzb2xpZCByZ2IoMTE0LDE1OSwyMDcpO3BhZGRpbmctbGVmdDoxZXgiPjxk
aXYgZGlyPSJsdHIiPkhleSBKYW1lcyw8ZGl2Pjxicj48L2Rpdj48ZGl2PllvdXIgdGhlb3J5IHNl
ZW1zIHRvIGJlIGNvcnJlY3QuIEFkZGluZyAmcXVvdDtzYWVfZ3JvdXBzPTIwIDE5JnF1b3Q7IHNl
ZW1zIHRvIG1ha2UgYXV0aGVudGljYXRpb24gZmFpbC48L2Rpdj48ZGl2PkhlcmUmIzM5O3Mgd2hh
dCBJIHRyaWVkOsKgPGEgaHJlZj0iaHR0cHM6Ly9naXN0LmdpdGh1Yi5jb20vYWxleGNlcG9pLzcx
ZjFiMWZiNTc5YjI2ZTBhYmFhNWI3ZjgxODkyM2JlIiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly9n
aXN0LmdpdGh1Yi5jb20vYWxleGNlcG9pLzcxZjFiMWZiNTc5YjI2ZTBhYmFhNWI3ZjgxODkyM2Jl
PC9hPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+QWxleC48L2Rpdj48L2Rpdj48ZGl2Pjxicj48
L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWls
X2F0dHIiPk9uIE1vbiwgMjMgQXVnIDIwMjEgYXQgMjE6MDMsIEphbWVzIFByZXN0d29vZCAmbHQ7
PGEgaHJlZj0ibWFpbHRvOnByZXN0d29qQGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPnByZXN0
d29qQGdtYWlsLmNvbTwvYT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48YmxvY2txdW90ZSB0eXBlPSJj
aXRlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjJweCBzb2xp
ZCByZ2IoMTE0LDE1OSwyMDcpO3BhZGRpbmctbGVmdDoxZXgiPjxkaXY+PGRpdj5IaSBBbGV4LDwv
ZGl2PjxkaXY+PGJyPjwvZGl2PjxibG9ja3F1b3RlIHR5cGU9ImNpdGUiIHN0eWxlPSJtYXJnaW46
MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MnB4IHNvbGlkIHJnYigxMTQsMTU5LDIwNyk7
cGFkZGluZy1sZWZ0OjFleCI+PGRpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxkaXYg
ZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9hdHRyIj5PbiBNb24sIDIzIEF1ZyAyMDIxIGF0IDE4OjIx
LCBKYW1lcyBQcmVzdHdvb2QgJmx0OzxhIGhyZWY9Im1haWx0bzpwcmVzdHdvakBnbWFpbC5jb20i
IHRhcmdldD0iX2JsYW5rIj5wcmVzdHdvakBnbWFpbC5jb208L2E+Jmd0OyB3cm90ZTo8YnI+PC9k
aXY+PGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhl
eDtib3JkZXItbGVmdDoycHggc29saWQgcmdiKDExNCwxNTksMjA3KTtwYWRkaW5nLWxlZnQ6MWV4
Ij48ZGl2PjxkaXY+SGkgQWxleCw8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pk9uIFN1biwgMjAy
MS0wOC0yMiBhdCAwNDo0NyArMDEwMCwgQWxleCBDZXBvaSB3cm90ZTo8L2Rpdj48YmxvY2txdW90
ZSB0eXBlPSJjaXRlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0
OjJweCBzb2xpZCByZ2IoMTE0LDE1OSwyMDcpO3BhZGRpbmctbGVmdDoxZXgiPjxkaXYgZGlyPSJs
dHIiPkhpIGV2ZXJ5b25lLDxicj48YnI+SSYjMzk7bSBoYXZpbmcgdHJvdWJsZSBjb25uZWN0aW5n
IHRvIGEgV1BBMyBuZXR3b3JrIGFmdGVyIHVwZGF0aW5nIGZyb20gMS4xNSB0byAxLjE2LiBDYW4g
cmVwcm9kdWNlIGNvbnNpc3RlbnRseSAoMTAwJSBzdWNjZXNzIHJhdGUgb24gMS4xNSwgMCUgc3Vj
Y2VzcyByYXRlIG9uIDEuMTYpLjxicj48YnI+WW91IGNhbiBzZWUgZGVidWcgbG9ncyBiZWZvcmUg
YW5kIGFmdGVyIGluIDxhIGhyZWY9Imh0dHBzOi8vZ2lzdC5naXRodWIuY29tL2FsZXhjZXBvaS9l
ZWYzMDFhNTZlNWU0MDgyNmE4YTQxNmNiZmI2ODRlNiIgdGFyZ2V0PSJfYmxhbmsiPmh0dHBzOi8v
Z2lzdC5naXRodWIuY29tL2FsZXhjZXBvaS9lZWYzMDFhNTZlNWU0MDgyNmE4YTQxNmNiZmI2ODRl
NjwvYT48YnI+PGJyPkRpZmYgc2hvd3Mgc29tZSBuZXcgJnF1b3Q7U0FFIEh1bnRpbmcgYW5kIFBl
Y2tpbmcmcXVvdDsgYWxnb3JpdGhtIHVzZWQgYW5kIGEgJnF1b3Q7QVAgZGlkIG5vdCBpbmNsdWRl
IGdyb3VwIG51bWJlciBpbiByZXNwb25zZSEmcXVvdDsgaW5mbywgdGhvdWdoIG5vdCBzdXJlIGlm
IHJlbGF0ZWQuPC9kaXY+PC9ibG9ja3F1b3RlPjwvZGl2PjwvYmxvY2txdW90ZT48L2Rpdj48L2Rp
dj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRpdj5JbiB5b3VyIGNhc2UgdGhlIGVmZmVj
dGl2ZSBkaWZmZXJlbmNlIGJldHdlZW4gSVdEIDEuMTYgYW5kIDEuMTUgaXMgdGhhdCB3ZSBub3cg
dHJ5IFNBRSBncm91cHMgaW4gZGVjZW5kaW5nIG9yZGVyLiBUaGlzIGlzIGJlY2F1c2UgaGlnaGVy
IGdyb3VwIG51bWJlcnMgYXJlIG1vcmUgc2VjdXJlLiBCVVQgdGhlIG9ubHkgZ3JvdXAgdGhhdCBp
cyByZXF1aXJlZCBmb3IgYSBkZXZpY2UgdG8gc3VwcG9ydCBpcyBncm91cCAxOSwgd2hpY2ggaXQg
c2VlbXMgeW91ciBBUCBmYWxscyB1bmRlci4gU28gd2UgaGF2ZSB0aGlzIHNpdHVhdGlvbiB3aGVy
ZSB3ZSB0cnkgZ3JvdXAgMjAsIGZhaWwsIHRoZW4gdHJ5IDE5LCBidXQgc29tZXRoaW5nIGVsc2Ug
Z29lcyB3cm9uZy48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PldlIGRvbiYjMzk7dCB0aGluayBJ
V0QgaXMgYmVoYXZpbmcgb3V0IG9mIHdoYXQgdGhlIHNwZWMgcmVxdXJpZXMgaW4gdGhpcyBzaXR1
YXRpb24gKGFuZCB3ZSBldmVuIHRlc3QgZm9yIHRoaXMgcmVqZWN0ZWQgZ3JvdXAgc2NlbmFyaW8p
IGJ1dCB0aGVyZSBhcmUgc2V2ZXJhbCByZWQgZmxhZyBjb21taXRzIGluIGhvc3RhcGQgZnJvbSAy
MDE4LzIwMTkgd2hpY2ggZGVzY3JpYmUgZml4aW5nIHNvbWUgYmVoYXZpb3IgdGhhdCBzb3VuZHMg
c2ltaWxhciB0byB0aGlzLiBJdHMgZGlmZmljdWx0IHRvIGtub3cgYmVjYXVzZSB3ZSBkb24mIzM5
O3QgaGF2ZSB5b3VyIEFQJiMzOTtzIGhvc3RhcGQgb3Iga2VybmVsIHZlcnNpb24gdG8gdHJ5IG91
dCBvdXJzZWx2ZXMuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj50bDtkcjwvZGl2PjxkaXY+PGJy
PjwvZGl2PjxkaXY+V2UgdGhpbmsgd2UgY2FuICYjMzk7Zml4JiMzOTsgdGhpcyBieSBzaW1wbHkg
dXNpbmcgZ3JvdXAgMTkgYnkgZGVmYXVsdCAob3IgYSBjb25maWcgb3B0aW9uKSBidXQgdGhhdHMg
bm90IG9wdGltYWwgc2luY2UgeW91IHJlYWxseSB3YW50IHRvIHVzZSB0aGUgbW9zdCBzZWN1cmUg
Z3JvdXAgaWYgaXQgaXMgYXZhaWxhYmxlLiBXaGF0IHdlIGNhbiBkbyB0byB2ZXJpZnkgdGhhdCB5
b3VyIEFQIGlzIHRvIGJsYW1lIGlzIHRyeSB3cGFfc3VwcGxpY2FudCBhbmQgaW5jbHVkZSB0aGlz
IG9wdGlvbjo8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PnNhZV9ncm91cHM9MjAgMTk8L2Rpdj48
ZGl2Pjxicj48L2Rpdj48ZGl2PlRoaXMgKnNob3VsZCogdHJ5IGdyb3VwIDIwIGZpcnN0IGFuZCBi
ZWhhdmUgc2ltaWxhcmx5IHRvIElXRC4gSWYgdGhpcyBhbHNvIHJlc3VsdHMgaW4gdGhlIHNhbWUg
aXNzdWUgd2Uga25vdyB0aGUgQVAgaXMgdG8gYmxhbWUuIEtub3dpbmcgdGhpcyB3aWxsIGF0IGxl
YXN0IGdpdmUgdXMgc29tZSBqdXN0aWZpY2F0aW9uIGZvciBhZGRpbmcgYSBjb25maWcgb3B0aW9u
IGFzIGEgZml4LjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+VGhhbmtzLDwvZGl2PjxkaXY+SmFt
ZXM8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PjxzcGFuPjwvc3Bhbj48L2Rpdj48L2Rpdj48L2Js
b2NrcXVvdGU+PC9kaXY+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+PHNwYW4+PC9z
cGFuPjwvZGl2PjwvZGl2Pgo8L2Jsb2NrcXVvdGU+PC9kaXY+Cg==

--===============7815942203043167979==--

