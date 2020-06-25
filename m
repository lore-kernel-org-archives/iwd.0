Content-Type: multipart/mixed; boundary="===============0084196986039126087=="
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Subject: iwd core dump
Date: Thu, 25 Jun 2020 17:34:23 -0500
Message-ID: <CAG17S_Pb+3DgdButoT70norbsxKHJNTSBYzHVjTRuuoiddBv-A@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0084196986039126087==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is on an Rpi B3+ runint aarch64. I have noticed that, periodically I
get disconnected and it doe snot reconnect. I am using connman to manage
the iwd connection. This is the first time I have seen the crash in the
log. It has been crashing and not recovering.

It gets a Deauth event (I've seen this quite a bit) and usually, it will
not reconnect until I reboot it and my router. How can I best diagnose this?

It is iwd 1.7 and connman 1.38. potentially useful excerpts from my journal:

Jun 17 23:26:58 rune64 kernel: Booting Linux on physical CPU 0x0000000000
[0x410fd034]
Jun 17 23:26:58 rune64 kernel: Linux version 5.4.44-1-ARCH
(alarm(a)buildrune64) (gcc version 9.3.0 (GCC)) #1 SMP PREEMPT Mon Jun 22
15:13:50 CDT 2020
Jun 17 23:26:58 rune64 kernel: Machine model: Raspberry Pi 3 Model B Plus
Rev 1.3
...
Jun 17 23:26:58 rune64 kernel: raspberrypi-firmware soc:firmware: Attached
to firmware from 2020-06-10 17:52, variant start_cd
Jun 17 23:26:58 rune64 kernel: raspberrypi-firmware soc:firmware: Firmware
hash is e46bba1638cca2708b31b9daf4636770ef981735
...
Jun 17 23:26:59 rune64 kernel: brcmfmac: F1 signature read
@0x18000000=3D0x15264345
Jun 17 23:26:59 rune64 kernel: brcmfmac: brcmf_fw_alloc_request: using
brcm/brcmfmac43455-sdio for chip BCM4345/6
Jun 17 23:26:59 rune64 kernel: usbcore: registered new interface driver
brcmfmac
...
Jun 17 23:27:00 rune64 kernel: brcmfmac: brcmf_fw_alloc_request: using
brcm/brcmfmac43455-sdio for chip BCM4345/6
Jun 17 23:27:00 rune64 kernel: brcmfmac: brcmf_c_preinit_dcmds: Firmware:
BCM4345/6 wl0: Feb 27 2018 03:15:32 version 7.45.154 (r684107 CY) FWID
01-4fbe0b04
...
Jun 24 22:28:10 rune64 iwd[261]: Wireless daemon version 1.7
Jun 24 22:28:10 rune64 iwd[261]: Loaded configuration from
/etc/iwd/main.conf
Jun 24 22:28:10 rune64 systemd[1]: Started Wireless service.
Jun 24 22:28:10 rune64 iwd[261]: netconfig: Network configuration is
disabled.
Jun 24 22:28:10 rune64 iwd[261]: Wiphy: 0, Name: phy0
Jun 24 22:28:10 rune64 iwd[261]:         Permanent Address:
b8:27:eb:52:cc:d0
Jun 24 22:28:10 rune64 iwd[261]:         Bands: 2.4 GHz 5 GHz
Jun 24 22:28:10 rune64 iwd[261]:         Ciphers: CCMP TKIP BIP
Jun 24 22:28:10 rune64 iwd[261]:         Supported iftypes: ad-hoc station
ap p2p-client p2p-go p2p-device
Jun 24 22:28:10 rune64 iwd[261]: Wiphy phy0 will only use the default
interface
Jun 24 22:28:11 rune64 iwd[261]: hardware_rekey not supported
Jun 25 13:40:14 rune64 iwd[261]: Received Deauthentication event, reason:
2, from_ap: false
Jun 25 13:40:14 rune64 iwd[261]: Received error during CMD_TRIGGER_SCAN:
Resource temporarily unavailable (11)
Jun 25 13:40:15 rune64 systemd[1]: iwd.service: Main process exited,
code=3Ddumped, status=3D11/SEGV
Jun 25 13:40:15 rune64 systemd[1]: iwd.service: Failed with result
'core-dump'.
Jun 25 13:40:15 rune64 systemd[1]: iwd.service: Scheduled restart job,
restart counter is at 1.
Jun 25 13:40:15 rune64 systemd[1]: Stopped Wireless service.
Jun 25 13:40:15 rune64 systemd[1]: Starting Wireless service...
Jun 25 13:40:15 rune64 iwd[15388]: Wireless daemon version 1.7
Jun 25 13:40:15 rune64 iwd[15388]: Loaded configuration from
/etc/iwd/main.conf
Jun 25 13:40:15 rune64 systemd[1]: Started Wireless service.

--===============0084196986039126087==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+PGRpdj5UaGlzIGlzIG9uIGFuIFJwaSBCMysgcnVuaW50IGFhcmNoNjQu
IEkgaGF2ZSBub3RpY2VkIHRoYXQsIHBlcmlvZGljYWxseSBJIGdldCBkaXNjb25uZWN0ZWQgYW5k
IGl0IGRvZSBzbm90IHJlY29ubmVjdC4gSSBhbSB1c2luZyBjb25ubWFuIHRvIG1hbmFnZSB0aGUg
aXdkIGNvbm5lY3Rpb24uIFRoaXMgaXMgdGhlIGZpcnN0IHRpbWUgSSBoYXZlIHNlZW4gdGhlIGNy
YXNoIGluIHRoZSBsb2cuIEl0IGhhcyBiZWVuIGNyYXNoaW5nIGFuZCBub3QgcmVjb3ZlcmluZy4g
PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+SXQgZ2V0cyBhIERlYXV0aCBldmVudCAoSSYj
Mzk7dmUgc2VlbiB0aGlzIHF1aXRlIGEgYml0KSBhbmQgdXN1YWxseSwgaXQgd2lsbCBub3QgcmVj
b25uZWN0IHVudGlsIEkgcmVib290IGl0IGFuZCBteSByb3V0ZXIuIEhvdyBjYW4gSSBiZXN0IGRp
YWdub3NlIHRoaXM/PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5JdCBpcyBpd2QgMS43IGFuZCBj
b25ubWFuIDEuMzguIHBvdGVudGlhbGx5IHVzZWZ1bCBleGNlcnB0cyBmcm9tIG15IGpvdXJuYWw6
PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+SnVuIDE3IDIzOjI2OjU4IHJ1bmU2NCBrZXJu
ZWw6IEJvb3RpbmcgTGludXggb24gcGh5c2ljYWwgQ1BVIDB4MDAwMDAwMDAwMCBbMHg0MTBmZDAz
NF08YnI+SnVuIDE3IDIzOjI2OjU4IHJ1bmU2NCBrZXJuZWw6IExpbnV4IHZlcnNpb24gNS40LjQ0
LTEtQVJDSCAoYWxhcm1AYnVpbGRydW5lNjQpIChnY2MgdmVyc2lvbiA5LjMuMCAoR0NDKSkgIzEg
U01QIFBSRUVNUFQgTW9uIEp1biAyMiAxNToxMzo1MCBDRFQgMjAyMDxicj5KdW4gMTcgMjM6MjY6
NTggcnVuZTY0IGtlcm5lbDogTWFjaGluZSBtb2RlbDogUmFzcGJlcnJ5IFBpIDMgTW9kZWwgQiBQ
bHVzIFJldiAxLjM8L2Rpdj48ZGl2Pi4uLjwvZGl2PjxkaXY+SnVuIDE3IDIzOjI2OjU4IHJ1bmU2
NCBrZXJuZWw6IHJhc3BiZXJyeXBpLWZpcm13YXJlIHNvYzpmaXJtd2FyZTogQXR0YWNoZWQgdG8g
ZmlybXdhcmUgZnJvbSAyMDIwLTA2LTEwIDE3OjUyLCB2YXJpYW50IHN0YXJ0X2NkPGJyPkp1biAx
NyAyMzoyNjo1OCBydW5lNjQga2VybmVsOiByYXNwYmVycnlwaS1maXJtd2FyZSBzb2M6ZmlybXdh
cmU6IEZpcm13YXJlIGhhc2ggaXMgZTQ2YmJhMTYzOGNjYTI3MDhiMzFiOWRhZjQ2MzY3NzBlZjk4
MTczNTwvZGl2PjxkaXY+Li4uPC9kaXY+PGRpdj5KdW4gMTcgMjM6MjY6NTkgcnVuZTY0IGtlcm5l
bDogYnJjbWZtYWM6IEYxIHNpZ25hdHVyZSByZWFkIEAweDE4MDAwMDAwPTB4MTUyNjQzNDU8YnI+
SnVuIDE3IDIzOjI2OjU5IHJ1bmU2NCBrZXJuZWw6IGJyY21mbWFjOiBicmNtZl9md19hbGxvY19y
ZXF1ZXN0OiB1c2luZyBicmNtL2JyY21mbWFjNDM0NTUtc2RpbyBmb3IgY2hpcCBCQ000MzQ1LzY8
YnI+SnVuIDE3IDIzOjI2OjU5IHJ1bmU2NCBrZXJuZWw6IHVzYmNvcmU6IHJlZ2lzdGVyZWQgbmV3
IGludGVyZmFjZSBkcml2ZXIgYnJjbWZtYWM8L2Rpdj48ZGl2Pi4uLjwvZGl2PjxkaXY+SnVuIDE3
IDIzOjI3OjAwIHJ1bmU2NCBrZXJuZWw6IGJyY21mbWFjOiBicmNtZl9md19hbGxvY19yZXF1ZXN0
OiB1c2luZyBicmNtL2JyY21mbWFjNDM0NTUtc2RpbyBmb3IgY2hpcCBCQ000MzQ1LzY8YnI+SnVu
IDE3IDIzOjI3OjAwIHJ1bmU2NCBrZXJuZWw6IGJyY21mbWFjOiBicmNtZl9jX3ByZWluaXRfZGNt
ZHM6IEZpcm13YXJlOiBCQ000MzQ1LzYgd2wwOiBGZWIgMjcgMjAxOCAwMzoxNTozMiB2ZXJzaW9u
IDcuNDUuMTU0IChyNjg0MTA3IENZKSBGV0lEIDAxLTRmYmUwYjA0PGJyPjwvZGl2PjxkaXY+Li4u
PC9kaXY+PGRpdj5KdW4gMjQgMjI6Mjg6MTAgcnVuZTY0IGl3ZFsyNjFdOiBXaXJlbGVzcyBkYWVt
b24gdmVyc2lvbiAxLjc8YnI+SnVuIDI0IDIyOjI4OjEwIHJ1bmU2NCBpd2RbMjYxXTogTG9hZGVk
IGNvbmZpZ3VyYXRpb24gZnJvbSAvZXRjL2l3ZC9tYWluLmNvbmY8YnI+SnVuIDI0IDIyOjI4OjEw
IHJ1bmU2NCBzeXN0ZW1kWzFdOiBTdGFydGVkIFdpcmVsZXNzIHNlcnZpY2UuPGJyPkp1biAyNCAy
MjoyODoxMCBydW5lNjQgaXdkWzI2MV06IG5ldGNvbmZpZzogTmV0d29yayBjb25maWd1cmF0aW9u
IGlzIGRpc2FibGVkLjxicj5KdW4gMjQgMjI6Mjg6MTAgcnVuZTY0IGl3ZFsyNjFdOiBXaXBoeTog
MCwgTmFtZTogcGh5MDxicj5KdW4gMjQgMjI6Mjg6MTAgcnVuZTY0IGl3ZFsyNjFdOiDCoCDCoCDC
oCDCoCBQZXJtYW5lbnQgQWRkcmVzczogYjg6Mjc6ZWI6NTI6Y2M6ZDA8YnI+SnVuIDI0IDIyOjI4
OjEwIHJ1bmU2NCBpd2RbMjYxXTogwqAgwqAgwqAgwqAgQmFuZHM6IDIuNCBHSHogNSBHSHo8YnI+
SnVuIDI0IDIyOjI4OjEwIHJ1bmU2NCBpd2RbMjYxXTogwqAgwqAgwqAgwqAgQ2lwaGVyczogQ0NN
UCBUS0lQIEJJUDxicj5KdW4gMjQgMjI6Mjg6MTAgcnVuZTY0IGl3ZFsyNjFdOiDCoCDCoCDCoCDC
oCBTdXBwb3J0ZWQgaWZ0eXBlczogYWQtaG9jIHN0YXRpb24gYXAgcDJwLWNsaWVudCBwMnAtZ28g
cDJwLWRldmljZTxicj5KdW4gMjQgMjI6Mjg6MTAgcnVuZTY0IGl3ZFsyNjFdOiBXaXBoeSBwaHkw
IHdpbGwgb25seSB1c2UgdGhlIGRlZmF1bHQgaW50ZXJmYWNlPGJyPkp1biAyNCAyMjoyODoxMSBy
dW5lNjQgaXdkWzI2MV06IGhhcmR3YXJlX3Jla2V5IG5vdCBzdXBwb3J0ZWQ8YnI+PC9kaXY+PGRp
dj5KdW4gMjUgMTM6NDA6MTQgcnVuZTY0IGl3ZFsyNjFdOiBSZWNlaXZlZCBEZWF1dGhlbnRpY2F0
aW9uIGV2ZW50LCByZWFzb246IDIsIGZyb21fYXA6IGZhbHNlPC9kaXY+SnVuIDI1IDEzOjQwOjE0
IHJ1bmU2NCBpd2RbMjYxXTogUmVjZWl2ZWQgZXJyb3IgZHVyaW5nIENNRF9UUklHR0VSX1NDQU46
IFJlc291cmNlIHRlbXBvcmFyaWx5IHVuYXZhaWxhYmxlICgxMSk8YnI+SnVuIDI1IDEzOjQwOjE1
IHJ1bmU2NCBzeXN0ZW1kWzFdOiBpd2Quc2VydmljZTogTWFpbiBwcm9jZXNzIGV4aXRlZCwgY29k
ZT1kdW1wZWQsIHN0YXR1cz0xMS9TRUdWPGJyPkp1biAyNSAxMzo0MDoxNSBydW5lNjQgc3lzdGVt
ZFsxXTogaXdkLnNlcnZpY2U6IEZhaWxlZCB3aXRoIHJlc3VsdCAmIzM5O2NvcmUtZHVtcCYjMzk7
Ljxicj5KdW4gMjUgMTM6NDA6MTUgcnVuZTY0IHN5c3RlbWRbMV06IGl3ZC5zZXJ2aWNlOiBTY2hl
ZHVsZWQgcmVzdGFydCBqb2IsIHJlc3RhcnQgY291bnRlciBpcyBhdCAxLjxicj5KdW4gMjUgMTM6
NDA6MTUgcnVuZTY0IHN5c3RlbWRbMV06IFN0b3BwZWQgV2lyZWxlc3Mgc2VydmljZS48YnI+SnVu
IDI1IDEzOjQwOjE1IHJ1bmU2NCBzeXN0ZW1kWzFdOiBTdGFydGluZyBXaXJlbGVzcyBzZXJ2aWNl
Li4uPGJyPkp1biAyNSAxMzo0MDoxNSBydW5lNjQgaXdkWzE1Mzg4XTogV2lyZWxlc3MgZGFlbW9u
IHZlcnNpb24gMS43PGJyPkp1biAyNSAxMzo0MDoxNSBydW5lNjQgaXdkWzE1Mzg4XTogTG9hZGVk
IGNvbmZpZ3VyYXRpb24gZnJvbSAvZXRjL2l3ZC9tYWluLmNvbmY8YnI+SnVuIDI1IDEzOjQwOjE1
IHJ1bmU2NCBzeXN0ZW1kWzFdOiBTdGFydGVkIFdpcmVsZXNzIHNlcnZpY2UuPGJyPjwvZGl2Pgo=

--===============0084196986039126087==--

