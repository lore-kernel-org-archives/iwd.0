Content-Type: multipart/mixed; boundary="===============7289582794956082839=="
MIME-Version: 1.0
From: Roberto "Roobre" Santalla <roobre@roobre.es>
Subject: [Feature] Send hostname in DHCP request
Date: Fri, 17 Jul 2020 16:58:18 +0200
Message-ID: <e155a0e1f4ef46fcb78ae4f3041dab9d2890c083.camel@roobre.es>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============7289582794956082839==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

This is my first time submitting a patch/feature request over email, I
hope I do not mess up :)

First of all, thank you for your work on iwd, I have recently started
to use it on my laptop and seems to be working very well.
I have, however, noticed that when using the built-in IP management, my
hostname was not being sent to the DHCP server. This is unfortunate
since it breaks my home network, which uses dnsmasq to build dns
records on-the-fly for hosts.

I have written and extremely simple, PoC patch which calls gethostname
and pass the returned string to the ell dhcp client.

What are your thoughts about this feature?

Regards,
- =E2=84=9D

=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=
=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=90
 =F0=9F=91=A4 Roberto Santalla Fern=C3=A1ndez
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80
 =F0=9F=94=91 https://keybase.io/roobre/key.asc
 =F0=9F=94=91  0E19 86A3 593E 6226
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=
=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=94=80
 =F0=9F=8C=8D https://roobre.es
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=
=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=
=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=
=95=90=E2=95=90=E2=95=90=E2=95=90


--===============7289582794956082839==
Content-Type: text/x-patch
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="0001-netconfig-Send-hostname-in-dhcp-request.patch"

RnJvbSBmNGJkZDE4MmU3ZDc5NTNmNTg1N2UyMWNhNzJmMzliNTlmMGEzN2QwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBSb2JlcnRvIFNhbnRhbGxhIDxyb29icmVAcm9vYnJlLmVzPgpE
YXRlOiBGcmksIDE3IEp1bCAyMDIwIDE2OjQwOjQyICswMjAwClN1YmplY3Q6IFtQQVRDSF0gbmV0
Y29uZmlnOiBTZW5kIGhvc3RuYW1lIGluIGRoY3AgcmVxdWVzdAoKLS0tCiBzcmMvbmV0Y29uZmln
LmMgfCA3ICsrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykKCmRpZmYgLS1n
aXQgYS9zcmMvbmV0Y29uZmlnLmMgYi9zcmMvbmV0Y29uZmlnLmMKaW5kZXggNzAxYWUzOGIuLmEw
NTA1NGNhIDEwMDY0NAotLS0gYS9zcmMvbmV0Y29uZmlnLmMKKysrIGIvc3JjL25ldGNvbmZpZy5j
CkBAIC0zMCw2ICszMCw3IEBACiAjaW5jbHVkZSA8bmV0aW5ldC9pZl9ldGhlci5oPgogI2luY2x1
ZGUgPG5ldGluZXQvaW4uaD4KICNpbmNsdWRlIDxsaW51eC9ydG5ldGxpbmsuaD4KKyNpbmNsdWRl
IDx1bmlzdGQuaD4KIAogI2luY2x1ZGUgPGVsbC9lbGwuaD4KIApAQCAtMTEwOSw2ICsxMTEwLDgg
QEAgYm9vbCBuZXRjb25maWdfY29uZmlndXJlKHN0cnVjdCBuZXRjb25maWcgKm5ldGNvbmZpZywK
IAkJCQljb25zdCB1aW50OF90ICptYWNfYWRkcmVzcywKIAkJCQluZXRjb25maWdfbm90aWZ5X2Z1
bmNfdCBub3RpZnksIHZvaWQgKnVzZXJfZGF0YSkKIHsKKwljaGFyIGhvc3RuYW1lWzEyOF07CisK
IAluZXRjb25maWctPmFjdGl2ZV9zZXR0aW5ncyA9IGFjdGl2ZV9zZXR0aW5nczsKIAluZXRjb25m
aWctPm5vdGlmeSA9IG5vdGlmeTsKIAluZXRjb25maWctPnVzZXJfZGF0YSA9IHVzZXJfZGF0YTsK
QEAgLTExMTYsNiArMTExOSwxMCBAQCBib29sIG5ldGNvbmZpZ19jb25maWd1cmUoc3RydWN0IG5l
dGNvbmZpZyAqbmV0Y29uZmlnLAogCWxfZGhjcF9jbGllbnRfc2V0X2FkZHJlc3MobmV0Y29uZmln
LT5kaGNwX2NsaWVudCwgQVJQSFJEX0VUSEVSLAogCQkJCQkJCW1hY19hZGRyZXNzLCBFVEhfQUxF
Tik7CiAKKwlpZiAoZ2V0aG9zdG5hbWUoaG9zdG5hbWUsIDEyOCkgPT0gMCkgeworCQlsX2RoY3Bf
Y2xpZW50X3NldF9ob3N0bmFtZShuZXRjb25maWctPmRoY3BfY2xpZW50LCBob3N0bmFtZSk7CisJ
fQorCiAJbmV0Y29uZmlnX2lwdjRfc2VsZWN0X2FuZF9pbnN0YWxsKG5ldGNvbmZpZyk7CiAKIAlu
ZXRjb25maWdfaXB2Nl9zZWxlY3RfYW5kX2luc3RhbGwobmV0Y29uZmlnKTsKLS0gCjIuMjcuMAoK

--===============7289582794956082839==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="signature.asc"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRRkZCQUFCQ0FBdkZpRUVwSmJ4b3dVcnda
bEMvM2p1RGhtR28xaytZaVlGQWw4UnZJb1JISEp2YjJKeVpVQnkKYjI5aWNtVXVaWE1BQ2drUURo
bUdvMWsrWWlabzdBZjdCbkdldnQ2clVWUjFETjRiQ092WXlRc0JEcmFPZnZqWgoxWGl2OGlqUDFi
bXl5aEEyZGhnN1ZxNmN4WnE3TlZ5enZ5WVcrMm0zcERVRVFCZ0tGeFUvYlA4a2xzR3FKamI1ClhS
L05iNXZwK3JGRUVra05oRWkxTHloU1ZxTk1McGVFQnhORGtnSzZrcGdRRXRzYVc0RVVIQm5tWHhQ
b2pCVEcKa1RjQnduY1VqakRicW9IMHNUd1k2TDRCSk01Ky9Oajc0TlB3UEUvZFBEU0RQTlZKRUxG
MGliZ1dYYy8vdkpCWQpwRVpxSlQ1eHJXaDByd3QydlgvTVBrcVVXSWRtazdDbkJYc3JJb3Z3OHl2
TjUzL0JnSno4cCt3ZjRxVDdJcFJqCjFINmlSWjhsWjBJS3FodlRoK2lpcmF6WSsxek5KRnpnSmxS
ZUVXM3drUG5hczR6ZDlDTVVzQT09Cj1vNGF6Ci0tLS0tRU5EIFBHUCBTSUdOQVRVUkUtLS0tLQo=

--===============7289582794956082839==--

