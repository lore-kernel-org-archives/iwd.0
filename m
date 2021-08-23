Content-Type: multipart/mixed; boundary="===============8532313235189059003=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: Re: Failed to connect to WPA3 network after update to iwd 1.16
Date: Mon, 23 Aug 2021 14:47:18 -0700
Message-ID: <ccb96e03729201227a2d05bf0f83bbbf96f9c387.camel@gmail.com>
In-Reply-To: <CAJtNWJhUsjOrNCxZ4nUnr1iFqk_QriMU9Vkq9pscFTMqpi5seA@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8532313235189059003==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alex,

On Mon, 2021-08-23 at 22:30 +0100, Alex Cepoi wrote:
> Hey James,
> =

> Your theory seems to be correct. Adding "sae_groups=3D20 19" seems to
> make authentication fail.
> Here's what I
> tried:=C2=A0
> https://gist.github.com/alexcepoi/71f1b1fb579b26e0abaa5b7f818923be
> =

> Alex.

Thanks for verifying this. Looks like it is something we will have to
work around in IWD.

> =

> On Mon, 23 Aug 2021 at 21:03, James Prestwood <prestwoj@gmail.com>
> wrote:
> > Hi Alex,
> > =

> > > =

> > > On Mon, 23 Aug 2021 at 18:21, James Prestwood
> > > <prestwoj@gmail.com> wrote:
> > > > Hi Alex,
> > > > =

> > > > On Sun, 2021-08-22 at 04:47 +0100, Alex Cepoi wrote:
> > > > > Hi everyone,
> > > > > =

> > > > > I'm having trouble connecting to a WPA3 network after
> > > > > updating from 1.15 to 1.16. Can reproduce consistently (100%
> > > > > success rate on 1.15, 0% success rate on 1.16).
> > > > > =

> > > > > You can see debug logs before and after in
> > > > >
> > > >
> > >
> > https://gist.github.com/alexcepoi/eef301a56e5e40826a8a416cbfb684e6
> > > > > =

> > > > > Diff shows some new "SAE Hunting and Pecking" algorithm used
> > > > > and a "AP did not include group number in response!" info,
> > > > > though not sure if related.
> > =

> > =

> > In your case the effective difference between IWD 1.16 and 1.15 is
> > that we now try SAE groups in decending order. This is because
> > higher group numbers are more secure. BUT the only group that is
> > required for a device to support is group 19, which it seems your
> > AP falls under. So we have this situation where we try group 20,
> > fail, then try 19, but something else goes wrong.
> > =

> > We don't think IWD is behaving out of what the spec requries in
> > this situation (and we even test for this rejected group scenario)
> > but there are several red flag commits in hostapd from 2018/2019
> > which describe fixing some behavior that sounds similar to this.
> > Its difficult to know because we don't have your AP's hostapd or
> > kernel version to try out ourselves.
> > =

> > tl;dr
> > =

> > We think we can 'fix' this by simply using group 19 by default (or
> > a config option) but thats not optimal since you really want to use
> > the most secure group if it is available. What we can do to verify
> > that your AP is to blame is try wpa_supplicant and include this
> > option:
> > =

> > sae_groups=3D20 19
> > =

> > This *should* try group 20 first and behave similarly to IWD. If
> > this also results in the same issue we know the AP is to blame.
> > Knowing this will at least give us some justification for adding a
> > config option as a fix.
> > =

> > Thanks,
> > James
> > =



