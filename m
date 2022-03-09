Content-Type: multipart/mixed; boundary="===============8875113934852854114=="
MIME-Version: 1.0
From: wen zhang <zhw2101024 at gmail.com>
To: iwd at lists.01.org
Subject: Re: Unable to build ELL with OpenSSL 3
Date: Thu, 10 Mar 2022 07:56:03 +0800
Message-ID: <CAKjfnjrEaMmk-=64ok9mrH_kFS5FTJ0ubh1u0myRLzBh5D2OkQ@mail.gmail.com>
In-Reply-To: c1597d43bd76de5df8d7db5e10721941e053f779.camel@gmail.com

--===============8875113934852854114==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

James Prestwood <prestwoj(a)gmail.com> =E4=BA=8E2022=E5=B9=B43=E6=9C=8810=
=E6=97=A5=E5=91=A8=E5=9B=9B 02:04=E5=86=99=E9=81=93=EF=BC=9A

> Hi,
>
> On Wed, 2022-03-09 at 18:36 +0800, wen zhang wrote:
>
> I tried to build ELL library on my system built following LFS 11.1
> <https://www.linuxfromscratch.org/lfs/view/stable-systemd/>, but the make
> command failed. Adding V=3D1 to the make command show one openssl command
> failed to finish.
>
> openssl pkcs8 -in unit/cert-client-key-pkcs8.pem -out
> unit/cert-client-key-pkcs8-v2-des.pem -topk8 -v2 des-cbc -v2prf
> hmacWithSHA1 -passout pass:abc
>
> Maybe something need to migrate from OpenSSL 1 to OpenSSL 3?
>
>
> So it appears DES was removed from OpenSSL3 as a built in module [1]. I'm
> guessing there is some way to compile this in, but the documentation also
> mentions some runtime legacy provider. So I think you'll need to rebuild
> openssl with DES built in or figure out a way to enable this provider. I'm
> thinking we do want to support the default OpenSSL3 build at some point in
> the future, but I'm not sure if our build system can enable this feature
> automatically or not.
>
> One thing to note is that OpenSSL is only used to verify ELL's crypto APIs
> in unit testing. So this failure should not block you from using the ELL
> API or IWD. And for IWD specifically all the unit tests build with OpenSS=
L3
> since none use DES.
>
> Also, there is a mailing list specific to ELL ell(a)lists.01.org.
> <ell(a)lists.01.org>
>
> [1] https://wiki.openssl.org/index.php/OpenSSL_3.0#Providers
>
> _______________________________________________
> iwd mailing list -- iwd(a)lists.01.org
> To unsubscribe send an email to iwd-leave(a)lists.01.org
>
> Thanks a lot! I'll try your method. It's also great to have a mailing list
> specific to ELL.
>

