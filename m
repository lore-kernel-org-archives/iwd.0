Content-Type: multipart/mixed; boundary="===============8936922773988480558=="
MIME-Version: 1.0
From: James Prestwood <prestwoj@gmail.com>
Subject: [PATCH] auto-t: scan as many times as needed to find networks
Date: Wed, 18 Aug 2021 10:46:34 -0700
Message-ID: <20210818174634.267270-1-prestwoj@gmail.com>
List-Id: <iwd.lists.01.org>
To: iwd@lists.01.org

--===============8936922773988480558==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Certain autotests coupled with slower test machines can result in lost
beacons and "Network not found" errors. In attempt to help with this
the test can just rescan (30 seconds max) until the network is found.
---
 autotests/util/iwd.py | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/autotests/util/iwd.py b/autotests/util/iwd.py
index 54157b00..730659ac 100755
--- a/autotests/util/iwd.py
+++ b/autotests/util/iwd.py
@@ -489,16 +489,24 @@ class Device(IWDDBusAbstract):
            network wasn't found. If the network is not found an exception =
is
            raised, this removes the need to extra asserts in autotests.
         '''
-        ordered_networks =3D self.get_ordered_networks(scan_if_needed)
+        def wait_for_network(self, network, scan_if_needed):
+            networks =3D self.get_ordered_networks(scan_if_needed)
 =

-        if not ordered_networks:
-            raise Exception('Network %s not found' % network)
+            if not networks:
+                # No point in continuing if we aren't going to re-scan
+                if not scan_if_needed:
+                    raise Exception("Network %s not found" % network)
 =

-        for n in ordered_networks:
-            if n.name =3D=3D network:
-                return n
+                return False
 =

-        raise Exception('Network %s not found' % network)
+            for n in networks:
+                if n.name =3D=3D network:
+                    return n
+
+            return False
+
+        return ctx.non_block_wait(wait_for_network, 30, self, network, sca=
n_if_needed,
+                                    exception=3DException("Network %s not =
found" % network))
 =

     def wps_push_button(self):
         self._wps_manager.PushButton(dbus_interface=3DIWD_WSC_INTERFACE,
-- =

2.31.1

--===============8936922773988480558==--