--===============8532313235189059003==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGh0bWw+PGhlYWQ+PC9oZWFkPjxib2R5PjxkaXY+SGkgQWxleCw8L2Rpdj48ZGl2Pjxicj48L2Rp
dj48ZGl2Pk9uIE1vbiwgMjAyMS0wOC0yMyBhdCAyMjozMCArMDEwMCwgQWxleCBDZXBvaSB3cm90
ZTo8L2Rpdj48YmxvY2txdW90ZSB0eXBlPSJjaXRlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7
IGJvcmRlci1sZWZ0OjJweCAjNzI5ZmNmIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPjxkaXYgZGly
PSJsdHIiPkhleSBKYW1lcyw8ZGl2Pjxicj48L2Rpdj48ZGl2PllvdXIgdGhlb3J5IHNlZW1zIHRv
IGJlIGNvcnJlY3QuIEFkZGluZyAic2FlX2dyb3Vwcz0yMCAxOSIgc2VlbXMgdG8gbWFrZSBhdXRo
ZW50aWNhdGlvbiBmYWlsLjwvZGl2PjxkaXY+SGVyZSdzIHdoYXQgSSB0cmllZDombmJzcDs8YSBo
cmVmPSJodHRwczovL2dpc3QuZ2l0aHViLmNvbS9hbGV4Y2Vwb2kvNzFmMWIxZmI1NzliMjZlMGFi
YWE1YjdmODE4OTIzYmUiIHRhcmdldD0iX2JsYW5rIj5odHRwczovL2dpc3QuZ2l0aHViLmNvbS9h
bGV4Y2Vwb2kvNzFmMWIxZmI1NzliMjZlMGFiYWE1YjdmODE4OTIzYmU8L2E+PC9kaXY+PGRpdj48
YnI+PC9kaXY+PGRpdj5BbGV4LjwvZGl2PjwvZGl2PjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rp
dj48ZGl2PlRoYW5rcyBmb3IgdmVyaWZ5aW5nIHRoaXMuIExvb2tzIGxpa2UgaXQgaXMgc29tZXRo
aW5nIHdlIHdpbGwgaGF2ZSB0byB3b3JrIGFyb3VuZCBpbiBJV0QuPC9kaXY+PGRpdj48YnI+PC9k
aXY+PGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSIgc3R5bGU9Im1hcmdpbjowIDAgMCAuOGV4OyBib3Jk
ZXItbGVmdDoycHggIzcyOWZjZiBzb2xpZDtwYWRkaW5nLWxlZnQ6MWV4Ij48ZGl2Pjxicj48L2Rp
dj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0
dHIiPk9uIE1vbiwgMjMgQXVnIDIwMjEgYXQgMjE6MDMsIEphbWVzIFByZXN0d29vZCAmbHQ7PGEg
aHJlZj0ibWFpbHRvOnByZXN0d29qQGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPnByZXN0d29q
QGdtYWlsLmNvbTwvYT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48YmxvY2txdW90ZSB0eXBlPSJjaXRl
IiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7IGJvcmRlci1sZWZ0OjJweCAjNzI5ZmNmIHNvbGlk
O3BhZGRpbmctbGVmdDoxZXgiPjxkaXY+PGRpdj5IaSBBbGV4LDwvZGl2PjxkaXY+PGJyPjwvZGl2
PjxibG9ja3F1b3RlIHR5cGU9ImNpdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDsgYm9yZGVy
LWxlZnQ6MnB4ICM3MjlmY2Ygc29saWQ7cGFkZGluZy1sZWZ0OjFleCI+PGRpdj48YnI+PGRpdiBj
bGFzcz0iZ21haWxfcXVvdGUiPjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9hdHRyIj5PbiBN
b24sIDIzIEF1ZyAyMDIxIGF0IDE4OjIxLCBKYW1lcyBQcmVzdHdvb2QgJmx0OzxhIGhyZWY9Im1h
aWx0bzpwcmVzdHdvakBnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5wcmVzdHdvakBnbWFpbC5j
b208L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSIgc3R5bGU9
Im1hcmdpbjowIDAgMCAuOGV4OyBib3JkZXItbGVmdDoycHggIzcyOWZjZiBzb2xpZDtwYWRkaW5n
LWxlZnQ6MWV4Ij48ZGl2PjxkaXY+SGkgQWxleCw8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pk9u
IFN1biwgMjAyMS0wOC0yMiBhdCAwNDo0NyArMDEwMCwgQWxleCBDZXBvaSB3cm90ZTo8L2Rpdj48
YmxvY2txdW90ZSB0eXBlPSJjaXRlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7IGJvcmRlci1s
ZWZ0OjJweCAjNzI5ZmNmIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPjxkaXYgZGlyPSJsdHIiPkhp
IGV2ZXJ5b25lLDxicj48YnI+SSdtIGhhdmluZyB0cm91YmxlIGNvbm5lY3RpbmcgdG8gYSBXUEEz
IG5ldHdvcmsgYWZ0ZXIgdXBkYXRpbmcgZnJvbSAxLjE1IHRvIDEuMTYuIENhbiByZXByb2R1Y2Ug
Y29uc2lzdGVudGx5ICgxMDAlIHN1Y2Nlc3MgcmF0ZSBvbiAxLjE1LCAwJSBzdWNjZXNzIHJhdGUg
b24gMS4xNikuPGJyPjxicj5Zb3UgY2FuIHNlZSBkZWJ1ZyBsb2dzIGJlZm9yZSBhbmQgYWZ0ZXIg
aW4gPGEgaHJlZj0iaHR0cHM6Ly9naXN0LmdpdGh1Yi5jb20vYWxleGNlcG9pL2VlZjMwMWE1NmU1
ZTQwODI2YThhNDE2Y2JmYjY4NGU2IiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly9naXN0LmdpdGh1
Yi5jb20vYWxleGNlcG9pL2VlZjMwMWE1NmU1ZTQwODI2YThhNDE2Y2JmYjY4NGU2PC9hPjxicj48
YnI+RGlmZiBzaG93cyBzb21lIG5ldyAiU0FFIEh1bnRpbmcgYW5kIFBlY2tpbmciIGFsZ29yaXRo
bSB1c2VkIGFuZCBhICJBUCBkaWQgbm90IGluY2x1ZGUgZ3JvdXAgbnVtYmVyIGluIHJlc3BvbnNl
ISIgaW5mbywgdGhvdWdoIG5vdCBzdXJlIGlmIHJlbGF0ZWQuPC9kaXY+PC9ibG9ja3F1b3RlPjwv
ZGl2PjwvYmxvY2txdW90ZT48L2Rpdj48L2Rpdj48L2Jsb2NrcXVvdGU+PGRpdj48YnI+PC9kaXY+
PGRpdj5JbiB5b3VyIGNhc2UgdGhlIGVmZmVjdGl2ZSBkaWZmZXJlbmNlIGJldHdlZW4gSVdEIDEu
MTYgYW5kIDEuMTUgaXMgdGhhdCB3ZSBub3cgdHJ5IFNBRSBncm91cHMgaW4gZGVjZW5kaW5nIG9y
ZGVyLiBUaGlzIGlzIGJlY2F1c2UgaGlnaGVyIGdyb3VwIG51bWJlcnMgYXJlIG1vcmUgc2VjdXJl
LiBCVVQgdGhlIG9ubHkgZ3JvdXAgdGhhdCBpcyByZXF1aXJlZCBmb3IgYSBkZXZpY2UgdG8gc3Vw
cG9ydCBpcyBncm91cCAxOSwgd2hpY2ggaXQgc2VlbXMgeW91ciBBUCBmYWxscyB1bmRlci4gU28g
d2UgaGF2ZSB0aGlzIHNpdHVhdGlvbiB3aGVyZSB3ZSB0cnkgZ3JvdXAgMjAsIGZhaWwsIHRoZW4g
dHJ5IDE5LCBidXQgc29tZXRoaW5nIGVsc2UgZ29lcyB3cm9uZy48L2Rpdj48ZGl2Pjxicj48L2Rp
dj48ZGl2PldlIGRvbid0IHRoaW5rIElXRCBpcyBiZWhhdmluZyBvdXQgb2Ygd2hhdCB0aGUgc3Bl
YyByZXF1cmllcyBpbiB0aGlzIHNpdHVhdGlvbiAoYW5kIHdlIGV2ZW4gdGVzdCBmb3IgdGhpcyBy
ZWplY3RlZCBncm91cCBzY2VuYXJpbykgYnV0IHRoZXJlIGFyZSBzZXZlcmFsIHJlZCBmbGFnIGNv
bW1pdHMgaW4gaG9zdGFwZCBmcm9tIDIwMTgvMjAxOSB3aGljaCBkZXNjcmliZSBmaXhpbmcgc29t
ZSBiZWhhdmlvciB0aGF0IHNvdW5kcyBzaW1pbGFyIHRvIHRoaXMuIEl0cyBkaWZmaWN1bHQgdG8g
a25vdyBiZWNhdXNlIHdlIGRvbid0IGhhdmUgeW91ciBBUCdzIGhvc3RhcGQgb3Iga2VybmVsIHZl
cnNpb24gdG8gdHJ5IG91dCBvdXJzZWx2ZXMuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj50bDtk
cjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+V2UgdGhpbmsgd2UgY2FuICdmaXgnIHRoaXMgYnkg
c2ltcGx5IHVzaW5nIGdyb3VwIDE5IGJ5IGRlZmF1bHQgKG9yIGEgY29uZmlnIG9wdGlvbikgYnV0
IHRoYXRzIG5vdCBvcHRpbWFsIHNpbmNlIHlvdSByZWFsbHkgd2FudCB0byB1c2UgdGhlIG1vc3Qg
c2VjdXJlIGdyb3VwIGlmIGl0IGlzIGF2YWlsYWJsZS4gV2hhdCB3ZSBjYW4gZG8gdG8gdmVyaWZ5
IHRoYXQgeW91ciBBUCBpcyB0byBibGFtZSBpcyB0cnkgd3BhX3N1cHBsaWNhbnQgYW5kIGluY2x1
ZGUgdGhpcyBvcHRpb246PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5zYWVfZ3JvdXBzPTIwIDE5
PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5UaGlzICpzaG91bGQqIHRyeSBncm91cCAyMCBmaXJz
dCBhbmQgYmVoYXZlIHNpbWlsYXJseSB0byBJV0QuIElmIHRoaXMgYWxzbyByZXN1bHRzIGluIHRo
ZSBzYW1lIGlzc3VlIHdlIGtub3cgdGhlIEFQIGlzIHRvIGJsYW1lLiBLbm93aW5nIHRoaXMgd2ls
bCBhdCBsZWFzdCBnaXZlIHVzIHNvbWUganVzdGlmaWNhdGlvbiBmb3IgYWRkaW5nIGEgY29uZmln
IG9wdGlvbiBhcyBhIGZpeC48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PlRoYW5rcyw8L2Rpdj48
ZGl2PkphbWVzPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj48c3Bhbj48L3NwYW4+PC9kaXY+PC9k
aXY+PC9ibG9ja3F1b3RlPjwvZGl2PjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2Pjxz
cGFuPjwvc3Bhbj48L2Rpdj48L2JvZHk+PC9odG1sPgo=

--===============8532313235189059003==--

