Content-Type: multipart/mixed; boundary="===============5225728487136654150=="
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Subject: Re: iwd not connecting on Raspberry Pi with Raspbian
Date: Sat, 29 Aug 2020 09:07:57 -0500
Message-ID: <CAG17S_NOvdFCKmyZSxhLCzNvS=yv9fCTNpnrzT4gLARY=rx+qg@mail.gmail.com>
In-Reply-To: <3765450.Iyh0gPlrZJ@mmm>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5225728487136654150==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Patrick,

I run iwd on RPi, but I am using Arch Linux. I've never tried it with
RaspiOS. Works pretty well, though I am having a re-connect issue that we
are trying to debug.

My guess is that you compiled the kernel to remove this message in the log:

Aug 23 22:52:24 rune64 iwd[235]: No Diffie-Hellman support found, WPS will
not be available
Aug 23 22:52:24 rune64 iwd[235]: The following options are missing in the
kernel:
Aug 23 22:52:24 rune64 iwd[235]:         CONFIG_KEY_DH_OPERATIONS

This is harmless and I have no problems connecting with this notification.
I think it means I cannot use WPS which I do not.

Are you trying to connect using the iwctl commands?

iwctl station wlan0 scan
iwctl station wlan0 get-networks
iwctl station wlan0 connect 'Network_Name"

It should return with

Type the network passphrase for "Network_Name" psk.
Passphrase: ********

or are you using connman to manage iwd?
Do you have an /etc/iwd/main.conf? If so, what is in it?

I assume you have enabled and started iwd.

Keith


On Sat, Aug 29, 2020 at 7:59 AM Patrick H=C3=A4cker <pat_h@web.de> wrote:

