Content-Type: multipart/mixed; boundary="===============7665689774445816049=="
MIME-Version: 1.0
From: Bruce A. Johnson <bjohnson at blueridgenetworks.com>
To: iwd at lists.01.org
Subject: Usable link speed info from iwd?
Date: Wed, 09 Mar 2022 15:55:42 -0500
Message-ID: <ab667060-d8a4-6df9-45e7-978460169b61@blueridgenetworks.com>

--===============7665689774445816049==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Does anyone have a recommendation on how to obtain usable link speed =

information from iwd? Not finding anything in the API, I resorted to the =

iw tool, and that gave me unbelievable information like:

iw dev wlan0 link
Connected to 94:a6:7e:e0:9b:10 (on wlan0)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SSID: NETGEAR62-5G
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 freq: 5180
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RX: 729218722 bytes (698037 pac=
kets)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TX: 649796954 bytes (597324 pac=
kets)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 signal: -36 dBm
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rx bitrate: 24.0 MBit/s
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tx bitrate: 6.0 MBit/s

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bss flags:=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 short-slot-time
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dtim period:=C2=A0=C2=A0=C2=A0 1
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 beacon int:=C2=A0=C2=A0=C2=A0=
=C2=A0 100

When the connection was in this state, I was able to pass data with =

iperf3 at nearly 100 Mbps in either direction with no packet loss on the =

transmit and about 1% packet loss on the receive. When I moved the =

router 10-12 meters further away, iw reported a _higher_ bit rate. (I =

couldn't test throughput because there was no connection on the WAN side =

in the new location.)

# iw dev wlan0 link
Connected to 94:a6:7e:e0:9b:10 (on wlan0)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SSID: NETGEAR62-5G
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 freq: 5180
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 RX: 24944 bytes (170 packets)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 TX: 1949 bytes (12 packets)
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 signal: -64 dBm
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rx bitrate: 260.0 MBit/s VHT-MC=
S 3 80MHz short GI VHT-NSS 2
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tx bitrate: 6.0 MBit/s

 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bss flags:=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 short-slot-time
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 dtim period:=C2=A0=C2=A0=C2=A0 1
 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 beacon int:=C2=A0=C2=A0=C2=A0=
=C2=A0 100

I must have a misunderstanding of what those figures mean. Is it that =

the only reasonable indication of link quality is the signal strength?

-- =

Bruce Johnson
Chantilly, Virginia
OpenPGP key ID: 296D1CD6F2B84CABhttps://keys.openpgp.org/


