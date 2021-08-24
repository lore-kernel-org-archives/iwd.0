Content-Type: multipart/mixed; boundary="===============8507478114060228059=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: Failed to connect to WPA3 network after update to iwd 1.16
Date: Tue, 24 Aug 2021 12:03:56 -0700
Message-ID: <ddb1932ccf6641d9caebb9f6293b256e301eae95.camel@gmail.com>
In-Reply-To: <CAJtNWJjeJELvqYTNDdB-ONmLQTeyh6e-1+Uozq2=df-vf6G6XA@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8507478114060228059==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 2021-08-24 at 20:03 +0100, Alex Cepoi wrote:
> Hey James,
> =

> Thanks for quick fix. I can confirm that the patches with a locally
> built iwd work fine for me ("Forcing default SAE group 19").
> =

> I'm assuming these will end up in iwd 1.18 once merged?

Yep they will and thank you for testing these out.

> =

> Alex.
> =

> On Tue, 24 Aug 2021 at 19:39, James Prestwood <prestwoj@gmail.com>
> wrote:
> > Hi Alex,
> > =

> > There are 4 patches on the mailing list which hopefully fix this
> > for you. I've also attached them as well.
> > =

> > Thanks,
> > James
> > =

> > On Mon, 2021-08-23 at 22:30 +0100, Alex Cepoi wrote:
> > > Hey James,
> > > =

> > > Your theory seems to be correct. Adding "sae_groups=3D20 19" seems
> > > to make authentication fail.
> > > Here's what I
> > > tried:=C2=A0
> > >
> > https://gist.github.com/alexcepoi/71f1b1fb579b26e0abaa5b7f818923be
> > > =

> > > Alex.
> > > =

> > > On Mon, 23 Aug 2021 at 21:03, James Prestwood
> > > <prestwoj@gmail.com> wrote:
> > > > Hi Alex,
> > > > =

> > > > > =

> > > > > On Mon, 23 Aug 2021 at 18:21, James Prestwood
> > > > > <prestwoj@gmail.com> wrote:
> > > > > > Hi Alex,
> > > > > > =

> > > > > > On Sun, 2021-08-22 at 04:47 +0100, Alex Cepoi wrote:
> > > > > > > Hi everyone,
> > > > > > > =

> > > > > > > I'm having trouble connecting to a WPA3 network after
> > > > > > > updating from 1.15 to 1.16. Can reproduce consistently
> > > > > > > (100% success rate on 1.15, 0% success rate on 1.16).
> > > > > > > =

> > > > > > > You can see debug logs before and after in
> > > > > > >
> > > > > >
> > > > >
> > > >
> > >
> > https://gist.github.com/alexcepoi/eef301a56e5e40826a8a416cbfb684e6
> > > > > > > =

> > > > > > > Diff shows some new "SAE Hunting and Pecking" algorithm
> > > > > > > used and a "AP did not include group number in response!"
> > > > > > > info, though not sure if related.
> > > > =

> > > > =

> > > > In your case the effective difference between IWD 1.16 and 1.15
> > > > is that we now try SAE groups in decending order. This is
> > > > because higher group numbers are more secure. BUT the only
> > > > group that is required for a device to support is group 19,
> > > > which it seems your AP falls under. So we have this situation
> > > > where we try group 20, fail, then try 19, but something else
> > > > goes wrong.
> > > > =

> > > > We don't think IWD is behaving out of what the spec requries in
> > > > this situation (and we even test for this rejected group
> > > > scenario) but there are several red flag commits in hostapd
> > > > from 2018/2019 which describe fixing some behavior that sounds
> > > > similar to this. Its difficult to know because we don't have
> > > > your AP's hostapd or kernel version to try out ourselves.
> > > > =

> > > > tl;dr
> > > > =

> > > > We think we can 'fix' this by simply using group 19 by default
> > > > (or a config option) but thats not optimal since you really
> > > > want to use the most secure group if it is available. What we
> > > > can do to verify that your AP is to blame is try wpa_supplicant
> > > > and include this option:
> > > > =

> > > > sae_groups=3D20 19
> > > > =

> > > > This *should* try group 20 first and behave similarly to IWD.
> > > > If this also results in the same issue we know the AP is to
> > > > blame. Knowing this will at least give us some justification
> > > > for adding a config option as a fix.
> > > > =

> > > > Thanks,
> > > > James
> > > > =

> > =

> > =



