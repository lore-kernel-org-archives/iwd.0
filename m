Content-Type: multipart/mixed; boundary="===============2196857415836658035=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 5/6] auto-t: wpas.py: add DPP utilities
Date: Tue, 04 Jan 2022 10:18:56 -0800
Message-ID: <20220104181857.103331-5-prestwoj@gmail.com>
In-Reply-To: 20220104181857.103331-1-prestwoj@gmail.com

--===============2196857415836658035==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 autotests/util/wpas.py | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/autotests/util/wpas.py b/autotests/util/wpas.py
index b5b539f4..c26f116c 100644
--- a/autotests/util/wpas.py
+++ b/autotests/util/wpas.py
@@ -3,6 +3,7 @@ import os
 import socket
 from gi.repository import GLib
 from config import ctx
+import binascii
 =

 ctrl_count =3D 0
 =

@@ -249,6 +250,31 @@ class Wpas:
     def set(self, key, value, **kwargs):
         self._ctrl_request('SET ' + key + ' ' + value, **kwargs)
 =

+    def dpp_enrollee_start(self, uri=3DNone):
+        self._ctrl_request('DPP_BOOTSTRAP_GEN type=3Dqrcode')
+        self.wait_for_result()
+
+        if uri:
+            self._ctrl_request('DPP_QR_CODE ' + uri)
+            self._dpp_qr_id =3D self.wait_for_result()
+            self._ctrl_request('DPP_AUTH_INIT peer=3D%s role=3Denrollee' %=
 self._dpp_qr_id)
+
+    def dpp_configurator_create(self, uri):
+        self._ctrl_request('DPP_CONFIGURATOR_ADD')
+        self._dpp_conf_id =3D self.wait_for_result()
+        self._ctrl_request('DPP_QR_CODE ' + uri)
+        self._dpp_qr_id =3D self.wait_for_result()
+
+        print("DPP Configurator ID: %s. DPP QR ID: %s" % (self._dpp_conf_i=
d, self._dpp_qr_id))
+
+    def dpp_configurator_start(self, ssid, passphrase):
+        ssid =3D binascii.hexlify(ssid.encode()).decode()
+        passphrase =3D binascii.hexlify(passphrase.encode()).decode()
+
+        self._ctrl_request('DPP_AUTH_INIT peer=3D%s conf=3Dsta-psk ssid=3D=
%s pass=3D%s' % (self._dpp_qr_id, ssid, passphrase))
+        self.wait_for_event('DPP-AUTH-SUCCESS')
+        self.wait_for_event('DPP-CONF-SENT')
+
     # Probably needed: remove references to self so that the GC can call _=
_del__ automatically
     def clean_up(self):
         if self.io_watch is not None:
-- =

2.31.1

--===============2196857415836658035==--

