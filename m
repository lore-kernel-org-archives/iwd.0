Content-Type: multipart/mixed; boundary="===============4464444465110604746=="
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Subject: Re: iwd core dump
Date: Fri, 26 Jun 2020 12:02:51 -0500
Message-ID: <CAG17S_NpWQ4nTnsj_6S1Ug5xttjgKHX47uqzKH1W4xvoxn_1SA@mail.gmail.com>
In-Reply-To: <8b6e62da-c44c-ed0e-a200-e70e494017c4@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4464444465110604746==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Denis,

I just loaded iwd 1.8. Will debug if it starts happening again.

Thanks,

Keith

On Fri, Jun 26, 2020 at 10:34 AM Denis Kenzior <denkenz@gmail.com> wrote:

> Hi Keith,
>
> On 6/25/20 5:34 PM, KeithG wrote:
> > This is on an Rpi B3+ runint aarch64. I have noticed that, periodically
> I get
> > disconnected and it doe snot reconnect. I am using connman to manage the
> iwd
> > connection. This is the first time I have seen the crash in the log. It
> has been
> > crashing and not recovering.
> >
> > It gets a Deauth event (I've seen this quite a bit) and usually, it will
> not
> > reconnect until I reboot it and my router. How can I best diagnose this?
> >
> > It is iwd 1.7 and connman 1.38. potentially useful excerpts from my
> journal:
> >
> > Jun 17 23:26:58 rune64 kernel: Booting Linux on physical CPU
> 0x0000000000
> > [0x410fd034]
> > Jun 17 23:26:58 rune64 kernel: Linux version 5.4.44-1-ARCH
> (alarm(a)buildrune64)
> > (gcc version 9.3.0 (GCC)) #1 SMP PREEMPT Mon Jun 22 15:13:50 CDT 2020
> > Jun 17 23:26:58 rune64 kernel: Machine model: Raspberry Pi 3 Model B
> Plus Rev 1.3
> > ...
> > Jun 17 23:26:58 rune64 kernel: raspberrypi-firmware soc:firmware:
> Attached to
> > firmware from 2020-06-10 17:52, variant start_cd
> > Jun 17 23:26:58 rune64 kernel: raspberrypi-firmware soc:firmware:
> Firmware hash
> > is e46bba1638cca2708b31b9daf4636770ef981735
> > ...
> > Jun 17 23:26:59 rune64 kernel: brcmfmac: F1 signature read
> @0x18000000=3D0x15264345
> > Jun 17 23:26:59 rune64 kernel: brcmfmac: brcmf_fw_alloc_request: using
> > brcm/brcmfmac43455-sdio for chip BCM4345/6
> > Jun 17 23:26:59 rune64 kernel: usbcore: registered new interface driver
> brcmfmac
> > ...
> > Jun 17 23:27:00 rune64 kernel: brcmfmac: brcmf_fw_alloc_request: using
> > brcm/brcmfmac43455-sdio for chip BCM4345/6
> > Jun 17 23:27:00 rune64 kernel: brcmfmac: brcmf_c_preinit_dcmds:
> Firmware:
> > BCM4345/6 wl0: Feb 27 2018 03:15:32 version 7.45.154 (r684107 CY) FWID
> 01-4fbe0b04
> > ...
> > Jun 24 22:28:10 rune64 iwd[261]: Wireless daemon version 1.7
> > Jun 24 22:28:10 rune64 iwd[261]: Loaded configuration from
> /etc/iwd/main.conf
> > Jun 24 22:28:10 rune64 systemd[1]: Started Wireless service.
> > Jun 24 22:28:10 rune64 iwd[261]: netconfig: Network configuration is
> disabled.
> > Jun 24 22:28:10 rune64 iwd[261]: Wiphy: 0, Name: phy0
> > Jun 24 22:28:10 rune64 iwd[261]:         Permanent Address:
> b8:27:eb:52:cc:d0
> > Jun 24 22:28:10 rune64 iwd[261]:         Bands: 2.4 GHz 5 GHz
> > Jun 24 22:28:10 rune64 iwd[261]:         Ciphers: CCMP TKIP BIP
> > Jun 24 22:28:10 rune64 iwd[261]:         Supported iftypes: ad-hoc
> station ap
> > p2p-client p2p-go p2p-device
> > Jun 24 22:28:10 rune64 iwd[261]: Wiphy phy0 will only use the default
> interface
> > Jun 24 22:28:11 rune64 iwd[261]: hardware_rekey not supported
> > Jun 25 13:40:14 rune64 iwd[261]: Received Deauthentication event,
> reason: 2,
> > from_ap: false
>
> Hmm, this implies the firmware tried to roam.  Does your network have
> multiple
> APs in the same SSID?
>
> Can you run iwmon and get a trace of this happening?  See
> https://iwd.wiki.kernel.org/debugging for details.
>
> > Jun 25 13:40:14 rune64 iwd[261]: Received error during CMD_TRIGGER_SCAN:
> > Resource temporarily unavailable (11)
>
> Hmm, I suspect we fixed this particular crash in iwd 1.8.  Can you try
> that?
>
> Regards,
> -Denis
>

--===============4464444465110604746==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+PGRpdj5EZW5pcyw8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkkganVz
dCBsb2FkZWQgaXdkIDEuOC4gV2lsbCBkZWJ1ZyBpZiBpdCBzdGFydHMgaGFwcGVuaW5nIGFnYWlu
LiA8YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5UaGFua3MsPC9kaXY+PGRpdj48YnI+PC9k
aXY+PGRpdj5LZWl0aDxicj48L2Rpdj48L2Rpdj48YnI+PGRpdiBjbGFzcz0iZ21haWxfcXVvdGUi
PjxkaXYgZGlyPSJsdHIiIGNsYXNzPSJnbWFpbF9hdHRyIj5PbiBGcmksIEp1biAyNiwgMjAyMCBh
dCAxMDozNCBBTSBEZW5pcyBLZW56aW9yICZsdDs8YSBocmVmPSJtYWlsdG86ZGVua2VuekBnbWFp
bC5jb20iPmRlbmtlbnpAZ21haWwuY29tPC9hPiZndDsgd3JvdGU6PGJyPjwvZGl2PjxibG9ja3F1
b3RlIGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9Im1hcmdpbjowcHggMHB4IDBweCAwLjhleDti
b3JkZXItbGVmdDoxcHggc29saWQgcmdiKDIwNCwyMDQsMjA0KTtwYWRkaW5nLWxlZnQ6MWV4Ij5I
aSBLZWl0aCw8YnI+Cjxicj4KT24gNi8yNS8yMCA1OjM0IFBNLCBLZWl0aEcgd3JvdGU6PGJyPgom
Z3Q7IFRoaXMgaXMgb24gYW4gUnBpIEIzKyBydW5pbnQgYWFyY2g2NC4gSSBoYXZlIG5vdGljZWQg
dGhhdCwgcGVyaW9kaWNhbGx5IEkgZ2V0IDxicj4KJmd0OyBkaXNjb25uZWN0ZWQgYW5kIGl0IGRv
ZSBzbm90IHJlY29ubmVjdC4gSSBhbSB1c2luZyBjb25ubWFuIHRvIG1hbmFnZSB0aGUgaXdkIDxi
cj4KJmd0OyBjb25uZWN0aW9uLiBUaGlzIGlzIHRoZSBmaXJzdCB0aW1lIEkgaGF2ZSBzZWVuIHRo
ZSBjcmFzaCBpbiB0aGUgbG9nLiBJdCBoYXMgYmVlbiA8YnI+CiZndDsgY3Jhc2hpbmcgYW5kIG5v
dCByZWNvdmVyaW5nLjxicj4KJmd0OyA8YnI+CiZndDsgSXQgZ2V0cyBhIERlYXV0aCBldmVudCAo
SSYjMzk7dmUgc2VlbiB0aGlzIHF1aXRlIGEgYml0KSBhbmQgdXN1YWxseSwgaXQgd2lsbCBub3Qg
PGJyPgomZ3Q7IHJlY29ubmVjdCB1bnRpbCBJIHJlYm9vdCBpdCBhbmQgbXkgcm91dGVyLiBIb3cg
Y2FuIEkgYmVzdCBkaWFnbm9zZSB0aGlzPzxicj4KJmd0OyA8YnI+CiZndDsgSXQgaXMgaXdkIDEu
NyBhbmQgY29ubm1hbiAxLjM4LiBwb3RlbnRpYWxseSB1c2VmdWwgZXhjZXJwdHMgZnJvbSBteSBq
b3VybmFsOjxicj4KJmd0OyA8YnI+CiZndDsgSnVuIDE3IDIzOjI2OjU4IHJ1bmU2NCBrZXJuZWw6
IEJvb3RpbmcgTGludXggb24gcGh5c2ljYWwgQ1BVIDB4MDAwMDAwMDAwMCA8YnI+CiZndDsgWzB4
NDEwZmQwMzRdPGJyPgomZ3Q7IEp1biAxNyAyMzoyNjo1OCBydW5lNjQga2VybmVsOiBMaW51eCB2
ZXJzaW9uIDUuNC40NC0xLUFSQ0ggKGFsYXJtQGJ1aWxkcnVuZTY0KSA8YnI+CiZndDsgKGdjYyB2
ZXJzaW9uIDkuMy4wIChHQ0MpKSAjMSBTTVAgUFJFRU1QVCBNb24gSnVuIDIyIDE1OjEzOjUwIENE
VCAyMDIwPGJyPgomZ3Q7IEp1biAxNyAyMzoyNjo1OCBydW5lNjQga2VybmVsOiBNYWNoaW5lIG1v
ZGVsOiBSYXNwYmVycnkgUGkgMyBNb2RlbCBCIFBsdXMgUmV2IDEuMzxicj4KJmd0OyAuLi48YnI+
CiZndDsgSnVuIDE3IDIzOjI2OjU4IHJ1bmU2NCBrZXJuZWw6IHJhc3BiZXJyeXBpLWZpcm13YXJl
IHNvYzpmaXJtd2FyZTogQXR0YWNoZWQgdG8gPGJyPgomZ3Q7IGZpcm13YXJlIGZyb20gMjAyMC0w
Ni0xMCAxNzo1MiwgdmFyaWFudCBzdGFydF9jZDxicj4KJmd0OyBKdW4gMTcgMjM6MjY6NTggcnVu
ZTY0IGtlcm5lbDogcmFzcGJlcnJ5cGktZmlybXdhcmUgc29jOmZpcm13YXJlOiBGaXJtd2FyZSBo
YXNoIDxicj4KJmd0OyBpcyBlNDZiYmExNjM4Y2NhMjcwOGIzMWI5ZGFmNDYzNjc3MGVmOTgxNzM1
PGJyPgomZ3Q7IC4uLjxicj4KJmd0OyBKdW4gMTcgMjM6MjY6NTkgcnVuZTY0IGtlcm5lbDogYnJj
bWZtYWM6IEYxIHNpZ25hdHVyZSByZWFkIEAweDE4MDAwMDAwPTB4MTUyNjQzNDU8YnI+CiZndDsg
SnVuIDE3IDIzOjI2OjU5IHJ1bmU2NCBrZXJuZWw6IGJyY21mbWFjOiBicmNtZl9md19hbGxvY19y
ZXF1ZXN0OiB1c2luZyA8YnI+CiZndDsgYnJjbS9icmNtZm1hYzQzNDU1LXNkaW8gZm9yIGNoaXAg
QkNNNDM0NS82PGJyPgomZ3Q7IEp1biAxNyAyMzoyNjo1OSBydW5lNjQga2VybmVsOiB1c2Jjb3Jl
OiByZWdpc3RlcmVkIG5ldyBpbnRlcmZhY2UgZHJpdmVyIGJyY21mbWFjPGJyPgomZ3Q7IC4uLjxi
cj4KJmd0OyBKdW4gMTcgMjM6Mjc6MDAgcnVuZTY0IGtlcm5lbDogYnJjbWZtYWM6IGJyY21mX2Z3
X2FsbG9jX3JlcXVlc3Q6IHVzaW5nIDxicj4KJmd0OyBicmNtL2JyY21mbWFjNDM0NTUtc2RpbyBm
b3IgY2hpcCBCQ000MzQ1LzY8YnI+CiZndDsgSnVuIDE3IDIzOjI3OjAwIHJ1bmU2NCBrZXJuZWw6
IGJyY21mbWFjOiBicmNtZl9jX3ByZWluaXRfZGNtZHM6IEZpcm13YXJlOiA8YnI+CiZndDsgQkNN
NDM0NS82IHdsMDogRmViIDI3IDIwMTggMDM6MTU6MzIgdmVyc2lvbiA3LjQ1LjE1NCAocjY4NDEw
NyBDWSkgRldJRCAwMS00ZmJlMGIwNDxicj4KJmd0OyAuLi48YnI+CiZndDsgSnVuIDI0IDIyOjI4
OjEwIHJ1bmU2NCBpd2RbMjYxXTogV2lyZWxlc3MgZGFlbW9uIHZlcnNpb24gMS43PGJyPgomZ3Q7
IEp1biAyNCAyMjoyODoxMCBydW5lNjQgaXdkWzI2MV06IExvYWRlZCBjb25maWd1cmF0aW9uIGZy
b20gL2V0Yy9pd2QvbWFpbi5jb25mPGJyPgomZ3Q7IEp1biAyNCAyMjoyODoxMCBydW5lNjQgc3lz
dGVtZFsxXTogU3RhcnRlZCBXaXJlbGVzcyBzZXJ2aWNlLjxicj4KJmd0OyBKdW4gMjQgMjI6Mjg6
MTAgcnVuZTY0IGl3ZFsyNjFdOiBuZXRjb25maWc6IE5ldHdvcmsgY29uZmlndXJhdGlvbiBpcyBk
aXNhYmxlZC48YnI+CiZndDsgSnVuIDI0IDIyOjI4OjEwIHJ1bmU2NCBpd2RbMjYxXTogV2lwaHk6
IDAsIE5hbWU6IHBoeTA8YnI+CiZndDsgSnVuIDI0IDIyOjI4OjEwIHJ1bmU2NCBpd2RbMjYxXTog
wqAgwqAgwqAgwqAgUGVybWFuZW50IEFkZHJlc3M6IGI4OjI3OmViOjUyOmNjOmQwPGJyPgomZ3Q7
IEp1biAyNCAyMjoyODoxMCBydW5lNjQgaXdkWzI2MV06IMKgIMKgIMKgIMKgIEJhbmRzOiAyLjQg
R0h6IDUgR0h6PGJyPgomZ3Q7IEp1biAyNCAyMjoyODoxMCBydW5lNjQgaXdkWzI2MV06IMKgIMKg
IMKgIMKgIENpcGhlcnM6IENDTVAgVEtJUCBCSVA8YnI+CiZndDsgSnVuIDI0IDIyOjI4OjEwIHJ1
bmU2NCBpd2RbMjYxXTogwqAgwqAgwqAgwqAgU3VwcG9ydGVkIGlmdHlwZXM6IGFkLWhvYyBzdGF0
aW9uIGFwIDxicj4KJmd0OyBwMnAtY2xpZW50IHAycC1nbyBwMnAtZGV2aWNlPGJyPgomZ3Q7IEp1
biAyNCAyMjoyODoxMCBydW5lNjQgaXdkWzI2MV06IFdpcGh5IHBoeTAgd2lsbCBvbmx5IHVzZSB0
aGUgZGVmYXVsdCBpbnRlcmZhY2U8YnI+CiZndDsgSnVuIDI0IDIyOjI4OjExIHJ1bmU2NCBpd2Rb
MjYxXTogaGFyZHdhcmVfcmVrZXkgbm90IHN1cHBvcnRlZDxicj4KJmd0OyBKdW4gMjUgMTM6NDA6
MTQgcnVuZTY0IGl3ZFsyNjFdOiBSZWNlaXZlZCBEZWF1dGhlbnRpY2F0aW9uIGV2ZW50LCByZWFz
b246IDIsIDxicj4KJmd0OyBmcm9tX2FwOiBmYWxzZTxicj4KPGJyPgpIbW0sIHRoaXMgaW1wbGll
cyB0aGUgZmlybXdhcmUgdHJpZWQgdG8gcm9hbS7CoCBEb2VzIHlvdXIgbmV0d29yayBoYXZlIG11
bHRpcGxlIDxicj4KQVBzIGluIHRoZSBzYW1lIFNTSUQ/PGJyPgo8YnI+CkNhbiB5b3UgcnVuIGl3
bW9uIGFuZCBnZXQgYSB0cmFjZSBvZiB0aGlzIGhhcHBlbmluZz/CoCBTZWUgPGJyPgo8YSBocmVm
PSJodHRwczovL2l3ZC53aWtpLmtlcm5lbC5vcmcvZGVidWdnaW5nIiByZWw9Im5vcmVmZXJyZXIi
IHRhcmdldD0iX2JsYW5rIj5odHRwczovL2l3ZC53aWtpLmtlcm5lbC5vcmcvZGVidWdnaW5nPC9h
PiBmb3IgZGV0YWlscy48YnI+Cjxicj4KJmd0OyBKdW4gMjUgMTM6NDA6MTQgcnVuZTY0IGl3ZFsy
NjFdOiBSZWNlaXZlZCBlcnJvciBkdXJpbmcgQ01EX1RSSUdHRVJfU0NBTjogPGJyPgomZ3Q7IFJl
c291cmNlIHRlbXBvcmFyaWx5IHVuYXZhaWxhYmxlICgxMSk8YnI+Cjxicj4KSG1tLCBJIHN1c3Bl
Y3Qgd2UgZml4ZWQgdGhpcyBwYXJ0aWN1bGFyIGNyYXNoIGluIGl3ZCAxLjguwqAgQ2FuIHlvdSB0
cnkgdGhhdD88YnI+Cjxicj4KUmVnYXJkcyw8YnI+Ci1EZW5pczxicj4KPC9ibG9ja3F1b3RlPjwv
ZGl2Pgo=

--===============4464444465110604746==--

