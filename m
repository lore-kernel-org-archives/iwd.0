Content-Type: multipart/mixed; boundary="===============1813955887809514561=="
MIME-Version: 1.0
From: Prestwood, James <james.prestwood@intel.com>
Subject: Re: How to use IWD in my own application?
Date: Fri, 01 Nov 2019 16:56:31 +0000
Message-ID: <f89048b4b3dd4c0f393823eb0e4b282fc3bf0b46.camel@intel.com>
In-Reply-To: <CAL47XF4fVz+81OPeH0V38YkJ_v3XCYev71zCtB138Aoyvt9_YQ@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1813955887809514561==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, 2019-11-01 at 19:50 +0300, Vitold S wrote:
Hello,
I want to use IWD without using iwctl command line interface.
Could you please provide way to use common Wi-FI API with shared library li=
ke Linux common way libiwd.so for invoke in my application?
Thanks.

IWD is a standalone wireless daemon and controlled via D-Bus (this is what =
iwctl itself uses). IWD does not expose any C APIs nor is it meant to be co=
mpiled into a library. D-Bus is going to be your only way of controlling IW=
D.

Thanks,
James


_______________________________________________

iwd mailing list -- iwd(a)lists.01.org<mailto:iwd@lists.01.org>

To unsubscribe send an email to iwd-leave(a)lists.01.org<mailto:iwd-leave(a=
)lists.01.org>


--===============1813955887809514561==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.html"

PGh0bWwgZGlyPSJsdHIiPg0KPGhlYWQ+DQo8bWV0YSBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUi
IGNvbnRlbnQ9InRleHQvaHRtbDsgY2hhcnNldD11dGYtOCI+DQo8L2hlYWQ+DQo8Ym9keSBzdHls
ZT0idGV4dC1hbGlnbjpsZWZ0OyBkaXJlY3Rpb246bHRyOyI+DQo8ZGl2PkhpLDwvZGl2Pg0KPGRp
dj48YnI+DQo8L2Rpdj4NCjxkaXY+T24gRnJpLCAyMDE5LTExLTAxIGF0IDE5OjUwICYjNDM7MDMw
MCwgVml0b2xkIFMgd3JvdGU6PC9kaXY+DQo8YmxvY2txdW90ZSB0eXBlPSJjaXRlIiBzdHlsZT0i
bWFyZ2luOjAgMCAwIC44ZXg7IGJvcmRlci1sZWZ0OjJweCAjNzI5ZmNmIHNvbGlkO3BhZGRpbmct
bGVmdDoxZXgiPg0KPGRpdiBkaXI9Imx0ciI+DQo8ZGl2PkhlbGxvLDwvZGl2Pg0KPGRpdj5JIHdh
bnQgdG8gdXNlIElXRCB3aXRob3V0IHVzaW5nIGl3Y3RsIGNvbW1hbmQgbGluZSBpbnRlcmZhY2Uu
PC9kaXY+DQo8ZGl2PkNvdWxkIHlvdSBwbGVhc2UgcHJvdmlkZSB3YXkgdG8gdXNlIGNvbW1vbiBX
aS1GSSBBUEkgd2l0aCBzaGFyZWQgbGlicmFyeSBsaWtlIExpbnV4IGNvbW1vbiB3YXkgbGliaXdk
LnNvIGZvciBpbnZva2UgaW4gbXkgYXBwbGljYXRpb24/PGJyPg0KPC9kaXY+DQo8ZGl2PlRoYW5r
cy48YnI+DQo8L2Rpdj4NCjwvZGl2Pg0KPC9ibG9ja3F1b3RlPg0KPGRpdj48YnI+DQo8L2Rpdj4N
CjxkaXY+SVdEIGlzIGEgc3RhbmRhbG9uZSB3aXJlbGVzcyBkYWVtb24gYW5kIGNvbnRyb2xsZWQg
dmlhIEQtQnVzICh0aGlzIGlzIHdoYXQgaXdjdGwgaXRzZWxmIHVzZXMpLiBJV0QgZG9lcyBub3Qg
ZXhwb3NlIGFueSBDIEFQSXMgbm9yIGlzIGl0IG1lYW50IHRvIGJlIGNvbXBpbGVkIGludG8gYSBs
aWJyYXJ5LiBELUJ1cyBpcyBnb2luZyB0byBiZSB5b3VyIG9ubHkgd2F5IG9mIGNvbnRyb2xsaW5n
IElXRC48L2Rpdj4NCjxkaXY+PGJyPg0KPC9kaXY+DQo8ZGl2PlRoYW5rcyw8L2Rpdj4NCjxkaXY+
SmFtZXM8L2Rpdj4NCjxkaXY+PGJyPg0KPC9kaXY+DQo8YmxvY2txdW90ZSB0eXBlPSJjaXRlIiBz
dHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7IGJvcmRlci1sZWZ0OjJweCAjNzI5ZmNmIHNvbGlkO3Bh
ZGRpbmctbGVmdDoxZXgiPg0KPHByZT5fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXzwvcHJlPg0KPHByZT5pd2QgbWFpbGluZyBsaXN0IC0tIDxhIGhyZWY9Im1h
aWx0bzppd2RAbGlzdHMuMDEub3JnIj5pd2RAbGlzdHMuMDEub3JnPC9hPjwvcHJlPg0KPHByZT5U
byB1bnN1YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIDxhIGhyZWY9Im1haWx0bzppd2QtbGVhdmVA
bGlzdHMuMDEub3JnIj5pd2QtbGVhdmVAbGlzdHMuMDEub3JnPC9hPjwvcHJlPg0KPHByZT48YnI+
PC9wcmU+DQo8L2Jsb2NrcXVvdGU+DQo8L2JvZHk+DQo8L2h0bWw+DQo=

--===============1813955887809514561==--

