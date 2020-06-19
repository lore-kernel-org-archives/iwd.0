Content-Type: multipart/mixed; boundary="===============3377780324756196386=="
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Subject: IWD on arch64 startup errors
Date: Fri, 19 Jun 2020 00:45:16 -0500
Message-ID: <CAG17S_NX8Navv+Mi_ocoJ_UAVftgjYWfYxPHdEBpJb6te3cvCg@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3377780324756196386==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I have been running iwd on armv6 and v7 for a while without issue. I
finally got an image or Arch aarch64 on my RPI running (kernel 5.4.44) and
cannot start the already compiled for aarch64 version of iwd on this
kernel. The journal shows this:
Jun 18 23:34:02 rune64 systemd[1]: Starting Wireless service...
Jun 18 23:34:03 rune64 iwd[4088]: No HMAC(SHA1) support found
Jun 18 23:34:03 rune64 iwd[4088]: No HMAC(MD5) support found
Jun 18 23:34:03 rune64 iwd[4088]: No CMAC(AES) support found
Jun 18 23:34:03 rune64 iwd[4088]: No HMAC(SHA256) support not found
Jun 18 23:34:03 rune64 iwd[4088]: No HMAC(SHA512) support found, certain
TLS connections might fail
Jun 18 23:34:03 rune64 iwd[4088]: No Diffie-Hellman support found, WPS will
not be available
Jun 18 23:34:03 rune64 iwd[4088]: The following options are missing in the
kernel:
Jun 18 23:34:03 rune64 iwd[4088]:         CONFIG_CRYPTO_USER_API_HASH
Jun 18 23:34:03 rune64 iwd[4088]:         CONFIG_KEY_DH_OPERATIONS
Jun 18 23:34:03 rune64 iwd[4088]:         CONFIG_CRYPTO_MD5
Jun 18 23:34:03 rune64 iwd[4088]:         CONFIG_CRYPTO_SHA256
Jun 18 23:34:03 rune64 iwd[4088]:         CONFIG_CRYPTO_AES
Jun 18 23:34:03 rune64 iwd[4088]:         CONFIG_CRYPTO_CMAC
Jun 18 23:34:03 rune64 iwd[4088]:         CONFIG_CRYPTO_USER_API_HASH
Jun 18 23:34:03 rune64 iwd[4088]:         CONFIG_CRYPTO_USER_API_HASH
Jun 18 23:34:03 rune64 iwd[4088]:         CONFIG_CRYPTO_USER_API_HASH
Jun 18 23:34:03 rune64 iwd[4088]:         CONFIG_CRYPTO_HMAC
Jun 18 23:34:03 rune64 iwd[4088]:         CONFIG_CRYPTO_HMAC
Jun 18 23:34:03 rune64 iwd[4088]:         CONFIG_CRYPTO_HMAC
Jun 18 23:34:03 rune64 iwd[4088]:         CONFIG_CRYPTO_SHA512
Jun 18 23:34:03 rune64 iwd[4088]:         CONFIG_CRYPTO_SHA1
Jun 18 23:34:03 rune64 iwd[4088]: The following optimized implementations
might be available:
Jun 18 23:34:03 rune64 iwd[4088]:         CONFIG_CRYPTO_SHA1_SSSE3
Jun 18 23:34:03 rune64 iwd[4088]:         CONFIG_CRYPTO_AES_NI_INTEL
Jun 18 23:34:03 rune64 iwd[4088]:         CONFIG_CRYPTO_SHA512_SSSE3
Jun 18 23:34:03 rune64 iwd[4088]:         CONFIG_CRYPTO_AES_X86_64
Jun 18 23:34:03 rune64 iwd[4088]:         CONFIG_CRYPTO_SHA256_SSSE3
Jun 18 23:34:03 rune64 systemd[1]: iwd.service: Main process exited,
code=3Dexited, status=3D1/FAILURE
Jun 18 23:34:03 rune64 systemd[1]: iwd.service: Failed with result
'exit-code'.
Jun 18 23:34:03 rune64 systemd[1]: Failed to start Wireless service.

I recently built this kernel on a system that was running 5.7.x and iwd
1.7.1 was also built on this kernel. When I run iwd on 5.7.x, it runs and
functions. I checked the config and most of these appear as modules but are
not built in. Must they be built in?

Keith