--===============7665689774445816049==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGh0bWw+DQogIDxoZWFkPg0KDQogICAgPG1ldGEgaHR0cC1lcXVpdj0iY29udGVudC10eXBlIiBj
b250ZW50PSJ0ZXh0L2h0bWw7IGNoYXJzZXQ9VVRGLTgiPg0KICA8L2hlYWQ+DQogIDxib2R5Pg0K
ICAgIDxwPkRvZXMgYW55b25lIGhhdmUgYSByZWNvbW1lbmRhdGlvbiBvbiBob3cgdG8gb2J0YWlu
IHVzYWJsZSBsaW5rDQogICAgICBzcGVlZCBpbmZvcm1hdGlvbiBmcm9tIGl3ZD8gTm90IGZpbmRp
bmcgYW55dGhpbmcgaW4gdGhlIEFQSSwgSQ0KICAgICAgcmVzb3J0ZWQgdG8gdGhlIGl3IHRvb2ws
IGFuZCB0aGF0IGdhdmUgbWUgdW5iZWxpZXZhYmxlIGluZm9ybWF0aW9uDQogICAgICBsaWtlOjwv
cD4NCiAgICA8cHJlPml3IGRldiB3bGFuMCBsaW5rDQpDb25uZWN0ZWQgdG8gOTQ6YTY6N2U6ZTA6
OWI6MTAgKG9uIHdsYW4wKQ0KwqDCoMKgwqDCoMKgwqAgU1NJRDogTkVUR0VBUjYyLTVHDQrCoMKg
wqDCoMKgwqDCoCBmcmVxOiA1MTgwDQrCoMKgwqDCoMKgwqDCoCBSWDogNzI5MjE4NzIyIGJ5dGVz
ICg2OTgwMzcgcGFja2V0cykNCsKgwqDCoMKgwqDCoMKgIFRYOiA2NDk3OTY5NTQgYnl0ZXMgKDU5
NzMyNCBwYWNrZXRzKQ0KwqDCoMKgwqDCoMKgwqAgc2lnbmFsOiAtMzYgZEJtDQrCoMKgwqDCoMKg
wqDCoCByeCBiaXRyYXRlOiAyNC4wIE1CaXQvcw0KwqDCoMKgwqDCoMKgwqAgdHggYml0cmF0ZTog
Ni4wIE1CaXQvcw0KDQrCoMKgwqDCoMKgwqDCoCBic3MgZmxhZ3M6wqDCoMKgwqDCoCBzaG9ydC1z
bG90LXRpbWUNCsKgwqDCoMKgwqDCoMKgIGR0aW0gcGVyaW9kOsKgwqDCoCAxDQrCoMKgwqDCoMKg
wqDCoCBiZWFjb24gaW50OsKgwqDCoMKgIDEwMDwvcHJlPg0KICAgIDxwPldoZW4gdGhlIGNvbm5l
Y3Rpb24gd2FzIGluIHRoaXMgc3RhdGUsIEkgd2FzIGFibGUgdG8gcGFzcyBkYXRhDQogICAgICB3
aXRoIGlwZXJmMyBhdCBuZWFybHkgMTAwIE1icHMgaW4gZWl0aGVyIGRpcmVjdGlvbiB3aXRoIG5v
IHBhY2tldA0KICAgICAgbG9zcyBvbiB0aGUgdHJhbnNtaXQgYW5kIGFib3V0IDElIHBhY2tldCBs
b3NzIG9uIHRoZSByZWNlaXZlLiBXaGVuDQogICAgICBJIG1vdmVkIHRoZSByb3V0ZXIgMTAtMTIg
bWV0ZXJzIGZ1cnRoZXIgYXdheSwgaXcgcmVwb3J0ZWQgYSA8dT5oaWdoZXI8L3U+DQogICAgICBi
aXQgcmF0ZS4gKEkgY291bGRuJ3QgdGVzdCB0aHJvdWdocHV0IGJlY2F1c2UgdGhlcmUgd2FzIG5v
DQogICAgICBjb25uZWN0aW9uIG9uIHRoZSBXQU4gc2lkZSBpbiB0aGUgbmV3IGxvY2F0aW9uLik8
YnI+DQogICAgPC9wPg0KICAgIDxwcmU+IyBpdyBkZXYgd2xhbjAgbGluaw0KQ29ubmVjdGVkIHRv
IDk0OmE2OjdlOmUwOjliOjEwIChvbiB3bGFuMCkNCsKgwqDCoMKgwqDCoMKgIFNTSUQ6IE5FVEdF
QVI2Mi01Rw0KwqDCoMKgwqDCoMKgwqAgZnJlcTogNTE4MA0KwqDCoMKgwqDCoMKgwqAgUlg6IDI0
OTQ0IGJ5dGVzICgxNzAgcGFja2V0cykNCsKgwqDCoMKgwqDCoMKgIFRYOiAxOTQ5IGJ5dGVzICgx
MiBwYWNrZXRzKQ0KwqDCoMKgwqDCoMKgwqAgc2lnbmFsOiAtNjQgZEJtDQrCoMKgwqDCoMKgwqDC
oCByeCBiaXRyYXRlOiAyNjAuMCBNQml0L3MgVkhULU1DUyAzIDgwTUh6IHNob3J0IEdJIFZIVC1O
U1MgMg0KwqDCoMKgwqDCoMKgwqAgdHggYml0cmF0ZTogNi4wIE1CaXQvcw0KDQrCoMKgwqDCoMKg
wqDCoCBic3MgZmxhZ3M6wqDCoMKgwqDCoCBzaG9ydC1zbG90LXRpbWUNCsKgwqDCoMKgwqDCoMKg
IGR0aW0gcGVyaW9kOsKgwqDCoCAxDQrCoMKgwqDCoMKgwqDCoCBiZWFjb24gaW50OsKgwqDCoMKg
IDEwMDwvcHJlPg0KICAgIDxwPkkgbXVzdCBoYXZlIGEgbWlzdW5kZXJzdGFuZGluZyBvZiB3aGF0
IHRob3NlIGZpZ3VyZXMgbWVhbi4gSXMgaXQNCiAgICAgIHRoYXQgdGhlIG9ubHkgcmVhc29uYWJs
ZSBpbmRpY2F0aW9uIG9mIGxpbmsgcXVhbGl0eSBpcyB0aGUgc2lnbmFsDQogICAgICBzdHJlbmd0
aD88L3A+DQogICAgPHByZSBjbGFzcz0ibW96LXNpZ25hdHVyZSIgY29scz0iNzIiPi0tIA0KQnJ1
Y2UgSm9obnNvbg0KQ2hhbnRpbGx5LCBWaXJnaW5pYQ0KT3BlblBHUCBrZXkgSUQ6IDI5NkQxQ0Q2
RjJCODRDQUIgPGEgY2xhc3M9Im1vei10eHQtbGluay1mcmVldGV4dCIgaHJlZj0iaHR0cHM6Ly9r
ZXlzLm9wZW5wZ3Aub3JnLyI+aHR0cHM6Ly9rZXlzLm9wZW5wZ3Aub3JnLzwvYT48L3ByZT4NCiAg
PC9ib2R5Pg0KPC9odG1sPg0K

