Content-Type: multipart/mixed; boundary="===============5930130465923469692=="
MIME-Version: 1.0
From: Alex Cepoi <alex.cepoi@gmail.com>
Subject: Re: Failed to connect to WPA3 network after update to iwd 1.16
Date: Mon, 23 Aug 2021 22:30:32 +0100
Message-ID: <CAJtNWJhUsjOrNCxZ4nUnr1iFqk_QriMU9Vkq9pscFTMqpi5seA@mail.gmail.com>
In-Reply-To: <1fb184f06d36da9b70c73c0bc4283f94076e8e16.camel@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5930130465923469692==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hey James,

Your theory seems to be correct. Adding "sae_groups=3D20 19" seems to make
authentication fail.
Here's what I tried:
https://gist.github.com/alexcepoi/71f1b1fb579b26e0abaa5b7f818923be

Alex.

On Mon, 23 Aug 2021 at 21:03, James Prestwood <prestwoj@gmail.com> wrote:

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

--===============5930130465923469692==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+SGV5IEphbWVzLDxkaXY+PGJyPjwvZGl2PjxkaXY+WW91ciB0aGVvcnkg
c2VlbXMgdG8gYmUgY29ycmVjdC4gQWRkaW5nICZxdW90O3NhZV9ncm91cHM9MjAgMTkmcXVvdDsg
c2VlbXMgdG8gbWFrZSBhdXRoZW50aWNhdGlvbiBmYWlsLjwvZGl2PjxkaXY+SGVyZSYjMzk7cyB3
aGF0IEkgdHJpZWQ6wqA8YSBocmVmPSJodHRwczovL2dpc3QuZ2l0aHViLmNvbS9hbGV4Y2Vwb2kv
NzFmMWIxZmI1NzliMjZlMGFiYWE1YjdmODE4OTIzYmUiIHRhcmdldD0iX2JsYW5rIj5odHRwczov
L2dpc3QuZ2l0aHViLmNvbS9hbGV4Y2Vwb2kvNzFmMWIxZmI1NzliMjZlMGFiYWE1YjdmODE4OTIz
YmU8L2E+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5BbGV4LjwvZGl2PjwvZGl2Pjxicj48ZGl2
IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPk9u
IE1vbiwgMjMgQXVnIDIwMjEgYXQgMjE6MDMsIEphbWVzIFByZXN0d29vZCAmbHQ7PGEgaHJlZj0i
bWFpbHRvOnByZXN0d29qQGdtYWlsLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPnByZXN0d29qQGdtYWls
LmNvbTwvYT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVv
dGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlk
IHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+PGRpdj48ZGl2PkhpIEFsZXgsPC9k
aXY+PGRpdj48YnI+PC9kaXY+PGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSIgc3R5bGU9Im1hcmdpbjow
cHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoycHggc29saWQgcmdiKDExNCwxNTksMjA3KTtw
YWRkaW5nLWxlZnQ6MWV4Ij48ZGl2Pjxicj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGRpdiBk
aXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPk9uIE1vbiwgMjMgQXVnIDIwMjEgYXQgMTg6MjEs
IEphbWVzIFByZXN0d29vZCAmbHQ7PGEgaHJlZj0ibWFpbHRvOnByZXN0d29qQGdtYWlsLmNvbSIg
dGFyZ2V0PSJfYmxhbmsiPnByZXN0d29qQGdtYWlsLmNvbTwvYT4mZ3Q7IHdyb3RlOjxicj48L2Rp
dj48YmxvY2txdW90ZSB0eXBlPSJjaXRlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAuOGV4
O2JvcmRlci1sZWZ0OjJweCBzb2xpZCByZ2IoMTE0LDE1OSwyMDcpO3BhZGRpbmctbGVmdDoxZXgi
PjxkaXY+PGRpdj5IaSBBbGV4LDwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+T24gU3VuLCAyMDIx
LTA4LTIyIGF0IDA0OjQ3ICswMTAwLCBBbGV4IENlcG9pIHdyb3RlOjwvZGl2PjxibG9ja3F1b3Rl
IHR5cGU9ImNpdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6
MnB4IHNvbGlkIHJnYigxMTQsMTU5LDIwNyk7cGFkZGluZy1sZWZ0OjFleCI+PGRpdiBkaXI9Imx0
ciI+SGkgZXZlcnlvbmUsPGJyPjxicj5JJiMzOTttIGhhdmluZyB0cm91YmxlIGNvbm5lY3Rpbmcg
dG8gYSBXUEEzIG5ldHdvcmsgYWZ0ZXIgdXBkYXRpbmcgZnJvbSAxLjE1IHRvIDEuMTYuIENhbiBy
ZXByb2R1Y2UgY29uc2lzdGVudGx5ICgxMDAlIHN1Y2Nlc3MgcmF0ZSBvbiAxLjE1LCAwJSBzdWNj
ZXNzIHJhdGUgb24gMS4xNikuPGJyPjxicj5Zb3UgY2FuIHNlZSBkZWJ1ZyBsb2dzIGJlZm9yZSBh
bmQgYWZ0ZXIgaW4gPGEgaHJlZj0iaHR0cHM6Ly9naXN0LmdpdGh1Yi5jb20vYWxleGNlcG9pL2Vl
ZjMwMWE1NmU1ZTQwODI2YThhNDE2Y2JmYjY4NGU2IiB0YXJnZXQ9Il9ibGFuayI+aHR0cHM6Ly9n
aXN0LmdpdGh1Yi5jb20vYWxleGNlcG9pL2VlZjMwMWE1NmU1ZTQwODI2YThhNDE2Y2JmYjY4NGU2
PC9hPjxicj48YnI+RGlmZiBzaG93cyBzb21lIG5ldyAmcXVvdDtTQUUgSHVudGluZyBhbmQgUGVj
a2luZyZxdW90OyBhbGdvcml0aG0gdXNlZCBhbmQgYSAmcXVvdDtBUCBkaWQgbm90IGluY2x1ZGUg
Z3JvdXAgbnVtYmVyIGluIHJlc3BvbnNlISZxdW90OyBpbmZvLCB0aG91Z2ggbm90IHN1cmUgaWYg
cmVsYXRlZC48L2Rpdj48L2Jsb2NrcXVvdGU+PC9kaXY+PC9ibG9ja3F1b3RlPjwvZGl2PjwvZGl2
PjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2PkluIHlvdXIgY2FzZSB0aGUgZWZmZWN0
aXZlIGRpZmZlcmVuY2UgYmV0d2VlbiBJV0QgMS4xNiBhbmQgMS4xNSBpcyB0aGF0IHdlIG5vdyB0
cnkgU0FFIGdyb3VwcyBpbiBkZWNlbmRpbmcgb3JkZXIuIFRoaXMgaXMgYmVjYXVzZSBoaWdoZXIg
Z3JvdXAgbnVtYmVycyBhcmUgbW9yZSBzZWN1cmUuIEJVVCB0aGUgb25seSBncm91cCB0aGF0IGlz
IHJlcXVpcmVkIGZvciBhIGRldmljZSB0byBzdXBwb3J0IGlzIGdyb3VwIDE5LCB3aGljaCBpdCBz
ZWVtcyB5b3VyIEFQIGZhbGxzIHVuZGVyLiBTbyB3ZSBoYXZlIHRoaXMgc2l0dWF0aW9uIHdoZXJl
IHdlIHRyeSBncm91cCAyMCwgZmFpbCwgdGhlbiB0cnkgMTksIGJ1dCBzb21ldGhpbmcgZWxzZSBn
b2VzIHdyb25nLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+V2UgZG9uJiMzOTt0IHRoaW5rIElX
RCBpcyBiZWhhdmluZyBvdXQgb2Ygd2hhdCB0aGUgc3BlYyByZXF1cmllcyBpbiB0aGlzIHNpdHVh
dGlvbiAoYW5kIHdlIGV2ZW4gdGVzdCBmb3IgdGhpcyByZWplY3RlZCBncm91cCBzY2VuYXJpbykg
YnV0IHRoZXJlIGFyZSBzZXZlcmFsIHJlZCBmbGFnIGNvbW1pdHMgaW4gaG9zdGFwZCBmcm9tIDIw
MTgvMjAxOSB3aGljaCBkZXNjcmliZSBmaXhpbmcgc29tZSBiZWhhdmlvciB0aGF0IHNvdW5kcyBz
aW1pbGFyIHRvIHRoaXMuIEl0cyBkaWZmaWN1bHQgdG8ga25vdyBiZWNhdXNlIHdlIGRvbiYjMzk7
dCBoYXZlIHlvdXIgQVAmIzM5O3MgaG9zdGFwZCBvciBrZXJuZWwgdmVyc2lvbiB0byB0cnkgb3V0
IG91cnNlbHZlcy48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PnRsO2RyPC9kaXY+PGRpdj48YnI+
PC9kaXY+PGRpdj5XZSB0aGluayB3ZSBjYW4gJiMzOTtmaXgmIzM5OyB0aGlzIGJ5IHNpbXBseSB1
c2luZyBncm91cCAxOSBieSBkZWZhdWx0IChvciBhIGNvbmZpZyBvcHRpb24pIGJ1dCB0aGF0cyBu
b3Qgb3B0aW1hbCBzaW5jZSB5b3UgcmVhbGx5IHdhbnQgdG8gdXNlIHRoZSBtb3N0IHNlY3VyZSBn
cm91cCBpZiBpdCBpcyBhdmFpbGFibGUuIFdoYXQgd2UgY2FuIGRvIHRvIHZlcmlmeSB0aGF0IHlv
dXIgQVAgaXMgdG8gYmxhbWUgaXMgdHJ5IHdwYV9zdXBwbGljYW50IGFuZCBpbmNsdWRlIHRoaXMg
b3B0aW9uOjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+c2FlX2dyb3Vwcz0yMCAxOTwvZGl2Pjxk
aXY+PGJyPjwvZGl2PjxkaXY+VGhpcyAqc2hvdWxkKiB0cnkgZ3JvdXAgMjAgZmlyc3QgYW5kIGJl
aGF2ZSBzaW1pbGFybHkgdG8gSVdELiBJZiB0aGlzIGFsc28gcmVzdWx0cyBpbiB0aGUgc2FtZSBp
c3N1ZSB3ZSBrbm93IHRoZSBBUCBpcyB0byBibGFtZS4gS25vd2luZyB0aGlzIHdpbGwgYXQgbGVh
c3QgZ2l2ZSB1cyBzb21lIGp1c3RpZmljYXRpb24gZm9yIGFkZGluZyBhIGNvbmZpZyBvcHRpb24g
YXMgYSBmaXguPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5UaGFua3MsPC9kaXY+PGRpdj5KYW1l
czwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PHNwYW4+PC9zcGFuPjwvZGl2PjwvZGl2Pgo8L2Js
b2NrcXVvdGU+PC9kaXY+Cg==

--===============5930130465923469692==--