--===============3377780324756196386==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+PGRpdj5JIGhhdmUgYmVlbiBydW5uaW5nIGl3ZCBvbiBhcm12NiBhbmQg
djcgZm9yIGEgd2hpbGUgd2l0aG91dCBpc3N1ZS4gSSBmaW5hbGx5IGdvdCBhbiBpbWFnZSBvciBB
cmNoIGFhcmNoNjQgb24gbXkgUlBJIHJ1bm5pbmcgKGtlcm5lbCA1LjQuNDQpIGFuZCBjYW5ub3Qg
c3RhcnQgdGhlIGFscmVhZHkgY29tcGlsZWQgZm9yIGFhcmNoNjQgdmVyc2lvbiBvZiBpd2Qgb24g
dGhpcyBrZXJuZWwuIFRoZSBqb3VybmFsIHNob3dzIHRoaXM6PC9kaXY+PGRpdj5KdW4gMTggMjM6
MzQ6MDIgcnVuZTY0IHN5c3RlbWRbMV06IFN0YXJ0aW5nIFdpcmVsZXNzIHNlcnZpY2UuLi48YnI+
SnVuIDE4IDIzOjM0OjAzIHJ1bmU2NCBpd2RbNDA4OF06IE5vIEhNQUMoU0hBMSkgc3VwcG9ydCBm
b3VuZDxicj5KdW4gMTggMjM6MzQ6MDMgcnVuZTY0IGl3ZFs0MDg4XTogTm8gSE1BQyhNRDUpIHN1
cHBvcnQgZm91bmQ8YnI+SnVuIDE4IDIzOjM0OjAzIHJ1bmU2NCBpd2RbNDA4OF06IE5vIENNQUMo
QUVTKSBzdXBwb3J0IGZvdW5kPGJyPkp1biAxOCAyMzozNDowMyBydW5lNjQgaXdkWzQwODhdOiBO
byBITUFDKFNIQTI1Nikgc3VwcG9ydCBub3QgZm91bmQ8YnI+SnVuIDE4IDIzOjM0OjAzIHJ1bmU2
NCBpd2RbNDA4OF06IE5vIEhNQUMoU0hBNTEyKSBzdXBwb3J0IGZvdW5kLCBjZXJ0YWluIFRMUyBj
b25uZWN0aW9ucyBtaWdodCBmYWlsPGJyPkp1biAxOCAyMzozNDowMyBydW5lNjQgaXdkWzQwODhd
OiBObyBEaWZmaWUtSGVsbG1hbiBzdXBwb3J0IGZvdW5kLCBXUFMgd2lsbCBub3QgYmUgYXZhaWxh
YmxlPGJyPkp1biAxOCAyMzozNDowMyBydW5lNjQgaXdkWzQwODhdOiBUaGUgZm9sbG93aW5nIG9w
dGlvbnMgYXJlIG1pc3NpbmcgaW4gdGhlIGtlcm5lbDo8YnI+SnVuIDE4IDIzOjM0OjAzIHJ1bmU2
NCBpd2RbNDA4OF06IMKgIMKgIMKgIMKgIENPTkZJR19DUllQVE9fVVNFUl9BUElfSEFTSDxicj5K
dW4gMTggMjM6MzQ6MDMgcnVuZTY0IGl3ZFs0MDg4XTogwqAgwqAgwqAgwqAgQ09ORklHX0tFWV9E
SF9PUEVSQVRJT05TPGJyPkp1biAxOCAyMzozNDowMyBydW5lNjQgaXdkWzQwODhdOiDCoCDCoCDC
oCDCoCBDT05GSUdfQ1JZUFRPX01ENTxicj5KdW4gMTggMjM6MzQ6MDMgcnVuZTY0IGl3ZFs0MDg4
XTogwqAgwqAgwqAgwqAgQ09ORklHX0NSWVBUT19TSEEyNTY8YnI+SnVuIDE4IDIzOjM0OjAzIHJ1
bmU2NCBpd2RbNDA4OF06IMKgIMKgIMKgIMKgIENPTkZJR19DUllQVE9fQUVTPGJyPkp1biAxOCAy
MzozNDowMyBydW5lNjQgaXdkWzQwODhdOiDCoCDCoCDCoCDCoCBDT05GSUdfQ1JZUFRPX0NNQUM8
YnI+SnVuIDE4IDIzOjM0OjAzIHJ1bmU2NCBpd2RbNDA4OF06IMKgIMKgIMKgIMKgIENPTkZJR19D
UllQVE9fVVNFUl9BUElfSEFTSDxicj5KdW4gMTggMjM6MzQ6MDMgcnVuZTY0IGl3ZFs0MDg4XTog
wqAgwqAgwqAgwqAgQ09ORklHX0NSWVBUT19VU0VSX0FQSV9IQVNIPGJyPkp1biAxOCAyMzozNDow
MyBydW5lNjQgaXdkWzQwODhdOiDCoCDCoCDCoCDCoCBDT05GSUdfQ1JZUFRPX1VTRVJfQVBJX0hB
U0g8YnI+SnVuIDE4IDIzOjM0OjAzIHJ1bmU2NCBpd2RbNDA4OF06IMKgIMKgIMKgIMKgIENPTkZJ
R19DUllQVE9fSE1BQzxicj5KdW4gMTggMjM6MzQ6MDMgcnVuZTY0IGl3ZFs0MDg4XTogwqAgwqAg
wqAgwqAgQ09ORklHX0NSWVBUT19ITUFDPGJyPkp1biAxOCAyMzozNDowMyBydW5lNjQgaXdkWzQw
ODhdOiDCoCDCoCDCoCDCoCBDT05GSUdfQ1JZUFRPX0hNQUM8YnI+SnVuIDE4IDIzOjM0OjAzIHJ1
bmU2NCBpd2RbNDA4OF06IMKgIMKgIMKgIMKgIENPTkZJR19DUllQVE9fU0hBNTEyPGJyPkp1biAx
OCAyMzozNDowMyBydW5lNjQgaXdkWzQwODhdOiDCoCDCoCDCoCDCoCBDT05GSUdfQ1JZUFRPX1NI
QTE8YnI+SnVuIDE4IDIzOjM0OjAzIHJ1bmU2NCBpd2RbNDA4OF06IFRoZSBmb2xsb3dpbmcgb3B0
aW1pemVkIGltcGxlbWVudGF0aW9ucyBtaWdodCBiZSBhdmFpbGFibGU6PGJyPkp1biAxOCAyMzoz
NDowMyBydW5lNjQgaXdkWzQwODhdOiDCoCDCoCDCoCDCoCBDT05GSUdfQ1JZUFRPX1NIQTFfU1NT
RTM8YnI+SnVuIDE4IDIzOjM0OjAzIHJ1bmU2NCBpd2RbNDA4OF06IMKgIMKgIMKgIMKgIENPTkZJ
R19DUllQVE9fQUVTX05JX0lOVEVMPGJyPkp1biAxOCAyMzozNDowMyBydW5lNjQgaXdkWzQwODhd
OiDCoCDCoCDCoCDCoCBDT05GSUdfQ1JZUFRPX1NIQTUxMl9TU1NFMzxicj5KdW4gMTggMjM6MzQ6
MDMgcnVuZTY0IGl3ZFs0MDg4XTogwqAgwqAgwqAgwqAgQ09ORklHX0NSWVBUT19BRVNfWDg2XzY0
PGJyPkp1biAxOCAyMzozNDowMyBydW5lNjQgaXdkWzQwODhdOiDCoCDCoCDCoCDCoCBDT05GSUdf
Q1JZUFRPX1NIQTI1Nl9TU1NFMzxicj5KdW4gMTggMjM6MzQ6MDMgcnVuZTY0IHN5c3RlbWRbMV06
IGl3ZC5zZXJ2aWNlOiBNYWluIHByb2Nlc3MgZXhpdGVkLCBjb2RlPWV4aXRlZCwgc3RhdHVzPTEv
RkFJTFVSRTxicj5KdW4gMTggMjM6MzQ6MDMgcnVuZTY0IHN5c3RlbWRbMV06IGl3ZC5zZXJ2aWNl
OiBGYWlsZWQgd2l0aCByZXN1bHQgJiMzOTtleGl0LWNvZGUmIzM5Oy48YnI+SnVuIDE4IDIzOjM0
OjAzIHJ1bmU2NCBzeXN0ZW1kWzFdOiBGYWlsZWQgdG8gc3RhcnQgV2lyZWxlc3Mgc2VydmljZS48
L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkkgcmVjZW50bHkgYnVpbHQgdGhpcyBrZXJuZWwgb24g
YSBzeXN0ZW0gdGhhdCB3YXMgcnVubmluZyA1LjcueCBhbmQgaXdkIDEuNy4xIHdhcyBhbHNvIGJ1
aWx0IG9uIHRoaXMga2VybmVsLiBXaGVuIEkgcnVuIGl3ZCBvbiA1LjcueCwgaXQgcnVucyBhbmQg
ZnVuY3Rpb25zLiBJIGNoZWNrZWQgdGhlIGNvbmZpZyBhbmQgbW9zdCBvZiB0aGVzZSBhcHBlYXIg
YXMgbW9kdWxlcyBidXQgYXJlIG5vdCBidWlsdCBpbi4gTXVzdCB0aGV5IGJlIGJ1aWx0IGluPyA8
YnI+PGJyPjwvZGl2PjxkaXY+S2VpdGg8YnI+PC9kaXY+PC9kaXY+Cg==

--===============3377780324756196386==--

