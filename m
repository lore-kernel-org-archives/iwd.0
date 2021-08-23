Content-Type: multipart/mixed; boundary="===============8827816188377751633=="
MIME-Version: 1.0
From: Tomasz =?unknown-8bit?q?K=C5=82oczko?= <kloczko.tomasz@gmail.com>
Subject: Fwd: iwd 1.17 test suite is failing
Date: Mon, 23 Aug 2021 17:44:46 +0100
Message-ID: <CABB28Cw8g=9_LzURexc3bx8ZmtejxyC7oWJM4JfV-FZ+=f34+g@mail.gmail.com>
In-Reply-To: <CABB28Cw69zjAgynZNZi2S5-EYvaPDous=fZM9azfkEMrExBXsQ@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8827816188377751633==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Forgot add iwd@
Resending reply to the list as well

---------- Forwarded message ---------
From: Tomasz K=C5=82oczko <kloczko.tomasz@gmail.com>
Date: Mon, 23 Aug 2021 at 17:42
Subject: Re: iwd 1.17 test suite is failing
To: Denis Kenzior <denkenz@gmail.com>


On Mon, 23 Aug 2021 at 14:58, Denis Kenzior <denkenz@gmail.com> wrote:
[..]

> This would have shown up earliest at iwd 1.16.  However, I'm not sure what
> this
> is about?  We use
> unit_test_sae_LDFLAGS =3D -Wl,-wrap,l_ecc_supported_ike_groups
>
> Perhaps LTO somehow interferes with that?  ell has a unit test that uses
> the
> same mechanism for quite some time..


I should check that am file before I wrote that email :/
Yes, it is a known that gcc issue that LTO is not working with -Wl,-wrap :/

I've been trying to use kind of workaround by add on top typical set of LTO
options passed in $CLAGS, $LDFLAGS, $CC, RANLIB, $NAM by add to CFLAGS
-ffat-lto-objects
and run 'make check unit_test_sae_LDFLAGS=3D"-Wl,-wrap,l_ecc_supported_ike_=
groups
-fno-lto"` but it still fails

[tkloczko(a)barrel iwd-1.17]$ make check unit_test_sae_LDFLAGS=3D"-fno-lto
-Wl,-wrap,l_ecc_supported_ike_groups"
make --no-print-directory check-am
make --no-print-directory check-TESTS
PASS: unit/test-cmac-aes
PASS: unit/test-hmac-md5
PASS: unit/test-hmac-sha1
PASS: unit/test-hmac-sha256
PASS: unit/test-prf-sha1
PASS: unit/test-kdf-sha256
PASS: unit/test-crypto
./build-aux/test-driver: line 107: 741643 Aborted                 (core
dumped) "$@" > $log_file 2>&1
FAIL: unit/test-eapol
PASS: unit/test-mpdu
PASS: unit/test-ie
PASS: unit/test-util
PASS: unit/test-ssid-security
PASS: unit/test-arc4
PASS: unit/test-wsc
PASS: unit/test-eap-mschapv2
PASS: unit/test-eap-sim
PASS: unit/test-sae
PASS: unit/test-p2p
PASS: unit/test-band
PASS: unit/test-client
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
Testsuite summary for iwd 1.17
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
# TOTAL: 20
# PASS:  19
# SKIP:  0
# XFAIL: 0
# FAIL:  1
# XPASS: 0
# ERROR: 0
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
See ./test-suite.log
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
make[3]: *** [Makefile:2661: test-suite.log] Error 1
make[2]: *** [Makefile:2769: check-TESTS] Error 2
make[1]: *** [Makefile:3113: check-am] Error 2
make: *** [Makefile:3115: check] Error 2
[tkloczko(a)barrel iwd-1.17]$ cat ./test-suite.log
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
   iwd 1.17: ./test-suite.log
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D

# TOTAL: 20
# PASS:  19
# SKIP:  0
# XFAIL: 0
# FAIL:  1
# XPASS: 0
# ERROR: 0

