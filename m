Content-Type: multipart/mixed; boundary="===============6041136192785910558=="
MIME-Version: 1.0
From: James Prestwood <prestwoj at gmail.com>
To: iwd at lists.01.org
Subject: [PATCH 4/7] auto-t: testutil: wait for operstate
Date: Wed, 30 Mar 2022 13:23:12 -0700
Message-ID: <20220330202315.1881335-4-prestwoj@gmail.com>
In-Reply-To: 20220330202315.1881335-1-prestwoj@gmail.com

--===============6041136192785910558==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Depending on timing the operstate may not be set even when IWD shows
as connected. Instead wait for the operstate to become set.
---
 autotests/util/testutil.py | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/autotests/util/testutil.py b/autotests/util/testutil.py
index 1fced6c4..01c42654 100644
--- a/autotests/util/testutil.py
+++ b/autotests/util/testutil.py
@@ -134,10 +134,7 @@ SIOCGIFADDR =3D 0x8915
 IFF_UP =3D 1 << 0
 IFF_RUNNING =3D 1 << 6
 =

-def test_iface_operstate(intf=3DNone):
-    if not intf:
-        intf =3D iwd.IWD.get_instance().list_devices()[0].name
-
+def _test_operstate(intf):
     sock =3D socket.socket(socket.PF_PACKET, socket.SOCK_RAW)
 =

     try:
@@ -146,10 +143,19 @@ def test_iface_operstate(intf=3DNone):
 =

         # IFF_LOWER_UP and IFF_DORMANT not returned by SIOCGIFFLAGS
         if flags & (IFF_UP | IFF_RUNNING) !=3D IFF_UP | IFF_RUNNING:
-            raise Exception(intf + ' operstate wrong')
+            return False
+
+        return True
     finally:
         sock.close()
 =

+def test_iface_operstate(intf=3DNone):
+    if not intf:
+        intf =3D iwd.IWD.get_instance().list_devices()[0].name
+
+    ctx.non_block_wait(_test_operstate, 10, intf,
+                        exception=3DException(intf + ' operstate wrong'))
+
 def test_ip_address_match(intf, ip):
     try:
         s =3D socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
-- =

2.34.1

--===============6041136192785910558==--

