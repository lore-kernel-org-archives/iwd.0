Content-Type: multipart/mixed; boundary="===============9199531780608631475=="
MIME-Version: 1.0
From: John Zimmermann <me@johnnynator.dev>
Subject: Re: [PATCH] resolve: allow setting default DNS resolver at compile
 time
Date: Sun, 01 Nov 2020 22:33:42 +0100
Message-ID: <f6c6fdb4-0609-44da-b11e-5f8da304a21d@www.fastmail.com>
In-Reply-To: <54ff705b-90bd-52ae-2ffd-a393e4c3bf7a@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============9199531780608631475==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis.

On Wed, Oct 28, 2020, at 9:38 PM, Denis Kenzior wrote:
> Hi John,
> =

> Could you explain the motivation behind this change?  Can't this be accom=
plished =

> easily by shipping a default main.conf?
> =

> Regards,
> -Denis
> =


Yes in theory most of this can be achieved with a main.conf. Our problem is=
, =

that our package manager (xbps) would overwrite already exisiting main.conf=
 files,
since they aren't yet tracked by it.
So patching iwd is our most reliable method that won't break any users conf=
ig.

Regards,
John

--===============9199531780608631475==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PCFET0NUWVBFIGh0bWw+PGh0bWw+PGhlYWQ+PHRpdGxlPjwvdGl0bGU+PHN0eWxlIHR5cGU9InRl
eHQvY3NzIj5wLk1zb05vcm1hbCxwLk1zb05vU3BhY2luZ3ttYXJnaW46MH08L3N0eWxlPjwvaGVh
ZD48Ym9keT48ZGl2PkhpIERlbmlzLjxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pk9uIFdl
ZCwgT2N0IDI4LCAyMDIwLCBhdCA5OjM4IFBNLCBEZW5pcyBLZW56aW9yIHdyb3RlOjxicj48L2Rp
dj48YmxvY2txdW90ZSB0eXBlPSJjaXRlIiBpZD0icXQiIHN0eWxlPSIiPjxkaXY+SGkgSm9obiw8
YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5Db3VsZCB5b3UgZXhwbGFpbiB0aGUgbW90aXZh
dGlvbiBiZWhpbmQgdGhpcyBjaGFuZ2U/Jm5ic3A7IENhbid0IHRoaXMgYmUgYWNjb21wbGlzaGVk
Jm5ic3A7PGJyPjwvZGl2PjxkaXY+ZWFzaWx5IGJ5IHNoaXBwaW5nIGEgZGVmYXVsdCBtYWluLmNv
bmY/PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+UmVnYXJkcyw8YnI+PC9kaXY+PGRpdj4t
RGVuaXM8YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2
PjxkaXY+WWVzIGluIHRoZW9yeSBtb3N0IG9mIHRoaXMgY2FuIGJlIGFjaGlldmVkIHdpdGggYSBt
YWluLmNvbmYuIE91ciBwcm9ibGVtIGlzLCA8YnI+PC9kaXY+PGRpdj50aGF0IG91ciBwYWNrYWdl
IG1hbmFnZXIgKHhicHMpIHdvdWxkIG92ZXJ3cml0ZSBhbHJlYWR5IGV4aXNpdGluZyBtYWluLmNv
bmYgZmlsZXMsPGJyPjwvZGl2PjxkaXY+IHNpbmNlIHRoZXkgYXJlbid0IHlldCB0cmFja2VkIGJ5
IGl0Ljxicj48L2Rpdj48ZGl2PlNvIHBhdGNoaW5nIGl3ZCBpcyBvdXIgbW9zdCByZWxpYWJsZSBt
ZXRob2QgdGhhdCB3b24ndCBicmVhayBhbnkgdXNlcnMgY29uZmlnLjxicj48L2Rpdj48ZGl2Pjxi
cj48L2Rpdj48ZGl2PlJlZ2FyZHMsPGJyPjwvZGl2PjxkaXY+Sm9objxicj48L2Rpdj48L2JvZHk+
PC9odG1sPg==
--===============9199531780608631475==--

