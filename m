Content-Type: multipart/mixed; boundary="===============3085941143925099111=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 11/11] auto-t: fix hwsim.py spoof frame
Date: Thu, 17 Dec 2020 11:36:11 -0800
Message-ID: <20201217193611.1177006-11-prestwoj@gmail.com>
In-Reply-To: <20201217193611.1177006-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============3085941143925099111==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

After the change creating radios from DBus the radio address pair
seems to come in mismatch order, meaning the radio address at
index zero may not always be what is expected. Instead of hardcoding
addresses[0] the address is checked in the entire addresses array.
---
 autotests/util/hwsim.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/autotests/util/hwsim.py b/autotests/util/hwsim.py
index 9aa14cbc..818bac1e 100755
--- a/autotests/util/hwsim.py
+++ b/autotests/util/hwsim.py
@@ -330,15 +330,15 @@ class Hwsim(iwd.AsyncOpAbstract):
             obj =3D objects[path]
             for interface in obj:
                 if interface =3D=3D HWSIM_INTERFACE_INTERFACE:
-                    if obj[interface]['Address'] =3D=3D radio.addresses[0]:
+                    if obj[interface]['Address'] in radio.addresses:
                         radio_path =3D path
                         break
 =

         iface =3D dbus.Interface(self._bus.get_object(HWSIM_SERVICE, radio=
_path),
                 HWSIM_INTERFACE_INTERFACE)
 =

-        iface.SendFrame(bytearray.fromhex(station.replace(':', '')),
-                        freq, -30, bytearray.fromhex(frame))
+        iface.SendFrame(dbus.ByteArray(bytearray.fromhex(station.replace('=
:', ''))),
+                        freq, -30, dbus.ByteArray(bytearray.fromhex(frame)=
))
 =

     def get_radio(self, name):
         for path in self.radios:
-- =

2.26.2

--===============3085941143925099111==--

