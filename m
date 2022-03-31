Content-Type: multipart/mixed; boundary="===============0216180491059171884=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: Re: iwd failes to compile
Date: Wed, 30 Mar 2022 17:25:30 -0700
Message-ID: <67fdf4740a92b1c4e981643622e98296fa81cc66.camel@gmail.com>
In-Reply-To: 20220331091212.7_3UMxwRSEuBRBC3oK5XAA@dayo05.hanmail.net

--===============0216180491059171884==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2022-03-31 at 09:12 +0900, Jimin Kim wrote:
> I got error on =

> =EF=BB=BF
> =EF=BB=BFGenerated manual page src/iwd.8 does not exist
> make[1]: *** [Makefile:3877: src/iwd.8] Error 1
> make: *** [Makefile:1570: all] Error 2
> =EF=BB=BF
> =EF=BB=BFwhen I use `make` to compile the iwd. How to solve this problem?

It failed building the man pages. You can either install rst2man, for
ubuntu/fedora (probably others) this is the 'python-docutils' package.
Alternatively you can just disable the man pages during configuration
with:

./bootstrap-configure --disable-manual-pages

> =EF=BB=BF
> =EF=BB=BFI've followed https://iwd.wiki.kernel.org/gettingstarted this
> document on wiki.

We'll get this updated. Thanks.

> =EF=BB=BF
> =EF=BB=BFThanks.
> =EF=BB=BF
> =EF=BB=BFJimin Kim
> =EF=BB=BF
> _______________________________________________
> iwd mailing list -- iwd(a)lists.01.org
> To unsubscribe send an email to iwd-leave(a)lists.01.org


