Content-Type: multipart/mixed; boundary="===============3545382645570762546=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 08/10] auto-t: wpas.py: add freq argument to configurator_start
Date: Tue, 11 Jan 2022 16:55:56 -0800
Message-ID: <20220112005558.1158405-8-prestwoj@gmail.com>
In-Reply-To: 20220112005558.1158405-1-prestwoj@gmail.com

--===============3545382645570762546==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This forces the configurator to request a new channel during the
authentication protocol.
---
 autotests/util/wpas.py | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/autotests/util/wpas.py b/autotests/util/wpas.py
index 2e50eb58..f8ef3357 100644
--- a/autotests/util/wpas.py
+++ b/autotests/util/wpas.py
@@ -268,11 +268,17 @@ class Wpas:
 =

         print("DPP Configurator ID: %s. DPP QR ID: %s" % (self._dpp_conf_i=
d, self._dpp_qr_id))
 =

-    def dpp_configurator_start(self, ssid, passphrase):
+    def dpp_configurator_start(self, ssid, passphrase, freq=3DNone):
         ssid =3D binascii.hexlify(ssid.encode()).decode()
         passphrase =3D binascii.hexlify(passphrase.encode()).decode()
 =

-        self._ctrl_request('DPP_AUTH_INIT peer=3D%s conf=3Dsta-psk ssid=3D=
%s pass=3D%s' % (self._dpp_qr_id, ssid, passphrase))
+        cmd =3D 'DPP_AUTH_INIT peer=3D%s conf=3Dsta-psk ssid=3D%s pass=3D%=
s ' % (self._dpp_qr_id, ssid, passphrase)
+
+        if freq:
+            cmd +=3D 'neg_freq=3D%u ' % freq
+
+        self._rx_data =3D []
+        self._ctrl_request(cmd)
         self.wait_for_event('DPP-AUTH-SUCCESS')
         self.wait_for_event('DPP-CONF-SENT')
 =

-- =

2.31.1

--===============3545382645570762546==--

