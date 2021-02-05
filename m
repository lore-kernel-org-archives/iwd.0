Content-Type: multipart/mixed; boundary="===============0227517207552646089=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 2/3] auto-t: make spoof_frame more robust
Date: Fri, 05 Feb 2021 10:09:10 -0800
Message-ID: <20210205180911.320809-2-prestwoj@gmail.com>
In-Reply-To: <20210205180911.320809-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============0227517207552646089==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Sometimes scan results can come in with a MAC address which
should be in the first index of addrs[] (42:xx:xx:xx:xx:xx).
This causes a failure to lookup the radio path.

There was also a failure path added if the radio cannot be
found rather than rely on DBus to fail with a None path.

The arguments to SendFrame were also changed to use the
ByteArray DBus type rather than python's internal bytearray.
This shouldn't have any effect, but its more consistent with
how DBus arguments should be used.
---
 autotests/util/hwsim.py | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/autotests/util/hwsim.py b/autotests/util/hwsim.py
index 9aa14cbc..ad4bec1f 100755
--- a/autotests/util/hwsim.py
+++ b/autotests/util/hwsim.py
@@ -330,15 +330,19 @@ class Hwsim(iwd.AsyncOpAbstract):
             obj =3D objects[path]
             for interface in obj:
                 if interface =3D=3D HWSIM_INTERFACE_INTERFACE:
-                    if obj[interface]['Address'] =3D=3D radio.addresses[0]:
+                    if obj[interface]['Address'] =3D=3D radio.addresses[0]=
 or \
+                                    obj[interface]['Address'] =3D=3D radio=
.addresses[1]:
                         radio_path =3D path
                         break
 =

+        if not radio_path:
+            raise Exception("Could not find radio %s" % radio.path)
+
         iface =3D dbus.Interface(self._bus.get_object(HWSIM_SERVICE, radio=
_path),
                 HWSIM_INTERFACE_INTERFACE)
 =

-        iface.SendFrame(bytearray.fromhex(station.replace(':', '')),
-                        freq, -30, bytearray.fromhex(frame))
+        iface.SendFrame(dbus.ByteArray.fromhex(station.replace(':', '')),
+                        freq, -30, dbus.ByteArray.fromhex(frame))
 =

     def get_radio(self, name):
         for path in self.radios:
-- =

2.26.2

--===============0227517207552646089==--

