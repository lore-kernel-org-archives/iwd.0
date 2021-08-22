Content-Type: multipart/mixed; boundary="===============3562894195115213169=="
MIME-Version: 1.0
From: Tomasz =?unknown-8bit?q?K=C5=82oczko?= <kloczko.tomasz@gmail.com>
Subject: iwd 1.17 test suite is failing
Date: Sun, 22 Aug 2021 19:55:08 +0100
Message-ID: <CABB28CwPkyQcCrznB2MbEGN5TKMoSvCnaPH5DSY5SJ-YaJe47w@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3562894195115213169==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I think that it started around 1.15.
iwd and eel compiled with LTO.

[tkloczko(a)barrel iwd-1.17]$ make check
make --no-print-directory check-am
make --no-print-directory check-TESTS
PASS: unit/test-cmac-aes
PASS: unit/test-hmac-md5
PASS: unit/test-hmac-sha1
PASS: unit/test-hmac-sha256
PASS: unit/test-prf-sha1
PASS: unit/test-kdf-sha256
PASS: unit/test-crypto
./build-aux/test-driver: line 107: 3860965 Aborted                 (core
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
/bin/sh ./libtool  --tag=3DCC   --mode=3Dlink /usr/bin/gcc  -fvisibility=3D=
hidden
-DUNITDIR=3D\""./unit/"\" -DCERTDIR=3D\""./unit/"\"  -O2 -g
-grecord-gcc-switches -pipe -Wall -Werror=3Dformat-security
-Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIONS
-specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong
-specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dgeneric
-fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection
-fdata-sections -ffunction-sections -flto=3Dauto -flto-partition=3Dnone -Os
-Wl,-wrap,l_ecc_supported_ike_groups -Wl,-z,relro -Wl,--as-needed
-Wl,--gc-sections -Wl,-z,now -specs=3D/usr/lib/rpm/redhat/redhat-hardened-ld
-flto=3Dauto -flto-partition=3Dnone -fuse-linker-plugin -o unit/test-sae
unit/test-sae.o src/sae.o src/crypto.o src/ie.o src/handshake.o src/erp.o
src/util.o src/mpdu.o -lell
libtool: link: /usr/bin/gcc -fvisibility=3Dhidden -DUNITDIR=3D\"./unit/\"
-DCERTDIR=3D\"./unit/\" -O2 -g -grecord-gcc-switches -pipe -Wall
-Werror=3Dformat-security -Wp,-D_FORTIFY_SOURCE=3D2 -Wp,-D_GLIBCXX_ASSERTIO=
NS
-specs=3D/usr/lib/rpm/redhat/redhat-hardened-cc1 -fstack-protector-strong
-specs=3D/usr/lib/rpm/redhat/redhat-annobin-cc1 -m64 -mtune=3Dgeneric
-fasynchronous-unwind-tables -fstack-clash-protection -fcf-protection
-fdata-sections -ffunction-sections -flto=3Dauto -flto-partition=3Dnone -Os
-Wl,-wrap -Wl,l_ecc_supported_ike_groups -Wl,-z -Wl,relro -Wl,--as-needed
-Wl,--gc-sections -Wl,-z -Wl,now
-specs=3D/usr/lib/rpm/redhat/redhat-hardened-ld -flto=3Dauto
-flto-partition=3Dnone -fuse-linker-plugin -o unit/test-sae unit/test-sae.o
src/sae.o src/crypto.o src/ie.o src/handshake.o src/erp.o src/util.o
src/mpdu.o  -lell
/usr/bin/ld: /tmp/cc8uiWzL.lto.o: in function `sae_choose_next_group':
/home/tkloczko/rpmbuild/BUILD/iwd-1.17/src/sae.c:139: undefined reference
to `__wrap_l_ecc_supported_ike_groups'
/usr/bin/ld: /tmp/cc8uiWzL.lto.o: in function `handshake_state_free':
/home/tkloczko/rpmbuild/BUILD/iwd-1.17/src/handshake.c:48: undefined
reference to `__wrap_l_ecc_supported_ike_groups'
/usr/bin/ld: /tmp/cc8uiWzL.lto.o: in function `sae_rx_authenticate':
/home/tkloczko/rpmbuild/BUILD/iwd-1.17/src/sae.c:161: undefined reference
to `__wrap_l_ecc_supported_ike_groups'
collect2: error: ld returned 1 exit status
make[3]: *** [Makefile:2040: unit/test-sae] Error 1
PASS: unit/test-p2p
PASS: unit/test-band
PASS: unit/test-client
make[3]: Target 'test-suite.log' not remade because of errors.
make[2]: *** [Makefile:2769: check-TESTS] Error 2
make[1]: *** [Makefile:3113: check-am] Error 2
make: *** [Makefile:3115: check] Error 2

BTW is it possible to organize iwd/eel mirrors on github/gitlab to be able
submit such an issue without being forced to subscribe to yet another
mailing list or put in README files details how to submit the issue?

kloczek
-- =

Tomasz K=C5=82oczko | LinkedIn: *http://lnkd.in/FXPWxH <http://lnkd.in/FXPW=
xH>*

--===============3562894195115213169==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFt
aWx5Om1vbm9zcGFjZSxtb25vc3BhY2UiPkhpLDwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1
bHQiIHN0eWxlPSJmb250LWZhbWlseTptb25vc3BhY2UsbW9ub3NwYWNlIj48YnI+PC9kaXY+PGRp
diBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFtaWx5Om1vbm9zcGFjZSxtb25v
c3BhY2UiPkkgdGhpbmsgdGhhdCBpdCBzdGFydGVkIGFyb3VuZCAxLjE1LjwvZGl2PjxkaXYgY2xh
c3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPSJmb250LWZhbWlseTptb25vc3BhY2UsbW9ub3NwYWNl
Ij5pd2QgYW5kIGVlbCBjb21waWxlZCB3aXRoIExUTy48L2Rpdj48ZGl2IGNsYXNzPSJnbWFpbF9k
ZWZhdWx0IiBzdHlsZT0iZm9udC1mYW1pbHk6bW9ub3NwYWNlLG1vbm9zcGFjZSI+PGJyPjwvZGl2
PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPSJmb250LWZhbWlseTptb25vc3BhY2Us
bW9ub3NwYWNlIj5bdGtsb2N6a29AYmFycmVsIGl3ZC0xLjE3XSQgbWFrZSBjaGVjazxicj5tYWtl
IC0tbm8tcHJpbnQtZGlyZWN0b3J5IGNoZWNrLWFtPGJyPm1ha2UgLS1uby1wcmludC1kaXJlY3Rv
cnkgY2hlY2stVEVTVFM8YnI+UEFTUzogdW5pdC90ZXN0LWNtYWMtYWVzPGJyPlBBU1M6IHVuaXQv
dGVzdC1obWFjLW1kNTxicj5QQVNTOiB1bml0L3Rlc3QtaG1hYy1zaGExPGJyPlBBU1M6IHVuaXQv
dGVzdC1obWFjLXNoYTI1Njxicj5QQVNTOiB1bml0L3Rlc3QtcHJmLXNoYTE8YnI+UEFTUzogdW5p
dC90ZXN0LWtkZi1zaGEyNTY8YnI+UEFTUzogdW5pdC90ZXN0LWNyeXB0bzxicj4uL2J1aWxkLWF1
eC90ZXN0LWRyaXZlcjogbGluZSAxMDc6IDM4NjA5NjUgQWJvcnRlZCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCAoY29yZSBkdW1wZWQpICZxdW90OyRAJnF1b3Q7ICZndDsgJGxvZ19maWxlIDImZ3Q7
JmFtcDsxPGJyPkZBSUw6IHVuaXQvdGVzdC1lYXBvbDxicj5QQVNTOiB1bml0L3Rlc3QtbXBkdTxi
cj5QQVNTOiB1bml0L3Rlc3QtaWU8YnI+UEFTUzogdW5pdC90ZXN0LXV0aWw8YnI+UEFTUzogdW5p
dC90ZXN0LXNzaWQtc2VjdXJpdHk8YnI+UEFTUzogdW5pdC90ZXN0LWFyYzQ8YnI+UEFTUzogdW5p
dC90ZXN0LXdzYzxicj5QQVNTOiB1bml0L3Rlc3QtZWFwLW1zY2hhcHYyPGJyPlBBU1M6IHVuaXQv
dGVzdC1lYXAtc2ltPGJyPi9iaW4vc2ggLi9saWJ0b29sIMKgLS10YWc9Q0MgwqAgLS1tb2RlPWxp
bmsgL3Vzci9iaW4vZ2NjIMKgLWZ2aXNpYmlsaXR5PWhpZGRlbiAtRFVOSVRESVI9XCZxdW90OyZx
dW90Oy4vdW5pdC8mcXVvdDtcJnF1b3Q7IC1EQ0VSVERJUj1cJnF1b3Q7JnF1b3Q7Li91bml0LyZx
dW90O1wmcXVvdDsgwqAtTzIgLWcgLWdyZWNvcmQtZ2NjLXN3aXRjaGVzIC1waXBlIC1XYWxsIC1X
ZXJyb3I9Zm9ybWF0LXNlY3VyaXR5IC1XcCwtRF9GT1JUSUZZX1NPVVJDRT0yIC1XcCwtRF9HTElC
Q1hYX0FTU0VSVElPTlMgLXNwZWNzPS91c3IvbGliL3JwbS9yZWRoYXQvcmVkaGF0LWhhcmRlbmVk
LWNjMSAtZnN0YWNrLXByb3RlY3Rvci1zdHJvbmcgLXNwZWNzPS91c3IvbGliL3JwbS9yZWRoYXQv
cmVkaGF0LWFubm9iaW4tY2MxIC1tNjQgLW10dW5lPWdlbmVyaWMgLWZhc3luY2hyb25vdXMtdW53
aW5kLXRhYmxlcyAtZnN0YWNrLWNsYXNoLXByb3RlY3Rpb24gLWZjZi1wcm90ZWN0aW9uIC1mZGF0
YS1zZWN0aW9ucyAtZmZ1bmN0aW9uLXNlY3Rpb25zIC1mbHRvPWF1dG8gLWZsdG8tcGFydGl0aW9u
PW5vbmUgLU9zIC1XbCwtd3JhcCxsX2VjY19zdXBwb3J0ZWRfaWtlX2dyb3VwcyAtV2wsLXoscmVs
cm8gLVdsLC0tYXMtbmVlZGVkIC1XbCwtLWdjLXNlY3Rpb25zIC1XbCwteixub3cgLXNwZWNzPS91
c3IvbGliL3JwbS9yZWRoYXQvcmVkaGF0LWhhcmRlbmVkLWxkIC1mbHRvPWF1dG8gLWZsdG8tcGFy
dGl0aW9uPW5vbmUgLWZ1c2UtbGlua2VyLXBsdWdpbiAtbyB1bml0L3Rlc3Qtc2FlIHVuaXQvdGVz
dC1zYWUubyBzcmMvc2FlLm8gc3JjL2NyeXB0by5vIHNyYy9pZS5vIHNyYy9oYW5kc2hha2UubyBz
cmMvZXJwLm8gc3JjL3V0aWwubyBzcmMvbXBkdS5vIC1sZWxsPGJyPmxpYnRvb2w6IGxpbms6IC91
c3IvYmluL2djYyAtZnZpc2liaWxpdHk9aGlkZGVuIC1EVU5JVERJUj1cJnF1b3Q7Li91bml0L1wm
cXVvdDsgLURDRVJURElSPVwmcXVvdDsuL3VuaXQvXCZxdW90OyAtTzIgLWcgLWdyZWNvcmQtZ2Nj
LXN3aXRjaGVzIC1waXBlIC1XYWxsIC1XZXJyb3I9Zm9ybWF0LXNlY3VyaXR5IC1XcCwtRF9GT1JU
SUZZX1NPVVJDRT0yIC1XcCwtRF9HTElCQ1hYX0FTU0VSVElPTlMgLXNwZWNzPS91c3IvbGliL3Jw
bS9yZWRoYXQvcmVkaGF0LWhhcmRlbmVkLWNjMSAtZnN0YWNrLXByb3RlY3Rvci1zdHJvbmcgLXNw
ZWNzPS91c3IvbGliL3JwbS9yZWRoYXQvcmVkaGF0LWFubm9iaW4tY2MxIC1tNjQgLW10dW5lPWdl
bmVyaWMgLWZhc3luY2hyb25vdXMtdW53aW5kLXRhYmxlcyAtZnN0YWNrLWNsYXNoLXByb3RlY3Rp
b24gLWZjZi1wcm90ZWN0aW9uIC1mZGF0YS1zZWN0aW9ucyAtZmZ1bmN0aW9uLXNlY3Rpb25zIC1m
bHRvPWF1dG8gLWZsdG8tcGFydGl0aW9uPW5vbmUgLU9zIC1XbCwtd3JhcCAtV2wsbF9lY2Nfc3Vw
cG9ydGVkX2lrZV9ncm91cHMgLVdsLC16IC1XbCxyZWxybyAtV2wsLS1hcy1uZWVkZWQgLVdsLC0t
Z2Mtc2VjdGlvbnMgLVdsLC16IC1XbCxub3cgLXNwZWNzPS91c3IvbGliL3JwbS9yZWRoYXQvcmVk
aGF0LWhhcmRlbmVkLWxkIC1mbHRvPWF1dG8gLWZsdG8tcGFydGl0aW9uPW5vbmUgLWZ1c2UtbGlu
a2VyLXBsdWdpbiAtbyB1bml0L3Rlc3Qtc2FlIHVuaXQvdGVzdC1zYWUubyBzcmMvc2FlLm8gc3Jj
L2NyeXB0by5vIHNyYy9pZS5vIHNyYy9oYW5kc2hha2UubyBzcmMvZXJwLm8gc3JjL3V0aWwubyBz
cmMvbXBkdS5vIMKgLWxlbGw8YnI+L3Vzci9iaW4vbGQ6IC90bXAvY2M4dWlXekwubHRvLm86IGlu
IGZ1bmN0aW9uIGBzYWVfY2hvb3NlX25leHRfZ3JvdXAmIzM5Ozo8YnI+L2hvbWUvdGtsb2N6a28v
cnBtYnVpbGQvQlVJTEQvaXdkLTEuMTcvc3JjL3NhZS5jOjEzOTogdW5kZWZpbmVkIHJlZmVyZW5j
ZSB0byBgX193cmFwX2xfZWNjX3N1cHBvcnRlZF9pa2VfZ3JvdXBzJiMzOTs8YnI+L3Vzci9iaW4v
bGQ6IC90bXAvY2M4dWlXekwubHRvLm86IGluIGZ1bmN0aW9uIGBoYW5kc2hha2Vfc3RhdGVfZnJl
ZSYjMzk7Ojxicj4vaG9tZS90a2xvY3prby9ycG1idWlsZC9CVUlMRC9pd2QtMS4xNy9zcmMvaGFu
ZHNoYWtlLmM6NDg6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYF9fd3JhcF9sX2VjY19zdXBwb3J0
ZWRfaWtlX2dyb3VwcyYjMzk7PGJyPi91c3IvYmluL2xkOiAvdG1wL2NjOHVpV3pMLmx0by5vOiBp
biBmdW5jdGlvbiBgc2FlX3J4X2F1dGhlbnRpY2F0ZSYjMzk7Ojxicj4vaG9tZS90a2xvY3prby9y
cG1idWlsZC9CVUlMRC9pd2QtMS4xNy9zcmMvc2FlLmM6MTYxOiB1bmRlZmluZWQgcmVmZXJlbmNl
IHRvIGBfX3dyYXBfbF9lY2Nfc3VwcG9ydGVkX2lrZV9ncm91cHMmIzM5Ozxicj5jb2xsZWN0Mjog
ZXJyb3I6IGxkIHJldHVybmVkIDEgZXhpdCBzdGF0dXM8YnI+bWFrZVszXTogKioqIFtNYWtlZmls
ZToyMDQwOiB1bml0L3Rlc3Qtc2FlXSBFcnJvciAxPGJyPlBBU1M6IHVuaXQvdGVzdC1wMnA8YnI+
UEFTUzogdW5pdC90ZXN0LWJhbmQ8YnI+UEFTUzogdW5pdC90ZXN0LWNsaWVudDxicj5tYWtlWzNd
OiBUYXJnZXQgJiMzOTt0ZXN0LXN1aXRlLmxvZyYjMzk7IG5vdCByZW1hZGUgYmVjYXVzZSBvZiBl
cnJvcnMuPGJyPm1ha2VbMl06ICoqKiBbTWFrZWZpbGU6Mjc2OTogY2hlY2stVEVTVFNdIEVycm9y
IDI8YnI+bWFrZVsxXTogKioqIFtNYWtlZmlsZTozMTEzOiBjaGVjay1hbV0gRXJyb3IgMjxicj5t
YWtlOiAqKiogW01ha2VmaWxlOjMxMTU6IGNoZWNrXSBFcnJvciAyPGJyPjwvZGl2PjxkaXYgY2xh
c3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPSJmb250LWZhbWlseTptb25vc3BhY2UsbW9ub3NwYWNl
Ij48YnI+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVsdCIgc3R5bGU9ImZvbnQtZmFtaWx5
Om1vbm9zcGFjZSxtb25vc3BhY2UiPkJUVyBpcyBpdCBwb3NzaWJsZSB0byBvcmdhbml6ZSBpd2Qv
ZWVsIG1pcnJvcnMgb24gZ2l0aHViL2dpdGxhYiB0byBiZSBhYmxlIHN1Ym1pdCBzdWNoIGFuIGlz
c3VlIHdpdGhvdXQgYmVpbmcgZm9yY2VkIHRvIHN1YnNjcmliZSB0byB5ZXQgYW5vdGhlciBtYWls
aW5nIGxpc3Qgb3IgcHV0IGluIFJFQURNRSBmaWxlcyBkZXRhaWxzIGhvdyB0byBzdWJtaXQgdGhl
IGlzc3VlPzwvZGl2PjxkaXYgY2xhc3M9ImdtYWlsX2RlZmF1bHQiIHN0eWxlPSJmb250LWZhbWls
eTptb25vc3BhY2UsbW9ub3NwYWNlIj48YnI+PC9kaXY+PGRpdiBjbGFzcz0iZ21haWxfZGVmYXVs
dCIgc3R5bGU9ImZvbnQtZmFtaWx5Om1vbm9zcGFjZSxtb25vc3BhY2UiPmtsb2N6ZWs8L2Rpdj48
ZGl2PjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9zaWduYXR1cmUiIGRhdGEtc21hcnRtYWls
PSJnbWFpbF9zaWduYXR1cmUiPjxkaXYgZGlyPSJsdHIiPjxkaXY+PGRpdiBkaXI9Imx0ciI+PGZv
bnQgZmFjZT0ibW9ub3NwYWNlLCBtb25vc3BhY2UiPi0twqA8L2ZvbnQ+PC9kaXY+PGRpdiBkaXI9
Imx0ciI+PGZvbnQgZmFjZT0ibW9ub3NwYWNlLCBtb25vc3BhY2UiPlRvbWFzeiBLxYJvY3prbyB8
IExpbmtlZEluOsKgPGIgc3R5bGU9ImZvbnQtd2VpZ2h0Om5vcm1hbCI+PGEgaHJlZj0iaHR0cDov
L2xua2QuaW4vRlhQV3hIIiBzdHlsZT0idGV4dC1kZWNvcmF0aW9uOm5vbmUiIHRhcmdldD0iX2Js
YW5rIj48c3BhbiBzdHlsZT0iZm9udC1zaXplOjEzcHg7Y29sb3I6cmdiKDE3LDg1LDIwNCk7YmFj
a2dyb3VuZC1jb2xvcjp0cmFuc3BhcmVudDt0ZXh0LWRlY29yYXRpb246dW5kZXJsaW5lO3ZlcnRp
Y2FsLWFsaWduOmJhc2VsaW5lO3doaXRlLXNwYWNlOnByZS13cmFwIj5odHRwOi8vbG5rZC5pbi9G
WFBXeEg8L3NwYW4+PC9hPjwvYj48L2ZvbnQ+PC9kaXY+PC9kaXY+PGRpdiBkaXI9Imx0ciI+PGZv
bnQgZmFjZT0ibW9ub3NwYWNlLCBtb25vc3BhY2UiPjxicj48L2ZvbnQ+PC9kaXY+PC9kaXY+PC9k
aXY+PC9kaXY+PC9kaXY+Cg==

--===============3562894195115213169==--

