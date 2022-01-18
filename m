Content-Type: multipart/mixed; boundary="===============8872278258780116442=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 10/12] auto-t: wpas.py: handle enrollee as responder
Date: Tue, 18 Jan 2022 13:25:10 -0800
Message-ID: <20220118212512.2017977-10-prestwoj@gmail.com>
In-Reply-To: 20220118212512.2017977-1-prestwoj@gmail.com

--===============8872278258780116442==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This adds support for wpa_supplicant to generate its own URI and
start presence announcements (DPP_CHIRP).
---
 autotests/util/wpas.py | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/autotests/util/wpas.py b/autotests/util/wpas.py
index c8e65179..995bdad1 100644
--- a/autotests/util/wpas.py
+++ b/autotests/util/wpas.py
@@ -239,10 +239,17 @@ class Wpas:
     def set(self, key, value, **kwargs):
         self._ctrl_request('SET ' + key + ' ' + value, **kwargs)
 =

-    def dpp_enrollee_start(self, uri=3DNone):
+    def dpp_enrollee_start(self, uri=3DNone, oper_and_channel=3DNone):
+        if not oper_and_channel:
+            oper_and_channel =3D '81/1'
+
         self._rx_data =3D []
-        self._ctrl_request('DPP_BOOTSTRAP_GEN type=3Dqrcode')
-        self.wait_for_result()
+        self._ctrl_request('DPP_BOOTSTRAP_GEN type=3Dqrcode chan=3D%s' % o=
per_and_channel)
+        self._dpp_qr_id =3D self.wait_for_result()
+        self._ctrl_request('DPP_BOOTSTRAP_GET_URI %s' % self._dpp_qr_id)
+        self._dpp_uri =3D self.wait_for_result()
+
+        print("DPP Enrollee QR: %s" % self._dpp_uri)
 =

         if uri:
             self._rx_data =3D []
@@ -250,6 +257,10 @@ class Wpas:
             self._dpp_qr_id =3D self.wait_for_result()
             self._rx_data =3D []
             self._ctrl_request('DPP_AUTH_INIT peer=3D%s role=3Denrollee' %=
 self._dpp_qr_id)
+        else:
+            self._ctrl_request('DPP_CHIRP own=3D%s iter=3D100' % self._dpp=
_qr_id)
+
+        return self._dpp_uri
 =

     def dpp_configurator_create(self, uri):
         self._rx_data =3D []
-- =

2.31.1

--===============8872278258780116442==--

