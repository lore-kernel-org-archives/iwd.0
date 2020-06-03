Content-Type: multipart/mixed; boundary="===============1332315011078943772=="
MIME-Version: 1.0
From: KeithG <ys3al35l@gmail.com>
Subject: Cannot get ap mode to work
Date: Wed, 03 Jun 2020 12:17:31 -0500
Message-ID: <CAG17S_NU=nmTMUf=z5ceSEZ4ow2Cw4kfHTZ9NBZ6zvXMynNksA@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============1332315011078943772==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

I cannot get AP mode to function on my RPIs. If I try to do it by these
commands:

~# iwctl adapter phy0 show
                                 Adapter: phy0
---------------------------------------------------------------------------=
-----
  Settable  Property         Value
---------------------------------------------------------------------------=
-----
            Name             phy0
         *  Powered          on
            Vendor           Broadcom Corp.
            Model            BCM43438 combo WLAN and Bluetooth Low Energy
(BLE)
            SupportedModes   ad-hoc station ap

~# iwctl device wlan0 show
                                 Device: wlan0
---------------------------------------------------------------------------=
-----
  Settable  Property            Value
---------------------------------------------------------------------------=
-----
            Name                wlan0
         *  Mode                ap
         *  Powered             on
            Address             b8:27:eb:52:cc:d0
            Adapter             phy0

~# iwctl ap wlan0 start "MyNet" "password"

On my Windows PC, I can select the SSID "MyNet" and attempt to connect but
every time, I get:
"Can't connect to this network"
From my android phone, I get a similar response: It tries to connect but
never negotiates a connection.

I have tried by running dnsmasq and then starting the iwd in AP mode (like
I do with hostapd), but still cannot connect.

Daniel on the connman list suggested I collect a log of the connection
attempt by running the commands suggested in the README:
https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/README
I tried before and got gibberish. I just did it again (by the book) and the
files are attached. This is on a RaspberryPi 3B+ running Arch Linux.

What is going wrong and how can I fix it? My goal is to ditch
hostapd/dnsmasq and use connman/iwd to allow the RPI to boot as an AP if it
does not have a 'known-network' that it can find.

Regards,

Keith