--===============0216180491059171884==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGh0bWw+PGhlYWQ+CiAgICA8c3R5bGU+CiAgICAgICAgcHttYXJnaW4tdG9wOjA7bWFyZ2luLWJv
dHRvbTowfQogICAgPC9zdHlsZT4KPC9oZWFkPgo8Ym9keT48ZGl2Pk9uIFRodSwgMjAyMi0wMy0z
MSBhdCAwOToxMiArMDkwMCwgSmltaW4gS2ltIHdyb3RlOjwvZGl2PjxibG9ja3F1b3RlIHR5cGU9
ImNpdGUiIHN0eWxlPSJtYXJnaW46MCAwIDAgLjhleDsgYm9yZGVyLWxlZnQ6MnB4ICM3MjlmY2Yg
c29saWQ7cGFkZGluZy1sZWZ0OjFleCI+PGRpdiBzdHlsZT0iY29sb3I6IzExMTtmb250LWZhbWls
eTpBcHBsZSBTRCBHb3RoaWMgTmVvLE1hbGd1biBHb3RoaWMsJ+unkeydgCDqs6DrlJUnLHNhbnMt
c2VyaWY7Zm9udC1zaXplOjEwcHQ7bGluZS1oZWlnaHQ6MS41OyI+PHA+SSBnb3QgZXJyb3Igb24g
PGJyPjwvcD48cD7vu788YnI+PC9wPjxwPu+7v0dlbmVyYXRlZCBtYW51YWwgcGFnZSBzcmMvaXdk
LjggZG9lcyBub3QgZXhpc3Q8YnI+bWFrZVsxXTogKioqIFtNYWtlZmlsZTozODc3OiBzcmMvaXdk
LjhdIEVycm9yIDE8YnI+bWFrZTogKioqIFtNYWtlZmlsZToxNTcwOiBhbGxdIEVycm9yIDI8L3A+
PHA+77u/PC9wPjxwPu+7v3doZW4gSSB1c2UgYG1ha2VgIHRvIGNvbXBpbGUgdGhlIGl3ZC4gSG93
IHRvIHNvbHZlIHRoaXMgcHJvYmxlbT88L3A+PC9kaXY+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwv
ZGl2PjxkaXY+SXQgZmFpbGVkIGJ1aWxkaW5nIHRoZSBtYW4gcGFnZXMuIFlvdSBjYW4gZWl0aGVy
IGluc3RhbGwgcnN0Mm1hbiwgZm9yIHVidW50dS9mZWRvcmEgKHByb2JhYmx5IG90aGVycykgdGhp
cyBpcyB0aGUgJ3B5dGhvbi1kb2N1dGlscycgcGFja2FnZS4gQWx0ZXJuYXRpdmVseSB5b3UgY2Fu
IGp1c3QgZGlzYWJsZSB0aGUgbWFuIHBhZ2VzIGR1cmluZyBjb25maWd1cmF0aW9uIHdpdGg6PC9k
aXY+PGRpdj48YnI+PC9kaXY+PGRpdj4uL2Jvb3RzdHJhcC1jb25maWd1cmUgLS1kaXNhYmxlLW1h
bnVhbC1wYWdlczwvZGl2PjxkaXY+PGJyPjwvZGl2PjxibG9ja3F1b3RlIHR5cGU9ImNpdGUiIHN0
eWxlPSJtYXJnaW46MCAwIDAgLjhleDsgYm9yZGVyLWxlZnQ6MnB4ICM3MjlmY2Ygc29saWQ7cGFk
ZGluZy1sZWZ0OjFleCI+PGRpdiBzdHlsZT0iY29sb3I6IzExMTtmb250LWZhbWlseTpBcHBsZSBT
RCBHb3RoaWMgTmVvLE1hbGd1biBHb3RoaWMsJ+unkeydgCDqs6DrlJUnLHNhbnMtc2VyaWY7Zm9u
dC1zaXplOjEwcHQ7bGluZS1oZWlnaHQ6MS41OyI+PHA+77u/PC9wPjxwPu+7v0kndmUgZm9sbG93
ZWQgPGEgdGFyZ2V0PSJfYmxhbmsiIGhyZWY9Imh0dHBzOi8vaXdkLndpa2kua2VybmVsLm9yZy9n
ZXR0aW5nc3RhcnRlZCIgY2xhc3M9InR4LWxpbmsiIHJlbD0ibm9vcGVuZXIgbm9yZWZlcnJlciI+
aHR0cHM6Ly9pd2Qud2lraS5rZXJuZWwub3JnL2dldHRpbmdzdGFydGVkPC9hPiB0aGlzIGRvY3Vt
ZW50IG9uIHdpa2kuPC9wPjwvZGl2PjwvYmxvY2txdW90ZT48ZGl2Pjxicj48L2Rpdj48ZGl2Pldl
J2xsIGdldCB0aGlzIHVwZGF0ZWQuIFRoYW5rcy48L2Rpdj48ZGl2Pjxicj48L2Rpdj48YmxvY2tx
dW90ZSB0eXBlPSJjaXRlIiBzdHlsZT0ibWFyZ2luOjAgMCAwIC44ZXg7IGJvcmRlci1sZWZ0OjJw
eCAjNzI5ZmNmIHNvbGlkO3BhZGRpbmctbGVmdDoxZXgiPjxkaXYgc3R5bGU9ImNvbG9yOiMxMTE7
Zm9udC1mYW1pbHk6QXBwbGUgU0QgR290aGljIE5lbyxNYWxndW4gR290aGljLCfrp5HsnYAg6rOg
65SVJyxzYW5zLXNlcmlmO2ZvbnQtc2l6ZToxMHB0O2xpbmUtaGVpZ2h0OjEuNTsiPjxwPu+7vzwv
cD48cD7vu79UaGFua3MuPC9wPjxwPu+7vzwvcD48cD7vu79KaW1pbiBLaW08YnI+PC9wPjxwPu+7
vzxicj48L3A+PC9kaXY+PGRpdj48aW1nIHNyYz0iaHR0cHM6Ly9jb25maXJtLm1haWwuZGF1bS5u
ZXQvY29uZmlybWFwaS92MS91c2Vycy9kYXlvMDUlNDBoYW5tYWlsJTJFbmV0L2NtYWlscy8yMDIy
MDMzMTA5MTIxMiUyRTdfM1VNeHdSU0V1QlJCQzNvSzVYQUElNDBkYXlvMDUlMkVoYW5tYWlsJTJF
bmV0L3JlY2lwaWVudHMvaXdkJTQwbGlzdHMlMkUwMSUyRW9yZyI+PC9kaXY+PGRpdj5fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXzxicj48L2Rpdj48ZGl2Pml3
ZCBtYWlsaW5nIGxpc3QgLS0gPGEgaHJlZj0ibWFpbHRvOml3ZEBsaXN0cy4wMS5vcmciPml3ZEBs
aXN0cy4wMS5vcmc8L2E+PGJyPjwvZGl2PjxkaXY+VG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFp
bCB0byA8YSBocmVmPSJtYWlsdG86aXdkLWxlYXZlQGxpc3RzLjAxLm9yZyI+aXdkLWxlYXZlQGxp
c3RzLjAxLm9yZzwvYT48YnI+PC9kaXY+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwvZGl2PjxkaXY+
PHNwYW4+PC9zcGFuPjwvZGl2PjwvYm9keT48L2h0bWw+Cg==

--===============0216180491059171884==--

