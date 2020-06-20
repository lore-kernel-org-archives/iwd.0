Content-Type: multipart/mixed; boundary="===============5644666971761959990=="
MIME-Version: 1.0
From: Martin Tesar <martin.tesar@yourwifi.cz>
Subject: Fw: Failed to load trusted user certificate
Date: Sat, 20 Jun 2020 12:51:45 +0000
Message-ID: <
 <AM0PR06MB515545E35BEC93012AF782819F990@AM0PR06MB5155.eurprd06.prod.outlook.com>>
In-Reply-To: <AM0PR06MB5155FD700FFE88879BCEA64B9F990@AM0PR06MB5155.eurprd06.prod.outlook.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============5644666971761959990==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello,

it looks like the IWD is not able to load trusted user certificates.
Basically if the certificate is enclosed in

-----BEGIN TRUSTED CERTIFICATE-----
-----END TRUSTED CERTIFICATE-----

I'm always getting an error "Failed to load". Once the user cert is
converted using OpenSSL and is enclosed in

-----BEGIN CERTIFICATE-----
-----END CERTIFICATE-----

it can be loaded without any problem. But such a converted certificate
is not accepted by the RADIUS in my case.

Below is the network configuration file and related syslog output

[Security]
EAP-Method=3DTLS
EAP-Identity=3Dsomeuser
EAP-TLS-ClientCert=3D/usr/local/share/ca-certificates/user.crt
EAP-TLS-ClientKey=3D/usr/local/share/ca-certificates/key.crt
EAP-TLS-CACert=3D/usr/local/share/ca-certificates/root.crt

Jun  2 01:19:41 somehost systemd[1]: Starting Wireless service...
Jun  2 01:19:41 somehost iwd[767]: No Diffie-Hellman support found, WPS wil=
l not be available
Jun  2 01:19:41 somehost iwd[767]: The following options are missing in the=
 kernel:
Jun  2 01:19:41 somehost iwd[767]: #011CONFIG_KEY_DH_OPERATIONS
Jun  2 01:19:41 somehost iwd[767]: Wireless daemon version 1.7
Jun  2 01:19:41 somehost systemd[1]: Started Wireless service.
Jun  2 01:19:41 somehost iwd[767]: netconfig: Network configuration is disa=
bled.
Jun  2 01:19:41 somehost iwd[767]: Wiphy: 0, Name: phy0
Jun  2 01:19:41 somehost iwd[767]: #011Permanent Address: dc:a6:32:49:d4:66
Jun  2 01:19:41 somehost iwd[767]: #011Bands: 2.4 GHz 5 GHz
Jun  2 01:19:41 somehost iwd[767]: #011Ciphers: CCMP TKIP BIP
Jun  2 01:19:41 somehost iwd[767]: #011Supported iftypes: ad-hoc station ap=
 p2p-client p2p-go p2p-device
Jun  2 01:19:41 somehost iwd[767]: Wiphy phy0 will only use the default int=
erface
Jun  2 01:19:41 somehost kernel: [  169.433109] brcmfmac: brcmf_cfg80211_se=
t_power_mgmt: power save disabled
Jun  2 01:19:41 somehost iwd[767]: Failed to load /usr/local/share/ca-certi=
ficates/user.crt

Thanks!
Martin


-- System Information:
Debian Release: bullseye/sid
Architecture: armhf (armv7l)

Kernel: Linux 5.6.14-v7l+ (SMP w/4 CPU cores)
Kernel taint flags: TAINT_CRAP
Locale: LANG=3Den_GB.UTF-8, LC_CTYPE=3Den_GB.UTF-8 (charmap=3DUTF-8),
LANGUAGE=3Den_GB.UTF-8 (charmap=3DUTF-8)
Shell: /bin/sh linked to /bin/dash
Init: systemd (via /run/systemd/system)

Versions of packages iwd depends on:
ii  libc6         2.30-8+rpi1
ii  libreadline8  8.0-4

iwd recommends no packages.

iwd suggests no packages.

-- no debconf information


