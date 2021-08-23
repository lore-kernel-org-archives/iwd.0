Content-Type: multipart/mixed; boundary="===============6790542473478791893=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 1/3] auto-t: hwsim.py: convert addresses to 42:* format
Date: Mon, 23 Aug 2021 11:32:19 -0700
Message-ID: <20210823183221.558154-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============6790542473478791893==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

mac80211_hwsim has a funny quirk with multiple addresses in
radios. Some operations require address index zero, some index
one. And these addresses (possibly a result of how test-runner
initializes radios) sometimes get mixed up. For example scan
results may show a BSS address as 02:00:00:00:00:00, while the
next test run shows 42:00:00:00:00:00.

Ultimately, sending out frames requires the first nibble of the
address to be 0x4 so to handle both variants of addresses described
above hwsim.py was updated to always bitwise OR the first byte
with 0x40.
---
 autotests/util/hwsim.py | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/autotests/util/hwsim.py b/autotests/util/hwsim.py
index 52543062..db106dcb 100755
--- a/autotests/util/hwsim.py
+++ b/autotests/util/hwsim.py
@@ -335,14 +335,26 @@ class Hwsim(iwd.AsyncOpAbstract):
     def object_manager(self):
         return self._object_manager_if
 =

+    @staticmethod
+    def _convert_address(address):
+        first =3D int(address[0:2], base=3D16)
+        first |=3D 0x40
+        first =3D format(first, 'x')
+
+        address =3D first + address[2:]
+
+        return address
+
     def spoof_disassociate(self, radio, freq, station):
         '''
             Send a spoofed disassociate frame to a station
         '''
+        dest =3D self._convert_address(radio.addresses[0].replace(':', ''))
+
         frame =3D 'a0 00 3a 01'
         frame +=3D station.replace(':', '')
-        frame +=3D radio.addresses[0].replace(':', '')
-        frame +=3D radio.addresses[0].replace(':', '')
+        frame +=3D dest
+        frame +=3D dest
         frame +=3D '30 01 07 00'
         self.spoof_frame(radio, freq, station, frame)
 =

-- =

2.31.1

--===============6790542473478791893==--