--===============1332315011078943772==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+SSBjYW5ub3QgZ2V0IEFQIG1vZGUgdG8gZnVuY3Rpb24gb24gbXkgUlBJ
cy4gSWYgSSB0cnkgdG8gZG8gaXQgYnkgdGhlc2UgY29tbWFuZHM6PGRpdj48YnI+fiMgaXdjdGwg
YWRhcHRlciBwaHkwIHNob3c8YnI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBBZGFwdGVyOiBwaHkwPGJyPi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPGJy
PsKgIFNldHRhYmxlIMKgUHJvcGVydHkgwqAgwqAgwqAgwqAgVmFsdWU8YnI+LS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS08YnI+wqAgwqAgwqAgwqAgwqAgwqAgTmFtZSDCoCDCoCDCoCDCoCDCoCDCoCBw
aHkwPGJyPsKgIMKgIMKgIMKgIMKgKiDCoFBvd2VyZWQgwqAgwqAgwqAgwqAgwqBvbjxicj7CoCDC
oCDCoCDCoCDCoCDCoCBWZW5kb3IgwqAgwqAgwqAgwqAgwqAgQnJvYWRjb20gQ29ycC48YnI+wqAg
wqAgwqAgwqAgwqAgwqAgTW9kZWwgwqAgwqAgwqAgwqAgwqAgwqBCQ000MzQzOCBjb21ibyBXTEFO
IGFuZCBCbHVldG9vdGggTG93IEVuZXJneSAoQkxFKTxicj7CoCDCoCDCoCDCoCDCoCDCoCBTdXBw
b3J0ZWRNb2RlcyDCoCBhZC1ob2Mgc3RhdGlvbiBhcDxicj48YnI+fiMgaXdjdGwgZGV2aWNlIHds
YW4wIHNob3c8YnI+wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBEZXZpY2U6IHdsYW4wPGJyPi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tPGJyPsKgIFNldHRh
YmxlIMKgUHJvcGVydHkgwqAgwqAgwqAgwqAgwqAgwqBWYWx1ZTxicj4tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLTxicj7CoCDCoCDCoCDCoCDCoCDCoCBOYW1lIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
d2xhbjA8YnI+wqAgwqAgwqAgwqAgwqAqIMKgTW9kZSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGFw
PGJyPsKgIMKgIMKgIMKgIMKgKiDCoFBvd2VyZWQgwqAgwqAgwqAgwqAgwqAgwqAgb248YnI+wqAg
wqAgwqAgwqAgwqAgwqAgQWRkcmVzcyDCoCDCoCDCoCDCoCDCoCDCoCBiODoyNzplYjo1MjpjYzpk
MDxicj7CoCDCoCDCoCDCoCDCoCDCoCBBZGFwdGVyIMKgIMKgIMKgIMKgIMKgIMKgIHBoeTA8L2Rp
dj48ZGl2Pjxicj48L2Rpdj48ZGl2Pgp+IyBpd2N0bCBhcCB3bGFuMCBzdGFydCAmcXVvdDtNeU5l
dCZxdW90OyAmcXVvdDtwYXNzd29yZCZxdW90OwoKPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5P
biBteSBXaW5kb3dzIFBDLCBJIGNhbiBzZWxlY3QgdGhlIFNTSUQgJnF1b3Q7TXlOZXQmcXVvdDsg
YW5kIGF0dGVtcHQgdG8gY29ubmVjdCBidXQgZXZlcnkgdGltZSwgSSBnZXQ6PC9kaXY+PGRpdj4m
cXVvdDtDYW4mIzM5O3QgY29ubmVjdCB0byB0aGlzIG5ldHdvcmsmcXVvdDs8L2Rpdj48ZGl2PkZy
b20gbXkgYW5kcm9pZCBwaG9uZSwgSSBnZXQgYSBzaW1pbGFyIHJlc3BvbnNlOiBJdCB0cmllcyB0
byBjb25uZWN0IGJ1dCBuZXZlciBuZWdvdGlhdGVzIGEgY29ubmVjdGlvbi4gPGJyPjwvZGl2Pjxk
aXY+PGJyPjwvZGl2PjxkaXY+SSBoYXZlIHRyaWVkIGJ5IHJ1bm5pbmcgZG5zbWFzcSBhbmQgdGhl
biBzdGFydGluZyB0aGUgaXdkIGluIEFQIG1vZGUgKGxpa2UgSSBkbyB3aXRoIGhvc3RhcGQpLCBi
dXQgc3RpbGwgY2Fubm90IGNvbm5lY3QuIDxicj48L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkRh
bmllbCBvbiB0aGUgY29ubm1hbiBsaXN0IHN1Z2dlc3RlZCBJIGNvbGxlY3QgYSBsb2cgb2YgdGhl
IGNvbm5lY3Rpb24gYXR0ZW1wdCBieSBydW5uaW5nIHRoZSBjb21tYW5kcyBzdWdnZXN0ZWQgaW4g
dGhlIFJFQURNRTo8L2Rpdj48ZGl2PjxhIGhyZWY9Imh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHVi
L3NjbS9uZXR3b3JrL3dpcmVsZXNzL2l3ZC5naXQvdHJlZS9SRUFETUUiPmh0dHBzOi8vZ2l0Lmtl
cm5lbC5vcmcvcHViL3NjbS9uZXR3b3JrL3dpcmVsZXNzL2l3ZC5naXQvdHJlZS9SRUFETUU8L2E+
PC9kaXY+PGRpdj5JIHRyaWVkIGJlZm9yZSBhbmQgZ290IGdpYmJlcmlzaC4gSSBqdXN0IGRpZCBp
dCBhZ2FpbiAoYnkgdGhlIGJvb2spIGFuZCB0aGUgZmlsZXMgYXJlIGF0dGFjaGVkLiBUaGlzIGlz
IG9uIGEgUmFzcGJlcnJ5UGkgM0IrIHJ1bm5pbmcgQXJjaCBMaW51eC48L2Rpdj48ZGl2Pjxicj48
L2Rpdj48ZGl2PldoYXQgaXMgZ29pbmcgd3JvbmcgYW5kIGhvdyBjYW4gSSBmaXggaXQ/IE15IGdv
YWwgaXMgdG8gZGl0Y2ggaG9zdGFwZC9kbnNtYXNxIGFuZCB1c2UgY29ubm1hbi9pd2QgdG8gYWxs
b3cgdGhlIFJQSSB0byBib290IGFzIGFuIEFQIGlmIGl0IGRvZXMgbm90IGhhdmUgYSAmIzM5O2tu
b3duLW5ldHdvcmsmIzM5OyB0aGF0IGl0IGNhbiBmaW5kLjwvZGl2PjxkaXY+PGJyPjwvZGl2Pjxk
aXY+UmVnYXJkcyw8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PktlaXRoPGJyPjwvZGl2PjwvZGl2
Pgo=

--===============1332315011078943772==
Content-Type: application/octet-stream
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="trace-file.pcap"

1MOyoQIABAAAAAAAAAAAAAAABAD9AAAA+9jXXjfaBgDEAAAAxAAAAAAEAzgAAAAAAAAAAAAAABC0
AAAAFwAAAAAAAAAAAAAAEwEAAAgAAwADAAAACgAGAGDyYq5w/gAACAAuAAoAAAAEABUAfgAqAAAF
TXlOZXQBCIKEi5YMEhgkIQIADyQyJAEoASwBMAE0ATgBPAFAAWQBaAFsAXABdAF4AXwBgAGEAYgB
jAGQAZUBmQGdAaEBpQEwFgEAAA+sBAEAAA+sBAEAAA+sAgAAAAAyBDBIYGxGBXIAAAAAfwoEAMiA
AUAAAAAAAAAA2ddeXesGAEQAAABEAAAAAAQDOAAAAAAAAAAAAAAAEDQAAAAXAAAAAAAAAAAAAAAU
AQAACAADAAMAAAAKAAYAYPJirnD+AAAIAC4AAAAAAAQAFQAA2ddeousGAEQAAABEAAAAAAQDOAAA
AAAAAAAAAAAAEDQAAAAXAAAAAAAAAAAAAAAUAQAACAADAAMAAAAKAAYAYPJirnD+AAAIAC4AAAAA
AAQAFQA=
--===============1332315011078943772==
Content-Type: application/octet-stream
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="trace-pae.pcap"

1MOyoQIABAAAAAAAAAAAAAAABABxAAAA
--===============1332315011078943772==--