--===============5644666971761959990==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGh0bWw+CjxoZWFkPgo8bWV0YSBodHRwLWVxdWl2PSJDb250ZW50LVR5cGUiIGNvbnRlbnQ9InRl
eHQvaHRtbDsgY2hhcnNldD1pc28tODg1OS0yIj4KPHN0eWxlIHR5cGU9InRleHQvY3NzIiBzdHls
ZT0iZGlzcGxheTpub25lOyI+IFAge21hcmdpbi10b3A6MDttYXJnaW4tYm90dG9tOjA7fSA8L3N0
eWxlPgo8L2hlYWQ+Cjxib2R5IGRpcj0ibHRyIj4KPGRpdiBzdHlsZT0iZm9udC1mYW1pbHk6IENh
bGlicmksIEFyaWFsLCBIZWx2ZXRpY2EsIHNhbnMtc2VyaWY7IGZvbnQtc2l6ZTogMTJwdDsgY29s
b3I6IHJnYigwLCAwLCAwKTsiPgo8c3BhbiBzdHlsZT0iY29sb3I6IHJnYigwLCAwLCAwKTsgZm9u
dC1mYW1pbHk6IENhbGlicmksIEFyaWFsLCBIZWx2ZXRpY2EsIHNhbnMtc2VyaWY7IGZvbnQtc2l6
ZTogMTJwdDsiPkhlbGxvLDwvc3Bhbj48YnI+CjwvZGl2Pgo8ZGl2Pgo8ZGl2IGRpcj0ibHRyIj4K
PGRpdj4KPGRpdiBkaXI9Imx0ciI+CjxkaXYgc3R5bGU9ImZvbnQtZmFtaWx5OkNhbGlicmksQXJp
YWwsSGVsdmV0aWNhLHNhbnMtc2VyaWY7IGZvbnQtc2l6ZToxMnB0OyBjb2xvcjpyZ2IoMCwwLDAp
Ij4KPGRpdj48YnI+CjwvZGl2Pgo8ZGl2Pml0IGxvb2tzIGxpa2UgdGhlIElXRCBpcyBub3QgYWJs
ZSB0byBsb2FkIHRydXN0ZWQgdXNlciBjZXJ0aWZpY2F0ZXMuPGJyPgo8L2Rpdj4KPGRpdj5CYXNp
Y2FsbHkgaWYgdGhlIGNlcnRpZmljYXRlIGlzIGVuY2xvc2VkIGluPGJyPgo8L2Rpdj4KPGRpdj48
YnI+CjwvZGl2Pgo8ZGl2Pi0tLS0tQkVHSU4gVFJVU1RFRCBDRVJUSUZJQ0FURS0tLS0tPGJyPgo8
L2Rpdj4KPGRpdj4tLS0tLUVORCBUUlVTVEVEIENFUlRJRklDQVRFLS0tLS08YnI+CjwvZGl2Pgo8
ZGl2Pjxicj4KPC9kaXY+CjxkaXY+SSdtIGFsd2F5cyBnZXR0aW5nIGFuIGVycm9yICZxdW90O0Zh
aWxlZCB0byBsb2FkJnF1b3Q7LiBPbmNlIHRoZSB1c2VyIGNlcnQgaXM8YnI+CjwvZGl2Pgo8ZGl2
PmNvbnZlcnRlZCB1c2luZyBPcGVuU1NMIGFuZCBpcyBlbmNsb3NlZCBpbjxicj4KPC9kaXY+Cjxk
aXY+PGJyPgo8L2Rpdj4KPGRpdj4tLS0tLUJFR0lOIENFUlRJRklDQVRFLS0tLS08YnI+CjwvZGl2
Pgo8ZGl2Pi0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS08YnI+CjwvZGl2Pgo8ZGl2Pjxicj4KPC9k
aXY+CjxkaXY+aXQgY2FuIGJlIGxvYWRlZCB3aXRob3V0IGFueSBwcm9ibGVtLiBCdXQgc3VjaCBh
IGNvbnZlcnRlZCBjZXJ0aWZpY2F0ZTxicj4KPC9kaXY+CjxkaXY+aXMgbm90IGFjY2VwdGVkIGJ5
IHRoZSBSQURJVVMgaW4gbXkgY2FzZS48YnI+CjwvZGl2Pgo8ZGl2Pjxicj4KPC9kaXY+CjxkaXY+
QmVsb3cgaXMgdGhlIG5ldHdvcmsgY29uZmlndXJhdGlvbiBmaWxlIGFuZCByZWxhdGVkIHN5c2xv
ZyBvdXRwdXQ8YnI+CjwvZGl2Pgo8ZGl2Pjxicj4KPC9kaXY+CjxkaXY+W1NlY3VyaXR5XTxicj4K
PC9kaXY+CjxkaXY+RUFQLU1ldGhvZD1UTFM8YnI+CjwvZGl2Pgo8ZGl2PkVBUC1JZGVudGl0eT1z
b21ldXNlcjxicj4KPC9kaXY+CjxkaXY+RUFQLVRMUy1DbGllbnRDZXJ0PS91c3IvbG9jYWwvc2hh
cmUvY2EtY2VydGlmaWNhdGVzL3VzZXIuY3J0PGJyPgo8L2Rpdj4KPGRpdj5FQVAtVExTLUNsaWVu
dEtleT0vdXNyL2xvY2FsL3NoYXJlL2NhLWNlcnRpZmljYXRlcy9rZXkuY3J0PGJyPgo8L2Rpdj4K
PGRpdj5FQVAtVExTLUNBQ2VydD0vdXNyL2xvY2FsL3NoYXJlL2NhLWNlcnRpZmljYXRlcy9yb290
LmNydDxicj4KPC9kaXY+CjxkaXY+PGJyPgo8L2Rpdj4KPGRpdj5KdW4gJm5ic3A7MiAwMToxOTo0
MSBzb21laG9zdCBzeXN0ZW1kWzFdOiBTdGFydGluZyBXaXJlbGVzcyBzZXJ2aWNlLi4uPGJyPgo8
L2Rpdj4KPGRpdj5KdW4gJm5ic3A7MiAwMToxOTo0MSBzb21laG9zdCBpd2RbNzY3XTogTm8gRGlm
ZmllLUhlbGxtYW4gc3VwcG9ydCBmb3VuZCwgV1BTIHdpbGwgbm90IGJlIGF2YWlsYWJsZTwvZGl2
Pgo8ZGl2Pkp1biAmbmJzcDsyIDAxOjE5OjQxIHNvbWVob3N0IGl3ZFs3NjddOiBUaGUgZm9sbG93
aW5nIG9wdGlvbnMgYXJlIG1pc3NpbmcgaW4gdGhlIGtlcm5lbDo8L2Rpdj4KPGRpdj5KdW4gJm5i
c3A7MiAwMToxOTo0MSBzb21laG9zdCBpd2RbNzY3XTogIzAxMUNPTkZJR19LRVlfREhfT1BFUkFU
SU9OUzxicj4KPC9kaXY+CjxkaXY+SnVuICZuYnNwOzIgMDE6MTk6NDEgc29tZWhvc3QgaXdkWzc2
N106IFdpcmVsZXNzIGRhZW1vbiB2ZXJzaW9uIDEuNzxicj4KPC9kaXY+CjxkaXY+SnVuICZuYnNw
OzIgMDE6MTk6NDEgc29tZWhvc3Qgc3lzdGVtZFsxXTogU3RhcnRlZCBXaXJlbGVzcyBzZXJ2aWNl
Ljxicj4KPC9kaXY+CjxkaXY+SnVuICZuYnNwOzIgMDE6MTk6NDEgc29tZWhvc3QgaXdkWzc2N106
IG5ldGNvbmZpZzogTmV0d29yayBjb25maWd1cmF0aW9uIGlzIGRpc2FibGVkLjxicj4KPC9kaXY+
CjxkaXY+SnVuICZuYnNwOzIgMDE6MTk6NDEgc29tZWhvc3QgaXdkWzc2N106IFdpcGh5OiAwLCBO
YW1lOiBwaHkwPGJyPgo8L2Rpdj4KPGRpdj5KdW4gJm5ic3A7MiAwMToxOTo0MSBzb21laG9zdCBp
d2RbNzY3XTogIzAxMVBlcm1hbmVudCBBZGRyZXNzOiBkYzphNjozMjo0OTpkNDo2Njxicj4KPC9k
aXY+CjxkaXY+SnVuICZuYnNwOzIgMDE6MTk6NDEgc29tZWhvc3QgaXdkWzc2N106ICMwMTFCYW5k
czogMi40IEdIeiA1IEdIejxicj4KPC9kaXY+CjxkaXY+SnVuICZuYnNwOzIgMDE6MTk6NDEgc29t
ZWhvc3QgaXdkWzc2N106ICMwMTFDaXBoZXJzOiBDQ01QIFRLSVAgQklQPGJyPgo8L2Rpdj4KPGRp
dj5KdW4gJm5ic3A7MiAwMToxOTo0MSBzb21laG9zdCBpd2RbNzY3XTogIzAxMVN1cHBvcnRlZCBp
ZnR5cGVzOiBhZC1ob2Mgc3RhdGlvbiBhcCBwMnAtY2xpZW50IHAycC1nbyBwMnAtZGV2aWNlPC9k
aXY+CjxkaXY+SnVuICZuYnNwOzIgMDE6MTk6NDEgc29tZWhvc3QgaXdkWzc2N106IFdpcGh5IHBo
eTAgd2lsbCBvbmx5IHVzZSB0aGUgZGVmYXVsdCBpbnRlcmZhY2U8L2Rpdj4KPGRpdj5KdW4gJm5i
c3A7MiAwMToxOTo0MSBzb21laG9zdCBrZXJuZWw6IFsgJm5ic3A7MTY5LjQzMzEwOV0gYnJjbWZt
YWM6IGJyY21mX2NmZzgwMjExX3NldF9wb3dlcl9tZ210OiBwb3dlciBzYXZlIGRpc2FibGVkPC9k
aXY+CjxkaXY+SnVuICZuYnNwOzIgMDE6MTk6NDEgc29tZWhvc3QgaXdkWzc2N106IEZhaWxlZCB0
byBsb2FkIC91c3IvbG9jYWwvc2hhcmUvY2EtY2VydGlmaWNhdGVzL3VzZXIuY3J0PC9kaXY+Cjxk
aXY+PGJyPgo8L2Rpdj4KPGRpdj5UaGFua3MhPGJyPgo8L2Rpdj4KPGRpdj5NYXJ0aW48YnI+Cjwv
ZGl2Pgo8ZGl2Pjxicj4KPC9kaXY+CjxkaXY+PGJyPgo8L2Rpdj4KPGRpdj4tLSBTeXN0ZW0gSW5m
b3JtYXRpb246PGJyPgo8L2Rpdj4KPGRpdj5EZWJpYW4gUmVsZWFzZTogYnVsbHNleWUvc2lkPGJy
Pgo8L2Rpdj4KPGRpdj5BcmNoaXRlY3R1cmU6IGFybWhmIChhcm12N2wpPGJyPgo8L2Rpdj4KPGRp
dj48YnI+CjwvZGl2Pgo8ZGl2Pktlcm5lbDogTGludXggNS42LjE0LXY3bCYjNDM7IChTTVAgdy80
IENQVSBjb3Jlcyk8YnI+CjwvZGl2Pgo8ZGl2Pktlcm5lbCB0YWludCBmbGFnczogVEFJTlRfQ1JB
UDxicj4KPC9kaXY+CjxkaXY+TG9jYWxlOiBMQU5HPWVuX0dCLlVURi04LCBMQ19DVFlQRT1lbl9H
Qi5VVEYtOCAoY2hhcm1hcD1VVEYtOCksPGJyPgo8L2Rpdj4KPGRpdj5MQU5HVUFHRT1lbl9HQi5V
VEYtOCAoY2hhcm1hcD1VVEYtOCk8YnI+CjwvZGl2Pgo8ZGl2PlNoZWxsOiAvYmluL3NoIGxpbmtl
ZCB0byAvYmluL2Rhc2g8YnI+CjwvZGl2Pgo8ZGl2PkluaXQ6IHN5c3RlbWQgKHZpYSAvcnVuL3N5
c3RlbWQvc3lzdGVtKTxicj4KPC9kaXY+CjxkaXY+PGJyPgo8L2Rpdj4KPGRpdj5WZXJzaW9ucyBv
ZiBwYWNrYWdlcyBpd2QgZGVwZW5kcyBvbjo8YnI+CjwvZGl2Pgo8ZGl2PmlpICZuYnNwO2xpYmM2
ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAyLjMwLTgmIzQzO3JwaTE8YnI+CjwvZGl2Pgo8
ZGl2PmlpICZuYnNwO2xpYnJlYWRsaW5lOCAmbmJzcDs4LjAtNDxicj4KPC9kaXY+CjxkaXY+PGJy
Pgo8L2Rpdj4KPGRpdj5pd2QgcmVjb21tZW5kcyBubyBwYWNrYWdlcy48YnI+CjwvZGl2Pgo8ZGl2
Pjxicj4KPC9kaXY+CjxkaXY+aXdkIHN1Z2dlc3RzIG5vIHBhY2thZ2VzLjxicj4KPC9kaXY+Cjxk
aXY+PGJyPgo8L2Rpdj4KPGRpdj4tLSBubyBkZWJjb25mIGluZm9ybWF0aW9uPGJyPgo8L2Rpdj4K
PGRpdj48YnI+CjwvZGl2Pgo8L2Rpdj4KPC9kaXY+CjwvZGl2Pgo8L2Rpdj4KPC9kaXY+CjwvYm9k
eT4KPC9odG1sPgo=

--===============5644666971761959990==--