--===============7665689774445816049==
Content-Type: application/pgp-signature
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="OpenPGP_signature.sig"

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCndzRjVCQUFCQ0FBakZpRUVtR3ZveWt3My9F
MHgxT2VNS1cwYzF2SzRUS3NGQW1JcEZFNEZBd0FBQUFBQUNna1FLVzBjMXZLNFRLdTEKYkEvL1pL
U2JnbmhnSWZkcHZuRWFSTnVFSUxqSGZkNUIwVm1QK05EeWNEWXRaOUxQOGlGMmlVczVyVEh1M0Fp
aWJqNXJBc3hLYVZPSwplTUxZT054ZXY1U0crcjdPbkxWMmVrWDRyYkdBWWthN013cVludTlOTDdl
eTRrKy9zSVNTdytDRERQVGtnYzN1RkdURDQyUEZISEtPClVsQlNBVlZicUNQdkJ2MjdJWEY0TXN6
cFJRN1RON0dJcFN6NDJvUzVkU3ZRb1NFbTJ1NVRWeUkwZlZqdmEzWjNPWFVLVTQ2WXhsZjUKRFNl
U3hGVzR4Y1dxdm1YeUtMcTNtc0JkN1JjTi90RndJb3NvcXIwOTgwSnNLYkNqM0RxY2VLSnY5N2Nk
Qnh3RnFlTjhtbzdQNWRtdQpucWZmOVpFWUg4Tk1EUTIxeHdUQkcwa0Z0TnBUOW9oZTA0bkFOMHZH
U2h1V2RWYm1ocHhJVU9sNnUvV3Q3RmlxNC9FTExPMWhreWJzClJ3VFZqVmJGbDhaQnpKZkpKWGFh
dDRIS1B2SURkMGhWRU5TRDFhOE9MRzVzMlVsZzlsYjRCMnNQb3dwam1MSnN2ZjBhQjBEWDFKUGsK
TkRqYlBUMU9ZRXpSRU5IV3RWcVJkWU83NjlEL1hrbmtWd2F3VmxFSGViL2l5UzBhVXdNekdkYlFt
Y1ovblpFN0IvQ3RGK3ZwbWtRZApvQlJZZ3RIOFIyT0xoNmduWXJ6MEl3K0RIQmZzR2JVSG1DdlB1
UE82Smo5NmYrV2RqSmpDYmczdTkreVBwRkdEUnUxaHdDSXNqWFA1CjFMcHNlUUViL0hRd0dGNkJJ
ZlgwMUlYOXF4eGZWenFOaXFQeWw4WjdOVVhLR3pUcmNBVnVETHY2elJ3N3E3cFBuREdqMW44R0g3
UE8KRFY4PQo9cnFyYQotLS0tLUVORCBQR1AgU0lHTkFUVVJFLS0tLS0K

--===============7665689774445816049==--

