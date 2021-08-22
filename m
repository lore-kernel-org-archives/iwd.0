Content-Type: multipart/mixed; boundary="===============2723838096815914694=="
MIME-Version: 1.0
From: Alex Cepoi <alex.cepoi@gmail.com>
Subject: Re: Failed to connect to WPA3 network after update to iwd 1.16
Date: Mon, 23 Aug 2021 00:17:56 +0100
Message-ID: <CAJtNWJhStLK_Kqa2uS9OPEv-vPLpnrK09c+N2vjtyPEvPKJeXw@mail.gmail.com>
In-Reply-To: <22f7a9d9-c52e-44c7-2541-f8f4b451a610@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============2723838096815914694==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Sure thing:
https://gist.github.com/alexcepoi/83511b1c128767722ec8d6b50d1f66a7

Does that help?

On Sun, 22 Aug 2021 at 19:36, Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Alex,
>
> > Diff shows some new "SAE Hunting and Pecking" algorithm used and a "AP
> did not
> > include group number in response!" info, though not sure if related.
>
> It is.  Looks like the Nest advertises SAE H2E support and we try to use
> that
> but something goes wrong.  Can you capture a log with iwmon?
>
> https://iwd.wiki.kernel.org/debugging
>
> Regards,
> -Denis
>

--===============2723838096815914694==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+U3VyZSB0aGluZzrCoDxhIGhyZWY9Imh0dHBzOi8vZ2lzdC5naXRodWIu
Y29tL2FsZXhjZXBvaS84MzUxMWIxYzEyODc2NzcyMmVjOGQ2YjUwZDFmNjZhNyI+aHR0cHM6Ly9n
aXN0LmdpdGh1Yi5jb20vYWxleGNlcG9pLzgzNTExYjFjMTI4NzY3NzIyZWM4ZDZiNTBkMWY2NmE3
PC9hPjxkaXY+PGJyPjwvZGl2PjxkaXY+RG9lcyB0aGF0IGhlbHA/PC9kaXY+PC9kaXY+PGJyPjxk
aXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48ZGl2IGRpcj0ibHRyIiBjbGFzcz0iZ21haWxfYXR0ciI+
T24gU3VuLCAyMiBBdWcgMjAyMSBhdCAxOTozNiwgRGVuaXMgS2VuemlvciAmbHQ7PGEgaHJlZj0i
bWFpbHRvOmRlbmtlbnpAZ21haWwuY29tIj5kZW5rZW56QGdtYWlsLmNvbTwvYT4mZ3Q7IHdyb3Rl
Ojxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46
MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7
cGFkZGluZy1sZWZ0OjFleCI+SGkgQWxleCw8YnI+Cjxicj4KJmd0OyBEaWZmIHNob3dzIHNvbWUg
bmV3ICZxdW90O1NBRSBIdW50aW5nIGFuZCBQZWNraW5nJnF1b3Q7IGFsZ29yaXRobSB1c2VkIGFu
ZCBhICZxdW90O0FQIGRpZCBub3QgPGJyPgomZ3Q7IGluY2x1ZGUgZ3JvdXAgbnVtYmVyIGluIHJl
c3BvbnNlISZxdW90OyBpbmZvLCB0aG91Z2ggbm90IHN1cmUgaWYgcmVsYXRlZC48YnI+Cjxicj4K
SXQgaXMuwqAgTG9va3MgbGlrZSB0aGUgTmVzdCBhZHZlcnRpc2VzIFNBRSBIMkUgc3VwcG9ydCBh
bmQgd2UgdHJ5IHRvIHVzZSB0aGF0IDxicj4KYnV0IHNvbWV0aGluZyBnb2VzIHdyb25nLsKgIENh
biB5b3UgY2FwdHVyZSBhIGxvZyB3aXRoIGl3bW9uPzxicj4KPGJyPgo8YSBocmVmPSJodHRwczov
L2l3ZC53aWtpLmtlcm5lbC5vcmcvZGVidWdnaW5nIiByZWw9Im5vcmVmZXJyZXIiIHRhcmdldD0i
X2JsYW5rIj5odHRwczovL2l3ZC53aWtpLmtlcm5lbC5vcmcvZGVidWdnaW5nPC9hPjxicj4KPGJy
PgpSZWdhcmRzLDxicj4KLURlbmlzPGJyPgo8L2Jsb2NrcXVvdGU+PC9kaXY+Cg==

--===============2723838096815914694==--