--===============8507478114060228059==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGh0bWw+PGhlYWQ+PC9oZWFkPjxib2R5PjxkaXY+T24gVHVlLCAyMDIxLTA4LTI0IGF0IDIwOjAz
ICswMTAwLCBBbGV4IENlcG9pIHdyb3RlOjwvZGl2PjxibG9ja3F1b3RlIHR5cGU9ImNpdGUiIHN0
eWxlPSJtYXJnaW46MCAwIDAgLjhleDsgYm9yZGVyLWxlZnQ6MnB4ICM3MjlmY2Ygc29saWQ7cGFk
ZGluZy1sZWZ0OjFleCI+PGRpdiBkaXI9Imx0ciI+SGV5IEphbWVzLDxkaXY+PGJyPjwvZGl2Pjxk
aXY+VGhhbmtzIGZvciBxdWljayBmaXguIEkgY2FuIGNvbmZpcm0gdGhhdCB0aGUgcGF0Y2hlcyB3
aXRoIGEgbG9jYWxseSBidWlsdCBpd2Qgd29yayBmaW5lIGZvciBtZSAoIkZvcmNpbmcgZGVmYXVs
dCBTQUUgZ3JvdXAgMTkiKS48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkknbSBhc3N1bWluZyB0
aGVzZSB3aWxsIGVuZCB1cCBpbiBpd2QgMS4xOCBvbmNlIG1lcmdlZD88L2Rpdj48L2Rpdj48L2Js
b2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+PGRpdj5ZZXAgdGhleSB3aWxsIGFuZCB0aGFuayB5b3Ug
Zm9yIHRlc3RpbmcgdGhlc2Ugb3V0LjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxibG9ja3F1b3RlIHR5
cGU9ImNpdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDsgYm9yZGVyLWxlZnQ6MnB4ICM3Mjlm
Y2Ygc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+PGRpdiBkaXI9Imx0ciI+PGRpdj48YnI+PC9kaXY+
PGRpdj5BbGV4LjwvZGl2PjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX3F1
b3RlIj48ZGl2IGRpcj0ibHRyIiBjbGFzcz0iZ21haWxfYXR0ciI+T24gVHVlLCAyNCBBdWcgMjAy
MSBhdCAxOTozOSwgSmFtZXMgUHJlc3R3b29kICZsdDs8YSBocmVmPSJtYWlsdG86cHJlc3R3b2pA
Z21haWwuY29tIj5wcmVzdHdvakBnbWFpbC5jb208L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJs
b2NrcXVvdGUgdHlwZT0iY2l0ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4OyBib3JkZXItbGVm
dDoycHggIzcyOWZjZiBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij48ZGl2PjxkaXY+SGkgQWxleCw8
L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlRoZXJlIGFyZSA0IHBhdGNoZXMgb24gdGhlIG1haWxp
bmcgbGlzdCB3aGljaCBob3BlZnVsbHkgZml4IHRoaXMgZm9yIHlvdS4gSSd2ZSBhbHNvIGF0dGFj
aGVkIHRoZW0gYXMgd2VsbC48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlRoYW5rcyw8L2Rpdj48
ZGl2PkphbWVzPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5PbiBNb24sIDIwMjEtMDgtMjMgYXQg
MjI6MzAgKzAxMDAsIEFsZXggQ2Vwb2kgd3JvdGU6PC9kaXY+PGJsb2NrcXVvdGUgdHlwZT0iY2l0
ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4OyBib3JkZXItbGVmdDoycHggIzcyOWZjZiBzb2xp
ZDtwYWRkaW5nLWxlZnQ6MWV4Ij48ZGl2IGRpcj0ibHRyIj5IZXkgSmFtZXMsPGRpdj48YnI+PC9k
aXY+PGRpdj5Zb3VyIHRoZW9yeSBzZWVtcyB0byBiZSBjb3JyZWN0LiBBZGRpbmcgInNhZV9ncm91
cHM9MjAgMTkiIHNlZW1zIHRvIG1ha2UgYXV0aGVudGljYXRpb24gZmFpbC48L2Rpdj48ZGl2Pkhl
cmUncyB3aGF0IEkgdHJpZWQ6Jm5ic3A7PGEgaHJlZj0iaHR0cHM6Ly9naXN0LmdpdGh1Yi5jb20v
YWxleGNlcG9pLzcxZjFiMWZiNTc5YjI2ZTBhYmFhNWI3ZjgxODkyM2JlIiB0YXJnZXQ9Il9ibGFu
ayI+aHR0cHM6Ly9naXN0LmdpdGh1Yi5jb20vYWxleGNlcG9pLzcxZjFiMWZiNTc5YjI2ZTBhYmFh
NWI3ZjgxODkyM2JlPC9hPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+QWxleC48L2Rpdj48L2Rp
dj48ZGl2Pjxicj48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciIg
Y2xhc3M9ImdtYWlsX2F0dHIiPk9uIE1vbiwgMjMgQXVnIDIwMjEgYXQgMjE6MDMsIEphbWVzIFBy
ZXN0d29vZCAmbHQ7PGEgaHJlZj0ibWFpbHRvOnByZXN0d29qQGdtYWlsLmNvbSIgdGFyZ2V0PSJf
YmxhbmsiPnByZXN0d29qQGdtYWlsLmNvbTwvYT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48YmxvY2tx
dW90ZSB0eXBlPSJjaXRlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7IGJvcmRlci1sZWZ0OjJw
eCAjNzI5ZmNmIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPjxkaXY+PGRpdj5IaSBBbGV4LDwvZGl2
PjxkaXY+PGJyPjwvZGl2PjxibG9ja3F1b3RlIHR5cGU9ImNpdGUiIHN0eWxlPSJtYXJnaW46MCAw
IDAgLjhleDsgYm9yZGVyLWxlZnQ6MnB4ICM3MjlmY2Ygc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+
PGRpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJn
bWFpbF9hdHRyIj5PbiBNb24sIDIzIEF1ZyAyMDIxIGF0IDE4OjIxLCBKYW1lcyBQcmVzdHdvb2Qg
Jmx0OzxhIGhyZWY9Im1haWx0bzpwcmVzdHdvakBnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5w
cmVzdHdvakBnbWFpbC5jb208L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVvdGUgdHlw
ZT0iY2l0ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4OyBib3JkZXItbGVmdDoycHggIzcyOWZj
ZiBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij48ZGl2PjxkaXY+SGkgQWxleCw8L2Rpdj48ZGl2Pjxi
cj48L2Rpdj48ZGl2Pk9uIFN1biwgMjAyMS0wOC0yMiBhdCAwNDo0NyArMDEwMCwgQWxleCBDZXBv
aSB3cm90ZTo8L2Rpdj48YmxvY2txdW90ZSB0eXBlPSJjaXRlIiBzdHlsZT0ibWFyZ2luOjAgMCAw
IC44ZXg7IGJvcmRlci1sZWZ0OjJweCAjNzI5ZmNmIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPjxk
aXYgZGlyPSJsdHIiPkhpIGV2ZXJ5b25lLDxicj48YnI+SSdtIGhhdmluZyB0cm91YmxlIGNvbm5l
Y3RpbmcgdG8gYSBXUEEzIG5ldHdvcmsgYWZ0ZXIgdXBkYXRpbmcgZnJvbSAxLjE1IHRvIDEuMTYu
IENhbiByZXByb2R1Y2UgY29uc2lzdGVudGx5ICgxMDAlIHN1Y2Nlc3MgcmF0ZSBvbiAxLjE1LCAw
JSBzdWNjZXNzIHJhdGUgb24gMS4xNikuPGJyPjxicj5Zb3UgY2FuIHNlZSBkZWJ1ZyBsb2dzIGJl
Zm9yZSBhbmQgYWZ0ZXIgaW4gPGEgaHJlZj0iaHR0cHM6Ly9naXN0LmdpdGh1Yi5jb20vYWxleGNl
cG9pL2VlZjMwMWE1NmU1ZTQwODI2YThhNDE2Y2JmYjY4NGU2IiB0YXJnZXQ9Il9ibGFuayI+aHR0
cHM6Ly9naXN0LmdpdGh1Yi5jb20vYWxleGNlcG9pL2VlZjMwMWE1NmU1ZTQwODI2YThhNDE2Y2Jm
YjY4NGU2PC9hPjxicj48YnI+RGlmZiBzaG93cyBzb21lIG5ldyAiU0FFIEh1bnRpbmcgYW5kIFBl
Y2tpbmciIGFsZ29yaXRobSB1c2VkIGFuZCBhICJBUCBkaWQgbm90IGluY2x1ZGUgZ3JvdXAgbnVt
YmVyIGluIHJlc3BvbnNlISIgaW5mbywgdGhvdWdoIG5vdCBzdXJlIGlmIHJlbGF0ZWQuPC9kaXY+
PC9ibG9ja3F1b3RlPjwvZGl2PjwvYmxvY2txdW90ZT48L2Rpdj48L2Rpdj48L2Jsb2NrcXVvdGU+
PGRpdj48YnI+PC9kaXY+PGRpdj5JbiB5b3VyIGNhc2UgdGhlIGVmZmVjdGl2ZSBkaWZmZXJlbmNl
IGJldHdlZW4gSVdEIDEuMTYgYW5kIDEuMTUgaXMgdGhhdCB3ZSBub3cgdHJ5IFNBRSBncm91cHMg
aW4gZGVjZW5kaW5nIG9yZGVyLiBUaGlzIGlzIGJlY2F1c2UgaGlnaGVyIGdyb3VwIG51bWJlcnMg
YXJlIG1vcmUgc2VjdXJlLiBCVVQgdGhlIG9ubHkgZ3JvdXAgdGhhdCBpcyByZXF1aXJlZCBmb3Ig
YSBkZXZpY2UgdG8gc3VwcG9ydCBpcyBncm91cCAxOSwgd2hpY2ggaXQgc2VlbXMgeW91ciBBUCBm
YWxscyB1bmRlci4gU28gd2UgaGF2ZSB0aGlzIHNpdHVhdGlvbiB3aGVyZSB3ZSB0cnkgZ3JvdXAg
MjAsIGZhaWwsIHRoZW4gdHJ5IDE5LCBidXQgc29tZXRoaW5nIGVsc2UgZ29lcyB3cm9uZy48L2Rp
dj48ZGl2Pjxicj48L2Rpdj48ZGl2PldlIGRvbid0IHRoaW5rIElXRCBpcyBiZWhhdmluZyBvdXQg
b2Ygd2hhdCB0aGUgc3BlYyByZXF1cmllcyBpbiB0aGlzIHNpdHVhdGlvbiAoYW5kIHdlIGV2ZW4g
dGVzdCBmb3IgdGhpcyByZWplY3RlZCBncm91cCBzY2VuYXJpbykgYnV0IHRoZXJlIGFyZSBzZXZl
cmFsIHJlZCBmbGFnIGNvbW1pdHMgaW4gaG9zdGFwZCBmcm9tIDIwMTgvMjAxOSB3aGljaCBkZXNj
cmliZSBmaXhpbmcgc29tZSBiZWhhdmlvciB0aGF0IHNvdW5kcyBzaW1pbGFyIHRvIHRoaXMuIEl0
cyBkaWZmaWN1bHQgdG8ga25vdyBiZWNhdXNlIHdlIGRvbid0IGhhdmUgeW91ciBBUCdzIGhvc3Rh
cGQgb3Iga2VybmVsIHZlcnNpb24gdG8gdHJ5IG91dCBvdXJzZWx2ZXMuPC9kaXY+PGRpdj48YnI+
PC9kaXY+PGRpdj50bDtkcjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+V2UgdGhpbmsgd2UgY2Fu
ICdmaXgnIHRoaXMgYnkgc2ltcGx5IHVzaW5nIGdyb3VwIDE5IGJ5IGRlZmF1bHQgKG9yIGEgY29u
ZmlnIG9wdGlvbikgYnV0IHRoYXRzIG5vdCBvcHRpbWFsIHNpbmNlIHlvdSByZWFsbHkgd2FudCB0
byB1c2UgdGhlIG1vc3Qgc2VjdXJlIGdyb3VwIGlmIGl0IGlzIGF2YWlsYWJsZS4gV2hhdCB3ZSBj
YW4gZG8gdG8gdmVyaWZ5IHRoYXQgeW91ciBBUCBpcyB0byBibGFtZSBpcyB0cnkgd3BhX3N1cHBs
aWNhbnQgYW5kIGluY2x1ZGUgdGhpcyBvcHRpb246PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5z
YWVfZ3JvdXBzPTIwIDE5PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5UaGlzICpzaG91bGQqIHRy
eSBncm91cCAyMCBmaXJzdCBhbmQgYmVoYXZlIHNpbWlsYXJseSB0byBJV0QuIElmIHRoaXMgYWxz
byByZXN1bHRzIGluIHRoZSBzYW1lIGlzc3VlIHdlIGtub3cgdGhlIEFQIGlzIHRvIGJsYW1lLiBL
bm93aW5nIHRoaXMgd2lsbCBhdCBsZWFzdCBnaXZlIHVzIHNvbWUganVzdGlmaWNhdGlvbiBmb3Ig
YWRkaW5nIGEgY29uZmlnIG9wdGlvbiBhcyBhIGZpeC48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2
PlRoYW5rcyw8L2Rpdj48ZGl2PkphbWVzPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48c3Bhbj48
L3NwYW4+PC9kaXY+PC9kaXY+PC9ibG9ja3F1b3RlPjwvZGl2PjwvYmxvY2txdW90ZT48ZGl2Pjxi
cj48L2Rpdj48ZGl2PjxzcGFuPjwvc3Bhbj48L2Rpdj48L2Rpdj48L2Jsb2NrcXVvdGU+PC9kaXY+
PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+PHNwYW4+PC9zcGFuPjwvZGl2PjwvYm9k
eT48L2h0bWw+Cg==

--===============8507478114060228059==--