.. contents:: :depth: 2

FAIL: unit/test-eapol
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

test-eapol: unit/test-eapol.c:3625: test_ap_sta_hs_event: Assertion `event
!=3D HANDSHAKE_EVENT_FAILED' failed.
FAIL unit/test-eapol (exit status: 134)
So with that work around it at least it does not end with SIGSEV :)

Nevertheless it is only a workaround and I would not recommend apply any
changes for that in iwd automake files.
Simple this is a gcc bug.

> BTW is it possible to organize iwd/eel mirrors on github/gitlab to be
> able
> > submit such an issue without being forced to subscribe to yet another
> mailing
> > list or put in README files details how to submit the issue?
> >
>
> We'll look into it.
>

Thx in advance :)

kloczek
-- =

Tomasz K=C5=82oczko | LinkedIn: http://lnkd.in/FXPWxH

--===============8827816188377751633==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFt
aWx5Om1vbm9zcGFjZSxtb25vc3BhY2UiPkZvcmdvdCBhZGQgaXdkQDwvZGl2PjxkaXYgY2xhc3M9
ImdtYWlsX2RlZmF1bHQiIHN0eWxlPSJmb250LWZhbWlseTptb25vc3BhY2UsbW9ub3NwYWNlIj5S
ZXNlbmRpbmcgcmVwbHkgdG8gdGhlIGxpc3QgYXMgd2VsbDwvZGl2PjxkaXYgY2xhc3M9ImdtYWls
X2RlZmF1bHQiIHN0eWxlPSJmb250LWZhbWlseTptb25vc3BhY2UsbW9ub3NwYWNlIj48c3BhbiBz
dHlsZT0iZm9udC1mYW1pbHk6QXJpYWwsSGVsdmV0aWNhLHNhbnMtc2VyaWYiPjxicj48L3NwYW4+
PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFtaWx5Om1vbm9z
cGFjZSxtb25vc3BhY2UiPjxzcGFuIHN0eWxlPSJmb250LWZhbWlseTpBcmlhbCxIZWx2ZXRpY2Es
c2Fucy1zZXJpZiI+LS0tLS0tLS0tLSBGb3J3YXJkZWQgbWVzc2FnZSAtLS0tLS0tLS08L3NwYW4+
PGJyPjwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX3F1b3RlIj48ZGl2IGRpcj0ibHRyIiBjbGFzcz0i
Z21haWxfYXR0ciI+RnJvbTogPHN0cm9uZyBjbGFzcz0iZ21haWxfc2VuZGVybmFtZSIgZGlyPSJh
dXRvIj5Ub21hc3ogS8WCb2N6a288L3N0cm9uZz4gPHNwYW4gZGlyPSJhdXRvIj4mbHQ7PGEgaHJl
Zj0ibWFpbHRvOmtsb2N6a28udG9tYXN6QGdtYWlsLmNvbSI+a2xvY3prby50b21hc3pAZ21haWwu
Y29tPC9hPiZndDs8L3NwYW4+PGJyPkRhdGU6IE1vbiwgMjMgQXVnIDIwMjEgYXQgMTc6NDI8YnI+
U3ViamVjdDogUmU6IGl3ZCAxLjE3IHRlc3Qgc3VpdGUgaXMgZmFpbGluZzxicj5UbzogRGVuaXMg
S2VuemlvciAmbHQ7PGEgaHJlZj0ibWFpbHRvOmRlbmtlbnpAZ21haWwuY29tIj5kZW5rZW56QGdt
YWlsLmNvbTwvYT4mZ3Q7PGJyPjwvZGl2Pjxicj48YnI+PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9
Imx0ciI+PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6bW9ub3NwYWNlLG1vbm9zcGFjZSI+PHNwYW4g
c3R5bGU9ImZvbnQtZmFtaWx5OkFyaWFsLEhlbHZldGljYSxzYW5zLXNlcmlmIj5PbiBNb24sIDIz
IEF1ZyAyMDIxIGF0IDE0OjU4LCBEZW5pcyBLZW56aW9yICZsdDs8YSBocmVmPSJtYWlsdG86ZGVu
a2VuekBnbWFpbC5jb20iIHRhcmdldD0iX2JsYW5rIj5kZW5rZW56QGdtYWlsLmNvbTwvYT4mZ3Q7
IHdyb3RlOjwvc3Bhbj48L2Rpdj48ZGl2IHN0eWxlPSJmb250LWZhbWlseTptb25vc3BhY2UsbW9u
b3NwYWNlIj48c3BhbiBzdHlsZT0iZm9udC1mYW1pbHk6QXJpYWwsSGVsdmV0aWNhLHNhbnMtc2Vy
aWYiPlsuLl3CoDwvc3Bhbj48L2Rpdj48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9xdW90ZSI+PGJs
b2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAu
OGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDox
ZXgiPlRoaXMgd291bGQgaGF2ZSBzaG93biB1cCBlYXJsaWVzdCBhdCBpd2QgMS4xNi7CoCBIb3dl
dmVyLCBJJiMzOTttIG5vdCBzdXJlIHdoYXQgdGhpcyA8YnI+CmlzIGFib3V0P8KgIFdlIHVzZTxi
cj4KdW5pdF90ZXN0X3NhZV9MREZMQUdTID0gPHNwYW4gY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0
eWxlPSJmb250LWZhbWlseTptb25vc3BhY2UsbW9ub3NwYWNlIj48L3NwYW4+LVdsLC13cmFwLGxf
ZWNjX3N1cHBvcnRlZF9pa2VfZ3JvdXBzPGJyPgo8YnI+ClBlcmhhcHMgTFRPIHNvbWVob3cgaW50
ZXJmZXJlcyB3aXRoIHRoYXQ/wqAgZWxsIGhhcyBhIHVuaXQgdGVzdCB0aGF0IHVzZXMgdGhlIDxi
cj4Kc2FtZSBtZWNoYW5pc20gZm9yIHF1aXRlIHNvbWUgdGltZS4uPC9ibG9ja3F1b3RlPjxkaXY+
PGJyPjwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5Om1vbm9zcGFjZSxtb25vc3BhY2UiPkkg
c2hvdWxkIGNoZWNrIHRoYXQgYW0gZmlsZSBiZWZvcmUgSSB3cm90ZSB0aGF0IGVtYWlsIDovPC9k
aXY+PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6bW9ub3NwYWNlLG1vbm9zcGFjZSI+WWVzLCBpdCBp
cyBhIGtub3duIHRoYXQgZ2NjIGlzc3VlIHRoYXQgTFRPIGlzIG5vdCB3b3JraW5nIHdpdGjCoDxz
cGFuIGNsYXNzPSJnbWFpbF9kZWZhdWx0Ij48L3NwYW4+PHNwYW4gc3R5bGU9ImZvbnQtZmFtaWx5
OkFyaWFsLEhlbHZldGljYSxzYW5zLXNlcmlmIj4tV2wsLXdyYXAgOi88L3NwYW4+PC9kaXY+PGRp
diBzdHlsZT0iZm9udC1mYW1pbHk6bW9ub3NwYWNlLG1vbm9zcGFjZSI+PHNwYW4gc3R5bGU9ImZv
bnQtZmFtaWx5OkFyaWFsLEhlbHZldGljYSxzYW5zLXNlcmlmIj48YnI+PC9zcGFuPjwvZGl2Pjxk
aXYgc3R5bGU9ImZvbnQtZmFtaWx5Om1vbm9zcGFjZSxtb25vc3BhY2UiPjxzcGFuIHN0eWxlPSJm
b250LWZhbWlseTpBcmlhbCxIZWx2ZXRpY2Esc2Fucy1zZXJpZiI+SSYjMzk7dmUgYmVlbiB0cnlp
bmcgdG8gdXNlIGtpbmQgb2Ygd29ya2Fyb3VuZMKgYnkgYWRkIG9uIHRvcCB0eXBpY2FsIHNldCBv
ZiBMVE8gb3B0aW9ucyBwYXNzZWQgaW4gJENMQUdTLCAkTERGTEFHUywgJENDLCBSQU5MSUIsICRO
QU0gYnkgYWRkIHRvIENGTEFHU8KgPC9zcGFuPjxzcGFuIHN0eWxlPSJmb250LWZhbWlseTpBcmlh
bCxIZWx2ZXRpY2Esc2Fucy1zZXJpZiI+LWZmYXQtbHRvLW9iamVjdHPCoCBhbmQgcnVuICYjMzk7
bWFrZSBjaGVja8KgPC9zcGFuPjxzcGFuIHN0eWxlPSJmb250LWZhbWlseTpBcmlhbCxIZWx2ZXRp
Y2Esc2Fucy1zZXJpZiI+dW5pdF90ZXN0X3NhZV9MREZMQUdTPSZxdW90Oy1XbCwtd3JhcCxsX2Vj
Y19zdXBwb3J0ZWRfaWtlX2dyb3VwcyAtZm5vLWx0byZxdW90O2AgYnV0IGl0IHN0aWxsIGZhaWxz
PC9zcGFuPjwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5Om1vbm9zcGFjZSxtb25vc3BhY2Ui
PjxzcGFuIHN0eWxlPSJmb250LWZhbWlseTpBcmlhbCxIZWx2ZXRpY2Esc2Fucy1zZXJpZiI+PGJy
Pjwvc3Bhbj48L2Rpdj48ZGl2IHN0eWxlPSJmb250LWZhbWlseTptb25vc3BhY2UsbW9ub3NwYWNl
Ij5bdGtsb2N6a29AYmFycmVsIGl3ZC0xLjE3XSQgbWFrZSBjaGVjayB1bml0X3Rlc3Rfc2FlX0xE
RkxBR1M9JnF1b3Q7LWZuby1sdG8gLVdsLC13cmFwLGxfZWNjX3N1cHBvcnRlZF9pa2VfZ3JvdXBz
JnF1b3Q7PGJyPm1ha2UgLS1uby1wcmludC1kaXJlY3RvcnkgY2hlY2stYW08YnI+bWFrZSAtLW5v
LXByaW50LWRpcmVjdG9yeSBjaGVjay1URVNUUzxicj5QQVNTOiB1bml0L3Rlc3QtY21hYy1hZXM8
YnI+UEFTUzogdW5pdC90ZXN0LWhtYWMtbWQ1PGJyPlBBU1M6IHVuaXQvdGVzdC1obWFjLXNoYTE8
YnI+UEFTUzogdW5pdC90ZXN0LWhtYWMtc2hhMjU2PGJyPlBBU1M6IHVuaXQvdGVzdC1wcmYtc2hh
MTxicj5QQVNTOiB1bml0L3Rlc3Qta2RmLXNoYTI1Njxicj5QQVNTOiB1bml0L3Rlc3QtY3J5cHRv
PGJyPi4vYnVpbGQtYXV4L3Rlc3QtZHJpdmVyOiBsaW5lIDEwNzogNzQxNjQzIEFib3J0ZWQgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgKGNvcmUgZHVtcGVkKSAmcXVvdDskQCZxdW90OyAmZ3Q7ICRs
b2dfZmlsZSAyJmd0OyZhbXA7MTxicj5GQUlMOiB1bml0L3Rlc3QtZWFwb2w8YnI+UEFTUzogdW5p
dC90ZXN0LW1wZHU8YnI+UEFTUzogdW5pdC90ZXN0LWllPGJyPlBBU1M6IHVuaXQvdGVzdC11dGls
PGJyPlBBU1M6IHVuaXQvdGVzdC1zc2lkLXNlY3VyaXR5PGJyPlBBU1M6IHVuaXQvdGVzdC1hcmM0
PGJyPlBBU1M6IHVuaXQvdGVzdC13c2M8YnI+UEFTUzogdW5pdC90ZXN0LWVhcC1tc2NoYXB2Mjxi
cj5QQVNTOiB1bml0L3Rlc3QtZWFwLXNpbTxicj5QQVNTOiB1bml0L3Rlc3Qtc2FlPGJyPlBBU1M6
IHVuaXQvdGVzdC1wMnA8YnI+UEFTUzogdW5pdC90ZXN0LWJhbmQ8YnI+UEFTUzogdW5pdC90ZXN0
LWNsaWVudDxicj49PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PGJyPlRlc3RzdWl0ZSBzdW1tYXJ5IGZvciBp
d2QgMS4xNzxicj49PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PGJyPiMgVE9UQUw6IDIwPGJyPiMgUEFTUzog
wqAxOTxicj4jIFNLSVA6IMKgMDxicj4jIFhGQUlMOiAwPGJyPiMgRkFJTDogwqAxPGJyPiMgWFBB
U1M6IDA8YnI+IyBFUlJPUjogMDxicj49PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PGJyPlNlZSAuL3Rlc3Qt
c3VpdGUubG9nPGJyPj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT08YnI+bWFrZVszXTogKioqIFtNYWtlZmls
ZToyNjYxOiB0ZXN0LXN1aXRlLmxvZ10gRXJyb3IgMTxicj5tYWtlWzJdOiAqKiogW01ha2VmaWxl
OjI3Njk6IGNoZWNrLVRFU1RTXSBFcnJvciAyPGJyPm1ha2VbMV06ICoqKiBbTWFrZWZpbGU6MzEx
MzogY2hlY2stYW1dIEVycm9yIDI8YnI+bWFrZTogKioqIFtNYWtlZmlsZTozMTE1OiBjaGVja10g
RXJyb3IgMjxicj5bdGtsb2N6a29AYmFycmVsIGl3ZC0xLjE3XSQgY2F0IC4vdGVzdC1zdWl0ZS5s
b2c8YnI+PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT08YnI+wqAgwqBpd2QgMS4xNzog
Li90ZXN0LXN1aXRlLmxvZzxicj49PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PTxicj48
YnI+IyBUT1RBTDogMjA8YnI+IyBQQVNTOiDCoDE5PGJyPiMgU0tJUDogwqAwPGJyPiMgWEZBSUw6
IDA8YnI+IyBGQUlMOiDCoDE8YnI+IyBYUEFTUzogMDxicj4jIEVSUk9SOiAwPGJyPjxicj4uLiBj
b250ZW50czo6IDpkZXB0aDogMjxicj48YnI+RkFJTDogdW5pdC90ZXN0LWVhcG9sPGJyPj09PT09
PT09PT09PT09PT09PT09PTxicj48YnI+dGVzdC1lYXBvbDogdW5pdC90ZXN0LWVhcG9sLmM6MzYy
NTogdGVzdF9hcF9zdGFfaHNfZXZlbnQ6IEFzc2VydGlvbiBgZXZlbnQgIT0gSEFORFNIQUtFX0VW
RU5UX0ZBSUxFRCYjMzk7IGZhaWxlZC48YnI+RkFJTCB1bml0L3Rlc3QtZWFwb2wgKGV4aXQgc3Rh
dHVzOiAxMzQpPC9kaXY+PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6bW9ub3NwYWNlLG1vbm9zcGFj
ZSI+U28gd2l0aCB0aGF0wqB3b3JrIGFyb3VuZCBpdCBhdCBsZWFzdCBpdCBkb2VzIG5vdCBlbmQg
d2l0aCBTSUdTRVYgOik8L2Rpdj48ZGl2IHN0eWxlPSJmb250LWZhbWlseTptb25vc3BhY2UsbW9u
b3NwYWNlIj48YnI+PC9kaXY+PGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6bW9ub3NwYWNlLG1vbm9z
cGFjZSI+TmV2ZXJ0aGVsZXNzIGl0IGlzIG9ubHkgYSB3b3JrYXJvdW5kIGFuZCBJIHdvdWxkIG5v
dCByZWNvbW1lbmQgYXBwbHnCoGFueSBjaGFuZ2VzIGZvciB0aGF0IGluIGl3ZCBhdXRvbWFrZSBm
aWxlcy48L2Rpdj48ZGl2IHN0eWxlPSJmb250LWZhbWlseTptb25vc3BhY2UsbW9ub3NwYWNlIj5T
aW1wbGUgdGhpcyBpcyBhIGdjY8KgYnVnLjwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5Om1v
bm9zcGFjZSxtb25vc3BhY2UiPjxicj48L2Rpdj48YmxvY2txdW90ZSBjbGFzcz0iZ21haWxfcXVv
dGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlk
IHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+CiZndDsgQlRXIGlzIGl0IHBvc3Np
YmxlIHRvIG9yZ2FuaXplIGl3ZC9lZWwgbWlycm9ycyBvbiBnaXRodWIvZ2l0bGFiIHRvIGJlIGFi
bGUgPGJyPgomZ3Q7IHN1Ym1pdCBzdWNoIGFuIGlzc3VlIHdpdGhvdXQgYmVpbmcgZm9yY2VkIHRv
IHN1YnNjcmliZSB0byB5ZXQgYW5vdGhlciBtYWlsaW5nIDxicj4KJmd0OyBsaXN0IG9yIHB1dCBp
biBSRUFETUUgZmlsZXMgZGV0YWlscyBob3cgdG8gc3VibWl0IHRoZSBpc3N1ZT88YnI+CiZndDsg
PGJyPgo8YnI+CldlJiMzOTtsbCBsb29rIGludG8gaXQuPGJyPjwvYmxvY2txdW90ZT48ZGl2Pjxi
cj48L2Rpdj48ZGl2IHN0eWxlPSJmb250LWZhbWlseTptb25vc3BhY2UsbW9ub3NwYWNlIj5UaHgg
aW4gYWR2YW5jZSA6KTwvZGl2PjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5Om1vbm9zcGFjZSxtb25v
c3BhY2UiPjxicj48L2Rpdj48ZGl2Pjxmb250IGZhY2U9Im1vbm9zcGFjZSwgbW9ub3NwYWNlIj48
c3BhbiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFtaWx5Om1vbm9zcGFjZSxt
b25vc3BhY2UiPmtsb2N6ZWs8L3NwYW4+PGJyPi0twqA8L2ZvbnQ+PC9kaXY+PGRpdiBkaXI9Imx0
ciI+PGZvbnQgZmFjZT0ibW9ub3NwYWNlLCBtb25vc3BhY2UiPlRvbWFzeiBLxYJvY3prbyB8IExp
bmtlZEluOsKgPGEgaHJlZj0iaHR0cDovL2xua2QuaW4vRlhQV3hIIiBzdHlsZT0idGV4dC1kZWNv
cmF0aW9uLWxpbmU6bm9uZSIgdGFyZ2V0PSJfYmxhbmsiPjxzcGFuIHN0eWxlPSJmb250LXNpemU6
MTNweDtiYWNrZ3JvdW5kLWNvbG9yOnRyYW5zcGFyZW50O3RleHQtZGVjb3JhdGlvbi1saW5lOnVu
ZGVybGluZTt2ZXJ0aWNhbC1hbGlnbjpiYXNlbGluZTt3aGl0ZS1zcGFjZTpwcmUtd3JhcCI+aHR0
cDovL2xua2QuaW4vRlhQV3hIPC9zcGFuPjwvYT48L2ZvbnQ+PC9kaXY+PC9kaXY+PC9kaXY+Cjwv
ZGl2PjwvZGl2Pgo=

--===============8827816188377751633==--