--===============8875113934852854114==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+SmFtZXMgUHJlc3R3b29kICZsdDs8YSBocmVm
PSJtYWlsdG86cHJlc3R3b2pAZ21haWwuY29tIj5wcmVzdHdvakBnbWFpbC5jb208L2E+Jmd0OyDk
uo4yMDIy5bm0M+aciDEw5pel5ZGo5ZubIDAyOjA05YaZ6YGT77yaPGJyPjwvZGl2PjxkaXYgY2xh
c3M9ImdtYWlsX3F1b3RlIj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJt
YXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0
LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+PGRpdj48ZGl2PkhpLDwvZGl2PjxkaXY+PGJyPjwvZGl2
PjxkaXY+T24gV2VkLCAyMDIyLTAzLTA5IGF0IDE4OjM2ICswODAwLCB3ZW4gemhhbmcgd3JvdGU6
PC9kaXY+PGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAw
LjhleDtib3JkZXItbGVmdDoycHggc29saWQgcmdiKDExNCwxNTksMjA3KTtwYWRkaW5nLWxlZnQ6
MWV4Ij48ZGl2IGRpcj0ibHRyIj48ZGl2PkkgdHJpZWQgdG8gYnVpbGQgRUxMIGxpYnJhcnkgb24g
bXkgc3lzdGVtIGJ1aWx0IGZvbGxvd2luZyA8YSBocmVmPSJodHRwczovL3d3dy5saW51eGZyb21z
Y3JhdGNoLm9yZy9sZnMvdmlldy9zdGFibGUtc3lzdGVtZC8iIHRhcmdldD0iX2JsYW5rIj5MRlMg
MTEuMTwvYT4sIGJ1dCB0aGUgbWFrZSBjb21tYW5kIGZhaWxlZC4gQWRkaW5nIFY9MSB0byB0aGUg
bWFrZSBjb21tYW5kIHNob3cgb25lIG9wZW5zc2wgY29tbWFuZCBmYWlsZWQgdG8gZmluaXNoLjwv
ZGl2PjxibG9ja3F1b3RlIHR5cGU9ImNpdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44
ZXg7Ym9yZGVyLWxlZnQ6MnB4IHNvbGlkIHJnYigxMTQsMTU5LDIwNyk7cGFkZGluZy1sZWZ0OjFl
eCI+PGRpdj5vcGVuc3NsIHBrY3M4IC1pbiB1bml0L2NlcnQtY2xpZW50LWtleS1wa2NzOC5wZW0g
LW91dCB1bml0L2NlcnQtY2xpZW50LWtleS1wa2NzOC12Mi1kZXMucGVtIC10b3BrOCAtdjIgZGVz
LWNiYyAtdjJwcmYgaG1hY1dpdGhTSEExIC1wYXNzb3V0IHBhc3M6YWJjPC9kaXY+PGJyPjwvYmxv
Y2txdW90ZT48ZGl2Pk1heWJlIHNvbWV0aGluZyBuZWVkIHRvIG1pZ3JhdGUgZnJvbSBPcGVuU1NM
IDEgdG8gT3BlblNTTCAzPyA8YnI+PC9kaXY+PC9kaXY+PC9ibG9ja3F1b3RlPjxkaXY+PGJyPjwv
ZGl2PjxkaXY+U28gaXQgYXBwZWFycyBERVMgd2FzIHJlbW92ZWQgZnJvbSBPcGVuU1NMMyBhcyBh
IGJ1aWx0IGluIG1vZHVsZSBbMV0uIEkmIzM5O20gZ3Vlc3NpbmcgdGhlcmUgaXMgc29tZSB3YXkg
dG8gY29tcGlsZSB0aGlzIGluLCBidXQgdGhlIGRvY3VtZW50YXRpb24gYWxzbyBtZW50aW9ucyBz
b21lIHJ1bnRpbWUgbGVnYWN5IHByb3ZpZGVyLiBTbyBJIHRoaW5rIHlvdSYjMzk7bGwgbmVlZCB0
byByZWJ1aWxkIG9wZW5zc2wgd2l0aCBERVMgYnVpbHQgaW4gb3IgZmlndXJlIG91dCBhIHdheSB0
byBlbmFibGUgdGhpcyBwcm92aWRlci4gSSYjMzk7bSB0aGlua2luZyB3ZSBkbyB3YW50IHRvIHN1
cHBvcnQgdGhlIGRlZmF1bHQgT3BlblNTTDMgYnVpbGQgYXQgc29tZSBwb2ludCBpbiB0aGUgZnV0
dXJlLCBidXQgSSYjMzk7bSBub3Qgc3VyZSBpZiBvdXIgYnVpbGQgc3lzdGVtIGNhbiBlbmFibGUg
dGhpcyBmZWF0dXJlIGF1dG9tYXRpY2FsbHkgb3Igbm90LsKgPC9kaXY+PGRpdj48YnI+PC9kaXY+
PGRpdj5PbmUgdGhpbmcgdG8gbm90ZSBpcyB0aGF0IE9wZW5TU0wgaXMgb25seSB1c2VkIHRvIHZl
cmlmeSBFTEwmIzM5O3MgY3J5cHRvIEFQSXMgaW4gdW5pdCB0ZXN0aW5nLiBTbyB0aGlzIGZhaWx1
cmUgc2hvdWxkIG5vdCBibG9jayB5b3UgZnJvbSB1c2luZyB0aGUgRUxMIEFQSSBvciBJV0QuIEFu
ZCBmb3IgSVdEIHNwZWNpZmljYWxseSBhbGwgdGhlIHVuaXQgdGVzdHMgYnVpbGQgd2l0aCBPcGVu
U1NMMyBzaW5jZSBub25lIHVzZSBERVMuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5BbHNvLCB0
aGVyZSBpcyBhIG1haWxpbmcgbGlzdCBzcGVjaWZpYyB0byBFTEzCoDxhIGhyZWY9Im1haWx0bzpl
bGxAbGlzdHMuMDEub3JnIiB0aXRsZT0iQ2xpY2sgdG8gbWFpbCBlbGxAbGlzdHMuMDEub3JnIiBz
dHlsZT0id2hpdGUtc3BhY2U6bm93cmFwIiB0YXJnZXQ9Il9ibGFuayI+ZWxsQGxpc3RzLjAxLm9y
Zy48L2E+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5bMV3CoDxhIGhyZWY9Imh0dHBzOi8vd2lr
aS5vcGVuc3NsLm9yZy9pbmRleC5waHAvT3BlblNTTF8zLjAjUHJvdmlkZXJzIiB0YXJnZXQ9Il9i
bGFuayI+aHR0cHM6Ly93aWtpLm9wZW5zc2wub3JnL2luZGV4LnBocC9PcGVuU1NMXzMuMCNQcm92
aWRlcnM8L2E+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGJsb2NrcXVvdGUgdHlwZT0iY2l0ZSIgc3R5
bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDtib3JkZXItbGVmdDoycHggc29saWQgcmdiKDEx
NCwxNTksMjA3KTtwYWRkaW5nLWxlZnQ6MWV4Ij48ZGl2Pl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fPGJyPjwvZGl2PjxkaXY+aXdkIG1haWxpbmcgbGlzdCAt
LSA8YSBocmVmPSJtYWlsdG86aXdkQGxpc3RzLjAxLm9yZyIgdGFyZ2V0PSJfYmxhbmsiPml3ZEBs
aXN0cy4wMS5vcmc8L2E+PGJyPjwvZGl2PjxkaXY+VG8gdW5zdWJzY3JpYmUgc2VuZCBhbiBlbWFp
bCB0byA8YSBocmVmPSJtYWlsdG86aXdkLWxlYXZlQGxpc3RzLjAxLm9yZyIgdGFyZ2V0PSJfYmxh
bmsiPml3ZC1sZWF2ZUBsaXN0cy4wMS5vcmc8L2E+PGJyPjwvZGl2PjwvYmxvY2txdW90ZT48ZGl2
PgpUaGFua3MgYSBsb3QhIEkmIzM5O2xsIHRyeSB5b3VyIG1ldGhvZC4gSXQmIzM5O3MgYWxzbyBn
cmVhdCB0byBoYXZlIGEgCm1haWxpbmcgbGlzdCBzcGVjaWZpYyB0byBFTEwuCgo8L2Rpdj48ZGl2
PjxzcGFuPjwvc3Bhbj48L2Rpdj48L2Rpdj4KPC9ibG9ja3F1b3RlPjwvZGl2PjwvZGl2Pgo=

--===============8875113934852854114==--

