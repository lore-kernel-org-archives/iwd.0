Content-Type: multipart/mixed; boundary="===============4338654533191019976=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 02/10] auto-t: wpas.py: read DPP event until expected result
Date: Tue, 11 Jan 2022 16:55:50 -0800
Message-ID: <20220112005558.1158405-2-prestwoj@gmail.com>
In-Reply-To: 20220112005558.1158405-1-prestwoj@gmail.com

--===============4338654533191019976==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Controlling wpa_supplicant/hostapd from a text based interface is
problematic in that there is no way of knowing if an event corresponds
to a request. In certain cases if wpa_s/hostapd is sending out multiple
events and we make a request, a random event may come back after the
request, but before the actual result.

To fix this, at least for this specific case, we can continue to read
from the socket until the result is numeric.
---
 autotests/util/wpas.py | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/autotests/util/wpas.py b/autotests/util/wpas.py
index 0caa947f..2e50eb58 100644
--- a/autotests/util/wpas.py
+++ b/autotests/util/wpas.py
@@ -242,19 +242,29 @@ class Wpas:
         self._ctrl_request('SET ' + key + ' ' + value, **kwargs)
 =

     def dpp_enrollee_start(self, uri=3DNone):
+        self._rx_data =3D []
         self._ctrl_request('DPP_BOOTSTRAP_GEN type=3Dqrcode')
         self.wait_for_result()
 =

         if uri:
+            self._rx_data =3D []
             self._ctrl_request('DPP_QR_CODE ' + uri)
             self._dpp_qr_id =3D self.wait_for_result()
+            self._rx_data =3D []
             self._ctrl_request('DPP_AUTH_INIT peer=3D%s role=3Denrollee' %=
 self._dpp_qr_id)
 =

     def dpp_configurator_create(self, uri):
+        self._rx_data =3D []
         self._ctrl_request('DPP_CONFIGURATOR_ADD')
         self._dpp_conf_id =3D self.wait_for_result()
+        while not self._dpp_conf_id.isnumeric():
+            self._dpp_conf_id =3D self.wait_for_result()
+
+        self._rx_data =3D []
         self._ctrl_request('DPP_QR_CODE ' + uri)
         self._dpp_qr_id =3D self.wait_for_result()
+        while not self._dpp_conf_id.isnumeric():
+            self._dpp_qr_id =3D self.wait_for_result()
 =

         print("DPP Configurator ID: %s. DPP QR ID: %s" % (self._dpp_conf_i=
d, self._dpp_qr_id))
 =

-- =

2.31.1

--===============4338654533191019976==--

