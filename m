Content-Type: multipart/mixed; boundary="===============4613497523159844035=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH 01/18] auto-t: hostapd.py: add 'bssid' property
Date: Thu, 12 Aug 2021 13:21:50 -0700
Message-ID: <20210812202207.737053-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============4613497523159844035==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This gets the APs BSSID, bypassing the need to use hwsim
for obtaining this address.
---
 autotests/util/hostapd.py | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/autotests/util/hostapd.py b/autotests/util/hostapd.py
index 6031b1dc..f75dbe6b 100644
--- a/autotests/util/hostapd.py
+++ b/autotests/util/hostapd.py
@@ -234,3 +234,13 @@ class HostapdCLI:
         '''
         cmd =3D self.cmdline + ['req_beacon', addr, request]
         ctx.start_process(cmd, wait=3DTrue)
+
+    @property
+    def bssid(self):
+        cmd =3D self.cmdline + ['status']
+        status =3D ctx.start_process(cmd, wait=3DTrue, need_out=3DTrue).out
+        status =3D status.split('\n')
+
+        bssid =3D [x for x in status if x.startswith('bssid')]
+        bssid =3D bssid[0].split('=3D')
+        return bssid[1]
-- =

2.31.1

--===============4613497523159844035==--

