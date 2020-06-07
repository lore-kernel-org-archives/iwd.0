Content-Type: multipart/mixed; boundary="===============8593866120300797863=="
MIME-Version: 1.0
From: Daan De Meyer <daan.j.demeyer@gmail.com>
Subject: Race condition between iwd and systemd-udevd
Date: Sun, 07 Jun 2020 20:46:34 +0200
Message-ID: <CAO8sHcm=sgTvkyCWh1SD9PGUxB_L1cmEQS2sJTy6=PLKo3hNNw@mail.gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8593866120300797863==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

I've been having issues with systemd-udevd and iwd both trying to manage a
default wlan0 interface on boot which results in errors because iwd deletes
the default wlan0 interface while systemd-udevd is still busy with it.

Related systemd issue: https://github.com/systemd/systemd/issues/15691

Lennard Poettering suggests to wait with removing the wlan0 interface until
udev is done with it (which can be verified via the udev netlink interface).

I guess this would take some changes on iwd's side to check if udev is used
on the system and if so, wait until the relevant udev event before deleting
any default wlan0 interfaces. Would a patch implementing that be accepted?

Regards,

Daan De Meyer

--===============8593866120300797863==
Content-Type: text/html
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="attachment.htm"

PGRpdiBkaXI9Imx0ciI+PGRpdj5IaSw8L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkkmIzM5O3Zl
IGJlZW4gaGF2aW5nIGlzc3VlcyB3aXRoIHN5c3RlbWQtdWRldmQgYW5kIGl3ZCBib3RoIHRyeWlu
ZyB0byBtYW5hZ2UgYSBkZWZhdWx0IHdsYW4wIGludGVyZmFjZSBvbiBib290IHdoaWNoIHJlc3Vs
dHMgaW4gZXJyb3JzIGJlY2F1c2UgaXdkIGRlbGV0ZXMgdGhlIGRlZmF1bHQgd2xhbjAgaW50ZXJm
YWNlIHdoaWxlIHN5c3RlbWQtdWRldmQgaXMgc3RpbGwgYnVzeSB3aXRoIGl0Ljxicj48L2Rpdj48
ZGl2Pjxicj48L2Rpdj48ZGl2PlJlbGF0ZWQgc3lzdGVtZCBpc3N1ZTogPGEgaHJlZj0iaHR0cHM6
Ly9naXRodWIuY29tL3N5c3RlbWQvc3lzdGVtZC9pc3N1ZXMvMTU2OTEiPmh0dHBzOi8vZ2l0aHVi
LmNvbS9zeXN0ZW1kL3N5c3RlbWQvaXNzdWVzLzE1NjkxPC9hPjwvZGl2PjxkaXY+PGJyPjwvZGl2
PjxkaXY+TGVubmFyZCBQb2V0dGVyaW5nIHN1Z2dlc3RzIHRvIHdhaXQgd2l0aCByZW1vdmluZyB0
aGUgd2xhbjAgaW50ZXJmYWNlIHVudGlsIHVkZXYgaXMgZG9uZSB3aXRoIGl0ICh3aGljaCBjYW4g
YmUgdmVyaWZpZWQgdmlhIHRoZSB1ZGV2IG5ldGxpbmsgaW50ZXJmYWNlKS48L2Rpdj48ZGl2Pjxi
cj48L2Rpdj48ZGl2PkkgZ3Vlc3MgdGhpcyB3b3VsZCB0YWtlIHNvbWUgY2hhbmdlcyBvbiBpd2Qm
IzM5O3Mgc2lkZSB0byBjaGVjayBpZiB1ZGV2IGlzIHVzZWQgb24gdGhlIHN5c3RlbSBhbmQgaWYg
c28sIHdhaXQgdW50aWwgdGhlIHJlbGV2YW50IHVkZXYgZXZlbnQgYmVmb3JlIGRlbGV0aW5nIGFu
eSBkZWZhdWx0IHdsYW4wIGludGVyZmFjZXMuIFdvdWxkIGEgcGF0Y2ggaW1wbGVtZW50aW5nIHRo
YXQgYmUgYWNjZXB0ZWQ/PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+UmVnYXJkcyw8L2Rp
dj48ZGl2Pjxicj48L2Rpdj48ZGl2PkRhYW4gRGUgTWV5ZXI8YnI+PC9kaXY+PC9kaXY+Cg==

--===============8593866120300797863==--