> Hello,
>
> I try to get iwd running on a Raspberry Pi using a Raspbian kernel
> (5.4.59).
> The needed kernel options should be added (https://github.com/raspberrypi/
> linux/issues/3547 <https://github.com/raspberrypi/linux/issues/3547>),
> wpa_supplicant works, I compiled a kernel adding
> CONFIG_KEY_DH_OPERATIONS (which was the only remaining complaint by iwd),
> upgraded to iwd 1.8 but had no success.
>
> Now I am running out of ideas what else to try. The (hopefully) relevant
> part
> of iwd running in debug mode for 2.4 GHz:
> > src/station.c:station_autoconnect_next() Considering autoconnecting to
> BSS
> >     '98:9b:cb:4b:b1:cc' with SSID: auenstein, freq: 2472, rank: 7090,
> >     strength:  -5600
> > src/station.c:station_enter_state() Old State: autoconnect_quick, new
> >     state: connecting
> > src/station.c:station_netdev_event() Associating
> > src/netdev.c:netdev_unicast_notify() Unicast notification 59
> > src/netdev.c:netdev_mlme_notify() MLME notification Connect(46)
> > src/netdev.c:netdev_connect_event()
> > src/netdev.c:netdev_link_notify() event 16 on ifindex 3
> > src/netdev.c:netdev_link_notify() event 16 on ifindex 3
> > src/netdev.c:netdev_link_notify() event 16 on ifindex 3
> > src/netdev.c:netdev_link_notify() event 16 on ifindex 3
> > src/wiphy.c:wiphy_reg_notify() Notification of command Reg Change(36)
> > src/wiphy.c:wiphy_update_reg_domain() New reg domain country code for
> >     (global) is DE
> > 4-Way handshake failed for ifindex: 3, reason: 15
> > src/station.c:station_connect_cb() 3, result: 3
> > src/station.c:station_disassociated() 3
> > src/station.c:station_enter_state() Old State: connecting, new state:
> >     disconnected
>
> And the same for 5.6 GHz with a different error:
> > src/station.c:station_autoconnect_next() Considering autoconnecting to
> BSS
> >     '98:9b:cb:4b:b1:cd' with SSID: auenstein5G, freq: 5600, rank: 4592,
> >     strength: -6500
> > src/station.c:station_enter_state() Old State:
> >     autoconnect_quick, new state: connecting
> > src/station.c:station_netdev_event() Associating
> > src/netdev.c:netdev_unicast_notify() Unicast notification 59
> > src/netdev.c:netdev_mlme_notify() MLME notification Connect(46)
> > src/netdev.c:netdev_connect_event()
> > src/netdev.c:netdev_link_notify() event 16 on ifindex 3
> > src/netdev.c:netdev_link_notify() event 16 on ifindex 3
> > src/netdev.c:netdev_link_notify() event 16 on ifindex 3
> > src/netdev.c:netdev_link_notify() event 16 on ifindex 3
> > src/wiphy.c:wiphy_reg_notify() Notification of command Reg Change(36)
> > src/wiphy.c:wiphy_update_reg_domain() New reg domain country code for
> >     (global) is DE
> > src/netdev.c:netdev_link_notify() event 16 on ifindex 3
> > src/netdev.c:netdev_mlme_notify() MLME notification Disconnect(48)
> > src/netdev.c:netdev_disconnect_event()
> > Received Deauthentication event, reason: 2, from_ap: false
> > src/station.c:station_disconnect_event() 3
> > src/station.c:station_disassociated() 3
> > src/station.c:station_enter_state() Old State: connecting, new state:
> > disconnected
>
> I could imagine, that there is still a kernel module missing, but this is
> just
> guessing. Any hints how to continue debugging?
>
> I still think that iwd would be a good match for the Raspberry Pi and
> ideally
> after this issue is fixed most Raspberry Pi user can switch to iwd if they
> like.
>
> Kind regards
> Patrick_______________________________________________
> iwd mailing list -- iwd(a)lists.01.org
> To unsubscribe send an email to iwd-leave(a)lists.01.org
>

--===============5225728487136654150==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+PGRpdj5QYXRyaWNrLDwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+SSBy
dW4gaXdkIG9uIFJQaSwgYnV0IEkgYW0gdXNpbmcgQXJjaCBMaW51eC4gSSYjMzk7dmUgbmV2ZXIg
dHJpZWQgaXQgd2l0aCBSYXNwaU9TLiBXb3JrcyBwcmV0dHkgd2VsbCwgdGhvdWdoIEkgYW0gaGF2
aW5nIGEgcmUtY29ubmVjdCBpc3N1ZSB0aGF0IHdlIGFyZSB0cnlpbmcgdG8gZGVidWcuIDxicj48
L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pk15IGd1ZXNzIGlzIHRoYXQgeW91IGNvbXBpbGVkIHRo
ZSBrZXJuZWwgdG8gcmVtb3ZlIHRoaXMgbWVzc2FnZSBpbiB0aGUgbG9nOjwvZGl2PjxkaXY+PGJy
PjwvZGl2PjxkaXY+QXVnIDIzIDIyOjUyOjI0IHJ1bmU2NCBpd2RbMjM1XTogTm8gRGlmZmllLUhl
bGxtYW4gc3VwcG9ydCBmb3VuZCwgV1BTIHdpbGwgbm90IGJlIGF2YWlsYWJsZTxicj5BdWcgMjMg
MjI6NTI6MjQgcnVuZTY0IGl3ZFsyMzVdOiBUaGUgZm9sbG93aW5nIG9wdGlvbnMgYXJlIG1pc3Np
bmcgaW4gdGhlIGtlcm5lbDo8YnI+QXVnIDIzIDIyOjUyOjI0IHJ1bmU2NCBpd2RbMjM1XTogwqAg
wqAgwqAgwqAgQ09ORklHX0tFWV9ESF9PUEVSQVRJT05TPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRp
dj5UaGlzIGlzIGhhcm1sZXNzIGFuZCBJIGhhdmUgbm8gcHJvYmxlbXMgY29ubmVjdGluZyB3aXRo
IHRoaXMgbm90aWZpY2F0aW9uLiBJIHRoaW5rIGl0IG1lYW5zIEkgY2Fubm90IHVzZSBXUFMgd2hp
Y2ggSSBkbyBub3QuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5BcmUgeW91IHRyeWluZyB0byBj
b25uZWN0IHVzaW5nIHRoZSBpd2N0bCBjb21tYW5kcz88L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2
Pml3Y3RsIHN0YXRpb24gd2xhbjAgc2NhbjwvZGl2PjxkaXY+aXdjdGwgc3RhdGlvbiB3bGFuMCBn
ZXQtbmV0d29ya3M8L2Rpdj48ZGl2Pml3Y3RsIHN0YXRpb24gd2xhbjAgY29ubmVjdCAmIzM5O05l
dHdvcmtfTmFtZSZxdW90OzwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+SXQgc2hvdWxkIHJldHVy
biB3aXRoPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj4gVHlwZSB0aGUgbmV0d29yayBwYXNzcGhy
YXNlIGZvciAmcXVvdDtOZXR3b3JrX05hbWUmcXVvdDsgcHNrLjxicj5QYXNzcGhyYXNlOiAqKioq
KioqKjwvZGl2PjxkaXY+PGJyPiA8L2Rpdj48ZGl2Pm9yIGFyZSB5b3UgdXNpbmcgY29ubm1hbiB0
byBtYW5hZ2UgaXdkPzwvZGl2PjxkaXY+RG8geW91IGhhdmUgYW4gL2V0Yy9pd2QvbWFpbi5jb25m
PyBJZiBzbywgd2hhdCBpcyBpbiBpdD88YnI+PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5JIGFz
c3VtZSB5b3UgaGF2ZSBlbmFibGVkIGFuZCBzdGFydGVkIGl3ZC48L2Rpdj48ZGl2Pjxicj48L2Rp
dj48ZGl2PktlaXRoPGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjwvZGl2Pjxicj48ZGl2IGNsYXNz
PSJnbWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPk9uIFNhdCwg
QXVnIDI5LCAyMDIwIGF0IDc6NTkgQU0gUGF0cmljayBIw6Rja2VyICZsdDs8YSBocmVmPSJtYWls
dG86cGF0X2hAd2ViLmRlIj5wYXRfaEB3ZWIuZGU8L2E+Jmd0OyB3cm90ZTo8YnI+PC9kaXY+PGJs
b2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0ibWFyZ2luOjBweCAwcHggMHB4IDAu
OGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIwNCwyMDQpO3BhZGRpbmctbGVmdDox
ZXgiPkhlbGxvLDxicj4KPGJyPgpJIHRyeSB0byBnZXQgaXdkIHJ1bm5pbmcgb24gYSBSYXNwYmVy
cnkgUGkgdXNpbmcgYSBSYXNwYmlhbiBrZXJuZWwgKDUuNC41OSkuIDxicj4KVGhlIG5lZWRlZCBr
ZXJuZWwgb3B0aW9ucyBzaG91bGQgYmUgYWRkZWQgKDxhIGhyZWY9Imh0dHBzOi8vZ2l0aHViLmNv
bS9yYXNwYmVycnlwaS9saW51eC9pc3N1ZXMvMzU0NyIgcmVsPSJub3JlZmVycmVyIiB0YXJnZXQ9
Il9ibGFuayI+aHR0cHM6Ly9naXRodWIuY29tL3Jhc3BiZXJyeXBpLzxicj4KbGludXgvaXNzdWVz
LzM1NDc8L2E+KSwgd3BhX3N1cHBsaWNhbnQgd29ya3MsIEkgY29tcGlsZWQgYSBrZXJuZWwgYWRk
aW5nIDxicj4KQ09ORklHX0tFWV9ESF9PUEVSQVRJT05TICh3aGljaCB3YXMgdGhlIG9ubHkgcmVt
YWluaW5nIGNvbXBsYWludCBieSBpd2QpLCA8YnI+CnVwZ3JhZGVkIHRvIGl3ZCAxLjggYnV0IGhh
ZCBubyBzdWNjZXNzLjxicj4KPGJyPgpOb3cgSSBhbSBydW5uaW5nIG91dCBvZiBpZGVhcyB3aGF0
IGVsc2UgdG8gdHJ5LiBUaGUgKGhvcGVmdWxseSkgcmVsZXZhbnQgcGFydCA8YnI+Cm9mIGl3ZCBy
dW5uaW5nIGluIGRlYnVnIG1vZGUgZm9yIDIuNCBHSHo6PGJyPgomZ3Q7IHNyYy9zdGF0aW9uLmM6
c3RhdGlvbl9hdXRvY29ubmVjdF9uZXh0KCkgQ29uc2lkZXJpbmcgYXV0b2Nvbm5lY3RpbmcgdG8g
QlNTPGJyPgomZ3Q7wqAgwqAgwqAmIzM5Ozk4OjliOmNiOjRiOmIxOmNjJiMzOTsgd2l0aCBTU0lE
OiBhdWVuc3RlaW4sIGZyZXE6IDI0NzIsIHJhbms6IDcwOTAsPGJyPgomZ3Q7wqAgwqAgwqBzdHJl
bmd0aDrCoCAtNTYwMDxicj4KJmd0OyBzcmMvc3RhdGlvbi5jOnN0YXRpb25fZW50ZXJfc3RhdGUo
KSBPbGQgU3RhdGU6IGF1dG9jb25uZWN0X3F1aWNrLCBuZXc8YnI+CiZndDvCoCDCoCDCoHN0YXRl
OiBjb25uZWN0aW5nPGJyPgomZ3Q7IHNyYy9zdGF0aW9uLmM6c3RhdGlvbl9uZXRkZXZfZXZlbnQo
KSBBc3NvY2lhdGluZzxicj4KJmd0OyBzcmMvbmV0ZGV2LmM6bmV0ZGV2X3VuaWNhc3Rfbm90aWZ5
KCkgVW5pY2FzdCBub3RpZmljYXRpb24gNTk8YnI+CiZndDsgc3JjL25ldGRldi5jOm5ldGRldl9t
bG1lX25vdGlmeSgpIE1MTUUgbm90aWZpY2F0aW9uIENvbm5lY3QoNDYpPGJyPgomZ3Q7IHNyYy9u
ZXRkZXYuYzpuZXRkZXZfY29ubmVjdF9ldmVudCgpPGJyPgomZ3Q7IHNyYy9uZXRkZXYuYzpuZXRk
ZXZfbGlua19ub3RpZnkoKSBldmVudCAxNiBvbiBpZmluZGV4IDM8YnI+CiZndDsgc3JjL25ldGRl
di5jOm5ldGRldl9saW5rX25vdGlmeSgpIGV2ZW50IDE2IG9uIGlmaW5kZXggMzxicj4KJmd0OyBz
cmMvbmV0ZGV2LmM6bmV0ZGV2X2xpbmtfbm90aWZ5KCkgZXZlbnQgMTYgb24gaWZpbmRleCAzPGJy
PgomZ3Q7IHNyYy9uZXRkZXYuYzpuZXRkZXZfbGlua19ub3RpZnkoKSBldmVudCAxNiBvbiBpZmlu
ZGV4IDM8YnI+CiZndDsgc3JjL3dpcGh5LmM6d2lwaHlfcmVnX25vdGlmeSgpIE5vdGlmaWNhdGlv
biBvZiBjb21tYW5kIFJlZyBDaGFuZ2UoMzYpPGJyPgomZ3Q7IHNyYy93aXBoeS5jOndpcGh5X3Vw
ZGF0ZV9yZWdfZG9tYWluKCkgTmV3IHJlZyBkb21haW4gY291bnRyeSBjb2RlIGZvcjxicj4KJmd0
O8KgIMKgIMKgKGdsb2JhbCkgaXMgREU8YnI+CiZndDsgNC1XYXkgaGFuZHNoYWtlIGZhaWxlZCBm
b3IgaWZpbmRleDogMywgcmVhc29uOiAxNTxicj4KJmd0OyBzcmMvc3RhdGlvbi5jOnN0YXRpb25f
Y29ubmVjdF9jYigpIDMsIHJlc3VsdDogMzxicj4KJmd0OyBzcmMvc3RhdGlvbi5jOnN0YXRpb25f
ZGlzYXNzb2NpYXRlZCgpIDM8YnI+CiZndDsgc3JjL3N0YXRpb24uYzpzdGF0aW9uX2VudGVyX3N0
YXRlKCkgT2xkIFN0YXRlOiBjb25uZWN0aW5nLCBuZXcgc3RhdGU6PGJyPgomZ3Q7wqAgwqAgwqBk
aXNjb25uZWN0ZWQgPGJyPgo8YnI+CkFuZCB0aGUgc2FtZSBmb3IgNS42IEdIeiB3aXRoIGEgZGlm
ZmVyZW50IGVycm9yOjxicj4KJmd0OyBzcmMvc3RhdGlvbi5jOnN0YXRpb25fYXV0b2Nvbm5lY3Rf
bmV4dCgpIENvbnNpZGVyaW5nIGF1dG9jb25uZWN0aW5nIHRvIEJTUzxicj4KJmd0O8KgIMKgIMKg
JiMzOTs5ODo5YjpjYjo0YjpiMTpjZCYjMzk7IHdpdGggU1NJRDogYXVlbnN0ZWluNUcsIGZyZXE6
IDU2MDAsIHJhbms6IDQ1OTIsPGJyPgomZ3Q7wqAgwqAgwqBzdHJlbmd0aDogLTY1MDA8YnI+CiZn
dDsgc3JjL3N0YXRpb24uYzpzdGF0aW9uX2VudGVyX3N0YXRlKCkgT2xkIFN0YXRlOjxicj4KJmd0
O8KgIMKgIMKgYXV0b2Nvbm5lY3RfcXVpY2ssIG5ldyBzdGF0ZTogY29ubmVjdGluZzxicj4KJmd0
OyBzcmMvc3RhdGlvbi5jOnN0YXRpb25fbmV0ZGV2X2V2ZW50KCkgQXNzb2NpYXRpbmc8YnI+CiZn
dDsgc3JjL25ldGRldi5jOm5ldGRldl91bmljYXN0X25vdGlmeSgpIFVuaWNhc3Qgbm90aWZpY2F0
aW9uIDU5PGJyPgomZ3Q7IHNyYy9uZXRkZXYuYzpuZXRkZXZfbWxtZV9ub3RpZnkoKSBNTE1FIG5v
dGlmaWNhdGlvbiBDb25uZWN0KDQ2KTxicj4KJmd0OyBzcmMvbmV0ZGV2LmM6bmV0ZGV2X2Nvbm5l
Y3RfZXZlbnQoKTxicj4KJmd0OyBzcmMvbmV0ZGV2LmM6bmV0ZGV2X2xpbmtfbm90aWZ5KCkgZXZl
bnQgMTYgb24gaWZpbmRleCAzPGJyPgomZ3Q7IHNyYy9uZXRkZXYuYzpuZXRkZXZfbGlua19ub3Rp
ZnkoKSBldmVudCAxNiBvbiBpZmluZGV4IDM8YnI+CiZndDsgc3JjL25ldGRldi5jOm5ldGRldl9s
aW5rX25vdGlmeSgpIGV2ZW50IDE2IG9uIGlmaW5kZXggMzxicj4KJmd0OyBzcmMvbmV0ZGV2LmM6
bmV0ZGV2X2xpbmtfbm90aWZ5KCkgZXZlbnQgMTYgb24gaWZpbmRleCAzPGJyPgomZ3Q7IHNyYy93
aXBoeS5jOndpcGh5X3JlZ19ub3RpZnkoKSBOb3RpZmljYXRpb24gb2YgY29tbWFuZCBSZWcgQ2hh
bmdlKDM2KTxicj4KJmd0OyBzcmMvd2lwaHkuYzp3aXBoeV91cGRhdGVfcmVnX2RvbWFpbigpIE5l
dyByZWcgZG9tYWluIGNvdW50cnkgY29kZSBmb3I8YnI+CiZndDvCoCDCoCDCoChnbG9iYWwpIGlz
IERFPGJyPgomZ3Q7IHNyYy9uZXRkZXYuYzpuZXRkZXZfbGlua19ub3RpZnkoKSBldmVudCAxNiBv
biBpZmluZGV4IDM8YnI+CiZndDsgc3JjL25ldGRldi5jOm5ldGRldl9tbG1lX25vdGlmeSgpIE1M
TUUgbm90aWZpY2F0aW9uIERpc2Nvbm5lY3QoNDgpPGJyPgomZ3Q7IHNyYy9uZXRkZXYuYzpuZXRk
ZXZfZGlzY29ubmVjdF9ldmVudCgpPGJyPgomZ3Q7IFJlY2VpdmVkIERlYXV0aGVudGljYXRpb24g
ZXZlbnQsIHJlYXNvbjogMiwgZnJvbV9hcDogZmFsc2U8YnI+CiZndDsgc3JjL3N0YXRpb24uYzpz
dGF0aW9uX2Rpc2Nvbm5lY3RfZXZlbnQoKSAzPGJyPgomZ3Q7IHNyYy9zdGF0aW9uLmM6c3RhdGlv
bl9kaXNhc3NvY2lhdGVkKCkgMzxicj4KJmd0OyBzcmMvc3RhdGlvbi5jOnN0YXRpb25fZW50ZXJf
c3RhdGUoKSBPbGQgU3RhdGU6IGNvbm5lY3RpbmcsIG5ldyBzdGF0ZTo8YnI+CiZndDsgZGlzY29u
bmVjdGVkIDxicj4KPGJyPgpJIGNvdWxkIGltYWdpbmUsIHRoYXQgdGhlcmUgaXMgc3RpbGwgYSBr
ZXJuZWwgbW9kdWxlIG1pc3NpbmcsIGJ1dCB0aGlzIGlzIGp1c3QgPGJyPgpndWVzc2luZy4gQW55
IGhpbnRzIGhvdyB0byBjb250aW51ZSBkZWJ1Z2dpbmc/PGJyPgo8YnI+Ckkgc3RpbGwgdGhpbmsg
dGhhdCBpd2Qgd291bGQgYmUgYSBnb29kIG1hdGNoIGZvciB0aGUgUmFzcGJlcnJ5IFBpIGFuZCBp
ZGVhbGx5IDxicj4KYWZ0ZXIgdGhpcyBpc3N1ZSBpcyBmaXhlZCBtb3N0IFJhc3BiZXJyeSBQaSB1
c2VyIGNhbiBzd2l0Y2ggdG8gaXdkIGlmIHRoZXkgPGJyPgpsaWtlLjxicj4KPGJyPgpLaW5kIHJl
Z2FyZHM8YnI+ClBhdHJpY2tfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXzxicj4KaXdkIG1haWxpbmcgbGlzdCAtLSA8YSBocmVmPSJtYWlsdG86aXdkQGxpc3Rz
LjAxLm9yZyIgdGFyZ2V0PSJfYmxhbmsiPml3ZEBsaXN0cy4wMS5vcmc8L2E+PGJyPgpUbyB1bnN1
YnNjcmliZSBzZW5kIGFuIGVtYWlsIHRvIDxhIGhyZWY9Im1haWx0bzppd2QtbGVhdmVAbGlzdHMu
MDEub3JnIiB0YXJnZXQ9Il9ibGFuayI+aXdkLWxlYXZlQGxpc3RzLjAxLm9yZzwvYT48YnI+Cjwv
YmxvY2txdW90ZT48L2Rpdj4K

--===============5225728487136654150==--

